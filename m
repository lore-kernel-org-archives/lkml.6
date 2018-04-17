Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeDRQFE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:05:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44074 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751972AbeDRQE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:04:58 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/9] Add support for Cirrus Logic CS47L35/L85/L90/L91 codecs
Date: Tue, 17 Apr 2018 15:29:06 +0100
Message-ID: <20180417142915.15772-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=544 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804180144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: Compared to older versions of this chain I have removed patches at the
end of the chain that were being ignored until the earlier patches had been
merged - an impossible circular dependency. There were too many moving targets
to keep the whole chain up-to-date and so patches that were already acked were
getting stale. The subset of patches here are all acked or close-to-acked, and
can be built and used as they are to produce a working pinctrl and gpio.

The Cirrus Logic CS47L35, CS47L85, CS47L90/91 codecs are complex audio SoC
devices. In addition to the core audio capability they have onboard GPIO,
regulators, DSPs and interrupt controller and a large register map space
accessed over SPI or I2C. This family of codecs is based around common IP
blocks and they are managed by a set of common drivers referred to as "Madera".

Richard Fitzgerald (9):
  mfd: madera: Add register definitions for Cirrus Logic Madera codecs
  mfd: madera: Add DT bindings for Cirrus Logic Madera codecs
  mfd: madera: Add common support for Cirrus Logic Madera codecs
  mfd: madera: Register map tables for Cirrus Logic CS47L35
  mfd: madera: Register map tables for Cirrus Logic CS47L85
  mfd: madera: Register map tables for Cirrus Logic CS47L90/91
  pinctrl: madera: Add DT bindings for Cirrus Logic Madera codecs
  pinctrl: madera: Add driver for Cirrus Logic Madera codecs
  gpio: madera: Support Cirrus Logic Madera class codecs

 Documentation/devicetree/bindings/mfd/madera.txt   |  102 +
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |   99 +
 MAINTAINERS                                        |   16 +
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-madera.c                         |  206 +
 drivers/mfd/Kconfig                                |   50 +
 drivers/mfd/Makefile                               |   14 +
 drivers/mfd/cs47l35-tables.c                       | 1609 ++++++++
 drivers/mfd/cs47l85-tables.c                       | 3009 +++++++++++++++
 drivers/mfd/cs47l90-tables.c                       | 2674 +++++++++++++
 drivers/mfd/madera-core.c                          |  609 +++
 drivers/mfd/madera-i2c.c                           |  140 +
 drivers/mfd/madera-spi.c                           |  139 +
 drivers/mfd/madera.h                               |   44 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/cirrus/Kconfig                     |   15 +
 drivers/pinctrl/cirrus/Makefile                    |   13 +
 drivers/pinctrl/cirrus/pinctrl-cs47l35.c           |   45 +
 drivers/pinctrl/cirrus/pinctrl-cs47l85.c           |   59 +
 drivers/pinctrl/cirrus/pinctrl-cs47l90.c           |   57 +
 drivers/pinctrl/cirrus/pinctrl-madera-core.c       | 1076 ++++++
 drivers/pinctrl/cirrus/pinctrl-madera.h            |   41 +
 include/linux/mfd/madera/core.h                    |  187 +
 include/linux/mfd/madera/pdata.h                   |   59 +
 include/linux/mfd/madera/registers.h               | 3917 ++++++++++++++++++++
 27 files changed, 14189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 create mode 100644 drivers/gpio/gpio-madera.c
 create mode 100644 drivers/mfd/cs47l35-tables.c
 create mode 100644 drivers/mfd/cs47l85-tables.c
 create mode 100644 drivers/mfd/cs47l90-tables.c
 create mode 100644 drivers/mfd/madera-core.c
 create mode 100644 drivers/mfd/madera-i2c.c
 create mode 100644 drivers/mfd/madera-spi.c
 create mode 100644 drivers/mfd/madera.h
 create mode 100644 drivers/pinctrl/cirrus/Kconfig
 create mode 100644 drivers/pinctrl/cirrus/Makefile
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l35.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l85.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l90.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera-core.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera.h
 create mode 100644 include/linux/mfd/madera/core.h
 create mode 100644 include/linux/mfd/madera/pdata.h
 create mode 100644 include/linux/mfd/madera/registers.h

-- 
2.11.0
