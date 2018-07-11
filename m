Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2033AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB51F20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdez+S81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB51F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbeGKPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:45:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46814 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732452AbeGKPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:45:52 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so50052479oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cFaIxKiRkLdZoOsCRxHiV+OQRxSfXPA7u7YEMeQ0qkY=;
        b=Cdez+S81Fd7Yw7bXeglzWnBoDb9GA4lj8ovEzMkLaRBdpOGp2fCxdaFN5GXcYnqTiK
         tSyKI6XXtOpYCBWEWyczOcAnd5L77C9ZV8kbTejjr9H0q/2lMwsZuXMdgsPOK26qC1YG
         RWHDMfRsTxqKwim2pKWqRxWKa8IFT6BwVDO7jZyk4e1/UNuHrXY0keZN+yjtE0KjPCY8
         rrOj+jKmfygNLAVBczpyq051NZALJRqHnlDVsSqQqJn6aM1TC2oa+0fo9HA9upBiHIp1
         bvckImaeaH1tTwFSQHtiElIjme4PPEjtauvIOvyQjAgoRCoOIXouUy+ml8Dd3c8p0tg4
         jwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cFaIxKiRkLdZoOsCRxHiV+OQRxSfXPA7u7YEMeQ0qkY=;
        b=UVf/cBswaGa3eDn834yfRLqOHPz+rPI9x98M4GojSveP/BxmFwAwnOs+RmRwhRV6xS
         jKQhTgYUnG6mmUyob20KtvRKFZ/DEeHDABpLjOqa7zNjF+jNTMwDdkD/RSen5e/TNghF
         4D58DOT8LFjtETEdodMYn6kV9nGzzirunkDzzv2qt1WyorC5pj4JBnhqaBTux41S1oNP
         EPfIvyMbb7dax0Auwg2KeryO1NUd7WnbPY82zw72rnFv60JuLdQoEcKb4DuyQyX3SX4l
         ssAEMTyd8rIzkytQJD++f4cLTPNuyHgTpeWGFUEym3taw6ycof381hDbDDHC4Egf9nFG
         gBkw==
X-Gm-Message-State: APt69E1yUkPfUDdFPvWw1oRy+L+3Dm+aHwjQqioYWbEf1EJ5dD28/A9D
        j5lf3fPbfAroq/538AUL+WD3JRMXXxSJj0rqQO8=
X-Google-Smtp-Source: AAOMgpecB3S8UT1U0QitWt1X95anS07jwP8G2um6+M5KSa70iiQXoV24VgwDSS+cYrUZWHAwbJFswU/3x6zGnupY3qE=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr31219305oih.311.1531323657363;
 Wed, 11 Jul 2018 08:40:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 08:40:56
 -0700 (PDT)
In-Reply-To: <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com> <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
 <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com> <CAMe9rOoZ=8ROyR6U3-JY+4hib2Bb5LGhBYzY5S_Xp38coj16aQ@mail.gmail.com>
 <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com> <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 11 Jul 2018 08:40:56 -0700
Message-ID: <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
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

On Wed, Jul 11, 2018 at 8:13 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 07/11/2018 07:56 AM, H.J. Lu wrote:
>> On Mon, Jul 9, 2018 at 8:47 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>>> On 07/09/2018 07:14 PM, H.J. Lu wrote:
>>>>> I'd really want to see this reproduced without KASLR to make the oops
>>>>> easier to read.  It would also be handy to try your workload with all
>>>>> the pedantic debugging: KASAN, slab debugging, DEBUG_PAGE_ALLOC, etc...
>>>>> and see if it still triggers.
>>>> How can I turn them on at boot time?
>>> The only thing you can add at boot time is slab debugging, and it's
>>> probably the most useless of the three that I listed since you're not
>>> actually seeing any slab corruption.
>>>
>>> The rest are compile-time options.
>> I enabled KASAN, slab debugging, DEBUG_PAGE_ALLOC and disabled
>> KASLR.  Machine locked up.  Here is the last kernel message before locking
>> up.
>
> KASAN looks to have caught it, although it scrolled off the screen.  I
> can certainly imagine the oops you saw earlier being caused by stack
> corruption.
>
> Sounds like we need to reproduce this in an environment that can
> actually capture a real oops.  Can you share more about your workload?
> I'll see if I can get it to reproduce in a VM.

This is a quad-core machine with HT and 6 GB RAM.  The workload is
x32 GCC build and test with "make -j8".  The bug is triggered during GCC
test after a couple hours.  I have a script to set up my workload:

https://github.com/hjl-tools/gcc-regression

with a cron job

# It takes about 3 hour to bootstrap x86-64 GCC and 3 hour to run tests,
TIMEOUT=480
# Run it every hour,
30 * * * * /export/gnu/import/git/gcc-test-x32/gcc-build -mx32
--with-pic > /dev/null 2>&1


-- 
H.J.
