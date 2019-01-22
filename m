Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D47C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4343F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548119257;
	bh=5jwayfqkRCuOLRd8/9J9Dxz87AqZ3VrK/mi3HGTkh4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mcY7Xtp5ioMj5FmxzP69kfSmqL6fWqp7zOEjAhSSMnQu4PitdtHNJSqtF3DC3AU2M
	 p8VJ2PLb+1pWleSmu8JHzQY0aPM3Rjm7pF6H4rZC9NiqTnEte/El53vP370JfhPNpc
	 cKVzeqIvEVraK6Ha/a7+8klrf+dhwBt+ftG67gdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfAVBHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:07:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34606 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAVBHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:07:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so17173735otk.1;
        Mon, 21 Jan 2019 17:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/nRio5fAD0pW+N4ivHGzHMVFGGptuHDxNgOgJeP7bI=;
        b=kFDXtukzCpAbINg788HdXjT5c5GlZjQHx2+wu2AQzEa/lkneB9BC30KYwGel/aaDa2
         dhfsln5jfnCYN+jeOckdwgPvrjtG4YnV0VfBQNEUYmfOlmkviEfh9ggEdnDNDUnv4EXP
         G+NJtymPVXil8HtMOK0Kx93teIHMhRV0iB94LpLFjwTS/X27jylmnxUXm7qKNAL0xXJv
         x9qTOnrDDh6F7SmWNEYnaJYFNX9l9+PLrNf6fKsF0G2vcWENGLWRdhyk3svdjZGmBdil
         TpDJLAleyY+H68h7emetpLITb6G+8ir1iwXnC/1ksY0kJwD4Ng5BjFAz4gfyvUmh2Y73
         SFhQ==
X-Gm-Message-State: AJcUukfzvfXuExXzIsIqryFz+dyKRhpvF+k1FGiLptNsmhlEmwoRVYFl
        5I0C5tEVbmjKWIFhfNAZjw==
X-Google-Smtp-Source: ALg8bN7MI+OIsDNpY+m/U1nuHHeYT0ce6NJzeh5KVfkcmtdXBafyy+F8aQkA+NV3zFrLtjwxnt4Jrw==
X-Received: by 2002:a9d:6297:: with SMTP id x23mr19478201otk.63.1548119254572;
        Mon, 21 Jan 2019 17:07:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z15sm6468070oib.23.2019.01.21.17.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:07:33 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:07:33 -0600
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
Subject: Re: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
Message-ID: <20190122010733.GA21139@bogus>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:57:38AM +0100, Nicolas Ferre wrote:
> Update the Reset Controller's binding to add new SoC compatibility string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 36952cc39993..badce6ef3ab3 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -22,6 +22,7 @@ Its subnodes can be:
>  RSTC Reset Controller required properties:
>  - compatible: Should be "atmel,<chip>-rstc".
>    <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
> +  it also can be "microchip,sam9x60-rstc"

How is this related to at91sam9260-rstc?

The 'x' is a wildcard? We generally avoid wildcards.

>  - reg: Should contain registers location and length
>  - clocks: phandle to input clock.
>  
> -- 
> 2.17.1
> 
