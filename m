Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6BECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF37A2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF37A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJ0Fdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:33:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54692 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbeJ0Fdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:33:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 14123208F5; Fri, 26 Oct 2018 22:55:06 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id DA91A207AB;
        Fri, 26 Oct 2018 22:55:05 +0200 (CEST)
Date:   Fri, 26 Oct 2018 22:55:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.20
Message-ID: <20181026205506.GA14231@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.20.

This cycle, there were mostly non urgent fixes in drivers. I also
finally unexported the non managed registration.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.20

for you to fetch changes up to 3822d1bb0df18aa28930f19bc46e0704aea1be0f:

  rtc: sc27xx: Always read normal alarm when registering RTC device (2018-1=
0-25 02:35:42 +0200)

----------------------------------------------------------------
RTC for 4.20

Subsystem:
 - non devm managed registration is now removed from the driver API.
 - all the unnecessary rtc_valid_tm() calls have been removed

Drivers:
 - abx80X: watchdog support
 - cmos: fix non ACPI support
 - sc27xx: fix alarm support
 - Remove a possible sysfs race condition for ab8500, ds1307, ds1685, isl12=
08
 - Fix a possible race condition where an irq handler may be called before =
the
   rtc_device struct is allocated for mt6397, pl030, menelaus, armada38x

----------------------------------------------------------------
Alexandre Belloni (32):
      rtc: rv8803: fix the rv8803 id in the OF table
      rtc: rv8803: add Epson RX8803 support
      rtc: mt6397: fix possible race condition
      rtc: pl030: fix possible race condition
      rtc: pl031: switch to devm_rtc_allocate_device/rtc_register_device
      mfd: menelaus: Fix possible race condition and leak
      Merge tag 'ib-mfd-rtc-v4.20' of git://git.kernel.org/.../lee/mfd into=
 rtc-next
      rtc: unexport non devm managed registration
      rtc: remove irq_task from kerneldoc
      rtc: isl1208: avoid possible sysfs race
      rtc: reorder Makefile entries
      rtc: move rtc_add_group/s definitions
      rtc: isl1208: don't include core header file
      rtc: tx4939: fixup nvmem name and register size
      rtc: test: make license text and module license match.
      rtc: test: Switch to SPDX identifier
      rtc: ds1685: drop RTC_DS1685_PROC_REGS
      rtc: ds1685: use generic nvmem
      rtc: ds1685: use rtc_add_group
      rtc: ds1307: use rtc_add_group
      rtc: lib: correct documentation typo
      rtc: armada38x: fix possible race condition
      rtc: armada38x: add range
      rtc: armada38x: switch to rtc_time64_to_tm/rtc_tm_to_time64
      rtc: rs5c348: remove useless label
      rtc: rs5c348: remove forward declaration
      rtc: rs5c348: report error when time is invalid
      rtc: ab8500: use rtc_add_group
      rtc: ab8500: let the core handle range
      rtc: ab8500: remove useless check
      rtc: vr41xx: switch to rtc_time64_to_tm/rtc_tm_to_time64
      rtc: mv: let the core handle invalid alarms

Arnd Bergmann (1):
      rtc: mips: default to rtc-cmos on mips

Baolin Wang (5):
      rtc: sc27xx: Set wakeup capability before registering rtc device
      rtc: sc27xx: Clear SPG value update interrupt status
      rtc: sc27xx: Remove interrupts disable and clear in probe()
      rtc: sc27xx: Add check to see if need to enable the alarm interrupt
      rtc: sc27xx: Always read normal alarm when registering RTC device

Dan Carpenter (1):
      rtc: sysfs: fix NULL check in rtc_add_groups()

Giulio Benetti (2):
      rtc: ds1307: add offset sysfs for mt41txx chips.
      rtc: ds1307: add frequency_test_enable  attribute on m41txx

Gustavo A. R. Silva (2):
      rtc: sun6i: Use struct_size() in kzalloc()
      rtc: m41t80: mark expected switch fall-through

Jeremy Gebben (2):
      rtc: abx80x: use a 'priv' struct for client data
      rtc: abx80x: add basic watchdog support

Jia-Ju Bai (1):
      rtc: rtc-mrst: Replace mdelay() with msleep() in mrst_read_time()

Keerthy (2):
      rtc: omap: use of_device_is_system_power_controller function
      rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec

Maciej W. Rozycki (2):
      rtc: cmos: Fix non-ACPI undefined reference to `hpet_rtc_interrupt'
      rtc: cmos: Remove the `use_acpi_alarm' module parameter for !ACPI

Nathan Chancellor (1):
      rtc: s35390a: Change buf's type to u8 in s35390a_init

Paul Cercueil (1):
      rtc: jz4740: Drop dependency on MACH_INGENIC

Soeren Moch (1):
      rtc: ds1307: fix ds1339 wakealarm support

Thierry Reding (1):
      rtc: tegra: Propagate errors from platform_get_irq()

Wolfram Sang (1):
      rtc: ds1685: simplify getting .driver_data

YueHaibing (1):
      rtc: mrst: remove set but not used variable 'valid'

 arch/mips/Kconfig           |   2 +-
 drivers/char/Kconfig        |   2 +-
 drivers/mfd/menelaus.c      |  13 ++-
 drivers/rtc/Kconfig         |  14 +---
 drivers/rtc/Makefile        |  12 +--
 drivers/rtc/class.c         |  12 ++-
 drivers/rtc/interface.c     |   3 -
 drivers/rtc/rtc-ab8500.c    |  96 +++++-----------------
 drivers/rtc/rtc-abx80x.c    | 143 +++++++++++++++++++++++++++++---
 drivers/rtc/rtc-armada38x.c |  46 +++++------
 drivers/rtc/rtc-cmos.c      |  29 +++++--
 drivers/rtc/rtc-core.h      |  14 ----
 drivers/rtc/rtc-ds1307.c    | 145 ++++++++++++++++++++++++++++++++-
 drivers/rtc/rtc-ds1685.c    | 194 ++++++----------------------------------=
----
 drivers/rtc/rtc-isl1208.c   |  34 +++-----
 drivers/rtc/rtc-lib.c       |   2 +-
 drivers/rtc/rtc-m41t80.c    |   2 +-
 drivers/rtc/rtc-mrst.c      |   5 +-
 drivers/rtc/rtc-mt6397.c    |  13 +--
 drivers/rtc/rtc-mv.c        |   8 +-
 drivers/rtc/rtc-omap.c      |  28 ++++---
 drivers/rtc/rtc-pl030.c     |  15 ++--
 drivers/rtc/rtc-pl031.c     |  18 ++--
 drivers/rtc/rtc-rs5c348.c   |  65 +++++++--------
 drivers/rtc/rtc-rv8803.c    |   7 +-
 drivers/rtc/rtc-s35390a.c   |   2 +-
 drivers/rtc/rtc-sc27xx.c    |  60 +++++++++-----
 drivers/rtc/rtc-sun6i.c     |   3 +-
 drivers/rtc/rtc-sysfs.c     |   4 +-
 drivers/rtc/rtc-tegra.c     |  10 ++-
 drivers/rtc/rtc-test.c      |   7 +-
 drivers/rtc/rtc-tx4939.c    |   4 +-
 drivers/rtc/rtc-vr41xx.c    |   9 +-
 include/linux/rtc.h         |  21 +++--
 34 files changed, 556 insertions(+), 486 deletions(-)

--=20
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAlvTfx0ACgkQAyWl4gNJ
NJIVXg/+N2aaHLF8KPjiRaHm7a+uLnopGRHJFYsG+3kr9po1bSG1M01vf/UdiTXk
Q8f3TOYoR1uDcvOafzRNgNTP3A8473mvR9/5l2/GMW8inCkd4W8VWa/O08BMinTx
THcDN7jwxCA/uYe/YlEzJMPVCZ8n1LIFy34nsLho7yJs87+dShGmww1/KuM6F2tE
ARnAHRlJBAxbO1lrGHQp5piVTEuBR+QEPY3u+ORvLEiYCDC5tfLhwX1ZH88V8Hwz
UgmvgXEhNqHZvLOku2P2T4pKngFX+GL72VDnWdDN5c8iLFMZwjA70Mpe5mfysWCc
MISTfJq6PVxgVNQSsLBRT1KbODnHKbZjJRE2JDp/sqwNchN1umr0O8YpcMh2u9y3
BEcitwymrpqpmg/Bx6WwGS8a5L48FWwdyJePYp9FxygdVB1dZ4if0OUnNQ3kUsXj
/rwax+foE7DJ8vs5QgNu7JLQnHA0aF4C65ZnxN0CvvpH2m9t4Az0wSZEvOJvaIco
iznxYCGgPMSkqu2fxdCS3UFVAq5Y3g329Slm8eGC/e/KOo9Wvulp6kI4GdlRCsGk
2eG5x3zLd68Fv1DP0W+GGIYChiY+twwjajJDRSOa4oZhATEzo0SSk++z9z+Y0ds0
5/uMgZh9l5zlE+TRNGy97E6oYYrdj5qsSwiHgJ1xtxosZte6gKU=
=yLAq
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
