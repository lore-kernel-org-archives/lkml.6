Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C81CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A2B27374
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="I6baVo/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A2B27374
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966014AbeF1Mrn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:47:43 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52412 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965951AbeF1MrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530190032; x=1561726032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=v4B7Cwsu0IJuxg+/3oQ7E7iAV7W0OvQxHFhplCNRUO8=;
  b=I6baVo/48p47FX8KICDk/edbQWclDsRHQ30KzrERoYx7PL1uoocLUhoY
   vTo/zR8ffIYYsSDGNa27/YmVm6mNPdL9YzxzR/YCjq0el77xrdkrBJkrT
   IdeYbtYarx9Iws0ddMcvN428JA2uBhXfRQAMcthOHrFfQU2wZ6+Febm7o
   w=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="620006241"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:47:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCl77Y049307
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:47:11 GMT
Received: from EX13D02EUB003.ant.amazon.com (10.43.166.172) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:47:02 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUB003.ant.amazon.com (10.43.166.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:47:01 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:47:00 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <kvm@vger.kernel.org>
Subject: [less-CONFIG_NET v2 8/8] kvm: drop CONFIG_NET
Date:   Thu, 28 Jun 2018 14:45:36 +0200
Message-ID: <1530189936-25780-9-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
 <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenarios, we do not want to use CONFIG_NET even though we want
to use CONFIG_KVM. To get this working, and to not pull in more
dependencies, we need to disable CONFIG_TASKSTATS as well.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 arch/x86/kvm/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 92fd433..f209817 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -22,8 +22,8 @@ config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
 	depends on HIGH_RES_TIMERS
-	# for TASKSTATS/TASK_DELAY_ACCT:
-	depends on NET && MULTIUSER
+	# TASK_DELAY_ACCT:
+	depends on MULTIUSER
 	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
@@ -37,7 +37,6 @@ config KVM
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
 	select KVM_MMIO
-	select TASKSTATS
 	select TASK_DELAY_ACCT
 	select PERF_EVENTS
 	select HAVE_KVM_MSI
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

