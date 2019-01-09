Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBFAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0553206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFqBCiAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfAIQsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:48:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34952 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfAIQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:48:35 -0500
Received: by mail-io1-f67.google.com with SMTP id f4so6553475ion.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdCynCQXJR51Uq88sO1InC8ROmQ7T31Q2pMI8I3KRIY=;
        b=BFqBCiADprgxye+2BS0wxgDl9lErgr8cSN6izzYo8ORz7+eTVv76AIP+9ORHl9CJco
         2wvdQX/qWVKUwMfr5hC0oyLaXyyQQQ/P/nufVdFam6MOx9ZyMX2kHfX8g93gQ5bmdJy6
         xyrmWN4DLI7ohts8fK85H6eCs7gjl4dz6ydx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdCynCQXJR51Uq88sO1InC8ROmQ7T31Q2pMI8I3KRIY=;
        b=g4Z/4ZbPiar5Fc208Sf5I0waXhMfsa0zf9/TU0E4Tux5egFIO0sZfPn1bGSBXHhNp+
         T4dUzoWQgB7SAwxpvYXyuGCGD/Oc3/NP1STvuLNbRhVHfIcldz2RUMpVAAQgcObfu6fS
         GfyMkDWQu8NMbIuGvWldIn0Et+0q+aQDP3ypFz90OYnfAEpa+yg44JZDnHzby9TUvsJa
         fkQmFfbsHnLUmVv1eoBoWWBVF66kIyUT1vnTppmsvo+V4PRkZBn5LkbMbqmIwOsqllkH
         eu86t3tuny29CidDY867G/gzsTYmZVi0G2CUNN6471gaAlZbqBwhBctMweCjr8FtoKd9
         /GKw==
X-Gm-Message-State: AJcUukeP7TkxnWF8931rSajsziDX5bryFTn25AE/DDqHz0mfwTUPCkBz
        a0KGkTtndS4rhtRkK2BnhrwZDrta9DzsaK8jz7F6rA==
X-Google-Smtp-Source: ALg8bN46TfwF2T9uKnRpMHXxc2amErUpK307V7pvh/LihSLwY/nSB41VOSrL8lYO01v+ZQU/+Cc9DbX0Pwb4CqrjaUc=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr4084607iof.183.1547052514283;
 Wed, 09 Jan 2019 08:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com> <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com>
In-Reply-To: <20190109162846.GP5544@atomide.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Jan 2019 17:48:23 +0100
Message-ID: <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Ladislav Michl <ladis@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 17:28, Tony Lindgren <tony@atomide.com> wrote:
>
> * Rafael J. Wysocki <rafael@kernel.org> [190109 09:44]:
> > On Wed, Jan 9, 2019 at 2:51 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Vincent Guittot <vincent.guittot@linaro.org> [190109 01:42]:
> > > > Le Tuesday 08 Jan 2019 =C3=A0 13:37:43 (-0800), Tony Lindgren a =C3=
=A9crit :
> > > > > Lowering the autosuspend_delay_ms to 2100 ms makes things work ag=
ain.
> > > > > Anything higher than 2200 ms seems to somehow time out immediatel=
y
> > > > > now :)
> > > >
> > > > This is quite close to the max ns of an int on arm 32bits
> > > >
> > > > Could you try the patch below ?
> > >
> > > Yup great thanks, that's it:
> > >
> > > Tested-by: Tony Lindgren <tony@atomide.com>
> >
> > Cool.  Thanks for getting to the bottom of this!
>
> No problem.
>
> One more thing I noticed: The 25% slack can get noticeable
> for larger values. For things like a 3 second uart console
> timeout slack of 750 ms is quite large variation.
>
> Should we have a limit of max 100 ms for the slack?

Keep in mind that when jiffies were used, expires was rounded to a
full second when delay was greater than a second. So you could already
have difference of up 990ms on arm before this patch
And i don't take into account the rework of timer infra which add
another level of variation, something like up to 640 ms more when the
timer is greater than 2880 ms for arm IIRC
>
> Regards,
>
> Tony
