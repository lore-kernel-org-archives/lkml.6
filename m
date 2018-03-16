Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1717850-1521167353-5-7646987478733602191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521167353; b=m2V0sJ9GzCVBXnNOl+8p1T6lVtzPr/3u95KhFt8nQjefZgf
    oVCmv7V7YW+EvDXpzEXORMdOiaN9Kc8mVFDPNudMpcXDgrwZ6KaWEOMFb4kKxeu9
    Kilm6HvdyMaX2VFlwU51M4y04NH6sADyzJ/WV8JZdb7hTABob/gzsJWalA0mhrMr
    9YaFTSdC1xPu4dNdOPFVpOsjeYRi8x7XEl34CxojUqxISvvMZz+5qqkImFjL33CV
    4YNMTQpab51V1GF7faX47M7XnRJzZPKdAK3I/beXUv1TWN409XVB55XZY4FpoR+T
    Y00cg3Z5aDv+tUKdqUciLbmPhHC2T+d5L/anqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521167353; bh=yMuVQJQAmK3HKeKZ7P3FoAs8G7++DWn9TYQMShAG5r8=; b=a
    8E7kdp81/SH6PuYePAbg3f8mvY8cBfxD4fiRkHpcD6gS6JhCWW66SpIA310n3cJS
    kPB5Cif0DhMwt30uih/K6ll+9tX7DZDGZu/s/E3+eCVJn6Sb44494tksI44osoa/
    Unna909yGSz4e3lyI3gIBH0eLJcvokE4nc0yzgBFwePaT1fgvIf0HWIDnssOqATS
    TsbVpo4LYscAuhIKcpedAYbhbpHplH7GhD0/GHzaD6+jGha0tDM4lvzwzYQOq253
    XA0zOQRsrBIGLa1hm6dsG2oXOP8RVz3ZFK7mDSP4w7G7ndj8a+35/W92isUDc6Gg
    9+Ghk60WseWd6oUkF8G0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCPC24 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 22:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeCPC2z (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 22:28:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4FB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 16 Mar 2018 11:28:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] usb: dwc3: add clock and resets
Message-Id: <20180316112851.d70521f05c79951a6d300742@kernel.org>
In-Reply-To: <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
References: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
        <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 20:39:58 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

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
> 
> I inserted reset_control_deassert() and clk_enable() before the first
> register access, i.e. dwc3_cache_hwparams().

This looks good to me. 

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

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
>   - usb-phy : array of phandle for the PHY device.  The first element
>     in the array is expected to be a handle to the USB2/HS PHY and
>     the second element is expected to be a handle to the USB3/SS PHY
>   - phys: from the *Generic PHY* bindings
>   - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
>  	or "usb3-phy".
> + - resets: list of phandle and reset specifier pairs
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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
