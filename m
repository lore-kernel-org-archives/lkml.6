Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51AEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8A214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEtxFz4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F8A214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeIQWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:20:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38496 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeIQWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:20:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id t84-v6so7948672pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgnBXN8D0NKQWm28wEL7c+0y3obfbWBMR0x6XnJuZho=;
        b=IEtxFz4smgql8c4geyCp7ffxUcaGj3QsSvT13Hi4bPl64AwWyry2eDvLdGbPnSc9Fu
         VO7XzOshOe1sHKytqrr0MMZ6X0mJ1d/x7JcaX5HIsJySwN66neqbbEs/b8J0DxMQckIs
         ljz44B6IvSDSydU5u890fGmEi3DbZszF7ZB194Sn9l7FxTxKazRRX2t6stECjGDNoMxz
         +hFN+sAR7jngUZegFgubonWIzoyua701xAtO4twMvkj6EG4qdJ0hW2V6Da7OLaUOdw8S
         1/yvuMk/K/3bQE6rcwn5KbwfFuueaMK9/Bx/DBPVuB8QkvlnmU67PTGuKyW7oMc1eUy2
         MmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgnBXN8D0NKQWm28wEL7c+0y3obfbWBMR0x6XnJuZho=;
        b=iDamkO5wtiBFVeB6QrRdXYGUmK+S/g84M6hYllD3YqJZd0UoHh8r3O67udC5ECnsu4
         QPP8+plcJMr6XbIVE150qndJ+rKpj0EcGujoZEA2iycVLFYDCHttR6JT5J/tv0ZPKN4C
         m60EaTpq5T9B7SMadOLK+tZCP5j9YLBndd233Oc6DWENUSoqMq59U6FOBguY4nxwhkkN
         bNeG5ZfWAOAIzbiafZ4nROkxUYv7iPUdQsShCqYUq+XxdluuZAcBunm62jlzd/PKbZBu
         tz45uH74vBo0wD6YBqZFbLzyM9ULNHw9YmsepjcovVpM5IYwpvkmjbOIrJVleD5r3wiC
         8HIQ==
X-Gm-Message-State: APzg51B/d37Kkja2HPrhDx2nAK4hO3ET1RffJYFfvPxXKFrlNUUPVE+O
        Fkhs7ZE+cnid8aLyDhdF0WZLcSDFuZ+IN54tSaBqOA==
X-Google-Smtp-Source: ANB0VdaPJ0F3fbH8YqesnJ+O2DX9/CNnV6TA3JiIIYrGdp7nVGsyV6YD3lqTYRPPlzxZiQNUD9E0wPiCKDe104PirIs=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr26847220pfi.174.1537203150575;
 Mon, 17 Sep 2018 09:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180915052511.2243-1-natechancellor@gmail.com>
 <20180916105351.1bf859ee@archlinux> <20180916151513.GA10200@flashbox>
In-Reply-To: <20180916151513.GA10200@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Sep 2018 09:52:18 -0700
Message-ID: <CAKwvOdkygBGNUkJj6zmBO=na-mXPKCeYQ+Grx49Gcyj2O9XJXw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 8:15 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Sun, Sep 16, 2018 at 10:53:51AM +0100, Jonathan Cameron wrote:
> > On Fri, 14 Sep 2018 22:25:11 -0700
> > Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > > Clang warns when an enumerated type is implicitly converted to another.
> > >
> > > drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
> > > enumeration type 'enum max9611_conf_ids' to different enumeration type
> > > 'enum max9611_csa_gain' [-Wenum-conversion]
> > >                         *csa_gain = gain_selectors[i];
> > >                                   ~ ^~~~~~~~~~~~~~~~~
> > > 1 warning generated.
> > >
> > > Change the type of the variable 'gain_selectors' to int so that Clang
> > > understands this is expected behavior.
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > How does this interact with the patch that Stefan Agner sent for
> > the same issue last week?

+ Stefan in case he has additional thoughts.  I don't feel strongly
about one patch vs the other.

> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e
> >
> > Thanks,
> >
> > Jonathan
> >
>
> Hi Jonathan,
>
> Sorry for the overlap. My patch is not necessary. I was working off
> of linux-next so I didn't catch this. I'll be better about checking
> maintainer trees before sending patches in the future.
>
> Thanks for the quick response!
> Nathan
>
> > > ---
> > >  drivers/iio/adc/max9611.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > index 0538ff8c4ac1..3c358b16a8fa 100644
> > > --- a/drivers/iio/adc/max9611.c
> > > +++ b/drivers/iio/adc/max9611.c
> > > @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
> > >                                 u16 *adc_raw,
> > >                                 enum max9611_csa_gain *csa_gain)
> > >  {
> > > -   enum max9611_conf_ids gain_selectors[] = {
> > > +   int gain_selectors[] = {
> > >             CONF_SENSE_1x,
> > >             CONF_SENSE_4x,
> > >             CONF_SENSE_8x
> >



-- 
Thanks,
~Nick Desaulniers
