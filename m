Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73CF218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545228598;
	bh=nNqbr1PIOnlOvlmO6o6M0AfBIrm50pUg1dwdeA0YT58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jgMYTlbeEVm180LXZz857NVk9oVQw0UQrPXbLB4mBVAeWMPoP0vA3L+P8YgnW6bHz
	 AtmAdZ16ClV3BXJ3q/VjAP2wAyaPW8mgE2Bdn1cGMikTLgqPWDiimoF0mTPa4PM8Ys
	 suCrrXOdlzJ+A3kQPbKENhdIqpi7owJcIxtkFnZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeLSOJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:09:57 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40212 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeLSOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:09:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so1670745oie.7;
        Wed, 19 Dec 2018 06:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lBddQ4xwUxWaiFLC0FQwuoepSQL2znFa/Hv/LlDZo3o=;
        b=b4bHj96Fpoq7xvrHtBKSFXcsdhJLNZH2gvPyT56BC2/titHW7+djAuf+RH9rnamVPI
         sYOOL94OHSJwehkfm9VTq91EyG1NEa2BYqBKU+YpQ7XD1gFxfPD6Pd8ihUjrEZk8X+Sm
         9ysRKiv3jnb19k0q14mvn0NykYyJU7dOq9w+HHaUe+hNX4wUU/2wzn0cN8nYRuvvAIXI
         A0Fce/7D/Xg5exTDLuwVv1ZOOaXn8K6ykcXVOu8HxhMJGIfCz7pWbzH3NITz+xc7x4JM
         xIV59ZahP8qv+Rzs4mrdaOvqi7sJ1rStl+l/vYx5+K/OImmA8ElSF5OxZoGWETLTtZFE
         Gv9w==
X-Gm-Message-State: AA+aEWbbxyR2rGotApignma6EwjfwoQwRaXixWGG3uvgBGH6vemZwtPF
        bEYbLYmFJ0v8feJGBhQ7Sg==
X-Google-Smtp-Source: AFSGD/UqPrlZVQoCmypk2dsL5LKVxyWMDISGov31SUXKEM4ZNK8YE+aQp2+LNnqxSuDFTSoB0m7Hag==
X-Received: by 2002:a05:6808:21a:: with SMTP id l26mr915311oie.312.1545228595406;
        Wed, 19 Dec 2018 06:09:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m89sm9918465otc.35.2018.12.19.06.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:09:54 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:09:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen Yu <chenyu56@huawei.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangbinghui@hisilicon.com,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 01/12] dt-bindings: usb: add support for dwc3
 controller on HiSilicon SoCs
Message-ID: <20181219140953.GA9910@bogus>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-2-chenyu56@huawei.com>
 <fde4d37b-0c4d-055b-a0ba-4e9fe87717ad@cogentembedded.com>
 <33cda716-d09c-28e7-d4b4-26f246786f5e@huawei.com>
 <680c5b9f-e2c7-926d-7d10-4ce2cd091282@cogentembedded.com>
 <bbe390f0-2fa6-515b-42c5-ede620b2b8c7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbe390f0-2fa6-515b-42c5-ede620b2b8c7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:28:56PM +0800, Chen Yu wrote:
> Hi,
> 
> On 2018/12/3 16:59, Sergei Shtylyov wrote:
> > On 03.12.2018 11:51, Chen Yu wrote:
> > 
> >>>> This patch adds binding descriptions to support the dwc3 controller
> >>>> on HiSilicon SoCs and boards like the HiKey960.
> >>>>
> >>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: John Stultz <john.stultz@linaro.org>
> >>>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> >>>> ---
> >>>>    .../devicetree/bindings/usb/dwc3-hisi.txt          | 67 ++++++++++++++++++++++
> >>>>    1 file changed, 67 insertions(+)
> >>>>    create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> >>>> new file mode 100644
> >>>> index 000000000000..d32d2299a0a1
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> >>>> @@ -0,0 +1,67 @@
> >>>> +HiSilicon DWC3 USB SoC controller
> >>>> +
> >>>> +This file documents the parameters for the dwc3-hisi driver.
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible:    should be "hisilicon,hi3660-dwc3"
> >>>> +- clocks:    A list of phandle + clock-specifier pairs for the
> >>>> +        clocks listed in clock-names
> >>>> +- clock-names:    Specify clock names
> >>>> +- resets:    list of phandle and reset specifier pairs.
> >>>> +
> >>>> +Sub-nodes:
> >>>> +The dwc3 core should be added as subnode to HiSilicon DWC3 as shown in the
> >>>> +example below. The DT binding details of dwc3 can be found in:
> >>>> +Documentation/devicetree/bindings/usb/dwc3.txt
> >>>> +
> >>>> +Example:
> >>>> +    usb3: hisi_dwc3 {
> >>>> +        compatible = "hisilicon,hi3660-dwc3";
> >>>> +        #address-cells = <2>;
> >>>> +        #size-cells = <2>;
> >>>> +        ranges;
> >>>> +
> >>>> +        clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> >>>> +             <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> >>>> +        clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> >>>> +        assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> >>>> +        assigned-clock-rates = <229000000>;
> >>>> +        resets = <&crg_rst 0x90 8>,
> >>>> +             <&crg_rst 0x90 7>,
> >>>> +             <&crg_rst 0x90 6>,
> >>>> +             <&crg_rst 0x90 5>;
> >>>> +
> >>>> +        dwc3: dwc3@ff100000 {

Please combine these into a single node. Unless you have a wrapper with 
registers, you don't need these 2 nodes. Clocks and reset can go in the 
dwc3 node.

> >>>
> >>>      According to the DT spec, the node names should be generic, not chip specific, i.e. usb@ff100000 in this case.
> >>>
> >>
> >> Do you mean it should be usb@ff100000: dwc3@ff100000 ?
> > 
> >     dwc3: usb@ff100000
> > 
> >    "dwc3:" is a label, not name.
> 
> I use the node name "dwc3@ff100000" according to Documentation/devicetree/bindings/usb/dwc3.txt
> and documentations of vendor drivers, i.e. qcom,dwc3.txt, rockchip,dwc3.txt.
> 
> In these documentations, the dwc3 sub-node name uses "dwc3@xxxxxxxx".
> 
> I think it is better to be same as the other vendor's dwc3 drivers.

It's not. The other bindings are wrong. Follow the DT Spec.

Rob
