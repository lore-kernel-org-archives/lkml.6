Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeFAMki (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:40:38 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:38477 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeFAMkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:40:31 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 0/8] serial: 8250: Add 485 emulation to 8250_dw.
Date: Fri,  1 Jun 2018 14:40:13 +0200
Message-Id: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to handle rs485 with 8250_dw port.

Use existing em485 emulation layer for 8250 taking care to fix some bug
and taking care especially of RTS_AFTER_SEND case.

Giulio Benetti (8):
  serial: 8250_dw: add em485 support
  serial: 8250_dw: allow enable rs485 at boot time
  serial: 8250: Copy em485 from port to real port.
  serial: 8250: Handle case port doesn't have TEMT interrupt using
    em485.
  serial: 8250_dw: treat rpm suspend with -EBUSY if RS485 ON and
    RTS_AFTER_SEND
  serial: 8250: Copy mctrl when register port.
  serial: 8250: Make em485_rts_after_send() set mctrl according to rts
    state.
  serial: core: Mask mctrl with TIOCM_RTS too if rs485 on and
    RTS_AFTER_SEND set.

 drivers/tty/serial/8250/8250.h      |  2 +-
 drivers/tty/serial/8250/8250_core.c |  2 ++
 drivers/tty/serial/8250/8250_dw.c   | 41 ++++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/8250/8250_port.c | 33 ++++++++++++++++-------
 drivers/tty/serial/serial_core.c    | 12 ++++++++-
 include/linux/serial_8250.h         |  1 +
 7 files changed, 79 insertions(+), 14 deletions(-)

-- 
2.17.0
