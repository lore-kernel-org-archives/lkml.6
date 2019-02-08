Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE161C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F832080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyX085fI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfBHQvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:51:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52273 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHQvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:51:48 -0500
Received: by mail-it1-f193.google.com with SMTP id r11so4937600itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tg1qL1LrF6xs7SLg9oM+gORvqkIR9b3G0sTURrxKlck=;
        b=oyX085fIiCVjzpcxTKHWz2t+9h0xyLplqGJQBiRAJgCqy5YB4Ys+Pw8OcgHAFUie5a
         oECImoZPNcN6zwiDDEzF1lOjUvlRhKCRexgIAji2u4MKxOreMQ66z3YV9S/zpXBoqR5+
         DlW7PjnNfapGsTFNH6h55GV6LZwJlOufniqvwDlHoRu3KDVPB+71fiWOk3wk9R1mngoc
         v/c20hvx/cSB9EiQ/ppauoDIR41XN4YCTZ0CP0PJrkEvYGcoS6p27xmhOaLqZQOWKN6R
         nMSHU8UucVQtNRv9frRZ3sS3b/F9y08rol0Pr5DkFJR4XguNSvt+oE///Rp2nGgVZDV9
         hrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg1qL1LrF6xs7SLg9oM+gORvqkIR9b3G0sTURrxKlck=;
        b=RgIOTKX8TijA8ghXPTPgTwkAb2sxECSczb5Vk91pDmHy7Ss70YDbH6squYy6O78ClD
         BYn5Aidah2BHNLAIf1me3srhzJMFQYkXMMkpDhv+clCloTHbKhPJprDtU3SlD5Xq1fNM
         +B0B5Kpi9DyFFb4kM5bhdXo4XklHWeohoZUPZ51DMPqoJocmsQopwqDMI/IDYqNwcRsY
         CCH/oZvbtXBZAPBYssnc6QrScZdUDpxEZT8LODGjGEIbarE9Hra+DDATN71LlSRIkVFd
         wEQ8hk6Df5+NitQQj20W40/0BnFMv9Gt56iCEnQR3WN64a3ZS3NKsN12bDAa+3v4PXDV
         B2YQ==
X-Gm-Message-State: AHQUAuZOlwqRGyMZjuB43X9tHkZcurcmvgustOC7WJA3FVCUc7bp0Rbk
        JDYrRrarWw4sGgNtxG1OCpjrtYRZ13U/brydaneFmQ==
X-Google-Smtp-Source: AHgI3IZOxU4sIbmXA/T6XyiCWQEhEi/+RbBodnGtcAXm+CPt9qP5yynuSXi6ckmKEnz+n1In8V/PQJrvU7ihNUuCel8=
X-Received: by 2002:a5e:de45:: with SMTP id e5mr7128442ioq.294.1549644707383;
 Fri, 08 Feb 2019 08:51:47 -0800 (PST)
MIME-Version: 1.0
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
 <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
 <20190208154009.GK32511@hirez.programming.kicks-ass.net> <CAKfTPtB9EzuHQ+K56EbDSUV6ifkpj2OR12tXRBN6=NQDwC2OMg@mail.gmail.com>
 <20190208163045.GD32494@hirez.programming.kicks-ass.net> <CAKfTPtDjS4sL-ijVgGsN9Z1yEsCi87CZfpYsZCr2n3KTLV=ByA@mail.gmail.com>
 <20190208165100.GM32511@hirez.programming.kicks-ass.net>
In-Reply-To: <20190208165100.GM32511@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Feb 2019 17:51:36 +0100
Message-ID: <CAKfTPtCT5zJUjaXmTytNuAA+HY25VVGdT7st9xPkpLZ8-4At0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: optimization of update_blocked_averages()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 at 17:51, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Feb 08, 2019 at 05:47:53PM +0100, Vincent Guittot wrote:
> > On Fri, 8 Feb 2019 at 17:30, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Fri, Feb 08, 2019 at 04:44:53PM +0100, Vincent Guittot wrote:
> > > > On Fri, 8 Feb 2019 at 16:40, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > > Good point but this should go after the for_each_sched_entity() loop
> > >
> > > Indeed, but that loop does enqueue and can throttle again, should that
> > > not also get that additional list_add_leaf_cfs_rq() loop we added to
> > > enqueue_task_fair() to finish the add?
> >
> > Initially, I added this additional loop but finally removed it because
> > I didn't hit it during my tests. IIRC, we are protected by
> > throttle_count in such case, which is not the case when we enqueue a
> > task
>
> Fair enough; and the to-be added assert will notify us if we got that
> wrong :-)
>
> I'll add the assert, no need to re-send.

Thanks

>
> Thanks!
