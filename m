Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7C7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EAA21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sg/9JcAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfBAIKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:10:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35746 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBAIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:10:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id e7so3680804vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ww/6315LqyCbySb8JvfKS4rD8EINaOp8BfcXcUCvwg=;
        b=Sg/9JcAwOynQzdUrOW8mwXjovM7aJMbv1zVZLknDg0Vl8/dNyngM9NOa49FN5/Eig5
         jr7BIFDlJaWKkBKrg9efRFyaXc8NzSjZL1zae6gbhFQ7SO+F9sIBqV92lO8F/3uaos+n
         h8Bhgs/UjPVpqVPA5JERcyeYAyrBOizXqP3SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ww/6315LqyCbySb8JvfKS4rD8EINaOp8BfcXcUCvwg=;
        b=ab4h8BWmG4mW4Ws4Q/Y5sMHsvqeivLY/zwqRGXehqycmwlwx/CCnwTE0VZbZyKsZsV
         5lfw3tVze4s6Io0bdQnTFm3t/m+l7FlQebfbJYdvJi0+k6x96jGQ9BJf2sDXE44iu0XJ
         Fjr8Pnb6ca+OPlhQY8zsmQmGnCVpelXuDnDx5S4U58+upfNSPynkGGaVBA3mJw2dairD
         8tKRqjOka5KMBv06WdLIbUll/Agi8bSU1I6uLofQzxKqBLilz7eYAbB7lVcUILYT2ybz
         kkP3H9Y2e64Z6JK5dVxO87da5lVDeqdzZ7IPIT/Zhmyyh7iJbbaNigmAbprNT6W8EgV8
         4igw==
X-Gm-Message-State: AJcUukcptd3xjFqVWh3ER0ioGjfFzkCYPpQvN0sgKjG5W6ddqQUO5uAR
        YHgE2ZbN4cVgmCCLGV6wls2xDtaEJBpJVRHWCmdKRE9I
X-Google-Smtp-Source: ALg8bN5kZMa0aIRlR0/gBiEJyFJXY5hZlr0qv+JgRYwj3J5T7PeTS0atnrGdkCT8ST7aZiFY66JebpSvnWK7v/Rkrow=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr16063232vsi.191.1549008647810;
 Fri, 01 Feb 2019 00:10:47 -0800 (PST)
MIME-Version: 1.0
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com> <1548985091.10251.26.camel@mhfsdcap03>
In-Reply-To: <1548985091.10251.26.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Feb 2019 09:10:11 +0100
Message-ID: <CAPDyKFqHJn9uVkd5z4D5JvNKOtbn3E3SwL_WSgLb1=Lw1SgyUg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 02:38, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> On Thu, 2019-01-31 at 16:58 +0100, Ulf Hansson wrote:
> > On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > >
> > > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > > Therefore, any commands sent to the card should use HS400 timing.
> > > It is incorrect to reduce frequency to 50Mhz before sending the switch
> > > command, in this case, only reduce clock frequency to 50Mhz but without
> > > host timming change, host is still in hs400 mode but clock changed from
> > > 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
> > > the switch command gets response CRC error.
> >
> > According the eMMC spec there is no violation by decreasing the clock
> > frequency like this. We can use whatever value <=200MHz.
> >
> > However, perhaps in practice this becomes an issue, due to the tuning
> > for HS400 has been done on the "current" frequency.
> >
> > As as start, I think you need to clarify this in the changelog.
> >
> Yes, reduce clock frequency to 50Mhz is no Spec violation, but it may
> cause __mmc_switch() gets response CRC error, decreasing the clock but
> without HOST mode change, on the host side, host driver do not know
> what's operation the core layer want to do and can only set current bus
> clock to 50Mhz, without tuning parameter change, it has a chance lead to
> response CRC error. even lower clock frequency, but with the wrong
> tuning parameter setting(the setting is of hs400 tuning @200Mhz).

Right, makes sense.

> > >
> > > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > > after card timing change.
> > >
> > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > ---
> > >  drivers/mmc/core/mmc.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index da892a5..21b811e 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > >         int err;
> > >         u8 val;
> > >
> > > -       /* Reduce frequency to HS */
> > > -       max_dtr = card->ext_csd.hs_max_dtr;
> > > -       mmc_set_clock(host, max_dtr);
> > > -
> >
> > As far as I can tell, the reason to why we change the clock frequency
> > *before* the call to __mmc_switch() below, is probably to try to be on
> > the safe side and conform to the spec.
> >
> Agree, it Must be more safe with lower clock frequency, but the
> precondition is to make the host side recognize current timing is not
> HS400 mode. it has no method to find a safe setting to ensure no
> response CRC error when reduce clock from 200Mhz to 50Mhz.
> > However, I think you have a point, as the call to __mmc_switch(),
> > passes the "send_status" parameter as false, no other command than the
> > CMD6 is sent to the card.
> >
> yes, the send status command was sent only after __mmc_switch() done.
> > >         /* Switch HS400 to HS DDR */
> > >         val = EXT_CSD_TIMING_HS;
> > >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > > @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > >
> > >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> > >
> > > +       /* Reduce frequency to HS */
> > > +       max_dtr = card->ext_csd.hs_max_dtr;
> > > +       mmc_set_clock(host, max_dtr);
> > > +
> >
> > Perhaps it's even more correct to change the clock frequency before
> > the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
> > will be using the DDR52 timing in the controller, but with a too high
> > frequency.
> >
> for Our host, it has no impact to change the clock before or after
> change timing, as the mmc_set_timing() is only for host side, not
> related to MMC card side and no commands sent do card before the
> timing/clock change completed.

Alright. After a second thought, it actually looks more consistent
with mmc_select_hs400() to do it after, as what you propose in
$subject patch.

So, let's keep it as is.

> > >         err = mmc_switch_status(card);
> > >         if (err)
> > >                 goto out_err;
> > > --
> > > 1.8.1.1.dirty
> > >
> >
> > Finally, it sounds like you are trying to fix a real problem, can you
> > please provide some more information what is happening when the
> > problem occurs at your side?
> >
> Yes, I got a problem with new kernel version. with
> commit:57da0c042f4af52614f4bd1a148155a299ae5cd8, this commit makes
> re-tuning every time when access RPMB partition.

Okay, could you please add this as fixes tag for the next version of the patch.

>
> in fact, our host tuning result of hs400 is very stable and almost never
> get response CRC error with clock frequency at 200Mhz. but cannot ensure
> this tuning result also suitable when running at HS400 mode @50Mhz. as I
> mentioned before, the host side does not know the reason of reduce clock
> frequency to 50Mhz at HS400 mode, so what's the host side can do is only
> reduce the bus clock to 50Mhz, even it can just only set the tuning
> setting to default when clock frequency lower than 50Mhz, but both card
> & host side are still at HS400 mode, still cannot ensure this setting is
> suitable.

Right, thanks for clarifying.

So I am expecting a new version with a fixes tag and some
clarification of the changelog, then I am ready to apply this to give
it some test.

Kind regards
Uffe
