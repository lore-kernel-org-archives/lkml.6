Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D65C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7D225566
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7D225566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeFYHwg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:52:36 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40243 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbeFYHwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:52:34 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 5DCCB5DAFA;
        Mon, 25 Jun 2018 07:52:27 +0000 (UTC)
Date:   Mon, 25 Jun 2018 15:47:18 +0800
In-Reply-To: <5B309D37.80207@broadcom.com>
References: <20180315162510.11669-1-harald@ccbib.org> <20180315162510.11669-6-harald@ccbib.org> <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io> <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at> <5B309D37.80207@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I laptop
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Harald Geyer <harald@ccbib.org>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>, info@olimex.com,
        linux-wireless@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <1CF519CD-D44E-4959-8951-27CE710E0984@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年6月25日 GMT+08:00 下午3:43:51, Arend van Spriel <arend.vanspriel@broadcom.com> 写到:
>On 6/24/2018 6:34 PM, Harald Geyer wrote:
>> Icenowy Zheng writes:
>>> >在 2018-03-15四的 16:25 +0000，Harald Geyer写道：
>>>> > >+&mmc1 {
>>>> > >+	pinctrl-names = "default";
>>>> > >+	pinctrl-0 = <&mmc1_pins>;
>>>> > >+	vmmc-supply = <&reg_aldo2>;
>>>> > >+	vqmmc-supply = <&reg_dldo4>;
>>>> > >+	mmc-pwrseq = <&wifi_pwrseq>;
>>>> > >+	bus-width = <4>;
>>>> > >+	non-removable;
>>>> > >+	status = "okay";
>>>> > >+
>>>> > >+	rtl8723bs: wifi@1 {
>>>> > >+		reg = <1>;
>>>> > >+		interrupt-parent = <&r_pio>;
>>>> > >+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
>>>> > >+		interrupt-names = "host-wake";
>>>> > >+	};
>
>[...]
>
>>> >- This device node has no binding. The "host-wake" interrupt is
>part of
>>> >  Broadcom SDIO Wi-Fi binding, rather than a generic one.
>> I think the general mmc and interrupts bindings apply. And the mmc
>binding
>> clearly states that for sub-nodes a compatible string is optional.
>>
>> However I just realized that the 'interrupt-names' property is not
>part
>> of the general interrupts binding, so I guess at least this property
>should
>> be removed.
>
>Indeed. If the device just used the SDIO interrupt this is not needed. 
>The Broadcom device can use either SDIO interrupt or a so-called 
>out-of-band host-wake interrupt, which is what the above represents.

RTL8....S is also capable of use OOB interrupt.

>
>Regards,
>Arend
