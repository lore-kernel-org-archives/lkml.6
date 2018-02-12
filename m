Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeBLVbq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:31:46 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:35128 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeBLVbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:31:41 -0500
Date: Mon, 12 Feb 2018 22:31:39 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        ldv-project@linuxtesting.org, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 0/3] mtd: nand: vf610: fix error handling in
 vf610_nfc_probe()
Message-ID: <20180212223139.2e5404a9@bbrezillon>
In-Reply-To: <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
References: <20180130141141.7f4fd15a@bbrezillon>
        <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018 01:28:33 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> vf610_nfc_probe() misses error handling of mtd_device_register()
> and contains unneeded of_node_put() on error path.

Applied the whole series.

Thanks,

Boris

> 
> v2: Add nand_cleanup() to undone nand_scan_tail() as Boris Brezillon noted.
> v3: Rename error labels, remove of_node_put() per Boris Brezillon request.
> v4: Separate fix in to 3 patches.
> 
> Alexey Khoroshilov (3):
>   mtd: nand: vf610: remove the unnecessary of_node_put()
>   mtd: nand: vf610: improve readability of error label
>   mtd: nand: vf610: check mtd_device_register() return code
> 
>  drivers/mtd/nand/vf610_nfc.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
