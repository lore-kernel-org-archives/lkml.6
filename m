Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA492C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C5C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5kGJSeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C5C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeLMFJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:09:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42863 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:09:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so591786wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wVgfMIAdToI5b8WIMf4rQSlkeCMGyK9MCXnhpmi+Lg=;
        b=l5kGJSeDRDt05mUU9+F7gQOATjAMcKFcD0pGP22RgbFeulrE8qH491MIRT/DEP783A
         0bKacwdCMaSkbJyG+WNUnHJ6qeHyOQ4aWhVyuX8Y79baQUO22MAY9h4y2bKJzYR2y84N
         rpaMJGJ3KcwL0xCcxr9ET3TGplTo+qbdCe8E+LGBZNKBHJrthnUFpp9Mp4jNaJjFtX3p
         /Yn7w1Ql0oAsFb5qNZkjyi4KEWQwzoxVDbkyIRxLlBwAug63CkxCrsKwqi2zMbIa1Z9S
         bLZ7woXpTZTNomdZGMX1ml52BaZxcoq8/TMVCRgw2Rur5SYtTG6TvuEztBYGNUhuZZsM
         FrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wVgfMIAdToI5b8WIMf4rQSlkeCMGyK9MCXnhpmi+Lg=;
        b=Y8GF3/v2u52Kwm03PyP83SQhKPEp0grp8ZV3JiR1Rd4XaPIHLJ0EbCo877bFCybXke
         +IyDIcxMKlAuGAOGwzyCs30nr3Ohl2GlUV/oFMypTdWnjIta4HZFjq7If1jwHAKCM33c
         xwCQN0i867V3Pv6+qxkNfFx2AHvqKpE3WA6dcA/NICotUErJlKTnltRfc1N0rtLVIS8c
         qGE+bk3V++liCRRx+2lHPfYc2AzPvhU8/WnKFPm91FoeFnZ9BCVLy7M75rOOaGWRVVaH
         PuW4QsUDUvx5MjTJcDaTQBeQOWNAL3jaofSTimmLgeuDMx35ZmsUg0js+70W25pvQpeC
         pFEw==
X-Gm-Message-State: AA+aEWY/zX4dOrduZk81sXzmLB7QcALA4k/y4DKtA7rr7rXKISido0RW
        tWSDH+UFTh5QQLuE6s1kH3s=
X-Google-Smtp-Source: AFSGD/WbgjvMcWBU5mCCxYesR/1MaWK2pNz7qfbcoOf+33HdzaY7xwLfQKVaaCX5O19U34C/UnzRwg==
X-Received: by 2002:adf:900f:: with SMTP id h15mr19324293wrh.18.1544677783485;
        Wed, 12 Dec 2018 21:09:43 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x76sm1696467wmd.27.2018.12.12.21.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 21:09:43 -0800 (PST)
Date:   Wed, 12 Dec 2018 22:09:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: simple-card: Dereference pointer for memcpy sizeof
 in asoc_simple_card_probe
Message-ID: <20181213050941.GA32000@flashbox>
References: <20181213043548.29747-1-natechancellor@gmail.com>
 <87y38u10rx.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y38u10rx.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:07:42PM +0900, Kuninori Morimoto wrote:
> 
> Hi Nathan
> 
> > sound/soc/generic/simple-card.c:462:6: warning: argument to 'sizeof' in
> > 'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
> > source; expected 'struct asoc_simple_dai' or an explicit length
> > [-Wsizeof-pointer-memaccess]
> >                                         sizeof(priv->dai_props->cpu_dai));
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/soc/generic/simple-card.c:464:6: warning: argument to 'sizeof' in
> > 'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
> > source; expected 'struct asoc_simple_dai' or an explicit length
> > [-Wsizeof-pointer-memaccess]
> >                                         sizeof(priv->dai_props->codec_dai));
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 2 warnings generated.
> > 
> > Commit 4fb7f4df49d3 ("ASoC: simple-card: use cpu/codec pointer on
> > simple_dai_props") updated {cpu,codec}_dai to be pointers in struct
> > simple_dai_props but didn't update these locations to dereference the
> > pointers to get the proper size of their contents.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  sound/soc/generic/simple-card.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> > index 766123485d7c..d4738d3eb2f1 100644
> > --- a/sound/soc/generic/simple-card.c
> > +++ b/sound/soc/generic/simple-card.c
> > @@ -459,9 +459,9 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
> >  		dai_link->dai_fmt	= cinfo->daifmt;
> >  		dai_link->init		= asoc_simple_card_dai_init;
> >  		memcpy(&priv->dai_props->cpu_dai, &cinfo->cpu_dai,
> > -					sizeof(priv->dai_props->cpu_dai));
> > +					sizeof(*priv->dai_props->cpu_dai));
> >  		memcpy(&priv->dai_props->codec_dai, &cinfo->codec_dai,
> > -					sizeof(priv->dai_props->codec_dai));
> > +					sizeof(*priv->dai_props->codec_dai));
> >  	}
> 
> Ahh.. yes, simple-card is supporting non DT case, too.
> Thank you for your patch.
> But, I think "&priv->dai_props->codec_dai" need to fix, too.
> And it needs to point cpu_dai/codec_dai.
> Thank you for pointing it. I will fixup and post with your name.
> 
> Best regards
> ---
> Kuninori Morimoto

Sure, whatever you think is best, thank you for the quick response!

Nathan
