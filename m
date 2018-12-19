Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B111C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E522084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545229282;
	bh=ZuiOPMy4bql+p8o5fJy7gT59f439F67T/cmSLBnGSms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r3cCoulOAhiIDmy1Py67XAM7szOLK8rmf0FtJ6Fty65QXJYYWpec+svHaUvmCfp9x
	 PBhwSvXfV9qUHP4KsnfKIPeiT0r2TuMMnog4yUXilNmfoU5ak8DvuOgL3baA2HfGpC
	 zhls3xO23Ph5zmmBfgGGxvGgSq1f5YsmsQsKkU08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeLSOVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:21:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45136 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLSOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:21:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so19190335ota.12;
        Wed, 19 Dec 2018 06:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FDV03fILlBo4e0+KgpMmH7t5iEmdSD+aT9zk3aAZPPY=;
        b=dU3qnjlhJsawsUnQJudZW2TlKJMGiuHqOLGr6INH941rlbr0wOzMpxbkbRgGoK3X9a
         lIFW7RyunBIr99GwbU+CKZ26FkqfSJk+BFkoYSn1QT1S/2U5HfVeiUe0RuAJtmRu2iUE
         dCaVB5fmm2KM84LNcHyHxnRTPzutA1LhXuJHTC+dv21On1SeDr+qJ5EkMeN6lta2bROH
         nPmwb8fuUYCb+IuCiRSRNsUQ44u0cdJL8CzxL+pieT4pFg5idKLXFQkbKJ/laFeC8c2U
         BllCfsiCL29YVE8quZxocHyg1eoL6J9JqafjZe3mIYVcrIK+ocWfDWqMyoF8ZP3QLZSX
         Ersw==
X-Gm-Message-State: AA+aEWa8i5mj70j4CW+sqUHrOXc9w9xw30h2HNghp5WVmVRGSmIIaOXq
        4Bbg8AlqaqR0XQ6OeYcRrw==
X-Google-Smtp-Source: AFSGD/UrjvgUl0BbR3u/loGllTOIdTWGda1UQYTJ/ORe62CoAfpm78NPcnJw5zR4x1rq27yqZZZj+g==
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr4450410otg.185.1545229279609;
        Wed, 19 Dec 2018 06:21:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p129sm9559138oif.17.2018.12.19.06.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:21:18 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:21:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v1 03/12] dt-bindings: misc: Add bindings for HiSilicon
 usb hub and data role switch functionality on HiKey960
Message-ID: <20181219142118.GA24144@bogus>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-4-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203034515.91412-4-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:45:06AM +0800, Yu Chen wrote:
> This patch adds binding documentation to support usb hub and usb
> data role switch of Hisilicon HiKey&HiKey960 Board.
> 
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> --
> v1:
> 1) Fix some format errors as suggested by Sergei.
> 2) Modify gpio description to use gpiod API.
> --
> ---
>  .../bindings/misc/hisilicon-hikey-usb.txt          | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> new file mode 100644
> index 000000000000..f3413d851e18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> @@ -0,0 +1,36 @@
> +Support usb hub and usb data role switch of Hisilicon HiKey&HiKey960 Board.

s/&/ & /

Some trivial comments below, but this all needs to use the USB connector 
binding for the OTG and host ports and then we need to figure out how 
the switching fits into that.

> +
> +-----------------------------
> +
> +Required properties:
> +- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
> +- typc-vbus-int-gpio: gpio to control the vbus of typeC port
> +- typc-vbus-enable-val: gpio value that enable the vbus of typeC port

HiKey at least doesn't have a TypeC port.

> +- otg-gpio: gpio to switch DP&DM between the hub and typeC port
> +- hub-vdd33-en-gpio: gpio to enable the power of hub

-gpios for all these.

> +- pinctrl-0: pinctrl config
> +
> +Example
> +-----
> +
> +	hisi_hikey_usb: hisi_hikey_usb {
> +		compatible = "hisilicon,hikey960-usb";
> +		typec-vbus-gpios = <&gpio25 2 0>;
> +		typc-vbus-enable-val = <1>;
> +		otg-switch-gpios = <&gpio25 6 0>;
> +		hub-vdd33-en-gpios = <&gpio5 6 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbhub5734_pmx_func>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hikey_usb_ep: endpoint@0 {
> +				reg = <0>;
> +				device_type = "usb-role-switch";

Drop device_type.

> +				remote-endpoint = <&dwc3_role_switch_notify>;
> +			};
> +		};
> +
> +	};
> -- 
> 2.15.0-rc2
> 
