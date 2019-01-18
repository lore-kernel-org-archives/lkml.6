Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D592C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA1B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="RXYp9C+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dD30X1VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfARFN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:13:58 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60529 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfARFN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:13:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 203C9259AB;
        Fri, 18 Jan 2019 00:13:56 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute4.internal (MEProxy); Fri, 18 Jan 2019 00:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:subject:in-reply-to:date:references; s=fm1; bh=B/7
        CgNU5s94c/1EaCMbOA6ixXBS4qhF3PsyR2LzWL7U=; b=RXYp9C+JP0uTj8++2Jb
        4LKF4XSlvTbaEQv5YKVWnBb3omf7yyLCQ77YAb9MnaTIgev9OvA4cnpgkychacMY
        3t0bmkdmvrUEOmUMn7t8qxogxn+N5GSY3YMpfjSsbDVnxzcA1GhslF2lOwP4nrao
        nCf0bhlBio1N3H7AgEzn7xqSyGQmVlPnPqKmSIeXGxTE8sAa6FRHJQ3EGwD6ir/f
        u+YqUX4Tn0rAw1Q821ChyTgLvjDQprcwxdlEqRWTHjx+hi3IH0UtMyF4OdOrL72c
        ErXk2BFUvno7PbIF1v735K42KiFhfhxHRTWkCczqSVc/ViC3RPWAxYsO1FcncV6/
        b0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=B/7CgNU5s94c/1EaCMbOA6ixXBS4qhF3PsyR2LzWL
        7U=; b=dD30X1VT7T5ZAuVN0Tn16AbaFIdglCogLoTOOecOPEQfx1c++628p9Ota
        nG/4pTXkcOCW7g1HOF6LlW3ItiphvY5Vwbl/fW5FtnDasZWakK8nTPi6Ji7nTlqW
        5WiNudaGD/omXspAvh2BZUIIeBVE4U88U4DYIHT2/5C5h9hEwlXdrMViDbDRL/dL
        WEChh6FO1J6IBkmCMDJgSApeqIXqNELwe53ftVs6wPGvP3p0cBwMo/vL0Qra3AbG
        ebzA07bTkGd9ZvXtSz9nYMCAAuEFzBGOpNMe5LvUbkt48DYr8CF2iAYELNZzDWbX
        D8msEMekwHWjC3MGzehOzYMDVwbGg==
X-ME-Sender: <xms:k2BBXHkGVzJQL260bklIiKfXWg-EvPpLsptRckMK3lqRfzEp54W_sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgeelgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffhvfgggfgtof
    fujgfffhesthejredtredtjeenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceo
    rghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:k2BBXPFsjyVZ5P7AMBaVKleEO89bZMHupub_Nis--mKK7Y0ntK7m6g>
    <xmx:k2BBXIrVyAenT_Udlkfe3mzynKmp8JtZPGndmgyMvUqLzr4Hb4fdDg>
    <xmx:k2BBXD7xk1aEGteMZ4WCXMTYJtbG2OlVAz_x5uGefYNkkz7qJRs7ag>
    <xmx:lGBBXKXLjrfQlxyzi0UonxsoVzJ9A4OvZ9DanZWXvwTjdt7zbMBERA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id C148B429B; Fri, 18 Jan 2019 00:13:54 -0500 (EST)
Message-Id: <1547788434.2065387.1637728584.1098F843@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Stefan Schaeckeler <schaecsn@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org
Cc:     Stefan M Schaeckeler <sschaeck@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-36e4bfd3
Subject: Re: [PATCH v2 2/2] dt-bindings: edac: Aspeed AST2500
In-Reply-To: <1547743097-5236-3-git-send-email-schaecsn@gmx.net>
Date:   Fri, 18 Jan 2019 15:43:54 +1030
References: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
 <1547743097-5236-3-git-send-email-schaecsn@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, at 03:08, Stefan Schaeckeler wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for EDAC on the Aspeed AST2500 SoC.
> 
> Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  .../bindings/edac/aspeed-sdram-edac.txt       | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-
> edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> new file mode 100644
> index 000000000000..6a0f3d90d682
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> @@ -0,0 +1,25 @@
> +Aspeed AST2500 SoC EDAC node
> +
> +The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without 
> ECC (error
> +correction check).
> +
> +The memory controller supports SECDED (single bit error correction, 
> double bit
> +error detection) and single bit error auto scrubbing by reserving 8 
> bits for
> +every 64 bit word (effectively reducing available memory to 8/9).
> +
> +Note, the bootloader must configure ECC mode in the memory controller.
> +
> +
> +Required properties:
> +- compatible: should be "aspeed,ast2500-sdram-edac"
> +- reg:        sdram controller register set should be <0x1e6e0000 
> 0x174>
> +- interrupts: should be AVIC interrupt #0
> +
> +
> +Example:
> +
> +	edac: sdram@1e6e0000 {
> +		compatible = "aspeed,ast2500-sdram-edac";
> +		reg = <0x1e6e0000 0x174>;
> +		interrupts = <0>;
> +	};
> -- 
> 2.19.1
> 
