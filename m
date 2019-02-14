Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B846C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB9521928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfBNXPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:15:23 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.5]:23360 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728747AbfBNXPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:15:22 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 5E0B721260
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 17:15:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uQDxg8GER2qH7uQDxgfyuV; Thu, 14 Feb 2019 17:15:21 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=48102 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1guQCk-001i4x-Go; Thu, 14 Feb 2019 17:15:20 -0600
Subject: Re: [PATCH] can: mark expected switch fall-throughs
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de,
        davem@davemloft.net, Ludovic.Desroches@microchip.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
 <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
 <20190214230756.GR10129@piout.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
Date:   Thu, 14 Feb 2019 17:14:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214230756.GR10129@piout.net>
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
X-Exim-ID: 1guQCk-001i4x-Go
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:48102
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/19 5:07 PM, Alexandre Belloni wrote:
> On 14/02/2019 17:04:03-0600, Gustavo A. R. Silva wrote:
>>
>>
>> On 2/14/19 4:17 PM, Alexandre Belloni wrote:
>>> Hi,
>>>
>>> On 14/02/2019 15:37:26-0600, Gustavo A. R. Silva wrote:
>>>>
>>>>
>>>> On 1/30/19 2:11 AM, Nicolas.Ferre@microchip.com wrote:
>>>>> On 29/01/2019 at 19:06, Gustavo A. R. Silva wrote:
>>>>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>>>>> where we are expecting to fall through.
>>>>>>
>>>>>> This patch fixes the following warnings:
>>>>>>
>>>>>> drivers/net/can/peak_canfd/peak_pciefd_main.c:668:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>>> drivers/net/can/spi/mcp251x.c:875:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>>> drivers/net/can/at91_can.c:895:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>>> drivers/net/can/at91_can.c:953:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>>> drivers/net/can/usb/peak_usb/pcan_usb.c: In function ‘pcan_usb_decode_error’:
>>>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>>>     if (n & PCAN_USB_ERROR_BUS_LIGHT) {
>>>>>>        ^
>>>>>> drivers/net/can/usb/peak_usb/pcan_usb.c:428:2: note: here
>>>>>>    case CAN_STATE_ERROR_WARNING:
>>>>>>    ^~~~
>>>>>>
>>>>>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>>>>>
>>>>>> This patch is part of the ongoing efforts to enabling
>>>>>> -Wimplicit-fallthrough.
>>>>>>
>>>>>> Notice that in some cases spelling mistakes were fixed.
>>>>>> In other cases, the /* fall through */ comment is placed
>>>>>> at the bottom of the case statement, which is what GCC
>>>>>> is expecting to find.
>>>>>>
>>>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>>> ---
>>>>>>   drivers/net/can/at91_can.c                    | 6 ++++--
>>>>>
>>>>> For this one:
>>>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>>
>>>>
>>>> Thanks, Nicolas.
>>>>
>>>
>>> I though I had a déjà vu but you actually sent the at91 part twice.
>>>
>>
>> It wasn't intentional.
>>
>>>> Dave:
>>>>
>>>> I wonder if you can take this patch.
>>>>
>>>> Thanks
>>>> --
>>>> Gustavo
>>>>
>>>>>>   drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 +-
>>>>>>   drivers/net/can/spi/mcp251x.c                 | 3 ++-
>>>>>>   drivers/net/can/usb/peak_usb/pcan_usb.c       | 2 +-
>>>>>>   4 files changed, 8 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>>>>>> index d98c69045b17..1718c20f9c99 100644
>>>>>> --- a/drivers/net/can/at91_can.c
>>>>>> +++ b/drivers/net/can/at91_can.c
>>>>>> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>>>>>   				CAN_ERR_CRTL_TX_WARNING :
>>>>>>   				CAN_ERR_CRTL_RX_WARNING;
>>>>>>   		}
>>>>>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>>>>>> +		/* fall through */
>>>>>> +	case CAN_STATE_ERROR_WARNING:
>>>>>>   		/*
>>>>>>   		 * from: ERROR_ACTIVE, ERROR_WARNING
>>>>>>   		 * to  : ERROR_PASSIVE, BUS_OFF
>>>>>> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>>>>>   		netdev_dbg(dev, "Error Active\n");
>>>>>>   		cf->can_id |= CAN_ERR_PROT;
>>>>>>   		cf->data[2] = CAN_ERR_PROT_ACTIVE;
>>>>>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>>>
>>> Seriously, for that one, you should fix the compiler. The fall through
>>
>> I'll pass your feedback on to the GCC guys.
>>
>>> is not implicit, it is actually quite explicit and the warning is simply
>>> wrong.
>>>
>>> Also, the gcc documentation says that -Wimplicit-fallthrough=3
>>> recognizes /* fallthrough */ as a proper fall through comment (and I
>>> tested with gcc 8.2).
>>>
>>
>> Yeah. But that's not the relevant change in this case.  Notice that the
>> comment was moved to the very bottom of the previous case.
>>
> 
> Yes and it doesn't matter for gcc, I tested with gcc 8.2.
> 

Yeah. But, again, you are missing the relevant part of the patch.

--
Gustavo
