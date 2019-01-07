Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E19A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUgOiymF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfAGSWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:22:39 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:32992 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfAGSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:22:39 -0500
Received: by mail-qt1-f202.google.com with SMTP id k90so1082329qte.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=55NTT07eRl9Jvbq7bt8GJTcM7OZDvoqCukvddKO2pJA=;
        b=XUgOiymFTCfp+ZEx13K79sevEb6Hbt3YH//NFvV3cfURyVwwj0rf52anrcQfcF3GuN
         grXbEdQydgvYJ4UPdDndyh94uWS4DZLAkKzgy10FcOrpvN/0siRRXMnbZVjyD7RvNzm4
         qrXGbHgsW/x3ir6rtCXDhLTBgbtvxYnir0EAF7qnbLSLxUk4hlt7uYgUR+m5fv7pD8Lg
         BoSuSMYxSGUhKDjM/hLAotPRF2Cv4YyLTf7G7/bPDjZ8m8u73O2IicePdUqnUuXvw2QQ
         NzWA0thjkUHrknwhiqp1+I3GgQyUIWn1N/PwBYd+ErCEiKgjJ61Vr6BgZIuaOW1NM5a/
         cAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=55NTT07eRl9Jvbq7bt8GJTcM7OZDvoqCukvddKO2pJA=;
        b=nft8vmDnVvd82e4/qQbb1E92WUmZVU83rn4Bps3919cS4Lt3fNTy6sd3JanRk+w6Cq
         wPkrjlfqsnZgR4unuzy0alZtbcX28Ji29KbA4rBpofDQOCWf2FW+tpZT6hz2TczuB6vT
         YIcZNlY83BR9H2PH9JrKyA2A6/AUo2jcPeli9UmePAilzGdClQfTtxlh0e/ywmRZTu3B
         Xh34US5MS/d5bWzpeZpXE+RezhrNfN6nfw/TiR1Vl2dtNf4FDxJNCWzE6Ssniqh11IoS
         DNh//iQJSa/Ykm7TeYJNzRwty+DjVh4bT6yEc/SXSplnvoa1JGU1JwhYHx+vVnCUYrOx
         LKdw==
X-Gm-Message-State: AJcUukdjEM76ddC8hRitPFTvIe+nv6yM9rMRUgLoBTF8foUQMLWVbVbV
        F698N1+x2jgqF007p+RICFCbBO/yWDEXOw==
X-Google-Smtp-Source: ALg8bN4Ib7+OzXC1PLHWyRokeA/f8GM15hq2rCHfJRTxMVbfdFiaNVaSwvfV43LR3GEqnWavfIm7jOBawnbixw==
X-Received: by 2002:ac8:7244:: with SMTP id l4mr1476652qtp.21.1546885357814;
 Mon, 07 Jan 2019 10:22:37 -0800 (PST)
Date:   Mon,  7 Jan 2019 10:22:24 -0800
In-Reply-To: <ef0fe093-6fae-6c54-024b-fdec9c056af3@colorfullife.com>
Message-Id: <20190107182224.32380-1-shakeelb@google.com>
Mime-Version: 1.0
References: <ef0fe093-6fae-6c54-024b-fdec9c056af3@colorfullife.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: Re: general protection fault in put_pid
From:   Shakeel Butt <shakeelb@google.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jan 7, 2019 at 10:04 AM Manfred Spraul
<manfred@colorfullife.com> wrote:
>
> On 1/3/19 11:18 PM, Shakeel Butt wrote:
> > Hi Manfred,
> >
> > On Sun, Dec 23, 2018 at 4:26 AM Manfred Spraul
> > <manfred@colorfullife.com> wrote:
> >> Hello Dmitry,
> >>
> >> On 12/23/18 10:57 AM, Dmitry Vyukov wrote:
> >>> I can reproduce this infinite memory consumption with the C
> >>> program:
> >>> https://gist.githubusercontent.com/dvyukov/03ec54b3429ade16fa07bf8b2379aff3/raw/ae4f654e279810de2505e8fa41b73dc1d77778e6/gistfile1.txt
> >>>
> >>> But this is working as intended, right? It just creates infinite
> >>> number of large semaphore sets, which reasonably consumes infinite
> >>> amount of memory.
> >>> Except that it also violates the memcg bound and a process can
> >>> have
> >>> effectively unlimited amount of such "drum memory" in semaphores.
> >> Yes, this is as intended:
> >>
> >> If you call semget(), then you can use memory, up to the limits in
> >> /proc/sys/kernel/sem.
> >>
> >> Memcg is not taken into account, an admin must set
> >> /proc/sys/kernel/sem.
> >>
> >> The default are "infinite amount of memory allowed", as this is the
> >> most
> >> sane default: We had a logic that tried to autotune (i.e.: a new
> >> namespace "inherits" a fraction of the parent namespaces memory
> >> limits),
> >> but this we more or less always wrong.
> >>
> >>
> > What's the disadvantage of setting the limits in
> > /proc/sys/kernel/sem
> > high and let the task's memcg limits the number of semaphore a
> > process
> > can create? Please note that the memory underlying shmget and msgget
> > is already accounted to memcg.
>
> Nothing, it it just a question of implementing it.
>

I think it should be something like following:

---
 ipc/sem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 745dc6187e84..ad63df2658aa 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -494,7 +494,7 @@ static struct sem_array *sem_alloc(size_t nsems)
 		return NULL;
 
 	size = sizeof(*sma) + nsems * sizeof(sma->sems[0]);
-	sma = kvmalloc(size, GFP_KERNEL);
+	sma = kvmalloc(size, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!sma))
 		return NULL;
 
@@ -1897,7 +1897,8 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	rcu_read_unlock();
 
 	/* step 2: allocate new undo structure */
-	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
+		      GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1.97.g81188d93c3-goog

