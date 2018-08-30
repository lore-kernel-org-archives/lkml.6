Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC7FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C9920834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jblO/aQm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MFdtwCeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C9920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeH3SSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:18:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbeH3SSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:18:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7962F606DD; Thu, 30 Aug 2018 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535638585;
        bh=xVB8Tj60+0mxk0+wrnknOtSEZb8KZ3tP4S0U+Ml5I7s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jblO/aQmzg64cnzfG7MSEXW6L51UMrETb9VqMGyzqB/HjWPlBPfCW35a7cAMbgBAM
         odzYzwgmLIXpUHk0iGC5Zo/l3Z8ovS8LuWdDNzLi7nHUVfFxPKRPo52TLxCl2X3hWE
         r22y44VUvLeTx+gw7x1/WJgteBM6WJX/uAinZ+b8=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FF3760445;
        Thu, 30 Aug 2018 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535638583;
        bh=xVB8Tj60+0mxk0+wrnknOtSEZb8KZ3tP4S0U+Ml5I7s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MFdtwCeX0eZWhDBo6CNw8SkOwhuzSyYWV8kspHIF9iaE8HVsFuNLGL8iV/HbQrwN0
         GnhGWmciNRMukTVhV3LsQoDOETCfulVU+JaHyNeHDSL1LX1BGwl9q74tBNKCcD7TZG
         Mx19YLwUh77hsCSGceyTfM07JFEQfj4Ft3BO8bU8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FF3760445
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v2] remoteproc: qcom: Introduce Non-PAS ADSP PIL driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        sbpata@codeaurora.org
References: <1530264053-8394-1-git-send-email-rohitkr@codeaurora.org>
 <20180828060943.GI5090@builder>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <47e4e6f6-212d-124d-66b7-eaf3b579261c@codeaurora.org>
Date:   Thu, 30 Aug 2018 19:46:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828060943.GI5090@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for reviewing the patch.


On 8/28/2018 11:39 AM, Bjorn Andersson wrote:
> On Fri 29 Jun 02:20 PDT 2018, Rohit kumar wrote:
>
>> This adds APSS based ADSP PIL driver for QCOM SoCs.
>> Added initial support for SDM845 with ADSP bootup and
>> shutdown operation handled from Application Processor
>> SubSystem(APSS).
>>
> Hi Rohit,
>
> I've submitted a patch that renames the PAS based adsp driver, please
> rebase your patch upon this.

Sure.
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>> Changes since v1:
>> - Used APIs from qcom_q6v5.c
>> - Use clock, reset and regmap driver APIs instead of
>>    directly writing into the LPASS registers.
>> - Created new file for non PAS ADSP PIL instead of extending
>>    existing ADSP PIL driver.
>> - cleanups as suggested by Bjorn and Rob.
>>
>>   .../bindings/remoteproc/qcom,non-pas-adsp.txt      | 138 +++++
>>   drivers/remoteproc/Kconfig                         |  18 +
>>   drivers/remoteproc/Makefile                        |   1 +
>>   drivers/remoteproc/qcom_nonpas_adsp_pil.c          | 667 +++++++++++++++++++++
>>   4 files changed, 824 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
>>   create mode 100644 drivers/remoteproc/qcom_nonpas_adsp_pil.c
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
>> new file mode 100644
>> index 0000000..0581aaa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
> qcom,adsp-pil.txt
>
>> @@ -0,0 +1,138 @@
>> +Qualcomm Technology Inc. Non PAS ADSP Peripheral Image Loader
>> +
>> +This document defines the binding for a component that loads and boots firmware
>> +on the Qualcomm Technology Inc. ADSP Hexagon core.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be one of:
>> +		    "qcom,sdm845-apss-adsp-pil"
> "qcom,sdm845-adsp-pil"

ok
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the qdsp6ss
>> +
>> +- reg-names:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qdsp6ss"
> No need for reg-names when we have a single reg.

ok
>> +
>> +- interrupts-extended:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must list the watchdog, fatal IRQs ready, handover and
>> +		    stop-ack IRQs
>> +
> [..]
>> +
>> += EXAMPLE
>> +The following example describes the resources needed to boot control the
>> +ADSP, as it is found on SDM845 boards.
>> +	adsp-pil {
>> +		compatible = "qcom,sdm845-apss-adsp-pil";
>> +
>> +		reg = <0x17300000 0x40c>;
>> +		reg-names = "qdsp6ss";
>> +
>> +		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
>> +			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> +		interrupt-names = "wdog", "fatal", "ready",
>> +			"handover", "stop-ack";
>> +
>> +		clocks = <&clock_rpmh RPMH_CXO_CLK>,
>> +			<&lpasscc GCC_LPASS_SWAY_CLK>,
>> +			<&lpasscc LPASS_AUDIO_WRAPPER_AON_CLK>,
>> +			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
>> +			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
>> +			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
>> +			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
>> +			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
>> +		clock-names = "xo", "sway_cbcr", "lpass_aon",
>> +			"lpass_ahbs_aon_cbcr",
>> +			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
>> +			"qdsp6ss_sleep", "qdsp6ss_core";
>> +
>> +		cx-supply = <&pm8998_s9_level>;
> If this is a corner you should use the power-domain reference to the
> appropriate rpmhpd resource.

ok, will update it in next patchset
>> +
>> +		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
>> +			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
>> +		reset-names = "pdc_sync", "cc_lpass";
>> +
>> +		qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
>> +
>> +		memory-region = <&pil_adsp_mem>;
>> +
>> +		qcom,smem-states = <&adsp_smp2p_out 0>;
>> +		qcom,smem-state-names = "stop";
>> +	};
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 0dde375..9de0a53 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -100,6 +100,24 @@ config QCOM_ADSP_PIL
>>   	  Say y here to support the TrustZone based Peripherial Image Loader
>>   	  for the Qualcomm ADSP remote processors.
>>   
>> +config QCOM_NON_PAS_ADSP_PIL
> QCOM_ADSP_PIL

ok
>
> [..]
>> diff --git a/drivers/remoteproc/qcom_nonpas_adsp_pil.c b/drivers/remoteproc/qcom_nonpas_adsp_pil.c
>> new file mode 100644
>> index 0000000..826d3d4
>> --- /dev/null
>> +++ b/drivers/remoteproc/qcom_nonpas_adsp_pil.c
> Now qcom_adsp_pil.c

Yup
> [..]
>> +struct qcom_adsp {
> [..]
>> +
>> +	struct qcom_rproc_glink glink_subdev;
>> +	struct qcom_rproc_subdev smd_subdev;
> We don't use smd on sdm845, so omit this until we have a user.

sure
>> +	struct qcom_rproc_ssr ssr_subdev;
>> +	struct qcom_sysmon *sysmon;
>> +};
>> +
>> +static int adsp_clk_enable(struct qcom_adsp *adsp)
>> +{
>> +	int ret;
>> +
>> +	/* Enable SWAY clock */
>> +	ret = clk_prepare_enable(adsp->gcc_sway_cbcr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable LPASS AHB AON Bus */
>> +	ret = clk_prepare_enable(adsp->lpass_audio_aon_clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable the QDSP6SS AHBM and AHBS clocks */
>> +	ret = clk_prepare_enable(adsp->lpass_ahbs_aon_cbcr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = clk_prepare_enable(adsp->lpass_ahbm_aon_cbcr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Turn on the XO clock, required to boot FSM */
>> +	ret = clk_prepare_enable(adsp->qdsp6ss_xo_cbcr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable the QDSP6SS sleep clock for the QDSP6 watchdog enablement */
>> +	ret = clk_prepare_enable(adsp->qdsp6ss_sleep_cbcr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Configure QDSP6 core CBC to enable clock */
>> +	ret = clk_prepare_enable(adsp->qdsp6ss_core_cbcr);
>> +	if (ret)
>> +		return ret;
> Can we use the clk_bulk interface instead of using this expanded form?

Yup, will update in next spin.
>> +
>> +	return ret;
>> +}
>> +
>> +static int adsp_reset(struct qcom_adsp *adsp)
>> +{
>> +	unsigned int val;
>> +	int ret = 0;
> No need to initialize ret.

ok
>> +
>> +	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
>> +	writel(0x1, adsp->qdsp6ss_base + CORE_START_REG);
>> +
>> +	/* Trigger boot FSM to start QDSP6 */
>> +	writel(0x1, adsp->qdsp6ss_base + BOOT_CMD_REG);
>> +
>> +	/* Wait for core to come out of reset */
>> +	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
>> +			val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
>> +	if (ret)
>> +		dev_err(adsp->dev, "Boot FSM failed to complete.\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_adsp_start(struct qcom_adsp *adsp)
> I don't see the reason why adsp_reset() is split out from this function,
> or why qcom_adsp_start() is split out from adsp_start.

Will combine them in next spin
>> +{
>> +	int ret;
>> +
>> +	ret = adsp_clk_enable(adsp);
>> +	if (ret) {
>> +		dev_err(adsp->dev, "adsp clk_enable failed\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Program boot address */
>> +	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
>> +
>> +	ret = adsp_reset(adsp);
>> +	if (ret)
>> +		dev_err(adsp->dev, "De-assert QDSP6 out of reset failed\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
>> +{
>> +	unsigned long timeout;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	/* Reset the retention logic */
>> +	val = readl(adsp->qdsp6ss_base + RET_CFG_REG);
>> +	val |= 0x1;
>> +	writel(val, adsp->qdsp6ss_base + RET_CFG_REG);
>> +
>> +	/* Disable QDSP6 core CBCR clock */
>> +	clk_disable_unprepare(adsp->qdsp6ss_core_cbcr);
>> +
>> +	/* Disable the QDSP6SS sleep clock */
>> +	clk_disable_unprepare(adsp->qdsp6ss_sleep_cbcr);
>> +
>> +	/* Turn off the XO clock */
>> +	clk_disable_unprepare(adsp->qdsp6ss_xo_cbcr);
>> +
>> +	/* Disable the QDSP6SS AHBM and AHBS clocks */
>> +	clk_disable_unprepare(adsp->lpass_ahbs_aon_cbcr);
>> +
>> +	clk_disable_unprepare(adsp->lpass_ahbm_aon_cbcr);
>> +
>> +	/* Disable LPASS AHB AON Bus */
>> +	clk_disable_unprepare(adsp->lpass_audio_aon_clk);
>> +
>> +	/* Disable the slave way clock to LPASS */
>> +	clk_disable_unprepare(adsp->gcc_sway_cbcr);
>> +
>> +	/* QDSP6 master port needs to be explicitly halted */
>> +	ret = regmap_read(adsp->halt_map,
>> +			adsp->halt_lpass + LPASS_PWR_ON_REG, &val);
>> +	if (ret || !val)
>> +		goto reset;
>> +
>> +	ret = regmap_read(adsp->halt_map,
>> +			adsp->halt_lpass + LPASS_MASTER_IDLE_REG,
>> +			&val);
>> +	if (ret || val)
>> +		goto reset;
>> +
>> +	regmap_write(adsp->halt_map,
>> +			adsp->halt_lpass + LPASS_HALTREQ_REG, 1);
>> +
>> +	/*  Wait for halt ACK from QDSP6 */
>> +	timeout = jiffies + msecs_to_jiffies(ACK_TIMEOUT);
>> +	for (;;) {
>> +		ret = regmap_read(adsp->halt_map,
>> +			adsp->halt_lpass + LPASS_HALTACK_REG, &val);
>> +		if (ret || val || time_after(jiffies, timeout))
>> +			break;
>> +
>> +		udelay(1000);
>> +	}
>> +
>> +	ret = regmap_read(adsp->halt_map,
>> +			adsp->halt_lpass + LPASS_MASTER_IDLE_REG, &val);
>> +	if (ret || !val)
>> +		dev_err(adsp->dev, "port failed halt\n");
>> +
>> +reset:
>> +	/* Assert the LPASS PDC Reset */
>> +	reset_control_assert(adsp->pdc_sync_reset);
>> +	/* Place the LPASS processor into reset */
>> +	reset_control_assert(adsp->cc_lpass_restart);
>> +	/* wait after asserting subsystem restart from AOSS */
>> +	udelay(200);
>> +
>> +	/* Clear the halt request for the AXIM and AHBM for Q6 */
>> +	regmap_write(adsp->halt_map, adsp->halt_lpass + LPASS_HALTREQ_REG, 0);
>> +
>> +	/* De-assert the LPASS PDC Reset */
>> +	reset_control_deassert(adsp->pdc_sync_reset);
>> +	/* Remove the LPASS reset */
>> +	reset_control_deassert(adsp->cc_lpass_restart);
>> +	/* wait after de-asserting subsystem restart from AOSS */
>> +	udelay(200);
> Is the core halted at this point?

Core is halted when we request for it by writing 1 to LPASS_HALTREQ_REG. 
After halt, we need to cleanup for next start.
>> +
>> +	return 0;
>> +}
>> +
>> +static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> +
>> +	return qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
>> +			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
>> +			     &adsp->mem_reloc);
>> +}
>> +
>> +static int adsp_start(struct rproc *rproc)
>> +{
>> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> +	int ret;
>> +
>> +	qcom_q6v5_prepare(&adsp->q6v5);
>> +
>> +	ret = clk_prepare_enable(adsp->xo);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = clk_prepare_enable(adsp->aggre2_clk);
>> +	if (ret)
>> +		goto disable_xo_clk;
> Just skip aggre2_clk for now, unless there's going to be some other
> subsystem added soon that uses it.

Ok
>> +
>> +	ret = regulator_enable(adsp->cx_supply);
>> +	if (ret)
>> +		goto disable_aggre2_clk;
>> +
>> +	ret = regulator_enable(adsp->px_supply);
>> +	if (ret)
>> +		goto disable_cx_supply;
> Skip px_supply for now.

ok
>> +
>> +	ret = qcom_adsp_start(adsp);
>> +	if (ret) {
>> +		dev_err(adsp->dev,
>> +			"failed to bootup adsp\n");
>> +		goto disable_px_supply;
>> +	}
>> +
>> +	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
> Use 5 * HZ

sure
>> +	if (ret == -ETIMEDOUT) {
>> +		dev_err(adsp->dev, "start timed out\n");
>> +		qcom_adsp_shutdown(adsp);
>> +		goto disable_px_supply;
>> +	}
>> +
>> +	return 0;
>> +
>> +disable_px_supply:
>> +	regulator_disable(adsp->px_supply);
>> +disable_cx_supply:
>> +	regulator_disable(adsp->cx_supply);
>> +disable_aggre2_clk:
>> +	clk_disable_unprepare(adsp->aggre2_clk);
>> +disable_xo_clk:
>> +	clk_disable_unprepare(adsp->xo);
>> +
>> +	return ret;
>> +}
>> +
>> +static void qcom_adsp_pil_handover(struct qcom_q6v5 *q6v5)
>> +{
>> +	struct qcom_adsp *adsp = container_of(q6v5, struct qcom_adsp, q6v5);
>> +
>> +	regulator_disable(adsp->px_supply);
>> +	regulator_disable(adsp->cx_supply);
>> +	clk_disable_unprepare(adsp->aggre2_clk);
>> +	clk_disable_unprepare(adsp->xo);
> Omit px_supply and aggre2_clk for now.

ok
>> +}
> [..]
>> +static int adsp_init_clock(struct qcom_adsp *adsp)
>> +{
>> +	int ret;
>> +
>> +	adsp->xo = devm_clk_get(adsp->dev, "xo");
>> +	if (IS_ERR(adsp->xo)) {
>> +		ret = PTR_ERR(adsp->xo);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(adsp->dev, "failed to get xo clock");
>> +		return ret;
>> +	}
>> +
>> +	if (adsp->has_aggre2_clk) {
> Omit this for now.

ok
>> +		adsp->aggre2_clk = devm_clk_get(adsp->dev, "aggre2");
>> +		if (IS_ERR(adsp->aggre2_clk)) {
>> +			ret = PTR_ERR(adsp->aggre2_clk);
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(adsp->dev,
>> +						"failed to get aggre2 clock");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	adsp->gcc_sway_cbcr = devm_clk_get(adsp->dev, "sway_cbcr");
> Use the clk_bulk api to acquire the rest of these clocks.
okay
>> +	if (IS_ERR(adsp->gcc_sway_cbcr)) {
>> +		ret = PTR_ERR(adsp->xo);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(adsp->dev, "failed to get gcc_sway clock\n");
>> +		return PTR_ERR(adsp->gcc_sway_cbcr);
>> +	}
>> +
> [..]
>> +
>> +static const struct non_pas_adsp_data adsp_resource_init = {
>> +		.crash_reason_smem = 423,
>> +		.firmware_name = "adsp.mdt",
>> +		.has_aggre2_clk = false,
>> +		.ssr_name = "lpass",
>> +		.sysmon_name = "adsp",
>> +		.ssctl_id = 0x14,
> Please don't inherit the broken indentation.
Yup, will update in next spin.
>> +};
> Regards,
> Bjorn

Thanks,
Rohit
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
