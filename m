Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB152C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989822085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfAUSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:06:41 -0500
Received: from mx1.emlix.com ([46.4.235.150]:55386 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfAUSGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:06:41 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id BDEA525F0C1;
        Mon, 21 Jan 2019 19:00:39 +0100 (CET)
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: ci-hdrc-usb2: add property
 power-active-high
To:     Peter Chen <peter.chen@nxp.com>,
        Philipp Puschmann <philipp.puschmann@emlix.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190116105103.28842-2-philipp.puschmann@emlix.com>
 <20190116111133.31326-1-philipp.puschmann@emlix.com>
 <VI1PR04MB5327656AD22454B054CE0AD08B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
From:   Philipp Puschmann <pp@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <7d0da12b-0173-aca1-b0eb-78a00681d35d@emlix.com>
Date:   Mon, 21 Jan 2019 19:00:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5327656AD22454B054CE0AD08B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Am 17.01.19 um 08:01 schrieb Peter Chen:
>  
>>
>> The i.MX6q/dl USB controller may drive the usb power line directly, but the polarity
>> depends on the board. Reset state of the polarity is low-active so add this property
>> to allow it to be high-active.
>>
> 
> As far as I know, most of i.mx USB controllers (except imx28/23, but they don't have non-core registers)
> work like this, and most of them are low active for PP default. Would you just use "i.mx" at
> both your code and your comment?

Am i right that i have to add my code block to (nearly) all other version specific init functions then?
Will do so in next days and then send a v4 of this patch.
> 
> Peter
> 
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>> ---
>> Changes in v3: add description
>> ---
>>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>> b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>> index adae82385dd6..8696e3eff6e7 100644
>> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>> @@ -93,6 +93,7 @@ i.mx specific properties
>>  - over-current-active-low: over current signal polarity is active low.
>>  - over-current-active-high: over current signal polarity is active high.
>>    It's recommended to specify the over current polarity.
>> +- power-active-high: power signal polarity is high active (only for
>> +imx6q/dl)
>>  - external-vbus-divider: enables off-chip resistor divider for Vbus
>>
>>  Example:
>> --
>> 2.20.1
> 
