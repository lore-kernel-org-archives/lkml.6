Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB4EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7535720850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJsEnwpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7535720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeGRPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:52:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45955 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbeGRPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:52:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so5047251wrs.12;
        Wed, 18 Jul 2018 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=v9b4OM9embvafK7QSVNlISE3DfCT+Qb/+rVechN0YeM=;
        b=NJsEnwpHqUAU9OanU3Hh5o5aGhxTFp5ebQWSjrqQ3rJyrzI8GmeV7J6Z3K+i/ktpWQ
         U9a32tP1CNkJGkrOrEZz0gQ3ASxFCJKsZ3+57OBGeqclE9yhrxnYUBs12eneWYdDkPDY
         CsUzbEEH5Tfm/fjkQ6tCGglpyC83LeNtQ/+AxGccFmpYi8QniXJV4OhAEX0NIWDDNTvH
         keabTAiIr+nOGSH16BeH3N2fft2nsuB83ak2T/I1GzHL02Uq/IwbO2xo19C7SAm8XmLt
         KSUwlaeKmIiXsSIzY5Ec2wiNwsFiTYqT9ES7jDW9HEBr//jABG4WLLWO2hzZGyR1+alF
         Vduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=v9b4OM9embvafK7QSVNlISE3DfCT+Qb/+rVechN0YeM=;
        b=hN4xe/YdJVFJ8y8dMOjEMlPGBh3tqVF4v0PjQ+8Fh8Z/r+RhJ1RHr7z4aYP/YPfHg4
         24HOOy6fT/Rih/8/3rZAO2+PT+ozeZkyWneByHQGJTEBEU8WJUtrx5wYb1huoXEOV1IQ
         pOTAe0hTjpmU70N4Os2cG/IN0e8cIZuA2p0EFE60I9kb02vF6XFzH4MnUXUQOHVdEg9G
         DqgYZ+sCBTFGK2XMW9mtjE9FpIyVeZ+LZV4Z5XfwcdzmdtNOzkDxbLBg+wncSw2GDO8T
         78MHBYVA6vGg/qtuTLA4yrIm4ChAsDuA+y3BVL+yFNnwCczhhh0RoikzRC3fKk4tX8/U
         0uRA==
X-Gm-Message-State: AOUpUlFyX+6hhcqhq9M98DwTTJRArk5g5jr3HMuT7LF4nglYE4TiGC3C
        uepKgCypXNpIbbNwjblnnp0hdi+ElwOk+A9RZ/o=
X-Google-Smtp-Source: AAOMgpeQjySxovZsFQ1WLFpmkQ8j+dfDEmnOQspmgo5nYS74HESv27mwE8zhBnmt6N7YGrcAjZavcU+caggSTBvaXzI=
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr4745613wrc.119.1531926860645;
 Wed, 18 Jul 2018 08:14:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9784:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:14:20
 -0700 (PDT)
In-Reply-To: <20180718015154.GE3489@thunk.org>
References: <20180718014344.1309-1-tytso@mit.edu> <20180718015154.GE3489@thunk.org>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Wed, 18 Jul 2018 11:14:20 -0400
Message-ID: <CACXcFmk7D5t9yg9VxhKZgMvqK-LmFF0d7Dh9A3hsoGTfzzeM8A@mail.gmail.com>
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 9:51 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:

> On Tue, Jul 17, 2018 at 09:43:44PM -0400, Theodore Ts'o wrote:
>> This gives the user building their own kernel (or a Linux
>> distribution) the option of deciding whether or not to trust the CPU's
>> hardware random number generator (e.g., RDRAND for x86 CPU's) as being
>> correctly implemented and not having a back door introduced (perhaps
>> courtesy of a Nation State's law enforcement or intelligence
>> agencies).
>>
>> This will prevent getrandom(2) from blocking, if there is a
>> willingness to trust the CPU manufacturer.
>>
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> Note, I had meant to tag this with an RFC.  I'm not sure I really want
> to push this to Linus yet.  If you have an opinion, let me know.

I had something like this in patches I suggested as RFC a couple of
years back. Those patches were rejected for other reasons, quite
likely valid ones.

My version was not binary like this:

>> +config RANDOM_TRUST_CPU
>> +       bool "Trust the CPU manufacturer to initialize Linux's CRNG"

Instead, I had a compile-time option to choose a number 0-32
for how much entropy to assume a 32-bit value from the HWRNG
contains. Default was something less than 32. I debated values
in the 24-30 range, don't recall what I chose & don't think it
Matters hugely.

Is that a better approach than the binary choice?
