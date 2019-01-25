Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0ACC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6045217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ry/K7kUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfAYAOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:14:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55539 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYAOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 19:14:11 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so7999035ith.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 16:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLKtlTTnDjzBrCkSYM9R73jevjyDMQUKWjvv/GXIPqw=;
        b=Ry/K7kUg21ga08tJLyxFuzujby5lHv96QkeNUhSJ5iYy/iVBf/bbbAsSD3gMgu3jMm
         WRa+hKJOGTuIKg66WzBidunwWm6NmR7LkIf6twku/30ObYO5b/pcAWFIktpHrRu42mzr
         p/1Jp9ZPw+5diK7mSNqoI+XtGkzJJthIp1QCUxiqjt+xQnHcW4CZW16BTWld7VEFZapG
         QEykz5deo7FwRsfQDnKYp8YoUgOWSsVU7v7vbj/qRTBYGZNiZOvAhoTRq+hc74IP/Ws5
         JrNxyX+WON6/RL+3xcQvwQlc6GCvOQirYb2g25v14o47JQhlwIOZFusZsM6qOPSlvSzk
         CMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLKtlTTnDjzBrCkSYM9R73jevjyDMQUKWjvv/GXIPqw=;
        b=DCjXRSRzupWbxW95pkWLEIEorabmCCehjK/spkmw41t+A0hswLkSCNRZsugpxSGoKu
         ukiXMgxJt1yVw8mWB/w0RBUXgUlTqKx90sAVfEXbac7BmchztFtDALBJ/e4vHWtvutrC
         6ZAY6LSgTSx88Mn/iZWQ0pKJ5AQ7trYSAlgVQbDZ+8pUYMagCxw3hhT0FXfondiEXWAI
         1htINsKB2bbNIeYnQhFPc/KfUA4jxgo+72+GcdKZnuY5MBtJlvcj+xOp0RTWH/JsMuk1
         3UkKK2VCZVb2Xj04XnU03puB/2g5b5ZxEijFjeEmLHYHpiLRULMO34CBzdrtBy2lLD7h
         BH7A==
X-Gm-Message-State: AJcUukeYUW9wB1z/DNi0xAnx7Y2IH0nOJJ3zMN6RgUM6gVuoLumD6lKX
        49kq3URYDubPGAxV0tykfcIGJ60g3p5O/4ovKh7yBQ==
X-Google-Smtp-Source: ALg8bN6c8c4F0QnuJEyihM8Qz90S5+PTeUtozRdoTRuPSsdGJlw7zjBXpE6mlMQ26WdIMRqsPpl2GF/u/cGdyLBoNls=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr2723131itc.103.1548375249874;
 Thu, 24 Jan 2019 16:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
 <20190123232052.GD1257@redhat.com> <CAOesGMhU6wzX=sBC0iqDrzBYinP8POp=9-d4oEQoaNee-dU1zQ@mail.gmail.com>
 <20190123234817.GE1257@redhat.com> <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
 <CAFCwf10fvFAXQCGXpJHdf2bBOEJ9ZXZvoUgH9JWbNOtnmELBmg@mail.gmail.com> <CAPM=9twdfFSevH-qq7Vf1F7-nAgYvAw9XYmEKT-8LYBc403Thw@mail.gmail.com>
In-Reply-To: <CAPM=9twdfFSevH-qq7Vf1F7-nAgYvAw9XYmEKT-8LYBc403Thw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 24 Jan 2019 16:13:58 -0800
Message-ID: <CAOesGMh2CPrBn57b2H51+wVRtW0Y3SFpTOMGSSc4ombMkVLGNQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Dave Airlie <airlied@gmail.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 2:23 AM Dave Airlie <airlied@gmail.com> wrote:
>
> > I know I won't be able to convince you but I want to say that I think
> > your arguments for full userspace open source are not really
> > technical.
>
> There is more to keeping a kernel going than technical argument unfortunately.
>
> I guess the question for Greg, Olof etc, is do we care about Linux the
> kernel, or Linux the open source ecosystem, if the former, these sort
> of accelerator shim drivers are fine, useless to anyone who doesn't
> have all the magic hidden userspace, and impossible to support for
> anyone else, if the latter, we should leave the cost of maintenance to
> the company benefiting from it and leave maintaining it out of tree.

As mentioned in my reply to Daniel, I think we've got a history of
being pragmatic and finding reasonable trade-offs of what can be open
and what can be closed. For example, if truly care about open source
ecosystem, drivers that require closed firmware should also be
refused.

> Simple question like If I plug your accelerator into Power or ARM64,
> where do I get the port of your userspace to use it?

Does demanding complete open userspace get us closer to that goal in
reality? By refusing to work with people to enable their hardware,
they will still ship their platforms out of tree, using DKMS and all
the other ways of getting kernel modules installed to talk to the
hardware. And we'd be no closer.

In the end, they'd open up their userspace when there's business
reasons to do so. It's well-known how to work around refusal from us
to merge drivers by now, so it's not much leverage in that area.

> I'm not the final arbiter on this sort of thing, but I'm definitely
> going to make sure that anyone who lands this code is explicit in
> ignoring any experience we've had in this area and in the future will
> gladly accept "I told you so" :-)

There's only one final arbiter on any inclusion to code to the kernel,
but we tend to sort out most disagreements without going all the way
there.

I still think engaging has a better chance of success than rejecting
the contributions, especially with clear expectations w.r.t. continued
engagement and no second implementations over time. In all honestly,
either approach might fail miserably.


-Olof
