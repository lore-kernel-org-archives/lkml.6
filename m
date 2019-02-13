Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8344C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96834222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094248;
	bh=JRcQ5bP8qCnJCfKtieem91kM8vFgMorNqS6fqYbx1n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NQwxgfYq7hipixL9J28cQwuSq7wp+ftyNt7tcqZEDac6wGaSWL0oemD07qtmzQ/Xc
	 T4pvvA2ZlZb7c+eOY8EGgvNOAXFBK2di3oqzE2LQJUV9A2jtfXMtM1fxP9R5KuhtQx
	 5aIxTWvhoyjX+IxQBI4ZoL9/v3RjtM5kU8btR03g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403952AbfBMVoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:44:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46543 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391795AbfBMVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:44:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so6903186otm.13;
        Wed, 13 Feb 2019 13:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mygatE5L9ejlXqXxs6EaFwk2QDg+CnmV7Nl6A1YYc7o=;
        b=d1ethdHdQJ0Hw1B2NWNOuuc47+f5c//7LMZOmZPvZGR+vmGOo2HGWBDtkMV2ig0cmF
         E23J2H0llwUqB3UcvpU3ZWf+wBa3vG+/5hCu2G+jTpOBenyzE2WX2jYtqK8iog44keoa
         wqhOBjKaXOl5/oZWn+ze+17KfosI8I8N7I7AtEkp4SC7oU91oLBOM6f8AB+kKxEfQd6v
         uV1wsumVpIJCRsqs8KE7ObwL+pMNDK2vl2ISerTo+YJv/UlaYHyxMA8z5OO7wdWnRGR9
         3V+yYOvjYNcNFT+bFuafCUlFQiDYVlLWAQEth3nvWd5fXLbEfvK0GRnNSzkz96SkdCxk
         BZwg==
X-Gm-Message-State: AHQUAuagN/DfPRq8QgcGelz4b1OP5XfFyhkHEcipSeRCaAVTkk3QokWZ
        GuUp1DjUjhBT2gw/21Ltng==
X-Google-Smtp-Source: AHgI3IZVrOROshWm3fTiMOtFrTM/5eUhqBt6NxNGsZ42wVKdMKKywd4ctRkdwHu8S4XlSlmlofrYfg==
X-Received: by 2002:aca:6cc9:: with SMTP id h192mr194265oic.161.1550094245638;
        Wed, 13 Feb 2019 13:44:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u24sm403446otj.44.2019.02.13.13.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:44:04 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:44:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     jorge.ramirez-ortiz@linaro.org, robh@kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 1/4] dt-bindings: phy: remove qcom-dwc3-usb-phy
Message-ID: <20190213214404.GA31302@bogus>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-2-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-2-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 12:17:31 +0100, Jorge Ramirez-Ortiz wrote:
> This binding is not used by any driver.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/phy/qcom-dwc3-usb-phy.txt        | 37 -------------------
>  1 file changed, 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
