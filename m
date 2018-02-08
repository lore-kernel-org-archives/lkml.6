Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeBHVxF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:53:05 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:54096 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBHVxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:53:03 -0500
X-Auth-Info: WnoivQky53usfjDs8rxL7JSMQCNkuoeOI1RjffCpOqE=
Subject: Re: [PATCH v2 1/2] net, can, ifi: fix "write buffer full" error
To: Marc Kleine-Budde <mkl@pengutronix.de>, Heiko Schocher <hs@denx.de>,
        linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>
References: <20180208064748.17985-1-hs@denx.de>
 <59322f7d-4207-a5a4-89b5-dff1634e4183@pengutronix.de>
 <dfae1bda-9ccd-6a48-95f9-e061c1bd3828@denx.de>
 <ca1b9134-1e5a-ea83-146f-693ba38be413@pengutronix.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <c4d4f09b-42c2-90b3-65b2-4b493262c649@denx.de>
Date: Thu, 8 Feb 2018 22:44:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ca1b9134-1e5a-ea83-146f-693ba38be413@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 10:33 PM, Marc Kleine-Budde wrote:
> On 02/08/2018 08:22 PM, Marek Vasut wrote:
>> On 02/08/2018 03:46 PM, Marc Kleine-Budde wrote:
>>> On 02/08/2018 07:47 AM, Heiko Schocher wrote:
>>>> the driver reads in the ISR first the IRQpending register,
>>>> and clears after that in a write *all* bits in it.
>>>>
>>>> It could happen that the isr register raise bits between
>>>> this 2 register accesses, which leads in lost bits ...
>>>>
>>>> In case it clears "TX message sent successfully", the driver
>>>> never sends any Tx data, and buffers to userspace run over.
>>>>
>>>> Fixed this:
>>>> clear only the bits in the IRQpending register, the
>>>> driver had read.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>>
>>> Applied both to linux-can.
>>
>> Can you also apply them to stable, so they get into 4.9.x etc ?
> 
> I've already added stable on Cc, so they will be picked up by the stable
> maintainers.

Thanks!

-- 
Best regards,
Marek Vasut
