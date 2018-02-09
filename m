Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518185143-2-6347230916068688414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185141; b=ftOo4FN5rsizigYK2RzHZW/eWSgd1trtpVGjLNwWKpEp7zH
    neUKHv5br8hZo8qZatEUiTmhhWYHHEf34jm7e4JtC2DyV+/2ezb5kweQwlnazg2W
    SxdbNlIvz4E9rp/ll+G/OscfsOyCs3lveFhMaNlVMToNUoUcQ06BH5pL1cyhBLA+
    uwYjJZ64e/VOcoP0AFqktTMx+jEvW/D7SUu69ayQ1Sb0kDeOv9A7iRWGnMP9XHuF
    eSZ+URX55kLQmwwCsm40wxix1udWKLM0koYF3Q4OXq2Y6dhQqU3J8763gooIBXzt
    U2ajsMcNcIUkCAIaH47R8Eot/jbT6f3GqeZPjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185141; bh=9VdAL43X0iVHRLq8teIaNJP9jP
    GPolld+EJJzDX0TeU=; b=vpaHG/0lZxsayAZywlSu+uUR+THuHZ1U9zJxS1A/75
    xmts9b55rZIJNEe2NcFMuurP+YKg7k7htG3d2pAG/irYogK0yMuly0HNZBMvZfOp
    NvUcHa/o/syMEqIiPCtoZz76POhZEBktVwD7+OJGkoRnkClB/YSomUOv2tIVTAyS
    bnDI1R8UcDd8MJb8UDYQS5mjcM5HTwn0gaYiYgFHSYbWudBuFxYuP8tJx6JCryEr
    zU6/q0ZnpILcLRw4gdueZ9mDOK8seyfKoZH1v7IYmryR1ZR+/+79vrwgXmb5wrBV
    jM4qhYcXryRQPY7pFyji9H/tkKUjl7iE9+BTsm8d7Iow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBINnC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:43:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeBINm7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Al Viro <viro@zeniv.linux.org.uk>, alan@linux.intel.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 60/92] x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
Date: Fri,  9 Feb 2018 14:39:29 +0100
Message-Id: <20180209133935.579350557@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>


(cherry picked from commit b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd)

For __get_user() paths, do not allow the kernel to speculate on the value
of a user controlled pointer. In addition to the 'stac' instruction for
Supervisor Mode Access Protection (SMAP), a barrier_nospec() causes the
access_ok() result to resolve in the pipeline before the CPU might take any
speculative action on the pointer value. Given the cost of 'stac' the
speculation barrier is placed after 'stac' to hopefully overlap the cost of
disabling SMAP with the cost of flushing the instruction pipeline.

Since __get_user is a major kernel interface that deals with user
controlled pointers, the __uaccess_begin_nospec() mechanism will prevent
speculative execution past an access_ok() permission check. While
speculative execution past access_ok() is not enough to lead to a kernel
memory leak, it is a necessary precondition.

To be clear, __uaccess_begin_nospec() is addressing a class of potential
problems near __get_user() usages.

Note, that while the barrier_nospec() in __uaccess_begin_nospec() is used
to protect __get_user(), pointer masking similar to array_index_nospec()
will be used for get_user() since it incorporates a bounds check near the
usage.

uaccess_try_nospec provides the same mechanism for get_user_try.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727415922.33451.5796614273104346583.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/uaccess.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -123,6 +123,11 @@ extern int __get_user_bad(void);
 
 #define __uaccess_begin() stac()
 #define __uaccess_end()   clac()
+#define __uaccess_begin_nospec()	\
+({					\
+	stac();				\
+	barrier_nospec();		\
+})
 
 /*
  * This is a type: either unsigned long, if the argument fits into
@@ -474,6 +479,10 @@ struct __large_struct { unsigned long bu
 	__uaccess_begin();						\
 	barrier();
 
+#define uaccess_try_nospec do {						\
+	current->thread.uaccess_err = 0;				\
+	__uaccess_begin_nospec();					\
+
 #define uaccess_catch(err)						\
 	__uaccess_end();						\
 	(err) |= (current->thread.uaccess_err ? -EFAULT : 0);		\
