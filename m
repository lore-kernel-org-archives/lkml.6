Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525264294; cv=none;
        d=google.com; s=arc-20160816;
        b=CqOb89bbZbSwXXspnOzejGuZb2zrwej4NfYYF4ZBg1EdFbWxMssEkLQYTsWVzR8f/0
         q/KpPP8CKc8LfpGzJquOZ63JEiCGv0weIk1n001dMRaIO7jvJXPi0SzO4O9HVL+PiK57
         suF1YKrj4y6W0HBYGoXmaOaAsgVW3n8RPbshk1EMPapD7gv7zP+2FKmVTa8Bj7hwvULl
         08kNIthwQWTZ18iqMjw95kfB9ESzwsD15fQ4jqrSUka7gePfbn24hpagdo0Gg0LFncRQ
         V1ENH4kitVhUoG70He8LvCtI6RZnYp7FLnKCYba/6bZT2EmQ4ZQhNXjVOV6Qttlx2eOR
         p/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xjuCVMqjVWcjkStmvKCyAsxTTK6QAWfkK5gmdzjzdz4=;
        b=adzsdZRfj9T0TMFXUdYFZ12kDvB+GszUx3s2JdlDHbrfIq/milR4a6sKN3bYjDZOuF
         2Du+gLPnbtkrDI0zaCg/yH5EmfulelxFX+Cm4wuJpocJ4w+dsKktJIEUGptn+d8DbjTi
         OWHs70xKuSz5V9yrJ3QtFy0fNma47c62r59UlUYXfznbAR9CH2NIihoX5YrBhhFvuBf2
         kAiDRYxZu852qlZQWJUMWAgRPQ2jmFG46IbKy7r1bOtin0vq3E5knNqcgl+7WV+2KkgI
         BqCdEg/TdCcTmzDd4rKVL+EMGdIbNTIu2NlpQBhO5z73Hj8KjaVsHpaH/3yJhMBbtx8J
         IG5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kbnZod7x;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kbnZod7x;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoW3YJDs3SqYquCm7PVcvJEVfnY1NLrgJy2psaRUYcu5tY1aQvQCl1UNPs6lr6JLHfGHka0Nn7cFOrIxHBQeTg=
MIME-Version: 1.0
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 May 2018 14:31:33 +0200
Message-ID: <CAPDyKFrUmNyMQ9Aqgwg-Ncf08fYgAqaY_MckvxqsrUq7mr-LQg@mail.gmail.com>
Subject: Re: [PATCH 00/11] PM / Domains: Fixup error paths with dev_pm_domain_attach()
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM <linux-pm@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Mark Brown <broonie@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>,
	Russell King <linux@armlinux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798215227519391?=
X-GMAIL-MSGID: =?utf-8?q?1599355533613212057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26 April 2018 at 10:52, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> While I was on working adding support for multiple PM domains to genpd, I
> stumbled over several problems in the error path related to
> dev_pm_domain_attach(). Hence, I decided to fix these problems first, which is
> what this series intends to address.
>
> There first patch is material for stable, as it fixes a real bug in genpd,
> while the rest may be considered as improvement of the error paths when devices
> fails to be attached to their PM domains.
>
> I am seeking acks from subsystem maintainers and suggest with funnel the hole
> series through Rafael's linux-pm tree, unless there are objections to that of
> course.
>
> Ulf Hansson (11):
>   PM / Domains: Fix error path during attach in genpd
>   PM / Domains: Drop comment in genpd about legacy Samsung DT binding
>   PM / Domains: Drop redundant code in genpd while attaching devices
>   PM / Domains: Check for existing PM domain in dev_pm_domain_attach()
>   PM / Domains: Allow a better error handling of dev_pm_domain_attach()
>   amba: Respect all error codes from dev_pm_domain_attach()
>   driver core: Respect all error codes from dev_pm_domain_attach()
>   i2c: Respect all error codes from dev_pm_domain_attach()
>   mmc: sdio: Respect all error codes from dev_pm_domain_attach()
>   soundwire: Respect all error codes from dev_pm_domain_attach()
>   spi: Respect all error codes from dev_pm_domain_attach()
>
>  drivers/acpi/device_pm.c     |  9 +++------
>  drivers/amba/bus.c           |  4 ++--
>  drivers/base/platform.c      | 17 ++++++++---------
>  drivers/base/power/common.c  | 10 +++++++---
>  drivers/base/power/domain.c  | 45 +++++++++++++++-----------------------------
>  drivers/i2c/i2c-core-base.c  |  2 +-
>  drivers/mmc/core/sdio_bus.c  |  2 +-
>  drivers/soundwire/bus_type.c | 15 +++++++--------
>  drivers/spi/spi.c            | 11 ++++++-----
>  include/linux/acpi.h         |  2 +-
>  include/linux/pm_domain.h    |  2 +-
>  11 files changed, 52 insertions(+), 67 deletions(-)

Rafael,

I understand if you are busy so this is not a ping. :-)

However, perhaps I can simplify by sending you a PR with these!?

Kind regards
Uffe
