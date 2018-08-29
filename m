Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82551C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1941D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vU4KzQHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1941D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeH2FoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:44:20 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:6938
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725199AbeH2FoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p49UIgzdVYTvMYstQ34oGqJxEQEVwCRrVllAMN1N3s=;
 b=vU4KzQHMR24yu8DlXl2PGXrTHsdCQa+Ls1+T8Ok42+nbvVv25kkPmwablH3t+njvvLPfOxEPog7NDNL9KIkJ2cpd81RYgXztx0F/e/FLXq06dEvdkuyjoE2XJmnDI4FZGg2I8tuTti5ZVriN27qrH6H6BdpVA8rhfDK36a2aa0o=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 01:49:48 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx7d-sdb: enable gpio buttons as wakeup source
Date:   Wed, 29 Aug 2018 09:45:38 +0800
Message-Id: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff159b7-cfc4-48d2-a840-08d60d51b67f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;3:ZI9QLoRKBzCx23+QSZk6HvUGRP95beHQVcmUGscbuDR+KzYLsFniW3xBBQkd/5FyjyjAF1+rQDtL+FkxeXnklQLK8TQwTZ4jpGpyE9yfxpYFZM56g8tvBrSukQjlPT9y38pa4II5T+t3HioEu+KmbxyvVEzrYlYmn4+601/LEJSjrEMhwt+SWrOIjQlR9N/LrgFPmFlMGtjGmBagdSyOjHEiL6dxd08Jb8MB+TqvHN5/dhsJPuZw4svINCuVvRwV;25:/FyzWXGkjAt1SILU5AFDwNm20q+L2fd1z9tX+NXpLRSHCDajvzZMlz76wsxCXsZwPfp92/MC2QQgDc0BqQMJuwoUIs6EPCb+zkmy5ALeh+XdsN00QJuSrXzXzKUY2nQjR5TDy20eti5cRMBNc1VY8IL2J+MRrUI+bMKVSBba9Qjlxf6UfdbVR1arhp9T/K6Tbs+0HMwK01J5c5aYViIvGJ81KsNbw7i3B/jLaJzvk+VdsNLIyntYQ3gZ/DyZYi6qluKPVMsml+y5UTXOIoB3oY3tIIBNv7umy611+8p28MuVxgra8gTC9HbEwqGeElnOmVwJ5N2iCDhg8Poh9HtBvA==;31:Rv5bgDatdMsTXS+sQIX/DqirBkE6N5GjpUtRplBE3ImGEfxR+vh/Gam4VLFLf06rZL3f8HeTywJxKm9JmOPt8hYGIkaKKgBREGBFbpUfQZbQq0ZGcZtq/h0Wq9BiX6Jt3bccwYciZ8ENSuJjSxeh/sAwR00NfJ3B1Kn0UlF6+8NgRnkKmDOtApDU/edef4DDZkzBp3MGz8tRhR7e34aFu5R/DWH2s5wNG1FxVpIq/Pc=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;20:G7MBZ3YNikF/3DWkPRTEFraiJNOughQpQ+Spbm8M7skGzOg6WE6/hJ0zEO/qn5yVcAxPXe0pD81tDXJwqxfqjstgAH9r6k0h83CWus8e5EXz2lwQE6QiCf5TPWb/snf9gwztN+MrB2MP0xai3MgmdlbXfBHfstKp1Y2SW5kdi78Ezb2Hm3A3LRXxLl35mo3mdLLSZOnHMIXOKq2T58Zo+/rcbDn+Hy0m0ANXa3VCKdtFMpjvCZQCCrEUlxNlSdR1/RmyHMmvFqFsVLvtwu94mHdqSbVwSl5t7qcjtYP3OLg4fl+O50MuoctSvflvS0Mf9HsJrpRmZ0833CnQY2/9Q5MSrMwJYSVno+UHHMVfAk4yf2WC3/giZjD8AT4HRmNNOgJpZSKdrcQncI/qvxVey8Fs96DLtorxW9JVMNFtFtMzaHvKrJFfHw+H+/xQC9RnmDFA8ZxVDAX9pCsEWOvgbnVZ78azlbreofCONt7NsIILqXAFyk+I1yV/2NGe6BRC;4:gVhtaZmL4KLkMoDax4bRuL29h7Zq+1Ui+k85o7FEDnFA63xZSYKJ5jiQSzBqMt5Zg08tXcWk6GSPdNH3tMzts2iWqa9rQat5QzOKwOLxbqGmLrhvZ8EeCoT7Z1ZW+3mYKet5baEgVWKevVfWIaFT73gu7bslxXgZxCwkgnBW4RjTDKFepy5xj6/ENqCZY4Mdxe0XM5wuFuSy6A/JrZQXp+Hv2aH87fud6xXd0sHaGFedULhK+BOvlpNXp683NgZ79EG6YQ7gVGmIDRZmU1SrYCKl2NIlQcgZqTNTDhT2JjVny+3JnJ2Lh42PUWwhrfNS
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916409A484B8A21C8C956ACF5090@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(97736004)(81156014)(8676002)(81166006)(53936002)(50226002)(305945005)(7736002)(51416003)(8936002)(2906002)(186003)(6346003)(26005)(50466002)(52116002)(25786009)(106356001)(478600001)(16526019)(48376002)(105586002)(1857600001)(5660300001)(36756003)(4326008)(16586007)(316002)(6116002)(3846002)(6512007)(6486002)(6666003)(386003)(6506007)(476003)(2616005)(956004)(47776003)(86362001)(68736007)(66066001)(486006)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3916;23:6tRy0mSCR8qH+YonQvE5IPBW2Z15aSERAPwb/zn?=
 =?us-ascii?Q?Hlf+QzzeM0a5aDRzKEwTK0PoerRECzEkAPDZwkps2APxR/kbhrxw6DlVnMe2?=
 =?us-ascii?Q?0sDZloosLqA09YBliZPIKOzXX6jN+kggAg3Na1eFssAG2Z1ZJZcCx8Fm/2Jv?=
 =?us-ascii?Q?VI+UJPYT03wFXWZ4xK7cK5oc0OC7N3ve4mU5Cgxm9WN6pw4sZdHfjU17xj+7?=
 =?us-ascii?Q?wqYD1W6qbHFPw0zT4nuKUlzLxTgwy0PNBnz2fw8/LES5e5+vpOS0WJOFSSB6?=
 =?us-ascii?Q?PCRg1EIDAVZGByfzgK+e+uoeHOMsYuXlft3KT9FF7HX/Aqk/ydTDpfYbtau+?=
 =?us-ascii?Q?0+dqvh3L2JWLO8+wYrw5eapuhca3+qodvtRkR8U9Eno01WWSqD7RN2Kq0Ras?=
 =?us-ascii?Q?7HPIl44g9Z2R/2LNWZyZyFhWw57ioExyiw21mx9gDvjPpEUuF3262LeiLuxZ?=
 =?us-ascii?Q?Gqk/YQ8j7NeMnoQn33dOhbROWOBhaGqrDXmoreSgsxaueGLjGifTvI2yt/iL?=
 =?us-ascii?Q?8XX/MWhgMTiNbm2XrRI4jq3/b/nhdTICKKzVsXtsy1xQqEU8TYWcnjO9qoSU?=
 =?us-ascii?Q?h18PRrkt2XEU0NV7udpfax6O4EcWROTGnBylt/OXBO5L7gIOdFnLk+IPzSTe?=
 =?us-ascii?Q?JIHbq7MTEfxqEuXQXxL64y4Y4AUt6e0cskVkiIrOkQW7LsmSR10dGltGrpEq?=
 =?us-ascii?Q?pSO2gppLZG8kN+z0ejm0/D8FVdM1BPWDRJWd+KKF0llLG9JYzTmmv3zWwAcC?=
 =?us-ascii?Q?XmG0DbVLdAcX09eHIqOgQ1WRsp2JDovruFhZcUuuGj/PDydneS1z9imecXBn?=
 =?us-ascii?Q?09CP29ktiyudmj4ZYiOPgA0CR4vpvkQbQX4xfZeILZoJIQTET3rRvKa5A5bP?=
 =?us-ascii?Q?zQ5o9K6MRnwgRogQ/nXGcUy59XZ1LMFa2RcTFMjsbwjKDF2isedUnqZIRct7?=
 =?us-ascii?Q?/bDXbGDPpzk7o5YQAFQEirBmXSSEh2U9QEtFWWdZGbgmuEQ9dw2qpV4czJBd?=
 =?us-ascii?Q?irB8c0aCO3xIYJykEMM0txfNZQhbx5zZEiH33NdcJ9wjNRd5/1e+cnNf9/Cr?=
 =?us-ascii?Q?7Tgoxmi2VE7x1H8T2aMhfG3CUBk47Flj46y5ynwMkq1YJl8xNkoL20OzGy0M?=
 =?us-ascii?Q?h5nBPW9srRpLWYf+K4GfEEoyvVTFDNM5PBLepR+cG3GVhUsKH8bf4qw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: a7HXA9ZAYeijxW80/VGyaEPZowxpN9K3I6oAWs+fJqhejsG93FxuFlQBSMqV1+45XKrGioQ5RrNOOytNWaeFYsJxpdgXGFFbYEuGEaOva6A8+K6SD1k6fqvjIw7ymIKtlAqUm8Og6U2JLSgs1QeiGyctiqH+NE682pYDA+NotLh921HXnQy6rpAJZ+XPvRzEJoCPDGm2uFpZoL+vxRqw65qI8FPyxgOzAyOOOFQEfTT+2QLHkRD1Usp10OH1l+I2PG5k9LJyBEBjEe7k5NMflB1DrKXYglYMVBcQb/LxpLpOlxBBhLzrYqJMQE9v1i9l5pdo40XHiX5iI48tyTdow4IRA2eY6xCFewiUJ7z4mig=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;6:vur78cchASI0PmGIldHKPe3MLrvCnoXfDWF2wiXlAcqOmGy7GWik8yHZTbnBDI0eHgyvxrnRaiExuuhH6zueLK1W5B4KW3qDDatgwNoOCYaCUA557NHDn1t/BbIiMV5YxxkX42V8beSPzlmd4JeKloGi764XIqN3rNYWKXMjLjXcvAkr/4kjiOEumZgXu+xoyDnVENiD1XxM4VoR+lSl7+ntNjsUQq/nmHuuERvFcAyyLrsiHaImv/tOhxzId4fdnRldHDvs1dLJrfkiysVtyNR+uiWtHzCdgXYpI/z/f2YVEtezdZjrv7qAyhKT+h1YHbPZ/e1EojmtkC48PbTuEe29sYtxV58tTAXnH/mOo+eqxwf2JTQ8PS2Y/qUKXdwCW00M/29Z8v7iJfta9rKt4yz++4JZFGCQWnYQdqwosp7ZD9pqo1YRjKKlA2A9sMP8Dg72ulcpkqDFBTsEb+lE8g==;5:HvjlAetMOKZ4qKkGKQz3HchYsX7aSHzAJ6CcgQuVsYJ+Y8faDO/bAlN3ETlOfuk4ChDVmoJf0Q6/jmW7K254OFVPsxm6NU/FM9lzeO2hESUHTeWDXIgzHkzc51LaznNifC7uq8FpQdR+AQZq/P+EqD4qvq7JxcSpu7BLiw+VW3g=;7:egGwwCwEO8ekCHbIpbaKgC8v+fr+f0O2wyPILPkkmBGGYUH3acP6HIWDnaKj/LjIdQ3LKoCvqPYUchEBKirF8hAjUnQt7jtA64TLeKOPyjLg5Lzf+kjtIyfqannsp5bfivzqX9NK38CcFPBftteRp4+eVzgV3m4bdiWYrMJUhQsarrPmjulqZMUdeckTH15rAvv1p3H8iHXTwUyrOJCfrbHyGQQEAqVqxpbruksiFwL0qQzEGZj1rzrtwy96c0dG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 01:49:48.9850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff159b7-cfc4-48d2-a840-08d60d51b67f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables i.MX7D SDB board's below GPIO buttons
as wakeup sources:

S1(FUNC1): KEY_VOLUMEUP
S3(FUNC2): KEY_VOLUMEDOWN

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index c9b3c60..f1bafda 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -27,12 +27,14 @@
 			label = "Volume Up";
 			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
 		};
 	};
 
-- 
2.7.4

