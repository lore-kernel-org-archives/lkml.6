Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3522B218FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfABSWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:22:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:36855 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfABSWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:22:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 10:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,431,1539673200"; 
   d="scan'208";a="263909751"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2019 10:22:19 -0800
Subject: Re: [PATCH v9 08/12] mfd: intel-peci-client: Add PECI client MFD
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20181218210417.30140-1-jae.hyun.yoo@linux.intel.com>
 <20181218210417.30140-9-jae.hyun.yoo@linux.intel.com>
 <20181221144603.GR13248@dell>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <8e4bcf7d-aa43-6745-2ade-9123c8d182ef@linux.intel.com>
Date:   Wed, 2 Jan 2019 10:22:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221144603.GR13248@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 12/21/2018 6:46 AM, Lee Jones wrote:
> On Tue, 18 Dec 2018, Jae Hyun Yoo wrote:
> 
>> This commit adds PECI client MFD driver.
>>

<snip>

>>   
>> +config MFD_INTEL_PECI_CLIENT
>> +	bool "Intel PECI client"
>> +	depends on (PECI || COMPILE_TEST)
>> +	select MFD_CORE
>> +	help
>> +	  If you say yes to this option, support will be included for the
>> +	  Intel PECI (Platform Environment Control Interface) client. PECI is a
>> +	  one-wire bus interface that provides a communication channel from PECI
>> +	  clients in Intel processors and chipset components to external
>> +	  monitoring or control devices.
> 
> This driver doesn't appear to actually do anything that can't be done
> in a header file i.e. match some static data with a CPU ID.  The child
> devices can be registered by whatever registers this device.
> 
> It seems superfluous.  Why do you need it?
>

The main reason I added it is to provide a way for sharing the same unit
address from multiple side-band function drivers that read 'reg'
property setting from the parent node (this driver's node). The 'reg'
property reading code is not in this driver but it will be performed in
peci-core when this driver is registered using
module_peci_driver(peci_client_driver), and then it will provides
client->addr information for all its child node drivers.

<snip>

>> +#include <linux/bitfield.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/intel-peci-client.h>
>> +#include <linux/module.h>
>> +#include <linux/peci.h>
>> +#include <linux/of_device.h>
> 
> Alphabetical.
> 

Will fix it. Thanks!

<snip>

>> +enum cpu_gens {
>> +	CPU_GEN_HSX = 0, /* Haswell Xeon */
>> +	CPU_GEN_BRX,     /* Broadwell Xeon */
>> +	CPU_GEN_SKX,     /* Skylake Xeon */
>> +};
> 
> This is unused.
> 

This is being used in 8 lines below but actually the static array can be
initialized without using this enum type. Will remove it.

>> +static struct mfd_cell peci_functions[] = {
>> +	{ .name = "peci-cputemp", },
>> +	{ .name = "peci-dimmtemp", },
>> +	/* TODO: Add additional PECI sideband functions into here */
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
>> +};
>> +
>> +static int peci_client_get_cpu_gen_info(struct peci_client_manager *priv)
>> +{
>> +	u32 cpu_id;
>> +	u16 family;
>> +	u8 model;
>> +	int rc;
> 
> ret is almost ubiquitous in the kernel.  Please use it instead.
> 

Okay. Will change rc to ret.

<snip>

>> +static int peci_client_probe(struct peci_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct peci_client_manager *priv;
>> +	uint cpu_no;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, priv);
>> +	priv->client = client;
>> +	priv->dev = dev;
> 
> If you have client (Which contains dev, you don't need dev).
> 

Makes sense. Will remove the 'dev' member.

<snip>
