Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1CNCKntxHlu1fQAAmS7hNA
	; Mon, 11 Jun 2018 12:56:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9F2DC607A4; Mon, 11 Jun 2018 12:56:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0C15B601C3;
	Mon, 11 Jun 2018 12:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C15B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933169AbeFKM4Z convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 08:56:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52561 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932912AbeFKM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:56:22 -0400
Received: from marcel-macpro.fritz.box (p5B3D24B5.dip0.t-ipconnect.de [91.61.36.181])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1104ACF185;
        Mon, 11 Jun 2018 15:03:03 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 04/24] Bluetooth: hci_nokia: Add serdev_id_table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180611115240.32606-5-ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 14:56:20 +0200
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <94360989-9AA9-422D-9CA3-AA631731BD2D@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-5-ricardo.ribalda@gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

> Describe which hardware is supported by the current driver.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> drivers/bluetooth/hci_nokia.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index 3539fd03f47e..eb3d59894aef 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -801,6 +801,11 @@ static const struct of_device_id nokia_bluetooth_of_match[] = {
> MODULE_DEVICE_TABLE(of, nokia_bluetooth_of_match);
> #endif
> 
> +static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
> +	{ "hp4-bluetooth", },
> +	{}
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

as I said before, don’t bother with this driver. There is no need for this. Nothing is generic here, it is all specific for each of the 5 devices they shipped. Nokia is not building these kind of devices anymore and if they start changing their mind, then we add a patch for it listening this id.

Regards

Marcel
