Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EE12EC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99075208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jcline.org header.i=@jcline.org header.b="cwoXwGyX";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cZErAtr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99075208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jcline.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934090AbeFKR4U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:56:20 -0400
Received: from a8-57.smtp-out.amazonses.com ([54.240.8.57]:42324 "EHLO
        a8-57.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932292AbeFKR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=rdybrs3533vx7mghocfwl3vdwgpl2v5u; d=jcline.org; t=1528739777;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=2etOOeTS/DUkeB06XUkHFR4WV2UjD2YnXzwYrsv7AuY=;
        b=cwoXwGyXUc55cmAwJr61MpLcsQrapFBe/YbJeNstk3XI0OlBXYs7WgJHgIpCm5Gb
        qoLrCDg1UYb3EAWTWYmXkxHy0X7jVHHSqg7wqjJK0PHl2Kz48R9ybyal33jCFvAiCSZ
        78VPgvUZSrMtNrU6uk4zHegFkaCyG4qcJBWUiJD0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1528739777;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=2etOOeTS/DUkeB06XUkHFR4WV2UjD2YnXzwYrsv7AuY=;
        b=cZErAtr4aQx/sbqYCR28M4Xj4gY75mJIYf0yAB/fEAL0cApVLD0ag3xCtJV4D9Fo
        jUdbQTJRoDPhi0tZdPFcB7b3HxIvv3Z8vwRsTfi2L7AUMg69UN8v/cgOdIn4LOo/aqe
        3iuzigCxsCB086Rs5fF+RXwD5DmNNJJLjbMja4gM=
X-Virus-Scanned: amavisd-new at jcline.org
Subject: Re: Regression: x86/tsc: Fix mark_tsc_unstable()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, len.brown@intel.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        Diego Viola <diego.viola@gmail.com>,
        mmarget@physik.tu-berlin.de
References: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
 <20180611141742.GP12198@hirez.programming.kicks-ass.net>
 <20180611143801.GH12235@hirez.programming.kicks-ass.net>
 <20180611153042.GI12235@hirez.programming.kicks-ass.net>
From:   Jeremy Cline <jeremy@jcline.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jeremy@jcline.org; prefer-encrypt=mutual; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <01000163effdcb29-f886b68d-bdb4-44c0-a68e-f749e10280fd-000000@email.amazonses.com>
Date:   Mon, 11 Jun 2018 17:56:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611153042.GI12235@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.06.11-54.240.8.57
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 11:30 AM, Peter Zijlstra wrote:
> On Mon, Jun 11, 2018 at 04:38:01PM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 11, 2018 at 04:17:42PM +0200, Peter Zijlstra wrote:
>>> On Mon, Jun 11, 2018 at 01:59:15PM +0000, Jeremy Cline wrote:
>>>> A user has bisected the problem to the v4.16 commit 1ab4ca7c59d4
>>>> ("x86/tsc: Fix mark_tsc_unstable()"). According to the reporter,
>>>> explicitly setting "tsc=" on the kernel command line causes the boot to
>>>> always succeed. All the users have Thinkpad T500s or T400s (Core 2 Duos)
>>>
>>> Weird. So Core2 typically triggers mark_tsc_unstable() in either
>>> intel_idle or processor_idle. ISTR testing that when I did the patches.
>>>
>>> When I make that mark_tsc_unstable() in the idle drivers unconditional
>>> and boot my ivb with that, it doesn't want to fail. I've booted the
>>> machine 5 consequctive times without issue.
>>>
>>> Let me try and checkout -stable, maybe something's up with that.
>>
>> Nope -stable seems to be working as well on the IVB (with modification).
>> I just dug up my T500 and that's actually still running the test kernel.
>> Let me try and build the -stable kernel for that.
> 
> 4.16.8 works without issue on my T500 with a debian/ubuntu like distro
> config.
> 

Adding mmarget (who bisected the problem) to the CC.

It might well be something Fedora-specific, then. I just noticed mmarget
commented over the weekend noting that they couldn't reproduce the
problem without using the initramfs generated during the RPM install of
the kernel. mmarget's theory was that it's a race condition that doesn't
occur when the initramfs takes long enough to unpack, but I don't know
enough about the early boot process *or* how Fedora's generating the
initramfs for RPM installs vs "make install" yet to know how likely that
is. I'm going to have to do some research.

Thanks for looking into this so quickly and also sorry if this turns out
to be a Fedora problem :(

Thanks,
Jeremy
