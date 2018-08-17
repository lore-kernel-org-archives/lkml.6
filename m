Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84663C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323B32191C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="jdcCEk2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323B32191C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=linux-watchdog.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeHQOXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:23:34 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:46472 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeHQOXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:23:34 -0400
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 7D4AB40693; Fri, 17 Aug 2018 13:00:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 7D4AB40693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1534503654;
        bh=XJ/Lnasoa2C/xErpgQunFFG4Tzb6lL8ujJIz1i0GcWA=;
        h=Date:From:To:Cc:Subject:From;
        b=jdcCEk2KwkTxJwCQh//W2rHPSwQ2nGIrP/9IlnPkxNSX2+qmdKId5oAVKUxMQE99z
         KnSfksgCjiUA6g+PgDycAygdGQceyWZDDOBySMBR7ZnGlejs4jysHkLzIxv9Wf5qg1
         dlOxspxb7lNnd6rhbLXqLUHVbL/zvT5FzFJwM/6E=
Date:   Fri, 17 Aug 2018 13:00:54 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Ludovic Barre <ludovic.barre@st.com>,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Subject: [GIT PULL REQUEST] watchdog - v4.19 Merge window
Message-ID: <20180817110054.GA22769@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.19 release cycle.

This series contains:
* MEN 16z069 IP-Core: Add driver
* renesas-wdt: Add support for the R8A77990 wdt
* stm32_iwdg: Add stm32mp1 support and pclk feature
* sp805_wdt, orion_wdt, sprd_wdt: add several improvements
* imx2_wdt, stmp3xxx: Switch to SPDX identifier

The output from git request-pull:
----------------------------------------------------------------

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.19-rc1

for you to fetch changes up to 12aea518a202bc7c947553840f1d93f8129b41b2:

  watchdog: fix dependencies of menz69_wdt.o (2018-08-06 17:12:42 +0200)

----------------------------------------------------------------
linux-watchdog 4.19-rc1 tag

----------------------------------------------------------------
Fabio Estevam (2):
      watchdog: imx2_wdt: Switch to SPDX identifier
      watchdog: stmp3xxx: Switch to SPDX identifier

Johannes Thumshirn (2):
      watchdog: add driver for the MEN 16z069 IP-Core
      watchdog: fix dependencies of menz69_wdt.o

Ludovic Barre (2):
      dt-bindings: watchdog: add stm32mp1 support
      watchdog: stm32: add pclk feature for stm32mp1

Masaharu Hayakawa (1):
      dt-bindings: watchdog: renesas-wdt: Add support for the R8A77990 wdt

Maxim Kochetkov (1):
      watchdog: orion_wdt: Mark watchdog as active when running at probe

Ray Jui (4):
      dt-bindings: watchdog: Consolidate SP805 binding docs
      dt-bindings: watchdog: Add optional 'timeout-sec' property for sp805
      watchdog: sp805: add 'timeout-sec' DT property support
      watchdog: sp805: set WDOG_HW_RUNNING when appropriate

Srinath Mannam (1):
      watchdog: sp805: Add clock-frequency property

Wei Yongjun (1):
      watchdog: sprd_wdt: Remove redundant dev_err call in sprd_wdt_probe()

 .../devicetree/bindings/watchdog/arm,sp805.txt     |  29 +++-
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   1 +
 .../devicetree/bindings/watchdog/sp805-wdt.txt     |  31 ----
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  13 +-
 MAINTAINERS                                        |   6 +
 drivers/watchdog/Kconfig                           |  10 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imx2_wdt.c                        |   5 +-
 drivers/watchdog/menz69_wdt.c                      | 170 +++++++++++++++++++++
 drivers/watchdog/orion_wdt.c                       |   2 +
 drivers/watchdog/sp805_wdt.c                       |  63 ++++++--
 drivers/watchdog/sprd_wdt.c                        |   4 +-
 drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++-----
 drivers/watchdog/stmp3xxx_rtc_wdt.c                |   5 +-
 14 files changed, 351 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
 create mode 100644 drivers/watchdog/menz69_wdt.c
