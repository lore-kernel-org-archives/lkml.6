Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934632AbeB1Rwa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:52:30 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36599 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934203AbeB1RwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:52:07 -0500
X-ME-Sender: <xms:RuyWWoQ_vaeHfeMs7KFMHnIOPFp9AcnnYwMVecUzhiJ00yM-tWeN9w>
Subject: Re: [PATCH 1/3] dt-bindings: Add a binding for the sunxi message box
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-2-samuel@sholland.org>
 <20180228082843.fga47gfrv2g5kmiz@flea>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <ce95b875-8503-17e8-06ef-86e4b4b434e5@sholland.org>
Date: Wed, 28 Feb 2018 11:52:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180228082843.fga47gfrv2g5kmiz@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/28/18 02:28, Maxime Ripard wrote:
> On Tue, Feb 27, 2018 at 08:27:12PM -0600, Samuel Holland wrote:
>> This mailbox hardware is present in several Allwinner sun8i and sun50i
>> SoCs. Add a device tree binding for it.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  .../devicetree/bindings/mailbox/sunxi-msgbox.txt   | 40 ++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
>> new file mode 100644
>> index 000000000000..3b3ed7f870a0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
>> @@ -0,0 +1,40 @@
>> +Allwinner sunxi Message Box
>> +===========================
>> +
>> +The hardware message box on sunxi SoCs is a two-user mailbox controller
>> +containing 8 unidirectional FIFOs bonded into 4 bidirectional mailbox channels.
>> +An interrupt is raised for received messages, but software must poll to know
>> +when a transmitted message has been acknowledged by the remote user.
>> +
>> +Refer to ./mailbox.txt for generic information about mailbox device-tree
>> +bindings.
>> +
>> +Mailbox Device Node:
>> +====================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible:		Must be "allwinner,sunxi-msgbox".
> 
> The IP change quite often in the Allwinner SoCs, so it would be better
> to use a more specific compatible there. IIRC that IP was introduced
> with the A31, so what about sun6i-a31-msgbox?

Ok, I will do this for v2, following Andre's suggestion. (I knew the AR100 was
introduced with the A31, but I couldn't find any reference to the msgbox in the
A31 manual).

>> +- reg:			Contains the mailbox register address range (base
>> +			address and length).
>> +- clocks:		phandle for the clock controller and specifier.
>> +- clock-names:		Must be "bus".
>> +- resets:		phandle for the reset controller and specifier.
>> +- reset-names:		Must be "bus".
>> +- interrupts:		Contains interrupt information for the mailbox.
>> +- #mbox-cells		Must be 2 - the indexes of the transmit and receive
>> +			channels, respectively.
> 
> That would prevent any unidirectional communication, wouldn't it?
> Other mailboxes driver seem to have two mbox channels, one for each
> direction, which also seem to mimic our DMA bindings (where we are in
> pretty much the same situation).

I've responded to Jassi's comment about the same issue on patch 3.

> Thanks!
> Maxime

Regards,
Samuel
