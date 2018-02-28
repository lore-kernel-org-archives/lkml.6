Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837083-2-15169825328343197258
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
    t=1519837083; b=ZkjkOOFo0wLScuoHKvuVPsrqZ/ccMon/khSzzDwIAHmmNn7
    sdeGuLMKidxncTUsE+appDOTF8axcTt8mTo3TCcGYIr6YpIPYICgSlYR96a2nA66
    NfJju3CcU2qJmGhKKiA4DbQspRXJkmO18fQlBh3x1pJc4N2nbqNyZspD7FUOI06N
    ys3gc//4C4ZdFpkPovvDu3JUu6+KRAPxnkiTp3+PDtE+dtYJsPhh4NRGGKhYY2hP
    B/004k0Vua7TERLBAFpmJCtkfPyJd7blanP1Q6L+h84jTUEX3rQLOiF+OJI/Hcsz
    pyZenmp6f8pYGwy3xbwh8Tz0wXDXKXmSWMxvknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837083; bh=gH6t8KVYdteVhS+25pL
    8sOeXR80nnYDEELE5VfXlSls=; b=BqWsjNDQKDnrj7PNEe+vlORWUURBmg357az
    /m8s8Zv9If/bIzCm1rmUIABvgInY8m+ZKdt18ZgC+iLIhifaQhm10fz2Qgo156zm
    3XxkPoP0SBd8lH0wVg78P8exM7DDAxUvLbMCYqi00fWyKkVrNMmBw8zgOLkbcDSZ
    0LFUYBgW30pXwC2jtyDbwn6FyShwq6mwQkyLka6ENjid44c+fBSlzN/Foehg8apR
    DFW2WNjjNaU7B4rPzl1f0H7wSYGxEogg/PYkNDASj4zvs16M4yHZQz2Gg/tuoMMu
    pcjFs5OcaA18G0oedmcDEn8ouxJEJffac/CY+irT6dhyMmVlVgQ==
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
        id S933927AbeB1Pw7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34423 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1Pw5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mohamed Ghannam" <simo.ghannam@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.973234790@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 088/254] net: ipv4: fix for a race condition in
 raw_sendmsg
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

From: Mohamed Ghannam <simo.ghannam@gmail.com>

commit 8f659a03a0ba9289b9aeb9b4470e6fb263d6f483 upstream.

inet->hdrincl is racy, and could lead to uninitialized stack pointer
usage, so its value should be read only once.

Fixes: c008ba5bdc9f ("ipv4: Avoid reading user iov twice after raw_probe_proto_opt")
Signed-off-by: Mohamed Ghannam <simo.ghannam@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/raw.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -490,11 +490,16 @@ static int raw_sendmsg(struct kiocb *ioc
 	int err;
 	struct ip_options_data opt_copy;
 	struct raw_frag_vec rfv;
+	int hdrincl;
 
 	err = -EMSGSIZE;
 	if (len > 0xFFFF)
 		goto out;
 
+	/* hdrincl should be READ_ONCE(inet->hdrincl)
+	 * but READ_ONCE() doesn't work with bit fields
+	 */
+	hdrincl = inet->hdrincl;
 	/*
 	 *	Check the flags.
 	 */
@@ -569,7 +574,7 @@ static int raw_sendmsg(struct kiocb *ioc
 		/* Linux does not mangle headers on raw sockets,
 		 * so that IP options + IP_HDRINCL is non-sense.
 		 */
-		if (inet->hdrincl)
+		if (hdrincl)
 			goto done;
 		if (ipc.opt->opt.srr) {
 			if (!daddr)
@@ -591,12 +596,12 @@ static int raw_sendmsg(struct kiocb *ioc
 
 	flowi4_init_output(&fl4, ipc.oif, sk->sk_mark, tos,
 			   RT_SCOPE_UNIVERSE,
-			   inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol,
+			   hdrincl ? IPPROTO_RAW : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
-			    (inet->hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
+			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0);
 
-	if (!inet->hdrincl) {
+	if (!hdrincl) {
 		rfv.iov = msg->msg_iov;
 		rfv.hlen = 0;
 
@@ -621,7 +626,7 @@ static int raw_sendmsg(struct kiocb *ioc
 		goto do_confirm;
 back_from_confirm:
 
-	if (inet->hdrincl)
+	if (hdrincl)
 		err = raw_send_hdrinc(sk, &fl4, msg->msg_iov, len,
 				      &rt, msg->msg_flags);
 
