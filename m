Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1692CC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CCA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQfq+0jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CCA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757447AbeFSVZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:25:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46689 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757414AbeFSVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:25:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so472578pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=FoFCxOT7WCTcrfMyWhRzwq/90jC+TuKDpMDcEDmpWMY=;
        b=JQfq+0jnVobklnlqw8SD4bTcr23lZkK9PiYtHiQBEhEFEz1ZP28kogQmWAJO2zUTkG
         k5c6encUF1Kmaq3mlaCbUDeYC/qifWSZIOSVP4+7w0Qceg0fYMErMM3VZk6daMrdExGp
         zTTOjW564010Pb9HDIGBe2as9HUtvzG8wYssN2N/yO+8ItHJQ2wEmw69oukg7z1BfLFr
         VidNvBc4kqWPJMIRXN0OM/9cKjiSj9EeRB+DOnoYaCap7Vxtt7fAvlnYNrEjMcXabpfx
         6NuXkQpTVHG17jgaRp4E+LE/me73edYpaj3M2vOBWQuGSJ40uRxtpT+dFAI/AxfcvH0t
         KwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=FoFCxOT7WCTcrfMyWhRzwq/90jC+TuKDpMDcEDmpWMY=;
        b=M9+mhH0LbtXpd8fqzVImBOhbOSemb21+k2cfT9wVd1saxtD9b8ISLiAkVEpLcrNDLM
         t8hsa+fwfstg+ua+WMIhrSKltLNle9EPDKlSCn+RnO5PVcX+5kSGwM9HcU6dilXXu8xL
         yp4rZ6Z2Dvrv9ZhXtPW2PMNawNWf+J7/hQEsL8p39piMy6kAEEl+YLa0KftpWHKGCKFz
         jyQ6QGXrjPGRIWCocnMxyvjgkwm+duw+Azlb20JWgs4LP/4Ljd6SQ85E+nHxd6jYnr2h
         jdivLmIDp4BrnPc9oJ1U7TJyuCT5lLdL0dfRKLe7JRuxdqyDSmqag/PiPt+UKLGspcBN
         1vVQ==
X-Gm-Message-State: APt69E1f/4wnVqy3tIn7cFktDENzc9ySgooD7pS7nonGIMYZkw1HQLUt
        OBypvkQgPS6FF5MB13v10fY=
X-Google-Smtp-Source: ADUXVKIPC7CVJTYFfgBVcyxSqUCXXc5eVaEkIIqnr/G6gyIwYApBCbWUMpRp9TursVMKsgqC9XGyvg==
X-Received: by 2002:a62:7db:: with SMTP id 88-v6mr19778416pfh.178.1529443531768;
        Tue, 19 Jun 2018 14:25:31 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id t23-v6sm846203pfa.86.2018.06.19.14.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:25:31 -0700 (PDT)
From:   Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mikelley@microsoft.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 5/5] Drivers: hv: Enable CONFIG_HYPERV on ARM64
Date:   Tue, 19 Jun 2018 14:23:15 -0700
Message-Id: <1529443395-20874-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on ARM64,
causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 97954f5..c3e11a2 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && PCI && \
+			((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) || ARM64)
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
1.8.3.1

