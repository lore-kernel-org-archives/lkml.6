Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837708-2-402522960373641263
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
    t=1519837707; b=vceC2yVu8LJPVHiWebE2pdtkQaePwCXCpf8WR35yHmVp4/o
    tdk3ruWfVr9edyz46IkVPSEsLIS9ufQjhiF81Www5wiwFk26IHS96IEy2fKjR/DV
    E0RaT8UR4nYRdfYYHl5FFqT9bl/80UIHJsTdwHXGRqooo80NIt/gwEJdGZOhbRzA
    5YZd+4itH0wCQafMWWShh06L1rn9SwKrhg8hHFVSzZnlC23cQxKaiSvP69RRy+99
    y5iWStl0quIzfJ4KHpRTjVlDWFY/DRRke1+5fHmzVzF2isSZvePkrbGYUHWWZgVz
    EIq5TpGgnOCzxgM08tdLvbUmiN0SmlJg+P+TkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837707; bh=w59as75eFbcg758CELm
    HBnWyPqZ6o1CxK6fFl8F/35E=; b=vdHn3soD/cIGAZfV9fzu0xUfT3Hn48Pzg6o
    iENa1/bLw0nsbghOFpnudC/s60RLoNCgZjzb9zO0IM7ZLqDqRbRF+sWi3zQSAoFB
    ERR5PxR94I2jj40SqX7ATx2lkxlNNDMjDd9MLObGghPEuFRARSMu4Md2hdZVSgSB
    vJbXS1EK69sDc8w1lGjY6r5X0BE5E6sulAO0FjIovNQU73o4Libq60ZzKTsOxLfk
    pSJUo/AClPQC++FnlXwVpNIEZ3wxk+SH+6GGkZjiYm8zbu/1DrlvQxhTN0GQT5Wx
    fal8nScZ6fhT/Iz9FYYAgXREkVautVAw8870N2akeSS6e01FkZw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932884AbeB1RIY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:08:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34300 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933632AbeB1PuE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:50:04 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.733264036@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 229/254] dccp: don't restart ccid2_hc_tx_rto_expire()
 if sk in closed state
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

From: Alexey Kodanev <alexey.kodanev@oracle.com>

commit dd5684ecae3bd8e44b644f50e2c12c7e57fdfef5 upstream.

ccid2_hc_tx_rto_expire() timer callback always restarts the timer
again and can run indefinitely (unless it is stopped outside), and after
commit 120e9dabaf55 ("dccp: defer ccid_hc_tx_delete() at dismantle time"),
which moved ccid_hc_tx_delete() (also includes sk_stop_timer()) from
dccp_destroy_sock() to sk_destruct(), this started to happen quite often.
The timer prevents releasing the socket, as a result, sk_destruct() won't
be called.

Found with LTP/dccp_ipsec tests running on the bonding device,
which later couldn't be unloaded after the tests were completed:

  unregister_netdevice: waiting for bond0 to become free. Usage count = 148

Fixes: 2a91aa396739 ("[DCCP] CCID2: Initial CCID2 (TCP-Like) implementation")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/dccp/ccids/ccid2.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/dccp/ccids/ccid2.c
+++ b/net/dccp/ccids/ccid2.c
@@ -140,6 +140,9 @@ static void ccid2_hc_tx_rto_expire(unsig
 
 	ccid2_pr_debug("RTO_EXPIRE\n");
 
+	if (sk->sk_state == DCCP_CLOSED)
+		goto out;
+
 	/* back-off timer */
 	hc->tx_rto <<= 1;
 	if (hc->tx_rto > DCCP_RTO_MAX)
