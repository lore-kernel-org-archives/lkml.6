Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeDPXSJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 19:18:09 -0400
Received: from hermes.aosc.io ([199.195.250.187]:53283 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751893AbeDPXSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 19:18:07 -0400
Date: Tue, 17 Apr 2018 07:17:56 +0800
In-Reply-To: <20180416184745.tqxyvojtcbage4fu@rob-hp-laptop>
References: <20180411141641.14675-1-icenowy@aosc.io> <20180411141641.14675-2-icenowy@aosc.io> <20180416184745.tqxyvojtcbage4fu@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/5] dt-bindings: allow dwmac-sun8i to use other devices' exported regmap
To: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
CC: devicetree@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <04C9F795-2680-4220-A39A-7B7D5FD74C4A@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年4月17日 GMT+08:00 上午2:47:45, Rob Herring <robh@kernel.org> 写到:
>On Wed, Apr 11, 2018 at 10:16:37PM +0800, Icenowy Zheng wrote:
>> On some Allwinner SoCs the EMAC clock register needed by dwmac-sun8i
>is
>> in another device's memory space. In this situation dwmac-sun8i can
>use
>> a regmap exported by the other device with only the EMAC clock
>register.
>
>If this is a clock, then why not use the clock binding?

EMAC clock register is only the datasheet name. It contains
MII mode selection and delay chain configuration.

>
>> 
>> Document this situation in the dwmac-sun8i device tree binding
>> documentation.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>> index 3d6d5fa0c4d5..0c5f63a80617 100644
>> --- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>> +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>> @@ -20,8 +20,9 @@ Required properties:
>>  - phy-handle: See ethernet.txt
>>  - #address-cells: shall be 1
>>  - #size-cells: shall be 0
>> -- syscon: A phandle to the syscon of the SoC with one of the
>following
>> - compatible string:
>> +- syscon: A phandle to a device which exports the EMAC clock
>register as a
>> + regmap or to the syscon of the SoC with one of the following
>compatible
>> + string:
>>    - allwinner,sun8i-h3-system-controller
>>    - allwinner,sun8i-v3s-system-controller
>>    - allwinner,sun50i-a64-system-controller
>> -- 
>> 2.15.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
