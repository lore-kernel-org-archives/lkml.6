Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A42BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB702147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503320AbfBNVhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:37:31 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.144]:30960 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440305AbfBNVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:37:30 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id C4AA412B79
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:37:28 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uOhEg5ENj90onuOhEgSEBR; Thu, 14 Feb 2019 15:37:28 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=41338 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1guOhE-000wD0-6l; Thu, 14 Feb 2019 15:37:28 -0600
Subject: Re: [PATCH] can: mark expected switch fall-throughs
To:     Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de,
        davem@davemloft.net, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
Date:   Thu, 14 Feb 2019 15:37:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1guOhE-000wD0-6l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:41338
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/19 2:11 AM, Nicolas.Ferre@microchip.com wrote:
> On 29/01/2019 at 19:06, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> This patch fixes the following warnings:
>>
>> drivers/net/can/peak_canfd/peak_pciefd_main.c:668:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/spi/mcp251x.c:875:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/at91_can.c:895:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/at91_can.c:953:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/can/usb/peak_usb/pcan_usb.c: In function ‘pcan_usb_decode_error’:
>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     if (n & PCAN_USB_ERROR_BUS_LIGHT) {
>>        ^
>> drivers/net/can/usb/peak_usb/pcan_usb.c:428:2: note: here
>>    case CAN_STATE_ERROR_WARNING:
>>    ^~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Notice that in some cases spelling mistakes were fixed.
>> In other cases, the /* fall through */ comment is placed
>> at the bottom of the case statement, which is what GCC
>> is expecting to find.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/net/can/at91_can.c                    | 6 ++++--
> 
> For this one:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 

Thanks, Nicolas.

Dave:

I wonder if you can take this patch.

Thanks
--
Gustavo

>>   drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 +-
>>   drivers/net/can/spi/mcp251x.c                 | 3 ++-
>>   drivers/net/can/usb/peak_usb/pcan_usb.c       | 2 +-
>>   4 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>> index d98c69045b17..1718c20f9c99 100644
>> --- a/drivers/net/can/at91_can.c
>> +++ b/drivers/net/can/at91_can.c
>> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>   				CAN_ERR_CRTL_TX_WARNING :
>>   				CAN_ERR_CRTL_RX_WARNING;
>>   		}
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
>> +	case CAN_STATE_ERROR_WARNING:
>>   		/*
>>   		 * from: ERROR_ACTIVE, ERROR_WARNING
>>   		 * to  : ERROR_PASSIVE, BUS_OFF
>> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>   		netdev_dbg(dev, "Error Active\n");
>>   		cf->can_id |= CAN_ERR_PROT;
>>   		cf->data[2] = CAN_ERR_PROT_ACTIVE;
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
>> +	case CAN_STATE_ERROR_WARNING:
>>   		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>>   		reg_ier = AT91_IRQ_ERRP;
>>   		break;
>> diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
>> index c458d5fdc8d3..e4f4d65a76b4 100644
>> --- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
>> +++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
>> @@ -668,7 +668,7 @@ static int pciefd_can_probe(struct pciefd_board *pciefd)
>>   		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
>>   				    PCIEFD_REG_CAN_CLK_SEL);
>>   
>> -		/* fallthough */
>> +		/* fall through */
>>   	case CANFD_CLK_SEL_80MHZ:
>>   		priv->ucan.can.clock.freq = 80 * 1000 * 1000;
>>   		break;
>> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
>> index e90817608645..17257c73c302 100644
>> --- a/drivers/net/can/spi/mcp251x.c
>> +++ b/drivers/net/can/spi/mcp251x.c
>> @@ -875,7 +875,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
>>   			if (new_state >= CAN_STATE_ERROR_WARNING &&
>>   			    new_state <= CAN_STATE_BUS_OFF)
>>   				priv->can.can_stats.error_warning++;
>> -		case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +			/* fall through */
>> +		case CAN_STATE_ERROR_WARNING:
>>   			if (new_state >= CAN_STATE_ERROR_PASSIVE &&
>>   			    new_state <= CAN_STATE_BUS_OFF)
>>   				priv->can.can_stats.error_passive++;
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
>> index 13238a72a338..eca785532b6b 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
>> @@ -423,7 +423,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
>>   			new_state = CAN_STATE_ERROR_WARNING;
>>   			break;
>>   		}
>> -		/* else: fall through */
>> +		/* fall through */
>>   
>>   	case CAN_STATE_ERROR_WARNING:
>>   		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
>>
> 
> 
