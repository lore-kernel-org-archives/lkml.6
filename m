Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF57C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C597E26877
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahG5CWUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C597E26877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeF0DdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:33:18 -0400
Received: from mail-ve1eur01on0079.outbound.protection.outlook.com ([104.47.1.79]:59744
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752169AbeF0DdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay1zT2+/cMKby36svz99OMpYGvuJROc7s3R4P+x8cUw=;
 b=ahG5CWUuXgB7cMP67fnZaeACvJSPS0ZSu77NgW6q1F4z9JL2ZsHAt3cQTM/PHqc09ZOK+946WL9H17sjEYIN5NJ8V2ZH/zYQ+WA4cWkObt2/aLklSoFdfDkMKwkNAmppM6wJwtybcxsKkIDlIk9xip38hIW+71f1hqNUulUcyaE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1320.eurprd04.prod.outlook.com (2a01:111:e400:51cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Wed, 27 Jun
 2018 03:33:06 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: nvmem: imx-ocotp: add compatible string for imx6sll
Date:   Wed, 27 Jun 2018 11:28:50 +0800
Message-Id: <1530070130-3004-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530070130-3004-1-git-send-email-Anson.Huang@nxp.com>
References: <1530070130-3004-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To DB5PR04MB1320.eurprd04.prod.outlook.com
 (2a01:111:e400:51cc::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc360681-b189-4dea-95e6-08d5dbdeb43e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;3:pNJ9fjJ9zuhqDie/b7wU12bRchHYxRHoY9nGMD7b3v4HHzsSu5ooFpExsLzVJDOZUHakobXQlA0pF7KGZwQY54j3Kevq//N1WE75ZTmdaxj5uVfBebvAyCILoux1bmCk6X3S2uLDY+i05ErN/tK4bsB/NYHcmKfB/z1Z4OAy+pJSo/7ihEfn4+h9DabhtJZ1eDuMlK1gRSGtXE4qrLcU7fCBEZrH0JqHn2yxRNZy3olcXK0RroJ4ZuznYLyn6n6D;25:eRuvf4aDHkDlhUjpXSSsXO+IrF1D0GWd25hDDwQEbS6ZJ0pK3pkbgazM9Anzd5sgTzuRKkRushvDGBsQRflvFH5UtgkK2ytWUCPpF6zWR76fZ9otgS11+kzYNOzBedZrrVeI7b0bsDa0KFEcTJjzscM8Lugm1Af4wxJgyZ9aimAbYiS31rlbch6HHTMo8FOhGilmEoLclc4NkhNL/8fRWKF1SAQNqusThTyki74r3CjUKsA4m2s52wmE9gke6GpoFBybd6UjM03e05NPuYN9bhu96hXM5J/w0YRTSAcHuEy+4GLsByqqwOCQ/YHtaXgv4i+HFwV39VUdzr4EjzZcwQ==;31:V36dkpNAQJtWGmAwifzur8ctJzABrzBYDjzz7FDqcrDNyRN8ohCsAgnZtdcqcRzBxeyypvPANXePZ2WtR/45hq3yvAUAumDn08Van4xvmu+9VsfFSkuc+tV4S0AfZdbj4km13tNaAQLQCk0AOkLwnsDtGpew8kWX+U2Wm3jFmYc7YcUuhucepcqnLFzc9qoQK5r1o430mtjZR64DiNjmYEj0GSmycMbwoHuN/g7yWOk=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;20:3cMT0nlUH9bIc84zhrGqxIhzb0tKGkwAOTWepv+5chBZA7Cdmkb4meztoaYFI921ygaJZSIvQlPXZW2ge+sopP6DcSqBr1KKgkNX8nQ4HZRhrkCn+X5XCZyyEL+3XiZ6PzqvAJns3ivgdXvhShn8f/C+N4xRT+cvDVk7rCb9OsyVVLBEX9j2Ud5HTSxzqjauVuGxYKTipfED+4ac5D5hJI9m+c416hJ2/rHSL34TtP4LYPUCDIN5rPnprbDjQdQ/qRUkhRv0eOguRD3uXJ+Cie5CIeUBv/9Usk3Szp4er/t3UAnH1vqRkHjJ/SN1VeLFpq5ZC1WQGE0Js+LzBETzDpP+LMaLM8r4RGiQLMHvCAC2ZieLKu35FIV2afTUlIHoEZ4zhhTPgI1wPwkk2uWaU0to1dYqCoKErWv3gw4B7UO/wnt18YvbZhc4dmVUOW1i3dzP5z7Jdu4/Y2b20P69XycqZOG2VBKtn8R+7Zw3IxyJYRMigWjI3FwMrg/QHom9;4:mr8aE/awucVQ1WsmFXfFPnsfvxmyCpxfBAQUsXlqPGtUIKa5vW6Y5O2rol3yikgUOXPVeb0InBZB9xveXLvGrE3rnx+sBNUXLFDxzRiqUbTiJq+zG+OyjH98Ejrs5PaOMkULUnIqHaPbSfypQwdqIhgLnspZGfaSDe6D/G+Rlrq7Mis9pyvlX/4m09318Q3fs9F9MoiauYLZ2tONv5OHBplvffBl9vn+YG7l45YcKTviu0hL4TQO27+8cEUtYbRku2SnWpjKa3ct+ihkLW5va9y+1YjTJmaAYFNN211Gt9A3AXgmteRMlPAAq8HdP9bM
X-Microsoft-Antispam-PRVS: <DB5PR04MB1320D479978571D466BEC66BF5480@DB5PR04MB1320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1320;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(186003)(16526019)(8676002)(2906002)(386003)(6506007)(76176011)(26005)(11346002)(2616005)(476003)(81166006)(486006)(81156014)(8936002)(316002)(956004)(16586007)(5660300001)(105586002)(7736002)(6512007)(52116002)(51416003)(446003)(36756003)(106356001)(305945005)(6116002)(3846002)(478600001)(48376002)(50466002)(47776003)(97736004)(66066001)(6666003)(4326008)(6486002)(25786009)(53936002)(86362001)(50226002)(68736007)(14444005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1320;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1320;23:xFHVdM3OkduWHRI/pKjHabI/jqm685DQqR7ngd78r?=
 =?us-ascii?Q?1jZbBrVO3hiigSijrGnexSaHq/aPMoy7+UHTK+TqBm2jYXEEmpB5aElAxNmz?=
 =?us-ascii?Q?dV29Scyakj8jPAjzSSVCEqjne5Rbp9VZcZjUVNnK8YXXPMfDgpRfXw31i+qk?=
 =?us-ascii?Q?H3aVBgcjxDBRP9xbG8c0+xG05xQKxMZitxo1dQJvkttbS1VE6p9CfZDL+7lZ?=
 =?us-ascii?Q?HVbTR/vPikxoiD45eUaeqCLMJ2cgC8zV2oRlpiqnMzWK5k7jLLVHAHZHe3Pm?=
 =?us-ascii?Q?/Er1wdBp/Vtn4lmiI/vDhB3QuT/4qk44cwHEko1PlVs6NuCEcBSqsU6caKEQ?=
 =?us-ascii?Q?6MdjSEMJrbD9cI/XvM5+RQ+Gm75kpramjuh7LFhFVGWWsNowGZchSso2tYOe?=
 =?us-ascii?Q?nbO3rAD+8L5AQdkYN5bkLmkK3OzPPG+hn5DmSPpOg8gg/6VyVeIIaPum4x+4?=
 =?us-ascii?Q?bEKYPh0qGO8yBjfSJXRKheP48UPmEPTa5dggEc2HMRsd24FOQ6ZKzJDwDj9K?=
 =?us-ascii?Q?n92c0+dSom1YlqYRhG5dlm+GG1782uV1pnttQel3pByVn+dUSKuRacSf6O76?=
 =?us-ascii?Q?T43XuAo6nRTS6o7sVKuOxzP2dOqGTo9Tc9WSEVu9zwQnIp0f9ABDxtw7TIpq?=
 =?us-ascii?Q?NBoEZEDrnorXJRuZOF5nQO/Y/5h3I67c6H9JzPrLUZdkO4qRrhd9zmkMVXM6?=
 =?us-ascii?Q?9I1I3xIknf6/cvqPM5SC4+j2AKOUaROGHE/+zIuRfvOwovH1fFQypGPHmxz9?=
 =?us-ascii?Q?EdDwffzqaIEj6GboDWN7eXyVcTekKJS1XMxRmyoW3UY3cnY3MEYq0r57FuF0?=
 =?us-ascii?Q?6YvBY6qVQkkQDO/f4buyUcnRM7SXvpvPtRStfJ4l2Myat8PN1HUILwThhJ3s?=
 =?us-ascii?Q?uIH/6mP0WVTUvLO+Vq27oLc5XI+QrMNqnDA7fhRnHVIIfBxpG5b4YGE6ISWm?=
 =?us-ascii?Q?0wOra3UaLfB2kufuiBnf9fzQ68ildmq+dddNpRqYFecGWORHB/GH8bInYy9J?=
 =?us-ascii?Q?1c45tadgLSjAfaet3yiYKm0uF3PkYilsR3Z+gQ8aaSHpoEuBWsms7kswGV8B?=
 =?us-ascii?Q?L2HGLvdYA2DOkMDFcIGhSglPMZYseJGji0jmX6KcYWRzK1H15K7awWrntad6?=
 =?us-ascii?Q?SogWVjeskHn4rWKiccT4hOH2SmM6rfyg9rZ0hF4wn3BeI0QQIxHgJ9ogZjLr?=
 =?us-ascii?Q?ibEUA8cVnVHzOs=3D?=
X-Microsoft-Antispam-Message-Info: HzNDF1/rvUDMfG6NVrgCEbw8kzybNPgeiSjtTBGwKcM53sO6sFQjDdyZK7qrbiI2aVVyL6WMt8YirC8cW07qNFfKVG9JrjapF7/ZBIpXqC0fhvP7HMUsz970VwePNQ4F/Wjqe8uEEDSRIb9n2yzihR+lOpFvuqpyzoSwToX6M+fuJLaDt4IRRtA9giKI0nUsKJu4hReDksmZrh9IXbsKWE/1hLBxMuKYOr4N4zhL4kgoRrA0+kUKpapoHobVeG/6ZyisfvLTPdGT7VdzhjsEyWS5l45GX6mFeynoYwiK3+oExip3lilFyDXBLg5Er79zErG5eHdmOSchPrKdyLxf5/bpmBBqqTbR9HgdY0O72is=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;6:8Ud3ZxRRXQJ7MyIMhWlp9s5PQNRqKCrQVHR6o2JmaAnbQIAJem9YqVdJcHJJeDPRwLdnYJco+fZUCXs0kRqWdiCpQfMx09QsDBXNtMFo+TNUdWga6qlqxPS/jALPMJ8beNyio0FJWjIBYp9ef7MzJm18zwem9V+HzuW0vv87aFbmuLR7bquTU7E7XvO2PatuFJhi7PSsNYtJsYNLNFGyW4v5T9qYJ4djx3LIpZUIO3CL95Ui+ndwvSXBjD87PDwmgsh7G2mqQvzwfQYIwA1a5AnCILnOQbMRqln9nC8yYvAreM1E/9Hi7sMDfKfjKWgqXR3NKnmiqZL3h7pUDNI5Zf6y+j2kwGUsSrmLZGfsA3eKzCzpH4/EpaAfAUcn6t4J7Jc/jo2dHEuNcKGKPjk++3PVWAN2oHiGcwJVA5vhyAeQdFzQqkHfBrIo9sQsfxn9SpUPZbMvO5ST5p7Ed0VF5w==;5:WdITz1LPZbzOYAg/0p1dwvtXuxjZQjfOEAKIEyQAOLRyD8KqENnjWmewCxz44CWkXntp7c+9KUweoKAwFbB9MBJs3cBELXiIlG76ONuusRPIy4rRReVxBPjnqHSlDwQtuAob7MYS6YULcwHmDqJKxI0NUTXOMLvyAfZvZh7QgPQ=;24:PShJbaPyxgk5PXr6zJJANOPtiCBTOvHZG1y24bEkZHDs/vE+nmSdR1xOT5juD+9RsAk0I7QW4UWjtFbae4KdcaRIARk8ANgkLXoUZZZF/aE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;7:UjKV99SsZm5Rd1P4ODRUOL6LbZC1oqwf5WSj15Xm7+rGOh50Aci4wqZ+yCSF/TfqfFCtWBZL3ps8O4xSO7u1BiA46BSDIQtxbHo8z9Dx/GHnWf41zBFoXfhKBdviVJTglqUzLeA/AvkqweArH42Aw4IbGwNhLj7jkgLLfi9LyiEFhbUfd3DYA1gx4Ppr9PYPZqUbzF6QhZgLHzMo28iWSxv1f3PHJvBe95/PMGC90mpVkrD1SqT2lxxtA+x2dZTR
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 03:33:06.8683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc360681-b189-4dea-95e6-08d5dbdeb43e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for i.MX6SLL SOC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 729f674..792bc5f 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -1,7 +1,7 @@
 Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX and i.MX6UL SoCs.
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL and i.MX6SLL SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -10,6 +10,7 @@ Required properties:
 	"fsl,imx6sx-ocotp" (i.MX6SX),
 	"fsl,imx6ul-ocotp" (i.MX6UL),
 	"fsl,imx7d-ocotp" (i.MX7D/S),
+	"fsl,imx6sll-ocotp" (i.MX6SLL),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.7.4

