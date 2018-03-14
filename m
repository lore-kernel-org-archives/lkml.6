Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELsVedfEpEu+PWD2rqm/OlDnkX2B7S4nafFYh3DZCUES1hEWsnmmljmPrjmJWMRAmKmMAw+G
ARC-Seal: i=1; a=rsa-sha256; t=1521058982; cv=none;
        d=google.com; s=arc-20160816;
        b=ttBy/Km3VPVCC77piWhqzuDVmjD45Oy+PjDkm/NrcDv8Tf9iB9YZCwnMebmqfV8+iw
         +3bwxJ/6cVuZ1IcoLa4hOR1CR57TffRUMmvVay5b/Am+XFRowDvxprlAAHYoJJkrFd6V
         H2Fyqy2GgqnPwNvl/TrRn6aBlR09nCvOCgGXIFO8DZbJAWx8qlp9M4E3aooW44x8orvh
         L/TBE5/7eDPIIXc3+e0NoXA36l3UG0cfu532ZpnZCgXOYwVifvK9t/xQA/ZFvsUd4TRS
         n0NFTSJFFL/EZQU13htZ2gtL7IdxOKTvC/uaIeuzAgwgH2MZXQl2FguRVFOPA6w467qX
         M07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=IJ5uZfWJggK93iE3xtg4L/OmNKaF9iWtf+dLugHd5h0=;
        b=AxpcagdKL2vAdDzm9aE3Kf+RYIi9kpgC/gSIz4egCCl885+YAIfoPAiTM6UXzJ91y5
         zwVjb8VMSD7eMfdchZDO/S8wR2E8rHGbhYHpq41A/iqjcB2IVlZc38MEnTazTMC9QxJH
         U/Uc1pe2m7I9ib0Qzyma9IpJ5E/dgfSAgo58BrvqndOOp8RgYkuGptFGazef/i9D6p7w
         rxq6ocRJKOjo+kwsO+HL4NeV15txBgoeP4jj+FcsTb3uwLVdmh9krFjMBmPZxnhPGAlA
         VNqhglaXQ3puV4+2mgtem6DjbmnliXpwvu8p9Py3/tZLJ1ayMXb6KldnJf94P/ZC+eKb
         MTNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:34 +1100
Subject: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594945943746723387?=
X-GMAIL-MSGID: =?utf-8?q?1594945943746723387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,
 I'd like to submit the following drivers to staging.  They
 are all for components of the mt7621 MIPS-based SOC from Mediatek.
 I lifted them out of libreCMC and (for the ethernet code) out
 of email posts from about 2 years ago.  I forward-ported
 them to mainline, fixed enough bugs that they mostly work,
 and moved them to staging.

 With these patches the GNUBEE is almost usable.  It needs
 one patch to arch/mips/kernel/setup.c because mips_cm_probe()
 is being called too early.  To successfully reboot (i.e warm-restart)
 it needs a small patch to drivers/mtd/devices/m25p80.c.

 I've made a point of only included code that I can actually test
 on hardware that I have.  That has meant selecting only a few patches
 from a series and in a couple of cases, discarding some files from a
 patch.  I haven't discard code from within a file that I need part
 of.

 All the driver patches had a From: of John Crispin so he is cc:ed -
 thanks John!!

 I have added TODO files, some of which have useful details.
 I think some of the drivers (eth,mmc, maybe dma) should be merged
 with related mainline code rather than added as separate drivers.

 I've included a dts file for the GNUBEE.  When all the other drivers
 move out of staging, it should follow them.

 I plan to continue to work on these drivers, but probably not for a
 few weeks at least.

Thanks,
NeilBrown

---

John Crispin (12):
      staging: mt7621-pci: MIPS/ralink: add MT7621 pcie driver
      staging: mt7621-pinctrl: ralink: add pinctrl driver
      staging: mt7621-gpio: ralink: add mt7621 gpio controller
      staging: mt7621-spi: add mt7621 support
      staging: mt7621-dma: ralink: add rt2880 dma engine
      staging: mt7621-mmc: MIPS: ralink: add sdhci for mt7620a SoC
      staging: mt7621-eth: Document ralink/mediatek SoC ethernet binding
      staging: mt7621-eth: add the drivers core files
      staging: mt7621-eth: add gigabit switch driver (GSW)
      staging: mt7621-eth: add mdio support for mt762X family
      staging: mt7621-eth: add support for mt7621
      staging: mt7621-eth: mediatek: add Kconfig and Makefile

NeilBrown (1):
      staging: mt7621-dts: add dts files


 drivers/staging/Kconfig                            |   14 
 drivers/staging/Makefile                           |    8 
 drivers/staging/mt7621-dma/Kconfig                 |   12 
 drivers/staging/mt7621-dma/Makefile                |    4 
 drivers/staging/mt7621-dma/TODO                    |    5 
 drivers/staging/mt7621-dma/mtk-hsdma.c             |  767 +++++
 drivers/staging/mt7621-dma/ralink-gdma.c           |  928 ++++++
 drivers/staging/mt7621-dts/Kconfig                 |    5 
 drivers/staging/mt7621-dts/Makefile                |    3 
 drivers/staging/mt7621-dts/TODO                    |    5 
 drivers/staging/mt7621-dts/gbpc1.dts               |  143 +
 drivers/staging/mt7621-dts/mt7621.dtsi             |  471 +++
 .../devicetree/bindings/net/mediatek-net-gsw.txt   |   48 
 drivers/staging/mt7621-eth/Kconfig                 |   39 
 drivers/staging/mt7621-eth/Makefile                |   14 
 drivers/staging/mt7621-eth/TODO                    |   13 
 drivers/staging/mt7621-eth/ethtool.c               |  225 +
 drivers/staging/mt7621-eth/ethtool.h               |   22 
 drivers/staging/mt7621-eth/gsw_mt7620.h            |  277 ++
 drivers/staging/mt7621-eth/gsw_mt7621.c            |  298 ++
 drivers/staging/mt7621-eth/mdio.c                  |  271 ++
 drivers/staging/mt7621-eth/mdio.h                  |   27 
 drivers/staging/mt7621-eth/mdio_mt7620.c           |  173 +
 drivers/staging/mt7621-eth/mtk_eth_soc.c           | 2178 ++++++++++++++
 drivers/staging/mt7621-eth/mtk_eth_soc.h           |  721 +++++
 drivers/staging/mt7621-eth/soc_mt7621.c            |  160 +
 drivers/staging/mt7621-gpio/Kconfig                |    6 
 drivers/staging/mt7621-gpio/Makefile               |    3 
 drivers/staging/mt7621-gpio/TODO                   |    5 
 drivers/staging/mt7621-gpio/gpio-mt7621.c          |  353 ++
 drivers/staging/mt7621-mmc/Kconfig                 |   16 
 drivers/staging/mt7621-mmc/Makefile                |   42 
 drivers/staging/mt7621-mmc/TODO                    |    8 
 drivers/staging/mt7621-mmc/board.h                 |  137 +
 drivers/staging/mt7621-mmc/dbg.c                   |  347 ++
 drivers/staging/mt7621-mmc/dbg.h                   |  156 +
 drivers/staging/mt7621-mmc/mt6575_sd.h             | 1001 +++++++
 drivers/staging/mt7621-mmc/sd.c                    | 3074 ++++++++++++++++++++
 drivers/staging/mt7621-pci/Makefile                |    1 
 drivers/staging/mt7621-pci/TODO                    |   12 
 drivers/staging/mt7621-pci/pci-mt7621.c            |  840 +++++
 drivers/staging/mt7621-pinctrl/Kconfig             |    4 
 drivers/staging/mt7621-pinctrl/Makefile            |    3 
 drivers/staging/mt7621-pinctrl/TODO                |    6 
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c    |  472 +++
 drivers/staging/mt7621-spi/Kconfig                 |    6 
 drivers/staging/mt7621-spi/Makefile                |    1 
 drivers/staging/mt7621-spi/TODO                    |    5 
 drivers/staging/mt7621-spi/spi-mt7621.c            |  489 +++
 49 files changed, 13818 insertions(+)
 create mode 100644 drivers/staging/mt7621-dma/Kconfig
 create mode 100644 drivers/staging/mt7621-dma/Makefile
 create mode 100644 drivers/staging/mt7621-dma/TODO
 create mode 100644 drivers/staging/mt7621-dma/mtk-hsdma.c
 create mode 100644 drivers/staging/mt7621-dma/ralink-gdma.c
 create mode 100644 drivers/staging/mt7621-dts/Kconfig
 create mode 100644 drivers/staging/mt7621-dts/Makefile
 create mode 100644 drivers/staging/mt7621-dts/TODO
 create mode 100644 drivers/staging/mt7621-dts/gbpc1.dts
 create mode 100644 drivers/staging/mt7621-dts/mt7621.dtsi
 create mode 100644 drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt
 create mode 100644 drivers/staging/mt7621-eth/Kconfig
 create mode 100644 drivers/staging/mt7621-eth/Makefile
 create mode 100644 drivers/staging/mt7621-eth/TODO
 create mode 100644 drivers/staging/mt7621-eth/ethtool.c
 create mode 100644 drivers/staging/mt7621-eth/ethtool.h
 create mode 100644 drivers/staging/mt7621-eth/gsw_mt7620.h
 create mode 100644 drivers/staging/mt7621-eth/gsw_mt7621.c
 create mode 100644 drivers/staging/mt7621-eth/mdio.c
 create mode 100644 drivers/staging/mt7621-eth/mdio.h
 create mode 100644 drivers/staging/mt7621-eth/mdio_mt7620.c
 create mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.c
 create mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.h
 create mode 100644 drivers/staging/mt7621-eth/soc_mt7621.c
 create mode 100644 drivers/staging/mt7621-gpio/Kconfig
 create mode 100644 drivers/staging/mt7621-gpio/Makefile
 create mode 100644 drivers/staging/mt7621-gpio/TODO
 create mode 100644 drivers/staging/mt7621-gpio/gpio-mt7621.c
 create mode 100644 drivers/staging/mt7621-mmc/Kconfig
 create mode 100644 drivers/staging/mt7621-mmc/Makefile
 create mode 100644 drivers/staging/mt7621-mmc/TODO
 create mode 100644 drivers/staging/mt7621-mmc/board.h
 create mode 100644 drivers/staging/mt7621-mmc/dbg.c
 create mode 100644 drivers/staging/mt7621-mmc/dbg.h
 create mode 100644 drivers/staging/mt7621-mmc/mt6575_sd.h
 create mode 100644 drivers/staging/mt7621-mmc/sd.c
 create mode 100644 drivers/staging/mt7621-pci/Makefile
 create mode 100644 drivers/staging/mt7621-pci/TODO
 create mode 100644 drivers/staging/mt7621-pci/pci-mt7621.c
 create mode 100644 drivers/staging/mt7621-pinctrl/Kconfig
 create mode 100644 drivers/staging/mt7621-pinctrl/Makefile
 create mode 100644 drivers/staging/mt7621-pinctrl/TODO
 create mode 100644 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
 create mode 100644 drivers/staging/mt7621-spi/Kconfig
 create mode 100644 drivers/staging/mt7621-spi/Makefile
 create mode 100644 drivers/staging/mt7621-spi/TODO
 create mode 100644 drivers/staging/mt7621-spi/spi-mt7621.c

--
Signature
