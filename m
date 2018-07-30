Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D12C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C6320881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C6320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbeGaAuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:50:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50508 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731961AbeGaAuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:50:02 -0400
Received: by mail-it0-f67.google.com with SMTP id g191-v6so1729701ita.0;
        Mon, 30 Jul 2018 16:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KaUVMhlYIymPlGhi3Hdm/eBqvRL1P7SqjO1oX5VGL/0=;
        b=nFo/XxqBj8zqOLSQmZ3TU9zNeanxeed4EuJXD8fn6d0xJaiFsAciiL38jVTmzFlM2J
         SpOw7ktyr9Cbyfhb/D5jYhLG5S09KjBsGjOzjgia6eBS75ymdbveUmMysvYm872Ac3Ln
         AwB/vfCeP0CdULpIvm/9NzlbkM2Xw1k+B8MM1j/zqDtN9tHLmCobJwAboRXgauf0NOXQ
         l8GTU5tDqeVpOMflJfCkVJWXLlXd1SXuXYmWy/m1tuhXSRHrKtkz5pecGZw9GPY2DMLd
         e1Tws/qoyu2s9Did2A39gAcshFLGUXLiNSqX7YFiheqLilx81JojAk5pzyXOfFRsLwH9
         sJUA==
X-Gm-Message-State: AOUpUlEdsF4F22GCjKmZjr5QoAUw1enR47OtnBmDv4qPJ1G9QZIe692z
        X3Ak4EUwkodrv3lFyCNLzQ==
X-Google-Smtp-Source: AAOMgpdF11TdC84n5IPWE0DLKRFlUDhhkQzeuQ/tQFdXe/BAE/bivyPRCplqR2DIUYd81n2XOkY9gQ==
X-Received: by 2002:a24:d104:: with SMTP id w4-v6mr1038436itg.29.1532992365901;
        Mon, 30 Jul 2018 16:12:45 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id g23-v6sm3697637iob.88.2018.07.30.16.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:12:45 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:12:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3.1 08/10] dt-bindings: sun4i-drm: add HDMI VCC supply
 property for sun8i-dw-hdmi
Message-ID: <20180730231244.GA3966@rob-hp-laptop>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-9-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726171257.6688-9-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:12:55AM +0800, Icenowy Zheng wrote:
> Allwiner SoCs with DesignWare HDMI controller all come with a "HVCC"
> pin, which is the VCC of HDMI part.
> 
> Add a supply property to specify HVCC's regulator in the device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3.1:
> - New patch.
> 
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index fdb8fb29033f..cb4769913e89 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -97,6 +97,9 @@ Required properties:
>      first port should be the input endpoint. The second should be the
>      output, usually to an HDMI connector.
>  
> +Optional properties:
> +  - hdmi-supply: the VCC power supply of the controller

"hdmi" doesn't sound like the name of the supply. "hvcc" or just "vcc" 
would be more appropriate.

Rob
