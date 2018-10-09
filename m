Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BF6214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB1EPDq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BF6214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJIShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52231 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJIShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so1458354wmw.2;
        Tue, 09 Oct 2018 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZmLX6G2JlSljh1ihVkEH7VDWamjKDrF6JF0QalUJos=;
        b=aB1EPDq6RINF7SeqYBxAJRQsd+WfitVoH4k2hLpedq13K1iCwQCMKugxrlXhwEcyEB
         VABpPf1buesGa9aHdE/5ylQQ2AkdBnOWpIpkRnqK1pbxbKTgucmSQgeueCIywamIjL6Z
         CbO5D/z00RUU9qTI0qgA6BUDW0B64EPI2UctIiu9rJ2y50zAr1sJmHZ+jbjb0etTSLwn
         h1vHodmZbUXazlhKumURZZCqb5CRCJ8X0I3kGjmzIyGhhvmOTyH9CnUEjiDfFOdKgNy+
         BR15fMk1kK+GyotGH8UBAL5MtqCY9nkOgv5W4wkIgpGZIKNtvvC2vDzP6XRcw1ygaRqU
         elfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZmLX6G2JlSljh1ihVkEH7VDWamjKDrF6JF0QalUJos=;
        b=plKGL7Y1hc4bOi4pxhWRqGeeTW/3n+vfKHYnX8OKoglqQ5lWVjWJigZZKleKplArq5
         ttn22Qo1MndfYmfDMyOOWLI4RHK971+hBEZ1Kje1BevebhyFccx1zL5DWuRjL02rnVY7
         /XG01IZxm0mat3BQZyOPs1/R8uOLVxrZjHQXJAZoBcpr0TqoAlQHKixTFMBL2xYbk4FF
         9EZxsDbXno3K++70cOTuduFSGyADjFIuWtFqOOjjOpiKpYbstE3YjH3F4XgK4VAdU0Cx
         wkl4bg/9qAAzOC13IIiIsaJ6mCtTpVBm8yGp9emlW3C754TtuCjW8e1kNJ3n5D+H1jF7
         miHw==
X-Gm-Message-State: ABuFfojPbIu9BIssEyqKhWz/Zh9T/8RW1BPf8zVHcoTztfVVV0icZXvj
        Y/7brHD3clVp36KSsjMYrzM=
X-Google-Smtp-Source: ACcGV633AXlCDGnq58VCWH3kACG6Q2lknXpCIrSil0XMpUSHWEW7N8oHMmBo4ZdeN14lwxlRfNAxwQ==
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr1594870wmf.19.1539084044929;
        Tue, 09 Oct 2018 04:20:44 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id v129-v6sm9361330wme.45.2018.10.09.04.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:20:44 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/3] ARM: socfpga: Turn on ARM errata for L2 cache
Date:   Tue,  9 Oct 2018 13:20:21 +0200
Message-Id: <20181009112021.756-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009112021.756-1-peron.clem@gmail.com>
References: <20181009112021.756-1-peron.clem@gmail.com>
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

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

 v2: 
        - Remove fixes tag in commit log

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

