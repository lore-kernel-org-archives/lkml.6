Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9223DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B8820873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="k0Oj6uAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeL1Fiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 00:38:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38772 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeL1Fiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 00:38:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so16739049ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 21:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkWKJF5vn1aN/60Zz9qk7q6Qr9dnEs60CgbG2XZrpzM=;
        b=k0Oj6uAR7v0LUfu+/nnDcFke2xDkHmdKvdceJ1AOrkzQmRaVOHfutcfSsSoJivYYXb
         k0QvgAEK2wP3cKymozj3tNS9jlp+fgaIUUmuRhsd0FFrb1syheqsjVCXrEBL1cjyy32+
         adONxo3mWoagbBQ782ETB3Y9Di6YK/3SoYcwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkWKJF5vn1aN/60Zz9qk7q6Qr9dnEs60CgbG2XZrpzM=;
        b=e+Hx42OImBYjTRjG3h+GoTDWMIpUm+IpMuZ4SquGQfw1KRa2q00es6PjZBnVF+Q+JH
         yCkSZcZ8xQR2T0343P2CXI+S64WMsIyvmeK2Mn5SaKUrFyPdVre9g/4PDnrFNyBP21bm
         lpdHpU85Z3jPTPlIGdwwHdX8JQwb2qkGSxyH+8eekLVj0Z31E+fYOjX+wEYy34weja9A
         a6xHkFnW8jfJkYtJ87txEMd0nnfMsoSnzEogs4PwEUmNP5fN+YuJpUFhhsPLUJXdClcf
         mEe0YelgEH9s//VbErB1/7oqmzMuMak8XCugGNpv+qU1Oux1fcJqkIdI84AXckIC7BbB
         hylg==
X-Gm-Message-State: AA+aEWZ18HUYY5Eq7QDPNpCtIQG0OK6LsKG6NAJLk2RUNiZ1ThT3qIGZ
        PuixtUkBp5ol0RCywpN/QweAfR+u+w7xKSns5ArqbA==
X-Google-Smtp-Source: AFSGD/XcEDptxPnv2D95V+YKlEL2p0OpzjVjo/LnwvU7qeCTmgdhUvLoRn7GEkkfV/8RZb0WVn9SDxGsB+G2kaOTouM=
X-Received: by 2002:a50:e0cb:: with SMTP id j11mr21051112edl.195.1545975533205;
 Thu, 27 Dec 2018 21:38:53 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com> <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com> <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 28 Dec 2018 00:38:17 -0500
Message-ID: <CAMp4zn_Nsc58STx+dnzar2+uw=9F3FwSRiK6ZqaBugkcmLk_Xw@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 9:02 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Dec 27, 2018 at 05:53:52PM -0800, Tejun Heo wrote:
> > Vincent knows that part way better than me but I think the safest way
> > would be doing the optimization removal iff tmp_alone_branch is
> > already pointing to leaf_cfs_rq_list.  IIUC, it's pointing to
> > something else only while a branch is being built and deferring
> > optimization removal by an avg update cycle isn't gonna make any
> > difference anyway.
>
> So, something like the following.  Xie, can you see whether the
> following patch resolves the problem?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d1907506318a..88b9118b5191 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7698,7 +7698,8 @@ static void update_blocked_averages(int cpu)
>                  * There can be a lot of idle CPU cgroups.  Don't let fully
>                  * decayed cfs_rqs linger on the list.
>                  */
> -               if (cfs_rq_is_decayed(cfs_rq))
> +               if (cfs_rq_is_decayed(cfs_rq) &&
> +                   rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
>                         list_del_leaf_cfs_rq(cfs_rq);
>
>                 /* Don't need periodic decay once load/util_avg are null */
Tested-by: Sargun Dhillon <sargun@sargun.me>
We've deployed this patch to our test workload. We haven't seen a crash yet.
