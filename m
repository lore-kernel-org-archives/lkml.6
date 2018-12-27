Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D17C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA191206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJgmifz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeL0SPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:15:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35773 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeL0SPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:15:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so16911454ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGMMdRR51gZrz3buUuepUm5lmSENf5MPqQ/IfjT9YLc=;
        b=IJgmifz8ghi4hLPl0jnkUo3AGlk946gOb/GHMmxt5PCZbUw28k888n7Vvg2sLzDYhX
         v3MHTlndwIpXWO+UELsfy97FBSQnK7jdmRt7aDOxCvBjIlSUi/ATw9A9s5IaQKmHXZCp
         awRnzryCDCIDs8BiMJIBv0xDrjxccfWkJOY4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGMMdRR51gZrz3buUuepUm5lmSENf5MPqQ/IfjT9YLc=;
        b=pGV88VFQ2N0QKjVQ9z/rHOgEQiFf6I8ovDxNX77c4amKf4cMoXlHXwpZ3i8552DJ9Z
         tPNmjeCXZsysc6f675L6xH+81O61jIW3tAzc3MK3PlLT/Jfnp/9qXhszkexl/buTDsYL
         vsKYzd2cUDsiM4PYu1wbZ10HNc4JynEhfCWNMH+BcOU7/nw7VT5gczBz00g8lq6+T4qB
         GfEEFa71eRGDd7DjXyRht28AkjDqe//3GgBqBqzMpDtOw0aumbKHIMXhStnqygV9vGU7
         MYdK/A9iT8J3xGZ9TfP4WbLrTccWcbUI6NciaHQ8jLH8+OJVVNVKO9+MnKSLrpWtqosf
         U6Yg==
X-Gm-Message-State: AJcUukdhrLRhUHe/KlanywVPFVI1XAlEp1GfXKf0ITR3i7/7MoQv8Mil
        sQbx/RofgPfj8OB7h3XcuEk+SunBBSU=
X-Google-Smtp-Source: ALg8bN55XNs4WgNlG1iLqqh/U6TkmfCOLJlh/RQiTWZE8Fq/GXstscpllX+wmRujy/H1T4PX5rbjdA==
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr11961332ljb.104.1545934534634;
        Thu, 27 Dec 2018 10:15:34 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id d15-v6sm8136477lja.38.2018.12.27.10.15.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 10:15:33 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id t18-v6so16889791ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 10:15:33 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr13657272lja.148.1545934533233;
 Thu, 27 Dec 2018 10:15:33 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com> <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
In-Reply-To: <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Dec 2018 10:15:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
Message-ID: <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Sargun Dhillon <sargun@sargun.me>, Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 9:02 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> In the original behavior, the cs_rq was removed from the list only
> when the cgroup was removed.
> patch a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance
> path) has added an optimization which remove the cfs_rq when there
> were no blocked load to update in order to optimize the loop but it
> has introduced a race condition that create this infinite loop. The
> patch fixes the problem by removing the optimization.
> I will look at re-adding the optimization once i will have afix for
> the race condition

Hmm. What's the race? We seem to take the rq lock for all the cases,
but maybe I'm missing something?

That commit a9e7f6544b9c is a year and a half old, why did this start
being reported now?

[ goes off and looks ]

Oh. unthrottle_cfs_rq -> enqueue_entity -> list_add_leaf_cfs_rq()
doesn't actually seem to hold the rq lock at all. It's just called
under a rcu read lock.

So it all seems to depend on that "on_list" flag for exclusion. Which
seems fundamentally racy, since it's not protected by a lock.

So yeah, the whole logic seems to depend on "on_list is sticky and
stays set until the whole task group is destroyed".

So commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance
path") would appear to be entirely wrong, because on_list isn't
actually protected by a lock, and that can confuse things.

But that still makes me go "how come is this only noticed 18 months
after the fact"?

So I'm probably still missing something.

Tejun? PeterZ? Tell my why I'm being dense.

                   Linus
