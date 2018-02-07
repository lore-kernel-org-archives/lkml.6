Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeBGI40 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:56:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48398 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeBGIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:55:50 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] bluetooth: hci_ath: Replace mdelay with msleep in
 ath_wakeup_ar3k
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1517048258-23798-1-git-send-email-baijiaju1990@gmail.com>
Date: Wed, 7 Feb 2018 09:55:48 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <133171D5-E5F0-486D-869F-8066EB8ECE59@holtmann.org>
References: <1517048258-23798-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju,

> ath_wakeup_ar3k() is never called from atomic context.
> 
> It is only called by ath_hci_uart_work() that is only called in 
> ath_open() via INIT_WORK().
> All of the above functions do not enter atomic context along the way.
> 
> Despite never getting called from atomic context, ath_wakeup_ar3k() calls
> mdelay() for busy wait.
> That is not necessary and can be replaced with msleep to avoid busy wait.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> drivers/bluetooth/hci_ath.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
