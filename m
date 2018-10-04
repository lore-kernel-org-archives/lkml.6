Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D27C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2225E21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/ss2ZGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2225E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJDR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:28:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32898 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDR2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:28:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so3196431pfn.0;
        Thu, 04 Oct 2018 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dQ9eb77XkgyCNH8/IxvJvNteYzHWM0iaVxDyUb+P0o=;
        b=C/ss2ZGWMHXPKlWMOKeIBZl3xnST0x8gEP68wCKn/R0zuwTwTIsV/Fk9gh8r0pEVzC
         kzFc+fEkGNFUoZfiSzUF1ldotmW60Z1dE/OHapHdJ7CB9BxzvBy+t+hNRM9l40TE/mEh
         cKqMKXaQdh2K5iue3CGE6dxVpcOafX4zvXTdSiTxdWhZUvSK27Wh5bGw9m3k4I4/5qvk
         6/mpi9vIobKUXO96Co24xLwgaS79t+6dLHvk3h9cmZmSuTvKFYh/qVOlm8L9X2uDyBxT
         m2NpF+Z3L+hZ2D82ae8gS8vT+PwbsKnvzbpJP1LrWgn/fDyE2D4Fk93WuEUhvtQcoheU
         LLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dQ9eb77XkgyCNH8/IxvJvNteYzHWM0iaVxDyUb+P0o=;
        b=Jm6UL0fxGaZPblT+54bHria8CQ6x8149SHNh8xaw9LMdUmrl4/OwqPc01kESqeR12Z
         pkdVWpeOCjDOfWmT0tzpgYaumJNn6LPNQZ5HRFZ/78q3gMFAp/h05iUDSJ4Iv5R1OqpU
         52NCOecCI2pJLHsh6NkGZx1s7YofCUgetnC8pZWV+IUI/nQwEavn7t9q+sv1pTP5fccI
         pH0XdWlYg9mKj6OplcWo1Oc9FtVntjo79TELsMgIlzEwEuk/2nPOaCDOK514fSEf4mfJ
         Q+MrMeY2hCW/EEYktUJqqxSJoABUe6yDjh+ZM16AuDBt2FEi7UUWMtGbIqqJn4bYT3z2
         vtaw==
X-Gm-Message-State: ABuFfoifmZFM2GmmS3FLIvQS5RF5YzSeiXd5m2FBvFts6ud+NAKjuiBm
        52NgYGubbl2Q20yQvQaZfqQ=
X-Google-Smtp-Source: ACcGV60+2KcCP5I+dUofs3EkVHg/7Ke62tcIwkI308MnBDOZ3+3I+JhXpPwmjIDG5FDPpmjd218kHg==
X-Received: by 2002:a63:a612:: with SMTP id t18-v6mr384933pge.338.1538649374579;
        Thu, 04 Oct 2018 03:36:14 -0700 (PDT)
Received: from icarus (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id u65-v6sm6885423pfb.144.2018.10.04.03.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 03:36:13 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:36:20 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Message-ID: <20181004103620.GB4779@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
 <20181002082142.GC15943@smile.fi.intel.com>
 <20181003114804.GE15943@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181003114804.GE15943@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 02:48:04PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 02, 2018 at 11:21:42AM +0300, Andy Shevchenko wrote:
> 
> > I would rather go with two prototypes to get()/set() a clump in the bitmap
> > in a way when it's aligned and BITS_PER_LONG % clump_size == 0.
> 
> To make things much easier, restrict clump_size to the one
> from the following set:
> 
> 1, 2, 4, 8, 16, 32 even on 64-bit platforms.
> 
> If it would be simpler solution to add 64 here (implying 32-bit platform),
> I would vote for that.
> 
> For the generic case we might need something like:
> 
> unsigned long bitmap_get_bits(unsigned long *src, unsigned int start, unsigned int nbits)
> {
> 	assert(nbits > BITS_PER_LONG);
> 
> 	/* Something like Rasmus proposed earlier */
> }
> 
> And similar to setter.
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

I have no objections to have a simplier macro for these common clump
sizes -- afterall, I suspect most drivers will likely use clump sizes
that are powers of 2 anyway. It would be nice to have a more versatile
macro though for those drivers that would benefit from odd clump sizes,
but we can perhaps postpone that until the need arises (the GPIO drivers
in this patchset all use a power of 2).

William Breathitt Gray
