Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3EF20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130693;
	bh=V1z837KrFQTeHqlr70LmmR3aDZOFkno1pcOduqj1Zkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NjjF2EyEb9TNYXrxJFPb+trbsmBGVBHDlv1hwUx4ro77sqN/skCoQRB15qY/KfX56
	 Feb1q1obfwdEbx2Syii6b+sXH3F9FfEeqN3zSnnybAEI7S/PFjBMLvpNybAl2lKqHn
	 gJxm70m/PvrtXqaHY6chggMQi7M6bC2yJ1w5Gv9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfBYViM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:38:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45704 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732161AbfBYViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:38:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id t82so8539640oie.12;
        Mon, 25 Feb 2019 13:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n/+FcntdGoFo0FQK5G2NK9RHZnwRapDF9RoTxONJRHY=;
        b=QXKkP/EWvwFwoDbgaCC3fUV23vGUerjWxojRh7fLDgflKPDIYHu1MOxViuMh82be/T
         yl22BRjpTVWDts2yUIyhMHwQ/pDIY38mggwIV9v8ZpmQqTSCzvugXigkRA6pwqePpwuB
         AyAg1mSA0QVe8SURlnjZ67144FxFjKkUDGz6YLC9XTHRhEDkmIIX7i+4zLHmJBu2NMJt
         ZEeEUOrMrf71+hz3M7Jz9TGo14w4ucVFJpvzh8TbKM6zrPavd4o4PAKlYvdUMdgYMFPS
         ky3PLB3Ood1k0yxPCUFKN+mn/xADwhOCs06JsZ6v54pe0WRR7BbPNWpN+wIYXc4H0GOS
         WYaw==
X-Gm-Message-State: AHQUAuYlkstXTYOWG43lHaFuGH29wVLAll097BSQcyn9neWlI0AsG2Ik
        9sY75WtSWyuo7RLMOg34q8C3tuc=
X-Google-Smtp-Source: AHgI3IaRSpo8TPfi6nCo6w6lE5YDvd4ssKFiCGeZa3BBVtyemPtj9LWYE4K23Mdp8p8bZM41jOq3bQ==
X-Received: by 2002:aca:ba06:: with SMTP id k6mr268387oif.159.1551130689156;
        Mon, 25 Feb 2019 13:38:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 97sm4964059otc.25.2019.02.25.13.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 13:38:08 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:38:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb-xhci: Add usb-phy-port-reset
 property
Message-ID: <20190225213807.GA18852@bogus>
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
 <1549347534-11320-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549347534-11320-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:48:53AM +0530, Srinath Mannam wrote:
> Add usb-phy-port-reset optional property to set quirk in xhci platform
> driver which forces USB port PHY reset on port disconnect event.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index fea8b15..ecbdb15 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -40,6 +40,7 @@ Optional properties:
>    - usb3-lpm-capable: determines if platform is USB3 LPM capable
>    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
>    - imod-interval-ns: default interrupt moderation interval is 5000ns
> +  - usb-phy-port-reset: set this to do USB PORT PHY reset while disconnect
>    - phys : see usb-hcd.txt in the current directory

This should be implied by the HCI or phy compatible string (depending 
on who exactly needs the quirky behavior).

Rob
