Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA8C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C01208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544139953;
	bh=QCCruB+vFZKboOCfl+j80BZ59hOWLGKWkIKRapam2fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JqY8quZtoLE8KCyq7bc4bdGMf3cIWph3ZFHu2j1oj1KEfeHiRpQFSH9EABqpV6PkO
	 UdF2gP+uw8e61nSsej2RTijFrmfV2/OArHJfTTUImsu2RWlPOWGMkv/Z17Osst/7Np
	 phKDI1pGg0DIyYXBCnceeOu0tdOQFYVxMwQASmsM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C01208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLFXpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:45:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34685 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLFXpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:45:52 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so2005986oig.1;
        Thu, 06 Dec 2018 15:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKdhjSTvTqGKMd8lU/xs/o2+ByWUt+TlCbLxQYPDo34=;
        b=ncZDV0tWXBn8ZUIVSg/pX5Ib6fQh1Xb1SMM4x7acyOWIlISwj/Y/n+tzFmIijVknl0
         bxrBZYbualzeyE+hrYA1cLm9CyrmajBfybL9rAC6NysPAJJSIHTsIaV/gjvFGCNh3PF6
         kWRi3OcVFBSL04uRx5b1nYoRqavpGglkbJlNx+0BuL7ICXics28vbdIBiHwcvwwZ7U3C
         0hOuAye461Aj1vtTBcdZqTcANisORqVSxN43gsuYL57YHOjqVHphUicC+ppkqrCJ3k8Y
         v7NV2JCGannv6fWZ/jERGxfrx4/+2FZKhenhM4Qx3Kz/JMEQgAX7HUz5MlCLCkfxRFTs
         eKDQ==
X-Gm-Message-State: AA+aEWa//B11BWMYtpTvHhKOP5UAqI+mS2hsV/PN9yPUm8wjA02rkCX1
        3tYoJNy0lIf4B0qVUnnikw==
X-Google-Smtp-Source: AFSGD/Vn7JUiezD+ASGIYqL+Ny8Sf2QRqBdHeVNnvg7lKz3PlGtX1jsPayYVeylgnOjaRNJ7jDc4IQ==
X-Received: by 2002:aca:e346:: with SMTP id a67mr19571969oih.81.1544139951481;
        Thu, 06 Dec 2018 15:45:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y20sm1633940otk.66.2018.12.06.15.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:45:51 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:45:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen.Hristev@microchip.com
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH 2/3] dt-bindings: drm/panel: simple: add support for PDA
 91-00156-A0
Message-ID: <20181206234550.GA3012@bogus>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
 <1542789804-4584-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542789804-4584-3-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:48:00AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> Adding Device Tree bindings for this panel.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  .../devicetree/bindings/display/panel/pda,91-00156-a0.txt          | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> new file mode 100644
> index 0000000..52f0da9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> @@ -0,0 +1,7 @@
> +PDA 91-00156-A0 5.0" WVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "pda,91-00156-a0"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

You need to explicitly list what properties from this are used. Does 
this have a single supply or did you just forget to add supplies for 
example? I don't know.

Rob
