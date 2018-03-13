Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeCMO1V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:27:21 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35290 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeCMO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:27:20 -0400
X-Google-Smtp-Source: AG47ELvJCLS8Vx20Co3YcDB+OEG3bKBrG9SaJX0JDLfyuAjMFdtv3cCJTd0cTVCwYn55py3sxCR6cnA9sP9K90IbYFo=
MIME-Version: 1.0
In-Reply-To: <357f8fbd-d079-8b75-aec6-96e59f5a9556@arm.com>
References: <20180313114607.2061209-1-arnd@arndb.de> <20180313114607.2061209-2-arnd@arndb.de>
 <357f8fbd-d079-8b75-aec6-96e59f5a9556@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Mar 2018 15:27:18 +0100
X-Google-Sender-Auth: qC_8Jvgk81keuPvNnwqTkC_NbVY
Message-ID: <CAK8P3a0jXmeNXwNkq+qOcaCvMSkzpVhOoq6QRs=3c2B1DqiaVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: scmi: add thermal dependency
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 3:09 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 13/03/18 11:45, Arnd Bergmann wrote:
>> A built-in scmi cpufreq driver cannot link against a modular
>> thermal framework:
>>
>> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_ready':
>> scmi-cpufreq.c:(.text+0x40): undefined reference to `of_cpufreq_cooling_register'
>> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_exit':
>> scmi-cpufreq.c:(.text+0x88): undefined reference to `cpufreq_cooling_unregister'
>>
>> This adds a Kconfig dependency that makes sure this configuration
>> is not possible, while allowing all configurations that can work.
>> Note that disabling CPU_THERMAL means we don't care about the
>> THERMAL dependency.
>>
>
> This newly added entry is only in arm-soc linux-next. Let me know if you
> want pull request with other possible fixes or you want to merge
> directly as it might be need to suppress these errors in your build
> system. For now I assume you will merge this directly in your tree, so
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I've applied it into my next/drivers branch now. Thanks for the Ack.
I assume the cpufreq maintainers will pick up the other one. I'm not
sure why I didn't run into that problem earlier, but today I saw both
for the first time.

      Arnd
