Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DFBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA1E20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFyAKTE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA1E20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbeGKRl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732860AbeGKRl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:41:58 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A5521019
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531330596;
        bh=U1OKIf61oeLkQ1T3BOuYv0hdnskAETKjIyaIvMlsAqA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HFyAKTE7qABVBxV+Y+ZeWZ1Vbdusg5aNVQvAceonkL9AzVr2B60igOdPla7I4Ehbz
         MpdLAYPeBjGBmoWneA2MVzkekfB727t3D5YaqVF8+H64xCqS0KTS7UpB7sE3NYGNYL
         VOavstvvfjHjUtrhk+tQDPyWAorACr/YquYCK98c=
Received: by mail-wr1-f51.google.com with SMTP id t6-v6so18991866wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:36:36 -0700 (PDT)
X-Gm-Message-State: APt69E17sVlY4Je7y3V5tZ1KXJkPp8Sva7wNCVC5n5Xy9mGG0Ud4UeI6
        0e+mYVrGXrTHzYszUXVxqC6fypos3+w63YH2GKqXLA==
X-Google-Smtp-Source: AAOMgpfbh5WJdeaB27x0xVytdm5WR+ajfwTeZxv7xYl6GO1CQOkiidbYvj1gREaeMlAmy9uFi4CJw7EMs94NoR9YRRQ=
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr20185293wrk.221.1531330594663;
 Wed, 11 Jul 2018 10:36:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:36:13
 -0700 (PDT)
In-Reply-To: <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com> <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
 <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com> <CAMe9rOoZ=8ROyR6U3-JY+4hib2Bb5LGhBYzY5S_Xp38coj16aQ@mail.gmail.com>
 <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com> <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
 <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com> <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com>
 <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 11 Jul 2018 10:36:13 -0700
X-Gmail-Original-Message-ID: <CALCETrXEBhNsxZtbiG+Mh2r3hka27qRgn6J=mx-krXq4n86Ayg@mail.gmail.com>
Message-ID: <CALCETrXEBhNsxZtbiG+Mh2r3hka27qRgn6J=mx-krXq4n86Ayg@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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

On Wed, Jul 11, 2018 at 10:29 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
> On Wed, Jul 11, 2018 at 9:53 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
>> On Wed, Jul 11, 2018 at 9:49 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>>> On 07/11/2018 09:29 AM, H.J. Lu wrote:
>>>>>> # It takes about 3 hour to bootstrap x86-64 GCC and 3 hour to run tests,
>>>>>> TIMEOUT=480
>>>>>> # Run it every hour,
>>>>>> 30 * * * * /export/gnu/import/git/gcc-test-x32/gcc-build -mx32
>>>>>> --with-pic > /dev/null 2>&1
>>>>> Oh, fun, one of those.
>>>>>
>>>>> How long does it take to reproduce?
>>>> About 5 hours.
>>>
>>> It would be much appreciated if you can get a console of some kind on
>>> that system and try to get a full KASAN oops out of it.  Serial, usb
>>> debug, or maybe netconsole would probably work.
>>
>> I don't have serial ports. I will try netconsole.
>>
>>> I'll also try to get it running on a big system and see if it triggers
>>> faster there.
>>
>> I have seen it on machines with various amounts of cores and RAMs.
>> It triggers the fastest on 8 cores with 6GB RAM reliably.
>
> Here is the first kernel message.

I find myself wondering if this is somehow the same issue as below:

https://syzkaller.appspot.com/bug?id=2c33dff2a2138d709b43671603dc01d65b28a689

We could plausibly have a problem with the entry code, but I don't see
anything relevant in the changelog.
