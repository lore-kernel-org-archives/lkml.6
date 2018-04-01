Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeDAI4k (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 04:56:40 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:43804 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeDAI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 04:56:39 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, pantelis.antoniou@konsulko.com,
        mark.rutland@arm.com, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, joe@perches.com, corbet@lwn.net,
        me@tobin.cc, sergey.senozhatsky@gmail.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/2] cowsay support
Date: Sun,  1 Apr 2018 10:56:20 +0200
Message-Id: <20180401085622.7754-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the printk subsystem gains more and more popularity it is time to add
the final missing feature to make it perfect, namely cowsay output.
Currently only one type of cow is supported and the only user is kmsg,
but I can see more use cases for it and the need for different cow types.

Example of /dev/kmsg usage:
[    1.309561]   _________________________________________
[    1.309561] < systemd[1]: Detected architecture x86-64. >
[    1.309561]   -----------------------------------------
[    1.309561]                     \   ^__^
[    1.309561]                      \  (oo)\_______
[    1.309561]                         (__)\       )\/\
[    1.309561]                             ||----w |
[    1.309561]                             ||     ||

Richard Weinberger (2):
  lib: vsprintf: Implement %pCOW
  printk: Use %pCOW for kmsg

 kernel/printk/printk.c |  5 ++++-
 lib/vsprintf.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.13.6
