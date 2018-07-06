Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABE0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75D8208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCx0xook"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75D8208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934619AbeGFSfi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:35:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34694 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbeGFSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id c12-v6so9813241ljj.1;
        Fri, 06 Jul 2018 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfkN2BRmaFMo/wJvnoikyZaoLnqmd1IN7BL7KjnftSU=;
        b=VCx0xookwbWEfN8FOT6DQfZ1+ftEcUF5fK156A7kP0ErRwXU6djju+yEmJdzU3/iww
         O6XGLaZstOSpjpBkQ24Jkfzv26/BqC0e8Pb1edt9qfIAyvskzvNuz8WeH8J+nWasjLch
         8OF5i+2IqRDNoh4StmCrtjjYL0zQ1VTKZ4ad6DjKmyluz74kxJixn6R7FifIuPOrMCKf
         5XlldOvdAMiFW4HqYVorOi0MS2aAC6wTiTJSnKooF3dV4ka+PrPlpYGSmP98U9F2uCTM
         BrH/3zAVyf4QU/CG+ljmkDIBJdv50M/AAVi6h8mLJYZcLYHqx8H9WLNcj43asuPgqfb2
         cT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfkN2BRmaFMo/wJvnoikyZaoLnqmd1IN7BL7KjnftSU=;
        b=duAD82iGBZLGuGqxlEXuKVIstf84nsAIS4nzguJ+keKxmu6lu0MkBYe043j3uLQtva
         kfLePPp1SVegZJ04Xff80fKNn6DGNzyrj+clX2U6in0gLV17OaooIcDy1VRupfyNigKb
         lAuwO2lS8GDVLuwLpJDBUMnU8xj5rCxZe4WSptnOJju513/yf/V8P7Ks+QRnArHHlgSo
         /93hx9izUwwt39J037ygx4tYzqrPt2ue9nyTQTrlI9Qt978p71HYEDjdP7cbzkKheXeo
         +ECpU00W61nIH80nVKyb1S+fpOmIl/uOdL0TtRB7qfTwduPeX9GfBKtcUy54TGczsLad
         MJow==
X-Gm-Message-State: APt69E20K5o+SnDpESCXHyZxQKxiszVaEobG94ff7/esvAnXV4tcUXce
        8ylud7Bf0FsD2vb2hakWqeM=
X-Google-Smtp-Source: AAOMgpd6sTnBtsIoqka4IsQcTHuOc+j9ItIML4UvV+qMaFfSKx+t7SBHP1jKYuWopWvD65ElNQfyTw==
X-Received: by 2002:a2e:9d0e:: with SMTP id t14-v6mr3237178lji.112.1530902003798;
        Fri, 06 Jul 2018 11:33:23 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:23 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 1/9] ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
Date:   Fri,  6 Jul 2018 20:32:42 +0200
Message-Id: <1530901970-14972-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds missing interrupt-controller property to gph2 block,
to silence following warnings during build
  /soc/pinctrl@e0200000/gph2: Missing interrupt-controller or interrupt-map property

It's reguired by Samsung aries boards, an S5PV210 based
Samsung Galaxy S (i9000) and Galaxy S 4G phones, which are added in next patches.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 3a79feab11c3..7f0c9d447871 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -258,6 +258,8 @@
 	gph2: gph2 {
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-- 
2.7.4

