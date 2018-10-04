Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E319121473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcUerniO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E319121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJDPrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:47:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35943 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeJDPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:46:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so8995725wrw.3;
        Thu, 04 Oct 2018 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAY6asfu2dthVrWoRaMrySY99FspVqJhbvZ+puVcCpQ=;
        b=YcUerniOc5ukL58Rog+5iCx6keflrN9HJpLYHahZDeAj98+kmfluHPoG9kOxruekqn
         7sJzVLrN0maoh1ucd3x6LQ+vQqSMRWHputukEqbdjXgE9p4HnX/6ghN01uvnDh5l1zg+
         Pv3oG3cVDsn0A6TO2DJ3DTGUPVW52+4RH2i4CnN2a+CeII57x10o2TpbEB0ITfJdX1Xr
         zcLlyROLuGHi66CPCce+sHUsv76QxBKMUxmj40RcBxvHIO+Aju+6iuaTDyOZx0otgaoD
         eCbcE3QsWZGTJKfv/af8QwevhMhloQHRO/a78nhVjuHKIwTvlUlKNPqkxD/EhkgLkZUK
         7h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAY6asfu2dthVrWoRaMrySY99FspVqJhbvZ+puVcCpQ=;
        b=tJClyofwMSUq4qB+kw4UUngy65lJil+fN/Mh5S0/BJX5zJMBc2Y2EiYUl72yGw/myG
         i7EYfF6S2tBGKX7V9HgJHphhCDnwnFiLhhllVvx9d3yx9Doe8Uonfb0/V9XIsT/O0AZg
         L0CQNkj9T00Pct5du1tTjz1KsSsOlEdjkeSGit2V2mwgyh22a3948z4nxNXOMdM8mcr7
         +HwZTNE+UIymAcClGSyGRW7j2JF6Zp0OghK+4r49YWWXiIZhSzsFx1tSNwNQozXy57Qa
         8ohZr2TfklIM5OC9QnZFroJHgBRLo99y6m1iwbBgG1Rqpo4X5lUGfbNVt0/N0bKbfOni
         fZRg==
X-Gm-Message-State: ABuFfoj4ag9YatBWK9UO6ZiHiJqmeErCVtEHt92J/jJEnthdc8Wyz4va
        9TDkF48bYJn31iWTtV7f9a61vUdS7F3xMA==
X-Google-Smtp-Source: ACcGV61j4SWI3d82/0nOgoUJIsSCp4IDwgIGMBqr2fVZKs1dnLHbtpV5X/0qmp8hWNSWAxBe6LF5mg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7-v6mr3788424wrp.229.1538643283484;
        Thu, 04 Oct 2018 01:54:43 -0700 (PDT)
Received: from cperon-Latitude-7490.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id b139-v6sm8715013wmd.36.2018.10.04.01.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:54:42 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 3/3] ARM: socfpga: Turn on ARM errata for L2 cache
Date:   Thu,  4 Oct 2018 10:54:15 +0200
Message-Id: <20181004085415.12925-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004085415.12925-1-peron.clem@gmail.com>
References: <20181004085415.12925-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

Turn on these ARM and PL310 errata for SoCFPGA:

ARM_ERRATA_754322
ARM_ERRATA_764369
ARM_ERRATA_775420

PL310_ERRATA_588369
PL310_ERRATA_727915
PL310_ERRATA_753970
PL310_ERRATA_769419

Fixes: 387798b37c8d ("ARM: initial multiplatform support")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 4adb901dd5eb..a04660918d71 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -11,6 +11,13 @@ menuconfig ARCH_SOCFPGA
 	select HAVE_ARM_TWD if SMP
 	select MFD_SYSCON
 	select PCI_DOMAINS if PCI
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_775420
+	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
+	select PL310_ERRATA_753970 if PL310
+	select PL310_ERRATA_769419
 
 if ARCH_SOCFPGA
 config SOCFPGA_SUSPEND
-- 
2.17.1

