Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FDEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8220855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="oG5OB19K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FhySyZFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfAREVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:21:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59705 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbfAREVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:21:15 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BE4521ADD;
        Thu, 17 Jan 2019 23:21:14 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute4.internal (MEProxy); Thu, 17 Jan 2019 23:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:references:date:in-reply-to:subject; s=fm1; bh=m9V
        EIlsPUJt00+Jb74/la9I69I7E0UJYRsCp2QNRtBo=; b=oG5OB19KjjwCkg9aVNs
        HVTm2eb8ZbNXU4ZpwzFkrQImrzjRLuj8LO1niVg5ZOy3PGpS7fwFJ+MIwUfXhPhB
        mOwGjugIIppOol35NU6zfUMNKCHOo9ZpYejCb56EoH1KFZReNnaxWKQNxhJTaZSz
        4wTjYaBcqGiCVOARPDi8pD9o4c7no9zgUONmgxryBjf6JbMvdCqj9pLi6sumDV3x
        IQsVf7IrNX5AKSpZSBd/RwC3niykkatbdvZr7wbxMnaxItdYMYGeQX/tVG/HEVRw
        LQ0F9W/pt+y44ykjlaBZ8TSmEY1XnHWFr6FiykpmVXv8WuGoluiQoqMdzKUDrXn3
        avQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=m9VEIlsPUJt00+Jb74/la9I69I7E0UJYRsCp2QNRt
        Bo=; b=FhySyZFw7t7GqpTwHw/DQ5vvJjjtU/tbtSVi9YVZ/og6ELh3be+DjJM6B
        gxmaIP7yOgvvPx/1azZ5eQqKnwZQchefPWhjftWCrsxwjg5yElEUg/0WhhbWKtKp
        S8oTNnRxn64TWJkXGo8EOU1YrUHBk66s5QgssB3mGVEpdg3pyQ2w2i+084on5XFc
        Ir8mp52MNWv/RizXLF2urdyDmiPiV9Pq2yLS8VAosN+Ci2x+SlUoe08rEeeyUUNf
        4QjXn56qY72h/+ZL/QZkqb8eWVdaeX8/xqf7O9ekS/BdZQh43h7MHK78mLvPM3Vl
        tUSJPj16pT8P+yresBRLmbHv+bu8A==
X-ME-Sender: <xms:OVRBXMDcb3mdRnHaga1R2g4qANad2gTgMIg2ETVVgIYH74dN1t44YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgeelgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffhvfgggfgtof
    hfffgjufesthejredtredtjeenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceo
    rghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:OVRBXK1qoPczqoQGfrGNuKZWw7T_yJOWQKSm4jOlnk2n4QcxCg8lAQ>
    <xmx:OVRBXCXjn_vaA3S3yaqtftWEInbWegOglRUHMp58Dzkx7Rr9l6CPjQ>
    <xmx:OVRBXEmU1h3z0pRYDZmCqcg7ZRjUSJLe0WstK7C8no9wTslOeBjyQA>
    <xmx:OlRBXK-xS45LkojaaSuib_yZKftL2sz9PB6xtTV1DAoTT3TjjEh-lg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id BC8FD429B; Thu, 17 Jan 2019 23:21:12 -0500 (EST)
Message-Id: <1547785272.2051152.1637704704.1926B2B5@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-36e4bfd3
References: <20190117190830.824013-1-vijaykhemka@fb.com>
Date:   Fri, 18 Jan 2019 14:51:12 +1030
In-Reply-To: <20190117190830.824013-1-vijaykhemka@fb.com>
Subject: Re: [PATCH] dt-bindings: aspeed-lpc: Make parameter optional
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On Fri, 18 Jan 2019, at 05:38, Vijay Khemka wrote:
> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/
> Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 34dd89087cff..ff0cb28903dd 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -135,6 +135,10 @@ Required properties:
>  - clocks:	contains a phandle to the syscon node describing the clocks.
>  		There should then be one cell representing the clock to use
>  
> +Optional properties:
> +These below properties are optional and required only if one need to use it
> +through ioctl.

I'd just say "Optional properties". Leave the description off, as we probably
shouldn't be talking about ioctls and such in the bindings.

Andrew

> +
>  - memory-region: A phandle to a reserved_memory region to be used for the LPC
>  		to AHB mapping
>  
> -- 
> 2.17.1
> 
