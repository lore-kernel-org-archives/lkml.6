Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCADC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CFA20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CFA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeGaB3b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:29:31 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47777 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbeGaB3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:29:31 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 3CCED64D1A;
        Mon, 30 Jul 2018 23:51:51 +0000 (UTC)
Date:   Tue, 31 Jul 2018 07:51:17 +0800
In-Reply-To: <20180730231244.GA3966@rob-hp-laptop>
References: <20180726171257.6688-1-icenowy@aosc.io> <20180726171257.6688-9-icenowy@aosc.io> <20180730231244.GA3966@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3.1 08/10] dt-bindings: sun4i-drm: add HDMI VCC supply property for sun8i-dw-hdmi
To:     linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
CC:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <F275EA55-B791-4EDC-8796-DB79E95D7008@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月31日 GMT+08:00 上午7:12:44, Rob Herring <robh@kernel.org> 写到:
>On Fri, Jul 27, 2018 at 01:12:55AM +0800, Icenowy Zheng wrote:
>> Allwiner SoCs with DesignWare HDMI controller all come with a "HVCC"
>> pin, which is the VCC of HDMI part.
>> 
>> Add a supply property to specify HVCC's regulator in the device tree.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v3.1:
>> - New patch.
>> 
>>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3
>+++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git
>a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> index fdb8fb29033f..cb4769913e89 100644
>> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> @@ -97,6 +97,9 @@ Required properties:
>>      first port should be the input endpoint. The second should be
>the
>>      output, usually to an HDMI connector.
>>  
>> +Optional properties:
>> +  - hdmi-supply: the VCC power supply of the controller
>
>"hdmi" doesn't sound like the name of the supply. "hvcc" or just "vcc" 
>would be more appropriate.

Okay. In original versions it used to be "hvcc-supply", and
I will pick the name again.

>
>Rob
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
