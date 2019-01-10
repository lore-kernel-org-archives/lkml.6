Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B32C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F08420685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7OrjCFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfAJHu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:50:27 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:53055 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfAJHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:50:27 -0500
Received: by mail-it1-f174.google.com with SMTP id g76so15956197itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INsuntaXfrMFs/lZatoLWmlxRSavmXUczoK2TVglobY=;
        b=E7OrjCFEJq8T8axZB71vgTBwGx0iXgPBDIbVSDnOEicYpGCoHnRxB2GkQlHfgmAgTf
         Bf3SME3JPZiSPVMtnzCHUCFFuBYDep6oVLjBfFEnLcTQPKG0JUlqc66nyleBmkoeHfBF
         h9GztOacO/FKr35cLTQyEZwv0zbGafTDRnjJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INsuntaXfrMFs/lZatoLWmlxRSavmXUczoK2TVglobY=;
        b=GKqh9sS6Rf+tr8BJOrQP9rmKC5vYa/TFEDRghozyMw0E0WUfMOnkP6zsueUuU2MBiM
         LX0H2V1MpuCHlMCyGWEo2pSUIztTaMXhstc+BbDRZkrOw/M8/L5pI2/KX60LZ4+oITj3
         wXZSoANNRwAts7lNt5EWFnMycMGztZTxHGZ2VOQeSV12NE2Vp6YSnvdlFLNIfSCYeQM6
         +2RllXdreQgxMidN+PKtNoJDmMdZSNGe6EG/NVyfEg0j/+YmrrsVyfykSM8qxlhgt6uN
         f71pnZyLdLNo67U0MrYh5vJ8lqgETwKs/sSMHGbBD2SMH4Q8+aQX8je5AnA6+PUW8Beg
         61bg==
X-Gm-Message-State: AJcUukfeacCkdPXovDXgxKESofHevK3012HSgCvNW4VLlJMGQ2aYMdeW
        2Xr+MpUwuIoQkWq+mTfLuytKGA/vdE8qwcv+9IuxOA==
X-Google-Smtp-Source: ALg8bN4TcGwpGoI5T7NASo4ym68M5QmJe5bQFZZ+whlwbCspbnHFBlpTJ/9YnPxnoJyriFVS23hu4/KDApVQp0zfYC8=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr6582694itf.14.1547106625983;
 Wed, 09 Jan 2019 23:50:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch> <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch> <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
 <20190109160736.GA7416@lenoch> <CAKfTPtBnNA6knrsHsZXeaotBSn5mS12xNWNUKdSwZ1EUvueQkA@mail.gmail.com>
 <20190109172623.GB1711@lenoch> <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
 <CAJZ5v0jPJYyszAs4qJhqX+5RGwzJoo=+reTS__buoCrfTeYY8Q@mail.gmail.com> <20190110074558.GA26167@lenoch>
In-Reply-To: <20190110074558.GA26167@lenoch>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jan 2019 08:50:14 +0100
Message-ID: <CAKfTPtA53BS0MTW7SaiC7B+KsGmWCiUJW+PzT57CUN5YpGN5vA@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 08:46, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> On Wed, Jan 09, 2019 at 11:06:34PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 9, 2019 at 7:05 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 9 Jan 2019 at 18:26, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > >
> > > > On Wed, Jan 09, 2019 at 05:32:31PM +0100, Vincent Guittot wrote:
> > > > > On Wed, 9 Jan 2019 at 17:07, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > >
> > > > > > On Wed, Jan 09, 2019 at 03:12:25PM +0100, Vincent Guittot wrote:
> > > > > > > Please keep all thread list when replying :-)
> > > > > >
> > > > > > Ahh, sorry for that...
> > > > > > [snip]
> > > > > > > On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > > > > I agree, but it doea all the magic correctly, so you won't need
> > > > > > > > to touch that code is ktime_t changes (I know, unlikely..)
> > > > > > >
> > > > > > > But the current implementation doesn't care of any changes in ktime_t
> > > > > > > as it uses raw ns
> > > > > >
> > > > > > Fair enough, so let's go back to:
> > > > >
> > > > > This one looks good for me
> > > >
> > > > Lets split is for 'comments fix' patch, which was just send and 'the rest'.
> > > > Now, 'the rest' can either be v2 of your "PM/runtime: Fix autosuspend_delay on
> > > > 32bits arch" or will wait for 5.1. You decide :)
> > >
> > > I don't really mind.
> > >
> > > Rafael,
> > > Do you prefer to only take the fix for u64 casting problem or do you
> > > prefer to also take the optimization below in one single patch ?
> >
> > The casting problem is a bug and the optimization is next release
> > material in my view.  Please send the optimization separately.
>
> Ok, will send that separately in a few moments...
> Btw, u64 casting problem seems to be still present in rpm_suspend while
> computing slack for autosuspend delay greater than 25% of 2^31 (2^33) ns.

Good point. I will add it to the fix as well

> Not sure if that triggers any real bug.
