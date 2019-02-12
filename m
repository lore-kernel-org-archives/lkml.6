Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99850C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F173214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u7th5qwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfBLMoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:44:06 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:38016
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729457AbfBLMoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0g+UCKnajQlF6ZaMQS2Y0ezxmuYc9qreh7W+yGXi1c=;
 b=u7th5qwHz7DMdyf76s7jxkU//FCxsRoq+7UzZSezthqqce5NeuOvloPgDt87c2GcSxuz8yHm+nHtWMICGrlPghDbMS4q5JqpMD6dCS7AnJJBs7r4a9RjYfA3FbwMu1TSTVK32nZIu5sP1/s6tA/xE52pWuzxb2CtZt+V4eEuKVw=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5379.eurprd04.prod.outlook.com (20.178.115.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 12:43:56 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:43:56 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] cpufreq: Add i.mx8mq support
Thread-Topic: [PATCH 1/2] cpufreq: Add i.mx8mq support
Thread-Index: AQHUws1/vGuK9i/NUECj4GLPl6ZtMqXcGZiAgAACB4A=
Date:   Tue, 12 Feb 2019 12:43:56 +0000
Message-ID: <20190212124355.tp3l2hm3qi3vhlgp@fsr-ub1664-175>
References: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
 <1549974999.2546.28.camel@pengutronix.de>
In-Reply-To: <1549974999.2546.28.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5379;6:VK8ieA0vUuF5XbYQXU7O00yzxbtXlKGaMoRdvelaEAbBCdV9jPhDQpEyBj2xwZirUzlyTmC9SV0CAz9LAx/PlUU8F+p24rf0cD6C3NicU1mLoB7bX8QEyxj148296FjLZYUbKm6Q8pMltMte5/I+m3TPxAyT2ZdBfWHHuFsrRMMDoP7G46oJR65CWrAdHFyKlTx2aFYhpPwT6zDfMaf6hjMJtZqz0plj3a+DIMnBWEmECephCptMeTjpBy1zK/XBbk0ZPljHpYsGsB06d8L3/034BOtxs2glYnQ3tV8Bs7LvTlIMiROyPPB4l9kiNqQKK6IYN0WEADfqzUTzSygjpMtR4qwTNLS4Hxb9bDSYKDSee/qMuQq070apVUQT+Btc5da/vcr5prlT87Xm7S311KHbF3DOnd9ibuz7fLHw0+9TjcXiZQ46rXR6jTmfsAhy0XxmX7bdBKmTZyH44zNCtQ==;5:uPbX5pE5OvE55/LrlnxV8o8yVp5v7ZivTDdk1rW7ASvtxB67tzSXFPHNI3iYewwGxqQYceqcLxpoDKFUjqbXW3tUVC1LfUYSV++/cr1nFck7Vbkp7lrSkfW1CXTTuzmeJ9OQIQjMuWdyR8f0bFBntPKdbik4t0tTdtTVDqLhsGEjJTDzXc2n4ZSr8whECVrD6/aaf2Eo71nuXdohyKUKNA==;7:/3jpIZEfYKq0DBKnP/uz2wi0gRKgSGsaKeCvRaLmJK32ShFvEFfCefkmWrTHSygn6Kd0EYjsYyyC0wSHM3LUFyoB3zuYBgG/oc84RMtWr2oT05ikVmtW4dhshrWmm7GDpSc9/aB6UY+d/PeODfiBMg==
x-ms-office365-filtering-correlation-id: 189ea501-0ae7-4296-cc43-08d690e7c0c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5379;
x-ms-traffictypediagnostic: AM0PR04MB5379:
x-microsoft-antispam-prvs: <AM0PR04MB53796874A92BA29A6C2242A1F6650@AM0PR04MB5379.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(6246003)(3846002)(33716001)(305945005)(86362001)(53936002)(33896004)(6116002)(8936002)(478600001)(14454004)(81156014)(81166006)(26005)(8676002)(6506007)(186003)(76176011)(53546011)(7736002)(68736007)(102836004)(97736004)(105586002)(54906003)(2906002)(25786009)(6486002)(1076003)(6916009)(6512007)(44832011)(316002)(11346002)(71200400001)(6436002)(71190400001)(476003)(106356001)(9686003)(486006)(66066001)(229853002)(14444005)(446003)(256004)(4326008)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5379;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gH855TvbYR7AxD8vnqiZTNwwK4h8HTDSitkQivGm+fqK1FTCVwocqCJF05zhNiCbbiBaABUC0abFgirEQmN8085LEsXI7xae1LZQC/2K7fNNuQubqTVqHMQBRdTMf83111/U3MAi1RoJv2HBhPnf/TiiF3T1rVUhfvClTQJLsZo1xAgTfLpRyuv1fLID3A5I9y51CkB7JnxVyl98K7yyAqlhJp6ReU9fhj0YLipBCUOqthBjzv8jy94fkoFiI0UZXtYV/ZGjs76z+b031ymA+vZNkyoShuuFdOarh2rzxvZXUMoX67VQsyNl7Pu2VA0toTRYceopX8zvbM7DGAKRa8GezmTRIbnEXPL547RGEsj4C6sOmdphGyu43OAKUeWxYjX/q4ONXC8jhuhdZPv8JNwYvFPdR5zd14w8ajRPEqM=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FE59C9BFDF6F3C418B84382BF27B7F4F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189ea501-0ae7-4296-cc43-08d690e7c0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:43:56.4835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-12 13:36:39, Lucas Stach wrote:
> Hi Abel,
>=20
> we really don't want another platform specific cpufreq driver in
> mainline. The CPU clock change dance should be abstracted in the
> imx8mq-clk driver, just like we do on i.MX5 and i.MX7. This would allow
> us to reuse the cpufreq-dt driver, like we do on those platforms.
>=20

Fair enough. This is what we had in our internal tree.
Will rewrite as suggested then.
Thanks.

> Regards,
> Lucas
>=20
> Am Dienstag, den 12.02.2019, 12:21 +0000 schrieb Abel Vesa:
> > > From: Anson Huang <Anson.Huang@nxp.com>
> >=20
> > Add i.MX8MQ cpufreq support, current version of
> > EVK board does NOT support voltage scale, but next
> > version will add this support, so this driver only
> > supports cpu frequency scale, voltage scale will
> > be added later once new board available.
> >=20
> > A53 CPU clock normally is from ARM_PLL, but during
> > ARM_PLL relock window, it will be switched to
> > SYS1_PLL_800M to avoid clock missing, and after
> > arm pll relock done, it will be switched back.
> >=20
> > > Signed-off-by: Anson Huang <anson.huang@nxp.com>
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > =A0drivers/cpufreq/Kconfig.arm=A0=A0=A0=A0=A0=A0|=A0=A0=A08 ++
> > =A0drivers/cpufreq/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A01 +
> > =A0drivers/cpufreq/imx8mq-cpufreq.c | 223 +++++++++++++++++++++++++++++=
++++++++++
> > =A03 files changed, 232 insertions(+)
> > =A0create mode 100644 drivers/cpufreq/imx8mq-cpufreq.c
> >=20
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 179a1d3..9d8001c 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -92,6 +92,14 @@ config ARM_IMX6Q_CPUFREQ
> > =A0
> > > =A0	=A0=A0If in doubt, say N.
> > =A0
> > +config ARM_IMX8MQ_CPUFREQ
> > > +	tristate "NXP i.MX8MQ cpufreq support"
> > > +	select PM_OPP
> > > +	help
> > > +	=A0=A0This adds cpufreq driver support for NXP i.MX8MQ series SoCs.
> > +
> > > +	=A0=A0If in doubt, say N.
> > +
> > =A0config ARM_KIRKWOOD_CPUFREQ
> > > =A0	def_bool MACH_KIRKWOOD
> > > =A0	help
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 689b26c..fe5416c 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > > @@ -56,6 +56,7 @@ obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+=3D cppc_cpufreq.=
o
> > > =A0obj-$(CONFIG_ARCH_DAVINCI)		+=3D davinci-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+=3D highbank-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+=3D imx6q-cpufreq.o
> > > +obj-$(CONFIG_ARM_IMX8MQ_CPUFREQ)	+=3D imx8mq-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+=3D kirkwood-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+=3D mediatek-cpufreq.o
> > > =A0obj-$(CONFIG_MACH_MVEBU_V7)		+=3D mvebu-cpufreq.o
> > diff --git a/drivers/cpufreq/imx8mq-cpufreq.c b/drivers/cpufreq/imx8mq-=
cpufreq.c
> > new file mode 100644
> > index 0000000..ee24fab
> > --- /dev/null
> > +++ b/drivers/cpufreq/imx8mq-cpufreq.c
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 NXP
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/cpu.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/suspend.h>
> > +
> > +static struct device *cpu_dev;
> > +static bool free_opp;
> > +static struct cpufreq_frequency_table *freq_table;
> > +static struct mutex set_cpufreq_lock;
> > +static unsigned int transition_latency;
> > +static unsigned int suspend_freq;
> > +static struct clk *a53_clk;
> > +static struct clk *arm_a53_src_clk;
> > +static struct clk *arm_pll_clk;
> > +static struct clk *arm_pll_out_clk;
> > +static struct clk *sys1_pll_800m_clk;
> > +
> > +static int imx8mq_set_target(struct cpufreq_policy *policy, unsigned i=
nt index)
> > +{
> > > +	struct dev_pm_opp *opp;
> > > +	unsigned long freq_hz;
> > > +	unsigned int old_freq, new_freq;
> > > +	int ret;
> > +
> > > +	mutex_lock(&set_cpufreq_lock);
> > +
> > > +	new_freq =3D freq_table[index].frequency;
> > > +	freq_hz =3D new_freq * 1000;
> > > +	old_freq =3D policy->cur;
> > +
> > > +	rcu_read_lock();
> > > +	opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
> > > +	if (IS_ERR(opp)) {
> > > +		rcu_read_unlock();
> > > +		dev_err(cpu_dev, "failed to find OPP for %ld\n", freq_hz);
> > > +		mutex_unlock(&set_cpufreq_lock);
> > > +		return PTR_ERR(opp);
> > > +	}
> > > +	rcu_read_unlock();
> > +
> > > +	dev_dbg(cpu_dev, "%u MHz --> %u MHz\n",
> > > +		old_freq / 1000, new_freq / 1000);
> > +
> > > +	clk_set_parent(arm_a53_src_clk, sys1_pll_800m_clk);
> > > +	clk_set_rate(arm_pll_clk, new_freq * 1000);
> > > +	clk_set_parent(arm_a53_src_clk, arm_pll_out_clk);
> > +
> > > +	/* Ensure the arm clock divider is what we expect */
> > > +	ret =3D clk_set_rate(a53_clk, new_freq * 1000);
> > > +	if (ret)
> > > +		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> > +
> > > +	mutex_unlock(&set_cpufreq_lock);
> > > +	return ret;
> > +}
> > +
> > +static int imx8mq_cpufreq_init(struct cpufreq_policy *policy)
> > +{
> > > +	int ret;
> > +
> > > +	policy->clk =3D a53_clk;
> > > +	policy->cur =3D clk_get_rate(a53_clk) / 1000;
> > > +	policy->suspend_freq =3D suspend_freq;
> > +
> > > +	ret =3D cpufreq_generic_init(policy, freq_table, transition_latency=
);
> > > +	if (ret) {
> > > +		dev_err(cpu_dev, "imx8mq cpufreq init failed!\n");
> > > +		return ret;
> > > +	}
> > +
> > > +	return 0;
> > +}
> > +
> > +static struct cpufreq_driver imx8mq_cpufreq_driver =3D {
> > > +	.flags =3D CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> > > +	.verify =3D cpufreq_generic_frequency_table_verify,
> > > +	.target_index =3D imx8mq_set_target,
> > > +	.get =3D cpufreq_generic_get,
> > > +	.init =3D imx8mq_cpufreq_init,
> > > +	.name =3D "imx8mq-cpufreq",
> > > +	.attr =3D cpufreq_generic_attr,
> > +#ifdef CONFIG_PM
> > > +	.suspend =3D cpufreq_generic_suspend,
> > +#endif
> > +};
> > +
> > +static int imx8mq_cpufreq_probe(struct platform_device *pdev)
> > +{
> > > +	struct device_node *np;
> > > +	int num, ret;
> > +
> > > +	cpu_dev =3D get_cpu_device(0);
> > > +	if (!cpu_dev) {
> > > +		pr_err("failed to get cpu0 device\n");
> > > +		return -ENODEV;
> > > +	}
> > +
> > > +	np =3D of_node_get(cpu_dev->of_node);
> > > +	if (!np) {
> > > +		dev_err(cpu_dev, "failed to find cpu0 node\n");
> > > +		return -ENOENT;
> > > +	}
> > +
> > > +	a53_clk =3D clk_get(cpu_dev, "a53");
> > > +	arm_a53_src_clk =3D clk_get(cpu_dev, "arm_a53_src");
> > > +	arm_pll_clk =3D clk_get(cpu_dev, "arm_pll");
> > > +	arm_pll_out_clk =3D clk_get(cpu_dev, "arm_pll_out");
> > > +	sys1_pll_800m_clk =3D clk_get(cpu_dev, "sys1_pll_800m");
> > > +	if (IS_ERR(a53_clk) || IS_ERR(arm_a53_src_clk)
> > > +		|| IS_ERR(arm_pll_out_clk) || IS_ERR(arm_pll_clk)
> > > +		|| IS_ERR(sys1_pll_800m_clk)) {
> > > +		dev_err(cpu_dev, "failed to get clocks\n");
> > > +		ret =3D -ENOENT;
> > > +		goto put_clk;
> > > +	}
> > +
> > > +	/*
> > > +	=A0* We expect an OPP table supplied by platform.
> > > +	=A0* Just, incase the platform did not supply the OPP
> > > +	=A0* table, it will try to get it.
> > > +	=A0*/
> > > +	num =3D dev_pm_opp_get_opp_count(cpu_dev);
> > > +	if (num < 0) {
> > > +		ret =3D dev_pm_opp_of_add_table(cpu_dev);
> > > +		if (ret < 0) {
> > > +			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> > > +			goto put_clk;
> > > +		}
> > +
> > > +		/* Because we have added the OPPs here, we must free them */
> > > +		free_opp =3D true;
> > +
> > > +		num =3D dev_pm_opp_get_opp_count(cpu_dev);
> > > +		if (num < 0) {
> > > +			ret =3D num;
> > > +			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> > > +			goto out_free_opp;
> > > +		}
> > > +	}
> > +
> > > +	ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> > > +	if (ret) {
> > > +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> > > +		goto out_free_opp;
> > > +	}
> > +
> > > +	/* use MAX freq to suspend */
> > > +	suspend_freq =3D freq_table[num - 1].frequency;
> > +
> > > +	if (of_property_read_u32(np, "clock-latency", &transition_latency))
> > > +		transition_latency =3D CPUFREQ_ETERNAL;
> > +
> > > +	mutex_init(&set_cpufreq_lock);
> > +
> > > +	ret =3D cpufreq_register_driver(&imx8mq_cpufreq_driver);
> > > +	if (ret) {
> > > +		dev_err(cpu_dev, "failed register driver: %d\n", ret);
> > > +		goto free_freq_table;
> > > +	}
> > +
> > > +	of_node_put(np);
> > > +	dev_info(cpu_dev, "registered imx8mq-cpufreq\n");
> > +
> > > +	return 0;
> > +
> > +free_freq_table:
> > > +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> > +out_free_opp:
> > > +	if (free_opp)
> > > +		dev_pm_opp_of_remove_table(cpu_dev);
> > +put_clk:
> > > +	if (!IS_ERR(a53_clk))
> > > +		clk_put(a53_clk);
> > > +	if (!IS_ERR(arm_a53_src_clk))
> > > +		clk_put(arm_a53_src_clk);
> > > +	if (!IS_ERR(arm_pll_clk))
> > > +		clk_put(arm_pll_clk);
> > > +	if (!IS_ERR(arm_pll_out_clk))
> > > +		clk_put(arm_pll_out_clk);
> > > +	if (!IS_ERR(sys1_pll_800m_clk))
> > > +		clk_put(sys1_pll_800m_clk);
> > > +	of_node_put(np);
> > > +	return ret;
> > +}
> > +
> > +static int imx8mq_cpufreq_remove(struct platform_device *pdev)
> > +{
> > > +	cpufreq_unregister_driver(&imx8mq_cpufreq_driver);
> > > +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> > > +	if (free_opp)
> > > +		dev_pm_opp_of_remove_table(cpu_dev);
> > > +	clk_put(a53_clk);
> > > +	clk_put(arm_a53_src_clk);
> > > +	clk_put(arm_pll_clk);
> > > +	clk_put(arm_pll_out_clk);
> > > +	clk_put(sys1_pll_800m_clk);
> > +
> > > +	return 0;
> > +}
> > +
> > +static struct platform_driver imx8mq_cpufreq_platdrv =3D {
> > > +	.driver =3D {
> > > > +		.name	=3D "imx8mq-cpufreq",
> > > +	},
> > > > +	.probe		=3D imx8mq_cpufreq_probe,
> > > > +	.remove		=3D imx8mq_cpufreq_remove,
> > +};
> > +module_platform_driver(imx8mq_cpufreq_platdrv);
> > +
> > > +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> > +MODULE_DESCRIPTION("Freescale i.MX8MQ cpufreq driver");
> > +MODULE_LICENSE("GPL");=
