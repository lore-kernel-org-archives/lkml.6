Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E961AECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AA82086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD0/I54v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AA82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeITAnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:43:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45147 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeITAnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:43:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so6886055wrb.12;
        Wed, 19 Sep 2018 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VM1SHi99ErZOiQWcYkJp6hbVZU2jRwqvPiHonofDm9Y=;
        b=aD0/I54vhAKtD4sjI+YxIwsUkVVjcZ9EWIA7K/iNa5nL1Ye3IQYLKIG4V7EoB9mqGm
         5NEhziUIfIGjd56nGvGxZFZyxKgXZ3KAWRW/UzK6fo1fgmH1Rm31XY8HtNMGYkGnqdaQ
         6E3uO1FhcIWqXO/0XiTbS3meVIKxfjV2oJDw3FhMIdvg5l0MQSA7eO28NAFmkNWwO/RO
         YKRbtQxHLCIIw4QqHYDR8pEJa05DZnE/rVFVwVHO6g8wRWgpNJbkCUd+goICAjT3q7mU
         645CVs0tevPo9Lpr62EJn1819G7D9Z7ad7JyCGxsQ8sk6Eq9Ri3+u82Tw7uTvRi2fvrO
         OD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VM1SHi99ErZOiQWcYkJp6hbVZU2jRwqvPiHonofDm9Y=;
        b=bw8uGB1g8Hf3yWdq0okzFATpdtKHvEG+XRj733K9lh0wA3hapCjBYfGGwB/26FXr8o
         wCGn3g8DPKULKTyMBXYphtB5vT4QSK2saZ8kRag9Kno50jTNW2kPZBrS4gsHebttStOT
         VYhLvj3B2JAngNx2MsilQ9RGIPvvjNK9tr4fE9Yv8f2EEbfRu7UqlEB6HYpJwTb+TLOp
         qpp/yPGR1VGgoC360uQvPka2dE43O7UWuacIN5ZfDtrogmUyDFF7rb8VDEuKkVQe7yTU
         CXfVWhSxheMQudSGlfiu5P3qXQd4RNPZ24P1a5HYVMjWBqZDie9KBT4OMQk4FEPTbwA4
         jCqQ==
X-Gm-Message-State: APzg51Bzah+1ggVaj4LifqxT6IDAzWnPKazAnYk7Wud7qIEj0N0uC6Rf
        xQN8oz2XO0ySfEKndG+eK70=
X-Google-Smtp-Source: ANB0VdYEYc/aI0fcDnAxzRDkZqG0+g7qSMjssb+PvzqaH9g/dxi3okcXf1Hu9oQehLJoaO5XUk+FAA==
X-Received: by 2002:adf:f984:: with SMTP id f4-v6mr30576945wrr.105.1537383828077;
        Wed, 19 Sep 2018 12:03:48 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d22-v6sm38689192wra.80.2018.09.19.12.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 12:03:46 -0700 (PDT)
Date:   Wed, 19 Sep 2018 12:03:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     prabhakar.csengg@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: davinci: Fix implicit enum conversion warning
Message-ID: <20180919190345.GA31549@flashbox>
References: <20180915061615.25308-1-natechancellor@gmail.com>
 <CAKwvOd=FY9_F=yDOPaesM1VmYW0jTaAAYcMTmG6TFwa=ACu62w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=FY9_F=yDOPaesM1VmYW0jTaAAYcMTmG6TFwa=ACu62w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:39:05AM -0700, Nick Desaulniers wrote:
> On Fri, Sep 14, 2018 at 11:16 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/media/platform/davinci/vpbe_display.c:524:24: warning: implicit
> > conversion from enumeration type 'enum osd_v_exp_ratio' to different
> > enumeration type 'enum osd_h_exp_ratio' [-Wenum-conversion]
> >                         layer_info->h_exp = V_EXP_6_OVER_5;
> >                                           ~ ^~~~~~~~~~~~~~
> > 1 warning generated.
> >
> > This appears to be a copy and paste error judging from the couple of
> > lines directly above this statement and the way that height is handled
> > in the if block above this one.
> 
> 
> The above code for reference looks like:
>    492                 if (h_exp)
>    493                         layer_info->h_exp = H_EXP_9_OVER_8;
> 
> so it makes sense to me that:
> if (h_exp) layer_info->h_exp = H_EXP_...;
> then
> if (v_exp) layer_info->v_exp = V_EXP_...;
> 
> Thanks for this patch Nathan, looks like an actual bug has been fixed.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> We should send this to stable if/when it lands.  Maybe the maintainers
> could apply it with:
> Cc: stable@vger.kernel.org
> 

Yes, I think this qualifies as stable material. Should I need to send a
v2, I will add it; otherwise, it can be added by the maintainers at
their discretion.

Thanks for the review!
Nathan

> 
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/media/platform/davinci/vpbe_display.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
> > index d6bf96ad474c..5c235898af7b 100644
> > --- a/drivers/media/platform/davinci/vpbe_display.c
> > +++ b/drivers/media/platform/davinci/vpbe_display.c
> > @@ -521,7 +521,7 @@ vpbe_disp_calculate_scale_factor(struct vpbe_display *disp_dev,
> >                 else if (v_scale == 4)
> >                         layer_info->v_zoom = ZOOM_X4;
> >                 if (v_exp)
> > -                       layer_info->h_exp = V_EXP_6_OVER_5;
> > +                       layer_info->v_exp = V_EXP_6_OVER_5;
> >         } else {
> >                 /* no scaling, only cropping. Set display area to crop area */
> >                 cfg->ysize = expected_ysize;
> > --
> > 2.18.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
