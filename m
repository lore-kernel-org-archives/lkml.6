Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CE02084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545228862;
	bh=9k0OBO4C3EwWwHGblNT+cjI8ox1SjSZ8a0j4eph0w0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zsonLvUmP+5Z/Ys89WFFWg+gcEaZ5HxoOpk1Rvh8Jc8VMHleP6Xk+jvxagoD2jHdb
	 k6/ftZXFiAZ5DOPo7TL7HZMgVFWlXTTKFE3yoGX3AjD+3Ux1nNjvU1Jj9hm+l9oHks
	 k6sAclGgFdmRJnQP7D7aCD73OM/w6fhKUvCtz/mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeLSOOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:14:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38509 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbeLSOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:14:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so1691538oii.5;
        Wed, 19 Dec 2018 06:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3FjKbdSeKKjl3TRYQNpL8APwaJZYiHwy40ukckZvrk=;
        b=jkTz9+rZAgaebxbEUNgByeLYj/dJB8ZdTfcZ1j5/YixUe7VkwdE8fAx7laxgd7PbPz
         onrooZJPE5sA5UZCJEBdxSQ3i0j7JjS3ToHZJm7qzRu6hARBwYqkOKAb2qnbvOiB0qDw
         2gfXdKXKMQ54HCT9Wzv03aJBg9c6uSvWXIMblaarTH1pprI7O+xkbJBspyJm+yLRuzTV
         iG0Hs/kOIlAvoMZISxP8h2qScZjtba81fcZTbSOZWDwbbr3a1teX/FMhrKyCQ61AB5Hg
         ZLBg9cGJSGqD58W2M8IOOjule7e3rP/agQBuazhWIIVK1GnOpdq/IhxTZXOXuRhBTj/c
         r2nw==
X-Gm-Message-State: AA+aEWb8F0exY+P1QNG0pNj+gqhTfcPjlRmBQHAMB7/ssqdV19qpIm8I
        H7MRG9bigSRi2u8aUROjHHGi5iU=
X-Google-Smtp-Source: AFSGD/VUkqP1i+vSte1GTwhWg8B7lVt96ajEJZUL9UxY9WDsR0X1R+PoAw5sKJWTDdp+e2t7hIObzQ==
X-Received: by 2002:aca:50cf:: with SMTP id e198mr1233096oib.343.1545228860650;
        Wed, 19 Dec 2018 06:14:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z7sm8962186otm.63.2018.12.19.06.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:14:19 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:14:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v1 02/12] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
Message-ID: <20181219141419.GA17302@bogus>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-3-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203034515.91412-3-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:45:05AM +0800, Yu Chen wrote:
> This patch adds binding documentation for supporting the hi3660 usb
> phy on boards like the HiKey960.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> --
> v1: Fix some format error as suggested by Rob.
> --
> ---
>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt     | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> new file mode 100644
> index 000000000000..8ea52d51aa13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> @@ -0,0 +1,21 @@
> +Hisilicon hi3660 usb PHY

s/usb/USB/

> +-----------------------
> +
> +Required properties:
> +- compatible: should be "hisilicon,hi3660-usb-phy"
> +- #phy-cells: must be 0
> +- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
> +- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
> +- hisilicon,usb3-otg-bc-syscon: phandle of syscon used to control phy.
> +- hisilicon,eye-diagram-param: parameter set for phy
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties

Doesn't a phy need some clocks?

> +
> +Example:
> +	usb-phy {
> +		compatible = "hisilicon,hi3660-usb-phy";
> +		#phy-cells = <0>;
> +		hisilicon,pericrg-syscon = <&crg_ctrl>;
> +		hisilicon,pctrl-syscon = <&pctrl>;
> +		hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;

Is one of these the "main" registers for the phy? If so, then make this 
a child of that syscon node.

> +		hisilicon,eye-diagram-param = <0x22466e4>;
> +	};
> -- 
> 2.15.0-rc2
> 
