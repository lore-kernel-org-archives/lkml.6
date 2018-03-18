Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4103974-1521377797-2-13170299737455087264
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
    t=1521377797; b=WhBJviilL9dN09txKneKtE9nL7MmmU1dZ1zTFTsXxGr1Vyu
    mLepuS1u4gY9Ku6l8kSAh/vV/Itro3hB3u1wyI8ZnqXG/b2+fl4oszM4/If6deYY
    UeQwmJzIS5OoZNzDCwC7Q6G7ah+GUkVfKZQECYZpiSsC57MMN1AyTJnQVEHnuiMO
    T0E37JOPjhzMIYDG3UIPU0aOz5WAROvtSBUqxbh+/6rU9LZTgLBZ89BcfcCvoTJk
    spqYIdWg85lBMayYSFlxmWPUoLJoUs0wc6NO/gdDviAp/vvz7urJZu10jQc/A2Mc
    KOGqrH3zPvP0vqCkfLbREDtbMN4HRLubNK87vuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521377797; bh=YTpplPsuixX4hDTz/9tfCTmSWK
    s9heQDjxIA7pGyfx0=; b=Z4gWLYlS23xIq4Mi2+J1DXsvWmChUKYEIu9XTzMqbW
    vtfUH95ucPqzfRJuS50bZeWCi8CWvlgADUK0Ei4wVdh8XioJVkwOKMYvo5ChVP4/
    nbDXMDYExHdljQzLHgdwwMIUuKWOtUXfidtTqsvSRMxKrhhi6P5HrM78VmDwMFiw
    zdDEfe24HTfLf4dY6nspumrvtIh6Gn35LzBLJhWI0AX5bqaUXu0G0qCEuWjedE+M
    8Wb2ShhXUu0SyvQmkVZiAOCFQjz8/QDFBxKUmtpe28kZriF4ubOd9QaWbi8IKl2r
    Na0OoimU6nuYVtL26vtLBQniIY3WmXUEyrNJ2KXvpyvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iaUQm9Z3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iaUQm9Z3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeCRMwT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 08:52:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42883 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754505AbeCRMwM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 18 Mar 2018 08:52:12 -0400
X-Google-Smtp-Source: AG47ELuKs9L3VAdPPbz4NSEiy5GBsl9N09Kdjqe5lxEm1O+aaEuGLt1zkchfS3jLQ/KmhN+EK1I1Eg==
Date: Sun, 18 Mar 2018 07:52:09 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] usb: dwc3: add clock and resets
Message-ID: <20180318125209.juoa3gkgdv2djciw@rob-hp-laptop>
References: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
 <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 08:39:58PM +0900, Masahiro Yamada wrote:
> dwc3-of-simple.c only handles arbitrary number of clocks and resets.
> They are both generic enough to be put into the dwc3 core.  For simple
> cases, a nested node structure like follows:
> 
>   dwc3-glue {
>           compatible = "foo,dwc3";
>           clocks = ...;
>           resets = ...;
>           ...
> 
>           dwc3 {
>                   compatible = "snps,dwc3";
>                   ...
>           };

I'm not a fan of how this was done.


>   }
> 
> would be turned into a single node:
> 
>   dwc3 {
>           compatible = "foo,dwc3", "snps,dwc3";
>           clocks = ...;
>           resets = ...;
>           ...
>   }

And yes, this is what I'd prefer.

> 
> I inserted reset_control_deassert() and clk_enable() before the first
> register access, i.e. dwc3_cache_hwparams().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |   2 +
>  drivers/usb/dwc3/core.c                        | 127 ++++++++++++++++++++++++-
>  drivers/usb/dwc3/core.h                        |   5 +
>  3 files changed, 132 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 44e8bab..67e9cfb 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -9,12 +9,14 @@ Required properties:
>   - interrupts: Interrupts used by the dwc3 controller.
>  
>  Optional properties:
> + - clocks: list of phandle and clock specifier pairs

However, this should be specific as to how many clocks and their 
function. This should be readily available to someone with access to 
Synopsys datasheet. The number of clocks should generally be the same 
across SoCs, it is just some SoCs either tie clocks together or don't 
provide s/w control of some of the clocks.

>   - usb-phy : array of phandle for the PHY device.  The first element
>     in the array is expected to be a handle to the USB2/HS PHY and
>     the second element is expected to be a handle to the USB3/SS PHY
>   - phys: from the *Generic PHY* bindings
>   - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
>  	or "usb3-phy".
> + - resets: list of phandle and reset specifier pairs

ditto

>   - snps,usb3_lpm_capable: determines if platform is USB3 LPM capable
>   - snps,disable_scramble_quirk: true when SW should disable data scrambling.
>  	Only really useful for FPGA builds.
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index e9083a3..f17e4a9 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -8,6 +8,7 @@
>   *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/version.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> @@ -24,6 +25,7 @@
>  #include <linux/of.h>
>  #include <linux/acpi.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/reset.h>
>  
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> @@ -240,6 +242,74 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>  	return -ETIMEDOUT;
>  }
>  
> +static int dwc3_core_get_clks(struct dwc3 *dwc)
> +{
> +	struct device *dev = dwc->dev;
> +	struct device_node *node = dev->of_node;
> +	struct clk *clk;
> +	int num_clks, i;
> +
> +	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
> +	if (num_clks <= 0)
> +		return 0;
> +
> +	dwc->num_clks = num_clks;
> +
> +	dwc->clks = devm_kcalloc(dev, num_clks, sizeof(*dwc->clks), GFP_KERNEL);
> +	if (!dwc->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_clks; i++) {
> +		clk = of_clk_get(node, i);
> +		if (IS_ERR(clk))
> +			goto put_clks;
> +		dwc->clks[i] = clk;
> +	}
> +
> +	return 0;
> +
> +put_clks:
> +	while (--i >= 0)
> +		clk_put(dwc->clks[i]);
> +
> +	return PTR_ERR(clk);
> +}
> +
> +static void dwc3_core_put_clks(struct dwc3 *dwc)
> +{
> +	int i;
> +
> +	for (i = dwc->num_clks - 1; i >= 0; i--)
> +		clk_put(dwc->clks[i]);
> +}
> +
> +static int dwc3_core_enable_clks(struct dwc3 *dwc)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < dwc->num_clks; i++) {
> +		ret = clk_prepare_enable(dwc->clks[i]);
> +		if (ret)
> +			goto disable_clks;
> +	}
> +
> +	return 0;
> +
> +disable_clks:
> +	while (--i >= 0)
> +		clk_disable_unprepare(dwc->clks[i]);
> +
> +	return ret;
> +}
> +
> +static void dwc3_core_disable_clks(struct dwc3 *dwc)
> +{
> +	int i;
> +
> +	for (i = dwc->num_clks - 1; i >= 0; i--)
> +		clk_disable_unprepare(dwc->clks[i]);
> +}
> +
>  /*
>   * dwc3_frame_length_adjustment - Adjusts frame length if required
>   * @dwc3: Pointer to our controller context structure
> @@ -641,6 +711,8 @@ static void dwc3_core_exit(struct dwc3 *dwc)
>  	usb_phy_set_suspend(dwc->usb3_phy, 1);
>  	phy_power_off(dwc->usb2_generic_phy);
>  	phy_power_off(dwc->usb3_generic_phy);
> +	dwc3_core_disable_clks(dwc);
> +	reset_control_assert(dwc->resets);
>  }
>  
>  static bool dwc3_core_is_valid(struct dwc3 *dwc)
> @@ -1205,6 +1277,22 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	dwc3_get_properties(dwc);
>  
> +	dwc->resets = devm_reset_control_array_get_optional_shared(dev);
> +	if (IS_ERR(dwc->resets))
> +		return PTR_ERR(dwc->resets);
> +
> +	ret = dwc3_core_get_clks(dwc);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(dwc->resets);
> +	if (ret)
> +		goto put_clks;
> +
> +	ret = dwc3_core_enable_clks(dwc);
> +	if (ret)
> +		goto assert_resets;
> +
>  	platform_set_drvdata(pdev, dwc);
>  	dwc3_cache_hwparams(dwc);
>  
> @@ -1268,6 +1356,14 @@ static int dwc3_probe(struct platform_device *pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> +	dwc3_core_disable_clks(dwc);
> +
> +assert_resets:
> +	reset_control_assert(dwc->resets);
> +
> +put_clks:
> +	dwc3_core_put_clks(dwc);
> +
>  	return ret;
>  }
>  
> @@ -1289,11 +1385,38 @@ static int dwc3_remove(struct platform_device *pdev)
>  
>  	dwc3_free_event_buffers(dwc);
>  	dwc3_free_scratch_buffers(dwc);
> +	dwc3_core_put_clks(dwc);
>  
>  	return 0;
>  }
>  
>  #ifdef CONFIG_PM
> +static int dwc3_core_init_for_resume(struct dwc3 *dwc)
> +{
> +	int ret;
> +
> +	ret = reset_control_deassert(dwc->resets);
> +	if (ret)
> +		return ret;
> +
> +	ret = dwc3_core_enable_clks(dwc);
> +	if (ret)
> +		goto assert_resets;
> +
> +	ret = dwc3_core_init(dwc);
> +	if (ret)
> +		goto disable_clks;
> +
> +	return 0;
> +
> +disable_clks:
> +	dwc3_core_disable_clks(dwc);
> +assert_resets:
> +	reset_control_assert(dwc->resets);
> +
> +	return ret;
> +}
> +
>  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  {
>  	unsigned long	flags;
> @@ -1325,7 +1448,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> -		ret = dwc3_core_init(dwc);
> +		ret = dwc3_core_init_for_resume(dwc);
>  		if (ret)
>  			return ret;
>  
> @@ -1336,7 +1459,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  	case DWC3_GCTL_PRTCAP_HOST:
>  		/* nothing to do on host runtime_resume */
>  		if (!PMSG_IS_AUTO(msg)) {
> -			ret = dwc3_core_init(dwc);
> +			ret = dwc3_core_init_for_resume(dwc);
>  			if (ret)
>  				return ret;
>  		}
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 860d2bc..14cd335 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -891,6 +891,11 @@ struct dwc3 {
>  	struct usb_gadget	gadget;
>  	struct usb_gadget_driver *gadget_driver;
>  
> +	struct clk		**clks;
> +	int			num_clks;
> +
> +	struct reset_control	*resets;
> +
>  	struct usb_phy		*usb2_phy;
>  	struct usb_phy		*usb3_phy;
>  
> -- 
> 2.7.4
> 
