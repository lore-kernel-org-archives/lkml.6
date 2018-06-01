Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFAI7x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:59:53 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFAI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:59:50 -0400
Subject: Re: [PATCH 15/19] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        netdev@vger.kernel.org
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-16-ricardo.ribalda@gmail.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <d41488cd-18db-f99a-67ae-b0e809005b1d@i2se.com>
Date: Fri, 1 Jun 2018 10:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529131014.18641-16-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:KBKHHIknQxTViJ0jVYOc6V7cZjOq27rKU+oLlgOnesbrViKKeJN
 z6gy7gVOQ4We2AmGf40SPr0rwQtJoBkEaDKzXg2/6PmxLRqx6pufvVisg6N09Vp8DbSDCht
 BWBmtx1UD5iNSi6HDOMQjN8d8QVFXvoFnv+41GqMxhsRwNIypNyUqvjOzDqyFAMPM6ZKPUO
 49uF+kA08RkJZK1+yCLuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ePVke3zeqik=:n7DaG8LWOzwgWsL12dSW76
 l8n8OCYp3CpMVwSrLelYkiMJ8Be0QF1QxSTM7R8ydyXVunm4YdM7zb4l/pfn7lrKWKrezhsaX
 SFJmSCVVds2YoA+JUnI0H2bgPldWMrgCiCfw5zSj1Z1gmnO446Rf9VhJKjoediM720nqV0ZlT
 f7SETotw1nmScgnDPdU1JEJyuQaDLR0hONCxNHUWvnYqumyJFij6rslDrczrMqRzLXrN8gE/A
 Ly0NBQpb5mMOiwOxEoozvnEqGdU15V3IgoX0IeBLHyozJYPGYl0CeZX7CW+XZtE6Uspg7fuGA
 qxkw8gz2RI08yJbq2XguiRzgWKF5TrCVUCEHSUxnUloiZ3vOqM7rbnBaDsNTCXpdL1FGLe+E5
 Med0O07rexEDF5OUpMB8QPKgb5+JtzjtVyG/NsEqpT3Go15MS6Etfk/YFZ/7la/zd7wLo10kn
 s17Zu2R+7TSlhXmVIA1tU+YqcSAmcU9mXl/TA5j6dC7M2sIEnuZRpIFecD046v0mKtg19EPug
 D3DeypXmJJKcWV6mMmmJ8f9jXrlDuB2mukt4b4xV09kQiw1D3A+Gy3A5Y0ud2nMyyBU4pwmo4
 b43IXV4Fmqt2jtVZbxu/oDgMo6bNmNl57KcGeueLEazhugZfhlU/rll3e/47WEGOmtnN8t1Ct
 YeZgG4dJG8EOJT8uGmGLl/2oP+8hzNSZUJu3/8qiMaaHzfLVqzDmUlaFGtt2Ay9orK0tuG+5T
 fe/HSCDCJZCBmUTi
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,


Am 29.05.2018 um 15:10 schrieb Ricardo Ribalda Delgado:
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
>   drivers/net/ethernet/qualcomm/qca_uart.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
> index db6068cd7a1f..bb7aed805083 100644
> --- a/drivers/net/ethernet/qualcomm/qca_uart.c
> +++ b/drivers/net/ethernet/qualcomm/qca_uart.c
> @@ -405,6 +405,12 @@ static void qca_uart_remove(struct serdev_device *serdev)
>   	free_netdev(qca->net_dev);
>   }
>   
> +static struct serdev_device_id qca_uart_serdev_id[] = {
> +	{ QCAUART_DRV_NAME, },

i guess the id must be stable, so in case someone changes the driver 
name this has unexpected side effects?

Apart from that i'm fine with this patch.

Thanks
Stefan

> +	{},
> +};
> +MODULE_DEVICE_TABLE(serdev, qca_uart_serdev_id);
> +
>   static struct serdev_device_driver qca_uart_driver = {
>   	.probe = qca_uart_probe,
>   	.remove = qca_uart_remove,
> @@ -412,6 +418,7 @@ static struct serdev_device_driver qca_uart_driver = {
>   		.name = QCAUART_DRV_NAME,
>   		.of_match_table = of_match_ptr(qca_uart_of_match),
>   	},
> +	.id_table = qca_uart_serdev_id,
>   };
>   
>   module_serdev_device_driver(qca_uart_driver);
