Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44323ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26D72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26D72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJYFk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:40:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:59373 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeJYFk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:40:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 14:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="244088045"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2018 14:10:45 -0700
Subject: Re: [PATCH v8 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-9-jae.hyun.yoo@linux.intel.com>
 <20181024105903.GB4939@dell>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <db7570cb-8f63-b551-d119-c54270ce6139@linux.intel.com>
Date:   Wed, 24 Oct 2018 14:10:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024105903.GB4939@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 10/24/2018 3:59 AM, Lee Jones wrote:
> On Tue, 18 Sep 2018, Jae Hyun Yoo wrote:
> 
>> This commit adds PECI client MFD driver.
>>

<snip>

>> +config MFD_INTEL_PECI_CLIENT
>> +	bool "Intel PECI client"
>> +	depends on (PECI || COMPILE_TEST)
>> +	select MFD_CORE
>> +	help
>> +	  If you say yes to this option, support will be included for the
>> +	  multi-functional Intel PECI (Platform Environment Control Interface)
> 
> Remove 'multi-functional' from this sentence.
> 

Will remove the word.

<snip>

>> +static struct mfd_cell peci_functions[] = {
>> +	{
>> +		.name = "peci-cputemp",
>> +	},
>> +	{
>> +		.name = "peci-dimmtemp",
>> +	},
> 
> 	{ .name = "peci-cputemp", },
> 	{ .name = "peci-dimmtemp", },
> 

Will change it like you suggested.

> Do these have 2 different drivers?  Where are you putting them?
> 

Yes, these have 2 different drivers as hwmon subsystem drivers.
I submitted them into this patch series.
Patch 10/12: https://lkml.org/lkml/2018/9/18/1524
Patch 11/12: https://lkml.org/lkml/2018/9/18/1523

>> +	/* TODO: Add additional PECI sideband functions into here */
> 
> When will this be done?
> 

I'm hoping it will be done by the end of this year.

>> +};
>> +
>> +static const struct cpu_gen_info cpu_gen_info_table[] = {
>> +	[CPU_GEN_HSX] = {
>> +		.family        = 6, /* Family code */
>> +		.model         = INTEL_FAM6_HASWELL_X,
>> +		.core_max      = CORE_MAX_ON_HSX,
>> +		.chan_rank_max = CHAN_RANK_MAX_ON_HSX,
>> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_HSX },
>> +	[CPU_GEN_BRX] = {
>> +		.family        = 6, /* Family code */
>> +		.model         = INTEL_FAM6_BROADWELL_X,
>> +		.core_max      = CORE_MAX_ON_BDX,
>> +		.chan_rank_max = CHAN_RANK_MAX_ON_BDX,
>> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_BDX },
>> +	[CPU_GEN_SKX] = {
>> +		.family        = 6, /* Family code */
>> +		.model         = INTEL_FAM6_SKYLAKE_X,
>> +		.core_max      = CORE_MAX_ON_SKX,
>> +		.chan_rank_max = CHAN_RANK_MAX_ON_SKX,
>> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_SKX },
> 
> The '},'s should go on the line below.
> 

Okay. Will fix it.

>> +};
>> +
>> +static int peci_client_get_cpu_gen_info(struct peci_mfd *priv)
> 
> Remove all mention of 'mfd'.  It's not a thing.
> 

Will remove 'mfd'.

>> +{
>> +	u32 cpu_id;
>> +	int i, rc;
>> +
>> +	rc = peci_get_cpu_id(priv->adapter, priv->addr, &cpu_id);
>> +	if (rc)
>> +		return rc;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cpu_gen_info_table); i++) {
>> +		if (FIELD_GET(CPU_ID_FAMILY_MASK, cpu_id) +
>> +			FIELD_GET(CPU_ID_EXT_FAMILY_MASK, cpu_id) ==
>> +				cpu_gen_info_table[i].family &&
>> +		    FIELD_GET(CPU_ID_MODEL_MASK, cpu_id) ==
>> +			FIELD_GET(LOWER_NIBBLE_MASK,
>> +				  cpu_gen_info_table[i].model) &&
>> +		    FIELD_GET(CPU_ID_EXT_MODEL_MASK, cpu_id) ==
>> +			FIELD_GET(UPPER_NIBBLE_MASK,
>> +				  cpu_gen_info_table[i].model)) {
>> +			break;
>> +		}
>> +	}
> 
> This is really read.  Please reformat it, even if you have to use
> local variables to make it more legible.
> 

Will reformat it using local variables for better readability as you
suggest.

>> +	if (i >= ARRAY_SIZE(cpu_gen_info_table))
>> +		return -ENODEV;
> 
> Do you really want to fail silently?
> 

No. I'll add a dev_err printing.

>> +	priv->gen_info = &cpu_gen_info_table[i];
> 
> If you do this in the for(), you can then test priv->gen_info instead
> of seeing if the iterator maxed out.  Much nicer I think.
> 

Yes, that would be much nicer. Will fix it.

>> +	return 0;
>> +}
>> +
>> +bool peci_temp_need_update(struct temp_data *temp)
>> +{
>> +	if (temp->valid &&
>> +	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL_GPL(peci_temp_need_update);
>> +
>> +void peci_temp_mark_updated(struct temp_data *temp)
>> +{
>> +	temp->valid = 1;
>> +	temp->last_updated = jiffies;
>> +}
>> +EXPORT_SYMBOL_GPL(peci_temp_mark_updated);
> 
> These are probably better suited as inline functions to be placed in
> a header file.  No need to export them, since they only use their own
> data.
> 

Yes, that makes sense. I'll change these to inline functions.

>> +int peci_client_command(struct peci_mfd *priv, enum peci_cmd cmd, void *vmsg)
>> +{
>> +	return peci_command(priv->adapter, cmd, vmsg);
>> +}
>> +EXPORT_SYMBOL_GPL(peci_client_command);
> 
> If you share the adaptor with the client, you can call peci_command()
> directly.  There should also be some locking in here somewhere too.
> 

Yes, the client->adapter can be referenced from child drivers. Will make
them call peci_command() directly.

>> +int peci_client_rd_pkg_cfg_cmd(struct peci_mfd *priv, u8 mbx_idx,
> 
> This is gobbledegook.  What's rd?  Read?
> 

Yes, the 'rd' means 'read'. I intended to keep command names as listed
in the PECI specification such as RdPkgConfig, WrPkgConfig and so on.
Should I change it to 'peci_client_read_package_config_command' ?

>> +			       u16 param, u8 *data)
>> +{
>> +	struct peci_rd_pkg_cfg_msg msg;
>> +	int rc;
>> +
>> +	msg.addr = priv->addr;
>> +	msg.index = mbx_idx;
>> +	msg.param = param;
>> +	msg.rx_len = 4;
>> +
>> +	rc = peci_command(priv->adapter, PECI_CMD_RD_PKG_CFG, &msg);
>> +	if (!rc)
>> +		memcpy(data, msg.pkg_config, 4);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(peci_client_rd_pkg_cfg_cmd);
> 
> This too should be set-up as an inline function, not an exported one.
> 

Will change it to inline function.

>> +static int peci_client_probe(struct peci_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct peci_mfd *priv;
>> +	int rc;
> 
> 'ret' is more common.
> 

Will fix it.

>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, priv);
>> +	priv->client = client;
>> +	priv->dev = dev;
> 
>> +	priv->adapter = client->adapter;
>> +	priv->addr = client->addr;
> 
> You're already saving client.  No need to save its individual
> attributes as well.
> 

I intended to reduce pointer referencing depth because adapter and addr 
are frequently used, but you are right. I'll remove adapter and addr 
from the struct.

>> +	priv->cpu_no = client->addr - PECI_BASE_ADDR;
> 
> This seems clunky.  Does the spec say that the addresses have to be in
> numerical order with no gaps?  What if someone chooses to implement 4
> CPUs at 0x30, 0x35, 0x45 and 0x60?
> 

The CPU address will be assigned by H/W strap settings in order. Also,
there would be a case of using some CPU slots left empty, so gaps could
be happen on the addresses but it's still acceptable.

> What do you then do with cpu_no?
> 

It is being used for child device id parameter when this code calls
devm_mfd_add_devices() below. Also, it is referenced from cputemp and
dimmtemp hwmon drivers but it isn't needed because the hwmon drivers
already know client->addr. I'll change cpu_no as a local variable in 
here for child device id and will change the hwmon drivers.

>> +	snprintf(priv->name, PECI_NAME_SIZE, "peci_client.cpu%d", priv->cpu_no);
>> +
>> +	rc = peci_client_get_cpu_gen_info(priv);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = devm_mfd_add_devices(priv->dev, priv->cpu_no, peci_functions,
>> +				  ARRAY_SIZE(peci_functions), NULL, 0, NULL);
>> +	if (rc < 0) {
>> +		dev_err(priv->dev, "devm_mfd_add_devices failed: %d\n", rc);
> 
> This to too specific.
> 
>    "Failed to register child devices"
> 

Will fix it like you suggested.

>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id peci_client_of_table[] = {
>> +	{ .compatible = "intel,peci-client" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, peci_client_of_table);
>> +#endif
>> +
>> +static const struct peci_device_id peci_client_ids[] = {
>> +	{ .name = "peci-client", .driver_data = 0 },
> 
> Remove .driver_data if you're not going to use it.
> 

Okay. I'll remove .driver_data.

>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(peci, peci_client_ids);
>> +
>> +static struct peci_driver peci_client_driver = {
>> +	.probe    = peci_client_probe,
>> +	.id_table = peci_client_ids,
>> +	.driver   = {
>> +			.name           = "peci-client",
>> +			.of_match_table =
>> +				of_match_ptr(peci_client_of_table),
>> +	},
>> +};
> 
> Odd tabbing.
> 

Will fix the indentation.

>> +module_peci_driver(peci_client_driver);
>> +
>> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
>> +MODULE_DESCRIPTION("PECI client MFD driver");
> 
> Remove "MFD".
> 

Will remove it.

>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/intel-peci-client.h b/include/linux/mfd/intel-peci-client.h
>> new file mode 100644
>> index 000000000000..7ec272cddceb
>> --- /dev/null
>> +++ b/include/linux/mfd/intel-peci-client.h
>> @@ -0,0 +1,81 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2018 Intel Corporation */
>> +
>> +#ifndef __LINUX_MFD_PECI_CLIENT_H
>> +#define __LINUX_MFD_PECI_CLIENT_H
>> +
>> +#include <linux/peci.h>
>> +
>> +#if IS_ENABLED(CONFIG_X86)
>> +#include <asm/intel-family.h>
>> +#else
>> +/**
>> + * Architectures other than x86 cannot include the header file so define these
>> + * at here. These are needed for detecting type of client x86 CPUs behind a PECI
>> + * connection.
>> + */
>> +#define INTEL_FAM6_HASWELL_X   0x3F
>> +#define INTEL_FAM6_BROADWELL_X 0x4F
>> +#define INTEL_FAM6_SKYLAKE_X   0x55
>> +#endif
>> +
>> +#define LOWER_NIBBLE_MASK      GENMASK(3, 0)
>> +#define UPPER_NIBBLE_MASK      GENMASK(7, 4)
>> +
>> +#define CPU_ID_MODEL_MASK      GENMASK(7, 4)
>> +#define CPU_ID_FAMILY_MASK     GENMASK(11, 8)
>> +#define CPU_ID_EXT_MODEL_MASK  GENMASK(19, 16)
>> +#define CPU_ID_EXT_FAMILY_MASK GENMASK(27, 20)
>> +
>> +#define CORE_MAX_ON_HSX        18 /* Max number of cores on Haswell */
>> +#define CHAN_RANK_MAX_ON_HSX   8  /* Max number of channel ranks on Haswell */
>> +#define DIMM_IDX_MAX_ON_HSX    3  /* Max DIMM index per channel on Haswell */
>> +
>> +#define CORE_MAX_ON_BDX        24 /* Max number of cores on Broadwell */
>> +#define CHAN_RANK_MAX_ON_BDX   4  /* Max number of channel ranks on Broadwell */
>> +#define DIMM_IDX_MAX_ON_BDX    3  /* Max DIMM index per channel on Broadwell */
>> +
>> +#define CORE_MAX_ON_SKX        28 /* Max number of cores on Skylake */
>> +#define CHAN_RANK_MAX_ON_SKX   6  /* Max number of channel ranks on Skylake */
>> +#define DIMM_IDX_MAX_ON_SKX    2  /* Max DIMM index per channel on Skylake */
>> +
>> +#define CORE_NUMS_MAX          CORE_MAX_ON_SKX
>> +#define CHAN_RANK_MAX          CHAN_RANK_MAX_ON_HSX
>> +#define DIMM_IDX_MAX           DIMM_IDX_MAX_ON_HSX
>> +#define DIMM_NUMS_MAX          (CHAN_RANK_MAX * DIMM_IDX_MAX)
>> +
>> +#define TEMP_TYPE_PECI         6 /* Sensor type 6: Intel PECI */
>> +
>> +#define UPDATE_INTERVAL        HZ
>> +
>> +struct temp_data {
>> +	uint  valid;
>> +	s32   value;
>> +	ulong last_updated;
>> +};
> 
> This should not live in here.
> 

Will move it.

>> +struct cpu_gen_info {
>> +	u16  family;
>> +	u8   model;
>> +	uint core_max;
>> +	uint chan_rank_max;
>> +	uint dimm_idx_max;
>> +};
>> +
>> +struct peci_mfd {
> 
> Remove "_mfd".
> 

Will remove 'mfd'.

>> +	struct peci_client *client;
>> +	struct device *dev;
>> +	struct peci_adapter *adapter;
>> +	char name[PECI_NAME_SIZE];
> 
> What is this used for?
> 

This isn't needed. Thanks for your pointing out. I'll remove it.

>> +	u8 addr;
>> +	uint cpu_no;
>> +	const struct cpu_gen_info *gen_info;
> 
> Where is this used?
> 

It is referenced from cputemp and dimmtemp hwmon drivers to specify CPU
generation.

>> +};
> 
> Both of these structs need kerneldoc headers.
> 

Will add kerneldoc headers.

>> +bool peci_temp_need_update(struct temp_data *temp);
>> +void peci_temp_mark_updated(struct temp_data *temp);
> 
> These should live in a temperature driver.
> 

Agreed. I'll move it to temperature driver.

Thanks a lot for your careful review. I'll submit a new patch set soon.

Jae

>> +int  peci_client_command(struct peci_mfd *mfd, enum peci_cmd cmd, void *vmsg);
>> +int  peci_client_rd_pkg_cfg_cmd(struct peci_mfd *mfd, u8 mbx_idx,
>> +				u16 param, u8 *data);
>> +
>> +#endif /* __LINUX_MFD_PECI_CLIENT_H */
> 
