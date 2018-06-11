Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 92A6FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CEA208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHiCL7bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CEA208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934654AbeFKTX4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:23:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40910 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934630AbeFKTXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:23:52 -0400
Received: by mail-yb0-f194.google.com with SMTP id v17-v6so7089298ybe.7;
        Mon, 11 Jun 2018 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kaM7J9qGuj3Zo+f53UrU3PN0U2vygK/bHsRmyGrTwf8=;
        b=DHiCL7bVjXa7tIMpidbHzAhm2YwfbsOwJQB8HUDThUrNnVVcef+o5RlXlQ6YsoNe8V
         btH147hGLde15l5q6BfKN1qOJquRvBYeUAA1m62AgMlk3I6JaPeaUDDn07DdgPaGqX1b
         vPJ1P3GxLr0vfk3Oc8JlUW3e8XZlv5feDt0QtgZBl2K8Qdppz+GhWpO3uHmq/f68LFio
         0DRsxpB0JILX0t5+jbGeZh4vyPOihksOC7POajx5I7kK8rqXOuTW4ks0dKK6Xa6twLbO
         6XpcMah2OVjhvw2tAHtHhBH+nZ2AtYpKMVbqD83/N5bv0/059IiR2LLoWG3Nz8aF3pEo
         7nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kaM7J9qGuj3Zo+f53UrU3PN0U2vygK/bHsRmyGrTwf8=;
        b=ksGhYflTrEmcufxgrqNbmYixDC6xqK/5cIcjNnK9d+FRh+z+AVA+x7MH4zCe0+xHc/
         X1x6ydz+VQp8+q6yOB7Wc/nsQJ5yd4VYAFDBsH2Tq9aqeAgVAUDOYhHUUgmqYzr4aZwh
         sIkRkyoDDmogsoP77ifUXyI307KTI3iTeWUryRSQ/YcE+hiumqUzYaUlgDl2ryUoLMsP
         Lc8+C3bNFHl265kKlkpSu6EkHAqlXd1X8QlJ5QADR4z7Ma3Aqn0QwiAETNFzJ6pz6xB3
         lm1za8qVRWbBCcabtOEGb5eiETQ+Hb/LAjPWDVMR7yELS4uy4zT8ZwFHm3fIU1IyGLFV
         /07g==
X-Gm-Message-State: APt69E3DZgp/stPtWSe3j3gDmB4UW6dZOAr/F79OBv7VNOZ6/URDoqXl
        y2TmpvyNBRz7byC1/uz+UULa8BWXwddmkRZ5n4g=
X-Google-Smtp-Source: ADUXVKLqg/fDBJ/5YBFZxhSHBo/D8GAkg6rYXG1Yc3bRYs72Du0Vs+acwgobfxfJYBP+32hye88NpcWZtZlQpdFMg5E=
X-Received: by 2002:a25:ac12:: with SMTP id w18-v6mr261582ybi.77.1528745031304;
 Mon, 11 Jun 2018 12:23:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:a0cb:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 12:23:50
 -0700 (PDT)
In-Reply-To: <01000163f00c1dd6-11e49be4-fe96-49cf-bbf6-8d951874faa1-000000@email.amazonses.com>
References: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
 <20180611141742.GP12198@hirez.programming.kicks-ass.net> <20180611143801.GH12235@hirez.programming.kicks-ass.net>
 <20180611153042.GI12235@hirez.programming.kicks-ass.net> <01000163effdcb29-f886b68d-bdb4-44c0-a68e-f749e10280fd-000000@email.amazonses.com>
 <01000163f00c1dd6-11e49be4-fe96-49cf-bbf6-8d951874faa1-000000@email.amazonses.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Mon, 11 Jun 2018 16:23:50 -0300
Message-ID: <CA+ToGPHtL0Fd3TgqakqmEtKi7z6jszpoEdJcO+EyD9yh8pGTyQ@mail.gmail.com>
Subject: Re: Regression: x86/tsc: Fix mark_tsc_unstable()
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, len.brown@intel.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        mmarget@physik.tu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 3:11 PM, Jeremy Cline <jeremy@jcline.org> wrote:
> On 06/11/2018 01:56 PM, Jeremy Cline wrote:
>> On 06/11/2018 11:30 AM, Peter Zijlstra wrote:
>>> On Mon, Jun 11, 2018 at 04:38:01PM +0200, Peter Zijlstra wrote:
>>>> On Mon, Jun 11, 2018 at 04:17:42PM +0200, Peter Zijlstra wrote:
>>>>> On Mon, Jun 11, 2018 at 01:59:15PM +0000, Jeremy Cline wrote:
>>>>>> A user has bisected the problem to the v4.16 commit 1ab4ca7c59d4
>>>>>> ("x86/tsc: Fix mark_tsc_unstable()"). According to the reporter,
>>>>>> explicitly setting "tsc=" on the kernel command line causes the boot to
>>>>>> always succeed. All the users have Thinkpad T500s or T400s (Core 2 Duos)
>>>>>
>>>>> Weird. So Core2 typically triggers mark_tsc_unstable() in either
>>>>> intel_idle or processor_idle. ISTR testing that when I did the patches.
>>>>>
>>>>> When I make that mark_tsc_unstable() in the idle drivers unconditional
>>>>> and boot my ivb with that, it doesn't want to fail. I've booted the
>>>>> machine 5 consequctive times without issue.
>>>>>
>>>>> Let me try and checkout -stable, maybe something's up with that.
>>>>
>>>> Nope -stable seems to be working as well on the IVB (with modification).
>>>> I just dug up my T500 and that's actually still running the test kernel.
>>>> Let me try and build the -stable kernel for that.
>>>
>>> 4.16.8 works without issue on my T500 with a debian/ubuntu like distro
>>> config.
>>>
>>
>> Adding mmarget (who bisected the problem) to the CC.
>>
>> It might well be something Fedora-specific, then. I just noticed mmarget
>> commented over the weekend noting that they couldn't reproduce the
>> problem without using the initramfs generated during the RPM install of
>> the kernel. mmarget's theory was that it's a race condition that doesn't
>> occur when the initramfs takes long enough to unpack, but I don't know
>> enough about the early boot process *or* how Fedora's generating the
>> initramfs for RPM installs vs "make install" yet to know how likely that
>> is. I'm going to have to do some research.
>>
>> Thanks for looking into this so quickly and also sorry if this turns out
>> to be a Fedora problem :(
>
> Attached is the Fedora configuration for 4.16.8, as well, in case you'd
> like to test it with that.
>
> Thanks,
> Jeremy

Hi Jeremy,

I've compiled 4.16.8 with your config and booted my machine about 10
times with this kernel, and I'm unable to reproduce the issue.

Maybe it's an issue with the Fedora initramfs?

Diego
