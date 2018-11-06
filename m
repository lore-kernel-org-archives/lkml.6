Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2983420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pusHi1N6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2983420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbeKGCqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:46:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55516 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389303AbeKGCqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:46:34 -0500
Received: by mail-it1-f194.google.com with SMTP id b7-v6so18930872itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOkwPCRa3hxcXAFWPhipuDjsmzUilHzyYbPhcCW2B90=;
        b=pusHi1N6gKldFjCsy+TzZgaFO68GmBCxPGHbLqJR72FpinAu9VhS0ZkJsYdGzvCP5c
         tPjrtqMsU7yZHVy0SD4jJcaXEoxQ6HBdiPVbXnpsnBEajzCNKA1G7jyxWiA5fGrq4o7+
         Q+zPC0X4p8ZXcFureJOrXcHD6ErlvTszVHdGJt2pXp37/TrhneNC+tVqr0dGcCq4gXbU
         8/O42cIMwqkZR4etlJB35RaUFQ31iBvVqBhow4y7bBCHqFzd9FJ8mjWo2eIQ5KJ9SYfC
         KgyJKrFQJyDsUuxZ7dziWqkg8UwpgtTBBzvqfHvx6/HUNVMrPHmZnRwrdk9gGclcaTiG
         5Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOkwPCRa3hxcXAFWPhipuDjsmzUilHzyYbPhcCW2B90=;
        b=cbEdABHcL2nWWM9EuwiKrov+SQ+jGbI1z/CKPafCMbWtk1ycvpMB6wCvpgszS2RUfo
         istFMOe3BuEiSEnqUnMaeGgsBKCokAV2af0ASP92LQ8ihSbtccr0ryoBWesC+taufPHU
         doiz3HKumHG6Wb9W+KFmPSRDFZDhXtHBVkYiUyuaE/2FSBPND00tx+jGT/ugUDNBP0Eu
         ltavqG84wFbP6gbmUa5A6ZakuWELAAzV3GNiHPI96noN2SfSVgLxvIGZnfvkdptkp9JL
         /zlXAhB68+Km5t2XjOFPQBF1Lq7cOnHXiaoJN0Es0Bb0VTBLQOrDd/8+6Pkgb4YCMLxA
         Oyng==
X-Gm-Message-State: AGRZ1gJXJ2QOS48iqBPzxlF7ks+iEuNDLnG6ODjeXl7w4awy2EZV+nto
        xvUIRfvHkYwz69Ugx37D5ZXOAB42MjkPDOd4gJM=
X-Google-Smtp-Source: AJdET5c68/wCY/+rOr21mRzCJN4lcHjMFlN5I6RsccXsh5nUFExzsQJS5cOVm+POcjcYXjCr7jKne9Knu1ZgbF84Bw0=
X-Received: by 2002:a24:5308:: with SMTP id n8-v6mr2754878itb.146.1541524821429;
 Tue, 06 Nov 2018 09:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20181105204000.129023-1-bvanassche@acm.org> <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
 <1541454489.196084.157.camel@acm.org> <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
 <1541457654.196084.159.camel@acm.org> <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
 <1541462466.196084.163.camel@acm.org> <CAKgT0Ue59US_f-cZtoA=yVbFJ03ca5OMce2opUdQcsvgd8LWMw@mail.gmail.com>
 <1541464370.196084.166.camel@acm.org>
In-Reply-To: <1541464370.196084.166.camel@acm.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 6 Nov 2018 09:20:09 -0800
Message-ID: <CAKgT0UekDV4euPHs-wrZixGN1ryhZBq_42XdK6BapYke_xomJg@mail.gmail.com>
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

On Mon, Nov 5, 2018 at 4:32 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Mon, 2018-11-05 at 16:11 -0800, Alexander Duyck wrote:
> > If we really don't care then why even bother with the switch statement
> > anyway? It seems like you could just do one ternary operator and be
> > done with it. Basically all you need is:
> > return (defined(CONFIG_ZONE_DMA) && (flags & __GFP_DMA)) ? KMALLOC_DMA :
> >         (flags & __GFP_RECLAIMABLE) ? KMALLOC_RECLAIM : 0;
> >
> > Why bother with all the extra complexity of the switch statement?
>
> I don't think that defined() can be used in a C expression. Hence the
> IS_ENABLED() macro. If you fix that, leave out four superfluous parentheses,
> test your patch, post that patch and cc me then I will add my Reviewed-by.
>
> Bart.

Actually the defined macro is used multiple spots in if statements
throughout the kernel.

The reason for IS_ENABLED is to address the fact that we can be
dealing with macros that indicate if they are built in or a module
since those end up being two different defines depending on if you
select 'y' or 'm'.

Thanks.

- Alex
