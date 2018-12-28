Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3298218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MH5a7QYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeL1BhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:37:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34551 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeL1BhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:37:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so17593240lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 17:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8Nto6nXxU5WwVKzUWnQ8V5rARI8RREI7vnlZ1Cl/iM=;
        b=MH5a7QYea2NYc1XOCn8Pt9nuPNC2TSpp8ig+/m2924aifBJIlRKwdkJ0CPestnVzRJ
         g0p4gFs0+yrbjuTxq4Jsr0Iw35G4AL7wxNJSnfvDGEEczPkfy0ZAcBeiYHzysNTG32IR
         ijZeu5M+Ei6ovqMfIOM5XmNZunaTv/U7t5iXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8Nto6nXxU5WwVKzUWnQ8V5rARI8RREI7vnlZ1Cl/iM=;
        b=ClMR+i7CPIqEoU2lWbBHSvKI1Q+qe8bSODqOpYo3oJApelunuVJSGsactqQOlV7A9f
         cDudbRPS1A5qkut9xRZSYz7Pzw3N8Xgr1M/GMy54vIqxLaYhP2ExcjZsvW8hxaY+bzJF
         g0CHeA4RjbYcW0xx+iLssWJbrKGM2nBQM5/b8nj7B9zJMwLYdAvEW9n+OpbRUHDhy8z0
         WiprfNatxhXkt0awKJWvAKMbnkyPrhWg++gHWnDZs6d9hPg2jgzkhXKjFDQr/xODAtlN
         KCzoLqUj4QkF/3elFyy+eAJVdYecvo38drgKT2pHw3NtChqQzYnEzDwSOFfFnD/OcVJ5
         uvXQ==
X-Gm-Message-State: AJcUukeXZefabwwmisG5IVup8excrCcdYLIgRYOk1UptEFo9meDpuGfS
        HvCIUsye/Z6KcCm4YYWbkoOlAOyUJhk=
X-Google-Smtp-Source: ALg8bN5p5S9oS6Zj228carI58iaBrfX57oh0TDR5i7x9DPAi23y73f5vFeRVwu2jDl4Y+vG3IrNDRg==
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr14531493lja.81.1545961025588;
        Thu, 27 Dec 2018 17:37:05 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id l3-v6sm8339744ljg.21.2018.12.27.17.37.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 17:37:04 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id n18-v6so17567995lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 17:37:03 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr16168446ljx.6.1545961023303;
 Thu, 27 Dec 2018 17:37:03 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com> <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Dec 2018 17:36:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
Message-ID: <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Tejun Heo <tj@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Sargun Dhillon <sargun@sargun.me>,
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

On Thu, Dec 27, 2018 at 5:15 PM Tejun Heo <tj@kernel.org> wrote:
>
> I'm pretty sure enqueue_entity() *has* to be called with rq lock.
> unthrottle_cfs_rq() is called from tg_set_cfs_bandwidth(),
> distribute_cfs_runtime() and unthrottle_offline_cfs_rqs.  The first
> two grabs the rq_lock just around the calls and the last one has a
> lockdep assert on the rq_lock.  What am I missing?

No, I think you're right, and I just didn't follow things deep enough,
didn't see any rq locking in the loop in unthrottle_offline_cfs_rqs(),
and didn't realize that the rq is locked by the caller.

> > But that still makes me go "how come is this only noticed 18 months
> > after the fact"?
>
> Unless I'm totally confused, which is definitely possible, I don't
> think there's a race condition and the only bug is the
> tmp_alone_branch pointer getting dangled, which maybe doesn't happen
> all that much?

Ahh. That would explain the list corruption. The next
list_add_leaf_cfs_rq() could try to add to a removed entry.

How would you reset it? Do something like

       rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;

for every removal, or make it conditional on it matching the removed entry?

            Linus
