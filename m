Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22982C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F7720850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bemWZ7Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfBWIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:48:58 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:8064
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfBWIs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAf4nhmHdLry0AG8wO4p2T0U5PDrNaQsC8bzTBBaMpg=;
 b=bemWZ7Bmh9+3JHQfTz5fYi37d2WtKe7qDwPACf+jIq71xtsli0opBn+p+8+loXU+GeNviSYWr3CoOECO0OORTq4fGBTZljTdQEATYuxATiWNP5jWc73o41nCJSPHEPQ93g9EauIBLkLXjg3fXHA2BiTr4O2B1h6S43iGQOWq10Q=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3855.eurprd04.prod.outlook.com (52.134.16.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Sat, 23 Feb 2019 08:48:52 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%5]) with mapi id 15.20.1643.019; Sat, 23 Feb 2019
 08:48:52 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] soc: fsl: dpio: configure cache stashing destination
Thread-Topic: [PATCH 2/3] soc: fsl: dpio: configure cache stashing destination
Thread-Index: AQHUy1Sa6XcjNUTofUqAEtVAuu5zgw==
Date:   Sat, 23 Feb 2019 08:48:52 +0000
Message-ID: <20190223084816.28985-3-ioana.ciornei@nxp.com>
References: <20190223084816.28985-1-ioana.ciornei@nxp.com>
In-Reply-To: <20190223084816.28985-1-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:805:2a::38) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.8.3
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d81edf30-b85d-4511-b68b-08d6996bbc78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3855;
x-ms-traffictypediagnostic: VI1PR0402MB3855:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3855;23:/eiDqIDdsQJlbrCdPNTqXS6GlpmasHhg58THe?=
 =?iso-8859-1?Q?DvHb2xDaBgghb4S46b3wZumKkNNJ5KE+yjOeltMxhwA4RA5AhqA1RBPgts?=
 =?iso-8859-1?Q?61XoeodOLFosLH6VKi3eGvxDGbQNoO6slQY20GPgAMzApq8cf4IrzHEZQF?=
 =?iso-8859-1?Q?Bm01Xpa8TxATq+A/ObQcuD/fNUnjXt/n4ybdR7Xla3co07LeYRulgUx/TS?=
 =?iso-8859-1?Q?z9e682GJ++sJIt3pGBtFLqvPAPGanYqzLrkPqdZ7LMmSgzVL14NI/4GawT?=
 =?iso-8859-1?Q?9Sj0s9V2iKCthCdeCOjkpTFzI6s3QKTihKDpNtiiB+3zQq1w6fxAAB0pBi?=
 =?iso-8859-1?Q?LKBBFF2ez6e2zXqLVuuwhTGGkQ+H9XmtsrxWaP2P942rerBDSVztbdCeXy?=
 =?iso-8859-1?Q?1RYV1n+/RpJzmuP5NgoB2G8QJF9B6Ls0eNBcQ7Yp3hHB5gR15kXVpSW2NU?=
 =?iso-8859-1?Q?SzYYV409WDkZRRqkyBF3Vo9nU1ghtFMa2SljzKww5zX/TLFlqHohM/pHNN?=
 =?iso-8859-1?Q?YF6LOPXNn0A73nr4wtKi8zqZEkGy82sSB3itEvNyG2JgWtNQwJWDnDq3/2?=
 =?iso-8859-1?Q?4m+HAl7fr34xpkpuaWYGGMyDp7rZuj5Jvh+5NNbNxDfWOyyyeZlBZZaJAM?=
 =?iso-8859-1?Q?kCF53A1U+othwFuezzbN/FzInqqZEKwi7yc2SaqYBNC3MJJz6hKDNZ1yjK?=
 =?iso-8859-1?Q?LZrLlTMiQVzycC6ZjoNTSjIqLwqMxKTH0JUGXLfzdeSyYvSxgAXQ9IWd4W?=
 =?iso-8859-1?Q?5xQa72zcoOf5BDuiwwBQLrrrNkOw0PqXpuanm2WSHdaRD3nXdvAsfo3fWF?=
 =?iso-8859-1?Q?spd3rDoQTk6TpaeLBj7cZoH4HdCW2l0ba2hxKjkkwtivya6nqtDHRFkPsx?=
 =?iso-8859-1?Q?Z5C52IGs77Lf6hQ5ESXRKLWFr31k7twluXTmSHoom2hCtRsl5rnvRz9vJd?=
 =?iso-8859-1?Q?wWILfrzHaAoBTy7fqwFhD2EXOpl1TOjJ4BPR36jlwhnKny44c/cCujqIIL?=
 =?iso-8859-1?Q?FGNtnjCxiRDtQLsW1rctsw/KTc6Uk4ylPgs3l3ZKIQDRWnfSiXqIci2T7p?=
 =?iso-8859-1?Q?J3zDLPrI1oAH7NUbTvao/wl6OMsqbGrHpHLvKw1DBh9ONHjg2Jua2q4mKi?=
 =?iso-8859-1?Q?mfM0/z3A6Q5oFcSez63RX9Gh0hMG3BRxzhjaNacQqFeV2Sv5PN/29B6YsO?=
 =?iso-8859-1?Q?Bbxic8m3sRjQBEKadU4TdrXXvtrgR7GcjOB2IUFe2eGsO0ySRVVLDXV16/?=
 =?iso-8859-1?Q?hMQjuyhVUB4xq/MZcieMribgdgmat16HcUdvQ2Z9JGjvBPAyjC/Jc5jM/L?=
 =?iso-8859-1?Q?ZEElp4do/I5gd3asSJls+umUg?=
x-microsoft-antispam-prvs: <VI1PR0402MB3855EF03FEE5C7E254D3C756E0780@VI1PR0402MB3855.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(486006)(14454004)(50226002)(71190400001)(26005)(11346002)(44832011)(186003)(2616005)(478600001)(71200400001)(99286004)(52116002)(68736007)(4326008)(102836004)(2906002)(25786009)(446003)(476003)(76176011)(6636002)(6862004)(105586002)(6506007)(6436002)(54906003)(386003)(8936002)(3846002)(305945005)(8676002)(37006003)(6486002)(86362001)(5660300002)(106356001)(53936002)(256004)(7736002)(97736004)(6512007)(66066001)(36756003)(316002)(81166006)(6116002)(1076003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3855;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /uybtH3vYCVOlZFtezoGUkj8WpSFcctl2qSnYZhVqZ08qdmBg99tvUBW2HRpc+yJlqTEa8h2nLtDB36g+u77KKN0CkSpq1qfh3nW3CM1bheBqFnUGnJYpEsu92oEzvq/nppJ+I55oH4Do++gbwUebLQoUV3Qkc3yfNoXbomL/WWpaXLIYAZNGKcz+exSvGjwuBMWVF97AWUOzsYCH1J29I6pgZy6/PKN/T8VRsQL4sBurNN9YGMs0Gb49p02Sw/10M6m6R0zl0wjAJUCyw0EjUUR7q87qzyJB34LRxqivAapIvO7YFP1lt6MAocCop+OAG9jFtaQlBkwUiX0w6gJzjA0+mHqlt/rrSt6NrvkH7j3ksQxESCKCrV6Z+mISSCRZlhlymn9O2eKz+7OAR3teEs3Ism0sB+0gVTdthg5Cz0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81edf30-b85d-4511-b68b-08d6996bbc78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 08:48:50.6639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the SoC version and the CPU id, configure the cache
stashing destination for a specific dpio.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/Kconfig            |  1 +
 drivers/soc/fsl/dpio/dpio-cmd.h    |  5 ++++
 drivers/soc/fsl/dpio/dpio-driver.c | 52 ++++++++++++++++++++++++++++++++++=
++++
 drivers/soc/fsl/dpio/dpio.c        | 16 ++++++++++++
 drivers/soc/fsl/dpio/dpio.h        |  5 ++++
 5 files changed, 79 insertions(+)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 8f80e8b..61f8e14 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -22,6 +22,7 @@ config FSL_GUTS
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
         depends on FSL_MC_BUS
+        select SOC_BUS
         help
 	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
 	  buffer management facilities for software to interact with
diff --git a/drivers/soc/fsl/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cm=
d.h
index 5814d2f..e13fd3a 100644
--- a/drivers/soc/fsl/dpio/dpio-cmd.h
+++ b/drivers/soc/fsl/dpio/dpio-cmd.h
@@ -26,6 +26,7 @@
 #define DPIO_CMDID_DISABLE				DPIO_CMD(0x003)
 #define DPIO_CMDID_GET_ATTR				DPIO_CMD(0x004)
 #define DPIO_CMDID_RESET				DPIO_CMD(0x005)
+#define DPIO_CMDID_SET_STASHING_DEST			DPIO_CMD(0x120)
=20
 struct dpio_cmd_open {
 	__le32 dpio_id;
@@ -47,4 +48,8 @@ struct dpio_rsp_get_attr {
 	__le32 qbman_version;
 };
=20
+struct dpio_stashing_dest {
+	u8 sdest;
+};
+
 #endif /* _FSL_DPIO_CMD_H */
diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index a28799b..c0cdc89 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/sys_soc.h>
=20
 #include <linux/fsl/mc.h>
 #include <soc/fsl/dpaa2-io.h>
@@ -32,6 +33,46 @@ struct dpio_priv {
=20
 static cpumask_var_t cpus_unused_mask;
=20
+static const struct soc_device_attribute ls1088a_soc[] =3D {
+	{.family =3D "QorIQ LS1088A"},
+	{ /* sentinel */ }
+};
+
+static const struct soc_device_attribute ls2080a_soc[] =3D {
+	{.family =3D "QorIQ LS2080A"},
+	{ /* sentinel */ }
+};
+
+static const struct soc_device_attribute ls2088a_soc[] =3D {
+	{.family =3D "QorIQ LS2088A"},
+	{ /* sentinel */ }
+};
+
+static const struct soc_device_attribute lx2160a_soc[] =3D {
+	{.family =3D "QorIQ LX2160A"},
+	{ /* sentinel */ }
+};
+
+static int dpaa2_dpio_get_cluster_sdest(struct fsl_mc_device *dpio_dev, in=
t cpu)
+{
+	int cluster_base, cluster_size;
+
+	if (soc_device_match(ls1088a_soc)) {
+		cluster_base =3D 2;
+		cluster_size =3D 4;
+	} else if (soc_device_match(ls2080a_soc) ||
+		   soc_device_match(ls2088a_soc) ||
+		   soc_device_match(lx2160a_soc)) {
+		cluster_base =3D 0;
+		cluster_size =3D 2;
+	} else {
+		dev_err(&dpio_dev->dev, "unknown SoC version\n");
+		return -1;
+	}
+
+	return cluster_base + cpu / cluster_size;
+}
+
 static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
 {
 	struct device *dev =3D (struct device *)arg;
@@ -89,6 +130,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_d=
ev)
 	int err =3D -ENOMEM;
 	struct device *dev =3D &dpio_dev->dev;
 	int possible_next_cpu;
+	int sdest;
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -145,6 +187,16 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio=
_dev)
 	desc.cpu =3D possible_next_cpu;
 	cpumask_clear_cpu(possible_next_cpu, cpus_unused_mask);
=20
+	sdest =3D dpaa2_dpio_get_cluster_sdest(dpio_dev, desc.cpu);
+	if (sdest >=3D 0) {
+		err =3D dpio_set_stashing_destination(dpio_dev->mc_io, 0,
+						    dpio_dev->mc_handle,
+						    sdest);
+		if (err)
+			dev_err(dev, "dpio_set_stashing_destination failed for cpu%d\n",
+				desc.cpu);
+	}
+
 	/*
 	 * Set the CENA regs to be the cache inhibited area of the portal to
 	 * avoid coherency issues if a user migrates to another core.
diff --git a/drivers/soc/fsl/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
index 521bc69..af74c59 100644
--- a/drivers/soc/fsl/dpio/dpio.c
+++ b/drivers/soc/fsl/dpio/dpio.c
@@ -166,6 +166,22 @@ int dpio_get_attributes(struct fsl_mc_io *mc_io,
 	return 0;
 }
=20
+int dpio_set_stashing_destination(struct fsl_mc_io *mc_io,
+				  u32 cmd_flags,
+				  u16 token,
+				  u8 sdest)
+{
+	struct fsl_mc_command cmd =3D { 0 };
+	struct dpio_stashing_dest *dpio_cmd;
+
+	cmd.header =3D mc_encode_cmd_header(DPIO_CMDID_SET_STASHING_DEST,
+					  cmd_flags, token);
+	dpio_cmd =3D (struct dpio_stashing_dest *)cmd.params;
+	dpio_cmd->sdest =3D sdest;
+
+	return mc_send_command(mc_io, &cmd);
+}
+
 /**
  * dpio_get_api_version - Get Data Path I/O API version
  * @mc_io:	Pointer to MC portal's DPIO object
diff --git a/drivers/soc/fsl/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
index b2ac4ba..da06f72 100644
--- a/drivers/soc/fsl/dpio/dpio.h
+++ b/drivers/soc/fsl/dpio/dpio.h
@@ -75,6 +75,11 @@ int dpio_get_attributes(struct fsl_mc_io	*mc_io,
 			u16		token,
 			struct dpio_attr	*attr);
=20
+int dpio_set_stashing_destination(struct fsl_mc_io *mc_io,
+				  u32 cmd_flags,
+				  u16 token,
+				  u8 dest);
+
 int dpio_get_api_version(struct fsl_mc_io *mc_io,
 			 u32 cmd_flags,
 			 u16 *major_ver,
--=20
1.9.1

