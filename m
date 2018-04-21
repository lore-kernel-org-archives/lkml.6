Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDUIuj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:50:39 -0400
Received: from bert.emutex.com ([91.103.1.109]:53853 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeDUIug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:50:36 -0400
From: Javier Arteaga <javier@emutex.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Arteaga <javier@emutex.com>, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [RFC PATCH RESEND 0/3] UP Squared board drivers
Date: Sat, 21 Apr 2018 09:50:06 +0100
Message-Id: <20180421085009.28773-1-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  [linux-kernel correctly Cc'd on the series now. Sorry for
   the noise.] Hi all, This series adds platform support for AAEON's UP Squared,
    a x86 SBC based on Apollo Lake [1]. Specifically, it enables control for
   the board pin headers and for the LEDs, as both of these features are only
    available behind a FPGA-based platform controller. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[linux-kernel correctly Cc'd on the series now. Sorry for the noise.]

Hi all,

This series adds platform support for AAEON's UP Squared, a x86 SBC
based on Apollo Lake [1]. Specifically, it enables control for the board
pin headers and for the LEDs, as both of these features are only
available behind a FPGA-based platform controller.

This is structured around a MFD driver that provides a regmap interface
to that platform controller to each MFD cell.

The series is carved out from an out-of-tree support patchset, initially
written by Dan O'Donovan for the original UP Board [2] and then extended
through the past year to support new entries in the lineup (UP Board, UP
Squared and UP Core) [3].

Here we only submit support for UP Squared to simplify review. Still,
the driver is designed so that it can easily gain support for the other
boards.

Questions:

* Is MFD the right fit for the platform controller?
  The intention here is to encapsulate the custom GPIO-bitbanged control
  protocol by sharing the regmap between the drivers.

* Is our use of two chained pinctrls (in patch 3/3) valid?

Thank you!

[1]: http://www.up-board.org/upsquared/specifications-up2/
[2]: https://lkml.kernel.org/r/1467648434-29080-1-git-send-email-dan@emutex.com
[3]: https://github.com/emutex/ubilinux-kernel/commits/upboard-4.9

Javier Arteaga (3):
  mfd: upboard: Add UP2 platform controller driver
  leds: upboard: Add LED support
  pinctrl: upboard: Add pinctrl and gpio driver

 drivers/leds/Kconfig              |  10 +
 drivers/leds/Makefile             |   1 +
 drivers/leds/leds-upboard.c       |  87 +++++
 drivers/mfd/Kconfig               |  17 +
 drivers/mfd/Makefile              |   1 +
 drivers/mfd/upboard.c             | 273 ++++++++++++++++
 drivers/pinctrl/Kconfig           |  13 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-upboard.c | 523 ++++++++++++++++++++++++++++++
 include/linux/mfd/upboard.h       |  70 ++++
 10 files changed, 996 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard.h

-- 
2.17.0
