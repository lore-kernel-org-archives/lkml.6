Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12B620856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os75tXHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeL1QSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:18:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45930 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbeL1QSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:18:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so14830918lfa.12;
        Fri, 28 Dec 2018 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWKmTFS5ZShhZDX8uM7xr7EH6AMOt2sQtD7cbsV9khY=;
        b=Os75tXHLQ5Woz/aXfzxThmOiOs4nVjsc6VY+x1tXvnexcMuzCINJ/1pUslGGI4kDj0
         gy0+CS6BzZfwzQ4zW1FJPdu+W97jxanL5OINhESM5ys243LvLfv6OrXl9bkDYZ6pofPq
         P1ZmHwHLn4Nv742qOKlz/kjCL1BlGgTnI7ixV6siXwD74dmnaL1yTSCQBv5bPZTntTJK
         JD04Yl5+jGLC40naq1DQLFXlEEar1s+q6XiAbnDkmexg6WamP+wzvK0NIb0xCTLAEKaL
         8B3Yyd1CWkZ8MJREGyYq8i94tvpJCPqRx7YrFQSdlMQR7WYbE7nb328iUwpcQ/D5XcMS
         nhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWKmTFS5ZShhZDX8uM7xr7EH6AMOt2sQtD7cbsV9khY=;
        b=qPFmSwO04/TmCM5G03adOUecM5EXzVE16K1qOYi7m+g5DkS3CLSjfXb+wH7gaZHYL6
         YYNoFru5Q/a8niGfOAW2aMEDpkFYH9Rp9wp8ycknksJ3SkDN1jIuuIqViX/MKjmrEk4B
         mVPiYgUDUts/+yMTCwUMzdgSbSxe8jj9vUa6M5i8gZAI+z1qBgE8EqWGqFUzTEvMN1k1
         nFQDEkKft0XplzODcMtfsKzhAC5u2a7M9H7jLCzRFFljeRgJ/yxypxysoS4PXwMr9Ci0
         1p0pEnR1V9Tjjjry60qAqqee2z6vMtFel8fJIt5hY0h+fq+J6HfnsrXVWbXI+Z/GQqp7
         NXwA==
X-Gm-Message-State: AA+aEWbGSOaD2u+TRHdn2B790wKmVO2pvvffGvp1JUgDHZzMj6u+wKDQ
        EcDh9Dbf3LAzmws5AvngGoU=
X-Google-Smtp-Source: AFSGD/XkKiOKri+TsOKI0Wu9s9m0XTlRujFeB/+xuDFxCjNCtdAGEH/qpP4bfLVKWukuh3FLijjRxA==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr13629904lfg.89.1546013913934;
        Fri, 28 Dec 2018 08:18:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:18:33 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ARM: dts: s5pv210: galaxys: Remove hardcoded bootargs
Date:   Fri, 28 Dec 2018 17:18:15 +0100
Message-Id: <20181228161819.18931-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have uboot (flashed in place of stock kernel),
it's not needed anymore to hardcode bootargs.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-galaxys.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index 842276749717..cf161bbfbacf 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -11,13 +11,6 @@
 
 	chosen {
 		stdout-path = &uart2;
-		/*
-		 * It's hard to change those parameters in stock bootloader,
-		 * since it requires special hardware/cable.
-		 * Let's hardocde bootargs for now, till u-boot port is finished,
-		 * with which it should be easier.
-		 */
-		bootargs = "root=/dev/mmcblk2p1 rw rootwait ignore_loglevel earlyprintk";
 	};
 
 	nand_pwrseq: nand-pwrseq {
-- 
2.17.1

