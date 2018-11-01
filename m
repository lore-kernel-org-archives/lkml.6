Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99023C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0F420820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0F420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeKAOgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:36:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53042 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbeKAOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:36:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EAC1D20798; Thu,  1 Nov 2018 06:35:23 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A8E3920726;
        Thu,  1 Nov 2018 06:35:23 +0100 (CET)
Date:   Thu, 1 Nov 2018 06:35:23 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Addition of the I3C subsystem in 4.20 (5.0)?
Message-ID: <20181101063523.26bdbe28@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg, Linus,

Greg, I didn't get your feedback on v10 of the i3c patchset [1] where I
was asking if you'd agree to have this framework merged in 4.20 (I know
you were busy with the 4.19 release and after that the Kernel Summit, so
that's not a surprise), so I'm sending this PR. It's really not an attempt
to bypass you, more like a ping that, if positively acknowledged, might
lead to inclusion of the I3C framework in 4.20 (5.0?) :-).

Please let me know if you're opposed to the idea.

Regards,

Boris

[1]https://lkml.org/lkml/2018/10/26/552 

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-4.20

for you to fetch changes up to 71e60757e1eab6f7b821585948317961ccdc61d1:

  dt-bindings: i3c: Document Cadence I3C master bindings (2018-11-01 06:12:05 +0100)

----------------------------------------------------------------
Add the I3C framework + an I3C controller driver for Cadence IP

----------------------------------------------------------------
Boris Brezillon (7):
      i3c: Add core I3C infrastructure
      docs: driver-api: Add I3C documentation
      i3c: Add sysfs ABI spec
      dt-bindings: i3c: Document core bindings
      MAINTAINERS: Add myself as the I3C subsystem maintainer
      i3c: master: Add driver for Cadence IP
      dt-bindings: i3c: Document Cadence I3C master bindings

 Documentation/ABI/testing/sysfs-bus-i3c                   |  146 ++
 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt |   44 +
 Documentation/devicetree/bindings/i3c/i3c.txt             |  139 ++
 Documentation/driver-api/i3c/device-driver-api.rst        |    9 +
 Documentation/driver-api/i3c/index.rst                    |   11 +
 Documentation/driver-api/i3c/master-driver-api.rst        |   10 +
 Documentation/driver-api/i3c/protocol.rst                 |  203 +++
 Documentation/driver-api/index.rst                        |    1 +
 MAINTAINERS                                               |   12 +
 drivers/Kconfig                                           |    2 +
 drivers/Makefile                                          |    2 +-
 drivers/i3c/Kconfig                                       |   24 +
 drivers/i3c/Makefile                                      |    4 +
 drivers/i3c/device.c                                      |  233 ++++
 drivers/i3c/internals.h                                   |   26 +
 drivers/i3c/master.c                                      | 2661 +++++++++++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig                                |    6 +
 drivers/i3c/master/Makefile                               |    1 +
 drivers/i3c/master/i3c-master-cdns.c                      | 1671 +++++++++++++++++++++++
 include/linux/i3c/ccc.h                                   |  385 ++++++
 include/linux/i3c/device.h                                |  331 +++++
 include/linux/i3c/master.h                                |  648 +++++++++
 include/linux/mod_devicetable.h                           |   17 +
 23 files changed, 6585 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
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
 create mode 100644 drivers/i3c/master/i3c-master-cdns.c
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h
