Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24194C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94BF2080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S93XaUtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94BF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKJBDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:03:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42934 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbeKJBDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:03:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so2285551wru.9;
        Fri, 09 Nov 2018 07:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w73If53U6nLmhhv58TEcfbux9zgKSffY3HcRy0xx0+Q=;
        b=S93XaUtQPPkCPKA4SQnfHbXbarxf+cQ54tXZfGgAwVPa2EPgcA2iyc744QI9OL7hpv
         yun+++dk0dvX1JL/uRCFm0GctN2PeQbxsrfnxfvblL16Lfyf01HUpq5/ueRvPRtZjTpZ
         eIbVCBhW49tK33SSWJBfEl4r37hiATKm2m+bTFWVhhuqnulr4mUlR4leYEmwB9iRxF2T
         ihEh4FSr7SSUAMN80OeoYh8gUymblul698huRMUuThO+Rk17QR7eYXZEM/fHIK7JLsoP
         8NneYdq9ga62OzLle7hZjydz05LfH+usqV2TyLeBzHLnQBGTTou/undn/E3znk64t0eU
         Zb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w73If53U6nLmhhv58TEcfbux9zgKSffY3HcRy0xx0+Q=;
        b=BVhWdRm33g364V8P78l5Eb0qVXeGDRmSAyrXzrdt6yAPVnQNtwOoxDLmw5gYPfGWJy
         +UitaNqd2Q+X3S3xfA1Dt5Ko1S3WJDQpxXRCUAkddxQ/DKJgUlyIREiqp1W+tsh9m8Sm
         rViy5iuZL07v8OuOJetNVpvOL3S8dV6iUsSx/t3nYeujiQcq/8Xq6xpJFpbjZRnIWeo5
         CAIw9Je0sMHRikafQViRlG+Wkd3lQcObKWYxTUCN896VdlPGF+ES1gB039i8x70GlkKR
         9VC0JW4yMoz87EE6G1FvuHnibiwQ1k1A4Lj07rW/BHKIsI9J03we3el4bRzeGjqE/2o7
         LBUg==
X-Gm-Message-State: AGRZ1gK3icsouciLeUbzxXiWRiEUoAMFXKqpa3BZ8EUIS9uEij6ImoLC
        DovArdU1Oqwzf50rD0yKlI0=
X-Google-Smtp-Source: AJdET5cpFTmplKZI+67LG7bogpD2GXVGoo6CLC6xXdS2QM8zzGjnsXw/1lyYUPodCxhF0sP9CsKyNg==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr9050321wre.157.1541776920294;
        Fri, 09 Nov 2018 07:22:00 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1328198wmh.0.2018.11.09.07.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 07:21:59 -0800 (PST)
Date:   Fri, 9 Nov 2018 08:21:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
Message-ID: <20181109152157.GA5970@flashbox>
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
 <20180925161459.GA15840@flashbox>
 <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
 <20181025210456.GA14792@flashbox>
 <CACRpkda9LhdQybgci8gYs13L5pHWvDx43_Ftn5s+ERLLFPvLjQ@mail.gmail.com>
 <20181101000338.GA32577@flashbox>
 <CACRpkdYDgV8RWifqzu-MQxD-ZR87UeyQkxXuwB-yuXoUb0Mtbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYDgV8RWifqzu-MQxD-ZR87UeyQkxXuwB-yuXoUb0Mtbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:29:02AM +0100, Linus Walleij wrote:
> On Thu, Nov 1, 2018 at 1:03 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > [Me]
> > > A slightly lesser evil variant is to add a few PIN_CONFIG_CUSTOM_1
> > > PIN_CONFIG_CUSTOM_2 etc at the end of the enum and just
> > > #define MY_CONFIG PIN_CONFIG_CUSTOM_1
> > > in all drivers that use these.
> > >
> >
> > Some drivers actually just define their pin config params like:
> >
> > #define VAR (PIN_CONFIG_END + 1)
> >
> > In fact, more drivers do that than not. I will go ahead and draft some
> > patches tonight and send them out tonight to see what driver authors
> > think.
> 
> This seems to work. Is your kernel compile working without
> warnings after this round of patches?
> 

Yes, there are no more enum-conversion warnings and the tree shows there
are no more enums that use PIN_CONFIG_END.

> Thanks for driving this BTW.
> 

Thank you for being patient and forcing me to come up with a solution
that works for you!

Nathan

> Yours,
> Linus Walleij

