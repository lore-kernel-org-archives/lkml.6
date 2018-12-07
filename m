Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D75C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7872E20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMzuIcZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7872E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeLGTMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:12:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38380 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeLGTL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:11:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so4466508lja.5;
        Fri, 07 Dec 2018 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2x5BRD7D0OPE9JeIh4cIErJAv6rfykzoqrwzqsJVYI=;
        b=UMzuIcZe7mTZw0Ou8g5w5fRJxwWU+RMMNT0TDXCHpZsj5rFme3BqLltsNGU0Pky18A
         Iuryxn4DGVtfe+oHVSSZdyw2lq17D78s/AZhZHZi7L+Nbzr+ogLkuZ6F9C7lV/+V5eHX
         U8MMpS9RYmre81XKtFsji0sdWV12MBaNuIa528SBoYb8wtz5/aTcLt7K3gcCW+xt6jtV
         F7HIVkiIvTxRWI0pufOJUs1NYKoQGC2jHEmACi4iIfAg8mU+CbK/LxcVQOdv3SpvmBdA
         woxfhwwF5Af2vHN4XrrtP7lKT0yJOgWbNzVDnCwv/jgU3N3D9kkG0qMLfQmRgCCiBHfO
         ZO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2x5BRD7D0OPE9JeIh4cIErJAv6rfykzoqrwzqsJVYI=;
        b=A9ZszUIKsJQIqStwGPMbDeuQek8yzJmItzqYjl9bhxzJh+rTQF3VDXc5Q2Ok8TaNTD
         BZpweq4ie2aF7NVmlDZP5GeKW0BFbEtJ39kqo4wovfhbOMVtoltKyXV7jSkPyVE5i7XD
         70N+aMTWAf4i5o/Ut3jAMVDMPHXmA0nMWI1oqMWmnpVD9khz8s0OIVdTI16wxzfiBEAd
         BTNppgsN7XVQbIGgC8z++0FM4bGEf57PhObC3oiR7ThBcfvWEWxMfUS6hMdjQAoC2e2d
         iYsy12Pw8hQuzZqpff0DdaICwOu7vE7APMAc0np2vKU+rb1emXcnVrFCFUQXZnN5zlla
         PS7w==
X-Gm-Message-State: AA+aEWY158w1WUYMZc+DtVGdibhhtOLGozxeP/yGGidfmKqhQ8Nl5/R+
        nbDyeRA3Z5zspz60ONcMkRs=
X-Google-Smtp-Source: AFSGD/Uwhu9dmo2o6pcdMi52WE4LA4EXixzLK2K9odxFN1ZMjWB57nNPdaIOl/G02+0IfFuJOKdhMw==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr2275086ljj.18.1544209914351;
        Fri, 07 Dec 2018 11:11:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 11:11:53 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        kgene@kernel.org, krzk@kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, broonie@kernel.org,
        arnaud.pouliquen@st.com, baolin.wang@linaro.org,
        smohanad@codeaurora.org, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
        geert@linux-m68k.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant
Date:   Fri,  7 Dec 2018 20:11:36 +0100
Message-Id: <20181207191136.5464-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add information about new compatible for S5PV210

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.txt        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
index 6c49db7f8ad2..a10c1f89037d 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
@@ -11,7 +11,7 @@ New driver handles the following
 
 Required properties:
 - compatible:		Must be "samsung,exynos-adc-v1"
-				for exynos4412/5250 and s5pv210 controllers.
+				for exynos4412/5250 controllers.
 			Must be "samsung,exynos-adc-v2" for
 				future controllers.
 			Must be "samsung,exynos3250-adc" for
@@ -28,6 +28,8 @@ Required properties:
 				the ADC in s3c2443 and compatibles
 			Must be "samsung,s3c6410-adc" for
 				the ADC in s3c6410 and compatibles
+			Must be "samsung,s5pv210-adc" for
+				the ADC in s5pv210 and compatibles
 - reg:			List of ADC register address range
 			- The base address and range of ADC register
 			- The base address and range of ADC_PHY register (every
-- 
2.17.1

