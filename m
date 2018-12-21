Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8992DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DD121920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiezTVyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391040AbeLURl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:41:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55945 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391023AbeLURlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:41:51 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so7979828ith.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jxqs/xw8AMC3inlirPeL1B92a8X3IHYIDsTpUO4zlQ=;
        b=KiezTVyZ+jLeiUvqRbj0PXrRbvLdpm2OD0Ojfr6WZsrR80zzCim1/oLCcQeaRw+BkU
         BXLR/fLKriXoV2tfeX67dHpLbIaZoNj/jLslPJV/Epg7b+yCIwK486snPS/5SmMVgYiW
         xskIRJBymbLe8b1sqzc9LQCeUNBwOU/ZBz2Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jxqs/xw8AMC3inlirPeL1B92a8X3IHYIDsTpUO4zlQ=;
        b=i4s9CmmyzA1vkVLWs/TPamDjK10QZzqPmlEUpZaBNnGSyQSlHmM6N/KI8TGhCFNz5f
         Sf+5NYRc4YneM5qkxlVjUXe75DGHmfnP9hmXvmeeo69mTEfNmYRiWCwLWOUhHN6N5MTx
         P2uig3vLUFSYg7Qiae/t14T1/kvKr5x9Bxs6oTB15tW5Hitg5eHFBJ5yn4DZRFFqdwbH
         yta+BcJyagagSUNSrgkcUOczCfE4AFfdKPvF3dXqC2BlFpwfowsNiGK4x0bMJqk4Pv6V
         k/3Bi1VFpTwi4KyeBLPltBmt1/E4EWGBLylMHLoQLjp1qH9qCPyEfZE/gSYi3qJWgkDa
         hRbw==
X-Gm-Message-State: AA+aEWYkHOiOQUL04Y3BJNihpdS0Ik6eTr7K6jI21XPRSZek3n5mIFUt
        tDv8J95M0pEyjJd3MQBtrfZfBZkUxmbg2qRwu8JJnw==
X-Google-Smtp-Source: AFSGD/V9VkUBeYmM33h7zEwFbIu2bOwtSX811xO9ZTVOwZreVBS8Q04s3oP0fSK/JwcX91Ry9HQ1CIhcnPl2yLV/NzQ=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr2553233itb.152.1545414110144;
 Fri, 21 Dec 2018 09:41:50 -0800 (PST)
MIME-Version: 1.0
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-4-git-send-email-vincent.guittot@linaro.org>
 <c482361e-cfb4-d172-32c3-4d82ceb1e7d2@arm.com> <CAKfTPtCQTMs=6yGbrfuUGyhwPHWvMODcyyDROVjbURHFxLTxCQ@mail.gmail.com>
 <d87cba1f-fa5c-3d82-ec7f-f2c72d40cb30@arm.com> <CAKfTPtBh5tFgSLfTtKafUMjtHMrFLKj1Ep9YwNn5hZS=p756aQ@mail.gmail.com>
 <55dcf87d-21fd-65d6-ff5c-bbcb0f6a6d29@arm.com>
In-Reply-To: <55dcf87d-21fd-65d6-ff5c-bbcb0f6a6d29@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Dec 2018 18:41:39 +0100
Message-ID: <CAKfTPtBJ+V=U-xHdcviXt5ezxJAYUiXPrU=ma89=Z58tATt5qw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: fix unnecessary increase of balance interval
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 at 18:15, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 21/12/2018 14:49, Vincent Guittot wrote:
> [...]
> > After looking at shed.c at this sha1,  (sd->nr_balance_failed >
> > sd->cache_nice_tries+2) was the only condition for doing active
> > migration and as a result it was the only reason for doubling
> > sd->balance_interval.
> > My patch keeps exactly the same behavior for this condition
> > 'sd->nr_balance_failed > sd->cache_nice_tries+2). And, I'm even more
> > convinced to exclude (sd->nr_balance_failed > sd->cache_nice_tries+2)
> > condition because it's the condition that has introduced the doubling
> > of the interval.
> >
> > As said previously, you can argue that this behavior is not optimal
> > and discuss its validity, but the sha1 that you mentioned above,
> > introduced the current policy for (sd->nr_balance_failed >
> > sd->cache_nice_tries+2) condition.
> > Reverting such behavior would need more studies, tests and cares
>
> I agree with you on that, those are valid concerns.
>
> What I'm arguing for is instead of doing this in two steps (reset interval
> only for some active balance types, then experiment only increasing it for
> "active balance as a last resort"), I'd prefer doing it in one step.

Doing in 2 steps has the advantage of not delaying the current fix and
gives enough time for a complete study on the other step

>
> Mostly because I think the intermediate step adds an active balance
> categorization that can easily become confusing. Furthermore, that 2005
> commit explicitly states it wants to cater to pinned tasks, but we didn't
> have those LBF_* flags back then, so if we are to do something about it
> we should be improving upon the original intent.
>
> In the end it's not for me to decide, I just happen to find doing it that
> way more elegant (from a functionality & code readability PoV).
>
> > which
> > are out of the scope of this patchset and more related to a whole
> > refactoring of load_balance and calculte_imbalance; FYI, I have
> > submitted a topic on the subject for the next OSPM
>
