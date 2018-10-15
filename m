Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746CFC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FDD208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FDD208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJPCIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:08:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44609 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeJPCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:08:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so15851661oia.11;
        Mon, 15 Oct 2018 11:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXc+d0Rc6EuGQDJAiIKA+Xam+Mv/SY6agLLhvE1qLTo=;
        b=ZX1BrZD2dS9mKX/tLbCNEXAHJ9YbP8Tszg1JNHNkwPrxe9tpBNmnfyNSO+G/JKJIY3
         hH1gKEm1vKAc0zzQbSuS9H5GpxNPd12lZTkTVKtUBAlC1gclUZB9GKseF9cijt+xMiaZ
         /YnDdltsbs5hjK1PD6R4hzvtO9sf5SCZqfTOc++Ubd85zG80C89P7+6ZoJkYSMkZXX+5
         YBI6+dIza4VRy+fE0yBH8nD0SIDt2cby2xYniVxvEXF5djiXbSJzkFcY8Yvma9uaYFou
         quo38xUy5cdBqA0hTnBCxVgzTLPyq09/6CdVsXhUsUsMuM6kQXHFsZvszl7pcGlX9u+r
         Ogkw==
X-Gm-Message-State: ABuFfogNxacx5WMPKwsaXeiULnG1xN22zGHxaEHviC52p/u9kZPS9Rq7
        XllM8yw3Fx+8dzB+xvTFig==
X-Google-Smtp-Source: ACcGV61ZNC/zjhJOkGMTKfvsnjbS/hMmaLneC2p8y2fhWlVvoEtuXOBnM5lgv7XvTTRiXZysOygMOg==
X-Received: by 2002:aca:c0c1:: with SMTP id q184-v6mr10165346oif.353.1539627738080;
        Mon, 15 Oct 2018 11:22:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h70-v6sm4228397oic.17.2018.10.15.11.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:22:17 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:22:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        James Hogan <jhogan@kernel.org>, Alban Bedel <albeu@free.fr>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/5] dt-bindings: Add Broadcom STB OHCI, EHCI and XHCI
 binding document
Message-ID: <20181015182216.GA29537@bogus>
References: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
 <1538000414-24873-2-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538000414-24873-2-git-send-email-alcooperx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:20:10PM -0400, Al Cooper wrote:
> Add DT bindings document for Broadcom STB USB OHCI, EHCI and
> XHCI drivers.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../devicetree/bindings/usb/brcm,ehci-brcm.txt     | 22 +++++++++++++++++++++
>  .../devicetree/bindings/usb/brcm,ohci-brcm.txt     | 22 +++++++++++++++++++++
>  .../devicetree/bindings/usb/brcm,xhci-brcm.txt     | 23 ++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,ohci-brcm.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,xhci-brcm.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt b/Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt
> new file mode 100644
> index 000000000000..020b5ec40f5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt
> @@ -0,0 +1,22 @@
> +Broadcom STB USB EHCI controller
> +
> +Required properties:
> +- compatible: should be "brcm,ehci-brcm-v2"

Needs an SoC specific compatible string.

> +- reg: should contain one register range i.e. start and length
> +- interrupts: description of the interrupt line
> +- phys: phandle + phy specifier pair
> +  The specifier should be 0 for the OHCI/EHCI PHY and 1 for the XHCI PHY

0 or 1 depends on the phy binding. This binding just needs to say how 
many phy specifiers there are.

> +
> +Optional properties:
> +- clocks: A list of phandles for the clocks

Need to say how many and the order.

> +
> +Example:
> +
> +ehci@f0b00300 {
> +	compatible = "brcm,ehci-brcm-v2";
> +	reg = <0xf0b00300 0xa8>;
> +	interrupts = <0x0 0x5a 0x0>;
> +	interrupt-names = "usb0_ehci_0";
> +	phys = <&usbphy_0 0x0>;
> +	clocks = <&usb20>
> +};

Similar comments in the other 2 files.
