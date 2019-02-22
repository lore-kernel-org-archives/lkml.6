Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB07C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D6120657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2aImyng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfBVSrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:47:45 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43032 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:47:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so1732287qke.10;
        Fri, 22 Feb 2019 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaT+im/exFXiuwgGdAqRUQFYEcuWfEumIF7pOvOGNuQ=;
        b=G2aImyngdqoEn4nPid+PW+3gWZZRSs52AQMsz/kgQraCbgA1FFu9e6OBV8ASFFLWYY
         RlZc1APWE3oiNWwXIPwumapvcqGYaSLUpuj7vWhAaTD4AKXaS4B9LchMYDUCqiZmwW8/
         D6cIgAjHhUvWsdq+TB1c2Ekv7LN0x6wvdKnCYurfhJuBjWqxYwinpW4Q3B+6DpvHOnAT
         scxy6vlj7FJiYRlsiH/M/A/LQ3ZnjKYTEAqTrTINTxVPfMqAf8muCcCPbkXzQ8YdTpkm
         MnkP/DL5nOtOjCYpAeFDZXjoCiH7QJuvA9JCYz8r/folWKOSnalUzrHVSzYh6i5ePh56
         sTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaT+im/exFXiuwgGdAqRUQFYEcuWfEumIF7pOvOGNuQ=;
        b=XyRmR6ZUOHHz7iNesUlOfDPRtj0McZL/ASFDm7Sh8cufCKW8jppR9wXrscUJR+SmlG
         mq+C/hW+I3+ljUJcan9PMytzZW/lM0EmtIAT2jZKyQKyJgUdJHDVKGMyfOfZhqTnKRvr
         5PUWJSzNE8qHGhf4Q1eYQZuh9LsQ4feL4lkgCkF3stMNO22Wgf45FrzPzcfNwHoGNdi/
         4349eHqMN4cP564ZMPCQzd3CSoj37PQ9QT95NY0QQaa9CpIXGL6DrRvTn2zQx+fkNmcV
         RQnrqmYP37ENnPFtBlrodh5bnQPAtmDAexr5Jm+vQ2HeMTs3k35IImusRWuROxP/iWap
         UfRA==
X-Gm-Message-State: AHQUAub+Wi0ZylS5VMV5oLSP4I9r1oGEa61ep4Yd4kvuJvxT7CqNH1Nv
        97Q1MfYaD/tfojVxJlgM8tZNkQazEVa1BqGVKTw=
X-Google-Smtp-Source: AHgI3IanaQzYkmKzcAyH81NKHNEEQstgDAaHCvvQbZk0TbVaKuWGkJegoO4TduDZibE+RtiZNlvfsddkTQ/+2aU5h0k=
X-Received: by 2002:a05:620a:13ad:: with SMTP id m13mr4105843qki.59.1550861263361;
 Fri, 22 Feb 2019 10:47:43 -0800 (PST)
MIME-Version: 1.0
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com> <20190221232609.d4vxl3osj6mwooey@katana>
 <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
 <20190222102335.GA1771@kunai> <20190222103019.GD130153@ediswmail.ad.cirrus.com>
 <20190222113159.GB1771@kunai>
In-Reply-To: <20190222113159.GB1771@kunai>
From:   Jim Broadus <jbroadus@gmail.com>
Date:   Fri, 22 Feb 2019 10:47:32 -0800
Message-ID: <CAKgEEwt6ciUA27+c-v0qjwkGN3gdF95DF9msh4yQVArCCQ+irA@mail.gmail.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client device.
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 3:32 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > > > But I still have the feeling that the problem is not solved at the
> > > > right place. In i2c_new_device() we are storing parts of the fields of
> > > > struct i2c_board_info, and when resetting the irq we are losing
> > > > information. This patch solves that, but I wonder if the IRQ should
> > > > not be 'simply' set in i2c_device_probe(). This means we also need to
> > > > store the .resources of info, but I have a feeling this will be less
> > > > error prone in the future.
> > > >
> > > > But this is just my guts telling me something is not right. I would
> > > > perfectly understand if we want to get this merged ASAP.
> > > >
> > > > So given that the code is correct, this is my:
> > > > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > But at least I have expressed my feelings :)
> > >
> > > Which I can relate to very much. I see the code solves the issue but my
> > > feeling is that we are patching around something which should be handled
> > > differently in general.
> > >
> > > Is somebody willing to research this further?
> > >
> > > Thanks for your input.
> > >
> >
> > I would be willing to have more of a look at it but am slightly
> > nervous I am not right person as all the systems I currently work
> > with are DT based so don't really exemplify the issue at all.
>
> Thank you! Well, I'll be there, too. Discussing, reviewing, testing. And
> if we have Benjamin for that on board as well, then I think we have a
> good start for that task :) Others are more than welcome to join, too,
> of course.
>

I'm also more familiar with device-tree (just came across this on my personal
laptop) but happy to review and test at the risk of learning something.
