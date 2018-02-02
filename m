Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590889-2-16626787919481566060
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
    t=1517590888; b=NzQ2QADLTqr9lTWpYUsK7W5+r29qfVTWP3QLEp+SSdLu0+6
    wxVXRTm+EI0EhXtfTeH0JVZHDiKE5kTD9nMebta5/+JbTxo1+4wMUmaigEr64Xtt
    0VAF6qxYAnxMsp9zBKm0J6L0RjUprMKjyMel9cCnCxvTbTZBJVA6DfRw6SDUS2PO
    MC9L0t/s4seJ+arq0pOCvGdPD9xxxWqZKuEwd1NmnY0pjrGDfTpqO747RvyNuY8N
    H/hdmHAOj4AVvvz81QLuCAHQi+sn67iJ0bJc8hpzpTHArBubxTo4FOhWSAadISgz
    +VflcEQt05gjzCE3hj3yL2CgBNzTk1hfDh/Vveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590888; bh=ctuDBGJFdUSplFo0IWwrswZMVf
    eHpENGeXRctpCAN9U=; b=pbG+HNzJ+jZRYtufd0qNGxJRjyISECIrmGtwTb5721
    ar/Z4C1iT6oPhkca1ujueCYhx1P7sne3mC87SFBMYD4EpoOhNIJfJ+sIvvZ/NoG/
    Lldmc0aE60fLteqmXwLSbcIWk2t2wqVutGYInGlPjeItSvclngFmvJiVVBmMvfXn
    XhN3BHRYY7qDL2ggsqtkMeQV3BoqBYpVXZuUVvSDsZCN+hzuW4LaOkgDEKY7E3dY
    S3ZHL/ZTfoSXZTMYoS+6Xu05efu1lbdc/mbFO6Q9N4CutsLWiqNuy6mtB8IiAj5I
    OgcrB11sxQO1RTD08FSQ0Hz3nXrxfltL4weuZFybDIBQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeBBRBZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:01:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbeBBRBV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:01:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.com>, Michal Hocko <mhocko@suse.com>,
        Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 45/67] quota: Check for register_shrinker() failure.
Date: Fri,  2 Feb 2018 17:58:14 +0100
Message-Id: <20180202140820.392100764@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>


[ Upstream commit 88bc0ede8d35edc969350852894dc864a2dc1859 ]

register_shrinker() might return -ENOMEM error since Linux 3.12.
Call panic() as with other failure checks in this function if
register_shrinker() failed.

Fixes: 1d3d4437eae1 ("vmscan: per-node deferred work")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jan Kara <jack@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/quota/dquot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2919,7 +2919,8 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	register_shrinker(&dqcache_shrinker);
+	if (register_shrinker(&dqcache_shrinker))
+		panic("Cannot register dquot shrinker");
 
 	return 0;
 }
