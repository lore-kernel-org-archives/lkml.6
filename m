Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeDWDva (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:51:30 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:37856
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753988AbeDWDvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:51:25 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
Date: Mon, 23 Apr 2018 11:46:57 +0800
Message-Id: <1524455219-6736-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:YZ1UgbiEAfv8Pge1GXRMwQgnli7KZhycSnLEMf6zWaLnfon4Yfmtj9kD15PBMreB7QjD2D8pMOjoDK+I5uJHxDhC50mVI9bnHgkUU9l7Sya7aayjlVCyyN1lA27LiDSixqxeSvJF3LbRQMCqGsQQHhhEwoC9QrpEkHMg+zGGeigeMW30NpXNqDcvJxkpOnYkzT5QdOc5cwjJ2YksKRsX7PFi9IhDsa56s085lcgS8ub8kbuOVKkT6YVP7QzPEwI/;25:GgbSe8Tu9w3NzOaXZeWdLpFevVsjpND2y/bzllntPCJSlz/zv0zYib9Pe54AkGMJrTECHAJe3KobaWGyGVBKhpum7R88fojigEkT+oH1YyvOnm5aRSYzXLJIZHjxhMz7lQV51jqyv/2MdH1lMJX88kvRBejIVN7yznycZZtJyvYb2W37HkJgL0nPX3DalvRK20E/ZRjf7RWs1uOjNt8Xz6gFKvNHR3vdv3dmHM1KiZqzwwi8p0DjUJ6oAaCvd0rnsG8zwncxBF2h0UIQ1+oK+MUb0aLStZWBHbVrj27Bms1Ub3chNrQgHJ36ZMglojJI4ws6LMO3t0UVHWAn9feFEg==;31:6h8Df82cbgCMN7LyY+lJLnoMadUm+0fMPsUKj1UzUdkhduPe4QZG9D3myMRm0uf23nAOgD7vyVGnKyIobPwegcWhs2cIKfu+vfqh0jYCK58WKJAtN5dYZObWsvibgfUxNXDTR/jS7NC//aka969cgXpjScQNRN6eKxZxDwBtPa4A+Z8FaIoZIDHt3SFPAht7bAA6VYCQ/ihDVfTFtMHaMywjrw1bMFXXU6RbbzpLkmw=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:TcKBdo+ffUL336k2/rLbsxsPxRMWOj6k9riFxvMjtUDD4U6f1Aoe0BiQWoQjufWIPj5Z6/pbcDoVyEGZ+eHiC+KDwQngVWbFQX3C4Nkp6Qis6vWUsxFFe+07P5JNOB5ZoQUfWo9bqSz+tE49NXY/p1BX9aMcrgVPTecK8Htx0msEBBg+qvhON+CH9/8lED1+D/qLAhUjhmJ1OZnlDh5riT5qLhXey1Wos3nCz/t9CGi/AB9uP446OxhO7pPQnDT2iTrDwArnoBXKbEBY8fKyjJMYBglDByEyXvBlZdOhQ817POM8FsfX4Ho1qnkVVQBTfKrRGZXkjIKtmG0eUkjfYOVpD+qK7m3qQO3sIuAnnLrPhZQ1lWV5LNke+vLLv0qlF9MmDMt2BkUyoAzhrfFVTJL+q7NuJtlsXg94dvsHdTM6DNY9MsYnj4f+lDs4OQYo3Du7gi1bjHjbwM5YPjtuNPsLjdrYF4a2uGl0e56IYtkKEn/dddjrbWHqK1ML/40y;4:Cz//rAuANpjKG8MmHCuNtqx7+Dhho8oKb15mvkca3xl14zIXY1zGHbG9BwxieqIYDvLp79LTHPTqdA23zZBLGqBkb5rzBH6XR+PhLPepFEU1OOG8AP8O7Dl7ruQ5Tviga7sW3QLj3s50U7iQvOEQsBBXTEle8BfLSoPQAs5wqeQ1iAM5i4uBzt6sb9IbPQoyzSHKuK34CyS2UO+YlcbK7pkjf5x4qsFU+YYu3OwMQlPzVC9E2+GKYZDm79CgxrxXr4UVsdvK026gDdG1hl72Adq0EtMV/ovcBbqON8sVFtnrINKdsrlhUKhnZVkRpe2U
X-Microsoft-Antispam-PRVS: <HE1PR04MB1324CB7F16F2AAA47328C788F5890@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(8936002)(6666003)(26005)(186003)(16526019)(386003)(7736002)(6506007)(6486002)(2906002)(316002)(16586007)(478600001)(76176011)(52116002)(25786009)(4326008)(575784001)(86362001)(36756003)(50466002)(6512007)(53936002)(446003)(11346002)(956004)(2616005)(3846002)(6116002)(47776003)(476003)(50226002)(305945005)(5660300001)(81166006)(8676002)(66066001)(48376002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:dQlkWqrcSpxy62a8kccvtJja9wMhcAjV22QdAPeae?=
 =?us-ascii?Q?T+NuayL85lZkgGyd/rE4DhmhEQIE9X9x/G5HVd8i+LmoxA6GlNuKihDxAXK7?=
 =?us-ascii?Q?+CT8x6b0pCONQgFTTOwKhjYX3rHgFtgpACdvBn0cCTmSi2BeEBegK+9MxxkV?=
 =?us-ascii?Q?/Mz6qGcGS+urPYqIIiq1qZgaKIvMDEgLQPjBVOthrEITbzVTFLSBxs1SXgli?=
 =?us-ascii?Q?h868IujFydChYQiE1MJ4B5j7c9LnRTSPOzfycpDUVtPbF9X6g26CzfAaorZO?=
 =?us-ascii?Q?GKvhZbyD9v4B3y0dw7MGsFjlCLxWtZCjRzunBj6buhqPgp3Asoh4Mm12DbNt?=
 =?us-ascii?Q?ripcjivTx5ruqIybghDK6iUOXoCOIi841MCeJ/zeI4POdUbgf44iCM+jCjo4?=
 =?us-ascii?Q?XZUtVIIUR5uDqvsDpKXup3ZHgJOj8BhM3syU5weX1Trckr2f8xBIteK/HMUQ?=
 =?us-ascii?Q?gB4p2l4f83lnwm/+ztMDUhysEWJSapohHvmPdMOVAQlnCMsyacrD+dznEOqq?=
 =?us-ascii?Q?Rc88y68n+9nOgKpmEkCUlDsYJEIpTF66as5P6uiyoH/Bl8FhE3oR9X86GKU6?=
 =?us-ascii?Q?EpPNI8KBcJvYyHRSKlkn4j/7PNjl0aZOSMl4Fc1pCUH572qNJ89np+TDUVYw?=
 =?us-ascii?Q?08fHB8WLRNT4EtSPyjpGsp1TkZ9pyIC2KdgacR/7BSnSYa5b8ZnylPER5+9M?=
 =?us-ascii?Q?t+aDsKyYE/qI1qgqQmqVVCYthFTTiuMpUlLzRJqf+NbCUwJrYN1RP3VhxQA+?=
 =?us-ascii?Q?a2wlFLAWgxNJtKPQui8ZN2/LhArIVGVs7zQl0f/FtbQEaepHzJYBvWMFa6ZR?=
 =?us-ascii?Q?K42tVdsX7jguAgMEN8c28ATrE6eHaI2PJI1bJxoRnISFsCVth/rYlSz8J22Y?=
 =?us-ascii?Q?ZW/4RjXxjyWFW7h3LgIy+Oc+Pp9Qmz+l++ImFrWlCRsvx9TpPRubK+6eDQDq?=
 =?us-ascii?Q?NKccuwX4IPmngENVPIgrBYkl6kBqDG+XURAuZ0iHKYvUVdPuK3UffXqzFp/o?=
 =?us-ascii?Q?xolyJD5Ucn1VeDZ43QldIfr2biUMOKBGrWcFRc9GqeavVr5vhZ84vNbZOkrA?=
 =?us-ascii?Q?fyN7/o=3D?=
X-Microsoft-Antispam-Message-Info: fYmjHZoJ/VnE+ucQG1l/C1w3Xt/aQpgQ9Iuhtm6lRArrqCrv9KiJzZvgizfIz9VCPOzjEPpC9GVqBoW7d8fGuLyNqbph3fzn82bmF8JvCqTt1u2Z81KhZweLVZdXQxvUZjLipS7Z5eT7sfhbUWx7Jgmak5HGdnNH7ONEHfAdoF0qoYJyJiPCRodh8IiVeksF
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:J2UZCFrZCiXVh452k1h85owbTp6fhgjk6oyZxqgEc3TlPVWrgLXVplvKb+2oxDGr3UvlcX6RVjZkRsujdyoBc9ViNafeyQYHur/tWWSJ+WSxylutO4EB8mpd3q/NM+wBvBSNjwDKxMapRMTpd5Cn/FNky6PlNrpLgfTjns9GVT2Q/4+X+q4hYuVdWS7UPxTl4t1GFMF5m+eDmjjHPuv1G70igG+hQ898xSiUNnVOY8u2OozqIi1g+XelFA9zmeJU4HSb4VaZPHA1z4T08kgcAKE+B+cEcGksYalZ7yjZ3XxegxhJcSim0QZPwqnOzha8PpFT3ThD+d25WTm6J76WnXu2lw4A5C4VNbb+c5rSA9T16enIZ18m2wNF5QoDsNqzGRZp/NeIzBsM2AvuNZmlbMeOP5+YLe0GXYGs79knyrxli344A8j6u5TocNE1Jh2H6h52zS1AGlwlW5U4QBiCAg==;5:+c9zhExaB2re80uNlo9EVcy1ZYP/dHc5BW65GthQSBid+lwBIsCCDblFyWW0/aVRlTrV9riZCKxegsPLkgovEOw8lpVUfsLXMDjIWBWJPi0Ob+28XveOXyn9WIv3YdlBAlgujo21dKidIAGEMgztn+lizz0cL+tuki4EjBaGcak=;24:qLdIoZpIxpd0aXlcVAcqpXVVK2bR+7H6M1v6bR8QB+fKoE1I0ThmjAYpdJHgGIGWKG0RLzdg0n1NIU5SlwzHHYqNQRJlXVbq6j5T/41XFSQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:zsl1dx+sr1Ftpj0JAMJbX0tYbFY7+LhCFnmH3pQ4kxOMHlMVOVt1qOgtnkvhKtjxTq3Ug+PRlpg9+2feA5Ki+GMJzM+ZS/WhatiPYPjxgy/ouBUzyXqFinnOIevgdcQxuARAUOOLcGbRt1z/CchWD401EwdqHd+19HjqAFsDBTxVlihXkMBgrqxe2OBhPU4ZyN7TxMWYU2hA4TZnzcQLx88fQ1k7QV73kQljMhrVDeBikVRygjVW5ytisO1q3Z6c
X-MS-Office365-Filtering-Correlation-Id: 8ea300bf-371e-4866-d161-08d5a8cd7a5a
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 03:51:18.4826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea300bf-371e-4866-d161-08d5a8cd7a5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has two max7310 IO expander
on I2C3 bus, add support for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index d59084f..812f40b 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -82,6 +82,13 @@
 			>;
 		};
 
+		pinctrl_i2c3_2: i2c3grp-2 {
+			fsl,pins = <
+				MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
+				MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -272,3 +279,24 @@
 		};
 	};
 };
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_2>;
+	status = "okay";
+
+	max7310_a: gpio@30 {
+		compatible = "maxim,max7310";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_b: gpio@32 {
+		compatible = "maxim,max7310";
+		reg = <0x32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
2.7.4
