Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47244C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048CD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AbakWFs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeL1TFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:05:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39677 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbeL1TFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:05:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so15097359lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQ5YAz4960hkPFIPvfepYekwQOasEUcnUeIm7xI08XM=;
        b=AbakWFs/RwksrVl+kueMb/yXtxL8s7i6o4hl5q2cgngTrsK9+OFBcBNYhiel37BO15
         8IvYuc8EZHP3t5o4KGX3F5R2Z0NrLWakOXV7JrmIEu6xRxvE2mCfrcvPm0o2dS7GDe4s
         IusWVxvEnXu85tOguxBUQJNGvwpEZha0M4Le8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQ5YAz4960hkPFIPvfepYekwQOasEUcnUeIm7xI08XM=;
        b=Kqe8Djlqn+FQSqb6eeSgQFAQGTb/cEzFyfpnovWMVJ+Dr1mDwf/i132GDvxARIP6XC
         n1/3qbJRT5lOigPT8FTpsuIu2IBI44txYf5dEDrxCVyn5wLYEA2hSFEmjFwz6GLDS+vh
         KWxYCLztYXUCNNY909y5yEoFL031Wk1MZzz5GHtK+hc3/TgGsGX2M6ufj/qpHXx5vPbW
         x7Rfaut1MLN/kYp521jkJpXmdWhgEikFUHKAh//98HYTBepKoHA7H7axbUV2lEfgqbQX
         ZrcmBfhelJN7eID6Cuzf0MIOUOfX47JN4STCI3ChQUcfVKEePG2h/oKwyg0/Cw7bYokX
         d0UA==
X-Gm-Message-State: AA+aEWZOY2KpVBJbrC1NOTa/rkcwKR/Mmidmaels10V9qhScTumoyupp
        i9XUtsMLCfJMCVR6/wxY5pQ552JxWng=
X-Google-Smtp-Source: AFSGD/VNWfpQJwLmETiDB7mq8rrZH85OOy8hBiR/Ha22bsmBbynoNwrL+Kl/aU9wkCOz7+J52NtdRA==
X-Received: by 2002:a19:9904:: with SMTP id b4mr13989631lfe.95.1546023906309;
        Fri, 28 Dec 2018 11:05:06 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m1sm8102053lfb.56.2018.12.28.11.05.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 11:05:05 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u89-v6so19431985lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 11:05:04 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr18146554ljx.6.1546023904075;
 Fri, 28 Dec 2018 11:05:04 -0800 (PST)
MIME-Version: 1.0
References: <s5hk1k48ayx.wl-tiwai@suse.de> <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
In-Reply-To: <s5hmuoplgw2.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 11:04:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
Message-ID: <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 9:07 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> 1) Whether ASoC driver cannot work with these Dell machines at all

I'm willing to test patches.

Right now, the reason it fails to even load is that "codec_mask" is 0x0001.

And the skl_hda_dsp_generic.c code requires

        // This will be 1 for 0x0001
        codec_count = hweight_long(codec_mask);

        if (codec_count == 1 && codec_mask & IDISP_CODEC_MASK) {
           .. this is ok ..
        } else if (codec_count == 2 && codec_mask & IDISP_CODEC_MASK) {
           .. as is this ..
        } else {
           .. but here we return -EINVAL;
        }

and that basically requires that IDISP_CODEC_MASK be part of
codec_mask. Which it isn't (IDISP_CODEC_MASK is 0x4).

Anyway, as long as the ASoC driver refuses to touch this, the default
pretty much *has* to be the legacy PCI driver.

                Linus
