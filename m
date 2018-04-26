Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeDZHDn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:03:43 -0400
Received: from mail-ve1eur01on0078.outbound.protection.outlook.com ([104.47.1.78]:65264
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753067AbeDZHDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:03:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 5/6] ARM: dts: imx6sx-sabreauto: add wdog external reset support
Date: Thu, 26 Apr 2018 14:58:17 +0800
Message-Id: <1524725898-27974-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:604:d::30) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:2ALmbhnD6wfFR1EgDfdMFT3OotYlV/wGUA1iR8O+7F+kv/Ae55BRkKs9CQlpVOB6pPSMzKgHiBJwyKApBnQ0UjYVCyE5dOeRUx1+u74twQvtgLgctrxure2uW/GlzNUxxcC21T50g5QTke/wVK8n7zj/RX5xYv969z/ttEt9s5GVXKpQsJh2p5/4+TLcQiIyb6Xp5/pfqSkft7VzKyKzN1H6pKuKjMMUGLpA0B/Ju78YwSYDVQhfWhOx6O8DXOHn;25:0Np6Su4LP1ngRbtSt99AZU/QdWrKWBfRig39T1Ys2h+cxwyAV9ZJ6d4jYFPuwRMTJUiOdvnLgVKwdxoyBittuq7JMVEyRF974yt9Re4xaBStsP0GXuAJjNSeeS4qbCCLNs2B2nwVkztQof3aTqiQOI+zPoTXiEtJ4KsJt1qJ/HJV82QBoj/Je/vAuVk4zHGo4Lyg+s+i1/JhQudMcmGJR9Fg9OFpoHBP7kfkcsuxVHOOQ/e/jS/wRHft2/DIp67NPlg0/d/UpG+gwOs0HzOfYh4hGrJijFe1MCJQvTvbWZHV6v1bUVSXoYOYH9ifEgcpecpduWuOHix342e8s6CmJQ==;31:EfhzMvFQZL+THAOEn0708Ot6f9B6pqPGJ12pRj7qQ7BEdv4bHS5sfUJ7fmYoAcqyNUOf3n7kmsRgE29Y1Xtgmr65fJXQ7RZuRYEmetZ6GrOxYtxhakM1xcC0GtTZJJq2nPfXEEROvlLw/U1NXIMLqgK+txqJ7LW8SRyR2w7x7PYtXpgS81/M0UdgDP3otaFk/N5bkd1s8xrGI2fPkHkx5sn10rlAy2vALrwKQcJSdzs=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:DmuGjXDj5ugzRAN2+7SYHyOjouUJ8v3LsGWxGKWdcJKVoNeVflB4MJYpWHFI+Irs4W1MY0PQwKalVPY1Cxu9PUy5OVqF2gEUNYywa7KZVm9Aggt8DhEg2d5YoZ1ePf8s86KYY5wwvALYn2yzRD8BK1iCby4dfmwz/nnohND9muiJQDWj4mfwbKSn8KYAaquvflHbVgcTsvNx5RnmQmPrVziHt32CKm60LnQ9PV/BQYyAn+MXAcsbaxbNA0MrGBI0hRvU7TyqIsJd2vhJcd6OLSjqq5NyUsX/tXj7Ty4IVoC73Bkqh806LYmq2/GmZAB7sVR91LxONohiavFbfVKBCKOnfVSwaiXsc1o/pid3ffB6FTjwDSSveQPA66Ue+4uMlXConlHOJWXm57fv6CfVai3Eqkmyf5d2ao4OAuF7mwSCOM8KZeN4zj4oE3umVNS0WkMdNx/EzFbVw2y4yaBdZXzgaonwx9PT++3GQLfA/bPWfG+eBgVqCjsiv8MynLkK;4:9XVIbWuOIvXuNf/J1ezrwnCJwm6VajgMjh+lC5bsqLdBKSBK6n2YtiBENv8M7cxuVuBgl78OkwBPijHL1lQom8g6CxhDJDH+yWrUpGR7Rf4AGIb1xmEXdOTkKuCZccx6u5VQY4BI9d6E7urVKXg9CF7iZ1WbYLS56GRE2HNw9osREhJGqmzXwn0YLxUDa+4rsqgDnX1Je/3vrgBMvyJJGHQ2G5BNMYzGhFdUP8VAUamlUNJgiRtPVI4b/HXVGPAqRPIo1tA5THmrONRC+mwkEwZhyMRJO83l4+J87rC6SEb4+RQH2HExfov9j1jHEmDt
X-Microsoft-Antispam-PRVS: <VI1PR04MB1327FCEA9E0BE9A3BDFC0D0FF58E0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(36756003)(2616005)(106356001)(8936002)(11346002)(6486002)(97736004)(956004)(50226002)(25786009)(305945005)(7736002)(8676002)(81166006)(6116002)(478600001)(81156014)(446003)(105586002)(16526019)(6666003)(51416003)(50466002)(3846002)(47776003)(52116002)(386003)(6506007)(6512007)(316002)(16586007)(76176011)(26005)(2906002)(186003)(53936002)(486006)(5660300001)(4326008)(86362001)(48376002)(66066001)(476003)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:ee5fTUelmlxB+Y4X13GiIplwgZN6Pxpo6ExdJLUjZ?=
 =?us-ascii?Q?IJ15jSGdHUghUx26P0zhFjAWaz7H/lEAOPZyGwVZ95K8tn3YqeTz3USGk9En?=
 =?us-ascii?Q?Hx9M+hQGUUK6ETdKPS0w/DZOQn+9/UImzkw99i78y2tJmJvp2X87YxwSpDC9?=
 =?us-ascii?Q?cVMy0cJTC+xCxJ1tWqd5a/AuzuHQuwtKbJ9umlZv5z2nYOVtkhdpzUoZJ1E/?=
 =?us-ascii?Q?cAgimAF74R8UQ74sgv+azlEh+/9FOuzuTbj97o2OnrxguzHYTCB+LdgkFvvy?=
 =?us-ascii?Q?DGyOr0TMaMHrW59BMfNEDUzoqSReKVPfb0aTPQreyJvgaTFIF/GFICAmvQBH?=
 =?us-ascii?Q?PpgX5266+F0+Im0wIgYEKEwGckcHOSVngTfQrB04gYmnYCmTUVfsbj25VNbE?=
 =?us-ascii?Q?bd1qMOK9XKeXlthhXc6laA+z6lVDZdR/NwSGN3OXFqCWIEGb9BjthKjJ4c51?=
 =?us-ascii?Q?A6ryJakR4nGdWlKHk1JWc74f60mB+TCPQnayucJbg0c07Trf4addGgmMO2MU?=
 =?us-ascii?Q?8d8svi/ldGDYiDMhOsB5/HhfeSBji1hplLTfy6B4NtLah/N2/RsS5CIN6ogG?=
 =?us-ascii?Q?N/piUMbkKPUT3/m7W8yZvofN7ztkngultGrmwG3sKC3OLtVkEji+Wp7OpZBq?=
 =?us-ascii?Q?pQHaCwsgF3yJRoGv4rOaZC6LRrhxQNVA1a1o9CTVAQOgHWP90vlsZAtEs/Dv?=
 =?us-ascii?Q?KoxV4x61zf4ssviIu95kSLQfWdtmzS3RLfneBnA3mQ73dXgIF2JeonkiWeX8?=
 =?us-ascii?Q?XtApxdSs7l97kyljVx5lSgUAkKcu3vG4dIJbG14jkdzyb1TzHF71sM2iznD4?=
 =?us-ascii?Q?pNKe5YLM9dIG+XPzruh/Qrw31KWE5QFzP8XXEvX5UQxrocWcpQ/b2a9J+dC2?=
 =?us-ascii?Q?ajTLgLaaxuI+dHaE++yoev+zJM6sX42zPX+S51+x+6a73Nds+gsRS9zzenuZ?=
 =?us-ascii?Q?lT69eQyOAWSIEFHosgDj/RzziH6Ev8dN5fG58H5H419TJaFo/2Tx4QsL5IXU?=
 =?us-ascii?Q?waPiy/6do8L2iC8ZKJbsAAkce59lPZm8xvuZnnydeuyCHWDceHrXHPrvwaAK?=
 =?us-ascii?Q?KYLzfXXtUQEAlRZfzxnf79zmXGO8FFyzkFSi3gmkCyoi3azdPzMana0sgy/d?=
 =?us-ascii?Q?8eOeUAVnXLTWiIzq4Q2GkxYjjZSvdjmSzgb9fsPJ/NJz5JBWi7IaXONJe9Kb?=
 =?us-ascii?Q?vZKfz0SCUnIFIc=3D?=
X-Microsoft-Antispam-Message-Info: wTcnLIbfDnk6ksjdoJ0YoiBqFmYhq63pdzpa6TtOFSx8o47WLXEv+aajMnFDErzIlJzDr13p7hbyqxtdgvTNanc9LdG7zZMA9YlGo9Sk7xP3iuzYuU+niBQbvhEo5vJUL74l115/tk+WMrvxmLa7nWockSkUkXVWeYh9GhxLeLW1VwbiXuTVMGmoYIxYrpFg
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:W0cZUKjpxHQ1i7S/BAkUdFkjAFIw9wBkeZJXgCMyZsN02G8bjCizRJWFWJn3g/u0M966F7zxjq5si+47BfJ0op9fP2ERGOPGrGkMvIEBBfCrtnVliiU2y5hzZKW6KojCHuK/tl1C66yDLKqB0h0NYyT55N7cI4Pm2lzu8v1EcSr4QXydNSiuqeayxU/KiLL3WACDugXnViXX+kLfnBWQiQN3IAslLpfDiH+5Rd6/sKJvUUAR974dSIyYOOyFowWmEb+FvewHUJhn7+T6jvLMHn22pxkIZOoxGgWFlI+yzdhdYoB/6HnoGE94EUmccdHV96Zf9+YHD/aRhPWY90Wg9kQXhuZ+PyEM+qXEKw6muLVZCMWAqVkj6++dh7g/RXu3dAM48VNgx19drkscIy3RScrWL71gxMi/ZapEC5JAxf6qPXDeUXLqVN+qQvqwqR2Q2z++DbrvyJouL6mRJJzUGQ==;5:PuDJCfSoA5H7I681vuIy8gTyEK8AqCFXUQ0oq1hIan+3K3LPyBUSoL21MrX6VFZ/WCkUPpdZN1BwJy8uulESCvtXMD3R/VflM9tr/UnLgx5grd7trTWRSYekiRTenINCFAF6wRmPMPJCTWOzKjIf18zAWIKP1QgxAHuxzUW2LbE=;24:BJ/3GpJa2w5oC3lAVVloLPy5X9xjOveElXUpuvytqf1OuNoOz9fQiclp8FJ1a5IQX6tMtmtVVf3Qgt/5livD6IO3a+gDtpQRXlQWK2fRW/I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:ISZaPsT1VvvKcPe9ul5YjXnZFUmipLXDGOK6Es16vRqb7ndSoTvV+88pX79UiK47Xf4HUphI/ORztwvMhTk6IDI82Ex770htKXEPWg1UY5ckcaICvP6KoGxHcZefFpLliorGYNBxjGArKMIBh/fLkr4yO3jZNVl70v6I60i9hrWB3r1LHgfvgT83rrp4sABVAQ+jTVwd/i46wrl8asOztURXpvZKZyiT0epaZFgw+18kZAvL/W8CgOFkJbiSsNMJ
X-MS-Office365-Filtering-Correlation-Id: 0088600e-091e-42a5-68a8-08d5ab43c3ab
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 07:03:03.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0088600e-091e-42a5-68a8-08d5ab43c3ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V4.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 088a66c..eb1452c 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -241,6 +241,12 @@
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6SX_PAD_GPIO1_IO13__WDOG1_WDOG_ANY 0x30b0
+			>;
+		};
 	};
 };
 
@@ -380,3 +386,9 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
-- 
2.7.4
