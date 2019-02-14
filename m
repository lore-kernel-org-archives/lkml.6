Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E304C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB312229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBBa4RXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394550AbfBNIPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:15:17 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44531 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394478AbfBNIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:15:17 -0500
Received: by mail-vs1-f66.google.com with SMTP id r201so3094485vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1vSlE9Et3cfPY2F1A8sGnwrhCQsNEoL0FUxEug8lZc=;
        b=xBBa4RXz1IjzdL6Lt4V26sxhE7+GX/cw0HWxWUzg2kgnlpVjgh+xAr7uWx4CLoeQ/3
         5mYnSHXELr3tAZ26gQsVJnMg9651fkcMU/yCKYUIlk013OlDP8tXaHc+EkMA9viA7YfD
         6p+fscpw5PI7bsP1fdiH7SzSDXFdbiSjEmqg1HASKmCup7vWPBizYvaRIpW13bbpo86b
         WDowb8IV51W4bnn4Hq+AiEAMswOXGiR+6VIPcTHuDWpeR2uqYvERYkNiTH5XlW+lek9N
         GfjaDa2jeUZwKfbxg1LAXvw+0n1qUqdXcijXTS6Lz6pnVEsuckPlqr58iaiWx2Y4Gq1s
         6+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1vSlE9Et3cfPY2F1A8sGnwrhCQsNEoL0FUxEug8lZc=;
        b=YjTMKMc4p4xfhsERQJyrnllthWknAv0JiwRh7c9rM8SimqRwoFYsO25Vqjqb5yeBiV
         d0CH0d+nS02FubnzWjqVCKPhEvNe/eNvD8FxZedQjAxWqvUawskzpNN/9u122Ut+r0yy
         E4EbhfY0g4Ut6vE3ZYjO2+HW/EgPt1uaRSbcx4iVpGRB5HNnFMJPlxETXVP3bpCv4/5J
         OTVZ2R0Ef3HQnffSMhSPa/JaK2cHUAthNwZQWuuSUdXHzmoG+nI84RI63Sl/ec1CpkY2
         8tbr7d+9KlZV6td1/0wnfFc++WlsBgzTKiSTaOprGOalq5jiSV1oLlR1Twey1dkD7u0C
         19Fg==
X-Gm-Message-State: AHQUAuY24BUhFhHPshs2UEH6DfPjGvJGoV6z6Pu5k780SnBo4g/cPr2p
        EhwCOoo4fbGc+h3Jhx+YsV3DWmynvvRQC/mJlUDZ5w==
X-Google-Smtp-Source: AHgI3IZb1SyyZLg12u8rwtuZhCGYI/OQRskQQFBwn36j/LE7FglemYXyDqS16sJgwfH3fDSLVJ+13kvXM558cDuNMyU=
X-Received: by 2002:a67:b003:: with SMTP id z3mr1479418vse.200.1550132115847;
 Thu, 14 Feb 2019 00:15:15 -0800 (PST)
MIME-Version: 1.0
References: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com> <1550110458.16070.30.camel@mhfsdcap03>
In-Reply-To: <1550110458.16070.30.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Feb 2019 09:14:39 +0100
Message-ID: <CAPDyKFqncdVs-jB4_46ZhgZP3TGCaUWnOCoNmjfT-kAESY3csw@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
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
        srv_heupstream <srv_heupstream@mediatek.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 at 03:14, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> On Wed, 2019-02-13 at 13:08 +0100, Ulf Hansson wrote:
> > On Wed, 13 Feb 2019 at 10:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > >
> > > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > > Therefore, any commands sent to the card should use HS400 timing.
> > > reduce clock frequency to 50Mhz but without host timming change
> > > may cause CMD6 response CRC error. because host still running at
> > > hs400 mode, and it's hard to find a suitable setting for all eMMC
> > > cards when clock frequency reduced to 50Mhz but card & host still
> > > in hs400 mode.
> > > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > > after card timing change.
> > >
> > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> > > ---
> > >  drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
> > >  1 file changed, 23 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 09c688f..00adc2d 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > >         int err;
> > >         u8 val;
> > >
> > > -       /* Reduce frequency to HS */
> > > -       max_dtr = card->ext_csd.hs_max_dtr;
> > > -       mmc_set_clock(host, max_dtr);
> > > -
> > >         /* Switch HS400 to HS DDR */
> > >         val = EXT_CSD_TIMING_HS;
> > >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > >                            val, card->ext_csd.generic_cmd6_time, 0,
> > >                            true, false, true);
> > > -       if (err)
> > > -               goto out_err;
> > > +       /*
> > > +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> > > +        * error, do not treat it as error.
> > > +        */
> > > +       if (err) {
> > > +               if (err == -EILSEQ) {
> > > +                       /*
> > > +                        * card will busy after sending out response and host
> > > +                        * driver may not wait busy de-assert when get
> > > +                        * response CRC error. so just wait enough time to
> > > +                        * ensure card leave busy state.
> > > +                        */
> > > +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> > > +                       pr_debug("%s: %s switch to HS got CRC error\n",
> > > +                                mmc_hostname(host), __func__);
> > > +               } else {
> > > +                       goto out_err;
> > > +               }
> > > +       }
> > >
> > >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> > >
> > > +       /* Reduce frequency to HS */
> > > +       max_dtr = card->ext_csd.hs_max_dtr;
> > > +       mmc_set_clock(host, max_dtr);
> > > +
> >
> > What Adrian suggested was to not to move this part, but instead, only
> > allow CRC errors from the CMD6 as above.
> >
> > I guess it didn't work for you?
> >
> It should work for me. another issue is CMD6 will be sent 3 times at max

Alright, let's give it a try then.

>  err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);

Yeah, that one have I thought about earlier as well.

>
> if the first CMD6 got response CRC error, then Host driver must wait
> busy signal de-assert before send the next CMD6.
>
> So that it really make sense to issue CMD6(R1B) for 3 times ? if host
> driver did not handle the first CMD6 response CRC error and send second
> CMD6 directly, then this CMD6 will get timeout due to card still in busy
> state.

I fully agree with you, I don't think it makes sense to retry - not
even for any CMD6, because of the busy signalling the card may raise
afterwards.

Perhaps we should start with a simple oneliner patch, giving zero
instead of MMC_CMD_RETRIES to mmc_wait_for_cmd() and see how that
plays.

Then on top we can add the special error handling of the CRC errors,
along the lines of what you suggest.

Does it make sense?

[...]

Kind regards
Uffe
