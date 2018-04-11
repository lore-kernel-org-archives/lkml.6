Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464158-2-9892211749543575809
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
    1523464158; b=ObsQlhLhhrDUQMET/7Mt2YJvXDMQ/cx3WjFKPEyBIZdMWqInU9
    AMLrKd0nEOLYaR4sABQD+HfDAyRTIwI5g2MX9vDS9jwo+3gvImWuvw2xMBghCZoR
    35Q/cq2u6zlQYRmO+2nVWqKocBJwbESjnb5JLaYOCFR+FIGfQOEn7JrDw3QEBGjd
    7LJWJhlbCB15LrLhbPoHOal1ewYVaid1ha7tSttGZEGVgFPxYZMEkfLk97OJxO4A
    ON3sylZ+m/6RvCftSM3ZfsYhJxD/bhRrsjzfutTszPCRFcayOwMMJuQNDc5epPXQ
    3ftKhyy7945LN0+5knTnTmb30lf6CjbMnWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464158;
    bh=giPWmCMaCMOK1/qyqPuQjvVP2m/26yUPLk/9AcACJVU=; b=k0whhDP+hqDd
    ghRknFMIO8s0QV/vIpqPWtFKduiYORK21ZImWeU5I8NUxRM7Gjkk6GCX4/JKGXzS
    L5oYlx1jjQNbsPaoIYo8U9i8DJ/ZUpZzT8E0su29icMm57Q2L4TGVdUlgVlJ22n+
    lcqxMtCABaUpTO5BNBce0gGO3hyZ17kV6ZQ7NQjlSL/JZ1046N6WdB6bN8MabE3s
    TBdXQwElGmN9stj2gVoqPPSY4kHimPI1pWjt6dhzdS1sKgPaeza4tWGmzpw2A4KJ
    QFXB/bfSAMUQX5NPlByrXxkBMcV2wtVHnW/do5dxYPCMJTCEicCuXP86Oc4OsMi2
    MXOqnfjjrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPIfFDY5x5zjRPjrYfAZa/ptLR+6OAQkf2NW02oKWxewawL/VfjvvOQ8bq5I70RIHYIWyFqJnisqWmYlVmpG0N8rF+ewBrqSJOmd+XbR1WGl7f4r9ImH
    8rb8aJFI0XEG/S+aQSuVDTN5s3SuDOtSdEuLvY6ici8CLxZnf75FetytH/V3i+piTjUdkNlbd5YwEHUcIYE8jQVcT4IK3McqfGMyTfsgFKwrgEUh7aLmG+Xk
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9Rt4o3Z7AAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=iox4zFpeAAAA:8
    a=VwQbUJbxAAAA:8 a=2HZ0o_gNEvPU46_xZ4AA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=jE01AiZSAJ7eki2zvjzZ:22 a=xmb-EsYY8bH0VWELuYED:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeDKQZ5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754146AbeDKQZy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:54 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/24] x86/msr: Restrict MSR access when the kernel is
 locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:51 +0100
Message-ID: <152346395124.4030.8504337214384655170.stgit@warthog.procyon.org.uk>
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

From: Matthew Garrett <mjg59@srcf.ucam.org>

Writing to MSRs should not be allowed if the kernel is locked down, since
it could lead to execution of arbitrary code in kernel mode.  Based on a
patch by Kees Cook.

MSR accesses are logged for the purposes of building up a whitelist as per
Alan Cox's suggestion.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: x86@kernel.org
---

 arch/x86/kernel/msr.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index ef688804f80d..dfb61d358196 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -84,6 +84,11 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	if (kernel_is_locked_down("Direct MSR access")) {
+		pr_info("Direct access to MSR %x\n", reg);
+		return -EPERM;
+	}
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +140,11 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		if (kernel_is_locked_down("Direct MSR access")) {
+			pr_info("Direct access to MSR %x\n", regs[1]); /* Display %ecx */
+			err = -EPERM;
+			break;
+		}
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;

