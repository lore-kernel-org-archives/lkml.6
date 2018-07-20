Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71533ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364C6204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364C6204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbeGTQEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50621 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbeGTQEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:15 -0400
Received: by mail-it0-f67.google.com with SMTP id w16-v6so15151495ita.0;
        Fri, 20 Jul 2018 08:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4400huQ4V5Ov3OYcmT3UpQzNbXASRQed/CIQba7Utw=;
        b=CyX6eFeZxQ8Swr5njTvfzTaJhalWZcMoB4JBYAgoQgrChlLr/ih4Uh57DjrJWGSDbV
         FtBnBGlfCdSgep44EijcZ/OYbUtI8jvYhCZHQocpzjn2bDuoIslpKDoqDZmcL3vicMFq
         PTjcDalES91CcvqVrRwh0Fr2JCoes6rKaEGrUit+ERtQQz7FtnabG2cvYT7Sy2Y7Vxvy
         3H7fNel6N8BuKdECzwsFKaovku21R7jVM35bmpBJ9aKhjQXaDy2EvMsgrelB3Vj4xXZK
         jm2fjeC8BokUD1WUD4o9VitVOb9RVzZjoWEtZF+TedNXFlLMIfl4xtbSCVXsoSLp4EGr
         KrVA==
X-Gm-Message-State: AOUpUlEE88+MKG6f/WyrIHd3dLn/lljFQHyFoetHSJfNkhbCojAHR1fv
        TpyH1RwCJjExjsCGN8m0VQ==
X-Google-Smtp-Source: AAOMgpeDIhFR4eOpwRlsrfyIib80zDHfOL8KUeFtnN3jkW1z3PdQNkenI12Rm9756/9saY0AK0H6ag==
X-Received: by 2002:a24:8282:: with SMTP id t124-v6mr2097054itd.57.1532099730616;
        Fri, 20 Jul 2018 08:15:30 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id i9-v6sm627063iom.19.2018.07.20.08.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:15:30 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:15:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: syna: add support for the AS370 SoC
Message-ID: <20180720151529.GA26487@rob-hp-laptop>
References: <20180713171712.05f58a74@xhacker.debian>
 <20180713172457.6193a92f@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713172457.6193a92f@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 05:24:57PM +0800, Jisheng Zhang wrote:
> The AS370 SoC is a new derivative of the berlin family. The only
> difference is the SoC isn't named as berlin*.

So is it a derivative or just rebranded?

> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/arm/syna.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
> index 3bab18409b7a..3ba1d7b5ee74 100644
> --- a/Documentation/devicetree/bindings/arm/syna.txt
> +++ b/Documentation/devicetree/bindings/arm/syna.txt
> @@ -1,4 +1,4 @@
> -Marvell Berlin SoC Family Device Tree Bindings
> +Synaptics SoC Device Tree Bindings

Perhaps some note about what has happened here. Otherwise it looks 
strange having "Marvell Berlin" in the document when the title says 
Synaptics SoC.

>  ---------------------------------------------------------------
>  
>  Work in progress statement:
> @@ -13,6 +13,10 @@ stable binding/ABI.
>  
>  ---------------------------------------------------------------
>  
> +Boards with the Synaptics AS370 SoC shall have the following properties:
> +  Required root node property:
> +    compatible: "syna,as370"
> +
>  Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
>  shall have the following properties:
>  
> -- 
> 2.18.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
