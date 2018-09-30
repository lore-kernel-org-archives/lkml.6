Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC5C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211C2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeGhexD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E211C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeI3PtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 11:49:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44461 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeI3PtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 11:49:09 -0400
Received: by mail-yw1-f67.google.com with SMTP id s73-v6so4337602ywg.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h95nOSNIzamxLqicNjepKtBqkbtKzyPN4REvdazTE48=;
        b=EeGhexD2o/srBykbrd8+BvWj/7ZqddZQKQLWBk0xP0uVFcdHVggvFNpTeDyYa2KGHP
         nUBj7o4ne8iHA5WrEXuUlOOjddETG6buJhwtCj5bLS3DAweQ3ywGwY2/jB83/YvviC6T
         fTL3JKxn68Za83Mt6MvBWkoXwKgK/jjxHbCjSkohJ4hhWWDEHGe4FpCg4DMjcSBLK+ch
         E1cLmvLPGmnGIHj9n3Uh6UCrjcUDTNgBzsW7y4HEyEqbTVcoac1gsnJMVI+oVXSsuul2
         oO4OW14wGGCFMcOA8ht9q+FSgs2swXjLjJVbZa9iWtMssNZTa6aV2Z5g4+aBh0jl3yOe
         Kx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h95nOSNIzamxLqicNjepKtBqkbtKzyPN4REvdazTE48=;
        b=QHE6tqLbLAouwFuc0zIOR7BxLUuluIsBb50H1KTRsApPYb0XwqAyCfdiGi1wRJWinI
         ow5tvpNadfPXiEjgOS/YUAuv9m0oXDZ12Q3723hzrw4P2y6Pw4KWy54OKtWpqmZfaU8Y
         nL3eZ/AFqGu/Y2MwDwcLD5u61k0FLe6xZRnMgU5kgrPMR2uT80Z1f0Th0dYptKz5dQar
         Hm63lpf/pzajYmp9ekj8RDWdg30eGfKL+fV6OHvO38GTpU+ZGOEbvLl+CpnkDaWVqOnH
         AhamEy+OaGI9sIYVF3u1ZhgJtjsaczfIAlQDla62BetXnldmaC//wOd/Kmq/bfK4jtPG
         nuoA==
X-Gm-Message-State: ABuFfog1/rX28cmyvyptV0SyHC6wzdM+gwgLRHo1KPonN88FDzN6/6lb
        hd1nJXlgJO/mBSvFIzJ91HI6gN9EYaaR2Mpw0nA=
X-Google-Smtp-Source: ACcGV62PprZKx6pkNxpjBowWI8B5fRZS4ETFT/S5bH2iMcmAG78YWGuSJByyueUGuOGAV5gT00TACbDwKNCv3uafUbE=
X-Received: by 2002:a81:ae4e:: with SMTP id g14-v6mr3089590ywk.248.1538299017013;
 Sun, 30 Sep 2018 02:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180930065100.GL15893@shao2-debian> <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 30 Sep 2018 12:16:45 +0300
Message-ID: <CAOQ4uxgqBgYiGpf_6zrZk=L2bAQsujzcFE0ZzUXFHu8AnHSk7g@mail.gmail.com>
Subject: Re: [LKP] [fsnotify] 60f7ed8c7c: will-it-scale.per_thread_ops -5.9% regression
To:     rong.a.chen@intel.com
Cc:     Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 12:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Sep 30, 2018 at 9:50 AM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed a -5.9% regression of will-it-scale.per_thread_ops due to commit:
> >
> >
> > commit: 60f7ed8c7c4d06aeda448c6da74621552ee739aa ("fsnotify: send path type events to group with super block marks")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: will-it-scale
> > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> > with following parameters:
> >
> >         nr_task: 16
> >         mode: thread
> >         test: unlink2
> >         cpufreq_governor: performance
> >
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> >
> >
> >
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> >   gcc-7/performance/x86_64-rhel-7.2/thread/16/debian-x86_64-2018-04-03.cgz/lkp-bdw-ep3d/unlink2/will-it-scale
> >
> > commit:
> >   1e6cb72399 ("fsnotify: add super block object type")
> >   60f7ed8c7c ("fsnotify: send path type events to group with super block marks")
> >
>
> I have to admit this looks strange.
> All this commit does is dereference mnt->mnt.mnt_sb and then
> sb->s_fsnotify_mask/sb->s_fsnotify_marks to find that they are zero.
> AFAICT there should be no extra contention added by this commit and it's
> hard to believe that parallel unlink workload would suffer from this change.
>
> I will try to install lkp-tests to verify this on my own system, but
> until proven
> otherwise I will regard this as false positive.
>

Actually, is it possible to ask for a private test with the following patch
to optimize out an unneeded srcu_derefence().
This optimization (assuming it is correct) could in fact improve scaling
compared to upstream, because there are already 2 calls to
fsnotify_first_mark in the code. The blamed commit just adds a 3rd one.
I am assuming that() in the test there is an fsnotify mount mark (maybe setup
by systemd) otherwise, the optimization in line 351 would have not reached
the extra fsnotify_first_mark() call.
Can you confirm or disprove the assumption that an fanotify mount mark
is present during the test?

Thanks,
Amir.

----
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 422fbc6dffde..8d45d82e09ff 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -246,6 +246,9 @@ static struct fsnotify_mark
*fsnotify_first_mark(struct fsnotify_mark_connector
        struct fsnotify_mark_connector *conn;
        struct hlist_node *node = NULL;

+       if (!*connp)
+               return NULL;
+
        conn = srcu_dereference(*connp, &fsnotify_mark_srcu);
        if (conn)
                node = srcu_dereference(conn->list.first, &fsnotify_mark_srcu);
