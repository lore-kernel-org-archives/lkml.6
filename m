Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C320890
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982C320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934491AbeGCS0E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:26:04 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34676 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934309AbeGCS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:26:02 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so1102707ybq.1;
        Tue, 03 Jul 2018 11:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zdzFx3rczYWy818EgB002gC3Qapg6QYbrJqaltIaPD4=;
        b=KY/zTp/bA/JxVVZUExuzZTy7+J7HOJAJUzJ6E0taAgVyprdl/GZGjo4Hw/PHWzYl9a
         gqFA5sGSidksCJ7VlIrtfXWr4kR1FGl6o3c6BUnEyhH/HVvNmUtBId+qx5K3CUP9Qgfm
         ka0YGHT8VoDpxqTC5+wmVuBv9TxPzSIbIg+DBo/LUlpAjRmEXPPjhtvgbzVDo1S8qsYf
         TROTP6Tu43Ag2UnOQMxS4EUhxDM/N0urgMu5zeGnhfDn6U4ORxl53+3bHiztsYSOh6Y+
         Tlhg7fbY5He3DlYSeInZo624KUaZbhIfUJDjnH+khdOPHz1LXs9+Gz5iqJvjVCHMxe01
         kOyQ==
X-Gm-Message-State: APt69E35cY2P5W7Y8YHpl7Cd72NU0O9EsAZYVnNJGv+2KlglRn6J10OV
        cw6J4EtaZqfL7cdKGtWdHQ==
X-Google-Smtp-Source: ADUXVKK6D4OBp8NRVDr3Vw7vNjrABgXAqHshrvScEOrTPlRoBfdntTApL0818sJmP5T6uG8NURrR4w==
X-Received: by 2002:a25:2746:: with SMTP id n67-v6mr16534516ybn.200.1530642362035;
        Tue, 03 Jul 2018 11:26:02 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g190-v6sm766888ywh.83.2018.07.03.11.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:26:00 -0700 (PDT)
Date:   Tue, 3 Jul 2018 12:25:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>, seanpaul@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
Message-ID: <20180703182559.GA12809@rob-hp-laptop>
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
 <1529997340-156879-2-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529997340-156879-2-git-send-email-hjc@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 03:15:39PM +0800, Sandy Huang wrote:
> This path add support rv1108 and px30 rgb output interface driver.

Bindings are for h/w, not drivers.

> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc@rock-chips.com
> ---
> 
> Changes in v4: Add support px30
> Changes in v3: None
> Changes in v2: None
> 
> .../bindings/display/rockchip/rockchip-rgb.txt     | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> new file mode 100644
> index 0000000..077b9ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> @@ -0,0 +1,73 @@
> +Rockchip RV1108 RGB interface
> +================================
> +
> +Required properties:
> +- compatible: matching the soc type:
> +	- "rockchip,px30-rgb";
> +	- "rockchip,rv1108-rgb";

This doesn't look right? What (and how) is getting programmed here 
because you don't have any register interface.

> +
> +Optional properties:
> +- pinctrl-names: should be a "lcdc" entry or a "default" entry.
> +- pinctrl-0: pin control group to be used for this interface.
> +
> +The rgb has two video ports described by:
> +	Documentation/devicetree/bindings/media/video-interfaces.txt
> +Their connections are modeled using the OF graph bindings specified in
> +	Documentation/devicetree/bindings/graph.txt.
> +
> +- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop

So there is a mux for these inputs and they are switched with pinctrl? 

Just put the pinctrl nodes of the sources and enable whichever one is 
active.

Rob
