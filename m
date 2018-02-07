Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeBGIzs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:55:48 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58359 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeBGIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:55:47 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] bluetooth: btmrvl_main: Replace GFP_ATOMIC with
 GFP_KERNEL in btmrvl_send_sync_cmd
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1516982221-8524-1-git-send-email-baijiaju1990@gmail.com>
Date: Wed, 7 Feb 2018 09:55:44 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C39D859D-E8B7-4805-94F7-28FEFCACEEEC@holtmann.org>
References: <1516982221-8524-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju,

> After checking all possible call chains to btmrvl_send_sync_cmd(), 
> my tool finds that this function is never called in atomic context, 
> namely never in an interrupt handler or holding a spinlock. 
> And it calls wait_event_interruptible_timeout() after bt_skb_alloc(), 
> so it indicates that btmrvl_send_sync_cmd() 
> can call function which can sleep.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> drivers/bluetooth/btmrvl_main.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
