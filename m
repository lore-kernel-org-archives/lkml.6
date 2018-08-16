Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A61C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D083B208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="TNmf8sEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D083B208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389864AbeHPLPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:15:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54339 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeHPLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:15:44 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so5231213itb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z48r74tQ3NwkGpmt555QpjEUIvUf64n2+ljLFiTAxI8=;
        b=TNmf8sEJbQC/mrjwaoMaeLKKJ8DJ3K3AZIedpdG8l8/gqNAzeyiWribtrJrTWh0wc9
         oGY03fX5/oIHsi71iA0nVZ1aboCVUnX27Tm3kMYWVIpNyBavkXf5zUCAPmXznLB8bv/s
         8jS8++1yopCRJ5Z+nZbN+AxWuFirY0TyR0k+FzV5/T4zMYUj0lkIZ0qlEZTAngmpGn/1
         1/SY2nVJnUZepAbiJfbEVCVvhh6DZMZVYu6Fx9jLz3l6V8tz45JYBdq9euyH4G3u0jwO
         TpqOYNmG0SlSYTt0bwas3FwkfPC6zuMRf0jiOafds2cVf8jECYdXAksd/1Hc8KnsQqSH
         1KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z48r74tQ3NwkGpmt555QpjEUIvUf64n2+ljLFiTAxI8=;
        b=JUWF2epvCtAQvp8XdYKHHGjd/2YmGGyj9tWSnOheYFOVmNjR9fP19lbiTWdYHN4L3q
         fs+e/HrgdgoKjHz2Gz9ui22rKE8jHK1w7iR7ihb4V88uNCfgC1XZ0wS+f0Mow3gpIOa9
         67XpjaDubd8CPslanypNqelBGvx6OFfinfwqyGVYh19uMz29vHc8Zwfn+/2BH/MpBvTo
         UOn63XN5O2jVStiIRyEUhPTTuZo7LnqQyAtA8C2sCpCAakdxY2lXAqH4TzyMk9s6BcE+
         nZRV4an/rNBbxVvLTIHi5DlJKavlX69fEeQ+rdTZ4nXMwDa98cm3BYvJFKdvn8ZFpwWX
         rSig==
X-Gm-Message-State: AOUpUlHDN3XEGJXvA/6EYMQp7gjVCVYyp69AgHiWRFW9UIFF75FQwJ9+
        JF1YuEAZi94zIWdMFedTHjjmpiecJjZ9nZ2ta+8Y4Q==
X-Google-Smtp-Source: AA+uWPxn8HHQwsqIfgrBSjGGWFtob9kisQQkRss6CpfOuIFloDNj7NhAs2gzonLq2ht2ew65YMUsTb0ISxa+6Eyf0O0=
X-Received: by 2002:a24:3b0e:: with SMTP id c14-v6mr22038638ita.42.1534407535286;
 Thu, 16 Aug 2018 01:18:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8704:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 01:18:54
 -0700 (PDT)
In-Reply-To: <CAJZ5v0gKfyB7=5ZGj9uXejoBjkuf2snsKwYJM2Ar1_Vg8A8SCg@mail.gmail.com>
References: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
 <CAJZ5v0gKfyB7=5ZGj9uXejoBjkuf2snsKwYJM2Ar1_Vg8A8SCg@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 16 Aug 2018 16:18:54 +0800
Message-ID: <CAB4CAwfdwU6FQVEWWO2dLw-RJHTpqWeuk_BiH04ssE=iCOrJ+A@mail.gmail.com>
Subject: Re: Keyboard lost after exit s2idle on ASUS UX433FN
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 3:26 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Aug 16, 2018 at 4:45 AM Chris Chiu <chiu@endlessm.com> wrote:
>>
>> Hi,
>>     We recently hit a weird problem on the ASUS laptop UX433FN with
>> latest Intel Core i7-8565U CPU on kernel 4.18. The keyboard stops
>> functioning after exit s2idle. It stops firing interrupts after resume
>> on any keypress. We thought it should be something wrong with i8042
>> driver or even atkbd driver, so we tried to skip the suspend/resume
>> path of i8042 and input devices but no luck.
>>
>>     Then we tried to hack the s2idle code to fail right before it goes
>> into the idle state to find out which code really cause the keyboard
>> broken. It comes with an interesting finding that if it aborts s2idle
>> before cpuidle_resume() in s2idle_enter(), the keyboard is fine. If it
>> aborts after cpuidle_resume, then the keyboard down. At least it
>> proves that even with dpm_noirq_begin() and
>> dpm_noirq_suspend_devices() executed, the keyboard is still alive.
>> There should be something wrong with the cpuidle.
>>
>>     Going deeper into intel_idle_s2idle() which is invoked by
>> cpuidle_enter_s2idle(), we found that the keyboard interrupt will no
>> longer function after mwait_idle_with_hints() which just simply
>> executing intel monitor and mwait instructions. So I don't know what
>> should be the next step I can take. Can anyone give some pieces of
>> advice?
>
> It may indicate that the deepest C-states used by s2idle simply don't
> work correctly on the affected system.
>
> To verify this, you can try to disable the deepest C-states via sysfs
> using the "disable" attribute under
> /sys/devices/system/cpu/cpuX/cpuidle/stateX/
>
Thanks for the great help. I can have the keyboard work after s2idle with
the following command

echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/state8/disable

cpuX, X can be 0 to 7 on this CPU.
And only state8 disable would work, it fails on state 0~7 disabled.

There're 9 (0-8) states on the cpuidle of this machine. However, I have another
laptop with the same CPU Intel Core i7-8565U which only have 4(0-3) states
under the same '/sys/devices/system/cpu/cpuX/cpuidle/' entry. Sorry that I
don't have enough background knowledge about cpuidle. I thought the #C
state should be depend on CPU, but why the same i7-8565 has different
number of C-states?  And for this case, should I just disable C-8 state or there
should be a generic fix with it?

> Is s2idle the default suspend method on that system?  If so, have you
> checked whether or not suspend-to-RAM works too?
>

Yes, it's default s2idle. If I do 'echo mem > /sys/power/state', the keyboard
would still fail.

> Thanks,
> Rafael
