Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99290C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5721B206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ty/G2Zf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfAGVTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:19:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:19:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so1948216wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMS12CBPkWEx6XPyiai2g1lZvmvWsKHmn09Bs2IQBwg=;
        b=ty/G2Zf1hDmK/MWXK2jZQ3aF6R0kFEMPIgo4Ns1sZUNiw02GL7JSJX+jnGcd8K5xbv
         rgI2BiNq0UHhAZJXko36FZPClj8LcD32EO3BNMCJtVVB5AmPrQfnLe6jjezvrxrCOw2Q
         PcHPAQ4yWa6jBZF59jo8fR4xg0FONCEr5gvIUrDU7D69NUwGrEhxSiJGhsu+rDtf7/6M
         yjIqghrADUqgFdXRNG0aFKYqK8evZqgFIPNQLemYxvBqPvKSpjksnt/zVGe2iuhY+y5M
         xeYM2qlhacoEwhcJENjXzCvpQj1+mV+8VCu2hFx2ANSL4FsZ9k3uak+eaRlLrilZrEfQ
         X2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMS12CBPkWEx6XPyiai2g1lZvmvWsKHmn09Bs2IQBwg=;
        b=k64ifBDrRrFkyz1dfLnX0ea1NJDy3UuhEDmOulGvb2nGAoPedX6sOmrzsM+Zji1CGJ
         i9jkNCJU2bxycQHOGBQDHq7JSAd2IQrS6I5LIKLxYYRPU4KBBFQ3THzl67W+FJvBvFrE
         wLMnmVTOhjXG4Tcbn1m6C3neYplce+vQU94AFX4Msaewrvu9XQDBoKMJpQ/K8ibgh2S/
         vsGfTd1nyLbUpSTRNLbXSJP5CRtgAsvechnnxkLYOI69ipsbXHwLdXiS+cocyUBKr5B/
         e5T4Gdx3Zxf543MO426hA662LdHMipsHn7jO0ijxpi1gCHA8TVMcfvqvWCquNbtxhDDc
         Urmw==
X-Gm-Message-State: AJcUukfy8F1Pg3M3SAvEkOgCMa0x2CkAD/SnSdUpww1sNndK4jUePWBs
        CpRjfMmifP9aqR211AtDRA5eE7OvOQ==
X-Google-Smtp-Source: ALg8bN68CetAWBWrNdNY1LzItWTrMvrOnATiQGGWgNY4ZEBGK8Vtxj19jiwMx3vB2tQhj0Kpqpxyvg==
X-Received: by 2002:a5d:524b:: with SMTP id p11mr50669485wrv.147.1546895945841;
        Mon, 07 Jan 2019 13:19:05 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id 133sm8550375wme.9.2019.01.07.13.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:19:05 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:19:04 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107211904.GC5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
 <20190107183444.GA5966@xps-13>
 <20190107142749.34231bb6@gandalf.local.home>
 <20190107195209.GB5966@xps-13>
 <20190107145918.407b851b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107145918.407b851b@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:59:18PM -0500, Steven Rostedt wrote:
> On Mon, 7 Jan 2019 20:52:09 +0100
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > > Ug, kretprobe calls spinlocks in the callback? I wonder if we can
> > > remove them.
> > > 
> > > I'm guessing this is a different issue than the one that this patch
> > > fixes. This sounds like we are calling kretprobe from kretprobe?
> > > 
> > > -- Steve  
> > 
> > kretprobe_trampoline()
> >   -> trampoline_handler()
> >     -> kretprobe_hash_lock()
> >       -> raw_spin_lock_irqsave()  
> > 
> > If we put a kretprobe to raw_spin_lock_irqsave() it looks like
> > kretprobe is going to call kretprobe...
> 
> Right, but we should be able to add some recursion protection to stop
> that. I have similar protection in the ftrace code.

If we assume that __raw_spin_lock/unlock*() are always inlined a
possible way to prevent this recursion could be to use directly those
functions to do locking from the kretprobe trampoline.

But I'm not sure if that's a safe assumption... if not I'll see if I can
find a better solution.

Thanks,

From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH] kprobes: prevent recursion deadlock with kretprobe and
 spinlocks

kretprobe_trampoline() is using a spinlock to protect the hash of
kretprobes. Adding a kretprobe to the spinlock functions may cause
a recursion deadlock where kretprobe is calling itself:

 kretprobe_trampoline()
   -> trampoline_handler()
     -> kretprobe_hash_lock()
       -> raw_spin_lock_irqsave()
         -> _raw_spin_lock_irqsave()
 kretprobe_trampoline from _raw_spin_lock_irqsave => DEADLOCK

 kretprobe_trampoline()
   -> trampoline_handler()
     -> recycle_rp_inst()
       -> raw_spin_lock()
         -> _raw_spin_lock()
 kretprobe_trampoline from _raw_spin_lock => DEADLOCK

Use the corresponding inlined spinlock functions to prevent this
recursion.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 kernel/kprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..b89bef5e3d80 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1154,9 +1154,9 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
 	hlist_del(&ri->hlist);
 	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
-		raw_spin_lock(&rp->lock);
+		__raw_spin_lock(&rp->lock);
 		hlist_add_head(&ri->hlist, &rp->free_instances);
-		raw_spin_unlock(&rp->lock);
+		__raw_spin_unlock(&rp->lock);
 	} else
 		/* Unregistering */
 		hlist_add_head(&ri->hlist, head);
@@ -1172,7 +1172,7 @@ __acquires(hlist_lock)
 
 	*head = &kretprobe_inst_table[hash];
 	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
+	*flags = __raw_spin_lock_irqsave(hlist_lock);
 }
 NOKPROBE_SYMBOL(kretprobe_hash_lock);
 
@@ -1193,7 +1193,7 @@ __releases(hlist_lock)
 	raw_spinlock_t *hlist_lock;
 
 	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_unlock_irqrestore(hlist_lock, *flags);
+	__raw_spin_unlock_irqrestore(hlist_lock, *flags);
 }
 NOKPROBE_SYMBOL(kretprobe_hash_unlock);
 
-- 
2.17.1

