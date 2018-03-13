Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955268-2-1509054622563059195
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
    t=1520955268; b=cAAK5rfZ7SQcSfvvnStR1kIFy8gkF7opJ8FHkSAxgYWyKGJ
    JYV/B1WdSYhiseHLTmLIL8HYWTXrpV7B/YpNJyDvirIJXKF1n1lrnh8ZSh+FdVnb
    98gWcRmcTvBvx9dj+6ukpuy44eueTxerl6Mvm/AV0KTzrB6L+ELu/krGqG8yHR6s
    zctP9+OOb5bxr3pNvAAvHlHwa/ZL8x84K36JTtSmMer5y0uLZ1T8hymoGj/nIXGI
    P01/Y5GfCfj+K6NMi7E1ITEHWnAnBTHHgD5HeyjHk+Zmrj+PaA2J+b8zsO/icmna
    dVkwLk5Q4popyZaCfM2G1S+GMWJHVGCFIvWmpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955268; bh=EaZpJmyCq+HMbushBmTIzZuP/F
    hEfU+7QHIfI3wiJ2c=; b=QkMNunOgYfOdKqSZ4zN5iHrvqM+0NYEpAQFu2O/b/N
    W+9FzfUROscr011/E5KAQSm2DQOHUP7IXB8w1TMgnpmeepq0M9rmhIMoxDlyIuHB
    lEyJOkdSkRuVQQSrKP5AdQVI52IBJspJ1jZvahFWjzK451IUR1wS/zOwsmflX9k9
    kokdNAPGZseenUc3z3C1heHxpA7Z/rrXBXLrlo7lqu8KzW7sW4oSlsqXzhjP+ZT7
    m7Swh5ab6RON44qP00bRdVc3UU/fdbGEm14BC8TKEI7QXtw1rsOnMlLm0hx68A/K
    EqB73yUYP4rzEe29PFBihtTSxqO0CN2Nmtek41eeaBOQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S933753AbeCMPeX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:34:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933751AbeCMPeV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:34:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.15 144/146] NFS: Fix an incorrect type in struct nfs_direct_req
Date: Tue, 13 Mar 2018 16:25:11 +0100
Message-Id: <20180313152331.207311961@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit d9ee65539d3eabd9ade46cca1780e3309ad0f907 upstream.

The start offset needs to be of type loff_t.

Fixed: 5fadeb47dcc5c ("nfs: count DIO good bytes correctly with mirroring")
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/direct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -86,10 +86,10 @@ struct nfs_direct_req {
 	struct nfs_direct_mirror mirrors[NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX];
 	int			mirror_count;
 
+	loff_t			io_start;	/* Start offset for I/O */
 	ssize_t			count,		/* bytes actually processed */
 				max_count,	/* max expected count */
 				bytes_left,	/* bytes left to be sent */
-				io_start,	/* start of IO */
 				error;		/* any reported error */
 	struct completion	completion;	/* wait for i/o completion */
 
