Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C9920870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ixvRTK7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckyVHmX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C9920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeGPDQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 23:16:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49311 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbeGPDQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 23:16:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 132F721B82;
        Sun, 15 Jul 2018 22:50:54 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute4.internal (MEProxy); Sun, 15 Jul 2018 22:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Zzl7/sHSNh+IyPQWupkGHIFiP4/yf
        QZ+hKPwMIwSg88=; b=ixvRTK7hFWNCX7jVankQK53KlBrEZnr287ulbWGM1D6ZZ
        YxMF4Jk5eAKNJMSycMbwTue3rkA5R6Ujyz+oOva+APfWDqdcxGVuuKejiWEL8M8z
        WTInibBGM+RrJWa5ndKFyL8B4lz3jhtlwrVS1Fb47vdpwj0nitn0NjJc2teWZmn2
        D1vgWULf+njJw8HZwu4rGVPhn4jOjE6DE2DgNnqO2emIRafQBXEnz0hbBYvHp8GX
        TnZ8E3H7apixX1Aryd7Lxsp8OY/+RXvzEFu0AEFHZZs0IN8/hDxTeIxolZnJ2XjF
        UDpsTaDvQya/BMyp5DLPnZzpySF+10URhElBjzSLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Zzl7/s
        HSNh+IyPQWupkGHIFiP4/yfQZ+hKPwMIwSg88=; b=ckyVHmX03SmfMlOVkWqmh1
        +Tq5AQKi3H+2jlzV+Ebk8rgN+TcFqu0wQDFJo8BusC298LRgPmiFV2SmzJL51DBL
        cw/kidPbk9yig6uN4+Lw30iMmJwFjeU4gqwGtpWFVAjF/wj/z7qv843Vfy/xztOa
        gcBV25GpO2pzq7HkqVD59BpLkqrLo5d3dv0jXnWzHQPTQnb/bOTctj22dJQgqH8A
        dhhBe+m0l8JzZayIqgyQqfSvhin7c3wTuaRNaAeXkiMaJRODhjNT6aXZo+HEFbWI
        WBNOy3vsFedMPefNV6I9lTk82Zhl+IpFlpvn4E4uTJYAOyWS+CMMvZ5dzuPb3IEg
        ==
X-ME-Proxy: <xmx:DQhMW8KXNZBIEY-RocbjG3bfc-EcDbfB4vpknJo9gY16tiVvGT-y-A>
    <xmx:DQhMW0Gg-LNHyH1lTG_bHtaReW1QakHa9QBuDlY_NvrHtCGqsB7UDg>
    <xmx:DQhMWz6raDA0EZlhI6cYnnsGKXmPat9w_yVVsAx_uRohBkYGBVm6vQ>
    <xmx:DQhMW_36dVxfLUKYMVSTJ6UGuuRtq8Xg4gze7jJyuSAyxfzwLqLgZg>
    <xmx:DQhMW_h95tb9tnaueVSpPRt0-_yIz3IQ3gyZ9AL6pScGmrd3yjxEtg>
    <xmx:DghMW6T9I9TgaUNw-c514H_8hcyWH4vupebE5MEnc5kCmPghTYzr6Q>
X-ME-Sender: <xms:DQhMWyHsFBiEc-FEkxcug-ogyHj-skjQR-iDsrG6gP3kT58bDUyTkw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id F016B9E0F5; Sun, 15 Jul 2018 22:50:52 -0400 (EDT)
Message-Id: <1531709452.1037890.1441737864.7E216D02@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Rob Herring <robh@kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Cc:     mark.rutland@arm.com, arnd@arnd.de, gregkh@linuxfoundation.org,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-957169fa
In-Reply-To: <20180711202107.GA29980@rob-hp-laptop>
Subject: Re: [PATCH v1 1/2] dt-binding: bmc: Add NPCM7xx LPC BPC documentation
Date:   Mon, 16 Jul 2018 12:20:52 +0930
References: <20180704091427.409971-1-tmaimon77@gmail.com>
 <20180704091427.409971-2-tmaimon77@gmail.com>
 <20180711202107.GA29980@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018, at 05:51, Rob Herring wrote:
> On Wed, Jul 04, 2018 at 12:14:26PM +0300, Tomer Maimon wrote:
> > Added device tree binding documentation for Nuvoton BMC
> > NPCM7xx BIOS Post Code (BPC).
> > The NPCM7xx BPC monitoring two configurable I/O addresses
> > written by the host on Low Pin Count (LPC) bus.
> > 
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt    | 26 ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt b/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
> > new file mode 100644
> > index 000000000000..0832c9cbea32
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
> > @@ -0,0 +1,26 @@
> > +Nuvoton NPCM7xx LPC BPC interface
> > +
> > +Nuvoton BMC NPCM7xx BIOS Post Code (BPC) monitoring two
> > +configurable I/O addresses written by the host on the
> > +Low Pin Count (LPC) bus, the capure data stored in 128-word FIFO.
> 
> s/capure/capture/
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

So uncovering a bit of a dirty secret here, we should probably consider this in the context of the ASPEED snoop function. A driver snuck into the misc tree without an associated bindings document:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/aspeed-lpc-snoop.c

(it wasn't me, I'm happy to discuss my proposed bindings, please don't shoot the messenger :))

The devicetree node looks something like:

					lpc_snoop: lpc-snoop@0 {
						compatible = "aspeed,ast2500-lpc-snoop";
						reg = <0x0 0x80>;
						interrupts = <8>;
						status = "disabled";
					};

and also has a required "snoop-ports" property with at least one and up to two cells that describe the channels to snoop. Channel values are either 0 or 1. It's feasible that the double-word capture could also be supported as both supported channels have their data captured in different fields of the same register.

Do we go with what's already in the tree in supporting 'snoop-ports' or keep 'monitor-ports' as proposed by Tomer?

Andrew

> 
> 
> > +
> > +NPCM7xx BPC supports capture double words, when using capture
> > +double word only I/O address 1 is monitored.
> > +
> > +Required properties for lpc_bpc node
> > +- compatible	: "nuvoton,npcm750-lpc-bpc" for Poleg NPCM7XX.
> > +- reg 			: specifies physical base address and size of the registers.
> > +- interrupts	: contain the LPC BPC with flags for falling edge.
> > +- monitor-ports : contain monitor I/O addresses, at least one monitor I/O
> > +				  address required
> > +
> > +Optional property for lpc_bpc node
> > +- bpc-en-dwcapture : enable capture double words support.
> > +
> > +Example:
> > +	lpc_bpc: lpc-bpc@f0007040 {
> > +		compatible = "nuvoton,npcm7xx-lpc-bpc";
> > +		reg = <0xf0007040 0x14>;
> > +		monitor-ports = <0x80>;
> > +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > -- 
> > 2.14.1
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
