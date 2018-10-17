Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE3FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B19A214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ZMczT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B19A214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJQJrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:47:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45926 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:47:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so12339533pfn.12;
        Tue, 16 Oct 2018 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7o98vukBRqAgaV6Sc6XvYqpoeGVSYwk/d2AI7zlLOKg=;
        b=Y1ZMczT5UskJC5SrPr5C3ZQxCC53qj1wAXMV3Q4sbVDgzAUly0nuTzbvg5gHGtUEh3
         i1DxRB/PHyuELRoobqGIT9dmU1iRvtHBiLGBsIg5y91qQhK2+YR1780IiV1TrIwA9yUL
         CxgkQ0xnA56hds+c/aOrvfaYtJeLysIRFfkeJ4GsjKijxBR5CpBdegoILH4rVwU3jHII
         vfz5SzkCpWylgOBIrCo2K7TRoq5jRoPIysm4FdzAMdd3/E+QIRCUTl+4VR11slaz5CNM
         sleDtRcddHHyLz3oq8hjBpH/ulXD+5wl+tcGQC95/s8ygh9NC1e/PHGDri6sLOQsXZGx
         kYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7o98vukBRqAgaV6Sc6XvYqpoeGVSYwk/d2AI7zlLOKg=;
        b=QjP730Exa4zDHb5xcOD5dL1RE2PYvOKG8Y7ssM0v27KtLcbDAcboDCsf3Cf/Q4+vRw
         uxxIl7boDw0eBlX9XifARL0x0hVgS8FkartEwmWmidAXhjtSmzMkGKvxQaqDVS+p3yT0
         cG2XcDB1maFtuQZpZA7LIjnEU7NwEDskWUK0fnMvc+UwjfBxvYo7BMhG9Fdzrlq3+pLd
         yuFIEbzwm+UdHqsF7g1627hulD5yjTrUbCNGLORSGrrowKt3PquA5RnS2CO8mN4zH/Iz
         8XeU5mi/7CxrVIU1d67VBjQm+xKMLP8lGWBpRUv9bW2neKmVYXbDivLuKLXvtUr0pM8i
         cMyA==
X-Gm-Message-State: ABuFfoi1QoHc/tPwG7EoK9I1A+HTv9zXAaIdaB7wooRR1OmpJbrAY83T
        EQpyyzFF/rLbjglE9uSOrO0=
X-Google-Smtp-Source: ACcGV62s6Unj4TvmBZUi6ljQRbMje0T3YBNjq4oCFLJhDwKutxMvfqD5oZwVLyASr/Sg3I5jxkISDw==
X-Received: by 2002:a63:40c2:: with SMTP id n185-v6mr22850648pga.116.1539741244577;
        Tue, 16 Oct 2018 18:54:04 -0700 (PDT)
Received: from icarus ([2001:268:c0a4:1899:c8a2:53ea:c386:fc53])
        by smtp.gmail.com with ESMTPSA id p4-v6sm20180523pfg.188.2018.10.16.18.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 18:54:03 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:54:02 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
Message-ID: <20181017015402.GA3307@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
 <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
 <20181014041933.GA7335@icarus>
 <afbe5c62-f003-ca92-d185-8e6e9340c75d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afbe5c62-f003-ca92-d185-8e6e9340c75d@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 01:59:33PM +0200, Rasmus Villemoes wrote:
> On 2018-10-14 06:19, William Breathitt Gray wrote:
> 
> > a bit value of 0 in the
> > bits array does not necessarily mean the input was not requested, but
> > may instead mean that the value at the input is 0;
> 
> sure enough, but...
> 
> > therefore, the caller
> > must keep track of the requested inputs rather than try to deduce them
> > from the values in the bits array.
> 
> ...I don't agree that this logically follows. A caller might reasonably
> expect not to find any bits set in positions other than those in mask. A
> simple example would be caller that just tried to ask "are any of
> _these_ inputs set"; it would be reasonable to implement that using
> bitmap_empty() on the returned bitset, without first having to mask by
> the mask he passed in.
> 
> Rasmus

I see your point. It would be good to keep the behavior consistent with
what would be expected by the user -- and adding an additional AND
operation at the end to mask away the unrequested bits should not really
affect the performance to a discernible degree -- so I'll submit a
patchset implementing the mask for these drivers some time this weekend.

William Breathitt Gray
