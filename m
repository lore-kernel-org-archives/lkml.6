Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A01C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8B120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dR4oOIv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8B120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934344AbeFRIQT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:16:19 -0400
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:61833
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934284AbeFRIQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkrqN/dTyWPDrRuyiaVKAETUV+ThyPNcjrDnSrffVMU=;
 b=dR4oOIv6N4UunNGmbNwo2yVcBpOPs2QOGhRQppiVM4YOxmeOSb0/oKrdAy6dKxQHIYdFf59ZQGSqP1zC1c7+C3C/xSt3paE6mC9xBduyGJErDwX7O1aNCVcRly/3WtBmNiyCdRWXEBF4mr2X5cL55t2skDuhyorKU82JPCv1AZw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 08:16:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
Date:   Mon, 18 Jun 2018 11:15:44 +0300
Message-Id: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM0PR05CA0068.eurprd05.prod.outlook.com
 (2603:10a6:208:be::45) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ff8f40-9904-4665-a356-08d5d4f3be88
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:g1RUtWSFC4xnBGK1k7I94nbh7rOzTNlie1IfF7nRooDxVc/3XrvoNfr10hmoRhyCz/DaH8A3btW2nUBp8DluDJGa/fvreCRmKDSYgCGeK/ODhaz2d+NC5CGRtB2XQs1yqZ+OKS8Fg6RjPi2Ssatux0UDZp+IWRhOLBvuIskf91tSefsH540lANlZatkoqn/RAgbIrwYVajdtzz9Lo6UR7Gv1BkVIGnjkSxpx9wJT69F/3rAgviwjFRiWzcQDF0bQ;25:CvOGJ8tTU0DV/4UwFiFq0uOW1XfX/EiX420cUApwKuEaCw6a87p1zn0rSPYfb4VRgcEeFV6uWP5IYgK04NTHatzrp+z9fqPUgq2OV7lbCiceg6f+Omsh0E5MXtGEzZTXJG98UuUPDiUhQqsvSuHE/Nhyiyv9nm/U7CWMOf4oCnRPZlh47+H7adOTPys1mlvfRbYTTiNm1utO7SRUTGckYPs1eEIg+68hwqD7TQlmPyuCmLE4E6QeFKnJhydDoS6B8yAji/u1XhbS8iniGWgBwPx3nMGdkhxbz3OVkCr31WyLqu1p5gspRk1i3RJMUnQDZ+LTG1EHnNqqyNaQ7aMxSA==;31:n458jt7DsU9QXLwLvId81egGOnGiIv9OL387fBT0vrGE0hpmlgyi4fzXzm1Lnu7Q/DwjLiPnqcVeCvlQHd31znm4qLKbtxTvjwrRoGMdlcnmLhxHazPUNqjhOs2te9xQiQ0pguA1xDoa/UHP4DoNnQI6zSHpc1vc+e7gVeES3X8o6SU5stvA/C+I5wTD+rq1NOsqe6afMLMvBN6lZRfvF7FpLpKgtHya/dZIhZ0O+gc=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:IBdZAyjejcHCQ45wgCt/rLUl2mG/TrZUGqsz1BxueRqsxErSTZbWH44XbfU5ZFSBBhl41my0vcs9ZP9rfPhbkEAwGBzcjufcpb38QMjco0q4nJbHUyu7B4TGf8FEhNUWk1YFfj3lGMwM4mti+2QE9cIdt5MDU371MS1M2ut/9RQKNmx3qDg9Drv/8XEM0OD4FCjG94a1PpBFDDZC7kzOkbJkerHR8Pf697rMqeyy2kLGYnuBkhzeydoGvycZzCvMIdxzUfJFplSuF8WGKU5Qn9tU6sJD+lNYc5D/P/5SQ21sN96ODzA43WEyxBVglHLlZRR6XScumlIjWaLKiVbXsDd/fsm5aXEWUIOW5EU2LBNfns6tHJFDKeftp6bh7DOWDb82ggzIDxgK7JBNh4p7iZEFabf9KKivgEbhBgNDm8sgCZTQ9IfFhS3BeZ0KIXE3D/ij0e8jEIBNAL4z6yX7XCADDSdRx85Evq8eeAdQm6H/+RT/0crT9rxsLoysibTz;4:Rdj4Sk8Z272Nij8H05fQ5bass6VPCFZi/K5JTK/q+/70PPg9D9H+QkQefAt3wOTQOf4CsASmAMCc2G3x6EOCOx0S/LQTCe/sBGZuG0pOUs9aGhFszIA6a0fRjdpMk6YE51dVW3d8nFxo5RXDjkio+/lpVTSoPPnJ/d6Od9nKaCeB6ivKV/wiphk2Ba4KLYTZsti5fV93S84nR2J7Tuq7UrGJ1iZfLfjF3ZxmvjsvyvqJITRH/ghxw8l6/dTUf+v2MWStK0k7sN1Ff32zaJZnip0tYfk64HvB2G0s184zh/CRXGPV7njA4Rzsq7MjmcvW
X-Microsoft-Antispam-PRVS: <VI1PR04MB430123A0AA1E351D4BA021BAEE710@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(39860400002)(366004)(189003)(199004)(26005)(97736004)(52116002)(5660300001)(478600001)(47776003)(7736002)(51416003)(305945005)(2906002)(6666003)(106356001)(118296001)(6506007)(110136005)(6486002)(86362001)(16586007)(575784001)(316002)(6636002)(6306002)(6512007)(54906003)(386003)(486006)(2616005)(476003)(956004)(6116002)(3846002)(48376002)(16526019)(186003)(44832011)(8676002)(50466002)(68736007)(36756003)(105586002)(66066001)(8936002)(966005)(81156014)(50226002)(4326008)(53936002)(81166006)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:uQqxdZxtmVEYhJ9+ZRhs//Jqpw8q/8AC8n/X1zLrP?=
 =?us-ascii?Q?kWx6fvK8VVdAkPK2M7OAOTYdxRlr/IFo3UsjoDSXi2rw59yymCHTIbn863y+?=
 =?us-ascii?Q?9ntmPE9gVUHMBvlf8bvzNHUw95vCkfC3joiMTmosj6K+wxya/9GdeMdxk6tX?=
 =?us-ascii?Q?VX3hJ0W0VLo9z0r+fdZBJNrfnLMMO2ud+nAnddI16bcGxcZdtyXbkw47kfNU?=
 =?us-ascii?Q?uSeFLKnY8w3N+T2lx5+hlemF97YdWkQr6Qtiqo2X7KA0fcFe/wOc2iQEljrX?=
 =?us-ascii?Q?9A8G43OsxvbVwKFj8chnnwWgOPiV/YwxK/Zf3q1mCeU8qHTA3M8xuEdDEZl1?=
 =?us-ascii?Q?emXCNxDWeBVg3rydwdkrbrieZu9UdECsYlKmRY+JHIxhc9u39Y1r9+/o+/3P?=
 =?us-ascii?Q?e61IsliyCTuOuoBv6mlhzzxF9PPBuMz02pkIHFp+c5UNF/P8R/qULBv5sLdK?=
 =?us-ascii?Q?vbzCuS+EsKQvSn5w7E/BqpvdPxiAWTIvwChkrTFNLqElMKgM0eUPANohnPHG?=
 =?us-ascii?Q?KyRo6/TcA+w2l7pmr4jFSWgL6X+wc0JT5NiyBl10L1xfHMMXrRdel+0m9tT5?=
 =?us-ascii?Q?TsacG9L8KpYTFUZVgULSc1AMFVTbK7B2VUz6yliK90mfTkW/diqQpZpDdmqb?=
 =?us-ascii?Q?e1C2YUxAx5nm+54kgUReuyVII7mn2ghfxq66r4xfcxMlPsUkqDXL26liigBo?=
 =?us-ascii?Q?cc4iy+kB5T3LyCylWCbx6gNU8gMMeVVpdfGOHqZbgPoq3nrlSyD2HtFbOiXq?=
 =?us-ascii?Q?WJFRcGYyQaDea0KY30ByX8OiwWNLvzqevmiSH258Z5aWg3NB1eZ21XRCDnzz?=
 =?us-ascii?Q?2BgIsz5nyTzPeDubdWekwnj/4ryiihQGhkap6TtynPE5tnKeb17vkUMMyz3E?=
 =?us-ascii?Q?YEDseK6PS5DdJaAc1s3XeMD08YmOszwahvhiBNvK9C8C2nid5eBwnWl7HVAj?=
 =?us-ascii?Q?yIWOOqdjqVVSPwPL7bzYq4dbvHTUeDvjT2GuNiz7o9RFdAQYjRDmen6S+Ck/?=
 =?us-ascii?Q?iF9wvG/Ad/m12LtVywqlADjVKzpaAu9gFk2JOp9EVFEZAeVxMXAMOb9QE3vV?=
 =?us-ascii?Q?3YE10ofUxMf7eXw4FrSPUAogp9/VSvoPlr3IOYuj7/X0Z93I39C4JoByeC79?=
 =?us-ascii?Q?sVmseRtw1EPiUMYBUol1KuNyAUbyCSBl/Wwqbcf6zSFd9hPa3WXX7FQqz7Uf?=
 =?us-ascii?Q?HLsq56rhHrCM6p2McPoe1Qt+hMqAIn0jZUqVW+foFJY7OsEs/bMRc1CjK6uS?=
 =?us-ascii?Q?GKiYVRgxil4Gm8rFjO7ANJwTvABIakq0awXOYse0AzV8JTOU0g6X0EwRWMA5?=
 =?us-ascii?Q?5VvDaNzQA7WlPd4NDLvQNY=3D?=
X-Microsoft-Antispam-Message-Info: fN9wx0ah2yGQXd2BFH2bqEdaFrTnr1coKPW8Q1CEeJLySAzOalb6TQX9MXXfr7CMtSz8o10azw/ySJFXpluttai72HKhdRnkooFBzIIYIvoOLNiQcXsy+HpjIevkkYHOg/QAMITE3YQ9lPLq3FLBfv/vLhN3FAhBgGa0ubJ5XLfrIZ8aXKbtUjOmzdKpsw6yiFHRb2NQbEJfqWP+iOd4w3lfqJ5KTMgJr7FD70+PUA3HBANu0Jc7uP8vib+wkObPREKbCJ+Kpgr2CrpF8QID/gNiAB+QKZX+Y3tHG3p4HEG7hkbjfE4KoAO/Rha6Djw94Fu2vJL9r1c9MNy47/bP2g==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:hXUC+qgJTi66XbEORGPEvH0iMEDmM/oweFwDM+bYJ3nYq09S4SF4ELpgRIojwOAnJKcfePEsrYGV7DV4S5rM81hDZlrW54MbfELHc/mSfgd3fgL8BfgL0v+oqYoUvSdtqoPGUFTClXqX9Do1nijWweH+El/Qn4jPUN5YNUd8sM3eLn29MY0NnWPPYevhLrdA0sY01+sgoxQ0b8DMJ9QZIn3QgRSI290oGlYcMbKM/HpL08qeu3OLisRdjHz57CvralOBocsphJ7fn5bsVJ3MWcCsjL9Er+vnqCKYi1u96PSaqSAXq26WmWosl40dAz5T8QL4koumhqBhrWh2SbecA6Zvr7qv3E+HvAOgbKYZJhGTHUCnC0A9sk5+c4iKHB2gbQsrwxKwqtH6puozFQ7ihljj6w7QsLHkR/AbQeiiqRjCx6rsPbjUta0qBILaAe4kcyiyrB2UDNLNEi3dnLDHFA==;5:0y6LYH9/YorRnzoOGQ48BkH2a/wVZizqjMyJsWGYAB6d9HXXIiWzGvRrXcrlX5cHrkOZLKhsZqfnnYhVgpUazQE/pZDMnYxVv+z6ZqRuEjQdHHiNYrBcvDwgv4fuAMnvyPGs0R2zyJh0sf/OAeINNUJdvMzHEZXCDipOm5AnLN8=;24:UO2uiB1dXhBipJIyu9z115eUGBfsakp9VZJNfEszS1fuzIOyY4WL3We2zBe+Qth06y7NxQy6mktThyji/Fsvnr49foYhOAxHvPK/Du++rsQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;7:Zldj3YtoQ4IBb/wk8Kmis4wlbT5vNuEtOOX9Em7QqD8eRdv/Dx20w451oYmLmIcEcpydc6ytNzFnCqZxog7pOpg8QgF5YKLWaIGU0EGdrzzkJnPmLkAvRPBxdGZeLspQ8AJy3Al//i87Qiz0W+BcBQgLU0ajN3lITz5Pyduo6XoSmzFdJyCnPJ576ruzUa0A7YoS9BmEw/Idl6LWmV0hXpHKmHl2AKBonD8MFU0zPtDkv5ytxk4YAShbyjCOz1OY
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 08:16:07.4965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff8f40-9904-4665-a356-08d5d4f3be88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following sensors are on I2C3 on the baseboard:
* isil,isl29023 light sensor
* fsl,mag3110 magnetometer
* fsl,mma8451 accelerometer

Added under i2cmux/i2c@1 because they're not otherwise accessible.

These are all supported by iio with following configs:
* CONFIG_SENSORS_ISL29018
* CONFIG_MAG3110
* CONFIG_MMA8452

Tested with raw reads from iio sysfs.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Changes since v1:
 * adjusted node names (Fabio)

Link: https://lkml.org/lkml/2018/6/7/970

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 0e28e36ddbb2..a59a0fd1eb02 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -153,10 +153,31 @@
 				compatible = "maxim,max7310";
 				reg = <0x34>;
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
+
+			light-sensor@44 {
+				compatible = "isil,isl29023";
+				reg = <0x44>;
+				interrupt-parent = <&gpio5>;
+				interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+			};
+
+			magnetometer@e {
+				compatible = "fsl,mag3110";
+				reg = <0x0e>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <29 IRQ_TYPE_EDGE_RISING>;
+			};
+
+			accelerometer@1c {
+				compatible = "fsl,mma8451";
+				reg = <0x1c>;
+				interrupt-parent = <&gpio6>;
+				interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+			};
 		};
 	};
 };
 
 &ipu1_csi0_from_ipu1_csi0_mux {
-- 
2.17.1

