Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeCMJSd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:18:33 -0400
Received: from h1.radempa.de ([176.9.142.194]:60139 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbeCMJSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:18:32 -0400
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCH 3/5] arm64: dts: allwinner: a64: add simplefb for A64 SoC
In-reply-to: <20180313082724.7optc2xwgqoiibtx@flea>
References: <20180312161050.7647-1-harald@ccbib.org> <20180312161050.7647-4-harald@ccbib.org> <20180313082724.7optc2xwgqoiibtx@flea>
Comments: In-reply-to Maxime Ripard <maxime.ripard@bootlin.com>
   message dated "Tue, 13 Mar 2018 09:27:24 +0100."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1655.1520932701.1@stardust.g4.wien.funkfeuer.at>
Date: Tue, 13 Mar 2018 10:18:22 +0100
Message-Id: <E1evg4e-0000Qj-2w@stardust.g4.wien.funkfeuer.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard writes:
> On Mon, Mar 12, 2018 at 04:10:48PM +0000, Harald Geyer wrote:
>> The A64 SoC features two display pipelines, one has a LCD output, the
>> other has a HDMI output.
>>
>> Add support for simplefb for the LCD output. Tested on Teres I.
>>
>> This patch was inspired by work of Icenowy Zheng.
>>
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>> ---
>> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 ++++++++++++++++++++
>> 1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index ca1b365bc722..05d5e8def68a 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -52,6 +52,26 @@
>> 	#address-cells = <1>;
>> 	#size-cells = <1>;
>>
>> +	chosen {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +/*
>> + * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
>> + * However there is no support for this clock on A64 yet, so we depend
>> + * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
>> + */
> 
> There's definitely support for the CLK_MIXER0 clock in the DE2 CCU
> driver, so I guess this would need to be amended / fixed

AFAIK on the A64 a special sram quirk is necessary, that never got merged:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1574303.html

I asked Icenowy if I should resubmit her patch as part of this series,
but was told further discussion is necessary. I'm sure she can better
explain the details than me.

Actually if it wasn't for the sram quirk, there is a simplefb patch by
her, that could have been merged long ago:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1574304.html

Hope that explains,
Harald

> -- Maxime Ripard, Bootlin (formerly Free Electrons) Embedded Linux and
> Kernel engineering https://bootlin.com
> 
>>> application/pgp-signature attachment

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
