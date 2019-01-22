Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445E2C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067A820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548119418;
	bh=P4yJSZ7rgCW8FU6rGnqvtasw/vsGCR1d/x32BI+NPgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WtOgcJpJWOU3JzsabwdWdmp4cLGr5K2Xru5iO2Q9lxBUetWz1JcyAc1gi1n6jPlOl
	 +0pepQpp5Njxrt363whNHolZkmAJUoWAJ65c5ZDLh/rF2lXabpQKoN+6NCGl68TCl1
	 T+zRk1boXKqD+3kEgI6mKORHiTSjFqshOgZEuR7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfAVBKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:10:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45509 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAVBKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:10:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id y1so16042793oie.12;
        Mon, 21 Jan 2019 17:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TQvnxtgbnj8D4bzHvlMfTgl05BtygG41c+UHljen430=;
        b=tI9bSZqiYTS0M5DXTv7A8lKRItLQKO3qy0wTJdMu47geTGp17jnWpZmcyVD8ju6/Kv
         l//uxZGZo4r0lKHNSO2jWXUTMpq8mAnLkf9H8ETArehRHX9xzHURMWIfxY0vHXWHn11X
         QfpPDF+/p5FX3A1HpDMD9S4ekw2XpoihriJplw9jT93b9SDAGvsCHEVsC+P8sQbMc/kV
         2ZD09Z9ay4r0htPl6LAMgnpGU/nbQ3CMJ+jAgqCND05JK1AaxAHHRolH+CGCCH0Ijz+Q
         GVsgRDcnXe/dmjx29ZhQ9joMGJaZUkA9KAFVPNjWyoVJ4mp3NlS0VSQjUx8g5TChjwg5
         GIHA==
X-Gm-Message-State: AJcUukdSsUwNG9oUdI4egkG6uga1w/+vllNCIiUSjVgZ3Ahahbzbjrnk
        hkGmJ08SNzcoLcjGGnI8Pw==
X-Google-Smtp-Source: ALg8bN47kY7j+oz6B7SATJ6Zmbg2S5peA7VBanTyTT4sO/mRSaVKdyC6Peo2GJ97TfMIe+H37tbrnA==
X-Received: by 2002:aca:3b83:: with SMTP id i125mr7256699oia.53.1548119415253;
        Mon, 21 Jan 2019 17:10:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm6505910otr.30.2019.01.21.17.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:10:14 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:10:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation
 for sama5d3 10/100 interface
Message-ID: <20190122011014.GA25211@bogus>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:57:40AM +0100, Nicolas Ferre wrote:
> This removes a line left while adding the correct compatibility string for
> sama5d3 10/100 interface. Now use the "atmel,sama5d3-macb" string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/macb.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> index 3e17ac1d5d58..f5c414b10e27 100644
> --- a/Documentation/devicetree/bindings/net/macb.txt
> +++ b/Documentation/devicetree/bindings/net/macb.txt
> @@ -3,8 +3,7 @@
>  Required properties:
>  - compatible: Should be "cdns,[<chip>-]{macb|gem}"
>    Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
> -  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs or the 10/100Mbit IP
> -  available on sama5d3 SoCs.
> +  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.

Where is "atmel,sama5d3-macb"?

>    Use "cdns,np4-macb" for NP4 SoC devices.
>    Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
>    Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
> -- 
> 2.17.1
> 
