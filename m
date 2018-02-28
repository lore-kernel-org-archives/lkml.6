Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833686-2-5093032540041818064
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833685; b=M0UcDy9vHBswOLVfYxElFHeIHrr1XUVIgq1b0oSibF1fEkE
    FJ+YSix/Ha4/WJViez8SXOBmzj+lz9tn7cWW2TnSK+YKMDBx3OC/LIF2A4LihP/4
    mG8mNnJd2pw6r/5pMTglMMPCy6pTwoQvCxJFmS1cdUvr08DhIlpMLw6k48gyE/Eg
    3YL4d1TjB+8egzxqXM9Y4VELcJn2n1usDjsmThf+STBF1OQsj1VO3oQjmg1vJBOB
    JEe5csiC0D0neBexCv1psPIcYppTxObTsEAPz8o2lslXKKf/eIFcfsKJ6q7uj7eq
    CAZuwDMBXpo4GkkyFtZXtXu0bz2l8qo2MqHYFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833685; bh=o/xQcggaxGMUuTQhS+/
    yA3blO93FIQgFJz5N2wtTLQc=; b=Sw4L8ozNQTCnjR03K9bMmbL4kYjSybnS46q
    JRKRLlR0Rw13ip2wc64habYmc/C/EdZlOWmqLU23BMw/T8iRG7N6xuF+Wme9g61K
    wzI7k8qmXAeLu0wcPm8z9oIyRKjBhQJt9KmQ3V//K8N/Ni7umdR9sPFdRRCl4FN4
    q2le7fMEmQXUxlcIHkhVYOxtTf+owOgf/J6UAB1AQ/SaChTMoTQoayx+OZathBF+
    A6PVJPm02fxCdjosGEvKxV+PpvM1+mJXEgWYesTluSNBxuSs5bOqxYAseBwqD7hf
    P9NQzESKgafunbRkW+tY+b8fIlAIXRO7EQGmVNv3mYIMzChF/ZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeB1QBI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:01:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34688 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932120AbeB1QBG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:01:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Oleg Nesterov" <oleg@redhat.com>,
        "TSUKADA Koutaro" <tsukada@ascade.co.jp>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.204548780@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 169/254] kernel/acct.c: fix the acct->needcheck check
 in check_free_space()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oleg Nesterov <oleg@redhat.com>

commit 4d9570158b6260f449e317a5f9ed030c2504a615 upstream.

As Tsukada explains, the time_is_before_jiffies(acct->needcheck) check
is very wrong, we need time_is_after_jiffies() to make sys_acct() work.

Ignoring the overflows, the code should "goto out" if needcheck >
jiffies, while currently it checks "needcheck < jiffies" and thus in the
likely case check_free_space() does nothing until jiffies overflow.

In particular this means that sys_acct() is simply broken, acct_on()
sets acct->needcheck = jiffies and expects that check_free_space()
should set acct->active = 1 after the free-space check, but this won't
happen if jiffies increments in between.

This was broken by commit 32dc73086015 ("get rid of timer in
kern/acct.c") in 2011, then another (correct) commit 795a2f22a8ea
("acct() should honour the limits from the very beginning") made the
problem more visible.

Link: http://lkml.kernel.org/r/20171213133940.GA6554@redhat.com
Fixes: 32dc73086015 ("get rid of timer in kern/acct.c")
Reported-by: TSUKADA Koutaro <tsukada@ascade.co.jp>
Suggested-by: TSUKADA Koutaro <tsukada@ascade.co.jp>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/acct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -107,7 +107,7 @@ static int check_free_space(struct bsd_a
 
 	spin_lock(&acct_lock);
 	res = acct->active;
-	if (!file || time_is_before_jiffies(acct->needcheck))
+	if (!file || time_is_after_jiffies(acct->needcheck))
 		goto out;
 	spin_unlock(&acct_lock);
 
