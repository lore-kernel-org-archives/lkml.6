Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4941C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9219621902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="KJPSI94h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbfBROEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:04:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43485 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389801AbfBROD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so9950773ede.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TMKsmtSeB2s1AaZbZadZjj3xF8b5OyVicGrn8cs6Cxc=;
        b=KJPSI94h/3tr09gSDgWJ5ok7TSJC7JE/SFp+CPCPi5fV/xhzlIP8m+1T5aj3kNAVCS
         xawDKsAC8POcScc1qfEU3Mx7JR/0TIz2paMShO/Y2zlRdoxPpLXQcVNXOi1BkhNbvT5t
         k0Dsnts9zdDl5ya7+AE5PYVl1eet6ZUddv22gxrkx+FfPCHE1QFt1rqHB425oMLtX2dH
         DLj9oeRh/NaIiuETNkVr+lgZUDEJeC/mlCLreb/nV4Sgwr66LdO2XTOmd/gnnQ92GugB
         s6PgCWxnsmxMFnaVMIB24Cm2z6lH0e8xo+pB9gUvDoZQ5IXH9k28jMdD5ZInypUxMlVn
         vJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TMKsmtSeB2s1AaZbZadZjj3xF8b5OyVicGrn8cs6Cxc=;
        b=Ll5L/j+AIBsOoKObA+czcc72lsDD3E0+eG8D3FLFzTrqME/pLADqqf3PHGKn0KJnT0
         JcY3IU5Lc2Puub6/ssiP5Chv/1wngbbwjXOWT+/iOlhJnsjGL2paQEvwwgXFq9VARi0J
         UKn9xRfECeU/TV+bNITUSHCIx05K+A5HaV3tDOfwUGC5AZfVqtRGWns7AYxTaoU6bMPX
         CUE+rlnGvYr/rTvMDtpLLYL0FBBK2b1Oq7A97Sqin2C+YQXagGKrQD82Sripu38N+Gmt
         ka+EnpVD81zMTsygMrcW8OOXkT3qFTneleHVAPwBXJIiR+D0CvBSJ8Th4W2ALJM/jlOI
         P/SQ==
X-Gm-Message-State: AHQUAuZJk0ripgL9l+OnuhDyHJ+d7xoOa1Ar1PP2fmH5PTf5hCS2uhCG
        jYofQG0L7iMYqJ78sdhwcOVXvg==
X-Google-Smtp-Source: AHgI3IZWqJlESiACGZSBuFtcSlgUTXzB5UwYLjy0fJjTMr4Yq/bz8Bc0PoTINj2B3ihTtaQ8an9+iQ==
X-Received: by 2002:a50:fc12:: with SMTP id i18mr19300418edr.149.1550498635286;
        Mon, 18 Feb 2019 06:03:55 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:54 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 7/8] dt-bindings: iio/counter: ftm-quaddec: add poll-interval parameter
Date:   Mon, 18 Feb 2019 15:03:20 +0100
Message-Id: <20190218140321.19166-7-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New optional parameter supported by updated driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../devicetree/bindings/iio/counter/ftm-quaddec.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
index 4d18cd722074..60554e6c4367 100644
--- a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -6,8 +6,14 @@ Required properties:
 - compatible:		Must be "fsl,ftm-quaddec".
 - reg:			Must be set to the memory region of the flextimer.
 
-Optional property:
+Optional properties:
 - big-endian:		Access the device registers in big-endian mode.
+- poll-interval		Poll interval time in milliseconds for detecting
+			the under/overflow of the counter. Default value
+			is 100.
+			A value of 0 disables polling. This value can also
+			be set at runtime, but not to less than this initial
+			value (except 0 for disabling).
 
 Example:
 		counter0: counter@29d0000 {
-- 
2.17.1

