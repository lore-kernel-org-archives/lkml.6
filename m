Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF899C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFAF206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550881144;
	bh=SoYqt0gJ3OH1V+vW2BZ8S4uhI1PMwHYCWhTE1SekDhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPCRdPgOzbPFmh3ZusXFzuyFBcUMN7kJGQJl7/NUa+YiHwlD6GxnBNkFQpVmn6Zk2
	 YwQr3ssNoZ2dA4szW2TTauiM4JdPBioYYepY8g80R9usr03wUKTicghwqErx4sp2Km
	 b+VJkd7rPOiD2wwJ1Ojp/C7HXqkweKBYQsNjB03c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBWATD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:19:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46357 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWATD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:19:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id j135so3113270oib.13;
        Fri, 22 Feb 2019 16:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5jQBLpjkwgZ8uBCvuca4O9cQ1tXOhWWETW7U2gawY6I=;
        b=ArRolemtXfA5Nn/lJovDhS9KLvlgfq4e+Yqi+vq/ECOSfeQv54EZTeEBqiWJjrhOuO
         WnH5IAkoTfMLzeOEvFtPGH3XKCQPBks4AhByvGDgW7S76uxTXcWW56IXsWPk8XfCJ8Ky
         IY97VUm0JuiVIMGZINt18PpegrogYYvVYrtI+pCd1allhJUOW0CWKquYJEHQkJW+xuka
         q9K9cBo446HYnjId1ROvT0xMxVJTHnM8rxhb+Vw78wLXQcnUVc9EdV/FcbyZxMlyV1Ii
         engWNViPIETVpmlmhEvMpVGJxPC9rm1W5yVLesW0ajZDrNBhBR04vugr9Fbmqp/Rdc6j
         GIWA==
X-Gm-Message-State: AHQUAua5mFQu/oamG7QbcBRuEGfRyzdFdux0nVolqXHx7jChFO+VmvNJ
        blLwTo5v0HpQq6bBlwRu+A==
X-Google-Smtp-Source: AHgI3IahrTjXgi23GLN8uwF4nfk7uwbH1B/sjY2AzOvkskMxs5MgIiuxY+82ViUqSqmwit2hQE8S2Q==
X-Received: by 2002:aca:cf93:: with SMTP id f141mr4293589oig.130.1550881142331;
        Fri, 22 Feb 2019 16:19:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p8sm1437015otf.53.2019.02.22.16.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:19:01 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:19:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Roullier <christophe.roullier@st.com>
Cc:     robh@kernel.org, davem@davemloft.net, joabreu@synopsys.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        christophe.roullier@st.com, andrew@lunn.ch
Subject: Re: [PATCH V2 6/8] dt-bindings: net: stmmac: add syscfg clock
 property
Message-ID: <20190223001901.GA4107@bogus>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
 <1550824089-19961-7-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550824089-19961-7-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 09:28:07 +0100, Christophe Roullier wrote:
> Need syscfg clock for MCU family in case bootloader does not
> activate it.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
