Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06581C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813C724FBA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bj0ePy+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813C724FBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeGCBWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:22:50 -0400
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:2176
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752808AbeGCBWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZwpCXvppnAJ+x4mamA1AmBAffFFRd88xguhply7xw4=;
 b=Bj0ePy+tAKBGAG5egZMPXB7PZrKE6m9pWk5l5SxckKwJpuoWBxKTC3dm4sVtepH5x5l7BLBdyqk9cl6sbvSUSUy2wvJFkaNMJkN9Yys6531rCwFS1gHWZXllrN4kn0bSZVav5pRqjU3+lPdrRHujMOxwFLGkeOIa2VRXoZQ1P/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 01:22:40 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        fabio.estevam@nxp.com, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] bindings: add clocks optional binding for imx gpio
Date:   Tue,  3 Jul 2018 09:18:14 +0800
Message-Id: <1530580694-8649-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:203:72::25) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5cb0bc-9090-41e0-d2bc-08d5e08379fe
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:6KP6XXWZIXjXnVJ6gRBCIMI94SnH2yNCB8uo98VhYOAJc+ytXwdtN6/3XpDb8tmwSjcb5953CZZWmVaObUp8qoSrtxePjFKrQqZPSWhFANObmDDTW6n0nklyrnhH4dY529P4fAY6P7fGzClIQ85VdpRodsOLBeokaUSxOURWVs1ewve87Fs+3R4QZW7P3MXf9ROLVKdKSr/dBLCR6kQEy6nNfSl/E4k+CwCejr12XFYcponiPMIv1Yhi5UB3apoE;25:o0J4R36GGEaqOvMfxnwjALn11GBRnM8vPyBpN8yrDogo7PbMGtB/9Nz0+Pe7O0S8QoacG//lpHr8H+bhJVpKhl4oeOLSNJxgJA0O6S4TDzDfzkwqcWF84Tf3MWttPwCeEEEfVqn6wvBE3WxNwok1qaT6cc3yGn30K9OF67m+QRw7IhfNJaVOi/OXp869ID7EmxvZ/p5udVlFu3BGTQ45ZIMaNTVRWxW4txSoIL+BlJAwLkmoCUnMG8gFYwowycbmjwDThek5jQH8xnUW8VVV7OnCLe85uoXlLWE4GfBd8+i3VyS/Gx+ua3TklshT+Gw70St3/vGmFLPoyCtPT2r5vg==;31:a0920+YtBpDvTxnGMF3Ceo/COxS3kTVK9+BvS4lwEBqkkuHu+hQmnyYDCecPV5xMtaMDpwtpNi7Fwlmc1AXr2FihOeeaGRfbw3px8ZTZWSrKr+/y8GbxdXn6TNwmEgfLoruuKJIOJE1QFRfFEh4TWeMux69A8Ryocb9ujNiDuto1kCglCz2i9if65qbdHBgxjORz1Mo8gNxljYVgrg05yA1grA5nDADOf9XPa1HtEh8=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:yfA1ejc35rbOb6CYHOHlXdW5tW7cgXjlFdzsZZz2ai9CnQJWTkzn5S+A+MyvsfA665tm812mzy0QYCdPS5OZZZNUUiUM4bfwdJ7M+ehEzo3neEmmwkfCwe/D2P0WxHReDDOR7bR8JstNn6VFpLfs7hWY9Cflw8IsyJMBVBKJs6cnp24YJQfQ2QR2u1OBv1hhDPZKF7jHJhZvuqVHqm/g2zBIypbOGOa7vKiCRD2uPiMi2AQtrvnaYvoDtBIt4fHeZhgI+a01MVPAPrXjAAyIvyXxrpJss2emR2t/lYyBRujTt/FrBXOb+aCQzZXV13w5tha10/hZCulzyNOkl5dOruYcF5seQFwiCkAmsdvQrvp1Rq4OgGha5S36gc6NRPqtvWDRD6aeTMjVGcjnXxDPr1l+uA+WReNhitTiYZYt/r0tYL+xzCQ8uEleU2L5aIrklM9AqxH1Jopz00lKx8RCeHcHTAS92JIB5yyrABJQNIM4uDMXKjhcxpca39DTO7ub;4:iNxtqMGuxe7PJrFWnNokYru/3o5+rQpUBQ+rKpNB5/Gnv3sVwBcjiU9MkguN5oPBWBHpZqwUbS2ZPh9ICEhn235eQWzYv/hua3Fknd4/mBoMYr2XBz8/NaMMeQlHgpkq4DT2KtHo5WWtas3n1Ci320pMAuF23vmfmoIfUXXdTZGtst3zwb7iuIU62mXXNJsbU91BiVWWiJh/gcvjGWgsgt+/BkGS8adZA8x1SnosLHSSt0ioGI0IgTbZQmCwLX9LDiDZ9pz0lAxXH/M0ZVUe0gqof2VHECYC1TJst81S7yoWgI5L3mba/+dsKx8PUIE6
X-Microsoft-Antispam-PRVS: <AM3PR04MB13154ED3789A85DB522B6D93F5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(106356001)(16526019)(478600001)(53936002)(6116002)(26005)(316002)(956004)(2616005)(486006)(186003)(47776003)(16586007)(3846002)(4326008)(105586002)(476003)(66066001)(2906002)(25786009)(97736004)(50226002)(8936002)(6512007)(51416003)(52116002)(6486002)(50466002)(7736002)(5660300001)(48376002)(68736007)(86362001)(6666003)(8676002)(81156014)(6506007)(81166006)(36756003)(305945005)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:R95Dals0wl9X1g4hu0mP9h2Ur7d03hWnhOKY8dsYk?=
 =?us-ascii?Q?V0gqTPH+veHAsRa9ilA4d25qZoYoBuSuZ8hpxmdvWFyrCZBOT8YKr1vY1cLb?=
 =?us-ascii?Q?fld9tmMrZZH8ZQmgcXSJuyuhPIgDbTzYX9M/iaUwCvKVyLoy9vDo/Xl5KiFT?=
 =?us-ascii?Q?2II9qYBnI8jKg7IAmqIQbobT+u+M3dlNfSGELALhGOYWjUIQxJyj8WGLvVwZ?=
 =?us-ascii?Q?S8XxeURHDZh+ffGzrF3Ut+5KyXHK2UBBTd2IQXyp1V8lVmwMTgV1Y0h2xGDC?=
 =?us-ascii?Q?fSkIIM8tzoJHOicMwYinlQeoyxG0b7E6jb+TbJLREhqoFK0spz4SIJxx1yoL?=
 =?us-ascii?Q?WzToxzhSlp5Hmu0vR96hv0bb+qnKWTCBHiiLTthfY6bWY1EqMp/yr7ufaXdG?=
 =?us-ascii?Q?lGip+geI2Ch7QxF2ksOXX1R+LoOcXMs76xGD352KC8sxgsVEaGPZ+stATczH?=
 =?us-ascii?Q?Wn7B7GxuIqWeRZVhdBIauYc7nQLSnhGAr/15u21n9IwwROCWFQhEcf4H4YJQ?=
 =?us-ascii?Q?LHYLFMqNQgyaVhCdvp6kcdSdcqmOysl/uZn8O52HySjhnHSaqmEXUYAcXMqw?=
 =?us-ascii?Q?VkVVZ3PNhCWTbG66yOEAAdOvOnPW3hCKAPCQNpGR2RN2WpxkxMFO9a6RMA1g?=
 =?us-ascii?Q?Jgd2z84cIcW3rx+Kca3kY81wpj+i5lDtQtXQOVT/JaQKgFjB5H7+pp0WnnXc?=
 =?us-ascii?Q?beSLgvaof6dqvE6SMrqynd9ue2yjePjmq2vP6aYd/D+Xl9UdAKAWaRlyBDxR?=
 =?us-ascii?Q?f56mZjeH7V4VpZGTIGjiO1GHPISnxXidYaK8JAMsyqJNCBLhi0KizLodpwva?=
 =?us-ascii?Q?z/74kP3+0bdXH393QcBDpAyRJZc6z2C0dxeS/jbSdss03DdHgvvcrWW01wjZ?=
 =?us-ascii?Q?CTDPwS/mdoWp3ZITJtfHkaByMIb3jCEVnD45YFyOHQS4gqISnxQXtSWwA7rR?=
 =?us-ascii?Q?7j4A5PZ+mzunc6AsdS+eKVu14TxK6uyoV7qPxCFCfT0gXgXtp/VQH92xExp5?=
 =?us-ascii?Q?KV/Q/0hGeaorKP8B2fqwHtcANy1Z2PtiejQbbLpKJnaQDY4bxeocVre7oPsl?=
 =?us-ascii?Q?DN9THRRdtsUODs9nZZEuMFUceoyyA1y82NWqgjsl+5CWqqnkQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 4CsSUyHpaNfxvV+P8qbZj0ghuFTO/+43GwWac65IOUFpN/yuquxpJKyOBfkhXqGvOZjsIS5P79hEwDXXpTYAKkP9zR33VDdimrR8mQamTReBf+8q+pPQwq+BZCaQ4MAcDJbmSsrwDo2y81v4Rupx0i4Nygy1sv1r4HXNV+2An4Hdd9KWUhtSrd+HaQy8Poog0+KdIQf7XXBqLZFYudxcNLWqIeKg5IT+bvJhnjw+cFt4dJdUSSIHypnesKmHWuTmL6isoMrcHH/tZV+Q9APzJAl+37mCxGE7ZxtkRN+NKrO56qRxDaSkEBuRZFy3qmofEkQw1cR6+EfbVJfOlUfWiDxiSUtlFxM/Ed8TRxdM58c=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:EmQzx1q5nvSA2bIJrqSgPuCWHFF9wH6laKs3T5BRZxvGSmeWzlHELLgP82+mQZG+ztgHLak+ntke5bhd0F0/TyXXW7EXsHoBoRzxZh6MBtYVyJur9UBvzl7bZuz1r73yt2rCN5yhFpYXP2qLEIp6ZsOS5/pSvG/DootMoNoXJ8HSWlhmGg6WoMXbgBZ/sX27fxeUID0JxGYsx8UsHzAxPrzNBphDvhAdZKAEZCUruy9/EzJTcFdD2nVakaSAIfvojyedfBu8xdI2+j5RUqoQLAmxsz49XRPi0qytxCddS/qec6Ru7EwX90OL+75C/0isZGCtkuIqiiiisM2Hom7D/Zyl2F/XBLWeGjvTx9pAJ6lSDvqJhaWRoRQvqxtbDMyC8keFnVnd2xyxYUhyF5NzoOXiJS+8ZqErwAqzlS8H4V5BRB8o5qXaQHkBNlP3Cn6/fnY22/LaLwmKe5pCn10v3A==;5:tnC+mwlO785y7jQHdFE3Vm4D5WV/VDSkeRypBLnCoLlyoWL4b5hLsAbih9WWZQkrODSnmsyRsf+0Hs65+o7TZQ3q6SV7+W9F5kWKhMXgYqhST0feF8s7UDdXxD4rkKrRpJVlvLDfCHy84UVjnDA4NQumTmz/Ix3iyoRYKN8WM74=;24:6K6wAcgqV3vglzw2GHp32X6pJPsfSoyIul4uYudIAu1IWnftziw6i5pOgAp9G4swFa7b1F9shk7U2OgY4XxcFWc3Wj7q/M7OmEkovELM6hg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:qv5nJmKx6oIr4tcafzisCki74PSPmnoxg8RzKaqhgVClDwicJkP5zO69Pump/xU7Mj8IrXjwjkFT4wrmt4/7fWJIeG1ivl5ppUY9DXnO50zz40Usc8r1d1TO347/MupdDMqpgXF4rwAi2i1YEr7J1FUOUiOfFMCdp/0D9q1/tEGZEg1BZSOv/qjeBfL36QpABXLbOGIRyNIjwv+rCytWMrNw1OI0jDNWa08kxVLpMnIJ0cy3txM2Y6INfWDAHJ/Q
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 01:22:40.8252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5cb0bc-9090-41e0-d2bc-08d5e08379fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some i.MX SoCs have GPIO clock gate in CCM, accessing
GPIO registers needs to enable GPIO clock gate first,
i.MX GPIO driver will enable clock gate if there is
clock property in GPIO node of dtb, add optional property
to i.MX GPIO binding doc.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
index dbd22e0..b4cd9f90 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
@@ -19,6 +19,9 @@ Required properties:
       4 = active high level-sensitive.
       8 = active low level-sensitive.
 
+Optional properties:
+- clocks: the clock for clocking the GPIO silicon
+
 Example:
 
 gpio0: gpio@73f84000 {
-- 
2.7.4

