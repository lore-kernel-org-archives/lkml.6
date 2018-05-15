Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeEOSeR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:34:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:51327 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752178AbeEOSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:34:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="54606438"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Tue, 15 May 2018 21:34:06 +0300
Message-Id: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel console is sensitive to any kind of complex work needed to print
out anything on it. One such case is emergency print during Oops.

This series proposes to disable runtime PM and DMA operations on 8250
serial console.

More detailed explanation why is provided in patch 2.

The series has been in our internal trees for years already with no
problems observed.

Andy Shevchenko (3):
  console: introduce ->exit() callback
  serial: 8250_port: Don't use power management for kernel console
  serial: 8250_port: Disable DMA operations for kernel console

 drivers/tty/serial/8250/8250_core.c |  9 +++++++++
 drivers/tty/serial/8250/8250_port.c | 27 ++++++++++++++++++++++-----
 include/linux/console.h             |  1 +
 include/linux/serial_8250.h         |  1 +
 kernel/printk/printk.c              |  3 +++
 5 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.17.0
