Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527155137-2-17137590142178491436
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155136; b=Rmox/0XGSp97y4JsDyrFcZqSf8qhJIvSMwx0EyFL8eT41aIeFW
    1xWwijBHSmvdeHEDwueUc9Cdse2IObFv46ayGSEgxFVFhGTUqmHWO/Aluv1ubA/Z
    VHciCOGbxindcjsD9eD3zldaDBZzDmjbsgSqvRUvexD38Ccs4DrGpCJaqZyv9IwB
    pc5T/aO+azAoUZXsbSUJaDNmPksJU/DeFK/UYtzvmgovFJnR/x71vmYtZtBkeHwb
    aESMnvhPUJcmsFMryHB4yu09/Y8hdB1nMca7WAnh3k0ZSp8ARW5G+6Ut9+ljqXXd
    MjQm3t3D5TjOZqGh25E8f2zLpzjTTrTihO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155136; bh=MQMFTeYzzt5bzRdmnbM0jHD4rWzuSQ
    SYLlLTzI7ZI94=; b=mBRNPMS+eYKVoxIH5Tqh1dG1lEDf6/JsWSK3QJeiz1gA8v
    8e/q/W+6sesAVInPi9Y2Lp4tnxupnf99eY5G7G8BbXLlIqyXSGV3hNR2Oq1Jb7g9
    DorOPindeoEUA9OWVP7qgNeIdxa80PQWwMXJ1J1YU8uPiF84nuIlqpiXhcPsWDFi
    EFaObpARPZi6PeDAxUd1FAe0CeA8poZDyUHTG29I9FVDXFAqz77ZF5xUKg1d9sTz
    lqOyiu1Fkt/8sCbTvTlHaIJqVh7X3Mn74eKrEPPy8UBuv3/e9rmHa3x8fuOs21Db
    ghfGysJMGsNPkSnhsp5JL0ylA9X+BRj7qNBRfMeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=M2mJC6ia x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=M2mJC6ia x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGnbKuUUTaZVxfToMGcO/nhfqk5GDzrPa0ejzgpls5sjgHDh19xy1brIhwqAgGZFNFeJ78hvci96z6qS5oST7oF+rQH6dWBqf1vAXQkTjzH45IdyQohK
    8PPyzZkpbuNNpX9vCUKTp0h3HnmnAq6/SBolQHpuNhhnbftXowaH7C420juTAFSZ4rjCSBuDYRlNrBGrFLFHwiXnqJkK1Uiwm1lJVXaQMuaPMoLZs9xY2mRI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=ag1SF4gXAAAA:8 a=-Xu8FqAyaz8zE7KY4yQA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966801AbeEXJpd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966782AbeEXJp3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.4 65/92] ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
Date: Thu, 24 May 2018 11:38:42 +0200
Message-Id: <20180524093205.539658174@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 69af7e23a6870df2ea6fa79ca16493d59b3eebeb upstream.

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
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -165,13 +165,14 @@ optimized_callback(struct optimized_kpro
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
