Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeCHW26 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:28:58 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11676 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeCHW24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:28:56 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Mar 2018 14:28:55 -0800
Subject: Re: [PATCH v3 04/11] clk: tegra: add CVB tables for Tegra210 CPU DFLL
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-5-git-send-email-pdeschrijver@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c1caff79-bb2f-aefd-a4a7-671160e99933@nvidia.com>
Date: Thu, 8 Mar 2018 22:28:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517934852-23255-5-git-send-email-pdeschrijver@nvidia.com>
X-Originating-IP: [10.26.11.23]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/02/18 16:34, Peter De Schrijver wrote:

I think that you should have some description here.

> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 426 +++++++++++++++++++++++++++++
>  drivers/clk/tegra/cvb.h                    |   1 +
>  2 files changed, 427 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index 6486ad9..78dddab 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -88,6 +88,421 @@ struct dfll_fcpu_data {
>  	},
>  };
>  
> +static const unsigned long tegra210_cpu_max_freq_table[] = {
> +	[0] = 1912500000UL,
> +	[1] = 1912500000UL,
> +	[2] = 2218500000UL,
> +	[3] = 1785000000UL,
> +	[4] = 1632000000UL,
> +	[5] = 1912500000UL,
> +	[6] = 2014500000UL,
> +	[7] = 1734000000UL,
> +	[8] = 1683000000UL,
> +	[9] = 1555500000UL,
> +	[10] = 1504500000UL,
> +};
> +
> +#define CPU_CVB_TABLE \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{204000000UL,	{1007452, -23865, 370} }, \
> +		{306000000UL,	{1052709, -24875, 370} }, \
> +		{408000000UL,	{1099069, -25895, 370} }, \
> +		{510000000UL,	{1146534, -26905, 370} }, \
> +		{612000000UL,	{1195102, -27915, 370} }, \
> +		{714000000UL,	{1244773, -28925, 370} }, \
> +		{816000000UL,	{1295549, -29935, 370} }, \
> +		{918000000UL,	{1347428, -30955, 370} }, \
> +		{1020000000UL,	{1400411, -31965, 370} }, \
> +		{1122000000UL,	{1454497, -32975, 370} }, \
> +		{1224000000UL,	{1509687, -33985, 370} }, \
> +		{1326000000UL,	{1565981, -35005, 370} }, \
> +		{1428000000UL,	{1623379, -36015, 370} }, \
> +		{1530000000UL,	{1681880, -37025, 370} }, \
> +		{1632000000UL,	{1741485, -38035, 370} }, \
> +		{1734000000UL,	{1802194, -39055, 370} }, \
> +		{1836000000UL,	{1864006, -40065, 370} }, \
> +		{1912500000UL,	{1910780, -40815, 370} }, \
> +		{2014500000UL,	{1227000,      0,   0} }, \
> +		{2218500000UL,	{1227000,      0,   0} }, \
> +		{0,		{      0,      0,   0} }, \
> +	}
> +
> +#define CPU_CVB_TABLE_XA \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{204000000UL,	{1250024, -39785, 565} }, \
> +		{306000000UL,	{1297556, -41145, 565} }, \
> +		{408000000UL,	{1346718, -42505, 565} }, \
> +		{510000000UL,	{1397511, -43855, 565} }, \
> +		{612000000UL,	{1449933, -45215, 565} }, \
> +		{714000000UL,	{1503986, -46575, 565} }, \
> +		{816000000UL,	{1559669, -47935, 565} }, \
> +		{918000000UL,	{1616982, -49295, 565} }, \
> +		{1020000000UL,	{1675926, -50645, 565} }, \
> +		{1122000000UL,	{1736500, -52005, 565} }, \
> +		{1224000000UL,	{1798704, -53365, 565} }, \
> +		{1326000000UL,	{1862538, -54725, 565} }, \
> +		{1428000000UL,	{1928003, -56085, 565} }, \
> +		{1530000000UL,	{1995097, -57435, 565} }, \
> +		{1606500000UL,	{2046149, -58445, 565} }, \
> +		{1632000000UL,	{2063822, -58795, 565} }, \
> +		{0,		{      0,      0,   0} }, \
> +	}
> +
> +#define CPU_CVB_TABLE_EUCM1 \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{204000000UL,	{734429, 0, 0} }, \
> +		{306000000UL,	{768191, 0, 0} }, \
> +		{408000000UL,	{801953, 0, 0} }, \
> +		{510000000UL,	{835715, 0, 0} }, \
> +		{612000000UL,	{869477, 0, 0} }, \
> +		{714000000UL,	{903239, 0, 0} }, \
> +		{816000000UL,	{937001, 0, 0} }, \
> +		{918000000UL,	{970763, 0, 0} }, \
> +		{1020000000UL,	{1004525, 0, 0} }, \
> +		{1122000000UL,	{1038287, 0, 0} }, \
> +		{1224000000UL,	{1072049, 0, 0} }, \
> +		{1326000000UL,	{1105811, 0, 0} }, \
> +		{1428000000UL,	{1130000, 0, 0} }, \
> +		{1555500000UL,	{1130000, 0, 0} }, \
> +		{1632000000UL,	{1170000, 0, 0} }, \
> +		{1734000000UL,	{1227500, 0, 0} }, \
> +		{0,		{      0, 0, 0} }, \
> +	}
> +
> +#define CPU_CVB_TABLE_EUCM2 \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{204000000UL,	{742283, 0, 0} }, \
> +		{306000000UL,	{776249, 0, 0} }, \
> +		{408000000UL,	{810215, 0, 0} }, \
> +		{510000000UL,	{844181, 0, 0} }, \
> +		{612000000UL,	{878147, 0, 0} }, \
> +		{714000000UL,	{912113, 0, 0} }, \
> +		{816000000UL,	{946079, 0, 0} }, \
> +		{918000000UL,	{980045, 0, 0} }, \
> +		{1020000000UL,	{1014011, 0, 0} }, \
> +		{1122000000UL,	{1047977, 0, 0} }, \
> +		{1224000000UL,	{1081943, 0, 0} }, \
> +		{1326000000UL,	{1090000, 0, 0} }, \
> +		{1479000000UL,	{1090000, 0, 0} }, \
> +		{1555500000UL,	{1162000, 0, 0} }, \
> +		{1683000000UL,	{1195000, 0, 0} }, \
> +		{0,		{      0, 0, 0} }, \
> +	}
> +
> +#define CPU_CVB_TABLE_EUCM2_JOINT_RAIL \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{204000000UL,	{742283, 0, 0} }, \
> +		{306000000UL,	{776249, 0, 0} }, \
> +		{408000000UL,	{810215, 0, 0} }, \
> +		{510000000UL,	{844181, 0, 0} }, \
> +		{612000000UL,	{878147, 0, 0} }, \
> +		{714000000UL,	{912113, 0, 0} }, \
> +		{816000000UL,	{946079, 0, 0} }, \
> +		{918000000UL,	{980045, 0, 0} }, \
> +		{1020000000UL,	{1014011, 0, 0} }, \
> +		{1122000000UL,	{1047977, 0, 0} }, \
> +		{1224000000UL,	{1081943, 0, 0} }, \
> +		{1326000000UL,	{1090000, 0, 0} }, \
> +		{1479000000UL,	{1090000, 0, 0} }, \
> +		{1504500000UL,	{1120000, 0, 0} }, \
> +		{0,		{      0, 0, 0} }, \
> +	}
> +
> +#define CPU_CVB_TABLE_ODN \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{204000000UL,	{721094, 0, 0} }, \
> +		{306000000UL,	{754040, 0, 0} }, \
> +		{408000000UL,	{786986, 0, 0} }, \
> +		{510000000UL,	{819932, 0, 0} }, \
> +		{612000000UL,	{852878, 0, 0} }, \
> +		{714000000UL,	{885824, 0, 0} }, \
> +		{816000000UL,	{918770, 0, 0} }, \
> +		{918000000UL,	{915716, 0, 0} }, \
> +		{1020000000UL,	{984662, 0, 0} }, \
> +		{1122000000UL,	{1017608, 0, 0} }, \
> +		{1224000000UL,	{1050554, 0, 0} }, \
> +		{1326000000UL,	{1083500, 0, 0} }, \
> +		{1428000000UL,	{1116446, 0, 0} }, \
> +		{1581000000UL,	{1130000, 0, 0} }, \
> +		{1683000000UL,	{1168000, 0, 0} }, \
> +		{1785000000UL,	{1227500, 0, 0} }, \
> +		{0,		{      0, 0, 0} }, \
> +	}
> +
> +struct cvb_table tegra210_cpu_cvb_tables[] = {
> +	{
> +		.speedo_id = 10,
> +		.process_id = 0,
> +		.min_millivolts = 840,
> +		.max_millivolts = 1120,
> +		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 10,
> +		.process_id = 1,
> +		.min_millivolts = 840,
> +		.max_millivolts = 1120,
> +		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 9,
> +		.process_id = 0,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1162,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 9,
> +		.process_id = 1,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1162,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 8,
> +		.process_id = 0,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1195,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 8,
> +		.process_id = 1,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1195,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 7,
> +		.process_id = 0,
> +		.min_millivolts = 841,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_EUCM1,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 7,
> +		.process_id = 1,
> +		.min_millivolts = 841,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_EUCM1,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 6,
> +		.process_id = 0,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1150,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 6,
> +		.process_id = 1,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1150,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +		}
> +	},
> +	{
> +		.speedo_id = 5,
> +		.process_id = 0,
> +		.min_millivolts = 818,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 5,
> +		.process_id = 1,
> +		.min_millivolts = 818,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 4,
> +		.process_id = -1,
> +		.min_millivolts = 918,
> +		.max_millivolts = 1113,
> +		CPU_CVB_TABLE_XA,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x17711BD,
> +		}
> +	},
> +	{
> +		.speedo_id = 3,
> +		.process_id = 0,
> +		.min_millivolts = 825,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_ODN,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 3,
> +		.process_id = 1,
> +		.min_millivolts = 825,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_ODN,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 2,
> +		.process_id = 0,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 2,
> +		.process_id = 1,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +		}
> +	},
> +	{
> +		.speedo_id = 1,
> +		.process_id = 0,
> +		.min_millivolts = 837,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 1,
> +		.process_id = 1,
> +		.min_millivolts = 837,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 0,
> +		.process_id = 0,
> +		.min_millivolts = 850,
> +		.max_millivolts = 1170,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 0,
> +		.process_id = 1,
> +		.min_millivolts = 850,
> +		.max_millivolts = 1170,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +};
> +
>  static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
>  	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
>  	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
> @@ -95,11 +510,22 @@ struct dfll_fcpu_data {
>  	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
>  };
>  
> +static const struct dfll_fcpu_data tegra210_dfll_fcpu_data = {
> +	.cpu_max_freq_table = tegra210_cpu_max_freq_table,
> +	.cpu_max_freq_table_size = ARRAY_SIZE(tegra210_cpu_max_freq_table),
> +	.cpu_cvb_tables = tegra210_cpu_cvb_tables,
> +	.cpu_cvb_tables_size = ARRAY_SIZE(tegra210_cpu_cvb_tables),
> +};
> +
>  static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
>  	{
>  		.compatible = "nvidia,tegra124-dfll",
>  		.data = &tegra124_dfll_fcpu_data,
>  	},
> +	{
> +		.compatible = "nvidia,tegra210-dfll",
> +		.data = &tegra210_dfll_fcpu_data
> +	},
>  	{ },
>  };
>  
> diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
> index bcf15a0..91a1941 100644
> --- a/drivers/clk/tegra/cvb.h
> +++ b/drivers/clk/tegra/cvb.h
> @@ -41,6 +41,7 @@ struct cvb_cpu_dfll_data {
>  	u32 tune0_low;
>  	u32 tune0_high;
>  	u32 tune1;
> +	unsigned int tune_high_min_millivolts;
>  };
>  
>  struct cvb_table {
> 

Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
