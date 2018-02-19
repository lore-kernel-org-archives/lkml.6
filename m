Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x224hrqhXosApUyLRBKcTVyUMoMqX1Wpgfu4F+m9mcxzn1v3+OkWd6RGad286Be9PVZDrlJBn
ARC-Seal: i=1; a=rsa-sha256; t=1519035292; cv=none;
        d=google.com; s=arc-20160816;
        b=AJ280830Ye6KuTx3dDogXY62/IlDlxnN/3Ou02nKF4UlqVvrbkhn1SeQtCq/dwg6Ni
         VyRl3wEY+l+GTYpR+JJ/5526z3uMBg8ALsJQt95gYRJlpIYuSFZ7+qyJack+6G4GLgpc
         EXjowa3shOKAcMl3UMj1rvAnUzxpSSb7t2rTbQX6hDJ+wC1CYVUpSNGU6Rnd6FPiP2y/
         Yb8yw6LoK9sZqh3vExM4KGNLqS2vTzb3Cd+bnRKp/Jz2Ls01SJ0EKPAbyhbTbM/7uhCY
         QAtGkCbLkcRDDzBN4e0BQ1eUHZ5KN7ZPvH6mvPechGWf2CcW3fagno6DmAgDOmW3y0l9
         33Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=eVXrqTXtxEG9bmultQsB61CyawsCKv0A6MAfHntmcVY=;
        b=AZbq3ZGCDUHuNf3HCZGF4D/sjvONixREThqu3BRpY2ZthsU4Z71joovgDtcz3VMLzy
         udu9Fd4Q8OkWU4uOMo86XJrSA65a5LnK+pwvemGfXKJnIWdUcjFSuMwYjl4ycVfJQBr6
         +CaIeZRWG2TT1FHm+/uoguCiCjNvkb8FlblEjhyyY8gAuu82WIbWX9QnChUfwrSicpz0
         MNhlnE6GGdBbmyONKWW3dEsfK49zMMYfd2C0AkgJyhFHp9Aa7DgRl4aKmzoDoU83qIGf
         3bTLLruf9hzfKMNYeepiZUKQ/XhRoYTvmslA2oeNizj24F7PLVrS3Ad5X03CC763kCab
         y0Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-spi@vger.kernel.org
Subject: [4.9-stable 5/9] spi: bcm-qspi: shut up warning about cfi header inclusion
Date: Mon, 19 Feb 2018 11:13:24 +0100
Message-Id: <20180219101343.2922561-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:fNFR2SkUFidD6DOd1hU5AvN+G6oI/N4CzysfeBlm1iWZIRCXOjG
 lzSiGhuoVlgPkivX+6stIh5N/Jf0u9LytIbyq28exIKTIGw14a9UrOiZjRCSTzRu/lGbybA
 qMpS3H3sDgUDW0uUAzzK9bJCz4LO3ub7HvBrnpH9Jt+g3czQLb4vxAeeO3LeRPwrRa/WG1s
 3EAsc7gB9arOjNrOzBm3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AY+2YVoWEbo=:fcLX51cy29RDGkP2X7ABTd
 nTnjHh6+mW6exPRfg9cVmHDnu5imP2UR6MDsWOAfSPGSGt3ptNr+bR7nQNA7uBv0gHt5Kkzu3
 6h44G5xyrlDmlhfZ/WS9mXJE4dqi48R9GAEnd9iSHbJuf/y3h2SFL53eV/WSl254Yt39LVSJI
 8fLuN8MgOm4wBFqWi8ohl9130IwniMzh6PAfyUcdM3BIAObboHm/9NQWClD6RHsVVLv2iy9/8
 /Vsp6EUx6f2ZD/7GQKhcEcEHz3yaKxy4IK+uwbLboPJV/6rVwoRc/uB03051qq02Z4tRM5Udb
 6QZsYIIyOMilbBvCLOHqPBKWF16pKkYeAh59SlzSD6TQ2nD08ER2vy6UwJkgWxXAInaMCP7xa
 nsZx0YWb0wgBvPMtsAGSfUc2MGZRRkOIcDhhr4ZyGiFqvKG2LG/aQoBjRwkUmZkbjAq04a96B
 yQH6brhEwlPXZdYUft/jgnkxVXluvhrz8M0SscUBsKwJnVwc/oOvfhiBnJXVzaz+hSJ4gjt5L
 NRZaSu6ll5VrjSo2mUmky7CfrS/hwEPxPfz4LnaXqReKE9dQqVVlJFZER4Co5oYG4hsKsRWHb
 6chw7mabsJOmU6UYtT/7nJfybMADygwUaOA45EhVBex9Tffe1WNlI7bboKiQLruORZOfqBocc
 Xnqrg3hMxQZ0y5aqLVk0FLgN8mbZmK9GBkDsiDcZj7vm925RcMUElyz0+IfhmSwK5GXrPPAai
 +yRLugm2oY5cEDT7lpKTmSFoJQ5Xlphf+slcOw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592823950124353439?=
X-GMAIL-MSGID: =?utf-8?q?1592823950124353439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When CONFIG_MTD_CFI is disabled, we get a warning for this spi driver:

include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]

The problem here is a layering violation that was fixed in mainline kernels with
a larger rework in commit 054e532f8f90 ("spi: bcm-qspi: Remove hardcoded settings
and spi-nor.h dependency"). We can't really backport that to stable kernels, so
this just adds a Kconfig dependency to make it either build cleanly or force it
to be disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b7995474148c..0e7415f6d093 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -156,6 +156,7 @@ config SPI_BCM63XX_HSSPI
 config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
 	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || COMPILE_TEST
+	depends on MTD_NORFLASH
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
-- 
2.9.0
