Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935966AbeEYIIZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:08:25 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42127 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935866AbeEYIIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:08:23 -0400
X-Google-Smtp-Source: ADUXVKJgPIywCq40mv+Bhz5zHq5ipSZozjr4JMXjk9od7fOgUabRWEyMk4XgAZbXmvAPANwk6dGxzgF70GzCX+oI+A0=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpnrPeG23Q+i6ASCeohGR3vfGQRwQzjwGsKE=c4TyAiQA@mail.gmail.com>
References: <3221007.8CUDle5b3u@aspire.rjw.lan> <201805181421.jU5hI6Bo%fengguang.wu@intel.com>
 <CAPDyKFpnrPeG23Q+i6ASCeohGR3vfGQRwQzjwGsKE=c4TyAiQA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 May 2018 10:08:22 +0200
X-Google-Sender-Auth: k3QZNw8ObeuhrdHgUl78uX4ixHM
Message-ID: <CAJZ5v0jFmVd_SkvgoXmi2Psqg5ALJRDsKzV8PiFysHQt9f0uog@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: EC: Dispatch the EC GPE directly on s2idle wake
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kbuild-all@01.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        "Wang, Wendy" <wendy.wang@intel.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 8:49 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Rafael,
>
> On 18 May 2018 at 08:10, kbuild test robot <lkp@intel.com> wrote:
>> Hi Rafael,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on pm/linux-next]
>> [also build test ERROR on v4.17-rc5]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Rafael-J-Wysocki/ACPI-PM-Dispatch-EC-GPE-early-on-s2idle-resume-if-LPS0-_DSM-is-used/20180518-070817
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>> config: arm64-defconfig (attached as .config)
>> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/acpi/ec.o: In function `acpi_ec_dispatch_gpe':
>>>> ec.c:(.text+0x239c): undefined reference to `acpi_dispatch_gpe'
>>    ec.c:(.text+0x239c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `acpi_dispatch_gpe'
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
> This breaks arm64 builds, would you mind to drop the offending patch
> from your linux-next branch?

Not really, but I can fix it.

> In case you haven't got time to check, I think the problem is caused
> by CONFIG_ACPI_REDUCED_HARDWARE_ONLY being set for arm64 builds. I can
> try to fix the problem, if you are busy and want help with it?

I'll have a look.
