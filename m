Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3619796-1525407327-2-12863395707797917829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525407326; b=mLdPnr1yehC+K0sBkTWTe4kvwf793as+2QXguNtHIOOYfP7Kdt
    OZxyZ6OC0IYp1NZJRPdD8dmp6UHOkZ2MNTDrFeFUtmCpHLNV/u9Tq0Asc4qtB3Ao
    9kRAOdCXycL3zb/5XhyD4ZqQvUF2bvtx0dwWdnMSh3Fvhe9KRrG7SASwl1h4kkBT
    FJ65SUp6qQskhs6uwNiKOx3cg/QWwLf9ABbD43KAt+nfRK/xIrSuyjz/wyVE+Ubr
    bTPa8vzeD7zsShPv4fM4hwxN5Ztyhl2gHMpoFbLO1LGQymVqfGU83f86TRjGpBUd
    mOV25esDb7AxTongwCeiCR+kQuFcRIbCd+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525407326;
    bh=tdv6s6eaRcwaGccSBjbi9dF+NA7dQcwkjAbhP0Dj0es=; b=Tp5lEehoE4sq
    fbGHPRmVR3xJ5vK94yB4KuKH4Ov6YfXvzbKrCVMCOXLJtXxh0Z/jBpfgj9NTZ6Q0
    gsucFsTe7C1x1qRDrCrEDu9qQmoeuVnGEzkTzY7do91DS8xPFZ7MdGKMh6ty4x9+
    46SvR5Vl+XBZ2AIB9WwYdpZ1mKb4LOpi6JHuL8OA3961sWR9E4Ql3HfVvhnsu9cA
    K0zbZ9IDMXwHMX+OrvhxrZq5koESSCzujy3VJ4677K3GfzbttZBrl55jZa7pDZq0
    J4E/gTsTG6slDxGOLkj6LAJv7QYa6Tvaj5pBKTsNeKqEnqfErWVAkUh/q2mox5oD
    CQbxa7bPJg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1HEjBZ0e x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1HEjBZ0e x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGg81rV1sxgHJkUHYe0G56enudTziJrDPR1fgUGXxtXd6N9dWDEJqIa2V78Y5aEZqJB7rRWKfxSsA9h04oxawnUTI/cDUpb+GGvBzjpJ15+3iVnhV+N7
    xJVbPTtxtz7DGhSuqjJPNX2ZcYB19gXo6QudydciATdx4Vfr98kmf7cRWT15L2fFKbeYOmdUIWiyxPSXXWR4rqLsEs80Gl/FugzRWeDDSidbPJ81tEK/xt5S
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=eHHp_rMNl1P3d2qNW8UA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeEDEPZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 00:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeEDEPY (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 4 May 2018 00:15:24 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, David Long <dave.long@linaro.org>,
        stable@vger.kernel.org
Subject: [BUGFIX PATCH v3 1/4] arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
Date: Fri,  4 May 2018 13:15:01 +0900
Message-Id: <152540730083.29650.15621737261480060241.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152540727123.29650.13679359124038587629.stgit@devbox>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since get_kprobe_ctlblk() uses smp_processor_id() to access
per-cpu variable, it hits smp_processor_id sanity check as below.

[    7.006928] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[    7.007859] caller is debug_smp_processor_id+0x20/0x24
[    7.008438] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1-00192-g4eb17253e4b5 #1
[    7.008890] Hardware name: Generic DT based system
[    7.009917] [<c0313f0c>] (unwind_backtrace) from [<c030e6d8>] (show_stack+0x20/0x24)
[    7.010473] [<c030e6d8>] (show_stack) from [<c0c64694>] (dump_stack+0x84/0x98)
[    7.010990] [<c0c64694>] (dump_stack) from [<c071ca5c>] (check_preemption_disabled+0x138/0x13c)
[    7.011592] [<c071ca5c>] (check_preemption_disabled) from [<c071ca80>] (debug_smp_processor_id+0x20/0x24)
[    7.012214] [<c071ca80>] (debug_smp_processor_id) from [<c03335e0>] (optimized_callback+0x2c/0xe4)
[    7.013077] [<c03335e0>] (optimized_callback) from [<bf0021b0>] (0xbf0021b0)

To fix this issue, call get_kprobe_ctlblk() right after
irq-disabled since that disables preemption.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm/probes/kprobes/opt-arm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index bcdecc25461b..ddc5a82eb10d 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -165,13 +165,14 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 {
 	unsigned long flags;
 	struct kprobe *p = &op->kp;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	struct kprobe_ctlblk *kcb;
 
 	/* Save skipped registers */
 	regs->ARM_pc = (unsigned long)op->kp.addr;
 	regs->ARM_ORIG_r0 = ~0UL;
 
 	local_irq_save(flags);
+	kcb = get_kprobe_ctlblk();
 
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(&op->kp);
