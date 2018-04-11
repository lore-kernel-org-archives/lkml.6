Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464066-2-10654577553672538171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464065; b=v/AJxhWe0K3fUDa/GQ3Avy6qGEw01M2VkKs3LQfXENu3XOUNHD
    xNf9fGoXJVWXUbJ3VevY/KbHJ1BTNPOtd/OcNbvTt06wI2VJM6yiNex7Mq3PF/Fe
    DwMzVb7eQuNpXZ+SsHLiJ/2ts5nEHxRpSbfMaW0tZXgx/jjZGmtn9h0JNB9HNaD7
    KYGvhKPfpOGYJOsZ3nKLx+/LpcE6DDPEVS26Ckb3Q3GnKuduuaPjp+xWjskGGdgO
    do3C+njajREGQJ5qWNaegmv17pH/C5JFWzzU8pu+vHgPPlVxaTYjxhhBYfVPk5f4
    O1iScoW+ddLSUqiGS9iWXXsm7FBSef12cTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464065;
    bh=P5NxxJNGZ23lEwHgUh8zTYPMtnyeotHqeDTscj8BXUg=; b=DhlQe5ldLV3p
    GM/B7ufj9l8gKxrDJR2ENpeGKeMPkfxL+616+6XpadpqOfMsKM+WtHHbFhNY+eaC
    ALfJrcwMM+ZNUFJCcSIvRZB29vmM2wYpH1ig7cfU0dPXnLVt7e9x71xqnrz5Itoa
    pDLx3XZ/niGnCDvHtnfE8a19oVPmNgAHB9x1M7BiGsp7CEo9IljbuDREFqMUjhnf
    K7ahCrNG4NZddeqA4Ski9aVDVTt2Xe1zBLe5Ca9/s7HqDbyBgursuFCq/smGkbpZ
    F1es3ovH3DseSsxXLUucYsYVfSCYtYUTHlf3+LpqbI2SifburyVy5RQDvd5XdNCI
    m+e8mNCvKQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGRLUEEnAavmJEnn6VOVKLMTq3K+wZ6VSdyQjhwFzPvolK1bQZNEjjZgKZeRuvnUZmr0ByjrV8tXdukRBKzspS6p7KHoC8n2IfRv2ZeScIydXRU5+DUZ
    P0r6L/msU8ZfQYVH30p7JeV7ztFA54XaQS2qpRjqWDaRRCnxpAbC/B8PVGXjWRarNwcSUt421c0ujmfymqTBzI00FLihx31xGs397tBj9m9jLdtFro2FC9wu
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=eWy3-tugzq9TJOV8ABAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeDKQ1H (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:27:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753772AbeDKQ1F (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:27:05 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/24] bpf: Restrict kernel image access functions when the
 kernel is locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:27:03 +0100
Message-ID: <152346402306.4030.13915529680179697046.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program.

Completely prohibit the use of BPF when the kernel is locked down.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
---

 kernel/bpf/syscall.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0244973ee544..7457f2676c6d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2031,6 +2031,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kernel_is_locked_down("BPF"))
+		return -EPERM;
+
 	err = check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
 		return err;

