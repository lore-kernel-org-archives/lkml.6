Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4FA20856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDEhwt9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbeL1QSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:18:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40197 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeL1QSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:18:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so14830603lfe.7;
        Fri, 28 Dec 2018 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c77j7aD/DmGjVf2ggTd+wLasZg/BuGwrkqKrYB9JbP8=;
        b=cDEhwt9wG1QFCcJXIHxTwIV0NqOcdnAGoooCVKCfbtbqGquU3+OPDWK9iGyPVfa4nQ
         eE/egRt++mHX7vR8tHB/vRBiCe7+vmmAKjEyr540SKQTuneujk7iOLrBdgVeC59koDeK
         WWOdF790rAYmktb3S/7p3krU6yXyl569l/BuzSMqcEWjcWxihas14tbH1778ywnRaJT/
         8QusYQYnYwebW26hKhUJnCLdaRiejRgMu3iN0sFoyhRUdCSfppc9Nf3KZihfEOOvvDlX
         iEAgL6hu24mNLIhZOIr+KN+63IJwx4WKZta7bu8tU+PnK1HO73oGSMHTjF9KgrNFAeZZ
         aJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c77j7aD/DmGjVf2ggTd+wLasZg/BuGwrkqKrYB9JbP8=;
        b=RAVF74Ab3GD//IEw1J0FABWYd2IpZJQiavF5sRNHlgil41m1VxgHF3VypvOE6sbNnk
         BR6DgWLSrGYVaiTD5GxENuLold/KRUE2bP4LWQQ+r9SrEMjk9jxx2RF/53CVCduNCfTb
         QN9vaG0vsVWzQRoxUx3iIIv+EgjNyGcSjh3mBVCyQJgDLlyiI11fvn4pjEH6CANvK0CU
         x2WqTvAgcNlAzfGiAgO6PNlnwyXl4xLSw1aqDk0XwhwuHhvC45wWLGwqZfW6IFnnlOfc
         nAZ5yKKKfsE5B3O02+L11wmGi8wud2r8NMuVSKbsB6HHMHVR85y8Rx6Uy+vMo8ja2daJ
         eNWQ==
X-Gm-Message-State: AA+aEWbh0lw8i5obW0KYZly4ftmXAyrNwOnlIEthP48YobasO1dXfbZ+
        fn9qsoRR1E/iQSvhle21NrU=
X-Google-Smtp-Source: AFSGD/UyE61l113Mwb8+mzsJNmZ65GwhtxiJUdpSg7Ea4PYhR1wdq6X8HVcfFPJdk/Z/hQ4tb3hoWQ==
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr13572469lfe.4.1546013915790;
        Fri, 28 Dec 2018 08:18:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:18:35 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ARM: dts: s5pv210: fascinate4g: Remove hardcoded bootargs
Date:   Fri, 28 Dec 2018 17:18:16 +0100
Message-Id: <20181228161819.18931-4-pawel.mikolaj.chmiel@gmail.com>
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
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index ccf761b1babf..07a8d9bbe5b8 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -11,13 +11,6 @@
 
 	chosen {
 		stdout-path = &uart2;
-		/*
-		 * It's hard to change those parameters in stock bootloader,
-		 * since it requires special hardware/cable.
-		 * Let's hardocde bootargs for now, till u-boot port is finished,
-		 * with which it should be easier.
-		 */
-		bootargs = "root=/dev/mmcblk1p1 rw rootwait ignore_loglevel earlyprintk";
 	};
 
 	gpio-keys {
-- 
2.17.1

