Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824344-2-7936973716758814889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824344; b=Ux05lyvmaDISRwNYDkJAiQDp28QJhaih1mdtHITVy2QyUXA
    ew0XxPg4gwHotgMlWYcOjhVcwU8e5rhQdMxOH19/Of1vCwrrpjzLxBSm/nJ+RhI8
    JNg27jzK1QYKQcyaNA6FIYkHGR8hBd96zj3NtneGFr0TQuxjeiPB3bTNmCtrNW/q
    50dFKLeEAAmGOmJbK9Wmk2UYapOFVcY8uJltKygto67md5AAJ9vDwy7uPJOzpBRE
    Gxlkln4QmKWUBq0GtAwDTIcAEn0nfS7pT0s0QhToEJ+EW2OqCa2FyaLTZ2HR/YNE
    FjyTdZP9klxo0FAOYM8AaPK2TX+6wSUwaNBVCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824344; bh=dCgL7bFVGhDZn9fEKoF
    OYb56dcBIKEz0D72nwiXbTZw=; b=S/vqv6Mn+MPu/QgkEl8lhQFzXeeXe2npDIx
    8ecRzkhUa3OwOzrU6dBAWkv514d5IjYABnzN9RHRLE0jqNXKXmT5iOXYPsNa1G6G
    HS1MXyHWEDmrdI0ZZ+gaQhU7VmkeeW+8Rh2uskjz0Dmg6xk+lylAi9K49ssriw1d
    6rDKfl2XlHGw5sQY3CI9TC+I2PiOkEijOL9x3uc/d36VLYDD7bmXPPAeYWUdUYsn
    Z1sKJ3M1NkkCHf9/Jgkl4OQNHgtOeeEZk5CIBMTNIrIHYI3AcgcnIrUrpTE1Wv16
    JLYuxsNvDltBQj3yYi39pNycgLCCl9AAxOx6iY2ALvqV/4O6HwQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932788AbeCLDLx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:11:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41590 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932805AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.111738999@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 72/76] x86: fix SMAP in 32-bit environments
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit de9e478b9d49f3a0214310d921450cf5bb4a21e6 upstream.

In commit 11f1a4b9755f ("x86: reorganize SMAP handling in user space
accesses") I changed how the stac/clac instructions were generated
around the user space accesses, which then made it possible to do
batched accesses efficiently for user string copies etc.

However, in doing so, I completely spaced out, and didn't even think
about the 32-bit case.  And nobody really even seemed to notice, because
SMAP doesn't even exist until modern Skylake processors, and you'd have
to be crazy to run 32-bit kernels on a modern CPU.

Which brings us to Andy Lutomirski.

He actually tested the 32-bit kernel on new hardware, and noticed that
it doesn't work.  My bad.  The trivial fix is to add the required
uaccess begin/end markers around the raw accesses in <asm/uaccess_32.h>.

I feel a bit bad about this patch, just because that header file really
should be cleaned up to avoid all the duplicated code in it, and this
commit just expands on the problem.  But this just fixes the bug without
any bigger cleanup surgery.

Reported-and-tested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: There's no 'case 8' in __copy_to_user_inatomic()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -48,16 +48,22 @@ __copy_to_user_inatomic(void __user *to,
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__put_user_size(*(u8 *)from, (u8 __user *)to,
 					1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__put_user_size(*(u16 *)from, (u16 __user *)to,
 					2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__put_user_size(*(u32 *)from, (u32 __user *)to,
 					4, ret, 4);
+			__uaccess_end();
 			return ret;
 		}
 	}
@@ -98,13 +104,19 @@ __copy_from_user_inatomic(void *to, cons
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			__uaccess_end();
 			return ret;
 		}
 	}
@@ -142,13 +154,19 @@ __copy_from_user(void *to, const void __
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			__uaccess_end();
 			return ret;
 		}
 	}
@@ -164,13 +182,19 @@ static __always_inline unsigned long __c
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			__uaccess_end();
 			return ret;
 		}
 	}
