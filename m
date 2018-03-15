Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeCOOTr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:19:47 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:46302 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeCOOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:19:44 -0400
X-Google-Smtp-Source: AG47ELsaZRDt9jbwGFd81rJLNwETVkhkGupACHHSowY+/hPI4RYypKoZE86ZodruM6E6leVeQRtscVYov6nhz+1XJXc=
MIME-Version: 1.0
In-Reply-To: <20180314171914.tdwtppsvjsgxiqlv@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org> <20180314171914.tdwtppsvjsgxiqlv@lakrids.cambridge.arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Mar 2018 15:19:43 +0100
Message-ID: <CAPDyKFq5kZ5j-kBN=YyjGmn=_AEUEwe+QbSguEEAvsP87A0Kng@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 March 2018 at 18:19, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ulf,
>
> On Wed, Mar 14, 2018 at 05:58:10PM +0100, Ulf Hansson wrote:
>> For ARM, the PSCI firmware interface may be managing the power to the CPUs.
>> Depending on the SoC, CPUs may also be arranged in hierarchical manner, which
>> could add another level of complexity from a CPU idle management point of view.
>>
>> PSCI v1.0+ adds support for the so called OS initiated CPU suspend mode, which
>> enables a more fine grained method, allowing Linux to get more control, in
>> regards to being energy efficient. This is typically useful for these kind of
>> complex battery driven platforms.
>
>> The series is based on v4.16-rc5, but applies also as of today to Rafael's
>> linux-pm.git next branch. The code has been tested on a QCOM 410c dragonboard
>> and I except that test coverage should be increased by some more boards
>> shortly (for ARM64 with PSCI OSI support - only a few DT changes are needed).
>
> Do we have any numbers to show how this affects energy efficiency?

What kind of numbers are you looking for?

I don't have fresh energy numbers at hand, but of course I can run
some use cases and trying to get some data from the ARM energy probe.

What I have done recently, is of course to verify the solution using
trace_printk(). That in way by checking statistics from it, to for
example find out how often we enter an idle state for the CPU cluster
(and how long we stay in it).

However, as I have been working on the QCOM 410c, which currently uses
a proprietary ATF binary and which has the PSCI OSI mode supported.
Just leaving it in the Platform Coordinated mode and test to get a
comparison, won't actually say us much - because we don't know, in
what way QCOM implemented the PC mode (if at all), but of course I can
ask.

>
> Are there any other platforms with OSI support?

Our goal is to implement OSI support in the upstream version of ATF,
so anybody that want it can pick it for their ARM SoC.

We have so far played with a few hacks in ATF to enable OSI mode, as
to test this on a few other ARM SoCs (Hikey and a MTK developer board
for example).

Thanks for reviewing!

Kind regards
Uffe
