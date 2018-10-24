Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A8FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44209206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="spVBuqIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44209206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJYCk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYCk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:40:28 -0400
Received: from earth.universe (host-92-3-126-56.as43234.net [92.3.126.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62EB1206B5;
        Wed, 24 Oct 2018 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540404683;
        bh=QVEQqUT+5/FXqP3+NhUWq8mk5SfVF2K28hqiX5bkcIA=;
        h=Date:From:To:Cc:Subject:From;
        b=spVBuqINhvWIKOPlNGM04NKmQY9IcCYukOKktPyZmfuRsl4lH4iBdksA5mPNPIGAj
         JDK48Q/TugFn5y82NbBPNjdCcSVRNrhXVgNdbZdq48porkv8/VxfcVpr+vNX+8RmPg
         F2IRYlLyMNWj1LEPpvtTn4//znAZtqYNxOONJu/M=
Received: by earth.universe (Postfix, from userid 1000)
        id 5F7BB3C0987; Wed, 24 Oct 2018 20:11:21 +0200 (CEST)
Date:   Wed, 24 Oct 2018 20:11:21 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 4.20
Message-ID: <20181024181121.3pw6o3qqcx6zd7ob@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bocorhr2qhyfdbao"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bocorhr2qhyfdbao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

All patches have been in linux-next for like 4 weeks except for
ones, that have only been in there for a couple of days. Those
are simple fixes not touching any real code, so it should be fine.
Please find the details are in the tag. There shouldn't be any
problems merging this.

-- Sebastian

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.20

for you to fetch changes up to cfb347979e71d3ce6be59a988b3357f541c9eacf:

  power: max8925: mark expected switch fall-through (2018-10-21 21:33:35 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.20 series

* Add Spreadtrum SC2731 charger driver
* bq25890-charger: Add BQ25896 support
* bq27xxx-battery: Add support for BQ27411
* qcom-pon: Add pms405 pon support
* cros-charger: add support for dedicated port
* misc. fixes

----------------------------------------------------------------
Andreas Kemnade (2):
      power: supply: twl4030_charger: fix charging current out-of-bounds
      power: supply: twl4030_charger: disable eoc interrupt on linear charge

Angus Ainslie (Purism) (4):
      power: supply: bq25890_charger: Add debugging output of failed initialization
      power: supply: bq25890_charger: Remove unused table entries
      power: supply: bq25890_charger: Add the BQ25896 part
      power: supply: bq25890_charger: Read back the current battery voltage

Baolin Wang (2):
      dt-bindings: power: Add Spreadtrum SC2731 charger documentation
      power: supply: Add Spreadtrum SC2731 charger support

Claudiu Beznea (6):
      power: reset: at91-poweroff: switch to slow clock before shutdown
      power: reset: at91-poweroff: use only one poweroff function
      power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
      power: reset: at91-poweroff: make sclk part of struct shdwc
      power: reset: at91-poweroff: rename at91_shdwc_base member of struct shdwc
      power: reset: at91-poweroff: do not procede if at91_shdwc is allocated

Colin Ian King (2):
      power: supply: cros_usbpd: remove unused pointer 'dev'
      power: supply: fix spelling mistake "Gauage" -> "Gauge"

Dan Carpenter (1):
      power: supply: ab8500_fg: silence uninitialized variable warnings

David Lechner (1):
      power: supply: sysfs: ratelimit property read error message

Ding Xiang (1):
      power: supply: ab8500_fg: fix obsolete function

Fabien Parent (2):
      mfd: cros: add charger port count command definition
      power: supply: cros: add support for dedicated port

Gustavo A. R. Silva (1):
      power: max8925: mark expected switch fall-through

Krzysztof Kozlowski (1):
      power: supply: maxim: Add SPDX license identifiers

Kuninori Morimoto (1):
      power: reset: convert to SPDX identifiers

Liu Xiang (1):
      power: supply: bq27xxx: Add support for BQ27411

Sebastian Reichel (2):
      Merge tag 'psy-at91-poweroff-immutable-for-v4.20-signed' into psy-next
      Merge tag 'psy-mfd-cros-immutable-for-v4.20-signed' into psy-next

Tomasz Figa (1):
      power: supply: max8998-charger: Fix platform data retrieval

Vinod Koul (1):
      power: reset: qcom-pon: Add pms405 pon support

kbuild test robot (1):
      power: supply: bq25890_charger: fix semicolon.cocci warnings

 .../devicetree/bindings/power/reset/qcom,pon.txt   |   5 +-
 .../devicetree/bindings/power/supply/bq25890.txt   |   3 +
 .../devicetree/bindings/power/supply/bq27xxx.txt   |   1 +
 .../bindings/power/supply/sc2731_charger.txt       |  40 ++
 arch/arm/mach-at91/pm_suspend.S                    |   8 +
 drivers/power/reset/at91-sama5d2_shdwc.c           | 119 +++--
 drivers/power/reset/qcom-pon.c                     |   1 +
 drivers/power/reset/rmobile-reset.c                |   5 +-
 drivers/power/supply/Kconfig                       |   7 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ab8500_fg.c                   |  52 ++-
 drivers/power/supply/bq25890_charger.c             |  62 ++-
 drivers/power/supply/bq27xxx_battery.c             |   9 +
 drivers/power/supply/bq27xxx_battery_i2c.c         |   2 +
 drivers/power/supply/cros_usbpd-charger.c          | 117 ++++-
 drivers/power/supply/ds2780_battery.c              |   2 +-
 drivers/power/supply/ds2781_battery.c              |   2 +-
 drivers/power/supply/ds2782_battery.c              |   2 +-
 drivers/power/supply/max14577_charger.c            |  22 +-
 drivers/power/supply/max17040_battery.c            |  18 +-
 drivers/power/supply/max17042_battery.c            |  32 +-
 drivers/power/supply/max77693_charger.c            |  22 +-
 drivers/power/supply/max8925_power.c               |   1 +
 drivers/power/supply/max8997_charger.c             |  26 +-
 drivers/power/supply/max8998_charger.c             |  28 +-
 drivers/power/supply/power_supply_sysfs.c          |   3 +-
 drivers/power/supply/sc2731_charger.c              | 504 +++++++++++++++++++++
 drivers/power/supply/twl4030_charger.c             |  30 +-
 include/linux/mfd/cros_ec_commands.h               |  10 +
 include/linux/power/bq27xxx_battery.h              |   1 +
 30 files changed, 922 insertions(+), 213 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
 create mode 100644 drivers/power/supply/sc2731_charger.c

--bocorhr2qhyfdbao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvQtcYACgkQ2O7X88g7
+pqJ3A//cZijmASolDKhjKNiJc/HblfuNEnHjPeSczx8p3CuEt7V00bvKoNLG5MX
qnxiUtV6PHdW7gpPBTf/3j2MG/qX8DkM5pbYu4kedPkQzouA8X1RingRPEqx90AW
P9TC21lW18t+20qoRDU10P6HcWMsufn54HclMOC8QILi4S5UvMFJoicHoOP3hROL
alFb4v+1tqNZ78YFgtaoATdhP5VB+SSrOzU5IYJhxN1US9u85Qz23gE2X3wATCFD
H6vuTlk3g2YSj9k+hj99c0TMCU/sRR/5sVbRfpXjWN46s9bbgNc1ffGsGtIuzUYa
Bp2Goc7xTeLKuGbkd08TNKtBPWT16x+fWkZkGcG6ZR6rFte/UU7fVSyZrTKVv01h
mh+M765xATvTR2mtJz0jyxuyYZmfdr25tlihn5pRKrS5P2LwoFl7WrenBpSAB90d
CeDjruaWLz+pbi4egI14batY+ytgIJsH0rfk0i3mXWPBNbrTO7wmBLYu9A30kgy5
6FyWjseH+rsT1qe5ZA+eRWGrCbF5XLGjX0ljmDXmVMfoUCEbibwSazpcSV8kRFin
iBNzpTKGVyoJAmAGO5t0sch+mjm4m2CNVkNX2IarY7iON7sr32c7GVj9hbQ1WX6a
n9g93IKcpVCAWjXwPFMVorwH8gszDn7tJbrP1whwCLQztta6r/I=
=Kcv9
-----END PGP SIGNATURE-----

--bocorhr2qhyfdbao--
