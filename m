Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF27E2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="VF9ZC/pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBVOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:37:29 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36044 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfBVOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:37:29 -0500
Received: by mail-yb1-f196.google.com with SMTP id f5so921191ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71FWYCSYqolUNYdHB6h+7aw1EHmEdZQNjgmLsAFRBRQ=;
        b=VF9ZC/pwjqPWKGz+OnP5zP6UW1KRZmpKMyefSgpo9M4yhncv/srNYQXlaNPT0mMYSc
         CevSxczb1xOBYFBXTS3F+Ew3X3+rl+AWcvsSIEmeMaROY+QfKiQ/mkb1o6/5OqqgPadL
         v74SSsCtOtxqHNRLTdexqtC6ozLYX9HZIGDNtSSjI5wuocWlAw0jmT4sOe/2WTDX43St
         oT9RvASxAW2w7WNgyfZc7R5fhl5OhAUvYNAeP7wQfNB74k6hrb8IjoZ8CVtpTweE74Yw
         0LC8wiVx/gJd6mjqVP/BisAAxFNEvvOEPUcCxGESDRUZ+AZFw1BfN2bxkVr2Zgd74g+b
         3Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71FWYCSYqolUNYdHB6h+7aw1EHmEdZQNjgmLsAFRBRQ=;
        b=H23Q0BPYR4cgtEoNDOsnsyv/5t1O13DW/azrsxEpTK8QYbwSmAuwRSENBOFfvQlF+y
         /wZzHQ9EofX7qGEuvtZnCaE1HYQgbLVgTFHxCyri1/Fi1EbQps5jAbSO3R+z4q4a8Ex6
         oyCCDIIrteRNEntuHmqVxOh97MhWOxJV6ruby9YCCbq+8PTDNRuF13GJFln8CZAFWmtA
         ahcpF1vshniHDGOUQLT+L9cU0ALj63Eu6rq+ui7uFVpznXsECf2cQgXdbDN+Dx1FrRbx
         u0xTTuXo7wFlEItDcHVtK9vTa/zwJKHDplW01+fIgCfgNsZElq5DEyL3mzhcfUauaQ3U
         T2+A==
X-Gm-Message-State: AHQUAuYRwnjG5dGkka3FhGpJ7/mIvtqMsSgLzwG4xZW/tP8sHyKE01ek
        MKYf9wT4+hCRUtX9aVaQoyTyZnG7/Gi9F5Ier+5eug==
X-Google-Smtp-Source: AHgI3IbiwWkiGGT/QpFlIkUVk7q36nI0iMQVsQ7TPGxhgsjNk6oh2vnC2sXcuWD3EAz203Sc3uaEff/B8CXyMvysFGc=
X-Received: by 2002:a25:bec2:: with SMTP id k2mr3650739ybm.328.1550846248027;
 Fri, 22 Feb 2019 06:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com> <20190220164154.00547a77@archlinux>
 <20190221010931.GA3471@icarus> <20190221082758.GA3380@icarus>
In-Reply-To: <20190221082758.GA3380@icarus>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Fri, 22 Feb 2019 15:37:16 +0100
Message-ID: <CAKKE0ZEKLp2NJE55by5VHc36P=w_rrMxsPxQG60T0BtCzYkSEw@mail.gmail.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for your comments, I'll make a new version of the patch based
on your input.

William, I'll rebase the next version on top of your branch.

I'm glad the counter subsystem effort is progressing :)


Patrick Havelange.

On Thu, Feb 21, 2019 at 9:27 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Thu, Feb 21, 2019 at 10:09:54AM +0900, William Breathitt Gray wrote:
> > On Wed, Feb 20, 2019 at 04:41:54PM +0000, Jonathan Cameron wrote:
> > > On Mon, 18 Feb 2019 15:03:18 +0100
> > > Patrick Havelange <patrick.havelange@essensium.com> wrote:
> > >
> > > > This driver exposes the counter for the quadrature decoder of the
> > > > FlexTimer Module, present in the LS1021A soc.
> > > >
> > > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > > Given you cc'd William, I'm guessing you know about the counter
> > > subsystem effort.  I would really rather not take any drivers
> > > into IIO if we have any hope of getting that upstreamed soon
> > > (which I personally think we do and should!).  The reason is
> > > we end up having to maintain old ABI just because someone might be using
> > > it and it makes the drivers very messy.
> > >
> > > I'll review as is though as may be there are some elements that will
> > > cross over.
> > >
> > > Comments inline.  William: Looks like a straight forward conversion if
> > > it makes sense to get this lined up as part of your initial submission?
> > > You have quite a few drivers so I wouldn't have said it needs to be there
> > > at the start, but good to have it soon after.
> > >
> > > Jonathan
> >
> > I agree, we should try to merge this as part of Counter subsystem
> > introduction rather than as another IIO Counter driver. As we determined
> > when adding support for the STM32 timers, the existing IIO Counter API
> > is fundamentally unsuitable for representing counter devices. So
> > regardless of how a new Counter API is merged, the existing IIO Counter
> > API must be deprecated.
> >
> > Patrick, I apologize for the confusion this has caused. Would you be
> > able to convert this driver to use the proposed Counter subsystem API
> > from this patchset that I believe you encountered before:
> > https://marc.info/?l=linux-arm-kernel&m=153229982404051
> >
> > Although it was last updated in October, I believe you should be able to
> > rebase that Counter subsystem introduction patchset cleanly on top of
> > the IIO tree (if there are any merge conflicts send me an email). Take a
> > look at the generic-counter.rst file under the Documentation/driver-api/
> > directory for an overview of the API; the counter drivers under the
> > drivers/counter/ directory also make good references.
> >
> > If you have any difficulties understanding the API, or any other
> > troubles, don't hesitate to ask. Hopefully, I've made the documentation
> > clear enough to make the conversion of this driver quick and easy -- and
> > if not, then it's something I need to fix, so let me know. :-)
> >
> > William Breathitt Gray
>
> Patrick,
>
> It looks like there were some minor conflicts with the v9 patchset, so
> I've rebased it on top of the latest iio tree testing branch and
> resolved the conflicts in my personal repository. Please pull from my
> personal repository at https://gitlab.com/vilhelmgray/iio.git and base
> your patches on top of the generic_counter_v10 branch.
>
> William Breathitt Gray
