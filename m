Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A9C65C28
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365A120652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ENxF8Q16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365A120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJHSZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:25:34 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:16928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbeJHSZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gtJml6zR0DDXzh2usNXkD5VBdPANT7RIlSy6sq7U6E=;
 b=ENxF8Q16nPBUbK5wUDchcj7UDXca2zJx8L9aP9nqD9H1AQ9O5saYsLpfTbXg0UsCC9PPw1m7QSREuSkNAlqjZlVo6frF2b2f76W1fMQIBvlEAQauJdsaxeNBU09kHED9IMhWZofq/8p68A4feXLoE7dNeyHal2EU9oqaz//0uM4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 11:13:49 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 2/5] dt-bindings: spi: add binding file for NXP FlexSPI controller
Date:   Mon,  8 Oct 2018 16:41:40 +0530
Message-Id: <1538997103-11152-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483ee77f-c122-4b27-469d-08d62d0f21f1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:hoPjpxxFBJ8/wsTcmD82O9qRJaTOye4FpmCnnzF8sSODpMAV+XTfCq/EC/YNGUJcief0ee1ebWRhMkWZlmN5Vl1JBspk2JTZ8NbIyh6GMR4DQfJSXlDRiRkdMlxbwXDsYyVW2HEnu6VeGfhidYjT5MVDx4G2+hMjdRnSisSZfmz1/texUXz0PuNR1JJRroavY0JGhshd+/nCUAe4Z9uXu2Hy1bVPDpPapTKqe4POkty8T7Amqa0QbkQOe8CmMAd/;25:1zK8iPKAUbJsvbnnWpFM8l9XBSS4/VJuGWYXfGbkNe+zPtfOkgojojMdO2h1KHADGbHJazK0UAsldHufzfHXEOcj0iljjX2vrzLV1MFDZmpu4BHjvq5RzkGdcAgwhw6XA5nmPGv5DXtiC4Bzu1N5kOlRTuEpwEkcuQbiZzSt1LWzfY/Ipc0m+EYCi69Fc3Ibp28Ri2kAJ6I861as1RIzxWykF7Pq45mKaT2HwRd7YzM1Q0EjUBoLy1ZhIruNvsiBlotcuEmqw+jWmJHttZXxeOzUrPtj8qv9MIapuC4GN/LTTfBlOt80YO89HHzdllETVxgZVcf2Yemb583Udne3og==;31:WeDbvZx1LHUMHYYVC7ZOdGKfv8ub7fPVbcS+jTmdNF2Q7yYkWQCECUXWnfq1IhhADjEwXfgCbicl4iJfd67eMXnRelYWaE6nzLW6ZEEUPmZbpmynqPslbJT4HJSRMGcAwOYl+4jPnDo70J6WvnegrGsE8tluPftxKj47CbN7I1PPi396lr4oZlKmvH1cYYErYuijB/JeEi7Ffond0qiw5anmgrlhrLhjBvq0wsONYE4=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:DqR6v4ayNnnpE7Qly/WX7sOb6zv35uRK/vBORPijmq5K0w9QJ6qefpjU3wJUXCpOMrhKmUcSDqspErw+um6XTCOPvF0/yksW0wCq8fqitLYSCubyP75WpnS94L0WJfP1K7yqC1/Pd/JJQ8tgdRhoaUH62kSQ+rtaRu1x+AE1i9DXOKe3h+u4TjbUDrnwEiFetnoDztPwBFKBc+RsTPmQ9SYIXBeKX+mVDpXdZjeuWJK5yDHNJHJJhvppYVMHnzlTye6nL1m7ejwlliVKXFrklC4aJQ0l0zGa5Dj8P9toNX6SWmrftEAYNcz8frlUFsvtW1RRczo0826/ukVFy7WzjMFlEbGlVn993W5kFR9kEZ+8RiRMrma8mbgSd78At7LFEZdn+gmvPo590wdh/JPLySnJ3iE5kr/RZGa+Wd6+PzMSymmNxauUjqMxQK33AJDFW+gVeZ3FP1BjCK3C8ij4qE1rnug6Kn10FpTZfgsqrgaelnA0XL0YUtlGiplccJ+Z;4:bziVnRvInMbGzEeCZphSFisT/riBY70nGNx5vmWZmp0twLMQs3YBsOE4r8WVQ1/xfYOb+6lhfCdqqHuWiD8o3KTZhpu5ePKcbGmJUWqme6BH9pSug5pAFK+G+T/1d4ZiMmq4to44rgHeknCI1ku4WOkFzZu1WmeqLJS5CBvKUqmDLtuP5BBweFNZrTbvgyPGojWhRmk7VOTt3Xoy2xYGP/grO4fcC/rZIrbTKa2pMb189xN+r5Hv48vPRV1yvNJy4Aaa+X8v4atsU1DJmVDULZ+RgNTb7LMHNLY5pa79T9IfusxivKPAx2QOv6zo1gZg
X-Microsoft-Antispam-PRVS: <HE1PR04MB1034A969E83F71C928CF5F1999E60@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(2906002)(16586007)(105586002)(6506007)(55236004)(48376002)(316002)(50466002)(16526019)(6486002)(186003)(53936002)(6512007)(68736007)(26005)(106356001)(4326008)(52116002)(5660300001)(39060400002)(386003)(5009440100003)(51416003)(76176011)(97736004)(47776003)(7416002)(478600001)(2616005)(956004)(66066001)(25786009)(6666003)(6116002)(36756003)(476003)(486006)(86362001)(8676002)(305945005)(81156014)(81166006)(11346002)(446003)(3846002)(8936002)(50226002)(7736002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:YUnwSK29kfyGYKbwN35lwZtCD8ojxTni8B9OxlQ1K?=
 =?us-ascii?Q?ntMBmTsGagZbP7p+rw+ZZ7UtQX0ZzcKdCa7TtRDrVFVrqb93vy2sPWfw/zbo?=
 =?us-ascii?Q?GMtORgQf5gqzuuTQQQ/wuinY0aRKkz97FVpY+BaLqO9KgrhHVg5cT9uQoAo2?=
 =?us-ascii?Q?BoLD0Xrw1Dz6uS+k/uOLMhJHWVTBp9fsCPT00aNmSj5NIypInaV0kvl1mxJ1?=
 =?us-ascii?Q?pCINIsDaByCtTcI0jAo4/WPBcMZSs8WEoy+L+3T0lSjIBLavwvhvEfa1v+iI?=
 =?us-ascii?Q?VSrSgmjlRxlY5fxy0sE9b2QFHXfoSKLZZoKLq6K9gFpELgwNEaptbZrLtxRH?=
 =?us-ascii?Q?Et46mNmyya7loXx1obealBDEeUruENVU20c/Z7DE6F74/alLcZwuq/BLTceS?=
 =?us-ascii?Q?bCKIXhoc7xPGbej4osjaShnzlouRzNExybzqvG7kMk7CxCgcMEPuuejGJrvQ?=
 =?us-ascii?Q?i+SZMT1DcqJ3SDOxb14d5DRoSEHhBlg8qpgp+3ECy0P92vHx+VW49vIgXOaF?=
 =?us-ascii?Q?OXy2pFueqgPnedxhK9Ar72fBCsyjyGJ8W2rfZUUetuxvHZQKY4Hm10EUigTi?=
 =?us-ascii?Q?u1cZ45RvMYhdJzTLfezRrdV0ty+UX2IT4R16ZLdTIcaG/P0Xn7z5wRTT9cYg?=
 =?us-ascii?Q?jtu+A7qs9i4b9VMwDTJ+8dJwAecrYLP+rR5VfNNdtWo4jO7m1dgBPutuv1ru?=
 =?us-ascii?Q?VJdggyRmJ7dO5AQPHWfly9BLn/bIrWMEwrWltOYVdH+dC6tLbAiBpT1yJRD2?=
 =?us-ascii?Q?/pPgDChtGSDi6DfU5xX6lVjA2imb7eg97GuGcEe8BfkKuD7xnqUjzrymALSQ?=
 =?us-ascii?Q?R144Q25/A0TDTL3GJHkOzqIoyfLYJDje7fIkTVTxPdZkDwlUd0Z7f3oZ1fpP?=
 =?us-ascii?Q?V1t4EtZeUTafphgOzF304URxL60LQVvdA2OY5WvYNQSJN5uBN+5/qqLK/STD?=
 =?us-ascii?Q?fp8jMe8F5YJC1u2I8sYTEpglJ6oPBY/oeFYwK4EEdM6yVS05uClWJ5o3GKNj?=
 =?us-ascii?Q?9ogQHqMk3+tOujyybSxGW3xpz4WXbZymdV6jN4h7zvaD6NsO/1KxtawOxP/Y?=
 =?us-ascii?Q?EV2pzE5AgMLqZBbIo60R6EQBdSKNAoYy28PhDQugFDuFS96s3zA3z89+SDiz?=
 =?us-ascii?Q?Lc5YuehQObpRaek8ef7Ox+tjcK0z52mNQv6v5QLVGmlRKffcXj1P18cDcpLz?=
 =?us-ascii?Q?mtDUTM9lwInq3jpRDqd5aWQ6QtOPNnL+zNuHc4PxYjHN39U292GtxmJrVgts?=
 =?us-ascii?Q?f/hJkTAbb9+Mn++j4rpxYC07FTPB7YgHeGriCrH?=
X-Microsoft-Antispam-Message-Info: PhbEEn2SlciZ+hxWUuxhBPcEnehfLB3UxP4Jb1oOXii9OZ4ak/my/nodWcery6ZDGLk69J2VKqBI/93PjbiqzCoKX+8DOGyGXIBFaQ+c1vmu7PSnlD4eXVGksmNdW2Z0TBlScYPCKZB84XifJAS5thRTPUUykWwOBUqM2er8rjJT88PGI7nncOYS6WSALjsWHfdy3TXKWjm1C0M0B7ytP1FDtxIHQPFyHkE9ySPerbagVW2oLTs2gaxe3x+/ryranGMHBc667zear31EI39ztH3CzCnnwJUwE9vifTr2Y2OqJrD4r5DGRonGFASx9Z3Mz28Rzw3kQ9Klijivw9lxYqGa3Jr4XJxiFlUn2GB03iI=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:HfCp+8jfR6H+QZwHysyQNQkRWWH6G80kzeRRjPB9lFAVyDKLlz4vkhAaYulL2zGJ6TXyX4Hgqdriq5hoPhuxwERs/IpkNzgnDZ9+s7nzAR+Gi70k8I3ajlacP/T0mXRiwTQr1U18WRj6uk8A8S7OaUXN1KamL0Qrn9auUEq2VZSOsTmsdl4o9AC6bboncs7UwRC3yy2emlHFYSCOX+mbqm2va7xajVffILkopEaD53QqiGjqGsIrHFIHXaiRB9oITShEylBZoVc4uZaYsKuWMJisZ8g8lGlSqZRwAnwLk6eSRmq+pj0I37svtJL01VuK0YmAdl9c/P9SBiQQuPk6XpFNyE6AmQ+hakVUChzpzjgR44fRCXpSKndAEqgZFOG/1gu/xpmW3dJ7bkCIubillNw1c8uvVll0bbqK+MEo6n4PWvxEWNvhX4D07DENnxOorIGN0pG1bY2jMsZ3eSDleQ==;5:xfxbDnQeFeBqepejY5bK/8I0xnGOWZ4kvg46fr1D8ud+Y4yH4Zhs2loE3bSAlyrpwlYXjYgn1KizFk+zbRTU/C98sHmzwqeEEYhppmLUGNthZUKg57jOvrB3VQHzAMrg6fPBWGf3S+jR+KFtmEzUVgBcRI81PefabTWfgGe11rk=;7:LHCvPQhApaoHULtJri8386cFDl5OS/ecGCAchU592s5QoEDgh5dHT9Sv3RdAAAkrdUlwM2WkvuSUzRt1hQnyEayzkAtQn/t2E7VVWNYu0g4qyLpiTLIXdQPqxY/Zj0NzwHf9ciIzpoI3ZWdsPN47lZEolJff2yzoUJv+HCIgXKnAP62sbIfm9bjIqvhQuwPGWOl1/GU4H7x/zin7lBQS8gtQw5B2bJKd060jLFwgxPS+x+CT8nEuJjjbKjzRFHDi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 11:13:49.2192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483ee77f-c122-4b27-469d-08d62d0f21f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- Removed node property 'big-endian'.
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 0000000..402e2b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -0,0 +1,39 @@
+* NXP Flex Serial Peripheral Interface (FSPI)
+
+Required properties:
+  - compatible : Should be "nxp,lx2160a-fspi"
+  - reg :        First contains the register location and length,
+                 Second contains the memory mapping address and length
+  - reg-names :  Should contain the resource reg names:
+	         - fspi_base: configuration register address space
+                 - fspi_mmap: memory mapped address space
+  - interrupts : Should contain the interrupt for the device
+
+Required SPI slave node properties:
+  - reg :        There are two buses (A and B) with two chip selects each.
+                 This encodes to which bus and CS the flash is connected:
+                 - <0>: Bus A, CS 0
+                 - <1>: Bus A, CS 1
+                 - <2>: Bus B, CS 0
+                 - <3>: Bus B, CS 1
+
+Example showing the usage of two SPI NOR slave devices on bus A:
+
+spi0: flexspi@20c0000 {
+	compatible = "nxp,lx2160a-fspi";
+	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names = "fspi_base", "fspi_mmap";
+	interrupts = <0 25 0x4>; /* Level high type */
+	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names = "fspi_en", "fspi";
+
+	mt35xu512aba0: flash@0 {
+		reg = <0>;
+		....
+	};
+
+	mt35xu512aba1: flash@1 {
+		reg = <1>;
+		....
+	};
+};
-- 
2.7.4

