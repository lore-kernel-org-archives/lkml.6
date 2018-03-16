Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221865-2-10080404599216033112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221865; b=CA8lBJTvMKbNPJX/A39KAsUwHaFRg/bRsLs1F5eRrgZw4cc
    oH8XS1XFqRzx1HsOx/060tS/98ArQ7cKLbMdgbYdJogx5imBz3S7+Nn1CUo2ZYXP
    NxOBqQF6T0zKpvX6oeQMdclUkng6/M+lsimjLC+jSKRiZTOX69qqBlfkjJAVDHRz
    VJ/ma5EyyxEVUNbI7ZRzDKW8PqDzE4AswhKel4fYOoteXI+2hxOMUDsVZ6JnenNg
    8atlAU9siAmJPRt1ALgiVUeW8faaQKTkxWFgMmSko7rX0M/dEwf8h2T3ZzpU0bfc
    EfQO6eymQhK5Lvrkv5OXWtA7pdLjFZb71K6fOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221865; bh=KKHUrAsJEzR1WlSawSF4rIxGaW
    bmIJ2ZnMRDQKftEZY=; b=FNt3izSPLAax8j4HCxZLrv45s161A8xKRb/DeLnFYG
    3ObpnTGlPYpISrFWFh/3tUepGtDjKH9eaq8fAMcT0gjC94o2AIX4KKFxUIuQr/jn
    Af9Qps56A+kpYRfUsUvzJ5mdXZgxOAo007vHvmqA+s5LR2QU5EohILP6Q/9xlzBS
    ct23X935NQ1kKh6I8zEIhM4xQXEwZ0cjJ+G/TaqVCtqVZdDuo5StlXSTdgFTll8E
    yWDrIN3NxURq2ttKJqg/Xopq7HfGm+RXRXsvCDZW30Pq3NutJTc/V7UYO1STCBvW
    b0mGqvupOY6dJHUSDAefaNTediYXWuBWMZ8D/Yoy7vLQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1753719AbeCPRhe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:37:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33846 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbeCPP0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fe0b19af568972814355@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 11/25] netfilter: bridge: ebt_among: add missing match size checks
Date: Fri, 16 Mar 2018 16:22:58 +0100
Message-Id: <20180316152233.215761989@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit c4585a2823edf4d1326da44d1524ecbfda26bb37 upstream.

ebt_among is special, it has a dynamic match size and is exempt
from the central size checks.

Therefore it must check that the size of the match structure
provided from userspace is sane by making sure em->match_size
is at least the minimum size of the expected structure.

The module has such a check, but its only done after accessing
a structure that might be out of bounds.

tested with: ebtables -A INPUT ... \
--among-dst fe:fe:fe:fe:fe:fe
--among-dst fe:fe:fe:fe:fe:fe --among-src fe:fe:fe:fe:ff:f,fe:fe:fe:fe:fe:fb,fe:fe:fe:fe:fc:fd,fe:fe:fe:fe:fe:fd,fe:fe:fe:fe:fe:fe
--among-src fe:fe:fe:fe:ff:f,fe:fe:fe:fe:fe:fa,fe:fe:fe:fe:fe:fd,fe:fe:fe:fe:fe:fe,fe:fe:fe:fe:fe:fe

Reported-by: <syzbot+fe0b19af568972814355@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebt_among.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/net/bridge/netfilter/ebt_among.c
+++ b/net/bridge/netfilter/ebt_among.c
@@ -172,18 +172,35 @@ ebt_among_mt(const struct sk_buff *skb,
 	return true;
 }
 
+static bool poolsize_invalid(const struct ebt_mac_wormhash *w)
+{
+	return w && w->poolsize >= (INT_MAX / sizeof(struct ebt_mac_wormhash_tuple));
+}
+
 static int ebt_among_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct ebt_among_info *info = par->matchinfo;
 	const struct ebt_entry_match *em =
 		container_of(par->matchinfo, const struct ebt_entry_match, data);
-	int expected_length = sizeof(struct ebt_among_info);
+	unsigned int expected_length = sizeof(struct ebt_among_info);
 	const struct ebt_mac_wormhash *wh_dst, *wh_src;
 	int err;
 
+	if (expected_length > em->match_size)
+		return -EINVAL;
+
 	wh_dst = ebt_among_wh_dst(info);
-	wh_src = ebt_among_wh_src(info);
+	if (poolsize_invalid(wh_dst))
+		return -EINVAL;
+
 	expected_length += ebt_mac_wormhash_size(wh_dst);
+	if (expected_length > em->match_size)
+		return -EINVAL;
+
+	wh_src = ebt_among_wh_src(info);
+	if (poolsize_invalid(wh_src))
+		return -EINVAL;
+
 	expected_length += ebt_mac_wormhash_size(wh_src);
 
 	if (em->match_size != EBT_ALIGN(expected_length)) {
