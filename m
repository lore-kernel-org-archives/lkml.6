Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518185141-2-7435107618999524174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185141; b=ss/TEwo14RhnyMXovGvyoGAwQu59LXVzmH+gYDfKSA0FxDu
    3EdwTPA3rq+6cNYCbqKTdhlwzX1xzjjSy4r9DBAwWOIWMvwRk3ZuXbv2ym949gJt
    mL6gwtcRX/dRrhOpzTljojxEcDHbSk9i4p8dfH61SU5b9u0kpMDeyApT7cYSr6Zj
    oJF8W0Eklpb+kBwfCPVk5P5cc4y+VYrgOCctmoCIzbfq8JWpnOVRNWs3HWbNwK1D
    tr3kcydccLBvGD+XgVNfM/cTULWROojBphOObAR7fbAm8xXcAVxPU5CBPOdiYUGp
    lhIuEoHscLUf+hzdBgUWFGh3faKZ+CZr3GhbZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185141; bh=GzHCwOGol16E7FqMYrR1t5H6Eb
    lQ5WlxBNzWDdae2+Q=; b=BbxzL9N/mOYEOJgU40rP1CXKwkw8koqwUYV09SDSn+
    Wtmzqw//JRG9PTX/4qL9jrmElbAk0vHO6zDipPty+4S3//RSZkKvTdw08PvVOpVL
    Pzgkdku0AMj+CRXiBLN211czfcchJgXEHaWUjhjdA09teenCW9cgWYWqErP9nOm9
    4Da5w1Q6mefChKGB2z8BTerX9G00G6PnMA+TQg5nLAHWn/waZHxR6tjt4xIA1azg
    M3nZI1YoNgb/w4ycsZ+swQCyQBZ5hsapOc0RmZfjVrxU0RBudWqjjw4/VINVg+aJ
    xJu/DYqtavUUWEaJaak9ZKfN8ZVYRzQHmu4QUtEG+PHw==
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
        id S1753028AbeBIOFT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:05:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeBINnC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, alan@linux.intel.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 61/92] x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}
Date: Fri,  9 Feb 2018 14:39:30 +0100
Message-Id: <20180209133935.649625001@linuxfoundation.org>
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


(cherry picked from commit b5c4ae4f35325d520b230bab6eb3310613b72ac1)

In preparation for converting some __uaccess_begin() instances to
__uacess_begin_nospec(), make sure all 'from user' uaccess paths are
using the _begin(), _end() helpers rather than open-coded stac() and
clac().

No functional changes.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727416438.33451.17309465232057176966.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/usercopy_32.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -570,12 +570,12 @@ do {									\
 unsigned long __copy_to_user_ll(void __user *to, const void *from,
 				unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
 		n = __copy_user_intel(to, from, n);
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_to_user_ll);
@@ -627,7 +627,7 @@ EXPORT_SYMBOL(__copy_from_user_ll_nocach
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
 					unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
 		n = __copy_user_intel_nocache(to, from, n);
@@ -636,7 +636,7 @@ unsigned long __copy_from_user_ll_nocach
 #else
 	__copy_user(to, from, n);
 #endif
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_from_user_ll_nocache_nozero);
