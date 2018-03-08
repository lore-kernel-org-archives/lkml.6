Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-529228-1520472924-2-15317530088046689457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520472923; b=OAjuoR4wc2g5ybC8mgu0B0aijOEtbdYsTWTv1PqhBP+44kb
    Bv4ddaZSt8t2cw3/4VAURaf1GXIhOdQNT6eKTp2yR7htbDLqpFQyuCjc85KFOO/F
    fezWf3AYYnYXamEMktW2vyMyee6AR3p7fgc9V/VGeTAO9w4zdPwpqBWjaI0Atedr
    i5WtCzlzil0GCHek9+S1akOy/s+heFSdsNu3DG6w9lrKSuvZgCkAfEnZl8JwDm/U
    7I2p2+BipYhCEipORSmP4AFZqVyyEIw0KAUCjjkVdMW8iZcb/3SNK/16pBuxYeV1
    GkLcC5FwbQa5iq4ZpUVoLghmxkIa0mA+mGY8+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520472923; bh=DDpKB4TrPma1WZNePrspaKjyF1
    Tm3orLco0FR1bXpG0=; b=ZSvg/znORrEinhFQVlTdWZGxqCNENOtokodEgx7X3i
    uS8zYKsXav0TI3eHuA5MEBiNs8xyxlSDmc9vk1HvBNfxMbgBrwC87k05T0JlK4AS
    l0+x2oDY0TxBZbcdjA8CQSXjdYQqEoezuN/GjeV/4mHW+9JaidpN1/Wr0I7MrAbG
    p0+gQA53swLQ7x2fYxF6XnpsW9EuJF3r6KNR0MrzoIp+YEA965DAhFjpnKu5JX8I
    unlUd7RAYGU4XJbAioO+rnSit5oty+5u65kgqHbhZe3KCnIgj41XnYXx5lqfU95W
    knPhlcBZdu9YM1Ds23cpa7NlUjSByATKkhkia5RHmmSw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q/noNKq3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q/noNKq3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934582AbeCHBfK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 20:35:10 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38130 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933554AbeCHBfI (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Mar 2018 20:35:08 -0500
X-Google-Smtp-Source: AG47ELtZPpa0D/+JotiwwhVz8vJCP8QCJejkZEPVUeS4o3WqeOLaf2OInSEwr11FcHCRed28SLlT2g==
Date: Wed, 7 Mar 2018 19:35:05 -0600
From: Rob Herring <robh@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] USB3/DWC3: Enable undefined length INCR burst type
Message-ID: <20180308013505.lyrmkdz54iyghbsf@rob-hp-laptop>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
 <20180306085911.5930-3-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306085911.5930-3-ran.wang_1@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 04:59:11PM +0800, Ran Wang wrote:
> Enable the undefined length INCR burst type and set INCRx.
> Different platform may has the different burst size type.
> In order to get best performance, we need to tune the burst size to
> one special value, instead of the default value.
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v5:
>   - no change
> Changes in v4:
>   - Modify the codes according to the definition of this property.
> Changes in v3:
>   - add new property for INCR burst in usb node to reset GSBUSCFG0.
> Changes in v2:
>   - split patch
>   - create one new function to handle soc bus configuration register.
> 
>  drivers/usb/dwc3/core.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |    7 ++++
>  2 files changed, 90 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index f1d838a..8ea2bc8 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -741,6 +741,87 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
>  static int dwc3_core_get_phy(struct dwc3 *dwc);
>  static int dwc3_core_ulpi_init(struct dwc3 *dwc);
>  
> +/* set global soc bus configuration registers */
> +static void dwc3_set_soc_bus_cfg(struct dwc3 *dwc)
> +{
> +	struct device *dev = dwc->dev;
> +	u32 *vals;
> +	u32 cfg;
> +	int ntype;
> +	int ret;
> +	int i;
> +
> +	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
> +
> +	/*
> +	 * Handle property "snps,incr-burst-type-adjustment".
> +	 * Get the number of value from this property:
> +	 * result <= 0, means this property is not supported.
> +	 * result = 1, means INCRx burst mode supported.
> +	 * result > 1, means undefined length burst mode supported.
> +	 */
> +	ntype = device_property_read_u32_array(dev,
> +			"snps,incr-burst-type-adjustment", NULL, 0);

Can't you just do:

if (ntype <= 0)
    return;

> +	if (ntype > 0) {

And then save a level of indentation.

> +		vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
> +		if (!vals) {
> +			dev_err(dev, "Error to get memory\n");
> +			return;
> +		}
> +		/* Get INCR burst type, and parse it */
> +		ret = device_property_read_u32_array(dev,
> +			"snps,incr-burst-type-adjustment", vals, ntype);
> +		if (ret) {
> +			dev_err(dev, "Error to get property\n");
> +			return;
> +		}
> +		*(dwc->incrx_type + 1) = vals[0];
> +		if (ntype > 1) {
> +			*dwc->incrx_type = 1;
> +			for (i = 1; i < ntype; i++) {
> +				if (vals[i] > *(dwc->incrx_type + 1))
> +					*(dwc->incrx_type + 1) = vals[i];
> +			}
> +		} else
> +			*dwc->incrx_type = 0;

This code is hard to follow. Why do you have an array to store a boolean 
(INCR burst enable) and the burst size. 2 elements with more descriptive 
names would be better.


> +
> +		/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
> +		cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
> +		if (*dwc->incrx_type)
> +			cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
> +		switch (*(dwc->incrx_type + 1)) {
> +		case 256:
> +			cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
> +			break;
> +		case 128:
> +			cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
> +			break;
> +		case 64:
> +			cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
> +			break;
> +		case 32:
> +			cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
> +			break;
> +		case 16:
> +			cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
> +			break;
> +		case 8:
> +			cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
> +			break;
> +		case 4:
> +			cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
> +			break;
> +		case 1:
> +			break;
> +		default:
> +			dev_err(dev, "Invalid property\n");
> +			break;
> +		}
> +	}
> +
> +	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
> +}
> +
>  /**
>   * dwc3_core_init - Low-level initialization of DWC3 Core
>   * @dwc: Pointer to our controller context structure
> @@ -803,6 +884,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	/* Adjust Frame Length */
>  	dwc3_frame_length_adjustment(dwc);
>  
> +	dwc3_set_soc_bus_cfg(dwc);
> +
>  	usb_phy_set_suspend(dwc->usb2_phy, 0);
>  	usb_phy_set_suspend(dwc->usb3_phy, 0);
>  	ret = phy_power_on(dwc->usb2_generic_phy);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8f97f61..565d7ec 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -806,6 +806,7 @@ struct dwc3_scratchpad_array {
>   * @regs: base address for our registers
>   * @regs_size: address space size
>   * @fladj: frame length adjustment
> + * @incrx_type: INCR burst type adjustment
>   * @irq_gadget: peripheral controller's IRQ number
>   * @nr_scratch: number of scratch buffers
>   * @u1u2: only used on revisions <1.83a for workaround
> @@ -939,6 +940,12 @@ struct dwc3 {
>  	enum usb_phy_interface	hsphy_mode;
>  
>  	u32			fladj;
> +	/*
> +	 * For INCR burst type.
> +	 * First field: for undefined length INCR burst type enable.
> +	 * Second field: for INCRx burst type enable
> +	 */
> +	u32			incrx_type[2];
>  	u32			irq_gadget;
>  	u32			nr_scratch;
>  	u32			u1u2;
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
