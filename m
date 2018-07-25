Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FF620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FF620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeGYQvd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:51:33 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36813 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbeGYQvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:51:33 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id E6F6F9F496;
        Wed, 25 Jul 2018 15:38:57 +0000 (UTC)
Date:   Wed, 25 Jul 2018 23:38:06 +0800
In-Reply-To: <20180725153126.GA8350@rob-hp-laptop>
References: <20180722055739.26464-1-icenowy@aosc.io> <20180722055739.26464-7-icenowy@aosc.io> <CAGb2v65m6AEW=DO-cqLMyjfnaiZudm38hXufJL6LXdOrJqir_g@mail.gmail.com> <20180725153126.GA8350@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH v3 6/9] dt-bindings: phy: add binding for Allwinner USB3 PHY
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>
CC:     devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <75A6FEBC-FDCE-459E-93C5-60F4B0E6D44D@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月25日 GMT+08:00 下午11:31:26, Rob Herring <robh@kernel.org> 写到:
>On Sun, Jul 22, 2018 at 02:10:33PM +0800, Chen-Yu Tsai wrote:
>> On Sun, Jul 22, 2018 at 1:57 PM, Icenowy Zheng <icenowy@aosc.io>
>wrote:
>> > The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
>> > external USB3 pins of the SoC.
>> >
>> > Add a device tree binding for the PHY.
>> >
>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> > ---
>> > Changes in v3:
>> > - Added Chen-Yu's Review tag.
>> >
>> > Rob,
>> > Although you mentioned that the supply is for the port, not the
>phy;
>> > currently in USB situation "powering on the PHY" also indicates
>> > "powering on the port" and nearly all usages of phy-supply is for
>Vbus.
>> >
>> > Maybe we should change the overall phy-supply to satisfy this.
>> 
>> Or maybe change it to vbus-supply, like we have for phy-sun4i-usb,
>> until USB port power sequencing is added. (I remember there were
>> patches for this. What happened?)
>
>Once it is in the binding, we are stuck with it.
>
>Connector bindings have landed. We should add vbus-supply to that. You 
>don't have to have a property in the node associated with a driver. The

How should the phy DT node reference the connector?

>
>phy driver can walk the tree and get the Vbus supply.
>
>UniPhier has the same issue.
>
>Rob
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
