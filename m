Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324283-2-13299263222358549615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324282; b=GKfN0tVNdDbLNC/1O/Zl8IxHbvNCh1inLQBJBDvbkVwwDZR
    Ohn8IJZAbzWJTzafAjrrQPFnViMcshVyEGGpajQwoz8aZebE/Gve73cQ5he1Ku7B
    rSiQq61xXFxoK/lsDnvuSZZEagRzNAhzgKDcU2DdougIrh3Tr1V0mX+AqkLFafyM
    oX5I7QLGmCopDLTNdAsVyICfFY9vWMaui7AUKxZI621DPddv4bSAM7wOZ+NlAeRY
    19B2lNT1B+oHmdU68MEkH4aV9AO8Rx4RmmOJeNFN3VMd2VgybJ1e+/+H22ndVSVC
    hWolBEzTYdUMfP6mL5Wz0s7S4B1D33WdithPcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324282; bh=eP/AH+lQxHwKuULdilv
    KNit5kzgkEjlU3g0pBS3v6BI=; b=iV+cRrY2q8YPGk3NoStWf4Kzob03ydHadh/
    hfqLV34T1M0Kj+EX5eTdslGLaz5UkqOGAgoO7rsNPPzqa51qZWezj2eofnm+cXmS
    G1++r4s4FmHrXvAMbI+vlCaFN79Y6Gos6pAUENOgmHMcRDUZO7JnJm0prYmzCXBN
    EJEPtI/qXyTQ2a83VEdlQLFMMwOz0qB0dVuhVG3+PB947JXD4aLzcfF5W7sqnziU
    HgZ15lrHSkpM7jBy5GNKmawXqGYbMztcRMzJ8BMHyhvob52afEAa+hyAh4beJMXS
    mJ4B6rjfB9I/giTT8bfZJf6XaYayCaDLZ3Q+Van1eSZrn6Mv1Rw==
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
        id S1753358AbeBKEnG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:43:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41892 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752871AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Alexander Potapenko" <glider@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.400637311@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 085/136] net/sctp: Always set scope_id in
 sctp_inet6_skb_msgname
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 7c8a61d9ee1df0fb4747879fa67a99614eb62fec upstream.

Alexandar Potapenko while testing the kernel with KMSAN and syzkaller
discovered that in some configurations sctp would leak 4 bytes of
kernel stack.

Working with his reproducer I discovered that those 4 bytes that
are leaked is the scope id of an ipv6 address returned by recvmsg.

With a little code inspection and a shrewd guess I discovered that
sctp_inet6_skb_msgname only initializes the scope_id field for link
local ipv6 addresses to the interface index the link local address
pertains to instead of initializing the scope_id field for all ipv6
addresses.

That is almost reasonable as scope_id's are meaniningful only for link
local addresses.  Set the scope_id in all other cases to 0 which is
not a valid interface index to make it clear there is nothing useful
in the scope_id field.

There should be no danger of breaking userspace as the stack leak
guaranteed that previously meaningless random data was being returned.

Fixes: 372f525b495c ("SCTP:  Resync with LKSCTP tree.")
History-tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: 
 - Adjust context
 - Add braces]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -787,6 +787,8 @@ static void sctp_inet6_skb_msgname(struc
 		if (ipv6_addr_type(&addr->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) {
 			struct sctp_ulpevent *ev = sctp_skb2event(skb);
 			addr->v6.sin6_scope_id = ev->iif;
+		} else {
+			addr->v6.sin6_scope_id = 0;
 		}
 	}
 
