Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732795; cv=none;
        d=google.com; s=arc-20160816;
        b=v0pfzKfA2wfoZPef2qiourM7/6ZYg51N3X6zf/niE+UXAgwtlPQ23rD1XlMp2QbHqn
         4ejfFekcoFbND0Ly3NHl2E61oqpp9xxJYh6+JioZgi/WW2Y5+mc4h6FX8l2W5hOpxkjy
         O/E4Leoq+bKjW8XAssO9SjAsde1G7WjTaAZjYH8wbuQHImUHKMEGXwem0uwAPNFDXwDJ
         vQ0AFeLJ/VNkY3GYjLMDz6sHxXx3j5h2UagjKa88AhqnSpc9yT7kgU77zdweEDqhy7GG
         /U2NStWkWvgkOLkJCKDWWn0h6W0XroHc9RS8b2u3T5K1CFZhItuWECRlUrsMc8tR5W17
         XgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=BKyv6xwF8Xm1RgBOJm9c8M4cgM43KKWLhCuI4xFY+ho=;
        b=UdR0ndxEANskRGHWPKCTs0EDmUhpRqRrw2nX2q5xA5dssc+iWmZdJz1W9NdTr+CAf0
         US8/s3Ie+rBh0o+PkIQLG9fCOJZc9d5VoaLUITfPauuaH27Axj4B91i+7JTTJXh6TZGP
         K79e0DdLl86++d4mvocc/4jiPqhGxg1nrxcZgY21TXV2cqtWDJPOZBKJbAuYXKvmhcnB
         mbf9VTcEdP5Blj8e+iWhF2ppQOCNv0IkOk5goIDcmCn9MJnUrSEUQhM0ZsLM16L8yMz6
         mUsDujG8NvsAQU1yOaXuQRXdzyEHEGi3XTUV8Qqi+ci5k0LoSw4fI+xRNlaeK3wgriXB
         JZ+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=h3H6rFI2;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=h3H6rFI2;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr/9HZ4K2rf7hHC9GQ6n+NLAr97l5Bpo+qeyWNTLtXZO766NNEUdd2y6H0U6skrYIBd7Y10pw==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/11] PM / Domains: Fixup error paths with dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:52:59 +0200
Message-Id: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798215227519391?=
X-GMAIL-MSGID: =?utf-8?q?1598798215227519391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While I was on working adding support for multiple PM domains to genpd, I
stumbled over several problems in the error path related to
dev_pm_domain_attach(). Hence, I decided to fix these problems first, which is
what this series intends to address.

There first patch is material for stable, as it fixes a real bug in genpd,
while the rest may be considered as improvement of the error paths when devices
fails to be attached to their PM domains.

I am seeking acks from subsystem maintainers and suggest with funnel the hole
series through Rafael's linux-pm tree, unless there are objections to that of
course.

Ulf Hansson (11):
  PM / Domains: Fix error path during attach in genpd
  PM / Domains: Drop comment in genpd about legacy Samsung DT binding
  PM / Domains: Drop redundant code in genpd while attaching devices
  PM / Domains: Check for existing PM domain in dev_pm_domain_attach()
  PM / Domains: Allow a better error handling of dev_pm_domain_attach()
  amba: Respect all error codes from dev_pm_domain_attach()
  driver core: Respect all error codes from dev_pm_domain_attach()
  i2c: Respect all error codes from dev_pm_domain_attach()
  mmc: sdio: Respect all error codes from dev_pm_domain_attach()
  soundwire: Respect all error codes from dev_pm_domain_attach()
  spi: Respect all error codes from dev_pm_domain_attach()

 drivers/acpi/device_pm.c     |  9 +++------
 drivers/amba/bus.c           |  4 ++--
 drivers/base/platform.c      | 17 ++++++++---------
 drivers/base/power/common.c  | 10 +++++++---
 drivers/base/power/domain.c  | 45 +++++++++++++++-----------------------------
 drivers/i2c/i2c-core-base.c  |  2 +-
 drivers/mmc/core/sdio_bus.c  |  2 +-
 drivers/soundwire/bus_type.c | 15 +++++++--------
 drivers/spi/spi.c            | 11 ++++++-----
 include/linux/acpi.h         |  2 +-
 include/linux/pm_domain.h    |  2 +-
 11 files changed, 52 insertions(+), 67 deletions(-)

-- 
2.7.4
