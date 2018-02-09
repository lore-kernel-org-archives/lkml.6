Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeBIW2v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:28:51 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44432 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752488AbeBIW2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:28:50 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Stefan Agner <stefan@agner.ch>, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v4 0/3] mtd: nand: vf610: fix error handling in vf610_nfc_probe()
Date: Sat, 10 Feb 2018 01:28:33 +0300
Message-Id: <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180130141141.7f4fd15a@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vf610_nfc_probe() misses error handling of mtd_device_register()
and contains unneeded of_node_put() on error path.

v2: Add nand_cleanup() to undone nand_scan_tail() as Boris Brezillon noted.
v3: Rename error labels, remove of_node_put() per Boris Brezillon request.
v4: Separate fix in to 3 patches.

Alexey Khoroshilov (3):
  mtd: nand: vf610: remove the unnecessary of_node_put()
  mtd: nand: vf610: improve readability of error label
  mtd: nand: vf610: check mtd_device_register() return code

 drivers/mtd/nand/vf610_nfc.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

-- 
2.7.4
