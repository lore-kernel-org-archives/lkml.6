Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeBGIzw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:55:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57207 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753483AbeBGIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:55:49 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] bluetooth: hci_ll: Replace mdelay with msleep in
 download_firmware
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1517047432-23420-1-git-send-email-baijiaju1990@gmail.com>
Date: Wed, 7 Feb 2018 09:55:46 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4991CEBC-8298-4AE5-86FD-686261E16BA6@holtmann.org>
References: <1517047432-23420-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju,

> download_firmware() is never called from atomic context.
> 
> It is only called by ll_setup() that is called only via function pointer 
> "->setup" used in hci_uart_setup() in drivers/bluetooth/hci_serdev.c and
> drivers/bluetooth/hci_ldisc.c. hci_uart_setup() is called only 
> via function pointer "->setup" used in hci_dev_do_open() 
> in net/bluetooth/hci_core.c.
> All of the above functions do not enter atomic context.
> 
> Besides, ll_setup() calls msleep() and hci_dev_do_open calls mutex_lock().
> So it indicates that all the above functions call functions that can sleep.
> 
> Despite never getting called from atomic context, download_firmware() 
> calls mdelay() for busy wait.
> That is not necessary and can be replaced with msleep to avoid busy wait.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> drivers/bluetooth/hci_ll.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
