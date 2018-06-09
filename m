Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ytKiCYIiHFvhOAAAmS7hNA
	; Sat, 09 Jun 2018 18:55:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 747DD608CA; Sat,  9 Jun 2018 18:55:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x+h866za"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 691C2608BF;
	Sat,  9 Jun 2018 18:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 691C2608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeFISzN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 14:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753319AbeFISzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 14:55:11 -0400
Received: from mail.kernel.org (unknown [91.207.57.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3232204EE;
        Sat,  9 Jun 2018 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528570511;
        bh=dFkEDgJ/KLPnlwQ0Fx+vGDD+gK4edzIV4a9xIqBSEuc=;
        h=Date:From:To:Cc:Subject:From;
        b=x+h866zaFJhhb41rNJeRdilMWBio+6CTTHX4ZiVuCJnNgG83J/TBzYPUF5RbrWx+n
         dWPHe9+5/EffpTwGU+0E+ruvgcWr5BPtuVkSp9Tmbi28Z4KWCvNREuIbdvcbsVwcfY
         klE/N1hrS/04KOf+VHkONTMdMqb6JTq1d4dxaIFo=
Date: Sat, 9 Jun 2018 20:55:06 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 4.18
Message-ID: <20180609185506.6pogmj5jd3swacwh@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="akmbbgfpvgyqgtxt"
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--akmbbgfpvgyqgtxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Stephen reported a merge conflict in the USB tree, that I pulled
into power-supply via a tag Greg prepared for me. The issue has
been fixed by Greg in the USB tree in the meantime, so I suppose
git will figure it out by itself.

-- Sebastian

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.18

for you to fetch changes up to c42812da1395bf57a6f7b5934b5339a3a42c2c7d:

  MAINTAINERS: add entry for LEGO MINDSTORMS EV3 (2018-06-01 13:11:31 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.18 series

* bq27xxx: Add BQ27426 support
* ab8500: Drop AB8540/9540 support
* Introduced new usb_type property
* Properly document the power-supply ABI
* misc. cleanups and fixes

----------------------------------------------------------------
Adam Thomson (6):
      typec: tcpm: Add core support for sink side PPS
      Documentation: power: Initial effort to document power_supply ABI
      power: supply: Add error checking of psy desc during registration
      power: supply: Add 'usb_type' property and supporting code
      typec: tcpm: Represent source supply through power_supply
      typec: tcpm: Add support for sink PPS related messages

Andrew F. Davis (1):
      power: supply: bq27xxx: Add support for BQ27426

Colin Ian King (2):
      power: supply: ab8500_fg: fix spelling mistake: "Disharge" -> "Discharge"
      power: supply: ab8500_charger: fix spelling mistake: "faile" -> "failed"

David Lechner (1):
      MAINTAINERS: add entry for LEGO MINDSTORMS EV3

Dmitry Osipenko (3):
      usb: phy: tegra: Cleanup error messages
      usb: tegra: Move utmi-pads reset from ehci-tegra to tegra-phy
      usb: phy: Add Kconfig entry for Tegra PHY driver

Dominik Bozek (1):
      usb: hub: Don't wait for connect state at resume for powered-off ports

Geert Uytterhoeven (1):
      usb: Remove depends on HAS_DMA in case of platform dependency

Greg Kroah-Hartman (1):
      typec: tcpm: fix compiler warning about stupid things

Gregory CLEMENT (2):
      usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
      usb: host: xhci-plat: Fix clock resource by adding a register clock

Gustavo A. R. Silva (1):
      usb: core: hcd: mark expected switch fall-through

Hans de Goede (4):
      power: supply: axp288_charger: Support 3500 and 4000 mA input current limit
      power: supply: axp288_charger: Do not bind when the charge function is not used
      power: supply: axp288_fuelguage: Do not bind when the fg function is not used
      power: supply: axp288_fuel_gauge: Remove polling from the driver

Jia-Ju Bai (3):
      usb: storage: Replace mdelay with msleep in init_freecom
      usb: isp1760: Replace mdelay with msleep in isp1760_init_core
      usb: isp1760: Replace mdelay with msleep in isp1760_stop

Johan Hovold (6):
      USB: phy: drop unused legacy controller-phy bind helper
      USB: core: hcd: drop support for legacy phys
      USB: ehci-omap: drop unused legacy phy support
      USB: musb: omap2430: drop non-DT support
      USB: renesas_usbhs: drop unused legacy-phy support
      USB: phy: drop legacy board-file support

Ladislav Michl (2):
      power: supply: sysfs: Use enum to specify property
      power: supply: charger-manager: Verify polling interval only when polling requested

Li Jun (5):
      usb: typec: tcpm: pdo matching optimization
      usb: typec: fusb302: remove max_snk_* for sink config
      dt-bindings: usb: fusb302: remove max-sink-* properties
      usb: typec: wcove: remove max_snk_* for sink config
      usb: typec: tcpm: remove max_snk_mv/ma/mw

Linus Walleij (1):
      power: supply: ab8500: Drop AB8540/9540 support

Mathias Nyman (6):
      usb: define HCD_USB32 speed option for hosts that support USB 3.2 dual-lane
      USB: Add support to store lane count used by USB 3.2
      usb: set root hub lane counts
      USB: show USB 3.2 Dual-lane devices as Gen Xx2 during device enumeration
      USB: USB 3.2 Add sysfs entries for a usb device rx_lanes and tx_lanes
      Documentation sysfs-bus-usb: Add rx_lanes and tx_lanes introduced in USB 3.2

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out

Mike Looijmans (1):
      gpio-poweroff: Use gpiod_set_value_cansleep

Sebastian Reichel (1):
      Merge tag 'tags/tcpm-pps-4.18' into psy-next

Sergiy Kibrik (1):
      power: supply: s3c-adc-battery: fix driver data initialization

ShuFan Lee (2):
      staging: typec: rt1711h typec chip driver
      dt-bindings: usb: rt1711h device tree binding document

Shuah Khan (1):
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Souptick Joarder (1):
      usb: mon: Change return type to vm_fault_t

Takashi Iwai (1):
      usb: audio-v2: Correct the comment for struct uac_clock_selector_descriptor

Wei Yongjun (1):
      usb: roles: Fix potential NULL dereference in intel_xhci_usb_probe()

Wolfram Sang (3):
      usb: phy: simplify getting .drvdata
      usb: mtu3: simplify getting .drvdata
      power: supply: simplify getting .drvdata

Yossi Mansharoff (1):
      doc: usb: ci-hdrc-usb2: Add property "mux-controls"

 Documentation/ABI/testing/sysfs-bus-usb            |   18 +
 Documentation/ABI/testing/sysfs-class-power        |  455 +++++++++
 .../devicetree/bindings/power/supply/bq27xxx.txt   |    1 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    6 +
 .../devicetree/bindings/usb/fcs,fusb302.txt        |    6 -
 .../devicetree/bindings/usb/richtek,rt1711h.txt    |   17 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    5 +-
 MAINTAINERS                                        |    8 +
 drivers/power/reset/gpio-poweroff.c                |    4 +-
 drivers/power/supply/ab8500_bmdata.c               |   63 --
 drivers/power/supply/ab8500_btemp.c                |   93 +-
 drivers/power/supply/ab8500_charger.c              |  133 +--
 drivers/power/supply/ab8500_fg.c                   |   14 +-
 drivers/power/supply/abx500_chargalg.c             |   62 --
 drivers/power/supply/axp288_charger.c              |   26 +-
 drivers/power/supply/axp288_fuel_gauge.c           |   27 +-
 drivers/power/supply/bq27xxx_battery.c             |    9 +
 drivers/power/supply/bq27xxx_battery_i2c.c         |    2 +
 drivers/power/supply/charger-manager.c             |    5 +-
 drivers/power/supply/gpio-charger.c                |    3 +-
 drivers/power/supply/power_supply_core.c           |   11 +-
 drivers/power/supply/power_supply_sysfs.c          |  123 ++-
 drivers/power/supply/s3c_adc_battery.c             |    8 +-
 drivers/staging/typec/Kconfig                      |    8 +
 drivers/staging/typec/Makefile                     |    1 +
 drivers/staging/typec/tcpci.h                      |    1 +
 drivers/staging/typec/tcpci_rt1711h.c              |  312 ++++++
 drivers/usb/core/hcd.c                             |   47 +-
 drivers/usb/core/hub.c                             |   23 +-
 drivers/usb/core/sysfs.c                           |   22 +
 drivers/usb/gadget/udc/Kconfig                     |    4 +-
 drivers/usb/host/Kconfig                           |    4 +-
 drivers/usb/host/ehci-omap.c                       |    5 +-
 drivers/usb/host/ehci-tegra.c                      |   87 +-
 drivers/usb/host/xhci-plat.c                       |   31 +-
 drivers/usb/host/xhci.h                            |    3 +-
 drivers/usb/isp1760/isp1760-core.c                 |    2 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |    2 +-
 drivers/usb/mon/mon_bin.c                          |    2 +-
 drivers/usb/mtu3/Kconfig                           |    2 +-
 drivers/usb/mtu3/mtu3_plat.c                       |    6 +-
 drivers/usb/musb/omap2430.c                        |   95 +-
 drivers/usb/phy/Kconfig                            |    9 +
 drivers/usb/phy/Makefile                           |    2 +-
 drivers/usb/phy/phy-am335x.c                       |    6 +-
 drivers/usb/phy/phy-tegra-usb.c                    |  140 ++-
 drivers/usb/phy/phy.c                              |  133 +--
 drivers/usb/renesas_usbhs/common.h                 |    1 -
 drivers/usb/renesas_usbhs/rcar2.c                  |   29 -
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |    2 +
 drivers/usb/storage/freecom.c                      |    4 +-
 drivers/usb/typec/Kconfig                          |    1 +
 drivers/usb/typec/fusb302/Kconfig                  |    2 +-
 drivers/usb/typec/fusb302/fusb302.c                |  105 +-
 drivers/usb/typec/tcpm.c                           | 1059 ++++++++++++++++++--
 drivers/usb/typec/typec_wcove.c                    |    4 +-
 drivers/usb/usbip/stub_dev.c                       |    4 +-
 include/linux/mfd/abx500.h                         |    1 -
 include/linux/mfd/abx500/ab8500-bm.h               |    2 -
 include/linux/mfd/abx500/ux500_chargalg.h          |    4 -
 include/linux/power/bq27xxx_battery.h              |    3 +-
 include/linux/power_supply.h                       |   16 +
 include/linux/usb.h                                |    4 +
 include/linux/usb/audio-v2.h                       |    2 +-
 include/linux/usb/hcd.h                            |    2 +-
 include/linux/usb/pd.h                             |    4 +-
 include/linux/usb/phy.h                            |   36 -
 include/linux/usb/tcpm.h                           |   10 +-
 include/linux/usb/tegra_usb_phy.h                  |    2 +
 include/uapi/linux/usb/ch11.h                      |    5 +
 70 files changed, 2383 insertions(+), 965 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
 create mode 100644 drivers/staging/typec/tcpci_rt1711h.c

--akmbbgfpvgyqgtxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlscIogACgkQ2O7X88g7
+poAwA/+KQvfPJzeNynYexn+d+kruUctmMwgggRnYXIK72oxCEk0Lc6QetfA/+TI
zjkPQ5GNm9omZwi2HO+eHwUOcfLVSsr0HB9NHOyD9i2Tqzx90knSnMKeU1jlXaB9
SVpfmpr2BD/+8AXs2JZrzmUL6P1Ir7FpZRURt87HKl2Wy/IEMLrcxuEAGyyCLMPs
mx5y98+YIfneMuh2bgviaJ9tqKsjCDr1fWjZFkxKvd92ltMVZjB+mhh19oiRJF2T
USrRjwZHdnqrYxms5vW5MUTxZmJQngJDsptUFC8kLvHQSonFVbqEKyx62lC0tDz5
uk1v0F/QsRh+R1gEYr/SrucM1nlKfloetc4bsZxeG7ivqMp2H//SxuTcCDB9I13z
YecZ/lyRcy4Y9C2IABNOkcnyFw870Codn7P72px5cwddjSaZ4fLanLOZYMdf87AT
wTQw376J3alGNnO5/1JtMQJy0ZtnyOMKIFt6r3/HyQxDmb3fSzVg19kjT5w7nkbN
JyN+hJUZSvPj4/OmwRjnhXf3EpTNtDcElScz/i4vmHFuly/65hpfU+QiLtqr08xp
/EXdDxW2bDxxUfS/n89ROhUV5yvTGJ9sYh5kwqePia1xxEnzUX4dTzd4pskl9ELa
Zzfp+9cck5isriQk5yFWk5YlYNE6kIKsf3VB6ac5or3ltoS/SIQ=
=34Gm
-----END PGP SIGNATURE-----

--akmbbgfpvgyqgtxt--
