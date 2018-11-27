Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B77C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02944208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJXtt0UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02944208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeK0NYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:24:09 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50712 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbeK0NYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:24:09 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so14314648iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYhvrJp1F6xCS2BSAGlYwk9a60TmyXDkOBAdJ7PTZU8=;
        b=PJXtt0UYtlxxA9bwVr05ClAwMlVYX83dpke+BWfZmuxTIIYXKZQcI2/+dKLjbT5o6/
         S0MQmgyq2wg0OgPPX85yJ0Rt9Wwl19oc+xV5FqgN2U/6CcP9JYevXuwlNiI/LN8RIKQS
         ZAoGNnqi8gfzkfz/uHEYCUUXlRLITrloBclDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYhvrJp1F6xCS2BSAGlYwk9a60TmyXDkOBAdJ7PTZU8=;
        b=BZCQ+uPhV51GvG2qPxnMUL0QwzmSUryQQAMenQh8Uh9onoLTFJncu0ugLqXM/GBcgd
         9VfqENO7jyEX0Wr4Ay0+ksLfAqY4WLjgN6i9k2YZAGIuSZRicEMQ+xGjeuhB8/wSB6dn
         Rgm49Vezah/9vx0hRtf0R69/BoWq3r02nf6iWqhAbMtR2sDtCBunFzqR1TVJDFEIhspF
         1H7PJiRV4vcIcZun4U2m0frBLx7PrI6g2d3atIez8I9VQrDIqL/vFFHGdsCWJDl2tLbg
         DQY5FEcQZZfQdhdV8ApsFB6+kpl8lGfJskAFwfRlSpvuIvfTVqOcPgO2XGqoi/s+JUaN
         nHbA==
X-Gm-Message-State: AGRZ1gLepjI1TG9uyLxGxz3bQH3C4YhoOBDPhZzXPBr8ObMjvIoavEt1
        700MRrh9eP/SOoG1ce74V65E9ZhM86P9z8+JkOzUCw==
X-Google-Smtp-Source: AJdET5d6xrxhg/Bw9DnfUW9rGjKO8uaMAbPEDagCd8/AqDvqdTGWAWo84YebDT9Ja+o/t6kMsvkx0+MlcMATZp9q378=
X-Received: by 2002:a24:684a:: with SMTP id v71-v6mr24635089itb.137.1543285671709;
 Mon, 26 Nov 2018 18:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com> <CANEJEGu30oPGRjeK2Sp1dUj4CuFjZeZ9+-2DRwhvmMLNex3p7A@mail.gmail.com>
In-Reply-To: <CANEJEGu30oPGRjeK2Sp1dUj4CuFjZeZ9+-2DRwhvmMLNex3p7A@mail.gmail.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Mon, 26 Nov 2018 18:27:40 -0800
Message-ID: <CANEJEGs+ou+YyB503fyX9sqSzbp-EpykGo7OXgCNV0cW7RA0vA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
To:     Grant Grundler <grundler@chromium.org>
Cc:     RyanS.Lee@maximintegrated.com, Liam Girdwood <lgirdwood@gmail.com>,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized I had one more question...

On Mon, Nov 26, 2018 at 6:24 PM Grant Grundler <grundler@chromium.org> wrote:
>
> Hi Ryan!
>
> Just some questions inline - in general I like the reset function.
>
> On Mon, Nov 26, 2018 at 10:46 AM Ryan Lee <RyanS.Lee@maximintegrated.com> wrote:
> >
> > Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> > ---
> >  Changes : Created max98373_reset function to minimize code duplication.
> >            Changed regmap_write to regmap_update_bits. Other bits except LSB need to be masked.
> >            Added reset verification step to make sure software reset is completed well. Software reset is done in 10ms in normal case.
> >            Revision ID is available when the amp is in the idle state which means software reset is completed.

Why not poll the RevID register a few times until it gives a value?

Then structure the code to try reset twice (maybe three times).
This would avoid the unusual "sleep time after reset is increased" code.

cheers,
grant

> >            Software reset will be performed maximum 3 times to avoid amp reset failure. Generally it is done in the first trial.
> >            sleep time after software reset is increased + 30ms for every retrial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).
>
> Why is the sleep time increased after each SW reset?
> What is the failure case that you've seen which would benefit from this?
>
> >
> >  sound/soc/codecs/max98373.c | 41 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
> > index a09d013..55af7f02 100644
> > --- a/sound/soc/codecs/max98373.c
> > +++ b/sound/soc/codecs/max98373.c
> > @@ -724,14 +724,45 @@ static struct snd_soc_dai_driver max98373_dai[] = {
> >         }
> >  };
> >
> > +static void max98373_reset(struct max98373_priv *max98373, struct device *dev)
> > +{
> > +       int ret, reg, count, delay;
> > +
> > +       count = 0;
> > +       while (true) {
> > +               /* Software Reset */
> > +               ret = regmap_update_bits(max98373->regmap,
> > +                       MAX98373_R2000_SW_RESET,
> > +                       MAX98373_SOFT_RESET,
> > +                       MAX98373_SOFT_RESET);
> > +               if (ret)
> > +                       dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
> > +
> > +               delay = 10000 + (count * 30000);
> > +               usleep_range(delay, delay + 1000);
> > +
> > +               /* Software Reset Verification */
> > +               ret = regmap_read(max98373->regmap,
> > +                       MAX98373_R21FF_REV_ID, &reg);
> > +               if (!ret) {
> > +                       dev_info(dev, "Reset completed (retry:%d)\n", count);
> > +                       break;
>
> Instead of break, can the code return here?
> "break" implies something else will happen after the while loop exits
> - there isn't.
>
> > +               }
> > +
> > +               if (++count > 3)        {
> > +                       dev_err(dev, "Reset failed. (ret:%d)\n", ret);
> > +                       break;
> > +               }
> > +               usleep_range(10000, 11000);
>
> Why is there a second delay after reading MAX98373_R21FF_REV_ID?
> Is this really necessary?
>
> If the second usleep_range() isn't needed, it would be better/clearer
> to make code loop on "while (count < 4)".   And then outside the while
> loop, use dev_err() to share what the failure was.
>
> > +       }
> > +}
> > +
> >  static int max98373_probe(struct snd_soc_component *component)
> >  {
> >         struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
> >
> >         /* Software Reset */
> > -       regmap_write(max98373->regmap,
> > -               MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> > -       usleep_range(10000, 11000);
> > +       max98373_reset(max98373, component->dev);
> >
> >         /* IV default slot configuration */
> >         regmap_write(max98373->regmap,
> > @@ -818,9 +849,7 @@ static int max98373_resume(struct device *dev)
> >  {
> >         struct max98373_priv *max98373 = dev_get_drvdata(dev);
> >
> > -       regmap_write(max98373->regmap,
> > -               MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> > -       usleep_range(10000, 11000);
> > +       max98373_reset(max98373, dev);
> >         regcache_cache_only(max98373->regmap, false);
> >         regcache_sync(max98373->regmap);
> >         return 0;
> > --
> > 2.7.4
> >
>
> cheers,
> grant
