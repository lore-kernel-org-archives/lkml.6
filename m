Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39FAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917E7218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbeLSPzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:55:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37890 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbeLSPzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:55:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7F3420A82; Wed, 19 Dec 2018 16:54:57 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id A19E8206A7;
        Wed, 19 Dec 2018 16:54:47 +0100 (CET)
Date:   Wed, 19 Dec 2018 16:54:47 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [GIT PULL] i3c: Initial pull request
Message-ID: <20181219165447.2db6a689@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the first PR for the I3C subsystem, and this times it comes
even before the merge window is open (which I hope is not a problem :-/).
Let me know if it's too early and I'll try to resend it next week.

Regards,

Boris

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-4.21

for you to fetch changes up to 25ac3da61ba144f8dbfe377eeec6b1da7ad0854a:

  i3c: master: cdns: fix I2C transfers in Cadence I3C master driver (2018-12-12 17:08:32 +0100)

----------------------------------------------------------------
Add initial support for I3C along with 2 I3C master controller drivers.

----------------------------------------------------------------
Boris Brezillon (7):
      i3c: Add core I3C infrastructure
      docs: driver-api: Add I3C documentation
      i3c: Add sysfs ABI spec
      dt-bindings: i3c: Document core bindings
      MAINTAINERS: Add myself as the I3C subsystem maintainer
      i3c: master: Add driver for Cadence IP
      dt-bindings: i3c: Document Cadence I3C master bindings

Colin Ian King (1):
      i3c: master: dw: fix mask operation by using the correct operator

Dan Carpenter (2):
      i3c: fix an error code in i3c_master_add_i3c_dev_locked()
      ic3: off by one in mode_show()

Przemyslaw Gaj (1):
      i3c: master: cdns: fix I2C transfers in Cadence I3C master driver

Vitor Soares (3):
      i3c: master: Add driver for Synopsys DesignWare IP
      dt-binding: i3c: Document Synopsys DesignWare I3C
      MAINTAINERS: Add myself as the dw-i3c-master module maintainer

YueHaibing (1):
      i3c: master: Remove set but not used variable 'old_i3c_scl_lim'

 Documentation/ABI/testing/sysfs-bus-i3c                      |  146 ++
 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt    |   43 +
 Documentation/devicetree/bindings/i3c/i3c.txt                |  138 ++
 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt |   41 +
 Documentation/driver-api/i3c/device-driver-api.rst           |    9 +
 Documentation/driver-api/i3c/index.rst                       |   11 +
 Documentation/driver-api/i3c/master-driver-api.rst           |    9 +
 Documentation/driver-api/i3c/protocol.rst                    |  203 +++
 Documentation/driver-api/index.rst                           |    1 +
 MAINTAINERS                                                  |   18 +
 drivers/Kconfig                                              |    2 +
 drivers/Makefile                                             |    2 +-
 drivers/i3c/Kconfig                                          |   24 +
 drivers/i3c/Makefile                                         |    4 +
 drivers/i3c/device.c                                         |  233 +++
 drivers/i3c/internals.h                                      |   26 +
 drivers/i3c/master.c                                         | 2659 ++++++++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig                                   |   22 +
 drivers/i3c/master/Makefile                                  |    2 +
 drivers/i3c/master/dw-i3c-master.c                           | 1216 ++++++++++++++++
 drivers/i3c/master/i3c-master-cdns.c                         | 1666 +++++++++++++++++++++
 include/linux/i3c/ccc.h                                      |  385 +++++
 include/linux/i3c/device.h                                   |  331 +++++
 include/linux/i3c/master.h                                   |  648 +++++++++
 include/linux/mod_devicetable.h                              |   17 +
 25 files changed, 7855 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100644 Documentation/driver-api/i3c/device-driver-api.rst
 create mode 100644 Documentation/driver-api/i3c/index.rst
 create mode 100644 Documentation/driver-api/i3c/master-driver-api.rst
 create mode 100644 Documentation/driver-api/i3c/protocol.rst
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100644 drivers/i3c/master/i3c-master-cdns.c
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h
