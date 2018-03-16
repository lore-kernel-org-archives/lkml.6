Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221464-2-11433762372643302908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221464; b=aTlpYOFXtBL1O25Cqcfs4+AMwHkGjG6o1mOPgJC0wehvVmV
    FF5m5lQtOr5lCYcDbsAs6zgmm9ZsoAZJUu2CSRnapClqM/5NYJ4VyxxHpiRYGjtq
    JYdE2KSa0e8I27pDbqHwJTVEy1aKI+IzHwKLU4H/XV+uS3ecKsa96B6ZXBoUJgUU
    4j1EEQXPM3erG6mLbZ7CyNCKMjjF0/HksIRfwdi+mr384CLaQgP+Vid9ZesY/DoC
    Akjow1ckyW+VsCnDPS0bC4aV2TUyIaEP2TH/Fa7QtCXDk8QvCFYJuWMF4ikauuxh
    kqoJ9g9U6xWkXimO/VVB7z2XdnVcEqQHcIXjWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221464; bh=+OUxAXagpQuzu7yuP/hD349SdS
    hibrmqTZbPNJTF/5Q=; b=ThOK+45HBt5ISgD3EzmTXCm/9xoONoV3TAUCv3efJS
    l8hQY9SI9W6SAV1NE4l1yvzXFxzJU0KTGhKAyfavK79pCHgXWwfitoxJ4VfHc9Mp
    azZbkYnT7tcLdImCWI4OSQuIc4DMTcbyct1B8sI+VwW+gJrRBgi5bWis/Ww7hzT9
    J4yvzdUruHpYH6rC0oEXXMPxJGL6gCI38WZgl37YZkrUkw1QV+5pmKOJIT4AlQaM
    b85Djv7950uwcek04kLL7hER81fMVI9Jv/fDsgR8xKqP+nnH1FkR5En1IxDO9Z3Z
    wiipcwt6qRy5aIEqjDYoJW+xOswE6QuvW6Meiv8xqGIg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeCPP14 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:27:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeCPP1w (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 30/63] netfilter: nfnetlink_queue: fix timestamp attribute
Date: Fri, 16 Mar 2018 16:23:02 +0100
Message-Id: <20180316152303.355607281@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit a7f1884554b81bd68cd435d72f09a3527629ac43 upstream.

Since 4.4 we erronously use timestamp of the netlink skb (which is zero).

Bugzilla: https://bugzilla.netfilter.org/show_bug.cgi?id=1066
Fixes: b28b1e826f818c30ea7 ("netfilter: nfnetlink_queue: use y2038 safe timestamp")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nfnetlink_queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -501,7 +501,7 @@ nfqnl_build_packet_message(struct net *n
 
 	if (entskb->tstamp.tv64) {
 		struct nfqnl_msg_packet_timestamp ts;
-		struct timespec64 kts = ktime_to_timespec64(skb->tstamp);
+		struct timespec64 kts = ktime_to_timespec64(entskb->tstamp);
 
 		ts.sec = cpu_to_be64(kts.tv_sec);
 		ts.usec = cpu_to_be64(kts.tv_nsec / NSEC_PER_USEC);
