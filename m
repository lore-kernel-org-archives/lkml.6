Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617087-1524602002-2-10802586635113836416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524602000; b=okKkukWIDb7P/E9fM7Inm9rNW5LF2Gmcuvqy7SIoH/gldXSzwJ
    R2sYFeniOWTZVfK0Hxki9mWpjXOAG1YRAhjIqRCgG7XK6kXiiY3X1QE746sj5iri
    TppC/MWEhs3tqzrwYGwMOSzQFA+o74mPQV1LG9xdKqqmttt//p6YtKxt5LQFupjZ
    xrjybaifOCUMCU+uU5prTP0Og9Ez3Va+kOJxJFyTugKDUJtm8SlLjyYW/n5uMbYi
    6vlI6Te5tFZ090ieG/mPGDmrjSE/StRG3BMp0Pi/MZLOrW0hnd+9KVNJv72I9yZ+
    vsQB5RhIXY75598MEtJmuveYm81qbcpvEX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524602000; bh=IShsR9ltxK7TjHJ1vrcvXuwF/vEN09
    iDuBAXski0qQ4=; b=fuqFsx0mhjo4htloZ0mRXLRLfmeaFyYtEeWDnQ1a/mOuND
    hDyxpD03XQlwjt7zzo8kJCKtx8aI95R+EoBZ0REBcepnw5odl38eIzPW/H2VeWJ0
    RmyIcVpIhJcvJxSx7/XzBa9JEnGo02NIsbbJaStXhgRsMkXgD2Ik2XmVCovcAOus
    R32nl3GAx3tsvRRQNwKZajRNNpimD1r0UT1G88HBpIhgtAijr3F4exKAYgqgaM0x
    6vkWTaPRtq3ZW+0MIMEOkzW/kO8ViPnuNLJpbkBgODj9hZtXvQbvepIWDzEhMv1l
    tIMQ4rPTcBYfogvJTfQLOdQOzOh2Hsv0GqP2kyjw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdHqzTMBNbBjPlDS/qMUFsxuqS3UX5/dDBIoEgP4yD+r+EOTwOldKjkLPOoAxNkq5xjnEV2mhKMSMSsVh6YHMXCbVaV+FzaSsFEssapRNkdTafS0p6e
    agEvGopmNplXfVLC5BxPDpdfkTulpjM+fc92KO9Pf4kauBmDYFMZk3y7aBbQXq2Sx1z/OnbBz4bpExuh+iZ877evKin6iwmR4ScfnPlxibu+jzRDokeEXJU+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Vt2AcnKqAAAA:8
    a=VwQbUJbxAAAA:8 a=cO4SiTTC1lYiX4ISQCsA:9 a=x8gzFH9gYPwA:10
    a=v10HlyRyNeVhbzM4Lqgd:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDXUdS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 16:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeDXUdM (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 16:33:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF3D217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 00/10] ARM: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:29 +0200
Message-Id: <20180424203239.21885-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,


Overview
========
Let's continue the removal of old platforms. We already get rid of Exynos4212.
Now it's time for Exynos5440.

The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
server platforms but it did not make it to the market really.  There are
no development boards with it and probably there are no real products
neither.  The development for Exynos5440 ended in 2013 and since then
the platform is in maintenance mode.

The only development happening around it is the PCIe driver for Exynos5433
(ARMv8). [1]

Removing Exynos5440, makes our life slightly easier:
1. Less maintenance,
2. Smaller code, less quirks,
3. No need to preserve (imaginary) backward-compatibility for Exynos PCIe
   driver (so it is easier to add support for Exynos5433).


Because of point (3) above - I left the PCIe and PCIe PHY drivers intact.


Dependencies
============
I think about starting with removal of DTS in some kernel release (patch 1/10).
Then all drivers can be removed/updated - subsystem maintainers can pick their
patches freely.

Finally, after getting rid of all Exynos5440 symbols, the last patch (10/10) will
end in arm-soc tree.


Any comments?


Best regards,
Krzysztof

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1569919.html

Krzysztof Kozlowski (10):
  ARM: dts: exynos: Remove Exynos5440
  ata: ahci-platform: Remove support for Exynos5440
  cpufreq: exynos: Remove support for Exynos5440
  clk: samsung: Remove support for Exynos5440
  i2c: s3c2410: Remove support for Exynos5440
  thermal: samsung: Remove support for Exynos5440
  pinctrl: samsung: Remove support for Exynos5440
  spi: s3c64xx: samsung: Remove support for Exynos5440
  usb: host: exynos: Remove support for Exynos5440
  ARM: exynos: Remove support for Exynos5440

 .../bindings/arm/samsung/samsung-boards.txt        |    2 -
 .../devicetree/bindings/ata/ahci-platform.txt      |    1 -
 .../devicetree/bindings/clock/exynos5440-clock.txt |   28 -
 .../bindings/cpufreq/cpufreq-exynos5440.txt        |   28 -
 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    4 +-
 .../devicetree/bindings/thermal/exynos-thermal.txt |   14 +-
 arch/arm/boot/dts/Makefile                         |    2 -
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |   42 -
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   81 --
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |   20 -
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      |   21 -
 arch/arm/boot/dts/exynos5440.dtsi                  |  355 -------
 arch/arm/mach-exynos/Kconfig                       |   12 -
 arch/arm/mach-exynos/common.h                      |    8 -
 arch/arm/mach-exynos/exynos.c                      |   15 +-
 drivers/ata/ahci_platform.c                        |    1 -
 drivers/clk/samsung/Makefile                       |    1 -
 drivers/clk/samsung/clk-exynos5440.c               |  167 ----
 drivers/cpufreq/Kconfig.arm                        |   14 -
 drivers/cpufreq/Makefile                           |    1 -
 drivers/cpufreq/exynos5440-cpufreq.c               |  452 ---------
 drivers/i2c/busses/i2c-s3c2410.c                   |    2 -
 drivers/pinctrl/samsung/Kconfig                    |   10 +-
 drivers/pinctrl/samsung/Makefile                   |    1 -
 drivers/pinctrl/samsung/pinctrl-exynos5440.c       | 1005 --------------------
 drivers/spi/spi-s3c64xx.c                          |   12 -
 drivers/thermal/samsung/exynos_tmu.c               |  155 +--
 drivers/thermal/samsung/exynos_tmu.h               |    1 -
 drivers/usb/host/ehci-exynos.c                     |    7 -
 drivers/usb/host/ohci-exynos.c                     |    6 -
 include/dt-bindings/clock/exynos5440.h             |   44 -
 31 files changed, 9 insertions(+), 2503 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5440-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
 delete mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440.dtsi
 delete mode 100644 drivers/clk/samsung/clk-exynos5440.c
 delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c
 delete mode 100644 drivers/pinctrl/samsung/pinctrl-exynos5440.c
 delete mode 100644 include/dt-bindings/clock/exynos5440.h

-- 
2.14.1

