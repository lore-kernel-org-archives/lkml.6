Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-687271-1521002378-2-10206854356796312241
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521002377; b=oXfVi1e8cIPdwi+S4u+iqry7Y4MHPL1X5yI0qSemgAJrit9
    ZSg1B7Ncp6JhIOlLp+W2LaU9D1Ri6mae9poLHO//vwBMzfaA7N1oM9RFGjRi7dMl
    kwJCcauPnlsziiux6FVl4gds7t4m2k2LbGydrhEX3zAdI7ZluYEEPf9H4Ue/At9W
    7ok+fHlFndPgf8yBeZp8DPjgR4C1hYzwhMUpev95GvwzfXqmNqXQBkCT8AJ9FePS
    r5SjvUloBT4R+fZE/kXFQU2ZQX7gmvM9R61pBIoGeMMSY9jgUitWoaYzkTDb3o5W
    IG4rGw0m0q/rUFIMVHBQY59fvCkPa0gVYtJ1d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521002377; bh=H36th1I8C4tcsHrrwrLmKFSnDVTP618ObaIUDTYfhUk=; b=r
    ZjQfMAOHx8x/bnxw3N7STGjRzW6xdpAa3Xs8rAf1HjVlmzpu1EKRUPSg4gP7+rsO
    B/fEv4oY5g0UIoT+jfPGFGa0s1vowGG24tY8uge+UsQ9JILtE8D8Z/gsHE5H5ALT
    CYcKoCxp8Mt3Hes0hKPMQ/kHv7BvqJDAtp3XTkGteNkaXiexmd314PiNnNHxqDt+
    S/WYgxII5RW/0cuEDG4zdJqvOLzxjH6LmwSGRl2uyDeKIMFFOXzSLzuKBELwypKI
    +QalWiyMpXrem+ekZwdaL6Ou6XJ92vKBlw0x/U7F2lRrGAUV3f+dmOuv0PnD9Rvr
    Elkk3LB79Rwf4eSXzZ1og==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Fvep+i9o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=PepbV2f7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Fvep+i9o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=PepbV2f7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeCNEjR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 00:39:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeCNEjK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 00:39:10 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23C8260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v1 2/2] usb: dwc3: Add Qualcomm DWC3 glue driver
To: Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
 <1520937362-28777-2-git-send-email-mgautam@codeaurora.org>
 <878taw8c81.fsf@linux.intel.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <5a65d202-bb94-0f73-f9aa-9055a1cddf76@codeaurora.org>
Date: Wed, 14 Mar 2018 10:09:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <878taw8c81.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,


On 3/13/2018 4:38 PM, Felipe Balbi wrote:
> Hi,
>
> +Andy
>
> Manu Gautam <mgautam@codeaurora.org> writes:
>> DWC3 controller on Qualcomm SOCs has a Qscratch wrapper.
>> Some of its uses are described below resulting in need to
>> have a separate glue driver instead of using dwc3-of-simple:
>>  - It exposes register interface to override vbus-override
>>    and lane0-pwr-present signals going to hardware. These
>>    must be updated in peripheral mode for DWC3 if vbus lines
>>    are not connected to hardware block. Otherwise RX termination
>>    in SS mode or DP pull-up is not applied by device controller.
> right, core needs to know that VBUS is above 4.4V. Why wasn't this a
> problem when the original glue layer was first published?

Thanks for reviewing.
Original glue layer supported only host mode, hence this wasn't needed.

>
>>  - pwr_events_irq_stat support to ensure USB2 PHY is in L2 state
>>    before glue driver can turn-off clocks and suspend PHY.
> Core manages PHY suspend automatically. Isn't that working for you? Why?

Yes, it is not supported with QUSB2 PHY (usb2-phy on Qualcomm SOCs).
Issue is that If core suspends USB2 PHY (say in host mode if some SS device connected),
USB2 PHY stops responding to any attach event as it can't exit suspend state by itself.
But in case of driver suspend, along with PHY suspend wakeup events are enabled.
Glue driver can register for wakeup interrupts to exit suspend.

>
>>  - Support for wakeup interrupts lines that are asserted whenever
>>    there is any wakeup event on USB3 or USB2 bus.
> ok
>
>>  - Support to replace pip3 clock going to DWC3 with utmi clock
>>    for hardware configuration where SSPHY is not used with DWC3.
> Is that SW configurable? Really? In any case seems like this and SESSVLD
> valid should be handled using Hans' and Heikki's mux support.

Yes, with this we can use dwc3 without using SSPHY. Please point me to
those patches. There are only bunch of register writes in glue wrapper to
achieve the same.

>
>> Other than above hardware features in Qscratch wrapper there
>> are some limitations on QCOM SOCs that require special handling
>> of power management e.g. suspending PHY using GUSB2PHYCFG
>> register and ensuring PHY enters L2 before turning off clocks etc.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  drivers/usb/dwc3/Kconfig          |  11 +
>>  drivers/usb/dwc3/Makefile         |   1 +
>>  drivers/usb/dwc3/dwc3-of-simple.c |   1 -
>>  drivers/usb/dwc3/dwc3-qcom.c      | 635 ++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 647 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/usb/dwc3/dwc3-qcom.c
>>
>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>> index ab8c0e0..f5bb4f1 100644
>> --- a/drivers/usb/dwc3/Kconfig
>> +++ b/drivers/usb/dwc3/Kconfig
>> @@ -106,4 +106,15 @@ config USB_DWC3_ST
>>  	  inside (i.e. STiH407).
>>  	  Say 'Y' or 'M' if you have one such device.
>>  
>> +config USB_DWC3_QCOM
>> +	tristate "Qualcomm Platform"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on OF
>> +	default USB_DWC3
>> +	help
>> +	  Some Qualcomm SoCs use DesignWare Core IP for USB2/3
>> +	  functionality.
>> +
>> +	  Say 'Y' or 'M' if you have one such device.
>> +
>>  endif
>> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
>> index 7ac7250..c3ce697 100644
>> --- a/drivers/usb/dwc3/Makefile
>> +++ b/drivers/usb/dwc3/Makefile
>> @@ -48,3 +48,4 @@ obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
>>  obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
>>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
>>  obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
>> +obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
>> index cb2ee96..0fd0e8e 100644
>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> @@ -208,7 +208,6 @@ static int dwc3_of_simple_runtime_resume(struct device *dev)
>>  };
>>  
>>  static const struct of_device_id of_dwc3_simple_match[] = {
>> -	{ .compatible = "qcom,dwc3" },
>>  	{ .compatible = "rockchip,rk3399-dwc3" },
>>  	{ .compatible = "xlnx,zynqmp-dwc3" },
>>  	{ .compatible = "cavium,octeon-7130-usb-uctl" },
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> new file mode 100644
>> index 0000000..917199e
>> --- /dev/null
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -0,0 +1,635 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + *
>> + * Inspired by dwc3-of-simple.c
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/clk.h>
>> +#include <linux/irq.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/extcon.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/usb/of.h>
>> +#include <linux/reset.h>
>> +#include <linux/iopoll.h>
>> +
>> +#include "core.h"
>> +#include "io.h"
> you must be kidding, right? There's no way I'm gonna let a glue poke at
> core registers.
>
>> +static void dwc3_qcom_suspend_hsphy(struct dwc3_qcom *qcom)
>> +{
>> +	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
>> +	int		ret;
>> +	u32		val;
>> +
>> +	/* Clear previous L2 events */
>> +	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
>> +			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
>> +
>> +	/* Allow controller to suspend HSPHY */
>> +	val = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> +	val |=  DWC3_GUSB2PHYCFG_ENBLSLPM | DWC3_GUSB2PHYCFG_SUSPHY;
>> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), val);
> core should handle PHY bits. In any case, why don't you let core handle
> PHY suspend? It handles it automatically for us, there should be no need
> for SW intervention.
I agree with you. That would have been straight forward, but due to PHY issue
I mentioned earlier I had to do this here. I added more info on this in response to
your comment below.

>
>> +static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
>> +{
>> +	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
> nope! Glue shouldn't touch dwc3 at all.
Other than PHY handles, need this to fail runtime suspend if dwc3 hasn't
probed yet.

>
>> +	int		 i;
>> +
>> +	if (qcom->is_suspended)
>> +		return 0;
>> +
>> +	if (!dwc)
>> +		return -EBUSY;
> -ENODEV?
Ok.
>
>> +	dwc3_qcom_suspend_hsphy(qcom);
>> +
>> +	if (dwc->usb2_generic_phy)
>> +		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>> +	if (dwc->usb3_generic_phy)
>> +		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> core.c should do this.
Recommended sequence from h/w programming guide is that:
1. PHY autosuspend must be left disabled - snps,dis_u2_susphy_quirk/dis_enblslpm_quirk
2. During runtime-suspend (say on xhci bus_suspend) , PHY should be suspended
    using GUSB2PHYCFG register
3. Wait until pwr_event_irq_stat in qscratch reflects PHY transition to L2.
3. USB2 PHY driver can suspend - enable wakeup events and turns off clocks etc.
4. dwc3 glue driver can suspend.

Since, pwr_event_irq stat can't be checked in core driver, I added this handling
in glue driver. Alternative approach I can think of is to let dwc3 core suspend
PHY using GUSBPHYCFG register on suspend,  add some delay before
suspending PHY. Glue driver can check for pwr_event_irq stat and throw a
warning if PHY not in L2.
On runtime-resume, dwc3 core based on quirks - snps,dis_u2_susphy_quirk
can restore/clear the GUSB2PHYCFG register.

>
>> +	/* Disable HSPHY auto suspend */
>> +	val = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> +	val &= ~(DWC3_GUSB2PHYCFG_ENBLSLPM | DWC3_GUSB2PHYCFG_SUSPHY);
>> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), val);
>> +
>> +	qcom->is_suspended = false;
>> +
>> +	dev_dbg(qcom->dev, "DWC3 exited from low power mode\n");
> no dev_dbg() or dev_info() in this driver.
ok

>
>> +static irqreturn_t qcom_dwc3_resume_irq(int irq, void *data)
>> +{
>> +	struct dwc3_qcom *qcom = data;
>> +	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
>> +
>> +	/* If pm_suspended then let pm_resume take care of resuming h/w */
>> +	if (qcom->pm_suspended)
>> +		return IRQ_HANDLED;
>> +
>> +	dwc3_qcom_resume(qcom);
> instead, why don't you pm_runtime_resume() here, and let runtime_resume()
> handle dwc3_qcom_resume() ?

Sure. I added this earlier because runtime_pm might be disabled
if irq races with pm_resume. Now with pm_suspended check above, I can try
your suggestion.

>
>> +static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
>> +{
>> +	struct device		*dev = qcom->dev;
>> +	struct device_node	*np = dev->of_node;
>> +	int			i;
>> +
>> +	qcom->num_clocks = count;
>> +
>> +	if (!count)
>> +		return 0;
>> +
>> +	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
>> +				  sizeof(struct clk *), GFP_KERNEL);
>> +	if (!qcom->clks)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < qcom->num_clocks; i++) {
>> +		struct clk	*clk;
>> +		int		ret;
>> +
>> +		clk = of_clk_get(np, i);
>> +		if (IS_ERR(clk)) {
>> +			while (--i >= 0)
>> +				clk_put(qcom->clks[i]);
>> +			return PTR_ERR(clk);
>> +		}
>> +
>> +		ret = clk_prepare_enable(clk);
>> +		if (ret < 0) {
>> +			while (--i >= 0) {
>> +				clk_disable_unprepare(qcom->clks[i]);
>> +				clk_put(qcom->clks[i]);
>> +			}
>> +			clk_put(clk);
>> +
>> +			return ret;
>> +		}
>> +
>> +		qcom->clks[i] = clk;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dwc3_qcom_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node	*np = pdev->dev.of_node, *dwc3_np;
>> +	struct dwc3_qcom	*qcom;
>> +	struct resource		*res;
>> +	int			irq, ret, i;
>> +	bool			ignore_pipe_clk;
>> +
>> +	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>> +	if (!qcom)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, qcom);
>> +	qcom->dev = &pdev->dev;
>> +
>> +	qcom->resets = of_reset_control_array_get_optional_exclusive(np);
>> +	if (IS_ERR(qcom->resets)) {
>> +		ret = PTR_ERR(qcom->resets);
>> +		dev_err(&pdev->dev, "failed to get resets, err=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = reset_control_deassert(qcom->resets);
>> +	if (ret)
>> +		goto reset_put;
>> +
>> +	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
>> +	if (ret) {
>> +		dev_err(qcom->dev, "failed to get clocks\n");
>> +		goto reset_assert;
>> +	}
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qscratch");
>> +	qcom->qscratch_base = devm_ioremap_resource(qcom->dev, res);
>> +	if (IS_ERR(qcom->qscratch_base)) {
>> +		dev_err(qcom->dev, "failed to map qscratch - %d\n", ret);
>> +		ret = PTR_ERR(qcom->qscratch_base);
>> +		goto clk_disable;
>> +	}
>> +
>> +	irq = platform_get_irq_byname(pdev, "hs_phy_irq");
>> +	if (irq > 0) {
>> +		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					"qcom_dwc3 HS", qcom);
>> +		if (ret) {
>> +			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
>> +			goto clk_disable;
>> +		}
>> +	}
>> +
>> +	irq = platform_get_irq_byname(pdev, "dp_hs_phy_irq");
>> +	if (irq > 0) {
>> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> why do you need to set this flag?
These wakeup_irqs should be enabled only during suspend. With this flag I
don't need to disable irq immediately after requesting it.

>
>> +		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					"qcom_dwc3 DP_HS", qcom);
> this is the same as devm_request_irq()
I am passing hard_irq handler as NULL whereas thread_fn is not NULL.
devm_request_irq is just the opposite.


>
>> +		if (ret) {
>> +			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
>> +			goto clk_disable;
>> +		}
>> +		qcom->dp_hs_phy_irq = irq;
>> +	}
>> +
>> +	irq = platform_get_irq_byname(pdev, "dm_hs_phy_irq");
>> +	if (irq > 0) {
>> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> +		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					"qcom_dwc3 DM_HS", qcom);
>> +		if (ret) {
>> +			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
>> +			goto clk_disable;
>> +		}
>> +		qcom->dm_hs_phy_irq = irq;
>> +	}
>> +
>> +	irq = platform_get_irq_byname(pdev, "ss_phy_irq");
>> +	if (irq > 0) {
>> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> +		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>> +					qcom_dwc3_resume_irq,
>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +					"qcom_dwc3 SS", qcom);
>> +		if (ret) {
>> +			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
>> +			goto clk_disable;
>> +		}
>> +		qcom->ss_phy_irq = irq;
>> +	}
>> +
>> +	dwc3_np = of_get_child_by_name(np, "dwc3");
>> +	if (!dwc3_np) {
>> +		dev_err(qcom->dev, "failed to find dwc3 core child\n");
>> +		ret = -ENODEV;
>> +		goto clk_disable;
>> +	}
>> +
>> +	/*
>> +	 * Disable pipe_clk requirement if specified. Used when dwc3
>> +	 * operates without SSPHY and only HS/FS/LS modes are supported.
>> +	 */
>> +	ignore_pipe_clk = device_property_read_bool(qcom->dev,
>> +				"qcom,select-utmi-as-pipe-clk");
>> +	if (ignore_pipe_clk)
>> +		dwc3_qcom_select_utmi_clk(qcom);
>> +
>> +	ret = of_platform_populate(np, NULL, NULL, qcom->dev);
>> +	if (ret) {
>> +		dev_err(qcom->dev, "failed to register dwc3 core - %d\n", ret);
>> +		goto clk_disable;
>> +	}
>> +
>> +	qcom->dwc3 = of_find_device_by_node(dwc3_np);
>> +	if (!qcom->dwc3) {
>> +		dev_err(&pdev->dev, "failed to get dwc3 platform device\n");
>> +		goto depopulate;
>> +	}
>> +
>> +	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
>> +
>> +	/* register extcon to override vbus later on mode switch */
>> +	if (qcom->mode == USB_DR_MODE_OTG) {
>> +		ret = dwc3_qcom_register_extcon(qcom);
>> +		if (ret)
>> +			goto depopulate;
>> +	} else if (qcom->mode == USB_DR_MODE_PERIPHERAL) {
>> +		/* enable vbus override for device mode */
>> +		dwc3_qcom_vbus_overrride_enable(qcom, true);
>> +	}
>> +
>> +	device_init_wakeup(&pdev->dev, 1);
>> +	qcom->is_suspended = false;
>> +	pm_runtime_set_active(qcom->dev);
>> +	pm_runtime_enable(qcom->dev);
>> +
>> +	return 0;
>> +
>> +depopulate:
>> +	of_platform_depopulate(&pdev->dev);
>> +clk_disable:
>> +	for (i = qcom->num_clocks - 1; i >= 0; i--) {
>> +		clk_disable_unprepare(qcom->clks[i]);
>> +		clk_put(qcom->clks[i]);
>> +	}
>> +reset_assert:
>> +	reset_control_assert(qcom->resets);
>> +reset_put:
>> +	reset_control_put(qcom->resets);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dwc3_qcom_remove(struct platform_device *pdev)
>> +{
>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>> +	struct device *dev = qcom->dev;
>> +	int i;
>> +
>> +	of_platform_depopulate(&pdev->dev);
>> +
>> +	for (i = qcom->num_clocks - 1; i >= 0; i--) {
>> +		clk_disable_unprepare(qcom->clks[i]);
>> +		clk_put(qcom->clks[i]);
>> +	}
>> +	qcom->num_clocks = 0;
>> +
>> +	reset_control_assert(qcom->resets);
>> +	reset_control_put(qcom->resets);
>> +
>> +	pm_runtime_disable(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int dwc3_qcom_pm_suspend(struct device *dev)
>> +{
>> +	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
>> +	int ret = 0;
>> +
>> +	dev_err(dev, "dwc3-qcom PM suspend\n");
> why an error message here? There's no error. Remove this, it's unnecessary.
That is by mistake. I wanted a dev_dbg here. As you suggested I can just
remove this and following error messages.

>
>> +	ret = dwc3_qcom_suspend(qcom);
>> +	if (!ret)
>> +		qcom->pm_suspended = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static int dwc3_qcom_pm_resume(struct device *dev)
>> +{
>> +	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	dev_err(dev, "dwc3-qcom PM resume\n");
> ditto
>
>> +	ret = dwc3_qcom_resume(qcom);
>> +	if (!ret)
>> +		qcom->pm_suspended = false;
>> +
>> +	return ret;
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +static int dwc3_qcom_runtime_suspend(struct device *dev)
>> +{
>> +	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
>> +
>> +	dev_err(dev, "DWC3-qcom runtime suspend\n");
> ditto
>
>> +	return dwc3_qcom_suspend(qcom);
>> +}
>> +
>> +static int dwc3_qcom_runtime_resume(struct device *dev)
>> +{
>> +	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
>> +
>> +	dev_err(dev, "DWC3-qcom runtime resume\n");
> ditto
>
>> +	return dwc3_qcom_resume(qcom);
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_qcom_pm_suspend, dwc3_qcom_pm_resume)
>> +	SET_RUNTIME_PM_OPS(dwc3_qcom_runtime_suspend, dwc3_qcom_runtime_resume,
>> +			   NULL)
> why don't you have runtime_idle?

I didn't see any need for that. rpm_idle will invoke rpm_suspend if idle callback
is not specified.

>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

