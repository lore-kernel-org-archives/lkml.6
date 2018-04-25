Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585385-1524656142-2-7377102677005763233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656141; b=gmQayA4MfmR/3VJmqD1y7MtlXFz00cSq6F8L2dRzQgs8piUSn4
    IkoAy/UGzMKwgc0BGvCmDYbjx2di9UdsqSoMBxjg1Rr+jHA/AnHa9dtlPH/CVKLq
    jrWr1wBK5lUmV5KUlMYNOKLnaOzr9wNoruP8SrR7J8lMv+baJ9MLqP6GksZbki+z
    Vbnq4bFDeG3qWE2+kqcGoy4ugIEmm3OmbvoWt7bqiOb/QSmQYZaM4cNeGk7Pz+Rm
    23SgaCCMAtJNc8HqAWfUaKtg2uT/R6TWgaAdtEe0/uXqxHOrgBEzN/qcv1PSmyyr
    21eaftRleQ0AMOvxP5GEeFpEO+GM3YcpUOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656141; bh=Dc66OEUFANV54DJ7VRMiM3LlkErSg1
    ZPocDFbgLVvDE=; b=c7AxlTSfdEjshYGHKYwkSazsdRBSzh+Z2d+/STvk2eVcXb
    pYDeW5wecUuR5TdwIguOLbQdVbEvaUas/LfmhFaNiWGlwqa+fHh6kJO5M1ZR3RHy
    uIbX659AwaFPDh+RQQ5YY8h7gt5vi2VK9ZZKBDDQKNoLOvIBte1kcRSofh/e/8lM
    sDpLiDa3V+t6RWQGheKXczgz/4uncgmX3qVehva61WYyLXP33CLZ4NW2bx6VVi4m
    7p82bJ5Bl04e9/kBXeIM+POIGk6piBZaeBUgkM+mad9ynegtUn6xzwKk02AFsGIj
    59lCfo0hrCZETHOMFuUTHvUs9Xw9W2a53Us4LjJw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLkiFb17R/VpoO3vi1IAWrzvmfYuJvjBrp8zcg+qB1AinxQT0knWgdmbsWYZ1vmNI80Z7EH3kvwWLK1PTCKJ9WpLGMdYAA330/28GSrZVJD+cjNyUoxX
    YlGhAGPzjnv3pMkb4aNIZS7ryUd68z+TvduW7uxT7G5z/TAznCjT2KJ/i+91NCecEvslRLvhggVsGclge5iHyeCuc/THEC6pNoOaTJjqZxoKKFruMJzY2FO5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8
    a=ag1SF4gXAAAA:8 a=xcokqVkme5SxmkZ8enEA:9 a=AFzycvFG4FK61pKk:21
    a=dftMQ5WIG4TQjFO3:21 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
    a=cQPPKAXgyycSBL8etih5:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeDYLfY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:35:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbeDYKeN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 4.16 17/26] mm,vmscan: Allow preallocating memory for register_shrinker().
Date: Wed, 25 Apr 2018 12:33:26 +0200
Message-Id: <20180425103315.536235852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 8e04944f0ea8b838399049bdcda920ab36ae3b04 upstream.

syzbot is catching so many bugs triggered by commit 9ee332d99e4d5a97
("sget(): handle failures of register_shrinker()"). That commit expected
that calling kill_sb() from deactivate_locked_super() without successful
fill_super() is safe, but the reality was different; some callers assign
attributes which are needed for kill_sb() after sget() succeeds.

For example, [1] is a report where sb->s_mode (which seems to be either
FMODE_READ | FMODE_EXCL | FMODE_WRITE or FMODE_READ | FMODE_EXCL) is not
assigned unless sget() succeeds. But it does not worth complicate sget()
so that register_shrinker() failure path can safely call
kill_block_super() via kill_sb(). Making alloc_super() fail if memory
allocation for register_shrinker() failed is much simpler. Let's avoid
calling deactivate_locked_super() from sget_userns() by preallocating
memory for the shrinker and making register_shrinker() in sget_userns()
never fail.

[1] https://syzkaller.appspot.com/bug?id=588996a25a2587be2e3a54e8646728fb9cae44e7

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/super.c               |    9 ++++-----
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   21 ++++++++++++++++++++-
 3 files changed, 29 insertions(+), 8 deletions(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -166,6 +166,7 @@ static void destroy_unused_super(struct
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
+	free_prealloced_shrinker(&s->s_shrink);
 	/* no delays needed */
 	destroy_super_work(&s->destroy_work);
 }
@@ -251,6 +252,8 @@ static struct super_block *alloc_super(s
 	s->s_shrink.count_objects = super_cache_count;
 	s->s_shrink.batch = 1024;
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
+	if (prealloc_shrinker(&s->s_shrink))
+		goto fail;
 	return s;
 
 fail:
@@ -517,11 +520,7 @@ retry:
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	err = register_shrinker(&s->s_shrink);
-	if (err) {
-		deactivate_locked_super(s);
-		s = ERR_PTR(err);
-	}
+	register_shrinker_prepared(&s->s_shrink);
 	return s;
 }
 
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -75,6 +75,9 @@ struct shrinker {
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
 
-extern int register_shrinker(struct shrinker *);
-extern void unregister_shrinker(struct shrinker *);
+extern int prealloc_shrinker(struct shrinker *shrinker);
+extern void register_shrinker_prepared(struct shrinker *shrinker);
+extern int register_shrinker(struct shrinker *shrinker);
+extern void unregister_shrinker(struct shrinker *shrinker);
+extern void free_prealloced_shrinker(struct shrinker *shrinker);
 #endif
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -258,7 +258,7 @@ unsigned long lruvec_lru_size(struct lru
 /*
  * Add a shrinker callback to be called from the vm.
  */
-int register_shrinker(struct shrinker *shrinker)
+int prealloc_shrinker(struct shrinker *shrinker)
 {
 	size_t size = sizeof(*shrinker->nr_deferred);
 
@@ -268,10 +268,29 @@ int register_shrinker(struct shrinker *s
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+	return 0;
+}
+
+void free_prealloced_shrinker(struct shrinker *shrinker)
+{
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+}
 
+void register_shrinker_prepared(struct shrinker *shrinker)
+{
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
 	up_write(&shrinker_rwsem);
+}
+
+int register_shrinker(struct shrinker *shrinker)
+{
+	int err = prealloc_shrinker(shrinker);
+
+	if (err)
+		return err;
+	register_shrinker_prepared(shrinker);
 	return 0;
 }
 EXPORT_SYMBOL(register_shrinker);
