Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tCiaGZRyHlvCBgAAmS7hNA
	; Mon, 11 Jun 2018 13:01:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C841607BB; Mon, 11 Jun 2018 13:01:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BD0DE60385;
	Mon, 11 Jun 2018 13:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD0DE60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeFKNBF convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 09:01:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52073 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKNBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:01:03 -0400
Received: from marcel-macpro.fritz.box (p5B3D24B5.dip0.t-ipconnect.de [91.61.36.181])
        by mail.holtmann.org (Postfix) with ESMTPSA id 317A3CF185;
        Mon, 11 Jun 2018 15:07:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180611115240.32606-16-ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 15:01:01 +0200
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

> Export serdev table to the module header, allowing module autoload via
> udev/modprobe.
> 
> Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> drivers/net/ethernet/qualcomm/qca_uart.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
> index db6068cd7a1f..6d2ac6cae63f 100644
> --- a/drivers/net/ethernet/qualcomm/qca_uart.c
> +++ b/drivers/net/ethernet/qualcomm/qca_uart.c
> @@ -405,6 +405,12 @@ static void qca_uart_remove(struct serdev_device *serdev)
> 	free_netdev(qca->net_dev);
> }
> 
> +static struct serdev_device_id qca_uart_serdev_id[] = {
> +	{ QCAUART_DRV_NAME, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(serdev, qca_uart_serdev_id);
> +
> static struct serdev_device_driver qca_uart_driver = {
> 	.probe = qca_uart_probe,
> 	.remove = qca_uart_remove,
> @@ -412,6 +418,7 @@ static struct serdev_device_driver qca_uart_driver = {
> 		.name = QCAUART_DRV_NAME,
> 		.of_match_table = of_match_ptr(qca_uart_of_match),
> 	},
> +	.id_table = qca_uart_serdev_id,
> };

the commit message is misleading me. If I build something with ACPI or DT support, then modinfo will show all modalias information for ACPI and DT compatible strings. What else does udev/modprobe actually need? Is something broken with the modalias export?

Regards

Marcel
