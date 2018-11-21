Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380D9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B93214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0KLVe5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B93214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeKVBdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:33:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37869 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKVBdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:33:00 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so9254138iti.2;
        Wed, 21 Nov 2018 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ys2v4VpU8aBVdtgFHga/ZqujvxpSRLM7Hx/JBhZ+KQA=;
        b=q0KLVe5SxeIiLozDPble4eNZor0zjMG9kg6tYYDrEkqXpmNbmJS70MMzkpT8Ca5ZN3
         2R2RYwvM9ZjLzAGBXraSHXL2xRKvw8caP4O/gsFJuZF/19+7VzNz97CR6eI6JzCBVZ4Q
         Ak+lpw0veNc1lQWzrPPe7EdnuxsDrf4k6az+qMvqGNyJsbzBdMgR6yXtJCoH7qV2qY4W
         GA0+JKGgHBk3XCg+TGEiafuGz3ws/DSsQNelXl31qyuil2nJVuPPGk4E0nMo1UiJO/ep
         32wTR4pXMcqWW//5nGMDyjqgBPLD6fgNh/U1U4T7X8XHZrOnGXz/us7dOcaMYU2Od6FV
         UHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ys2v4VpU8aBVdtgFHga/ZqujvxpSRLM7Hx/JBhZ+KQA=;
        b=dniCmO3eEYog4GmOVqQD/wqPSVLN1xZj94aaxeK81X9o7gtJPAIWZHtLRL0oifRvC1
         QM/CS4DRLNVikdcwJt8AXRotbseeiYReizDr6hS/fpAK/PVKPklmbgKzryXE3LnekUrV
         l35glWcR43KotrLc5u3goTI46UHz4vraYHFJPNtRQooxDahCWfOLRid9ArhjxpAYSQUv
         PpHpDQ5Lcgo+JkVXOb5vtxam+2ECLNLt/4o0pFOt7ikMa0iJ8atC+js9jkeMvMzAaDDt
         pR09jWknyEfTf344/0Z6YE4AQMRuSLRDXAcFRVyW0MzsQZdV0dfjXqStZxG2qn1gqPIO
         9QaA==
X-Gm-Message-State: AA+aEWati5cwg4bDXVynANJtEASs4e299B1V0UqSw5A9MBf20zLxQ3Hi
        lUo/Cpchlc16FKDcV5JO+p3J1BGfZq6Ah/2tkAo=
X-Google-Smtp-Source: AFSGD/UinGiVTep9sOOelsf2vlEuzzSwDQAm0XKGz2FynVdbKeTX/tJ8iUfk+/pbUg8Y/X2qCqBk//Sv7zSljVQuHnQ=
X-Received: by 2002:a24:108a:: with SMTP id 132-v6mr5834418ity.78.1542812293925;
 Wed, 21 Nov 2018 06:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20181121141204.22819-1-tiny.windzz@gmail.com> <2d534bbb-7b75-8521-bf88-36b52c918d19@nvidia.com>
 <20181121144320.GA6446@ulmo> <CAEExFWswqoObtnjezRf-3u1ssJ04cwDaggg_HLXju72mannZ6w@mail.gmail.com>
 <bb47ae0d-3607-f396-b9e4-77e25777d6c2@nvidia.com> <20181121145600.GA7739@ulmo>
In-Reply-To: <20181121145600.GA7739@ulmo>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 21 Nov 2018 22:57:52 +0800
Message-ID: <CAEExFWv9YvurGR3iXie-LyHjAyWtmSQgJhmd9=WTd41R4bDiqQ@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:56 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Wed, Nov 21, 2018 at 02:50:54PM +0000, Jon Hunter wrote:
> >
> > On 21/11/2018 14:47, Frank Lee wrote:
> > > On Wed, Nov 21, 2018 at 10:43 PM Thierry Reding
> > > <thierry.reding@gmail.com> wrote:
> > >>
> > >> On Wed, Nov 21, 2018 at 02:34:57PM +0000, Jon Hunter wrote:
> > >>>
> > >>> On 21/11/2018 14:12, Yangtao Li wrote:
> > >>>> of_find_node_by_path() acquires a reference to the node returned b=
y
> > >>>> it and that reference needs to be dropped by its caller.soc_is_teg=
ra()
> > >>>> doesn't do that, so fix it.Call of_machine_is_compatible() to refa=
ctor
> > >>>> soc_is_tegra() whcih automatically manages the reference count.
> > >>>>
> > >>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > >>>> ---
> > >>>>  drivers/soc/tegra/common.c | 12 +++++++-----
> > >>>>  1 file changed, 7 insertions(+), 5 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common=
.c
> > >>>> index cd8f41351add..0b40700b672a 100644
> > >>>> --- a/drivers/soc/tegra/common.c
> > >>>> +++ b/drivers/soc/tegra/common.c
> > >>>> @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine=
_match[] =3D {
> > >>>>
> > >>>>  bool soc_is_tegra(void)
> > >>>>  {
> > >>>> -   struct device_node *root;
> > >>>> +   struct of_device_id *match =3D tegra_machine_match;
> > >>>>
> > >>>> -   root =3D of_find_node_by_path("/");
> > >>>> -   if (!root)
> > >>>> -           return false;
> > >>>> +   while(match->compatible){
> > >>>> +           if(of_machine_is_compatible(match->compatible))
> > >>>> +                   return true;
> > >>>> +           match++;
> > >>>> +   }
> > >>>>
> > >>>> -   return of_match_node(tegra_machine_match, root) !=3D NULL;
> > >>>> +   return false;
> > >>>>  }
> > >>>
> > >>> Ugh ... sorry, I thought that of_machine_is_compatible() looped thr=
ough
> > >>> the matches. OK, let's stick with your initial fix.
> > >>
> > >> Actually I prefer this one. Even if it is slightly more verbose, I t=
hink
> > >> it's much clearer what's actually going on. Also this hides all of t=
he
> > >> OF node reference counting in a core function, so it's worth the ext=
ra
> > >> line, in my opinion.
> > >>
> > >> Thierry
> > > Hi Jon=EF=BC=9A
> > >
> > > I like both, how aboout you?
> >
> > Yes fine with me too. However, looks like there is some formatting that
> > needs to be fixed up above. Please make sure you run checkpatch.pl on
> > your patches. Otherwise ...
> >
> > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> >
> > Thierry, pick up this version if you prefer.
>
> Yeah, I noticed the formatting issues, but I can take care of them while
> applying.
>
> Thanks,
> Thierry
Thierry=EF=BC=8C

Thanks.  :-)

Yours,
    Yangtao
