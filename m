Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F620666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ApIyY0B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbeIXS5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:57:35 -0400
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:22016
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729178AbeIXSQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZDWbX4cj/ih0jVtIDR9Buq1iviUhi3RmGmHoEO6l2I=;
 b=ApIyY0B9zGH4JnnHidm+IKJ5ZDieF93KVJu/fCXjSTEOF5FrvDGslr5fQ10gBQ6NBrCrhQwho1h1jPOkbPLRn3RNqbfwnalko7I4USmE5NK7nZk87QvX6jNf60rnuwd/m8tkMiQTWDF/VS8DHIN0n2HF5UDbGbbtFMbNqV4PFhc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (2603:10a6:803:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:14:13 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v3 1/6] dt-bindings: arm64: add compatible for LX2160A
Date:   Mon, 24 Sep 2018 05:38:56 +0530
Message-Id: <1537747741-6245-2-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To VI1PR04MB4798.eurprd04.prod.outlook.com
 (2603:10a6:803:53::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c80f47-bbbe-432d-7977-08d62217400c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;3:JANWVAKw99YYXC8EiFojxfbFFMpIUyO6A3gmsLzsBkcUFoLjaqWMB7ngSRALRma0UYKJqemGVc+5YY402JZ+zyUIgq6XkFpoVZkoTHG2HzosD5zPoHHe7599QtMLo8dD/oks2t+PUIJKp7qxq8O59XKHEIdVraIJ+SFJ/Ywd/3bTXXNL/NCIe59NYhF4PWWiS1elUUy0OdBdPZ1YOT9+YhFEozwMyks/Wxe+L/gq3HmJDq41S2uvCgJPAGSCnVRH;25:Dy+rcfJII2u155ExFkAxBj/g5S4JxEkYAYTK4oQU9gob0npJZw8eeRVaAetw0tVwq18CBYE+gvvVJavHm5tYez78zSN+KXq2m6S09pzKIAhv7evmyYUFZ2ucrGTxG0JDCR8G04tgU2FIZ3gWlA+WLU86DdSK+xGGPjwMM1sJg4CetwU1OppiKuNIgciSswGGBz41dm7zEu71xiKebIEeKEjNOp53YXG4ljyD2WRoImr6zd/DiYWJFwldqg04IVdFCj8rMieKwGMuY87KX+/MHBAAlThrwAyNU69tk2jfCPN6ThE28r0OWtfFeMwuUkdg9ZYatHw+ZlMupdw5sausXQ==;31:ymFB3I9nN6IBg6xSplRfG+PNTntB7dzEP50ajIkwBFlpSJUEesBi+xShZLWeaa9G6WYIcdVmL+wbhSAyNfUgxBpqeQLpcmpduC98xltxgNdAekez48+ktYTO+JqFvMWoYkvy284MQl/qMoFrdDmgR33MqFYlRD5ALnZ1go8AxRZnxkoMjJY4a3pf3UNuBXXALHdogukBTKHBJytBsHbnWyZIA8IOVWCs1l0seCw88zE=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4798:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;20:JAhWFeiwwiF7xlCeIJ7KFi+/d+Og5h4Sj/xgdEo9uMkRnHgRgLBIa3YdDrUgIR1lfZs+GwE8cCCGAy+MPNBkO4V535SnjdlL3hyJeqAYZDsXPbV8VYZQJaKXeY9CFyKwvGNtsa2zZxRwvRBKzRqnTewytXUfwUzfpXRkUhbh1+z2txyY+K6AkOHo8TKQaarEweJb8nSIoiOlpyySxxHpc9i/nfjtFR0BT7z/Vu2Au1N9z1wAL1+TCIKZgOM6QFKtG06U0gXZ11e36UoMNKzItnW4Mv7UYPeiI4rpXlAKe+KtLJqplgkcQgQT695nCBHhJtQ2+yElaTfVYkk0hh5WT3B+OtGLZPObJpJpsALigdPc6YrRJGfZuogRZnsQmrlT057sTq5/u1DsR58EBma3OIv+TOSDC8Ock1Fm9KyvKG6e54UTPCIDPytRNnXnDUkHRxAlMhnusTvkUKYH3AUTrAPYhdeeCTJ5aH6+k7yLtqNXykiNjhP2McYE1lioxZK8;4:OGFmLu56jkH9YfphKGMPDKLgOIjp4wpZFJi+lKy+wLAgkjX1IFgAN+pgGtOZDr8ptYQRgvK35J1Tg9rvkaxcr2a2P/G48MRCI2jmBr6hbjpW8KRIuFFxWARMbJ1Gdfu/ccynZsFmq5T7/U7oBQSmXlKI1I04FPRFdYSKZ58gzfS+2sukN22OwOWmab9xouNTG3ua2PR6iu6GB+ibYIdTxX9vcv2e9ZSEsVKPZQYkmjlCcJYT5Rc41BFdEuk/9mD1Y3eA1TV3QMAPFwDBP3tE4unYoNpTRY4tzl/P24deAVD+JoZTfgu3d5sGMEopxNLI
X-Microsoft-Antispam-PRVS: <VI1PR04MB479826D7EF36BEAC7DA48ECAF3170@VI1PR04MB4798.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(97736004)(5660300001)(6512007)(48376002)(6506007)(86362001)(47776003)(53936002)(386003)(6666003)(25786009)(52116002)(76176011)(51416003)(956004)(50466002)(186003)(7736002)(81166006)(16586007)(7416002)(486006)(36756003)(50226002)(6116002)(44832011)(68736007)(5009440100003)(26005)(446003)(305945005)(11346002)(16526019)(2906002)(66066001)(478600001)(106356001)(81156014)(105586002)(8936002)(2616005)(316002)(3846002)(476003)(8676002)(6486002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4798;23:RolSyKYvXpmdXOZqkf39DpGfGF8ZEpmtnawikSTgL?=
 =?us-ascii?Q?S+FNKcw2PsnlkW5ETdikbD0f4lj6I49Ad1iCAAekSfka6aFxueRemiGDiaMd?=
 =?us-ascii?Q?uElQIMs4M2oXWAzxmEjIu/fCyHTuZwjRd4zloFvwBs4rYAk8TxH3QaadVkq3?=
 =?us-ascii?Q?3VkdGn/10FYiRRLJFeOWdYuEEYZrZXdAFBE1SxXhES+XglsOBgEbbGpJRu+M?=
 =?us-ascii?Q?O8eHsCUoZR4Mo1T4xg9muIq4cR3/dhunMnSGDMYCAAa5d6xo3PCqWjKyOhUt?=
 =?us-ascii?Q?3UtlRXVYDjxJVc7t0Z21EVPytdmjT0t7k0AvpjksTHu6fTDALYyVR+HArRY1?=
 =?us-ascii?Q?IW1uh6GAaRHq+YPGzG0mBWvMIq9dmYPnopWPP4BTGtanjwM7a+29I4xoSilw?=
 =?us-ascii?Q?EN7vd34JuZdIjxDO8PI01Mz5mVfDXjeREJ5xtyBC6qxAORvmcbPVwh+/n2oh?=
 =?us-ascii?Q?BI80R4aoG2LTON7BW2X6EBx9ixlbTgUbD3zVJNVQHkEt9eg43k0E43qaSWOZ?=
 =?us-ascii?Q?VoPj24xf8uZ9zatYX/cODkTIb6CBJIHnz4YcXsFJzKu9WcEpwIf4LOMXSr5N?=
 =?us-ascii?Q?BUahMC0JjdIJ8SbKulhokgvMJrya2E6eMV+G5hoLtEjpNFX3KPEwXRul5GYO?=
 =?us-ascii?Q?aUQwR9Gwr3fAaNJk/ZPO91kxnA8GNAiQncDmVUsXT0EkdNr+zOA5B0AA85/W?=
 =?us-ascii?Q?aVfQHD8pVE1aM94frKu+xY+GIfVT1AfwyWRhUXyJ/6B0d2a0JBuwBtfJyL+B?=
 =?us-ascii?Q?oXaFtFM7lWSUS0HVNe4idgtNufJmWI9QCbK6x+tmmxCpq+c6y0GK9x40dtqc?=
 =?us-ascii?Q?z8vFctRCmQ/zwpk2pItUDTzHVU4593/F2TNUyDWoXDbzXAx/fyiOohZejzbn?=
 =?us-ascii?Q?ZvRFFvleKP1WLcL4djRWzAXtZFvQAzqkGfaDEleBgTbWg9Krqxt7UCEY1jCq?=
 =?us-ascii?Q?ulPbWJAzkJGBosEKLB7SauqRngtS1ey/IeebHziwGQj4QY6h1qSjrv0icPB3?=
 =?us-ascii?Q?9O0B7+nrS7kE42xi83rDibwbfHUYYe2vn0R60huVjiq0oIzzqUiBGrgrij/s?=
 =?us-ascii?Q?9Zq/80kcbwkLEle/9cPiU5uaR7y39ppYUqwMYIwm9zDkyTgE/pHgXgLi5UPE?=
 =?us-ascii?Q?s6bCaklOCQHdsLEBJfDUv9LqdY7vzMoNOZLHZJc1WHBv8R/aGhAuNhQEPfm/?=
 =?us-ascii?Q?kYKZMloLQJ7Pxd7In2F0T9rkzeb9b50HZ1z81PE0hq5Z+gCorU+pwUelPR9J?=
 =?us-ascii?Q?kJCQtv+PHh00pCuQt8DBTobkfSYYSIRH1oQwFjN?=
X-Microsoft-Antispam-Message-Info: N2c7p3gNCPN4vFc9Ko9PtZykKJHB1+3qHI9uctDPaW2d98OlVIocqiTyShZJFO0EAGjwcDUWzCdq9riuVGFti5njcoEfmFV0Jr4uY27R61N5rFAeo7BL+vlNoVT8KNioOdkBwuMJVqJY+VfU762muhX8D1VJwT6Q3Sx7iuiG237t5LC97QRX9qWG+cIDq12dLUDeaTfe66EYMZM2KS51iJzGwGNI43ea9pJE8A0MHy4AliRwT7pzvYerje940dRnvsthBnCQlH47JkRNlwe+UQJmDa+IvPHHyZ66Mqrqd/XRZuS6bsW4Hv0NbMUnH6/bdS0uM9qWCLmUnw/XvAFlLroWET8Ikm5IvyIwrAsav2E=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;6:mRyUzgo5C6J227mC3RUAKflYH0GZV/nAlzj++AXIlfLoQLi0O4CYQZcal1bxp1CLLTw4MsY2QL7kFozExM/T7neOZDKKahZi6hMKBMGTDs7VvyEjdy2hC2X30ubYw8TRvda+WKazGn9GRFyyNickJdQYMvB4ND19iCvofX9EHAJxvFPrk8BxF/8PIXwil60r+5XFJLfqWjo30PO74D4ODAltWXVPhP9Jp8/HOtXhLH5jSJexGKtntI/EbcWbd0NZ4xzcYI0Mt3yv8SpqDQg+JBjCUKE0zNtIbW95IRZeuVJEIHrLQpjWId20MPjmT2EjEzSs7YMRfQkuFBzW06HH62Aq/yHcmRm1X8ND+0Yb41NStwNvpgqdAIS1X/pvU0WMH0tTyjQR7Kz5cjg0NOIcuYemXPj77t9P9eK/jZLFLx0rGAWnMCJyV28uy3oz66r5QgR23vANJnqRbpEgEfvhgQ==;5:Hv9MAl21MObT6ZQGTCi6H0EGYC19pfkq39Wo0/9lg6n2Mgv+rn4xJONZrTZtHz3irTrD2vf22dCmliOHOOxzQ9XZJUOnIja2ya1ntIcmMAqIVp5M2tW8GX8jrFn5Ad5ib9lAaiOsjeA5/67dZImo+m1Nro1pBDADb3hETv5fufY=;7:fIifEJv8xqyp3LRlCdlqr8JVlhtnTE08sXBvYYsyPNMXcTHmrbHiFh7K+mc1B77k40aVOzupf4hxaQSprDy5a/wPjDEFRcIQoAtPfYrzToH7Ur3uSpWFiJOj9z5CG8vbG3+PUFfw9v5W2U+dwXfKuWu3KblBmgaIeotmeUD84dPU+BJL/SaAdrWdPqAJMt9UyJr4H8B6WcKbvbqhCe66trrlS0JZUS5SjObuJn/L3d3QWrHYHHQxiRKGxw+LmBzr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:14:13.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c80f47-bbbe-432d-7977-08d62217400c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for LX2160A SoC,QDS and RDB board

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..76256bd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -218,3 +218,15 @@ Required root node properties:
 LS2088A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
+
+LX2160A SoC
+Required root node properties:
+    - compatible = "fsl,lx2160a";
+
+LX2160A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-qds", "fsl,lx2160a";
+
+LX2160A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
-- 
2.7.4

