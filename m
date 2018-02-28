Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832507-2-18393299843955922140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832506; b=kKbXOAWpRQRQaZGjZT+h4k44AArcGJuMDzkFg9fPLxfTcjR
    fnnFr1w7CHTSP3gDVKKPz5Yd78b0izm6kWDPR3URjLMgtGDGmgyUQCO6fio/bUVK
    kzW9R7bQPBEWXxaBbs712NjG42r1HZagzdnCeVv7r2at6hy4l6N1BJXPt9iHxmRO
    21GAnmhBe6KjcoXYrUQhQDfDe2YP2KcBYuvhqEJNk7KAvOtL6V/k19VqyE+LSH8o
    EmThHVfHTLanD7HjDgrf0DeHOJlKgkHFvWKKjaHBBTQDefuez5hUTISK+RTEzGzd
    OJsrbTV5UmKjcPQDbBIB+H/jWQ3vpxvr6KwC2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832506; bh=yRUjyC3i5FrkWqibtuf
    Jo0ZIuV0wW1VBssFC4Ju2pp8=; b=GVcfUbSjBsHmiUsgtx1aQXKJaat74Wu6AGU
    3YClzoNFmsCT19ZxlA5CToOZSnwAl/stbv4sV3OJjJIx3pKfPz+yzo1kZI2Jm8hz
    ifzd8bAJnkpYir9uKVCX+xkC8p5vVTKGJXAaYZjFKLkLOrJcnVS3ZDW1WduFAQl1
    RfzlPkEMq6Bl0apQGBoKNLEV6HRg9NGA0IVizqEHpo7F2aD0hJfsrnY3lEDrKRrU
    2H7PFly5iNn+rfkSw8jZO8qS03ZzPpR/Sj9tlfN8BwKMQj2jMg3+1CJpZln1bA/N
    5afVSZxEQhMfDBEqDwksSLi4c512w7AvkDy+3o/toRxc5AyDTGA==
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
        id S932691AbeB1PjA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:39:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33229 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752671AbeB1PWc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:32 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jan Kara" <jack@suse.com>,
        "Jan Kara" <jack@suse.cz>, "Michal Hocko" <mhocko@suse.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.765600330@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 035/254] quota: Check for register_shrinker() failure.
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 88bc0ede8d35edc969350852894dc864a2dc1859 upstream.

register_shrinker() might return -ENOMEM error since Linux 3.12.
Call panic() as with other failure checks in this function if
register_shrinker() failed.

Fixes: 1d3d4437eae1 ("vmscan: per-node deferred work")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jan Kara <jack@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/quota/dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2747,7 +2747,8 @@ static int __init dquot_init(void)
 	printk("Dquot-cache hash table entries: %ld (order %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
-	register_shrinker(&dqcache_shrinker);
+	if (register_shrinker(&dqcache_shrinker))
+		panic("Cannot register dquot shrinker");
 
 	return 0;
 }
