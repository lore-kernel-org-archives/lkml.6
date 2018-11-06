Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6388EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271BF20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNifF26O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271BF20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeKGDoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:44:17 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34064 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbeKGDoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:44:17 -0500
Received: by mail-it1-f194.google.com with SMTP id t189-v6so11050204itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLO1X+nqAa14kF/ox2hW7N4LJ2zLmtf2ThCzUCMiwdU=;
        b=mNifF26OprBlTgZK9McZye3mV2U4hCEeRWsOkrLwyuGpugIK6i5eAardKowb7JCZuD
         mIg138Z0Kia/FWIA/hoDRRVgLiFqRFExulLsEyR+WVvuTPRUFBcI0Y3gy6WzVJb3j3Vt
         rPdUVgVtWIdJrW+AU+ecoFSP+2tI+bnAx5GDU9hs8d0N8128wlno5+dCjCa27a5kXA1h
         Zil4ijpse5oIUJH/pf9fy1ZlCvKUF79tXlWtt9lRJrGkV0u5Em5n5ifircmz++7TGKa+
         Ask5nNNLLv25reSfDfAZ3xBhHDwfWbdxDPjD7gLsm7iVe+nb+JCAjQoIrBMOnWAZz62M
         5ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLO1X+nqAa14kF/ox2hW7N4LJ2zLmtf2ThCzUCMiwdU=;
        b=am4KO0z2mW+xDl+wTewwa0g5ljYiMNP//3w//NRer7fxW1SfIoO6tBJps8dVxhTxCl
         FEGDdfYvp59DWOStjHLGQlbt8qOaNZOCS9a6qnfFHt1vUrVZTr2JTsGJiEHxPU6Oylqe
         4qOKkOp7qTI08sXUBgrtJ6hgzl3ZnsMVTB77dMcDeDzz8ATF6Js0x4oIq/08eOI2ULfB
         hlp4av/r4v73a9HJIqRMYSUHdPLi8hf+sUKguhQ2CjispTz4t2r5FGOpkTpk1/Ug2SUK
         EtKBCvVsDbp4BNyytQJK/LcxLVCxI9H2rAc7CVgbmRdoGIGLB3NGqfDzM1rsQeswoJsj
         dcOQ==
X-Gm-Message-State: AGRZ1gIETG4MtcnqEUJ6K3awRydI59uCJQ048m5gZYTkIJ+CbhzcfCkr
        ZsfZ/9C7vYzC3MGyUZPwdtouAghe5ya7G3nZqsY=
X-Google-Smtp-Source: AJdET5cOjiSPpJVxAZIai/A5s7y327p1+hgTaThDttOrt5IoQ8GduRbIUUJDdxufPb7+juvpIGo+xX8wZIlJ203oNaU=
X-Received: by 2002:a24:5308:: with SMTP id n8-v6mr2957155itb.146.1541528268278;
 Tue, 06 Nov 2018 10:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20181105204000.129023-1-bvanassche@acm.org> <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
 <1541454489.196084.157.camel@acm.org> <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
 <1541457654.196084.159.camel@acm.org> <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
 <1541462466.196084.163.camel@acm.org> <CAKgT0Ue59US_f-cZtoA=yVbFJ03ca5OMce2opUdQcsvgd8LWMw@mail.gmail.com>
 <1541464370.196084.166.camel@acm.org> <CAKgT0UekDV4euPHs-wrZixGN1ryhZBq_42XdK6BapYke_xomJg@mail.gmail.com>
 <1541526521.196084.184.camel@acm.org>
In-Reply-To: <1541526521.196084.184.camel@acm.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 6 Nov 2018 10:17:36 -0800
Message-ID: <CAKgT0UfbLH07Dqgk0HnhcoPbmQnoykbXLYzkdqTXkafh952Ceg@mail.gmail.com>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
To:     bvanassche@acm.org
Cc:     linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, guro@fb.com,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2018-11-06 at 09:20 -0800, Alexander Duyck wrote:
> > On Mon, Nov 5, 2018 at 4:32 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On Mon, 2018-11-05 at 16:11 -0800, Alexander Duyck wrote:
> > > > If we really don't care then why even bother with the switch statement
> > > > anyway? It seems like you could just do one ternary operator and be
> > > > done with it. Basically all you need is:
> > > > return (defined(CONFIG_ZONE_DMA) && (flags & __GFP_DMA)) ? KMALLOC_DMA :
> > > >         (flags & __GFP_RECLAIMABLE) ? KMALLOC_RECLAIM : 0;
> > > >
> > > > Why bother with all the extra complexity of the switch statement?
> > >
> > > I don't think that defined() can be used in a C expression. Hence the
> > > IS_ENABLED() macro. If you fix that, leave out four superfluous parentheses,
> > > test your patch, post that patch and cc me then I will add my Reviewed-by.
> >
> > Actually the defined macro is used multiple spots in if statements
> > throughout the kernel.
>
> The only 'if (defined(' matches I found in the kernel tree that are not
> preprocessor statements occur in Perl code. Maybe I overlooked something?

You may be right. I think I was thinking of "__is_defined", not "defined".

> > The reason for IS_ENABLED is to address the fact that we can be
> > dealing with macros that indicate if they are built in or a module
> > since those end up being two different defines depending on if you
> > select 'y' or 'm'.
>
> From Documentation/process/coding-style.rst:
>
> Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
> symbol into a C boolean expression, and use it in a normal C conditional:
>
> .. code-block:: c
>
>         if (IS_ENABLED(CONFIG_SOMETHING)) {
>                 ...
>         }
>
> Bart.

Right. Part of the reason for suggesting that is that depending on how
you define "CONFIG_SOMETHING" it can actually be defined as
"CONFIG_SOMETHING" or "CONFIG_SOMETHING_MODULE".  I was operating
under the assumption that CONFIG_ZONE_DMA wasn't ever going to be
built as a module.

Thanks.

- Alex
