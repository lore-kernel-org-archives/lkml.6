Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9456C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E5D21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E5D21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeI0X1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:27:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0X1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:27:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH8GcS102368
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:08:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH8GWZ102365;
        Thu, 27 Sep 2018 10:08:16 -0700
Date:   Thu, 27 Sep 2018 10:08:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-7377ed4bd56e6cc1ddbb63f03626fc5b92d3d6fe@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, rafael.j.wysocki@intel.com,
        puwen@hygon.cn, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: puwen@hygon.cn, mingo@kernel.org, rafael.j.wysocki@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@suse.de,
          hpa@zytor.com
In-Reply-To: <cce6ee26f4e2ebbab493433264d89d7cea661284.1537533369.git.puwen@hygon.cn>
References: <cce6ee26f4e2ebbab493433264d89d7cea661284.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] ACPI: Add Hygon Dhyana support
Git-Commit-ID: 7377ed4bd56e6cc1ddbb63f03626fc5b92d3d6fe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7377ed4bd56e6cc1ddbb63f03626fc5b92d3d6fe
Gitweb:     https://git.kernel.org/tip/7377ed4bd56e6cc1ddbb63f03626fc5b92d3d6fe
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:37:05 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:29:00 +0200

ACPI: Add Hygon Dhyana support

The Hygon Dhyana CPU has NONSTOP TSC feature, so enable the ACPI driver
support to it.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: rjw@rjwysocki.net
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Cc: lenb@kernel.org
Cc: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org
Link: https://lkml.kernel.org/r/cce6ee26f4e2ebbab493433264d89d7cea661284.1537533369.git.puwen@hygon.cn
---
 drivers/acpi/acpi_pad.c       | 1 +
 drivers/acpi/processor_idle.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 552c1f725b6c..a47676a55b84 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -70,6 +70,7 @@ static void power_saving_mwait_init(void)
 
 #if defined(CONFIG_X86)
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
 		/*
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index abb559cd28d7..b2131c4ea124 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -205,6 +205,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 static void tsc_check_state(int state)
 {
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_CENTAUR:
