Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C651ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FB52154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gpgtez+H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dk8wqZHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FB52154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391382AbeIVBby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:31:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391102AbeIVBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:31:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 456B76127B; Fri, 21 Sep 2018 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537558892;
        bh=DJBUU57zgr0OF/OI0jwtjVAwxqAoyU1SXp+SiTCXZ2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gpgtez+H49+14pOM0oKhHBE/sVu4/4mDTXTtq/67Y2CTzVo+MIylMtWjbddfZT0V9
         8teEd634A1DvnkxKvLzP5wMHX6IP2VX/DCYzE/h4nt63tAvBV9q2+Uc62TiF1BmN2E
         P292V/Rq3k3HO6voSZwQilkMTMkY7w1bCvXTU5m4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 03E97611AC;
        Fri, 21 Sep 2018 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537558891;
        bh=DJBUU57zgr0OF/OI0jwtjVAwxqAoyU1SXp+SiTCXZ2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dk8wqZHOK7Z9mVFPdyS5alGOYZAOJoDRHrcbRhjc+cfOtYMdfL1GSilgm6btLWZwP
         T7JWpt3hH6kyXdKJKkcHWjs63I+o9soAn5/jbZh84h0hLcWCkrNG0JyQVSBNJzCOIO
         DkZEuuyj68DKTpV3L9Xtxo6b2HFZmP9tc00pfGYk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 22 Sep 2018 01:11:30 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] remoteproc: qcom: Introduce Non-PAS ADSP PIL
 driver
In-Reply-To: <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
 <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
Message-ID: <a93b3178a09584dc0b4bed55ca4816a3@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

On 2018-09-03 17:22, Rohit kumar wrote:
> This adds Non PAS ADSP PIL driver for Qualcomm
> Technologies Inc SoCs.
> Added initial support for SDM845 with ADSP bootup and
> shutdown operation handled from Application Processor
> SubSystem(APSS).
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
....
> +	select QCOM_MDT_LOADER
> +	select QCOM_Q6V5_COMMON
> +	select QCOM_RPROC_COMMON
> +	help
> +	  Say y here to support the Peripherial Image Loader

replace Peripherial/Peripheral.
....
> +#include <linux/clk.h>
> +#include <linux/firmware.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/reset.h>
> +#include <linux/iopoll.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/smem_state.h>
> +

The headers should be in alphabetical order.

....
> +	struct reset_control *pdc_sync_reset;
> +	struct reset_control *cc_lpass_restart;
> +
> +	struct regmap *halt_map;
> +	unsigned int  halt_lpass;

remove the double spaces above.
....
> +	if (ret || val)
> +		goto reset;
> +
> +	regmap_write(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_HALTREQ_REG, 1);
> +
> +	/*  Wait for halt ACK from QDSP6 */

Minor nit, please remove the double spaces in the comment above.

> +	timeout = jiffies + msecs_to_jiffies(ACK_TIMEOUT);
> +	for (;;) {
> +		ret = regmap_read(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_HALTACK_REG, &val);
> +		if (ret || val || time_after(jiffies, timeout))
> +			break;
> +
> +		udelay(1000);

According to Documentation/timers/timers-howto.txt please use 
usleep_range()
when the delay range is between(10us - 20ms).

> +	}
> +
> +	ret = regmap_read(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_MASTER_IDLE_REG, &val);
....
> +	/* wait after asserting subsystem restart from AOSS */
> +	udelay(200);

ditto

> +
> +	/* Clear the halt request for the AXIM and AHBM for Q6 */
> +	regmap_write(adsp->halt_map, adsp->halt_lpass + LPASS_HALTREQ_REG, 
> 0);
> +
> +	/* De-assert the LPASS PDC Reset */
> +	reset_control_deassert(adsp->pdc_sync_reset);
> +	/* Remove the LPASS reset */
> +	reset_control_deassert(adsp->cc_lpass_restart);
> +	/* wait after de-asserting subsystem restart from AOSS */
> +	udelay(200);

ditto

> +
> +	return 0;
> +}
....
> +static int adsp_start(struct rproc *rproc)
> +{
> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	int ret;
> +	unsigned int val;
> +
> +	qcom_q6v5_prepare(&adsp->q6v5);
> +
> +	ret = clk_prepare_enable(adsp->xo);
> +	if (ret)
> +		return ret;

please call qcom_q6v5_unprepare on clk_prepare_enable failure to 
disable_irqs

> +
> +	dev_pm_genpd_set_performance_state(adsp->dev, INT_MAX);
> +	ret = pm_runtime_get_sync(adsp->dev);
> +	if (ret)
> +		goto disable_xo_clk;
> +
....
> +static int adsp_init_reset(struct qcom_adsp *adsp)
> +{
> +	adsp->pdc_sync_reset = devm_reset_control_get_exclusive(adsp->dev,
> +			"pdc_sync");
> +	if (IS_ERR(adsp->pdc_sync_reset)) {
> +		dev_err(adsp->dev, "failed to acquire pdc_sync reset\n");
> +		return PTR_ERR(adsp->pdc_sync_reset);
> +	}

Bjorn, should we return EPROBE_DEFER here since PDC global reset 
controller can be a module?

> +
> +	adsp->cc_lpass_restart = devm_reset_control_get_exclusive(adsp->dev,
> +			"cc_lpass");
> +	if (IS_ERR(adsp->cc_lpass_restart)) {
> +		dev_err(adsp->dev, "failed to acquire cc_lpass restart\n");
> +		return PTR_ERR(adsp->cc_lpass_restart);
> +	}
> +
> +	return 0;
....
> +static int adsp_remove(struct platform_device *pdev)
> +{
> +	struct qcom_adsp *adsp = platform_get_drvdata(pdev);
> +
> +	rproc_del(adsp->rproc);
> +
> +	qcom_remove_glink_subdev(adsp->rproc, &adsp->glink_subdev);
> +	qcom_remove_sysmon_subdev(adsp->sysmon);
> +	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
> +	rproc_free(adsp->rproc);
> +	pm_runtime_disable(adsp->dev);
> +

rmmod of the driver resulted in the following kernel panic:
having a pm_runtime_disable after rproc_free seems to be the cause of 
the kernel panic.
Please call pm_runtime_disable before rproc_free.

do_raw_spin_lock+0x28/0x118
__raw_spin_lock_irq+0x30/0x3c
__pm_runtime_disable+0x28/0xf4
adsp_remove+0x4c/0x5c [qcom_adsp_pil]
platform_drv_remove+0x28/0x50
device_release_driver_internal+0x124/0x1c8
driver_detach+0x44/0x80
bus_remove_driver+0x78/0x9c
driver_unregister+0x34/0x54
platform_driver_unregister+0x1c/0x28
cleanup_module+0x14/0x6bc [qcom_adsp_pil]
SyS_delete_module+0x1c4/0x214

> +	return 0;
> +}
> +
> +static const struct adsp_pil_data adsp_resource_init = {
> +	.crash_reason_smem = 423,
> +	.firmware_name = "adsp.mdt",
> +	.ssr_name = "lpass",
> +	.sysmon_name = "adsp",
> +	.ssctl_id = 0x14,
> +};
....
> +module_platform_driver(adsp_pil_driver);
> +MODULE_DESCRIPTION("QTi SDM845 ADSP Peripherial Image Loader");

replace QTi/QTI and Peripherial/Peripheral.

....
Also I see the following warns on stopping the adsp remoteproc, couldn't 
root cause it though:
  device_del+0x84/0x29c
  platform_device_del+0x2c/0x88
  platform_device_unregister+0x1c/0x30
  of_platform_device_destroy+0x98/0xa8
  device_for_each_child+0x54/0xa4
  of_platform_depopulate+0x38/0x54
  q6asm_remove+0x1c/0x2c
  apr_device_remove+0x38/0x70
  device_release_driver_internal+0x124/0x1c8
  device_release_driver+0x24/0x30
  bus_remove_device+0xcc/0xe4
  device_del+0x1f8/0x29c
  device_unregister+0x1c/0x30
  apr_remove_device+0x1c/0x2c
  device_for_each_child+0x54/0xa4
  apr_remove+0x28/0x34
  rpmsg_dev_remove+0x48/0x70
  device_release_driver_internal+0x124/0x1c8
  device_release_driver+0x24/0x30
  bus_remove_device+0xcc/0xe4
  device_del+0x1f8/0x29c
  device_unregister+0x1c/0x30
  qcom_glink_remove_device+0x1c/0x2c
  device_for_each_child+0x54/0xa4
  qcom_glink_native_remove+0x54/0x15c
  qcom_glink_smem_unregister+0x1c/0x30
  glink_subdev_stop+0x1c/0x2c [qcom_common]
  rproc_stop+0x40/0xc0
  rproc_shutdown+0x6c/0xc0
  rproc_del+0x28/0xa0
  adsp_remove+0x20/0x5c [qcom_adsp_pil]
  platform_drv_remove+0x28/0x50
  device_release_driver_internal+0x124/0x1c8
  driver_detach+0x44/0x80
  bus_remove_driver+0x78/0x9c
  driver_unregister+0x34/0x54
  platform_driver_unregister+0x1c/0x28
  cleanup_module+0x14/0x6bc [qcom_adsp_pil]
  SyS_delete_module+0x1c4/0x214

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
