Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2930626-1520939318-2-11319288318556515828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520939317; b=RA+xwZ6NRqIAM0BqhBIzp1Wj7aWUiema7R6k1AiDWRqfafG
    iXthfWoTD+KDpluuiS9ckFHBBwjyrNWfm//17YPpG1Lrfd4+sZ9Lw4sqs4j6bM0J
    o8PuNqzaGzb5LJmUCLGYAPLns2OQaWkNCYYaCC5Za5Ejc1i9Z2RU31aHxcUOmE+2
    rKvsDbL+Q6xc9vTIomR/+Pyhd690TkDK472Wwq5Y+u01uM9nRUwqQYyBPuSI7VS2
    xYbvRyaO2xzyuCnSgOQYwslH+1O+qYMrto0eqdqdxWTj32Eakq/80Q4Z2U4fF/0N
    EuUB5s7AFzh64cCMhU8YK9ixdBRX2QEm74CFfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520939317; bh=bdkgHw1AsDtP3uRlOU1mx3nuJn8/TbNpxPYOvJ
    gX5c0=; b=jV6LCuFmlNnvQLvzH9bBAw6qgRO+ZiZGmu5z851pjTkytR7nMlBRgS
    +qUeMJxvrHkASA38xbYmHLJz9LxiUEeWAd8cDmVkVExi+kNYakw8qkpCxHcBN/df
    /YzSjKiAfyUQ9/XEXFdFkoP9qFFz5ykfr3HGwrE7YlQWYuSrNHNUQAi1AHEgKrci
    zZq2ntay59RVfDuFJM3cpiUmrt7IpmPLI7mlunMVZl0JiQo+7/osPDKqCW6Yz10t
    YmcC14dxMWhtiTGQt2YPoRpj10qXkrGQSZwY3pM1ab4MN8si2TwPImYW1rdqHVpm
    ozZhfEXqteUPTr7c6lKmyapoNwOvOH/A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeCMLIf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 07:08:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:64240 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbeCMLId (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 13 Mar 2018 07:08:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="asc'?scan'208";a="182240708"
From: Felipe Balbi <balbi@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] usb: dwc3: Add Qualcomm DWC3 glue driver
In-Reply-To: <1520937362-28777-2-git-send-email-mgautam@codeaurora.org>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org> <1520937362-28777-2-git-send-email-mgautam@codeaurora.org>
Date: Tue, 13 Mar 2018 13:08:14 +0200
Message-ID: <878taw8c81.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

+Andy

Manu Gautam <mgautam@codeaurora.org> writes:
> DWC3 controller on Qualcomm SOCs has a Qscratch wrapper.
> Some of its uses are described below resulting in need to
> have a separate glue driver instead of using dwc3-of-simple:
>  - It exposes register interface to override vbus-override
>    and lane0-pwr-present signals going to hardware. These
>    must be updated in peripheral mode for DWC3 if vbus lines
>    are not connected to hardware block. Otherwise RX termination
>    in SS mode or DP pull-up is not applied by device controller.

right, core needs to know that VBUS is above 4.4V. Why wasn't this a
problem when the original glue layer was first published?

>  - pwr_events_irq_stat support to ensure USB2 PHY is in L2 state
>    before glue driver can turn-off clocks and suspend PHY.

Core manages PHY suspend automatically. Isn't that working for you? Why?

>  - Support for wakeup interrupts lines that are asserted whenever
>    there is any wakeup event on USB3 or USB2 bus.

ok

>  - Support to replace pip3 clock going to DWC3 with utmi clock
>    for hardware configuration where SSPHY is not used with DWC3.

Is that SW configurable? Really? In any case seems like this and SESSVLD
valid should be handled using Hans' and Heikki's mux support.

> Other than above hardware features in Qscratch wrapper there
> are some limitations on QCOM SOCs that require special handling
> of power management e.g. suspending PHY using GUSB2PHYCFG
> register and ensuring PHY enters L2 before turning off clocks etc.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/usb/dwc3/Kconfig          |  11 +
>  drivers/usb/dwc3/Makefile         |   1 +
>  drivers/usb/dwc3/dwc3-of-simple.c |   1 -
>  drivers/usb/dwc3/dwc3-qcom.c      | 635 ++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 647 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/dwc3/dwc3-qcom.c
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index ab8c0e0..f5bb4f1 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -106,4 +106,15 @@ config USB_DWC3_ST
>  	  inside (i.e. STiH407).
>  	  Say 'Y' or 'M' if you have one such device.
>=20=20
> +config USB_DWC3_QCOM
> +	tristate "Qualcomm Platform"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on OF
> +	default USB_DWC3
> +	help
> +	  Some Qualcomm SoCs use DesignWare Core IP for USB2/3
> +	  functionality.
> +
> +	  Say 'Y' or 'M' if you have one such device.
> +
>  endif
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index 7ac7250..c3ce697 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -48,3 +48,4 @@ obj-$(CONFIG_USB_DWC3_PCI)		+=3D dwc3-pci.o
>  obj-$(CONFIG_USB_DWC3_KEYSTONE)		+=3D dwc3-keystone.o
>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+=3D dwc3-of-simple.o
>  obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
> +obj-$(CONFIG_USB_DWC3_QCOM)		+=3D dwc3-qcom.o
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of=
-simple.c
> index cb2ee96..0fd0e8e 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -208,7 +208,6 @@ static int dwc3_of_simple_runtime_resume(struct devic=
e *dev)
>  };
>=20=20
>  static const struct of_device_id of_dwc3_simple_match[] =3D {
> -	{ .compatible =3D "qcom,dwc3" },
>  	{ .compatible =3D "rockchip,rk3399-dwc3" },
>  	{ .compatible =3D "xlnx,zynqmp-dwc3" },
>  	{ .compatible =3D "cavium,octeon-7130-usb-uctl" },
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> new file mode 100644
> index 0000000..917199e
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -0,0 +1,635 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + * Inspired by dwc3-of-simple.c
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/clk.h>
> +#include <linux/irq.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/extcon.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/usb/of.h>
> +#include <linux/reset.h>
> +#include <linux/iopoll.h>
> +
> +#include "core.h"
> +#include "io.h"

you must be kidding, right? There's no way I'm gonna let a glue poke at
core registers.

> +static void dwc3_qcom_suspend_hsphy(struct dwc3_qcom *qcom)
> +{
> +	struct dwc3	*dwc =3D platform_get_drvdata(qcom->dwc3);
> +	int		ret;
> +	u32		val;
> +
> +	/* Clear previous L2 events */
> +	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
> +			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> +
> +	/* Allow controller to suspend HSPHY */
> +	val =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +	val |=3D  DWC3_GUSB2PHYCFG_ENBLSLPM | DWC3_GUSB2PHYCFG_SUSPHY;
> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), val);

core should handle PHY bits. In any case, why don't you let core handle
PHY suspend? It handles it automatically for us, there should be no need
for SW intervention.

> +static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
> +{
> +	struct dwc3	*dwc =3D platform_get_drvdata(qcom->dwc3);

nope! Glue shouldn't touch dwc3 at all.

> +	int		 i;
> +
> +	if (qcom->is_suspended)
> +		return 0;
> +
> +	if (!dwc)
> +		return -EBUSY;

=2DENODEV?

> +	dwc3_qcom_suspend_hsphy(qcom);
> +
> +	if (dwc->usb2_generic_phy)
> +		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> +	if (dwc->usb3_generic_phy)
> +		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);

core.c should do this.

> +	/* Disable HSPHY auto suspend */
> +	val =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +	val &=3D ~(DWC3_GUSB2PHYCFG_ENBLSLPM | DWC3_GUSB2PHYCFG_SUSPHY);
> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), val);
> +
> +	qcom->is_suspended =3D false;
> +
> +	dev_dbg(qcom->dev, "DWC3 exited from low power mode\n");

no dev_dbg() or dev_info() in this driver.

> +static irqreturn_t qcom_dwc3_resume_irq(int irq, void *data)
> +{
> +	struct dwc3_qcom *qcom =3D data;
> +	struct dwc3	*dwc =3D platform_get_drvdata(qcom->dwc3);
> +
> +	/* If pm_suspended then let pm_resume take care of resuming h/w */
> +	if (qcom->pm_suspended)
> +		return IRQ_HANDLED;
> +
> +	dwc3_qcom_resume(qcom);

instead, why don't you pm_runtime_resume() here, and let runtime_resume()
handle dwc3_qcom_resume() ?

> +static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
> +{
> +	struct device		*dev =3D qcom->dev;
> +	struct device_node	*np =3D dev->of_node;
> +	int			i;
> +
> +	qcom->num_clocks =3D count;
> +
> +	if (!count)
> +		return 0;
> +
> +	qcom->clks =3D devm_kcalloc(dev, qcom->num_clocks,
> +				  sizeof(struct clk *), GFP_KERNEL);
> +	if (!qcom->clks)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < qcom->num_clocks; i++) {
> +		struct clk	*clk;
> +		int		ret;
> +
> +		clk =3D of_clk_get(np, i);
> +		if (IS_ERR(clk)) {
> +			while (--i >=3D 0)
> +				clk_put(qcom->clks[i]);
> +			return PTR_ERR(clk);
> +		}
> +
> +		ret =3D clk_prepare_enable(clk);
> +		if (ret < 0) {
> +			while (--i >=3D 0) {
> +				clk_disable_unprepare(qcom->clks[i]);
> +				clk_put(qcom->clks[i]);
> +			}
> +			clk_put(clk);
> +
> +			return ret;
> +		}
> +
> +		qcom->clks[i] =3D clk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dwc3_qcom_probe(struct platform_device *pdev)
> +{
> +	struct device_node	*np =3D pdev->dev.of_node, *dwc3_np;
> +	struct dwc3_qcom	*qcom;
> +	struct resource		*res;
> +	int			irq, ret, i;
> +	bool			ignore_pipe_clk;
> +
> +	qcom =3D devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
> +	if (!qcom)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, qcom);
> +	qcom->dev =3D &pdev->dev;
> +
> +	qcom->resets =3D of_reset_control_array_get_optional_exclusive(np);
> +	if (IS_ERR(qcom->resets)) {
> +		ret =3D PTR_ERR(qcom->resets);
> +		dev_err(&pdev->dev, "failed to get resets, err=3D%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D reset_control_deassert(qcom->resets);
> +	if (ret)
> +		goto reset_put;
> +
> +	ret =3D dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
> +	if (ret) {
> +		dev_err(qcom->dev, "failed to get clocks\n");
> +		goto reset_assert;
> +	}
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qscratch");
> +	qcom->qscratch_base =3D devm_ioremap_resource(qcom->dev, res);
> +	if (IS_ERR(qcom->qscratch_base)) {
> +		dev_err(qcom->dev, "failed to map qscratch - %d\n", ret);
> +		ret =3D PTR_ERR(qcom->qscratch_base);
> +		goto clk_disable;
> +	}
> +
> +	irq =3D platform_get_irq_byname(pdev, "hs_phy_irq");
> +	if (irq > 0) {
> +		ret =3D devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"qcom_dwc3 HS", qcom);
> +		if (ret) {
> +			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
> +			goto clk_disable;
> +		}
> +	}
> +
> +	irq =3D platform_get_irq_byname(pdev, "dp_hs_phy_irq");
> +	if (irq > 0) {
> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);

why do you need to set this flag?

> +		ret =3D devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"qcom_dwc3 DP_HS", qcom);

this is the same as devm_request_irq()

> +		if (ret) {
> +			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
> +			goto clk_disable;
> +		}
> +		qcom->dp_hs_phy_irq =3D irq;
> +	}
> +
> +	irq =3D platform_get_irq_byname(pdev, "dm_hs_phy_irq");
> +	if (irq > 0) {
> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +		ret =3D devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"qcom_dwc3 DM_HS", qcom);
> +		if (ret) {
> +			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
> +			goto clk_disable;
> +		}
> +		qcom->dm_hs_phy_irq =3D irq;
> +	}
> +
> +	irq =3D platform_get_irq_byname(pdev, "ss_phy_irq");
> +	if (irq > 0) {
> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +		ret =3D devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"qcom_dwc3 SS", qcom);
> +		if (ret) {
> +			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
> +			goto clk_disable;
> +		}
> +		qcom->ss_phy_irq =3D irq;
> +	}
> +
> +	dwc3_np =3D of_get_child_by_name(np, "dwc3");
> +	if (!dwc3_np) {
> +		dev_err(qcom->dev, "failed to find dwc3 core child\n");
> +		ret =3D -ENODEV;
> +		goto clk_disable;
> +	}
> +
> +	/*
> +	 * Disable pipe_clk requirement if specified. Used when dwc3
> +	 * operates without SSPHY and only HS/FS/LS modes are supported.
> +	 */
> +	ignore_pipe_clk =3D device_property_read_bool(qcom->dev,
> +				"qcom,select-utmi-as-pipe-clk");
> +	if (ignore_pipe_clk)
> +		dwc3_qcom_select_utmi_clk(qcom);
> +
> +	ret =3D of_platform_populate(np, NULL, NULL, qcom->dev);
> +	if (ret) {
> +		dev_err(qcom->dev, "failed to register dwc3 core - %d\n", ret);
> +		goto clk_disable;
> +	}
> +
> +	qcom->dwc3 =3D of_find_device_by_node(dwc3_np);
> +	if (!qcom->dwc3) {
> +		dev_err(&pdev->dev, "failed to get dwc3 platform device\n");
> +		goto depopulate;
> +	}
> +
> +	qcom->mode =3D usb_get_dr_mode(&qcom->dwc3->dev);
> +
> +	/* register extcon to override vbus later on mode switch */
> +	if (qcom->mode =3D=3D USB_DR_MODE_OTG) {
> +		ret =3D dwc3_qcom_register_extcon(qcom);
> +		if (ret)
> +			goto depopulate;
> +	} else if (qcom->mode =3D=3D USB_DR_MODE_PERIPHERAL) {
> +		/* enable vbus override for device mode */
> +		dwc3_qcom_vbus_overrride_enable(qcom, true);
> +	}
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +	qcom->is_suspended =3D false;
> +	pm_runtime_set_active(qcom->dev);
> +	pm_runtime_enable(qcom->dev);
> +
> +	return 0;
> +
> +depopulate:
> +	of_platform_depopulate(&pdev->dev);
> +clk_disable:
> +	for (i =3D qcom->num_clocks - 1; i >=3D 0; i--) {
> +		clk_disable_unprepare(qcom->clks[i]);
> +		clk_put(qcom->clks[i]);
> +	}
> +reset_assert:
> +	reset_control_assert(qcom->resets);
> +reset_put:
> +	reset_control_put(qcom->resets);
> +
> +	return ret;
> +}
> +
> +static int dwc3_qcom_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_qcom *qcom =3D platform_get_drvdata(pdev);
> +	struct device *dev =3D qcom->dev;
> +	int i;
> +
> +	of_platform_depopulate(&pdev->dev);
> +
> +	for (i =3D qcom->num_clocks - 1; i >=3D 0; i--) {
> +		clk_disable_unprepare(qcom->clks[i]);
> +		clk_put(qcom->clks[i]);
> +	}
> +	qcom->num_clocks =3D 0;
> +
> +	reset_control_assert(qcom->resets);
> +	reset_control_put(qcom->resets);
> +
> +	pm_runtime_disable(dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dwc3_qcom_pm_suspend(struct device *dev)
> +{
> +	struct dwc3_qcom *qcom =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	dev_err(dev, "dwc3-qcom PM suspend\n");

why an error message here? There's no error. Remove this, it's unnecessary.

> +	ret =3D dwc3_qcom_suspend(qcom);
> +	if (!ret)
> +		qcom->pm_suspended =3D true;
> +
> +	return ret;
> +}
> +
> +static int dwc3_qcom_pm_resume(struct device *dev)
> +{
> +	struct dwc3_qcom *qcom =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_err(dev, "dwc3-qcom PM resume\n");

ditto

> +	ret =3D dwc3_qcom_resume(qcom);
> +	if (!ret)
> +		qcom->pm_suspended =3D false;
> +
> +	return ret;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM
> +static int dwc3_qcom_runtime_suspend(struct device *dev)
> +{
> +	struct dwc3_qcom *qcom =3D dev_get_drvdata(dev);
> +
> +	dev_err(dev, "DWC3-qcom runtime suspend\n");

ditto

> +	return dwc3_qcom_suspend(qcom);
> +}
> +
> +static int dwc3_qcom_runtime_resume(struct device *dev)
> +{
> +	struct dwc3_qcom *qcom =3D dev_get_drvdata(dev);
> +
> +	dev_err(dev, "DWC3-qcom runtime resume\n");

ditto

> +	return dwc3_qcom_resume(qcom);
> +}
> +#endif
> +
> +static const struct dev_pm_ops dwc3_qcom_dev_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_qcom_pm_suspend, dwc3_qcom_pm_resume)
> +	SET_RUNTIME_PM_OPS(dwc3_qcom_runtime_suspend, dwc3_qcom_runtime_resume,
> +			   NULL)

why don't you have runtime_idle?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqnsR4ACgkQzL64meEa
mQaM2hAAtpcjjx2FtDuNsiIx7EMT84EnJjt6o60odgNAvg3GwaxFMR405mpskyUf
EbBSAuMI3CGQyBjB/zHigZdco5KTpVnFMu5ksFaAcZVP1JGmqWsGN6JVOkk9KEv9
42HZhawXDOzzc7BlJ1scoegomjx/sByIGfHtLFHGeG3idexSEKbd8oUG87mwwBM2
ldT5RNwKb+VLyIdCssdnbbJoZ0ZXC7ESXMfQ4DbSGzWaD0KTKXHCOh/cJdceuAJq
TjC7c1YDQFbTJDSoepk4LkH3h90xEpPVtTokh5pz9MMRmyZDer7AkVW51uzKNi9b
J6uRCPmvPjX+CkHtbS7L/vVOEowQy7TxwPA+ZMKyYvdxzrJx/KSCbe3Irx8tSB0E
Lkkre3a9/rhtrBvQ5MW5jvkh00Hv1JPxjVh99ZZBUQ0Zb7mPWZYA3j7eSDGofMOz
NZml3hi05jGqtrXqQduHU0UwcXQbfbBQY+VThYOyaKlG8cBV8t4fISJXaaAP/2lO
C/cBnXAKokmKkOL9+p0YRVUp67KLJZNtoEbvvUjX/sA/MSTW9Y0OPBFganTJTXZ/
UlK5W7AJ7UIvlx0rPipiPmam0AyE1uSgaVWPzfWJeaY5Hu9aHKWiC4PnnZ576viP
lo6Z65BK6wEBlvfmA1zdC9rcPQtsqsuLuxnu7t6KIU0l/Kc8UZY=
=LJgf
-----END PGP SIGNATURE-----
--=-=-=--
