Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839074-2-18143420624820769027
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
    t=1519839074; b=Y4mX79uvGDWNQ6TOxjWLjDG+5cZdEB1cf6GwIUPIe32yr4S
    D5mdw5OLjfoWl3Z9iFd8LxsTV+UQB1CTuN1YrEbfi9dGw9oAT4PRpmRco+83AoTx
    GdQHLewmygZUZVua5/v0pqX7tvzIKjpDMCEw8VUHBXoOhbd5xsiGvIXmTFxj8Ygv
    qTWppuHIsGP45LVVca/FnixLAZSNXUHzt3jgwPg2EwFgcl27w8sKAupZUkwRj5Pc
    45/eB1qKZKsuJUcYe3Vsc7eYCXhU906j1AAc31kM9fRIV+37LqZ8N14kGJMp9vZ/
    JfxOChVeGm2qDTuuo9B0w66OCvqku4z1oKnF0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839074; bh=P+cihqRNUiPFaSndkBK
    oAWM5hqEJGD4DTSxg8J7ky7M=; b=QtsK+QNUIwoFYI5U86yQ19z7Mtx3ItYMDQD
    1Z+NyTdaNMfBlNv9NOxazo/zGUfUhzA5WhOYnLQadKzENrTt9RMzdDdw+nZGbJTh
    Ilv8ydj9+eMZPnUCcdO+4LiEJOqBvBM8weL0ErRg8dMiDhdQyT3jxSRq44IVZZOv
    S33+jevGvdKrjfk5+70qGU4cbUKkd1J+HMohhPjgW5A8qLO/ChMKDKCh4wflk1Gb
    hOGX6QP+HMMJo7QhC6UlPAA+aDIKgYtt6rKs5ZaTyxpz35iwbGXZNI892gkkXBPs
    awhrpbBTRnHQjb2ydiQb8c5WkTYaX2Jk1IbVoCfmDwSW+pLokBg==
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
        id S932595AbeB1R3H (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:29:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33237 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932591AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+7b7b518b1228d2743963@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        "Neil Horman" <nhorman@tuxdriver.com>,
        "Xin Long" <lucien.xin@gmail.com>,
        "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.767410606@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 102/140] sctp: do not allow the v4 socket to bind a
 v4mapped v6 address
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit c5006b8aa74599ce19104b31d322d2ea9ff887cc upstream.

The check in sctp_sockaddr_af is not robust enough to forbid binding a
v4mapped v6 addr on a v4 socket.

The worse thing is that v4 socket's bind_verify would not convert this
v4mapped v6 addr to a v4 addr. syzbot even reported a crash as the v4
socket bound a v6 addr.

This patch is to fix it by doing the common sa.sa_family check first,
then AF_INET check for v4mapped v6 addrs.

Fixes: 7dab83de50c7 ("sctp: Support ipv6only AF_INET6 sockets.")
Reported-by: syzbot+7b7b518b1228d2743963@syzkaller.appspotmail.com
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/socket.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -314,16 +314,14 @@ static struct sctp_af *sctp_sockaddr_af(
 	if (len < sizeof (struct sockaddr))
 		return NULL;
 
+	if (!opt->pf->af_supported(addr->sa.sa_family, opt))
+		return NULL;
+
 	/* V4 mapped address are really of AF_INET family */
 	if (addr->sa.sa_family == AF_INET6 &&
-	    ipv6_addr_v4mapped(&addr->v6.sin6_addr)) {
-		if (!opt->pf->af_supported(AF_INET, opt))
-			return NULL;
-	} else {
-		/* Does this PF support this AF? */
-		if (!opt->pf->af_supported(addr->sa.sa_family, opt))
-			return NULL;
-	}
+	    ipv6_addr_v4mapped(&addr->v6.sin6_addr) &&
+	    !opt->pf->af_supported(AF_INET, opt))
+		return NULL;
 
 	/* If we get this far, af is valid. */
 	af = sctp_get_af_specific(addr->sa.sa_family);
