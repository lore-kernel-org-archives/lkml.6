Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0013EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0A420C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDmX4jFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0A420C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbeGKQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:58:55 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39604 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388359AbeGKQ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:58:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so50471063oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kdSTn5I7PTQjrQq+3Uujrfz/4bKu9DYxCX3OwgZGZzU=;
        b=XDmX4jFs9u1CAMuQ3IiIGuHUxgyQt2MwO9ZOQ3db6gGrQvK56FQVhYfqyTfO3wkPfm
         G75HhzMZVV4rkLzaPHlOW9oAzM+mXtxPIuathCJ2aQ1AL8lUE6m1+bdSsQsIpRihw6K2
         lrpRtp1WBmTm7uGNpH4g00pYA7i5EdE/z0obdjkmGQ2PflUZ8NVSoa5YTPwnXbeXjsTV
         YyVryqsJx3w0a027aLP4wBdOwD/RCTL7CcCwLUeLtETRQR+kH8j5yR4XOmaFDCYW/As1
         QbvadbaeWt5vNzpb8W+9HxlNQ+y24XG0q1XQueW0gra6mJiMBeDvO/i03JeoSAkW16Hw
         CKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kdSTn5I7PTQjrQq+3Uujrfz/4bKu9DYxCX3OwgZGZzU=;
        b=fTL6yguGYm1vudARI1GkRseSkLJhaLQ5s8IPmK1Tv16J1z2IuTsnsrg65iwFAnvdWr
         W4+K6YA2dVAAik/WHiOAu7BZt1jL4Aqs5qW5JeK7XmGQZJ+5AjZsMGBmx9z9fwO0g1ia
         kZ7wNodS+Gyu3gIq++wLQQ303QJ2wOi+8sokyJGmnMTvvp8pWAdPHyLtfd+EZWlmndGc
         LEIKbgR2UNQBINNGt/UvDuQAIbRQLS8Y4nHv3FJ6KxzVaW0MPBIIzyIs0BLrFGFfpGvY
         2fUqUcCOjwmbXX9mJ4DLXqYntA+gJWkFOnSITTGkHN3WxVZZPnz/T9p863vnFrR+PSAw
         tZsw==
X-Gm-Message-State: AOUpUlHKGItGWHNxCNP7AirZCKm/7ag0fbsGvptjyEcBspV1wjp9WDVJ
        bCnqMwkvN/mY0sedaDpklOnwPP4AOXc5I5r8jw8=
X-Google-Smtp-Source: AAOMgpclq7qYWYDQogFuzZDOZWeJ1c18Irx2NWeUoW9ddhNWQpaV84r2kN2XgYsZm+Iu+MxdCMRBCWVAVoR48M1Zf8Q=
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr100859oif.104.1531328022525;
 Wed, 11 Jul 2018 09:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 09:53:41
 -0700 (PDT)
In-Reply-To: <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com> <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
 <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com> <CAMe9rOoZ=8ROyR6U3-JY+4hib2Bb5LGhBYzY5S_Xp38coj16aQ@mail.gmail.com>
 <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com> <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
 <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 11 Jul 2018 09:53:41 -0700
Message-ID: <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 9:49 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 07/11/2018 09:29 AM, H.J. Lu wrote:
>>>> # It takes about 3 hour to bootstrap x86-64 GCC and 3 hour to run tests,
>>>> TIMEOUT=480
>>>> # Run it every hour,
>>>> 30 * * * * /export/gnu/import/git/gcc-test-x32/gcc-build -mx32
>>>> --with-pic > /dev/null 2>&1
>>> Oh, fun, one of those.
>>>
>>> How long does it take to reproduce?
>> About 5 hours.
>
> It would be much appreciated if you can get a console of some kind on
> that system and try to get a full KASAN oops out of it.  Serial, usb
> debug, or maybe netconsole would probably work.

I don't have serial ports. I will try netconsole.

> I'll also try to get it running on a big system and see if it triggers
> faster there.

I have seen it on machines with various amounts of cores and RAMs.
It triggers the fastest on 8 cores with 6GB RAM reliably.

-- 
H.J.
