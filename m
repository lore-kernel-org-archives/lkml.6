Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E7E217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550521108;
	bh=qBn2j+BnRJE8aGgGhDzzUUg+6dOTnQXht4dN2Kzz79I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGuLQZdX5WIjwrs6Q/vgWIo1Dd3QsJvnjGRuchgqqTzeHPY4j4JkRVWyDr4lhM6e4
	 WL9ngue1gVXvUQuKpMBj4ZT+hYIoXRJo26UHE2FOY6oHEmMhniTAoZCma7kk0nhUij
	 VzL0qkA4Y+l/imLlIg93TTcJ4Q9dhSIJsYHe2BbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfBRUS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:18:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34997 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfBRUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:18:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id z19so30471462otm.2;
        Mon, 18 Feb 2019 12:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1ytODxJTkjHzSrC1XUggLa4jgS5IIoI8A4eC9IUnps=;
        b=O88akpICzHMjJwueHZO/oLVdzsbdE1yxnodQWLuLajTSJkzI78nwrbwJyjfnHd5kbP
         jcbXUBAaSMI0M08UQbcJOvSiOpMAT2pfRe16HpEmMoyEA3Y96OkQMjbhHGwCV7db6ZRr
         Sgs5RAyzXFM8/17cg07hQXhPCNoOP0ykwo5EDbndUbe9g7VPN6yiVdf60ce5X+J/SeUW
         igmMQBQu7ynR/gYDvxVB1UnqFlwOETIySLVr9/60yj+88jllqGpc58gBqFwPSRipvrpQ
         YgZEXas0NLztheTiAcBApYfA3N3p49BA6WMAnumsyWMQ99OE3svkoMnuIL5cK0A60XEU
         83ZQ==
X-Gm-Message-State: AHQUAuZ8dnQ2zb5B+RPGb4EItb8Uyn6x0zTGl8e36C8Q3mlgkEY4Ul99
        L8MkgJ/t7k/9K4QAycZYeL89PRMVIQ==
X-Google-Smtp-Source: AHgI3IYJRBnXmBULiabeAU3nbodX9Jt5jSM8Gjy446b7oZ7tlIO0abtPhEYFxM/iIV248A+czIhfcg==
X-Received: by 2002:aca:cd0c:: with SMTP id d12mr382612oig.49.1550521105519;
        Mon, 18 Feb 2019 12:18:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k130sm6701796oia.47.2019.02.18.12.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:18:25 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:18:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
Message-ID: <20190218201824.GA23724@bogus>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-2-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218112310.17860-2-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:23:01PM +0800, Yu Chen wrote:
> This patch adds binding documentation for supporting the hi3660 usb
> phy on boards like the HiKey960.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v1:
> * Fix some format error as suggested by Rob.
> v2:
> * Change hi3660 usb PHY to hi3660 USB PHY
> ---
> ---
>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt     | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> new file mode 100644
> index 000000000000..f9a3d56cfdd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> @@ -0,0 +1,21 @@
> +Hisilicon hi3660 USB PHY
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
> +
> +Example:
> +	usb-phy {
> +		compatible = "hisilicon,hi3660-usb-phy";
> +		#phy-cells = <0>;
> +		hisilicon,pericrg-syscon = <&crg_ctrl>;
> +		hisilicon,pctrl-syscon = <&pctrl>;
> +		hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;

Are most of the registers within one of these blocks? If so, make this 
node a child of that node.

> +		hisilicon,eye-diagram-param = <0x22466e4>;
> +	};
> -- 
> 2.15.0-rc2
> 
