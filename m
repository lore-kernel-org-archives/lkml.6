Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E5BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D69321901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l4wjwtPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbfBMDJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:09:29 -0500
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:58720
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732110AbfBMDJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESTAN2xODOVRrMPO0gHEyfekXMIGo93RGB9zhn3yZwc=;
 b=l4wjwtPQaDIAWtW3zKWzNdKGX7NarNVrsLbELD5Ta9gbX1tafPUdqn1WA4SJcSe8onvk0r7v3G9r1dumvQmEhgqPDmkmOPnjV70y+PUF8yq9FVlDk3sg95tTIgxIIUlZltQ2LWYF/b+bhopvavF4wSKiVNaCdJdX15N/GyogCnM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 03:09:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 03:09:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Topic: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Thread-Index: AQHUw0mAk7D4InMTwEi38x/B8uOIAw==
Date:   Wed, 13 Feb 2019 03:09:15 +0000
Message-ID: <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3724;6:AoEyeCor673jgWKrFPJoIPWzaF59eOY8c0d+waDbGboqphftwrUN87TzpZI8PjjDq4Bd8G8RzjUC5esKwT1ofEwPBBEs+LON5RbBoU7z5IxQTOqvIfPOZ0Abdp2psfqq6dAGy2SgDLzCZ+3JpQfNq2qsF0Vci3Uy7xkgIlwegjQXHz09XyP1xouvRbL2EmcLHo2uAoiyTCv4PhYQ2vWIxDSTK7bag8ww6nkhRo8Pi/YU7AfWO6xHD5Gsefsu/qW5Ru9TIpMi+rGzAwEAONP8H3macsbxfB9FDdUyoY1fq5XJRLFekeDRVcEkG272KTFNDLYIlmfZDYgtPgcpimg0glZ05D5WSvMEjh8oLgCdy6Gd0f8TXy9rJUys5aZ0EuOwMSw52FHL6DXuOef80gvqzs9rQWhUctMyduPTHnikB/yC7OABPzMIPt7CHB6qbh6zSp646Sit3rbrFpsCEIpxfw==;5:YF6A17F3y1+0FDbZ+c0Sp1Pwk3iUyRY7nkqH+mxRjPcGS4xZ0gRGiiMJidlAoutWY7m/6bNil7hPaEIrMpm6LThK7XtgIb/FxmXrXcBwBneCF9aAifM6mfB6ABxPTthGzosMAgYCDGCjPeE4cB09IRfEQDRWcMvtZoPBTNGDdFGd98f6GCvg3HHp/LTYNkfzC1Lj22UEtJqCpGvzC+9rdA==;7:Yp3WaPRa48bUqGWgznMteLy4qFXk9jkY0CIgVjjFuKhFusbibkkVbUJi/09XOpPuszEuBpQfznaYM94iQabEacNmoLRVMwf8IvqeCaBsDVYr3KiZshRfZvKtc4S2131+qMRhNjqYQB8aQ0kF4TfHiw==
x-ms-office365-filtering-correlation-id: 5fd999be-9608-4a72-f87f-08d69160a29d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB37241E93573DDFC90E1D749BF5660@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(50226002)(97736004)(81166006)(81156014)(8676002)(7736002)(110136005)(446003)(305945005)(2906002)(256004)(52116002)(8936002)(476003)(486006)(2616005)(99286004)(11346002)(3846002)(14444005)(7416002)(6116002)(71200400001)(71190400001)(86362001)(36756003)(26005)(53936002)(478600001)(68736007)(386003)(2501003)(14454004)(186003)(102836004)(6506007)(2201001)(76176011)(316002)(66066001)(4326008)(105586002)(6512007)(106356001)(25786009)(6486002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Adlm22p5rshd/trynX8g4zOyTtQfA3hx7V8+zj6wf9NQtmyxuhdDY4XWl8PEs3kN/5JlQmJxH/ktft9CdpqUW4GFpD3xRGQG8SVDqPGfwOXnyJPNLknLuLQAl6gFpG8vmnc2gbVFGH/cfats3ZeApzm1Dg2T+bu0+JW0wHUxLExu3D988RHNTrSnBF+8h2qxOd7xpRq+7j1az/A4NMM7YiLAIxMeVlfRQBIz9v4fb2N1s/Yeu2d1puJgIh8UP3OscINLYxFL45rEfVN7GaYyexVmmtSvdLPFj/EOUd7KHl8vv+HWqtJuQvispo4Pzm8rUp0al9ffgPJNJ56MCuc+Vwy8D8dukXuvfZ1SQ/AJ+q7DWG55t12DqjWyRyPuMhEU1BpHqmppUZ5V1TG9Grwrj5O89/GCaibdTAc2bqOuwl0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd999be-9608-4a72-f87f-08d69160a29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 03:09:07.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NXP's i.MX SoCs with system controller inside, CPU frequency
scaling can ONLY be done by system controller firmware, and it
can ONLY be requested from secure mode, so Linux cpufreq driver has
to call ARM SMC to trap to ARM-Trusted-Firmware to request system
controller firmware to do CPU frequency scaling.

This patch adds i.MX system controller cpufreq driver support,
when doing CPU frequency scaling, cpufreq driver will do ARM SMC
call and trap to ARM-Trusted-Firmware, then SIP(silicon provider)
service will communicate with system controller for CPU frequenct
scaling.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/Kconfig.arm      |   9 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/imx-sc-cpufreq.c | 183 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/cpufreq/imx-sc-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 179a1d3..6d76465 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -92,6 +92,15 @@ config ARM_IMX6Q_CPUFREQ
=20
 	  If in doubt, say N.
=20
+config ARM_IMX_SC_CPUFREQ
+	tristate "NXP i.MX SoC system controller cpufreq support"
+	select PM_OPP
+	help
+	  This adds cpufreq driver support for NXP i.MX series SoCs with system
+	  controller inside.
+
+	  If in doubt, say N.
+
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool MACH_KIRKWOOD
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c..28ab9fb 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+=3D cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+=3D davinci-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+=3D highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+=3D imx6q-cpufreq.o
+obj-$(CONFIG_ARM_IMX_SC_CPUFREQ)	+=3D imx-sc-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+=3D kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+=3D mediatek-cpufreq.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+=3D mvebu-cpufreq.o
diff --git a/drivers/cpufreq/imx-sc-cpufreq.c b/drivers/cpufreq/imx-sc-cpuf=
req.c
new file mode 100644
index 0000000..dfc89abe
--- /dev/null
+++ b/drivers/cpufreq/imx-sc-cpufreq.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2019 NXP.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+#include <linux/syscalls.h>
+
+#define MAX_CLUSTER		1
+
+#define IMX_SIP_CPUFREQ			0xC2000001
+#define IMX_SIP_SET_CPUFREQ		0x00
+
+struct imx_sc_cpufreq {
+	struct device *cpu_dev;
+	struct clk *cpu_clk;
+};
+
+static struct cpufreq_frequency_table *freq_table[MAX_CLUSTER];
+static struct imx_sc_cpufreq cluster_freq[MAX_CLUSTER];
+static unsigned int transition_latency[MAX_CLUSTER];
+static DEFINE_SPINLOCK(cpufreq_psci_lock);
+
+static int imx_sc_cpufreq_set_target(struct cpufreq_policy *policy,
+				     unsigned int index)
+{
+	unsigned int cluster_id =3D topology_physical_package_id(policy->cpu);
+	unsigned int old_freq, new_freq;
+	struct arm_smccc_res res;
+
+	new_freq =3D freq_table[cluster_id][index].frequency;
+	old_freq =3D policy->cur;
+
+	dev_dbg(cluster_freq[cluster_id].cpu_dev, "%u MHz --> %u MHz\n",
+		old_freq / 1000, new_freq / 1000);
+
+	spin_lock(&cpufreq_psci_lock);
+	arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+		cluster_id, new_freq * 1000, 0, 0, 0, 0, &res);
+	spin_unlock(&cpufreq_psci_lock);
+
+	return 0;
+}
+
+static int imx_sc_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int cluster_id =3D topology_physical_package_id(policy->cpu);
+	int opp_num, ret =3D 0;
+
+	policy->clk =3D cluster_freq[cluster_id].cpu_clk;
+	policy->cur =3D clk_get_rate(cluster_freq[cluster_id].cpu_clk) / 1000;
+	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+
+	policy->freq_table =3D freq_table[cluster_id];
+	policy->cpuinfo.transition_latency =3D transition_latency[cluster_id];
+	opp_num =3D dev_pm_opp_get_opp_count(cluster_freq[cluster_id].cpu_dev);
+	policy->suspend_freq =3D freq_table[cluster_id][opp_num - 1].frequency;
+
+	dev_info(cluster_freq[cluster_id].cpu_dev,
+		"cluster %d running at freq %d MHz, suspend freq %d MHz\n",
+		cluster_id, policy->cur / 1000, policy->suspend_freq / 1000);
+
+	return ret;
+}
+
+static struct cpufreq_driver imx_sc_cpufreq_driver =3D {
+	.flags =3D CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
+	.verify =3D cpufreq_generic_frequency_table_verify,
+	.target_index =3D imx_sc_cpufreq_set_target,
+	.get =3D cpufreq_generic_get,
+	.init =3D imx_sc_cpufreq_init,
+	.name =3D "imx-sc-cpufreq",
+	.attr =3D cpufreq_generic_attr,
+#ifdef CONFIG_PM
+	.suspend =3D cpufreq_generic_suspend,
+#endif
+};
+
+static int imx_sc_cpufreq_probe(struct platform_device *pdev)
+{
+	struct imx_sc_ipc *cpufreq_ipc_handle;
+	struct device *cpu_dev;
+	struct device_node *np;
+	int cluster_id, ret =3D 0;
+
+	/* wait mailbox driver ready */
+	ret =3D imx_scu_get_handle(&cpufreq_ipc_handle);
+	if (ret)
+		return ret;
+
+	cpu_dev =3D get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu device 0\n");
+		return -ENODEV;
+	}
+
+	np =3D of_node_get(cpu_dev->of_node);
+	if (!np) {
+		pr_warn("failed to find cpu 0 node\n");
+		return -ENODEV;
+	}
+
+	ret =3D dev_pm_opp_of_add_table(cpu_dev);
+	if (ret < 0) {
+		dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
+		goto put_node;
+	}
+
+	cluster_id =3D topology_physical_package_id(0);
+	cluster_freq[cluster_id].cpu_dev =3D cpu_dev;
+	cluster_freq[cluster_id].cpu_clk =3D devm_clk_get(cpu_dev, NULL);
+	if (IS_ERR(cluster_freq[cluster_id].cpu_clk)) {
+		dev_err(cpu_dev, "failed to get cluster %d clock\n",
+			cluster_id);
+		ret =3D -ENOENT;
+		goto put_node;
+	}
+
+	ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster_id]);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_opp;
+	}
+
+	if (of_property_read_u32(np, "clock-latency",
+		&transition_latency[cluster_id]))
+		transition_latency[cluster_id] =3D CPUFREQ_ETERNAL;
+
+	ret =3D cpufreq_register_driver(&imx_sc_cpufreq_driver);
+	if (ret) {
+		dev_err(cpu_dev, "failed to register cpufreq driver: %d\n",
+			ret);
+		goto free_freq_table;
+	}
+
+	goto put_node;
+
+free_freq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster_id]);
+out_free_opp:
+	dev_pm_opp_of_remove_table(cpu_dev);
+put_node:
+	of_node_put(np);
+	return ret;
+}
+
+static int imx_sc_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&imx_sc_cpufreq_driver);
+
+	return 0;
+}
+
+static int __init imx_sc_register_cpufreq(void)
+{
+	platform_device_register_simple("imx-sc-cpufreq", -1, NULL, 0);
+
+	return 0;
+}
+device_initcall(imx_sc_register_cpufreq);
+
+static struct platform_driver imx_sc_cpufreq_platdrv =3D {
+	.driver =3D {
+		.name	=3D "imx-sc-cpufreq",
+	},
+	.probe		=3D imx_sc_cpufreq_probe,
+	.remove		=3D imx_sc_cpufreq_remove,
+};
+module_platform_driver(imx_sc_cpufreq_platdrv);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX system controller cpufreq driver");
+MODULE_LICENSE("GPL");
--=20
2.7.4

