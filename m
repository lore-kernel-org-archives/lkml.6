Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLPqPWHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BB97601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFFNmK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:42:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40853 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeFFNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:42:07 -0400
X-Google-Smtp-Source: ADUXVKKRqVPgDp0OWCT5rBxgN683Nth3zTHWIcu8Pxmu0fS6+hiZ2+qDXLEsVqDvZwQaXeiRiVJq1w==
Subject: Re: [PATCH v2 5/5] memory: tegra: Introduce Tegra20 EMC driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180603223654.23324-1-digetx@gmail.com>
 <20180603223654.23324-6-digetx@gmail.com> <20180606110258.GL11810@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <c17a1edf-f87d-e5f6-b446-34505a2bbc07@gmail.com>
Date: Wed, 6 Jun 2018 16:42:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606110258.GL11810@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.2018 14:02, Thierry Reding wrote:
> On Mon, Jun 04, 2018 at 01:36:54AM +0300, Dmitry Osipenko wrote:
>> Introduce driver for the External Memory Controller (EMC) found on Tegra20
>> chips, which controls the external DRAM on the board. The purpose of this
>> driver is to program memory timing for external memory on the EMC clock
>> rate change.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/Kconfig       |  10 +
>>  drivers/memory/tegra/Makefile      |   1 +
>>  drivers/memory/tegra/tegra20-emc.c | 586 +++++++++++++++++++++++++++++
>>  3 files changed, 597 insertions(+)
>>  create mode 100644 drivers/memory/tegra/tegra20-emc.c
>>
>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>> index 6d74e499e18d..34e0b70f5c5f 100644
>> --- a/drivers/memory/tegra/Kconfig
>> +++ b/drivers/memory/tegra/Kconfig
>> @@ -6,6 +6,16 @@ config TEGRA_MC
>>  	  This driver supports the Memory Controller (MC) hardware found on
>>  	  NVIDIA Tegra SoCs.
>>  
>> +config TEGRA20_EMC
>> +	bool "NVIDIA Tegra20 External Memory Controller driver"
>> +	default y
>> +	depends on ARCH_TEGRA_2x_SOC
>> +	help
>> +	  This driver is for the External Memory Controller (EMC) found on
>> +	  Tegra20 chips. The EMC controls the external DRAM on the board.
>> +	  This driver is required to change memory timings / clock rate for
>> +	  external memory.
>> +
>>  config TEGRA124_EMC
>>  	bool "NVIDIA Tegra124 External Memory Controller driver"
>>  	default y
>> diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
>> index 94ab16ba075b..3971a6b7c487 100644
>> --- a/drivers/memory/tegra/Makefile
>> +++ b/drivers/memory/tegra/Makefile
>> @@ -10,5 +10,6 @@ tegra-mc-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210.o
>>  
>>  obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
>>  
>> +obj-$(CONFIG_TEGRA20_EMC)  += tegra20-emc.o
>>  obj-$(CONFIG_TEGRA124_EMC) += tegra124-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186.o
>> diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
>> new file mode 100644
>> index 000000000000..26a18b5e7941
>> --- /dev/null
>> +++ b/drivers/memory/tegra/tegra20-emc.c
>> @@ -0,0 +1,586 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Tegra20 External Memory Controller driver
>> + *
>> + * Author: Dmitry Osipenko <digetx@gmail.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/sort.h>
>> +#include <linux/types.h>
>> +
>> +#include <soc/tegra/fuse.h>
>> +
>> +#define EMC_INTSTATUS				0x000
>> +#define EMC_INTMASK				0x004
>> +#define EMC_TIMING_CONTROL			0x028
>> +#define EMC_RC					0x02c
>> +#define EMC_RFC					0x030
>> +#define EMC_RAS					0x034
>> +#define EMC_RP					0x038
>> +#define EMC_R2W					0x03c
>> +#define EMC_W2R					0x040
>> +#define EMC_R2P					0x044
>> +#define EMC_W2P					0x048
>> +#define EMC_RD_RCD				0x04c
>> +#define EMC_WR_RCD				0x050
>> +#define EMC_RRD					0x054
>> +#define EMC_REXT				0x058
>> +#define EMC_WDV					0x05c
>> +#define EMC_QUSE				0x060
>> +#define EMC_QRST				0x064
>> +#define EMC_QSAFE				0x068
>> +#define EMC_RDV					0x06c
>> +#define EMC_REFRESH				0x070
>> +#define EMC_BURST_REFRESH_NUM			0x074
>> +#define EMC_PDEX2WR				0x078
>> +#define EMC_PDEX2RD				0x07c
>> +#define EMC_PCHG2PDEN				0x080
>> +#define EMC_ACT2PDEN				0x084
>> +#define EMC_AR2PDEN				0x088
>> +#define EMC_RW2PDEN				0x08c
>> +#define EMC_TXSR				0x090
>> +#define EMC_TCKE				0x094
>> +#define EMC_TFAW				0x098
>> +#define EMC_TRPAB				0x09c
>> +#define EMC_TCLKSTABLE				0x0a0
>> +#define EMC_TCLKSTOP				0x0a4
>> +#define EMC_TREFBW				0x0a8
>> +#define EMC_QUSE_EXTRA				0x0ac
>> +#define EMC_ODT_WRITE				0x0b0
>> +#define EMC_ODT_READ				0x0b4
>> +#define EMC_FBIO_CFG5				0x104
>> +#define EMC_FBIO_CFG6				0x114
>> +#define EMC_AUTO_CAL_INTERVAL			0x2a8
>> +#define EMC_CFG_2				0x2b8
>> +#define EMC_CFG_DIG_DLL				0x2bc
>> +#define EMC_DLL_XFORM_DQS			0x2c0
>> +#define EMC_DLL_XFORM_QUSE			0x2c4
>> +#define EMC_ZCAL_REF_CNT			0x2e0
>> +#define EMC_ZCAL_WAIT_CNT			0x2e4
>> +#define EMC_CFG_CLKTRIM_0			0x2d0
>> +#define EMC_CFG_CLKTRIM_1			0x2d4
>> +#define EMC_CFG_CLKTRIM_2			0x2d8
>> +
>> +#define EMC_CLKCHANGE_REQ_ENABLE		BIT(0)
>> +#define EMC_CLKCHANGE_PD_ENABLE			BIT(1)
>> +#define EMC_CLKCHANGE_SR_ENABLE			BIT(2)
>> +
>> +#define EMC_TIMING_UPDATE			BIT(0)
>> +
>> +#define EMC_CLKCHANGE_COMPLETE_INT		BIT(4)
>> +
>> +static const unsigned long emc_timing_registers[] = {
>> +	EMC_RC,
>> +	EMC_RFC,
>> +	EMC_RAS,
>> +	EMC_RP,
>> +	EMC_R2W,
>> +	EMC_W2R,
>> +	EMC_R2P,
>> +	EMC_W2P,
>> +	EMC_RD_RCD,
>> +	EMC_WR_RCD,
>> +	EMC_RRD,
>> +	EMC_REXT,
>> +	EMC_WDV,
>> +	EMC_QUSE,
>> +	EMC_QRST,
>> +	EMC_QSAFE,
>> +	EMC_RDV,
>> +	EMC_REFRESH,
>> +	EMC_BURST_REFRESH_NUM,
>> +	EMC_PDEX2WR,
>> +	EMC_PDEX2RD,
>> +	EMC_PCHG2PDEN,
>> +	EMC_ACT2PDEN,
>> +	EMC_AR2PDEN,
>> +	EMC_RW2PDEN,
>> +	EMC_TXSR,
>> +	EMC_TCKE,
>> +	EMC_TFAW,
>> +	EMC_TRPAB,
>> +	EMC_TCLKSTABLE,
>> +	EMC_TCLKSTOP,
>> +	EMC_TREFBW,
>> +	EMC_QUSE_EXTRA,
>> +	EMC_FBIO_CFG6,
>> +	EMC_ODT_WRITE,
>> +	EMC_ODT_READ,
>> +	EMC_FBIO_CFG5,
>> +	EMC_CFG_DIG_DLL,
>> +	EMC_DLL_XFORM_DQS,
>> +	EMC_DLL_XFORM_QUSE,
>> +	EMC_ZCAL_REF_CNT,
>> +	EMC_ZCAL_WAIT_CNT,
>> +	EMC_AUTO_CAL_INTERVAL,
>> +	EMC_CFG_CLKTRIM_0,
>> +	EMC_CFG_CLKTRIM_1,
>> +	EMC_CFG_CLKTRIM_2,
>> +};
>> +
>> +struct emc_timing {
>> +	unsigned long rate;
>> +	u32 emc_registers_data[ARRAY_SIZE(emc_timing_registers)];
>> +};
> 
> Nit: this seems like a very long variable name for something that is
> really just "values" or "data" written into a set of registers.
> 

Ok.

>> +struct tegra_emc {
>> +	struct device *dev;
>> +	struct notifier_block clk_nb;
>> +	struct clk *backup_clk;
>> +	struct clk *emc_mux;
>> +	struct clk *pll_m;
>> +	struct clk *clk;
>> +	void __iomem *regs;
>> +
>> +	struct completion clk_handshake_complete;
>> +	int irq;
>> +
>> +	struct emc_timing *timings;
>> +	unsigned int num_timings;
>> +};
>> +
>> +static irqreturn_t tegra_emc_isr(int irq, void *data)
>> +{
>> +	struct tegra_emc *emc = data;
>> +	u32 intmask = EMC_CLKCHANGE_COMPLETE_INT;
>> +	u32 status;
>> +
>> +	status = readl_relaxed(emc->regs + EMC_INTSTATUS) & intmask;
>> +	if (!status)
>> +		return IRQ_NONE;
>> +
>> +	/* clear interrupts */
>> +	writel_relaxed(status, emc->regs + EMC_INTSTATUS);
> 
> Do we really want to just clear the handshake complete interrupt or do
> we want to clear all of them? Perhaps we should also warn if there are
> other interrupts that we're not handling? Currently we'd only get some
> warning if another interrupt triggered without the handshake complete
> one triggering at the same time, but couldn't there be others asserted
> along with the handshake complete interrupt? In which case we'd just
> be ignoring them. Or perhaps not clearing it would get the ISR run
> immediately again and produce the "nobody cared" warning?
> 

Yes, we really want to just clear the handshake-complete interrupt. No, we
shouldn't warn about other interrupts because IRQ subsys does it for us. Other
interrupts shouldn't be asserted because we disabled them with the interrupts
masking in emc_setup_hw(). Other interrupts can only be asserted in a case of a
bug, there will be a "nobody cared" warning and interrupt will be disabled, this
is exactly what we want in that case.

>> +
>> +	/* notify about EMC-CAR handshake completion */
>> +	complete(&emc->clk_handshake_complete);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static struct emc_timing *tegra_emc_find_timing(struct tegra_emc *emc,
>> +						unsigned long rate)
>> +{
>> +	struct emc_timing *timing = NULL;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < emc->num_timings; i++) {
>> +		if (emc->timings[i].rate >= rate) {
>> +			timing = &emc->timings[i];
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!timing) {
>> +		dev_err(emc->dev, "no timing for rate %lu\n", rate);
>> +		return NULL;
>> +	}
>> +
>> +	return timing;
>> +}
>> +
>> +static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
>> +{
>> +	struct emc_timing *timing = tegra_emc_find_timing(emc, rate);
>> +	unsigned int i;
>> +
>> +	if (!timing)
>> +		return -ENOENT;
>> +
>> +	dev_dbg(emc->dev, "%s: timing rate %lu emc rate %lu\n",
>> +		__func__, timing->rate, rate);
>> +
>> +	/* program shadow registers */
>> +	for (i = 0; i < ARRAY_SIZE(timing->emc_registers_data); i++)
>> +		writel_relaxed(timing->emc_registers_data[i],
>> +			       emc->regs + emc_timing_registers[i]);
>> +
>> +	/* wait until programming has settled */
>> +	readl_relaxed(emc->regs + emc_timing_registers[0]);
>> +
>> +	if (emc->irq < 0)
>> +		writel_relaxed(EMC_CLKCHANGE_COMPLETE_INT,
>> +			       emc->regs + EMC_INTMASK);
>> +	else
>> +		reinit_completion(&emc->clk_handshake_complete);
>> +
>> +	return 0;
>> +}
>> +
>> +static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
>> +{
>> +	long timeout;
>> +	u32 value;
>> +	int err;
>> +
>> +	dev_dbg(emc->dev, "%s: flush %d\n", __func__, flush);
>> +
>> +	if (flush) {
>> +		/* manually initiate memory timing update */
>> +		writel_relaxed(EMC_TIMING_UPDATE,
>> +			       emc->regs + EMC_TIMING_CONTROL);
>> +		return 0;
>> +	}
>> +
>> +	if (emc->irq < 0) {
>> +		/* poll interrupt status if IRQ isn't available */
>> +		err = readl_relaxed_poll_timeout(emc->regs + EMC_INTSTATUS,
>> +				value, value & EMC_CLKCHANGE_COMPLETE_INT,
>> +				1, 100);
>> +		if (err) {
>> +			dev_err(emc->dev, "EMC-CAR handshake failed\n");
>> +			return -EIO;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	timeout = wait_for_completion_timeout(&emc->clk_handshake_complete,
>> +					      usecs_to_jiffies(100));
>> +	if (timeout == 0) {
>> +		dev_err(emc->dev, "EMC handshake failed\n");
>> +		return -EIO;
>> +	} else if (timeout < 0) {
>> +		dev_err(emc->dev, "failed to wait for EMC-CAR handshake: %ld\n",
>> +			timeout);
>> +		return timeout;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int load_one_timing_from_dt(struct tegra_emc *emc,
>> +				   struct emc_timing *timing,
>> +				   struct device_node *node)
>> +{
>> +	u32 rate;
>> +	int err;
>> +
>> +	if (!of_device_is_compatible(node, "nvidia,tegra20-emc-table")) {
>> +		dev_err(emc->dev, "incompatible DT node \"%s\"\n",
>> +			node->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = of_property_read_u32(node, "clock-frequency", &rate);
>> +	if (err) {
>> +		dev_err(emc->dev, "timing %s: failed to read rate: %d\n",
>> +			node->name, err);
>> +		return err;
>> +	}
>> +
>> +	err = of_property_read_u32_array(node, "nvidia,emc-registers",
>> +					 timing->emc_registers_data,
>> +					 ARRAY_SIZE(emc_timing_registers));
>> +	if (err) {
>> +		dev_err(emc->dev,
>> +			"timing %s: failed to read emc timing data: %d\n",
>> +			node->name, err);
>> +		return err;
>> +	}
>> +
>> +	/*
>> +	 * The EMC clock rate is twice the bus rate, and the bus rate is
>> +	 * measured in kHz.
>> +	 */
>> +	timing->rate = rate * 2 * 1000;
>> +
>> +	dev_dbg(emc->dev, "%s: emc rate %ld\n", __func__, timing->rate);
> 
> Nit: %lu for timing->rate?
> 

Yes.

>> +
>> +	return 0;
>> +}
>> +
>> +static int cmp_timings(const void *_a, const void *_b)
>> +{
>> +	const struct emc_timing *a = _a;
>> +	const struct emc_timing *b = _b;
>> +
>> +	if (a->rate < b->rate)
>> +		return -1;
>> +	else if (a->rate == b->rate)
>> +		return 0;
>> +	else
>> +		return 1;
> 
> Nit, I tend to 
> 

Tend to..?

>> +}
>> +
>> +static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
>> +					  struct device_node *node)
>> +{
>> +	struct device_node *child;
>> +	struct emc_timing *timing;
>> +	int child_count;
>> +	int err;
>> +
>> +	child_count = of_get_child_count(node);
> 
> It's unfortunate that of_get_child_count() doesn't return unsigned int,
> there's no reason why this would have to be signed.
> 

Patches are welcome ;)

>> +	if (!child_count) {
>> +		dev_err(emc->dev, "no memory timings in DT node\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	emc->timings = devm_kcalloc(emc->dev, child_count, sizeof(*timing),
>> +				    GFP_KERNEL);
>> +	if (!emc->timings)
>> +		return -ENOMEM;
>> +
>> +	emc->num_timings = child_count;
>> +	timing = emc->timings;
>> +
>> +	for_each_child_of_node(node, child) {
>> +		err = load_one_timing_from_dt(emc, timing++, child);
>> +		if (err) {
>> +			of_node_put(child);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
>> +	     NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct device_node *
>> +tegra_emc_find_node_by_ram_code(struct tegra_emc *emc, u32 ram_code)
>> +{
>> +	struct device_node *np;
>> +	int err;
>> +
>> +	for_each_child_of_node(emc->dev->of_node, np) {
>> +		u32 value;
>> +
>> +		err = of_property_read_u32(np, "nvidia,ram-code", &value);
>> +		if (err || value != ram_code)
>> +			continue;
>> +
>> +		return np;
>> +	}
>> +
>> +	dev_info(emc->dev, "no memory timings for RAM code %u found in DT\n",
>> +		 ram_code);
> 
> This seems like it should be dev_warn() or perhaps even dev_err() given
> that the result of it is the driver failing to probe. dev_info() may go
> unnoticed.
> 

Absence of memory timings is a valid case, hence dev_info() suit well here.

I can't see anything wrong with returning a errno if driver has nothing to do
and prefer to keep it because in that case managed resources would be free'd by
the driver core, though returning '0' also would work.

>> +
>> +	return NULL;
>> +}
>> +
>> +static int tegra_emc_clk_change_notify(struct notifier_block *nb,
>> +				       unsigned long msg, void *data)
>> +{
>> +	struct tegra_emc *emc = container_of(nb, struct tegra_emc, clk_nb);
>> +	struct clk_notifier_data *cnd = data;
>> +	int err;
>> +
>> +	switch (msg) {
>> +	case PRE_RATE_CHANGE:
>> +		err = emc_prepare_timing_change(emc, cnd->new_rate);
>> +		break;
>> +
>> +	case ABORT_RATE_CHANGE:
>> +		err = emc_prepare_timing_change(emc, cnd->old_rate);
>> +		if (err)
>> +			break;
>> +
>> +		err = emc_complete_timing_change(emc, true);
>> +		break;
>> +
>> +	case POST_RATE_CHANGE:
>> +		err = emc_complete_timing_change(emc, false);
>> +		break;
>> +
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
>> +
>> +	return notifier_from_errno(err);
>> +}
>> +
>> +static int emc_setup_hw(struct tegra_emc *emc)
>> +{
>> +	u32 emc_cfg;
>> +
>> +	emc_cfg = readl_relaxed(emc->regs + EMC_CFG_2);
>> +
>> +	/*
>> +	 * Depending on a memory type, DRAM should enter either self-refresh
>> +	 * or power-down state on EMC clock change.
>> +	 */
>> +	if (!(emc_cfg & EMC_CLKCHANGE_PD_ENABLE) &&
>> +	    !(emc_cfg & EMC_CLKCHANGE_SR_ENABLE))
>> +	{
>> +		dev_err(emc->dev,
>> +			"bootloader didn't specify DRAM auto-suspend mode\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* allow EMC and CAR to handshake on PLL divider/source changes */
>> +	emc_cfg |= EMC_CLKCHANGE_REQ_ENABLE;
>> +	writel_relaxed(emc_cfg, emc->regs + EMC_CFG_2);
>> +
>> +	/* initialize interrupt */
>> +	writel_relaxed(EMC_CLKCHANGE_COMPLETE_INT, emc->regs + EMC_INTMASK);
>> +	writel_relaxed(EMC_CLKCHANGE_COMPLETE_INT, emc->regs + EMC_INTSTATUS);
>> +
>> +	return 0;
>> +}
>> +
>> +static int emc_init(struct tegra_emc *emc, unsigned long rate)
>> +{
>> +	int err;
>> +
>> +	err = clk_set_parent(emc->emc_mux, emc->backup_clk);
>> +	if (err) {
>> +		dev_err(emc->dev,
>> +			"failed to reparent to backup source: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	err = clk_set_rate(emc->pll_m, rate);
>> +	if (err)
>> +		dev_err(emc->dev,
>> +			"failed to change pll_m rate: %d\n", err);
>> +
>> +	err = clk_set_parent(emc->emc_mux, emc->pll_m);
>> +	if (err) {
>> +		dev_err(emc->dev,
>> +			"failed to reparent to pll_m: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_emc_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np;
>> +	struct tegra_emc *emc;
>> +	struct resource *res;
>> +	u32 ram_code;
>> +	int err;
>> +
>> +	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
>> +	if (!emc)
>> +		return -ENOMEM;
>> +
>> +	emc->dev = &pdev->dev;
>> +
>> +	ram_code = tegra_read_ram_code();
>> +
>> +	np = tegra_emc_find_node_by_ram_code(emc, ram_code);
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	err = tegra_emc_load_timings_from_dt(emc, np);
>> +	of_node_put(np);
>> +	if (err)
>> +		return err;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	emc->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(emc->regs))
>> +		return PTR_ERR(emc->regs);
>> +
>> +	err = emc_setup_hw(emc);
>> +	if (err)
>> +		return err;
>> +
>> +	emc->irq = platform_get_irq(pdev, 0);
>> +	if (emc->irq < 0) {
>> +		dev_warn(&pdev->dev, "interrupt not specified\n");
>> +		dev_warn(&pdev->dev, "continuing, but please update your DT\n");
> 
> Do we really need this? I think this is a case where we don't have to
> keep backwards-compatibility because this driver hasn't "worked" in a
> very long time (because it was absent). Therefore, if we error out in
> the absence of an interrupt we don't break anything.
> 
> There's a few places in this driver that are awkward just because the
> interrupt isn't mandatory. I don't think it's warranted in this case.
> 

Backwards compatibility is always nice to have, but I don't really mind dropping it.

>> +	} else {
>> +		init_completion(&emc->clk_handshake_complete);
>> +
>> +		err = devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr, 0,
>> +				       dev_name(&pdev->dev), emc);
>> +		if (err < 0) {
>> +			dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
>> +				emc->irq, err);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	emc->pll_m = clk_get_sys(NULL, "pll_m");
>> +	if (IS_ERR(emc->pll_m)) {
>> +		err = PTR_ERR(emc->pll_m);
>> +		dev_err(&pdev->dev, "failed to get pll_m: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	emc->backup_clk = clk_get_sys(NULL, "pll_p");
>> +	if (IS_ERR(emc->backup_clk)) {
>> +		err = PTR_ERR(emc->backup_clk);
>> +		dev_err(&pdev->dev, "failed to get pll_p: %d\n", err);
>> +		goto put_pll_m;
>> +	}
>> +
>> +	emc->clk = clk_get_sys(NULL, "emc");
>> +	if (IS_ERR(emc->clk)) {
>> +		err = PTR_ERR(emc->clk);
>> +		dev_err(&pdev->dev, "failed to get emc: %d\n", err);
>> +		goto put_backup;
>> +	}
> 
> Instead of using clk_get_sys(), why not specify these in the DT with
> proper names for context ("emc", "pll", "backup")? Again, I don't think
> we have to worry about backwards-compatibility here since there can be
> no regression.
> 

I don't think that "pll" and "backup" could be placed in DT because it is a pure
software-driver description.

"emc" could be retrieved from DT if we don't care about backwards compatibility.
