Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010CDC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A0A2415C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF4Q7tWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A0A2415C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeGELE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:04:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38753 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbeGELE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:04:26 -0400
Received: by mail-lf0-f65.google.com with SMTP id a4-v6so6608346lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SBIU8mJwqceYPkVd6F5eyRUeCJ0GWkoAyBk5rLNHqJc=;
        b=pF4Q7tWhgU1NcbbhuChThPR3ts2IXXt8cUtJcVC/As1JI4VXBhQWIaT1gYlFQW62NZ
         r4Mh1KJmiyvvXfoB8J/usYQi11+9QXL724nATKCUCDxZzUKSatYlaKytND9/hxHZCOoi
         egz5bLaJZYsVYd53Hq0QZkxTHejBfX3bQuC/Dn0Cxzer4suemcAM/WC9abQfTnQFP4Ff
         myhZExzXevuORwhG3OMpCMXMw0o6X2g8hpLzCJdM5nm87R/9zyYSawyXU8TeEJZSm2Kp
         a3wm9DuExvzwmcbDLfZSLC8Uu785gTkeyGcZyyjpAGGFYs4JjTX/Oz4+ynbcGNmmxfFs
         nEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SBIU8mJwqceYPkVd6F5eyRUeCJ0GWkoAyBk5rLNHqJc=;
        b=CbMn4m9/Pu7rtmmcogJs9Aacp6xVPdYnz0nxQfp3m+dOzw5lb7SiApO3HaaSyFK1Fy
         dGX3UlHkLlfcRI7YjjuAh1iCvAh5OH9tj0QOMNyPqI8X2sDskQEeOWKFtbmiZiG3l4fd
         JkjXeE7DKedRjzPKmdUeD9HXbMoMx/EZG+O0W6AR8dBSj2biibuSIeWiOfN/gOr/hYZi
         AlIXqGGSmdS4CbGkgIjlDJvA+eJ3BpmB/PiUB8IanXrcrdHvoikoF9+zm3CLUeyRbQ7/
         s/E3ODw2uTaUc8kBaDv81WeLFNvajSbnzScDzCCRRSeW/OgZFaZLEMC6C3/yTdunEyiB
         2sQw==
X-Gm-Message-State: APt69E2SmMyvCHp7ZneBAqe35yRSf3eVvgUe/lOhN2IaCCGxe/1UZ9wC
        nPcI+RbLam10wTgaAmQGxSpJokPE2M5bIefNrQCNqVKG
X-Google-Smtp-Source: AAOMgpd+mTUSpg7Bectf7bam5SxpJ67kYh5i8ht7rzY2zKgHbv5p+zsAnqLGTfGX0GgbsCsVwq97+NA+tK2hpEqZ2g0=
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr2885843lfe.148.1530788664764;
 Thu, 05 Jul 2018 04:04:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 04:04:23 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1807051254050.21817@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
 <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com> <alpine.LRH.2.21.1807051254050.21817@math.ut.ee>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Jul 2018 13:04:23 +0200
X-Google-Sender-Auth: H8BWQi4P54BTIxik_ofiqn0FCdk
Message-ID: <CAK8P3a3x+Qm7UWPBESi4=tzpvqscVxVg14j5PBoPqS0vJD2VZA@mail.gmail.com>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 11:54 AM, Meelis Roos <mroos@linux.ee> wrote:
>> > I tried 4.18.0-rc1-00023-g9ffc59d57228 and now
>> > 4.18.0-rc3-00113-gfc36def997cf on a 32-bit server and then some other
>> > 32-bit machines, and got half-failed bootup - kernel and userspace come
>> > up but some services fail to start, including network and
>> > systemd-journald:
>> >
>> > systemd-journald[85]: Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at ../src/basic/time-util.c:53, function now(). Aborting.
>> >
>> > I then tried multiple other machines. All x86-64 machines seem
>> > unaffected, some x86-32 machines are affected (Athlon with AMD750
>> > chipset, Fujitsu RX100-S2 with P4-3.4, and P4 with Intel 865 chipset),
>> > some very similar x86-32 machines are unaffected. I have different
>> > customized kernel configuration on them, so far I have not pinpointed
>> > any configuration option to be at fault.
>> >
>> > All machines run Debian unstable.
>> >
>> > 4.17.0 was working fine.
>> >
>> > Will continue with bisecting between 4.17.0 and
>> > 4.18.0-rc1-00023-g9ffc59d57228.
>>
>> That does sound like it is related to my patches indeed. If you are not
>> yet done bisecting, please checkout commit e27c49291a7f ("x86: Convert
>> x86_platform_ops to timespec64") before you try anything else, that
>> one is the top of the branch with my changes. If that fails, the bisection
>> will be much quicker.
>
> This commit was fine. So it's likely something else.

Ok, at least that's a relief for me, even if it didn't help you ;-)

I looked at the sources a bit and found that the assertion is triggered
in systemd whenever we try to read a clock that the kernel does not
provide. You have CONFIG_POSIX_TIMERS and
CLOCK_RTC_CLASS set, so all the normal clocks should be
operational, and I don't see anything unusual being passed into
clock_gettime() from systemd.

If you are able to find out what clock_id is passed in here, and what
the return code is, that might still lead to a solution more quickly
than continuing the bisection.

      Arnd
