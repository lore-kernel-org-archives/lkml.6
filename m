Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeBUVY0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:24:26 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46888 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBUU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 000/100] rtc: remove cargo culted code
Date: Wed, 21 Feb 2018 21:54:55 +0100
Message-Id: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series:
 - removes useless calls to rtc_valid_tm in .read_time, .set_time and
   .set_alarm
 - removes code setting default values for RTCs (and lets the core
   handle it)
 - removes useless "time is invalid" messages at probe time
 - removes useless indirect calls

Those were mostly copy pasted from other drivers

Alexandre Belloni (100):
  rtc: ds1511: let the core handle invalid time
  rtc: ds1553: let the core handle invalid time
  rtc: cmos: let the core handle invalid time
  rtc: rs5c348: let the core handle invalid time
  rtc: stk17ta8: let the core handle invalid time
  rtc: ab-b5ze-s3: stop validating rtc_time in .read_time
  rtc: ab3100: stop validating rtc_time in .read_time
  rtc: ab8500: stop validating rtc_time in .read_time
  rtc: ac100: stop validating rtc_time in .read_time
  rtc: au1xxx: stop validating rtc_time in .read_time
  rtc: bq32k: stop validating rtc_time in .read_time
  rtc: coh901331: stop validating rtc_time in .read_time
  rtc: cpcap: stop validating rtc_time in .read_time
  rtc: da9052: stop validating rtc_time in .read_time
  rtc: da9055: stop validating rtc_time in .read_time
  rtc: da9063: stop validating rtc_time in .read_time
  rtc: ds1216: stop validating rtc_time in .read_time
  rtc: ds1286: stop validating rtc_time in .read_time
  rtc: ds1302: stop validating rtc_time in .read_time
  rtc: ds1305: stop validating rtc_time in .read_time
  rtc: ds1307: stop validating rtc_time in .read_time
  rtc: ds1343: stop validating rtc_time in .read_time
  rtc: ds1347: stop validating rtc_time in .read_time
  rtc: ds1390: stop validating rtc_time in .read_time
  rtc: ds1685: stop validating rtc_time in .read_time
  rtc: ds1742: stop validating rtc_time in .read_time
  rtc: ds2404: stop validating rtc_time in .read_time
  rtc: ds3232: stop validating rtc_time in .read_time
  rtc: efi: stop validating rtc_time in .read_time
  rtc: fm3130: stop validating rtc_time in .read_time
  rtc: jz4740: stop validating rtc_time in .read_time
  rtc: lpc24xx: stop validating rtc_time in .read_time
  rtc: lpc32xx: stop validating rtc_time in .read_time
  rtc: ls1x: stop validating rtc_time in .read_time
  rtc: m41t94: stop validating rtc_time in .read_time
  rtc: m48t35: stop validating rtc_time in .read_time
  rtc: m48t59: stop validating rtc_time in .read_time
  rtc: m48t86: stop validating rtc_time in .read_time
  rtc: max6902: stop validating rtc_time in .read_time
  rtc: max6916: stop validating rtc_time in .read_time
  rtc: max8997: stop validating rtc_time in .read_time
  rtc: max8998: stop validating rtc_time in .read_time
  rtc: mc13xxx: stop validating rtc_time in .read_time
  rtc: mcp795: stop validating rtc_time in .read_time
  rtc: mpc5121: stop validating rtc_time in .read_time
  rtc: mrst: stop validating rtc_time in .read_time
  rtc: msm6242: stop validating rtc_time in .read_time
  rtc: mt7622: stop validating rtc_time in .read_time
  rtc: mv: stop validating rtc_time in .read_time
  rtc: nuc900: stop validating rtc_time in .read_time
  rtc: pcap: stop validating rtc_time in .read_time
  rtc: pcf2123: stop validating rtc_time in .read_time
  rtc: pcf2127: stop validating rtc_time in .read_time
  rtc: pcf50633: stop validating rtc_time in .read_time
  rtc: pcf8523: stop validating rtc_time in .read_time
  rtc: pic32: stop validating rtc_time in .read_time
  rtc: ps3: stop validating rtc_time in .read_time
  rtc: r7301: stop validating rtc_time in .read_time
  rtc: r9701: stop validating rtc_time in .read_time
  rtc: rp5c01: stop validating rtc_time in .read_time
  rtc: rx6110: stop validating rtc_time in .read_time
  rtc: rx8010: stop validating rtc_time in .read_time
  rtc: rx8025: stop validating rtc_time in .read_time
  rtc: s3c: stop validating rtc_time in .read_time
  rtc: s5m: stop validating rtc_time in .read_time
  rtc: sc27xx: stop validating rtc_time in .read_time
  rtc: sh: stop validating rtc_time in .read_time
  rtc: starfire: stop validating rtc_time in .read_time
  rtc: sun6i: stop validating rtc_time in .read_time
  rtc: sunxi: stop validating rtc_time in .read_time
  rtc: tps6586x: stop validating rtc_time in .read_time
  rtc: tx4939: stop validating rtc_time in .read_time
  rtc: wm831x: stop validating rtc_time in .read_time
  rtc: xgene: stop validating rtc_time in .read_time
  rtc: zynqmp: stop validating rtc_time in .read_time
  rtc: isl12022: stop validating rtc_time in .read_time
  rtc: isl12022: remove useless indirection
  rtc: m41t80: stop validating rtc_time in .read_time
  rtc: m41t93: stop validating rtc_time in .read_time
  rtc: max77686: stop validating rtc_time in .read_time
  rtc: omap: stop validating rtc_time in .set_time and .set_alarm
  rtc: spear: stop validating rtc_time in .set_time and .set_alarm
  rtc: tegra: stop validating rtc_time in .set_time
  rtc: abx80x: remove useless message
  rtc: pm8xxx: remove useless message
  rtc: rx4581: remove useless message
  rtc: rx8581: remove useless message
  rtc: tile: remove useless message
  rtc: rk808: remove useless debug message
  rtc: rk808: fix possible race condition
  rtc: s35390a: remove useless message
  rtc: s35390a: stop validating rtc_time in .read_time
  rtc: s35390a: remove useless indirection
  rtc: rs5c372:  remove useless message
  rtc: rs5c372: stop validating rtc_time in .read_time
  rtc: rs5c372: remove useless indirection
  rtc: max6900: stop validating rtc_time in .read_time
  rtc: max6900: remove useless indirection
  rtc: pcf85063: stop validating rtc_time in .read_time
  rtc: pcf85063: remove useless indirection

 drivers/rtc/rtc-ab-b5ze-s3.c |  4 +---
 drivers/rtc/rtc-ab3100.c     |  2 +-
 drivers/rtc/rtc-ab8500.c     |  2 +-
 drivers/rtc/rtc-abx80x.c     |  6 +-----
 drivers/rtc/rtc-ac100.c      |  2 +-
 drivers/rtc/rtc-au1xxx.c     |  2 +-
 drivers/rtc/rtc-bq32k.c      |  2 +-
 drivers/rtc/rtc-cmos.c       | 12 ------------
 drivers/rtc/rtc-coh901331.c  |  2 +-
 drivers/rtc/rtc-cpcap.c      |  2 +-
 drivers/rtc/rtc-da9052.c     |  3 +--
 drivers/rtc/rtc-da9055.c     |  2 +-
 drivers/rtc/rtc-da9063.c     |  2 +-
 drivers/rtc/rtc-ds1216.c     |  2 +-
 drivers/rtc/rtc-ds1286.c     |  2 +-
 drivers/rtc/rtc-ds1302.c     |  3 +--
 drivers/rtc/rtc-ds1305.c     |  3 +--
 drivers/rtc/rtc-ds1307.c     |  3 +--
 drivers/rtc/rtc-ds1343.c     |  2 +-
 drivers/rtc/rtc-ds1347.c     |  2 +-
 drivers/rtc/rtc-ds1390.c     |  2 +-
 drivers/rtc/rtc-ds1511.c     |  4 ----
 drivers/rtc/rtc-ds1553.c     |  4 ----
 drivers/rtc/rtc-ds1685.c     |  2 +-
 drivers/rtc/rtc-ds1742.c     |  2 +-
 drivers/rtc/rtc-ds2404.c     |  2 +-
 drivers/rtc/rtc-ds3232.c     |  2 +-
 drivers/rtc/rtc-efi.c        |  2 +-
 drivers/rtc/rtc-fm3130.c     |  3 +--
 drivers/rtc/rtc-isl12022.c   | 18 +++++-------------
 drivers/rtc/rtc-jz4740.c     |  2 +-
 drivers/rtc/rtc-lpc24xx.c    |  2 +-
 drivers/rtc/rtc-lpc32xx.c    |  2 +-
 drivers/rtc/rtc-ls1x.c       |  2 +-
 drivers/rtc/rtc-m41t80.c     |  2 +-
 drivers/rtc/rtc-m41t93.c     |  2 +-
 drivers/rtc/rtc-m41t94.c     |  3 +--
 drivers/rtc/rtc-m48t35.c     |  2 +-
 drivers/rtc/rtc-m48t59.c     |  2 +-
 drivers/rtc/rtc-m48t86.c     |  2 +-
 drivers/rtc/rtc-max6900.c    | 19 +++++--------------
 drivers/rtc/rtc-max6902.c    |  2 +-
 drivers/rtc/rtc-max6916.c    |  2 +-
 drivers/rtc/rtc-max77686.c   |  4 +---
 drivers/rtc/rtc-max8997.c    |  2 +-
 drivers/rtc/rtc-max8998.c    |  2 +-
 drivers/rtc/rtc-mc13xxx.c    |  2 +-
 drivers/rtc/rtc-mcp795.c     |  2 +-
 drivers/rtc/rtc-mpc5121.c    |  2 +-
 drivers/rtc/rtc-mrst.c       |  2 +-
 drivers/rtc/rtc-msm6242.c    |  2 +-
 drivers/rtc/rtc-mt7622.c     |  2 +-
 drivers/rtc/rtc-mv.c         |  2 +-
 drivers/rtc/rtc-nuc900.c     | 14 ++++++++------
 drivers/rtc/rtc-omap.c       |  3 ---
 drivers/rtc/rtc-pcap.c       |  2 +-
 drivers/rtc/rtc-pcf2123.c    |  2 +-
 drivers/rtc/rtc-pcf2127.c    |  2 +-
 drivers/rtc/rtc-pcf50633.c   |  2 +-
 drivers/rtc/rtc-pcf85063.c   | 18 +++++-------------
 drivers/rtc/rtc-pcf8523.c    |  2 +-
 drivers/rtc/rtc-pic32.c      |  2 +-
 drivers/rtc/rtc-pm8xxx.c     |  6 ------
 drivers/rtc/rtc-ps3.c        |  2 +-
 drivers/rtc/rtc-r7301.c      |  2 +-
 drivers/rtc/rtc-r9701.c      |  2 +-
 drivers/rtc/rtc-rk808.c      | 25 +++++++------------------
 drivers/rtc/rtc-rp5c01.c     |  2 +-
 drivers/rtc/rtc-rs5c348.c    |  5 -----
 drivers/rtc/rtc-rs5c372.c    | 24 +++++-------------------
 drivers/rtc/rtc-rx4581.c     |  6 +-----
 drivers/rtc/rtc-rx6110.c     |  2 +-
 drivers/rtc/rtc-rx8010.c     |  2 +-
 drivers/rtc/rtc-rx8025.c     |  2 +-
 drivers/rtc/rtc-rx8581.c     |  6 +-----
 drivers/rtc/rtc-s35390a.c    | 38 +++++++++-----------------------------
 drivers/rtc/rtc-s3c.c        |  2 +-
 drivers/rtc/rtc-s5m.c        |  2 +-
 drivers/rtc/rtc-sc27xx.c     |  2 +-
 drivers/rtc/rtc-sh.c         |  2 +-
 drivers/rtc/rtc-spear.c      | 12 +++---------
 drivers/rtc/rtc-starfire.c   |  2 +-
 drivers/rtc/rtc-stk17ta8.c   |  4 ----
 drivers/rtc/rtc-sun6i.c      |  2 +-
 drivers/rtc/rtc-sunxi.c      |  2 +-
 drivers/rtc/rtc-tegra.c      |  4 ----
 drivers/rtc/rtc-tile.c       |  3 ---
 drivers/rtc/rtc-tps6586x.c   |  2 +-
 drivers/rtc/rtc-tx4939.c     |  2 +-
 drivers/rtc/rtc-wm831x.c     |  2 +-
 drivers/rtc/rtc-xgene.c      |  2 +-
 drivers/rtc/rtc-zynqmp.c     |  2 +-
 92 files changed, 122 insertions(+), 263 deletions(-)

-- 
2.16.1
