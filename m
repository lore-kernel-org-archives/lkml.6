Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeFENx7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:53:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46471 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeFENx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:53:58 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180529131014.18641-5-ricardo.ribalda@gmail.com>
Date: Tue, 5 Jun 2018 15:53:55 +0200
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E848BED5-1D83-47FA-A673-29B366A60227@holtmann.org>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-5-ricardo.ribalda@gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

> Describe which hardware is supported by the current driver.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> drivers/bluetooth/hci_nokia.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index 3539fd03f47e..e32dfcd56b8d 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -801,6 +801,11 @@ static const struct of_device_id nokia_bluetooth_of_match[] = {
> MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
> #endif
> 
> +static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
> +	{ "hp4-bluetooth", },
> +	{},
> +};
> +
> static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
> 	.probe = nokia_bluetooth_serdev_probe,
> 	.remove = nokia_bluetooth_serdev_remove,
> @@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetooth_serdev_driver = {
> 		.pm = &nokia_bluetooth_pm_ops,
> 		.of_match_table = of_match_ptr(nokia_bluetooth_of_match),
> 	},
> +	.id_table = nokia_bluetooth_serdev_id,
> };

I would actually skip this hardware. First of all it is such a dedicated custom Nokia transport and hardware, and secondly it is no longer produced anyway.

Regards

Marcel
