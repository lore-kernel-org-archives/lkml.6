Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeDIWCu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 18:02:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32866 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbeDIWCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 18:02:47 -0400
Date: Tue, 10 Apr 2018 00:02:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.17
Message-ID: <20180409220235.GA27487@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.17.

It contains a few series that have been in preparation for a while and
that will help systems with RTCs that will fail in 2038, 2069 or 2100.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.17

for you to fetch changes up to 1485991c024603b2fb4ae77beb7a0d741128a48e:

  rtc: snvs: Fix usage of snvs_rtc_enable (2018-04-03 16:43:36 +0200)

----------------------------------------------------------------
RTC for 4.17

Subsystem:
 - Add tracepoints
 - Rework of the RTC/nvmem API to allow drivers to discard struct nvmem_con=
fig
   after registration
 - New range API, drivers can now expose the useful range of the RTC
 - New offset API the core is now able to add an offset to the RTC time,
   modifying the supported range.
 - Multiple rtc_time64_to_tm fixes
 - Handle time_t overflow on 32 bit platforms in the core instead of letting
   drivers do crazy things.
 - remove rtc_control API

New driver:
 - Intersil ISL12026

Drivers:
 - Drivers exposing the RTC non volatile memory have been converted to use =
nvmem
 - Removed useless time and date validation
 - Removed an indirection pattern that was a cargo cult from ancient drivers
 - Removed VLA usage
 - Fixed a possible race condition in probe functions
 - AB8540 support is dropped from ab8500
 - pcf85363 now has alarm support

----------------------------------------------------------------
Alexandre Belloni (100):
      rtc: documentation: correct nvmem date and version
      rtc: nvmem: pass nvmem_config to rtc_nvmem_register()
      rtc: nvmem: return error values
      rtc: nvmem: disallow registering nvmem more than once
      rtc: nvmem: allow registering the nvmem device before the rtc
      rtc: export rtc_nvmem_register() to drivers
      rtc: ds1305: call rtc_nvmem_register()
      rtc: ds1305: put ds1305_nvmem_cfg on the stack
      rtc: ds1307: call rtc_nvmem_register()
      rtc: ds1307: put struct nvmem_config on the stack
      rtc: ds1511: call rtc_nvmem_register()
      rtc: ds1511: put ds1511_nvmem_cfg on the stack
      rtc: m48t86: call rtc_nvmem_register()
      rtc: m48t86: put m48t86_nvmem_cfg on the stack
      rtc: omap: call rtc_nvmem_register()
      rtc: pcf85363: call rtc_nvmem_register()
      rtc: pcf85363: put struct nvmem_config on the stack
      rtc: rv8803: call rtc_nvmem_register()
      rtc: rv8803: put struct nvmem_config on the stack
      rtc: rv8803: fix possible race condition
      rtc: remove nvmem_config
      rtc: ds1343: simplify regmap initialization
      rtc: ds1343: switch to rtc_register_device
      rtc: ds1343: remove undocumented and useless sysfs files
      rtc: ds1343: use generic nvmem
      rtc: m48t59: switch to rtc_register_device
      rtc: m48t59: use generic nvmem
      rtc: sirfsoc: remove useless sirfsoc_rtc_ioctl
      rtc: ds1553: switch to rtc_register_device
      rtc: ds1553: use generic nvmem
      rtc: ds1553: make alarms useful
      rtc: cmos: fix possible race condition
      rtc: cmos: use generic nvmem
      rtc: ds1742: switch to rtc_register_device
      rtc: ds1742: use generic nvmem
      rtc: rp5c01: fix possible race condition
      rtc: rp5c01: use generic nvmem
      rtc: stk17ta8: make alarms useful
      rtc: stk17ta8: switch to rtc_register_device
      rtc: stk17ta8: fix possible race condition
      rtc: stk17ta8: use generic nvmem
      rtc: tx4939: remove arch/mips dependency
      rtc: tx4939: extend test coverage
      rtc: tx4939: switch to rtc_register_device
      rtc: tx4939: fix possible race condition
      rtc: tx4939: use generic nvmem
      char: rtc: remove unused rtc_control() API
      MAINTAINERS: rtc: update my email address
      rtc: ds1511: let the core handle invalid time
      rtc: ds1553: let the core handle invalid time
      rtc: cmos: let the core handle invalid time
      rtc: rs5c348: let the core handle invalid time
      rtc: stk17ta8: let the core handle invalid time
      rtc: stop validating rtc_time after rtc_time64_to_tm
      rtc: stop validating rtc_time after rtc_time_to_tm
      rtc: stop validating rtc_time in .read_time
      rtc: ab-b5ze-s3: stop validating rtc_time in .read_time
      rtc: cpcap: stop validating rtc_time in .read_time
      rtc: diasemi: stop validating rtc_time in .read_time
      rtc: nuc900: stop validating rtc_time in .read_time
      rtc: r7301: stop validating rtc_time in .read_time
      rtc: sc27xx: stop validating rtc_time in .read_time
      rtc: isl12022: remove useless indirection
      rtc: m41t93: stop validating rtc_time in .read_time
      rtc: max77686: stop validating rtc_time in .read_time
      rtc: omap: stop validating rtc_time in .set_time and .set_alarm
      rtc: spear: stop validating rtc_time in .set_time and .set_alarm
      rtc: tegra: stop validating rtc_time in .set_time
      rtc: abx80x: remove useless message
      rtc: pm8xxx: remove useless message
      rtc: rx4581: remove useless message
      rtc: rx8581: remove useless message
      rtc: rk808: remove useless debug message
      rtc: rk808: fix possible race condition
      rtc: s35390a: remove useless message
      rtc: s35390a: stop validating rtc_time in .read_time
      rtc: s35390a: remove useless indirection
      rtc: rs5c372: remove useless message
      rtc: rs5c372: stop validating rtc_time in .read_time
      rtc: rs5c372: remove useless indirection
      rtc: max6900: stop validating rtc_time in .read_time
      rtc: max6900: remove useless indirection
      rtc: pcf85063: stop validating rtc_time in .read_time
      rtc: pcf85063: remove useless indirection
      rtc: m41t80: fix race conditions
      rtc: m41t80: remove useless indirection
      rtc: pcf85363: add .max_register in regmap_config
      rtc: pcf85363: add alarm support
      rtc: pcf85363: set time accurately
      rtc: fix rtc_time64_to_tm for 3477
      rtc: isl12026: fixup nvmem registration
      rtc: Add RTC range
      rtc: Add useful timestamp definitions
      parisc: time: stop validating rtc_time in .read_time
      rtc: hctosys: Ensure system time doesn't overflow time_t
      rtc: mv: remove artificial limitation
      rtc: mrst: remove artificial limitation
      rtc: st-lpc: remove artificial limitation
      rtc: 88pm80x: remove artificial limitation
      rtc: 88pm860x: remove artificial limitation

Baolin Wang (4):
      rtc: Add tracepoints for RTC system
      rtc: Fix overflow when converting time64_t to rtc_time
      rtc: Factor out the RTC range validation into rtc_valid_range()
      rtc: Add one offset seconds to expand RTC range

Bryan O'Donoghue (1):
      rtc: snvs: Fix usage of snvs_rtc_enable

Colin Ian King (2):
      rtc: ds1302: remove redundant initializations of pointer bp
      rtc: tx4939: avoid unintended sign extension on a 24 bit shift

David Daney (1):
      rtc: isl12026: new driver.

Denis Osterland (2):
      rtc: isl1208: Fix unintended clear of SR bits
      rtc: isl1208: switch to rtc_register_device

Fabio Estevam (1):
      rtc: mxc_v2: Fix _iomem pointer notation

Gustavo A. R. Silva (4):
      rtc: remove VLA usage
      rtc: s5m: Move enum from rtc.h to rtc-s5m.c
      rtc: s5m: Remove VLA usage
      rtc: isl12022: use true and false for boolean values

James Hogan (1):
      rtc: goldfish: Add missing MODULE_LICENSE

Jeffy Chen (2):
      rtc: cros-ec: return -ETIME when refused to set alarms in the past
      rtc: at91sam9: Set name of regmap_config

Justin Chen (1):
      rtc: brcmstb-waketimer: Set wktmr prescaler

Linus Walleij (1):
      rtc: ab8500: Drop AB8540 support

Masahiro Yamada (1):
      rtc: at91sam: add 'depends on HAS_IOMEM' to fix unmet dependency

Mathieu Malaterre (1):
      rtc: remove a warning during scripts/kernel-doc step

Michael Grzeschik (1):
      rtc: isl1208: enable interrupt after context preparation

Michael McCormick (1):
      rtc: pcf85063: fix clearing bits in pcf85063_start_clock

Mohit Aggarwal (1):
      rtc: pm8xxx: Fix issue in RTC write path

Philipp Rossak (1):
      rtc: ac100: Fix ac100 determine rate bug

Sean Wang (1):
      rtc: mt7622: fix module autoloading for OF platform drivers

Sebastian Andrzej Siewior (1):
      rtc: m41t80: move m41t80_rtc_mutex to the block where it is used

 Documentation/ABI/testing/sysfs-class-rtc          |  16 +-
 .../devicetree/bindings/rtc/isil,isl12026.txt      |  28 ++
 MAINTAINERS                                        |   2 +-
 arch/parisc/kernel/time.c                          |   2 +-
 drivers/char/rtc.c                                 |  83 ----
 drivers/rtc/Kconfig                                |  13 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/class.c                                |  77 +++-
 drivers/rtc/hctosys.c                              |   5 +
 drivers/rtc/interface.c                            | 107 +++++
 drivers/rtc/nvmem.c                                |  29 +-
 drivers/rtc/rtc-88pm80x.c                          |   4 +-
 drivers/rtc/rtc-88pm860x.c                         |   4 +-
 drivers/rtc/rtc-ab-b5ze-s3.c                       |   4 +-
 drivers/rtc/rtc-ab3100.c                           |   2 +-
 drivers/rtc/rtc-ab8500.c                           |  57 +--
 drivers/rtc/rtc-abx80x.c                           |   6 +-
 drivers/rtc/rtc-ac100.c                            |  26 +-
 drivers/rtc/rtc-at91sam9.c                         |   1 +
 drivers/rtc/rtc-au1xxx.c                           |   2 +-
 drivers/rtc/rtc-bq32k.c                            |   8 +-
 drivers/rtc/rtc-brcmstb-waketimer.c                |   3 +
 drivers/rtc/rtc-cmos.c                             |  87 ++--
 drivers/rtc/rtc-coh901331.c                        |   2 +-
 drivers/rtc/rtc-core.h                             |   8 -
 drivers/rtc/rtc-cpcap.c                            |   2 +-
 drivers/rtc/rtc-cros-ec.c                          |   8 +-
 drivers/rtc/rtc-da9052.c                           |   3 +-
 drivers/rtc/rtc-da9055.c                           |   2 +-
 drivers/rtc/rtc-da9063.c                           |   2 +-
 drivers/rtc/rtc-ds1216.c                           |   2 +-
 drivers/rtc/rtc-ds1286.c                           |   2 +-
 drivers/rtc/rtc-ds1302.c                           |   7 +-
 drivers/rtc/rtc-ds1305.c                           |  24 +-
 drivers/rtc/rtc-ds1307.c                           |  32 +-
 drivers/rtc/rtc-ds1343.c                           | 185 ++------
 drivers/rtc/rtc-ds1347.c                           |   2 +-
 drivers/rtc/rtc-ds1390.c                           |   2 +-
 drivers/rtc/rtc-ds1511.c                           |  26 +-
 drivers/rtc/rtc-ds1553.c                           |  78 ++--
 drivers/rtc/rtc-ds1685.c                           |   2 +-
 drivers/rtc/rtc-ds1742.c                           |  75 ++-
 drivers/rtc/rtc-ds2404.c                           |   2 +-
 drivers/rtc/rtc-ds3232.c                           |   2 +-
 drivers/rtc/rtc-efi.c                              |   2 +-
 drivers/rtc/rtc-fm3130.c                           |   3 +-
 drivers/rtc/rtc-goldfish.c                         |   2 +
 drivers/rtc/rtc-isl12022.c                         |  20 +-
 drivers/rtc/rtc-isl12026.c                         | 501 +++++++++++++++++=
++++
 drivers/rtc/rtc-isl1208.c                          |  47 +-
 drivers/rtc/rtc-jz4740.c                           |   2 +-
 drivers/rtc/rtc-lib.c                              |   8 +-
 drivers/rtc/rtc-lpc24xx.c                          |   2 +-
 drivers/rtc/rtc-lpc32xx.c                          |   2 +-
 drivers/rtc/rtc-ls1x.c                             |   2 +-
 drivers/rtc/rtc-m41t80.c                           |  42 +-
 drivers/rtc/rtc-m41t93.c                           |   2 +-
 drivers/rtc/rtc-m41t94.c                           |   3 +-
 drivers/rtc/rtc-m48t35.c                           |   2 +-
 drivers/rtc/rtc-m48t59.c                           |  61 ++-
 drivers/rtc/rtc-m48t86.c                           |  25 +-
 drivers/rtc/rtc-max6900.c                          |  19 +-
 drivers/rtc/rtc-max6902.c                          |   2 +-
 drivers/rtc/rtc-max6916.c                          |   2 +-
 drivers/rtc/rtc-max77686.c                         |   4 +-
 drivers/rtc/rtc-max8997.c                          |   2 +-
 drivers/rtc/rtc-max8998.c                          |   2 +-
 drivers/rtc/rtc-mc13xxx.c                          |   2 +-
 drivers/rtc/rtc-mcp795.c                           |   4 +-
 drivers/rtc/rtc-mpc5121.c                          |   2 +-
 drivers/rtc/rtc-mrst.c                             |   4 +-
 drivers/rtc/rtc-msm6242.c                          |   2 +-
 drivers/rtc/rtc-mt7622.c                           |   3 +-
 drivers/rtc/rtc-mv.c                               |  14 +-
 drivers/rtc/rtc-mxc_v2.c                           |   2 +-
 drivers/rtc/rtc-nuc900.c                           |  14 +-
 drivers/rtc/rtc-omap.c                             |   6 +-
 drivers/rtc/rtc-pcap.c                             |   2 +-
 drivers/rtc/rtc-pcf2123.c                          |   2 +-
 drivers/rtc/rtc-pcf2127.c                          |   2 +-
 drivers/rtc/rtc-pcf50633.c                         |   2 +-
 drivers/rtc/rtc-pcf85063.c                         |  20 +-
 drivers/rtc/rtc-pcf8523.c                          |   2 +-
 drivers/rtc/rtc-pcf85363.c                         | 205 ++++++++-
 drivers/rtc/rtc-pic32.c                            |   2 +-
 drivers/rtc/rtc-pm8xxx.c                           |  55 ++-
 drivers/rtc/rtc-ps3.c                              |   2 +-
 drivers/rtc/rtc-r7301.c                            |   2 +-
 drivers/rtc/rtc-r9701.c                            |   2 +-
 drivers/rtc/rtc-rk808.c                            |  25 +-
 drivers/rtc/rtc-rp5c01.c                           |  67 ++-
 drivers/rtc/rtc-rs5c348.c                          |   5 -
 drivers/rtc/rtc-rs5c372.c                          |  24 +-
 drivers/rtc/rtc-rv8803.c                           |  33 +-
 drivers/rtc/rtc-rx4581.c                           |   6 +-
 drivers/rtc/rtc-rx6110.c                           |   2 +-
 drivers/rtc/rtc-rx8010.c                           |   2 +-
 drivers/rtc/rtc-rx8025.c                           |   2 +-
 drivers/rtc/rtc-rx8581.c                           |   6 +-
 drivers/rtc/rtc-s35390a.c                          |  38 +-
 drivers/rtc/rtc-s3c.c                              |   2 +-
 drivers/rtc/rtc-s5m.c                              |  27 +-
 drivers/rtc/rtc-sc27xx.c                           |   2 +-
 drivers/rtc/rtc-sh.c                               |   2 +-
 drivers/rtc/rtc-sirfsoc.c                          |  18 -
 drivers/rtc/rtc-snvs.c                             |  15 +-
 drivers/rtc/rtc-spear.c                            |  12 +-
 drivers/rtc/rtc-st-lpc.c                           |  16 -
 drivers/rtc/rtc-starfire.c                         |   2 +-
 drivers/rtc/rtc-stk17ta8.c                         |  74 ++-
 drivers/rtc/rtc-sun6i.c                            |   2 +-
 drivers/rtc/rtc-sunxi.c                            |   2 +-
 drivers/rtc/rtc-sysfs.c                            |  12 +
 drivers/rtc/rtc-tegra.c                            |   4 -
 drivers/rtc/rtc-tps6586x.c                         |   2 +-
 drivers/rtc/rtc-tx4939.c                           |  95 ++--
 drivers/rtc/rtc-wm831x.c                           |   2 +-
 drivers/rtc/rtc-xgene.c                            |   2 +-
 drivers/rtc/rtc-zynqmp.c                           |   2 +-
 drivers/rtc/systohc.c                              |   2 +-
 include/linux/mfd/samsung/rtc.h                    |  11 -
 include/linux/rtc.h                                |  29 +-
 include/trace/events/rtc.h                         | 206 +++++++++
 123 files changed, 1810 insertions(+), 1084 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
 create mode 100644 drivers/rtc/rtc-isl12026.c
 create mode 100644 include/trace/events/rtc.h

--=20
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAlrL4vgACgkQAyWl4gNJ
NJKLMA/+MhnCsjNTEZwp08QjQm8e09L8Xa/oBeKHFbFBMby9mpbTDDtIyjcVeh6Z
16DM09PX/Wa2/02zW1CCGWCzOiKYVPao4lPuhdEW0RcyQ8UcW5MPWn+0e2eDGrw9
BVGxLgI6Ck1JPqJopkLublCTw5woG38YE70PcVzIXsNlxEvU/SmTUNnd3FuPLiPI
YEHuJHqJKSk7L2AITrtu2A5WQsMvSLoaY7mpKhLtxN5rlC4dIiaEOscogGoCVVDz
7Q4qfxmq89LwwnT3QnleYrX/x6QjDsE5Eg20w58laNRmq/alto9LkEP2Z6cYE4QZ
/jDDVQMOsZjpE5BPdcnGY1Z5cIVsYKYhieLb8tLlJhO5uJdmG2d3kYJQVn3LOejS
sJJ+eiWiDigT/Nlh/wyFJuQ01DDTqBEGZBuGkQOCztuyltMTZk4Ml6umgSInrvJt
eCH7DBzZPtU4cgPCmosLKpzhjDOSFQOC5rAJXKDbmm3LNqGMk7x9EU6IZFrCphnD
LeSMrmNg8QCnlJ2HGaK8xTZGWu7SyLnOAeeYJBFNoZRyqIqJ98G/wQvLGuWq7wRS
tSRTz1G43LQLQtdc+eADj/m4FSxsOEXwwToMsjbwwVyYumYmjsBeXmfqWY9N4bmT
TJmErd9PT+H2cuWvTHn2O4cmdknEZj12nOE3utLjYTPnFecDPWw=
=5pVQ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
