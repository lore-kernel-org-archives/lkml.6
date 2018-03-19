Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483517-2-18125420543796237114
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
    t=1521483516; b=n6dTlPl/UJ11PBFnwiCmB74PC48rByizUih/ZBOj4ecVftD
    Yh/tw+lw01Dr7HXa9rN19llW5mF7c9jUvRrD8qFUHvhEnGPGm9yEjIlKYSJu9td7
    zl95QaAcOHw0cjVutDJqRY+csxhP0HzhPe7530tu672nZRzPF1Mpg+w2ig7rsOU3
    AKgq3dsP3zffzcrxBw0rzdSEyUDecj3i8/Z067Wt5agWJ9D9N0sRLmaAtlyyoTWV
    J+YZQ/T9r+zAZgxn+yvnAW9RdkZiXX+wvAvHTTDeMwB3SIRaogqaRiUomFwhhXV7
    Mctn8abtijyIcThhAgT4x2Z5lZvKwA9qH9nTc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483516; bh=ibo9FSzP0zjriPpuw766kePLVM
    awMBjIIIA1hCnfRJo=; b=SklKVEyYO8F4RImdRoFVCpmBKJWKUXsHD8DipwY69U
    vqmekSUfBlnhg57shiL3zsRhyTMqoxEwjD95OjwuKKZUmsqCHNBu4TwFMsRwz9bO
    jJJrCJAwHk42fYruq/vjVpwajS0FooTXo1vlzGXQamP4lQ/1ojHb9kqFs9A96FD5
    +UGIoT126sfbi0JJsV84SyJf6o9A5fmAZU+ljAa9RZPUVhgy577gGMZQcJ7x9X9k
    S06R9QdA11WWn09DCrZsMV99am+5Tk68Gl2/Y80qQftPw5TOO0fCi7MuFXngO0/l
    /aZJt92oMVtJz3htiOSbYTalQdqF+bbW7PiY5U7+mZAQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvfeehjeenucevlhhushhtvghrufhiiigvpeelge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvfeehjeenucevlhhushhtvghrufhiiigvpeelge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968946AbeCSSSN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:18:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969276AbeCSSSM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:18:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Jens Axboe <axboe@fb.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 001/241] blkcg: fix double free of new_blkg in blkcg_init_queue
Date: Mon, 19 Mar 2018 19:04:26 +0100
Message-Id: <20180319180751.230597698@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

commit 9b54d816e00425c3a517514e0d677bb3cec49258 upstream.

If blkg_create fails, new_blkg passed as an argument will
be freed by blkg_create, so there is no need to free it again.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-cgroup.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1078,10 +1078,8 @@ int blkcg_init_queue(struct request_queu
 	if (preloaded)
 		radix_tree_preload_end();
 
-	if (IS_ERR(blkg)) {
-		blkg_free(new_blkg);
+	if (IS_ERR(blkg))
 		return PTR_ERR(blkg);
-	}
 
 	q->root_blkg = blkg;
 	q->root_rl.blkg = blkg;
