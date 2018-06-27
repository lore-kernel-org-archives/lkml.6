Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FB3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923D326899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YCvQutA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923D326899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeF0Hjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:39:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40138 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbeF0Hjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:39:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so4309915wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXtqsHhITjNwa9rI9Bpj3HzsftH5uPu7ofohuvSLUF0=;
        b=YCvQutA5FSg/1lgh8zGylYlbnf0xE9O5flZn0hmFJponXdPsjTBIAEoRRafo9OdBk3
         CzAkKxrz8U17NheJH1PLbph+bWwiJ1w4pVjNcsXRG9IvQgVc1WhWpOYSr0Q8VkWyaNV3
         JVsjZAiikmjWfwlA2LQ3fV+0cboSICGj022kBFCD9EuVd/laFeof4//g3Kkk1BK8yiVu
         UbzoGlR/wutnYqiLcJCIUcugs7gE7X8S7B9Tc8HWu7PJLtZTPfi/jS2X9I5WIK3TlSAj
         SaeuxZpAYfP64xaM0d8axgNSoqwemEwiMU0Wb+kc06mVvytbWEb2eTiVGqxwSl4ut+Mg
         a77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXtqsHhITjNwa9rI9Bpj3HzsftH5uPu7ofohuvSLUF0=;
        b=raY8dAN2rWLv9BIJkJzDzjhhTlHoRzGpfHXXQ/zUkODep9zJpIfWiXSEYHf1HprsdT
         bvDjg7Asn9s6DRFSI/AV+nqtWIaDnnm6ktHwje6w7FaTvBg6gxquehRiuHffhWIDPlez
         /SHHCEBUq1Ap/T7t+gjHNTFlrdBFWej4zAp1FIklRiN+oMB0PybG53CqB+SVGliG+pjU
         5FJ3y4RkT+TWTGAZHCiwoyYcwv6uBUBVWaiXUA4sZ86BchmssRpHV9EcuM6JIPiDXkmX
         a286AI+QcC2sJGtImNxlXuHcwuOWeFvhol+8oP+Jl452KpIxHQr6ox8o8Sk/RandreZD
         mt6A==
X-Gm-Message-State: APt69E25WvSwCKkZnjcFPjSRv3/N/OJBqtTv/Kaq55Z9JGSU+REEtDy3
        Z5Rh/rR0GnvmkGIqqHacRtifuQ==
X-Google-Smtp-Source: AAOMgpd6vGkCqwwyddjw67ItYX2yD2N9VepyDDd7Wa0GDtzmiLDGALqypM6PL1QlW7PMc+nFDGAd0g==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr4009249wmd.133.1530085183413;
        Wed, 27 Jun 2018 00:39:43 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m58-v6sm5852169wrf.61.2018.06.27.00.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 00:39:42 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 1/2] ASoC: tas571x: add tas5707 compatible
Date:   Wed, 27 Jun 2018 09:39:36 +0200
Message-Id: <20180627073937.29912-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180627073937.29912-1-jbrunet@baylibre.com>
References: <20180627073937.29912-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tas5707 to the available compatibles of the tas571x driver

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/tas571x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
index b4959f10b74b..7c8fd37c2f9e 100644
--- a/Documentation/devicetree/bindings/sound/tas571x.txt
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -7,6 +7,7 @@ powerdown (optional).
 Required properties:
 
 - compatible: should be one of the following:
+  - "ti,tas5707"
   - "ti,tas5711",
   - "ti,tas5717",
   - "ti,tas5719",
-- 
2.14.4

