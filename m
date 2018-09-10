Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2247DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB1920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1MlfsS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB1920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeIJR2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:28:40 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44106 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeIJR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:28:39 -0400
Received: by mail-io0-f195.google.com with SMTP id 75-v6so437611iou.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0GmfvDH4Zbtq3MosUmIRYNCScaQQh6SKSfxdjhGSQA=;
        b=V1MlfsS2jvTip7rmUNcWvaaYrM+YLOdCocRhgXYp7GRE76aDV5vG1uJtdOwXrZnSKB
         GXC/qI+edR82FK5PTGAuWkyfSFNhbArCifXRaPqS6D2iWTEwSgNuB9ivws5AZ8mORR40
         cP7JeHBHFLS6wcnZFofwDudEfp5NRNoqGP5U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0GmfvDH4Zbtq3MosUmIRYNCScaQQh6SKSfxdjhGSQA=;
        b=qhPNKLjKDTZrWVzcKnq/xC/1kvRbtY7eoSeKYV7AvIp06oX5QGQQrg+KYTELDZ4TvC
         PBJK4qy+AaZy9EIia00SO2Tyamecm/RwF+EheCVL7K5HHc3K/svqrTnFQjBdT2qkBhbL
         neNxEuw83fzmwGJOB1uarDwnYwoO7dsAMijZ+h6l4qKL6aP3OHLBa+Pzkx5ieETWKDyI
         gWgIc4SpFkup5W1rs3SHjeNLyr3Wle06ksGINeqdu5HQAUiuk0x49hIGOKNSUiAg9odH
         tpuwfVvXpTFrNYfMCo7cWpzwLPtQM2DY+RNWRjQ5WR/iPfbeqEqYUywqXccmym7OxOK4
         4SKg==
X-Gm-Message-State: APzg51AGWEVjk76emyl+PFd2G0CJ7txAaJaUtIdqvuUk5pus8h9YJhKX
        NW8bGIhAJYegEjZF/s+TUhfyY4VYPnwhG9CQSf91rg==
X-Google-Smtp-Source: ANB0VdZjh2cKIs6NsemOJkcQueG4Kvp2M5+gZVGPNYKxOI5SyGVHFD22FQjMWpRUS3zdIjWIHl7dysiR1+n2sgkcoc8=
X-Received: by 2002:a6b:ea0a:: with SMTP id m10-v6mr17100272ioc.18.1536582886894;
 Mon, 10 Sep 2018 05:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180908190553.GA4573@gmail.com> <20180909093611.GA4614@zn.tnic>
 <CANiq72=RbankDmDSmD+jtvAFArGG-orMSayooGCAEa73_aOAuw@mail.gmail.com>
 <20180909160601.GA3873@zn.tnic> <CANiq72mXK8EGt7x4EVgU6H0ve9c-wGWuV06=TUfLbzB89_qYeQ@mail.gmail.com>
 <20180909164530.GB3873@zn.tnic> <CANiq72m2H2Y5MqOq62i2wVCZswWJmG4Bv8ODDFjjy4ec9+WaMA@mail.gmail.com>
 <CAKfTPtCJhPS0tuVhsLgB0Z-=5Vr5KvfU9tJ7E0MEdFJBVxt=5w@mail.gmail.com> <CANiq72=1_pw8=wZHUk+3_GdMkg0RXOb76HKtiarADwr4Sd-a-w@mail.gmail.com>
In-Reply-To: <CANiq72=1_pw8=wZHUk+3_GdMkg0RXOb76HKtiarADwr4Sd-a-w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Sep 2018 14:34:35 +0200
Message-ID: <CAKfTPtBJ2ThhXBQHOPPpsN482sWokm8CoADocr93jMVuXUuxBw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP configs
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        douly.fnst@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 at 12:32, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Vincent,
>
> On Mon, Sep 10, 2018 at 9:00 AM, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> > On Sun, 9 Sep 2018 at 19:00, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >>
> >> On Sun, Sep 9, 2018 at 6:45 PM, Borislav Petkov <bp@alien8.de> wrote:
> >> > On Sun, Sep 09, 2018 at 06:36:01PM +0200, Miguel Ojeda wrote:
> >> >> No, you get a different warning depending on whether you have enabled
> >> >> CONFIG_PARAVIRT_TIME_ACCOUNTING or CONFIG_IRQ_TIME_ACCOUNTING.
> >> >
> >> > Ok.
> >> >
> >> > Still, adding __maybe_unused to both (or writing it before the name,
> >> > whatever works!) and dropping the ifdeffery is still better for
> >> > readability's sake than having more ifdeffery, IMO.
> >>
> >> Agreed, it is quite confusing already. I tried to keep the style of
> >> the code, but Ingo/Peter might prefer the cleanup. Let's see...
> >
> > FYI, another patch has already been sent for this warning
> > https://lkml.org/lkml/2018/8/10/22
>
> Indeed -- sorry, I didn't notice. The patches are different in
> behavior, though; is the block there supposed to be there in non-SMP
> cases? (I guess so, since originally it was there, but asking just in
> case).

Yes, i think it's worth keeping it for !SMP
That being said, the original goal of the code is to compute the
amount of capacity stolen to a guest or by interrupt in order to
reflect that int the CPU capacity. But on !SMP, the cpu_capacity is
not used as there is no load balance decision between CPU to do.
Now, the code has being recently updated and the irq time is now also
used in schedutil when selecting frequency which can also benefit to
!SMP
But the enable of irq tracking for !SMP hasn't been sent yet

Regards,
Vincent

>
> Cheers,
> Miguel
