Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709805-2-1637330584325888419
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
    t=1518709805; b=K7ZFLw0b/Wo6HlpEEDbWcJrAe82/uiSL5DebZNpaibx3IFP
    ga1jb5R0Bs5bA57MKffWCbfa8dkkM9Y0lYcBV5fXazWR4N3vukvhoRPRmfTUAqCY
    Jk+On3ZsxylSN4qCi5i434Y/E2qz+CnBBhI7GPhM2mWrNWfgiEr0Jobafp0moaFO
    RC8k4iT/QfQT9UmnEbd84CLJjidd5VaC24gPB9nqpExImf7veF3pldQkmf7W9DTS
    W2J37CqyeyDL0mi6N1zM+H/zt+O2Edmy6rOVx9Xxm2+wnxl2+o63Yno+z2dC31qI
    tBknlNyZYDoxOgWi4UaX/J7IRPbLbh8D5zlhDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709805; bh=zCC02Ul4ABi7K34R8SjFKD4viE
    V45MxEOe7GCkMWjP8=; b=J2/Kn2+YnFRzXqAfu2kA/L5W6kN3CdT0LCd+HSjA61
    eVuGtDkFav688U7HSz/+PeDzvwBCcDbonYYSk598vWpzbdmKfCOc+6w/SlCJnihi
    8niB93kNdGD5RpnkoegNZ2THnDH/FwL9PEum2saHQiaqUkvoywt77XmvOhw9X5Nk
    SSijtEMpmU4NFx4FQpc1ejyqeqpZab9BykU18buYsqXTIKaeMIdEW8211ENsuXGr
    nII22EJkmLDD/osOGjNst2DRzV1lwWP92nw2PNsjd2ppSl7qBVg4pcB/xz2Yfq5S
    rQuJHWAoJpE0OdqtJ5Ocuw5r3q5E90r/kql6gl4fQajw==
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
        id S1424419AbeBOPsD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:48:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425009AbeBOPsC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:48:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.15 169/202] alpha: osf_sys.c: fix put_tv32 regression
Date: Thu, 15 Feb 2018 16:17:49 +0100
Message-Id: <20180215151721.703089781@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 47669fb6b5951d0e09fc99719653e0ac92b50b99 upstream.

There was a typo in the new version of put_tv32() that caused an unguarded
access of a user space pointer, and failed to return the correct result in
gettimeofday(), wait4(), usleep_thread() and old_adjtimex().

This fixes it to give the correct behavior again.

Fixes: 1cc6c4635e9f ("osf_sys.c: switch handling of timeval32/itimerval32 to copy_{to,from}_user()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/osf_sys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -964,8 +964,8 @@ static inline long
 put_tv32(struct timeval32 __user *o, struct timeval *i)
 {
 	return copy_to_user(o, &(struct timeval32){
-				.tv_sec = o->tv_sec,
-				.tv_usec = o->tv_usec},
+				.tv_sec = i->tv_sec,
+				.tv_usec = i->tv_usec},
 			    sizeof(struct timeval32));
 }
 
