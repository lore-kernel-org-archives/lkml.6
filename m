Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeECIbN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:31:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43985 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeECIbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:31:07 -0400
X-Google-Smtp-Source: AB8JxZrQ1MLYE/1aqSsMpHvR6HY2Fdi3KBrumIN01pSF1WHIzDALSsZXZLxxeRjkUpc3JlHCkZzjFrE/KcWnHSNDB+M=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrUmNyMQ9Aqgwg-Ncf08fYgAqaY_MckvxqsrUq7mr-LQg@mail.gmail.com>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org> <CAPDyKFrUmNyMQ9Aqgwg-Ncf08fYgAqaY_MckvxqsrUq7mr-LQg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 May 2018 10:31:06 +0200
X-Google-Sender-Auth: 0EdrzPKR-DxuhPC7Orz44vC5qeU
Message-ID: <CAJZ5v0gze0Purjaq0U3gqcCBfjW3pHBUMY8LdaYuY9ZfP2xTVQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] PM / Domains: Fixup error paths with dev_pm_domain_attach()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 April 2018 at 10:52, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> While I was on working adding support for multiple PM domains to genpd, I
>> stumbled over several problems in the error path related to
>> dev_pm_domain_attach(). Hence, I decided to fix these problems first, which is
>> what this series intends to address.
>>
>> There first patch is material for stable, as it fixes a real bug in genpd,
>> while the rest may be considered as improvement of the error paths when devices
>> fails to be attached to their PM domains.
>>
>> I am seeking acks from subsystem maintainers and suggest with funnel the hole
>> series through Rafael's linux-pm tree, unless there are objections to that of
>> course.
>>
>> Ulf Hansson (11):
>>   PM / Domains: Fix error path during attach in genpd
>>   PM / Domains: Drop comment in genpd about legacy Samsung DT binding
>>   PM / Domains: Drop redundant code in genpd while attaching devices
>>   PM / Domains: Check for existing PM domain in dev_pm_domain_attach()
>>   PM / Domains: Allow a better error handling of dev_pm_domain_attach()
>>   amba: Respect all error codes from dev_pm_domain_attach()
>>   driver core: Respect all error codes from dev_pm_domain_attach()
>>   i2c: Respect all error codes from dev_pm_domain_attach()
>>   mmc: sdio: Respect all error codes from dev_pm_domain_attach()
>>   soundwire: Respect all error codes from dev_pm_domain_attach()
>>   spi: Respect all error codes from dev_pm_domain_attach()
>>
>>  drivers/acpi/device_pm.c     |  9 +++------
>>  drivers/amba/bus.c           |  4 ++--
>>  drivers/base/platform.c      | 17 ++++++++---------
>>  drivers/base/power/common.c  | 10 +++++++---
>>  drivers/base/power/domain.c  | 45 +++++++++++++++-----------------------------
>>  drivers/i2c/i2c-core-base.c  |  2 +-
>>  drivers/mmc/core/sdio_bus.c  |  2 +-
>>  drivers/soundwire/bus_type.c | 15 +++++++--------
>>  drivers/spi/spi.c            | 11 ++++++-----
>>  include/linux/acpi.h         |  2 +-
>>  include/linux/pm_domain.h    |  2 +-
>>  11 files changed, 52 insertions(+), 67 deletions(-)
>
> Rafael,
>
> I understand if you are busy so this is not a ping. :-)
>
> However, perhaps I can simplify by sending you a PR with these!?

Yes, please.

I'm going to have a look at the patches anyway, but I'm not expecting
to see anything objectionable in them honestly. :-)
