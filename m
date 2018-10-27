Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB12C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A6120869
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="EJg1wwJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A6120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=linux-watchdog.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeJ0Ubi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:31:38 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:55840 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbeJ0Ubh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 16:31:37 -0400
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id CC9B4403A5; Sat, 27 Oct 2018 13:27:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org CC9B4403A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1540639644;
        bh=NW+gyem+BY0LJ6DTn3zOQ8ODlkOYc7UpS4LnQibXic4=;
        h=Date:From:To:Cc:Subject:From;
        b=EJg1wwJ4fKYLIskyWHpcAG1OQtKWBsBQJw3DcwnB/uRBFxsZtFY1tcwCwZ5evxpGc
         eiWXt+MUdEG2w3zL+7XXneUcCycJmQ5TtehxGyR8bfJQLCvrpE4t8SBjK6L8fFzxS3
         coQTMwkZoZi/XTJw6Qe6E3uHpDOPjtheWQ06xitE=
Date:   Sat, 27 Oct 2018 13:27:24 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Chris Brandt <chris.brandt@renesas.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jean Delvare <jdelvare@suse.de>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Romain Izard <romain.izard.pro@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL REQUEST] watchdog - v4.20 Merge window
Message-ID: <20181027112724.GA26504@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.20 (or 5.00) release cycle.

This series contains:
* Add Armada 37xx CPU watchdog
* w83627hf_wdt: Add Support for NCT6796D, NCT6797D, NCT6798D
* hpwdt: several improvements
* renesas_wdt: SPDX identifiers, stop when unregistering, support for R7S9210
* rza_wdt: SPDX identifiers, support longer timeouts
* core: fix null pointer dereference when releasing cdev
* iTCO_wdt: Drop option vendorsupport=2
* sama5d4: fix timeout-sec usage
* lantiq_wdt: convert to watchdog framework
* several small fixes

The output from git request-pull:
----------------------------------------------------------------

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.20-rc1

for you to fetch changes up to cd6ba41c192deca20d9add5554bc8c51d0f07de2:

  watchdog: ts4800: release syscon device node in ts4800_wdt_probe() (2018-10-22 10:16:28 +0200)

----------------------------------------------------------------
linux-watchdog 4.20-rc1 tag

----------------------------------------------------------------
Alexey Khoroshilov (1):
      watchdog: ts4800: release syscon device node in ts4800_wdt_probe()

Chris Brandt (2):
      watchdog: rza_wdt: Support longer timeouts
      dt-bindings: watchdog: renesas-wdt: Add support for R7S9210

Christophe Leroy (3):
      watchdog: mpc8xxx: use dev_xxxx() instead of pr_xxxx()
      watchdog: mpc8xxx: provide boot status
      dt-bindings: watchdog: add mpc8xxx-wdt support

Guenter Roeck (2):
      watchdog: w83627hf_wdt: Support NCT6796D, NCT6797D, NCT6798D
      MAINTAINERS: Fix file pattern for MEN Z069 watchdog driver

Hauke Mehrtens (3):
      watchdog: lantiq: update register names to better match spec
      watchdog: lantiq: Convert to watchdog_device
      watchdog: lantiq: add get_timeleft callback

Jean Delvare (2):
      watchdog: iTCO_wdt: Drop option vendorsupport=2
      watchdog: iTCO_wdt: Remove unused hooks

Jerry Hoemann (7):
      watchdog: hpwdt: Initialize pretimeout from module parameter.
      watchdog: hpwdt: Claim NMI from iLO
      watchdog: hpwdt: Display module parameters.
      watchdog: hpwdt: Module paramerter alias.
      watchdog: hpwdt: Update version number.
      watchdog: hpwdt: Update Driver Documentation.
      watchdog: hpwdt: Disable PreTimeout when Timeout is smaller

Kuninori Morimoto (1):
      watchdog: rza_wdt: convert to SPDX identifiers

Marek Behún (4):
      watchdog: Add support for Armada 37xx CPU watchdog
      dt-bindings: watchdog: Document armada-37xx-wdt binding
      documentation: watchdog: add documentation for armada-37xx-wdt
      watchdog: armada_37xx_wdt: use do_div for u64 division

Robert P. J. Day (1):
      watchdog: fix a small number of "watchog" typos in comments

Romain Izard (1):
      watchdog: sama5d4: fix timeout-sec usage

Wolfram Sang (3):
      watchdog: renesas_wdt: use SPDX identifier for Renesas drivers
      watchdog: core: fix null pointer dereference when releasing cdev
      watchdog: renesas_wdt: stop when unregistering

 .../bindings/watchdog/armada-37xx-wdt.txt          |  23 ++
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   |  25 ++
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   1 +
 Documentation/watchdog/hpwdt.txt                   |  93 ++---
 Documentation/watchdog/watchdog-parameters.txt     |   5 +
 MAINTAINERS                                        |   2 +-
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/armada_37xx_wdt.c                 | 388 +++++++++++++++++++++
 drivers/watchdog/booke_wdt.c                       |   2 +-
 drivers/watchdog/hpwdt.c                           |  24 +-
 drivers/watchdog/iTCO_vendor.h                     |   4 -
 drivers/watchdog/iTCO_vendor_support.c             | 168 +--------
 drivers/watchdog/iTCO_wdt.c                        |   4 -
 drivers/watchdog/lantiq_wdt.c                      | 311 ++++++++---------
 drivers/watchdog/mpc8xxx_wdt.c                     |  46 ++-
 drivers/watchdog/renesas_wdt.c                     |   6 +-
 drivers/watchdog/rza_wdt.c                         |  93 +++--
 drivers/watchdog/sama5d4_wdt.c                     |   6 +-
 drivers/watchdog/ts4800_wdt.c                      |   1 +
 drivers/watchdog/via_wdt.c                         |   4 +-
 drivers/watchdog/w83627hf_wdt.c                    |   8 +-
 drivers/watchdog/watchdog_dev.c                    |  10 +-
 23 files changed, 783 insertions(+), 454 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
 create mode 100644 drivers/watchdog/armada_37xx_wdt.c
