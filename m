Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935516AbeCHFgB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:36:01 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:40200 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935430AbeCHFf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:35:58 -0500
X-Google-Smtp-Source: AG47ELv6aDD3zRZF2OimR14/girKiJpxmnnyHhotYux91f6LrXkmWWbemRIxGxePTA7dZifyAVuaoNlTjLKlST6UgTk=
MIME-Version: 1.0
In-Reply-To: <CAOh2x=njFxcwDfQs1g3-Estrun5j=fSYVnG-EaVw0UcRaDKsSg@mail.gmail.com>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com> <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
 <CAOh2x=njFxcwDfQs1g3-Estrun5j=fSYVnG-EaVw0UcRaDKsSg@mail.gmail.com>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Thu, 8 Mar 2018 11:05:55 +0530
Message-ID: <CAP245DWAnYqbKJ_+NMqYvP9suwgmmkZ6twSBfAD64FxqztgnuA@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 10:19 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Wed, Mar 7, 2018 at 4:29 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> Cpufreq/cpuidle are designed to control a single parameter while
>> thermal framework is trying to mitigate heat from several disparate
>> sources that are throttled in different ways. Besides, cpufreq/cpuidle
>> have somewhat mature governors. Cpuidle has only one governor (for
>> tickless) - menu governor, cpufreq has ondemand in mainline, replaced
>> by interactive in android and hopefully soon both will be replaced by
>
> Interactive and schedfreq are already removed from Android 4.4 and 4.9.
> It used schedutil now.

Good to hear.

>> schedutil.
>>
>> Badly configured cpufreq/cpuidle/devfreq only leads to wasted power,
>> while badly configured thermal zone leads to the loss of operation
>> e.g. reboots, too hot to touch, etc.
>
> I don't think such heat-ups will happen right during boot, where some
> init.rc should
> come up and change the governor.

Interestingly enough, there are some patches that make the thermal
framework start earlier to deal with boot-time thermal issues. I
expect to post them soon. :-) These are required, for example, if the
device goes into a reboot loop - the device might not even make it to
the point in userspace where the governors are setup. In such a loop,
the temperature constantly keeps increasing.

> Over that if we are worried about production images only, then what prevents us
> to select the right default governor in the defconfig ? We shouldn't
> be worried about
> multi-platform kernels for production images.

I was refering to the 'make defconfig' out-of-box experience that
makes the majority of developer boards/devices out there stable to
work on. I can't do that today.

Regards,
Amit
