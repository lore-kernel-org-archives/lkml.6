Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B92075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCTJoRyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B92075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIEMEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:04:24 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36730 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIEMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:04:23 -0400
Received: by mail-pg1-f172.google.com with SMTP id d1-v6so3001652pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gAA0J3VhrgEllC2yCTaYJU9g9OZ4dIWotsN9TXJfqjw=;
        b=aCTJoRybIofn0azNkZpErhl3epsZ3+CaGx8jOo7XKACbs4ePdzLGveiquSFFu21/PI
         X2ciqNkPIX4P0vXBzOG5NuRxQOA6xOPi0r+QSu+5mGK/0Or29XQ0ZZdL/T7FLh/DdCHa
         eZkYKWCt+Zm3aHxarBRIXFqKFnK4zMG9Wi8TjBVs68ngQwCc07hs0GHouDMw56uutxkI
         koH4AfM7vj/8A74iiC98k9K0TvHoxfZJH/M4DjLEwl2oWhDipQEwmNW6yphdlyr8s5bJ
         SEUNg4ze//a1e7ZgS1z/b+Yx2KXgTp9A1KVMUqh6hZqJ9qLxKcaql/djlga1UwslfVCF
         i+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gAA0J3VhrgEllC2yCTaYJU9g9OZ4dIWotsN9TXJfqjw=;
        b=mQ7GvvgH2tEOnA6mSgq3SMEk4zn7HeP2gjqS0dvNyoF+m4Wzdv/Mwuftov+Z3EAT5d
         OYYtW8SIQKze1RwlvXde6rT6CKOHPSzSUr11GCRsoaErCdx+nM/m0nruZ0vP+foLCgx9
         9bMtLhVkgeDQ88mkTotaOPxIH+zwRmY7o5kZ9gJpgWHYsMd7mIQRDE0g9W6YVuoMk5VB
         DdNesSQP+eIV1/LnlSIKj80+ZYYiSHSgAG3Ua6uTaUTKIKOh+vsxVs79vB/7M8viD6Fb
         jZfttiEipLgYLc4A6y2edxgautLQi4tkjtSJRwrzTSXo54VjTQuJjjfiXZ253qmDpM7r
         ohqw==
X-Gm-Message-State: APzg51C4f+NnLl6kYr3PWlJeMcYJ17Kauz6iXA1YzwZ7X7rig8+iDgaM
        eGlyLdA5GpVou4D0t9aWKsLigTgDJrMJ2Ik/BAUVYA==
X-Google-Smtp-Source: ANB0VdYONIzsVrkqFAt+bixjife5R/FLI9mhB7v+v7bybcW09XYEn1NGtK3mYFzzSCPQQeSOETaf+0WhfMVnCGdintM=
X-Received: by 2002:a62:4494:: with SMTP id m20-v6mr39138245pfi.205.1536132929916;
 Wed, 05 Sep 2018 00:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 5 Sep 2018 00:35:09
 -0700 (PDT)
In-Reply-To: <1536085338.17991.1.camel@med.uni-goettingen.de>
References: <1535875700.17858.3.camel@med.uni-goettingen.de>
 <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
 <1535960372.32005.1.camel@med.uni-goettingen.de> <CA+55aFy=T6TmG_VcLvSTb02RyKTacxVCxwUALRn8_7cdoic0pA@mail.gmail.com>
 <1536042474.25086.1.camel@med.uni-goettingen.de> <CACT4Y+bBPRfjpWFXoZmruuot37_KTemZ0PHUNrFfOPW5+6JD7w@mail.gmail.com>
 <1536085338.17991.1.camel@med.uni-goettingen.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Sep 2018 09:35:09 +0200
Message-ID: <CACT4Y+aV8ts_v37RtovXC8epO+-JUwEb83cK3f-BeBFKjUKmNA@mail.gmail.com>
Subject: Re: VLAs and security
To:     "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 8:22 PM, Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
> Am Dienstag, den 04.09.2018, 10:00 +0200 schrieb Dmitry Vyukov:
>> On Tue, Sep 4, 2018 at 8:27 AM, Uecker, Martin
>> <Martin.Uecker@med.uni-goettingen.de> wrote:
>> > Am Montag, den 03.09.2018, 14:28 -0700 schrieb Linus Torvalds:
>
>
> Hi Dmitry,
>
>> Compiler and KASAN should still be able to do checking against the
>> static array size.
>
> ...and it is probably true that this is currently more useful
> than the limited amount of checking compilers can do for VLAs.
>
>> If you mean that there is some smaller dynamic logical bound n (<N)
>> and we are not supposed to use memory beyond that,
>
> Yes, this is what I mean.
>
> My concern is that this dynamic bound is valuable information
> which was put there by programmers by hand and I believe that
> this information can not always be recovered automatically
> by static analysis. So by removing VLAs from the source tree,
> this information ist lost.
>
>> then KMSAN [1] can
>> detect uses of the uninitialized part of the array. So we have some
>> coverage on the checking side too.
>>
>> [1] https://github.com/google/kmsan#kmsan-kernelmemorysanitizer
>
> But detecting reads of uninitialized parts can detect only some
> of the errors which could be detected with precise bounds.
> It can not detect out-of-bounds writes (which still fall into
> the larger fixed-size array) and it does not detect out-of-bounds
> reads (which still fall into the larger fixed-size array) if
> the larger fixed-size array was completely initialized
> before for some reason.

Well, I agree maybe it harms checking ability to some degree. But it's
always tradeoffs all way down. And in the end nothing can safe from
logical bugs (well, except for unit tests). With VLA one give a right
bound but the use wrong bytes in the buffer, or simply give a wrong
bound.
