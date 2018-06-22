Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DCAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708D32435B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vtyiIDzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708D32435B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933139AbeFVOOt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:14:49 -0400
Received: from mail-db5eur01on0050.outbound.protection.outlook.com ([104.47.2.50]:32028
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751266AbeFVOOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nSEqeodU3uC0tC/Br0TkhMEJNMlDLNTPOdTFyHfwy4=;
 b=vtyiIDzAIC0HYDeEsi/y3w8wSe2lAdkn9SPEyIhClVWINEhIjtaOVsMR9wPFSas2EBIAZd2ekTNjoQSuRu+E/dRr4olV8uFvSNfUlk6VPWfWXDG2c9CuvEMnIDDrdntlGoZY+tCsJamLd7PPQleuwub63Ferof/rQZ4QF/MP+KY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Fri, 22 Jun 2018 14:14:38 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] dt-bindings: mailbox: allow mbox-cells to be equal to 0
Date:   Fri, 22 Jun 2018 22:11:56 +0800
Message-Id: <1529676720-7533-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:203:2e::32) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 362390a7-3b8e-4474-4387-08d5d84a7f3f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:eymtSGXcxOHCBDV5a8dkz8VgBUS2O9SjlDujy+DS9qQ2QL9H+kkYx8ZPzUd0ycFrrSOJqP/6KjpblRUWZuBCrX5GA2YYYUm6OjK5Iz8Hnj9ktQC6m00nvU1helU8gPx4ZLnnx70SkHuolCh0MJz5i/9gIs2lzAh37hki9ccj9K1YunbFl5itLyABNNMC/t7W6DFT/DG0kK2q/+/mPDlHtjXUA/peUC4MzkQguiy6jJMcagb7T88ucWkPoVtP1tmW;25:chAj+LWvwAjOBdLoHelv6693vlVfhXYLDBLQOqoY+Nk3QcS1Qltz7AiXt8KIA5WgphStpJD5Te3MyskfWORfrMrWj5ylT05N7ALzhkP/mO++GCSze53lRHxSnEjWNO/k2nstHTuuCmI6QcBDBV46zjDON1Kk6K1uHpk0TEA76djEaWnNoUa8WdczYseIcqdv8htqV9itiDSVqQD3Ym4vHawzLwTbtfGNTeygq+EvGFTaEft4PVKmy8iQZbofBXxbtLWXCSfTtGQwFpk+x6eMdNbRX3DP7ZY+1J8H0Hto8gc2sl7NG0jIkLrzFEn7YkFNNI4/F/Nw1UFUYskxkkVqdg==;31:d87Us8ppVfa3/IjGDs19VbWJWmuyX7mq2B9+EEQGNa8NgEOaFsn36EQhAREH8eXTkhpkGPznAwMUll0e9xN0UjGzR7JjigG3ufC7IA6o/Dgfrp5qu0GlkrXkWW1zQ2d9lbL6HZ12en3ABjgjJcdZzHhHpw25KzB63YSmsWykjArJvEKKGukHQm4IQOnxZsSW/j02JkQ1Pdr92rwOzhHHcrxhrGWR+pnCFNmzlkwLq8o=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:U8dA+qvypRvVMYB/WTFI+sT2R4TVsV/KpIs1RdHdTF/otjBBy2eElW/OUawIYJONIas5167uKXUB8qiRTsW8lPxpSTf3bNzRgAosgM4r3Vm0raZWyrFYFN5QMHBgcM9+GNZanRbkSopk5PlQN85vdvIUOHrjQZ2aGnu9knBnVhYpDodKqWBe54tXwH/OcZC+lFH5HpJT2kmrQmIGqgioyHJzphW6cA2QXcV34X2iu/1dnP80239HEITBplgEWMEFpnqio/e51nYvj3EQsX0N3N+yL4WMgOw9H548YZ+tr3wutx6OvLE14WhvP7f5U6OOXiakUemRwXYcaMjuyJBnLuqbplbhqqRSvhyIBn5xYd85o+C8a9VJizFrCBUKAYcm2enUBUn0RZ0Vs4hmBiIC97FupHcF+suaAwHiW2dKDIjmiTrjnOIs/7L4mVzMHNk4jmUhnFaBzmRFsjoPvYSC6bNG2BPpTAnZ8EKoDjABGlV0ZMCxfhGX3V8tzL+rVPG9;4:67jNFKyAPT97K5dAavRFIRDKSU5tdqqLD0A4/gfJq6mfhUgXxvhn4VGUdyEKudyPjOesVN4rOuBKCA0GslE/kyrMCuQfpfX7SMPA9VDaB5ksa+uUlTnQ7YRSH1VQNd2b5tvMVVpq6jg/GP38anvb0/UCq2Gt49kePJLc94cvrbqPWFk20nMK1DCvmst8nJ+m/BgRv2lPhdd58HBRg84kBS4IahEgVBEWMaMhcTcyk2dcdmtdoAA8mxprUhCC2XoAYUnVbODm7iXu05/WEhsbS0zksfrSnGNak4tVSIJMGU4zmcULkU3vhjWP6YKRXcq5b1vwxrfjDKcYWI0xbFkyZtAHhF17sJz95BrlVPmNOtUSNkPy2+S23AIrbnoOrOwA
X-Microsoft-Antispam-PRVS: <AM0PR04MB4211603FC60ECC15C538D1DD80750@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(9452136761055)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(39380400002)(366004)(376002)(54534003)(199004)(189003)(305945005)(7736002)(2906002)(6512007)(54906003)(316002)(97736004)(53936002)(25786009)(50466002)(4326008)(50226002)(48376002)(15650500001)(478600001)(3846002)(5660300001)(39060400002)(6116002)(16586007)(6486002)(2361001)(6666003)(76176011)(68736007)(26005)(6916009)(52116002)(81166006)(2616005)(386003)(446003)(956004)(476003)(11346002)(186003)(16526019)(105586002)(106356001)(47776003)(86362001)(66066001)(8936002)(6506007)(51416003)(8676002)(486006)(81156014)(2351001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:7z7Od/0VD8SCYeu7vIwfYECpWkQefUtY6ronTNhFj?=
 =?us-ascii?Q?geK2tCYw46+I9BANTsuSjb5Xfhlh979aYZ9ISj4GgNAvUQhFOr0i34S+GQKU?=
 =?us-ascii?Q?vHmuwkgjj7VjvLEeXcSudd1RqOPS5+I3xiVipR7MpgefX3RoqiPeRIX8Phaj?=
 =?us-ascii?Q?KPS1LaCeQj18BeMk1YnqVqff//8/YuyhKtnQ5AK7ZMSm/K9m+EF4l5qyb85+?=
 =?us-ascii?Q?zldryNnamad/im9TYpxqsXk3+mFxOSDoNYvx2GNeCHicZn+fKo3358PotePh?=
 =?us-ascii?Q?yFpYXD5ThqfAIhhYjzjfSBxeSSTG22Owb5en5eOrL2r3LM/e4dJhGAhadu43?=
 =?us-ascii?Q?P6sjyRFgrLmtidwl2Mz9Vs2/KlwpGDX+tBT/sudVo/25nV3tPJcPXMWMxt/7?=
 =?us-ascii?Q?la2ysPaMIDxTTtZ1+IbPfdRun26IHx5CrhEYQIuruCoHw2SG5jfnZpWDsOYS?=
 =?us-ascii?Q?Dqy2b4yCr45ztY8D9XTPGdAN7CxUhFayCmGubReW0JTR9K8HhiRolHlh4N8c?=
 =?us-ascii?Q?OWB9Ma0zjOQiw5iXQUGWV48rWvwz1C2NM+Rc0AN4M9eZg2r3UnYwHOrQzfOE?=
 =?us-ascii?Q?3vPaXZbGiA+G9qPvjJhHLzMAUIrRMai3XOFfFCQOlO37Tw6hLg0rrPT9YW0d?=
 =?us-ascii?Q?ERwMK2fYAkYgs56loDkD+iAvREHbfWxAqKxMnAaNl66a4GwSELcLSF4h+p6G?=
 =?us-ascii?Q?nZOv9oIdCbMNN95g/YRiPlr5hIYwDyCNqVQnFAAYwg1PTbQKNI9YZ5fYraC4?=
 =?us-ascii?Q?yE3KAly4kHxZ2RpecX6thxNASIzcDnN/UI9CU4DHsOfQRDQobYddfVFPn4K9?=
 =?us-ascii?Q?A+gFLSXzkSqCV74uNhrAiGwSc6IYctvv1a2E6hnqon5LgRO9yI+7jDyiPpmE?=
 =?us-ascii?Q?gkFb8v//tljF6wZPj/wG1MN9onyEN6W9qSlS5nrptl0F33BLUa3HHc2cOIRp?=
 =?us-ascii?Q?uIunB03QL13xSI2GTnNHeUtpvx2+RftVKcGh/y9ammVy0rrlwQ7wLKX9UHxS?=
 =?us-ascii?Q?xAGFOyg9uMga3Y0R//1P9yiz+ar75frcE9vRXfIn36ztLHrl4D6RYKWslBzY?=
 =?us-ascii?Q?235dDOOoK0zzk1dz6tRyfeXBXKEvDCj9hNrdBJWItt4rItEvF7s7+EA6al5z?=
 =?us-ascii?Q?y/W2Nb7idw5drCNVrlxSDa/h1Ma8KPDN+v31FK7RPTM5fVs7ccAhPZAI2mA4?=
 =?us-ascii?Q?OLWYGape84/F4VL3mRgCBGbdksSmsSO8kLpvd6WAhaHfQSa9bMHAKcb6SYT9?=
 =?us-ascii?Q?gUEt1LomPyKSNIow11WuUsEy1xqNizhEnUjOVq1rXAyI32v+UqZ6Hkd2HJLT?=
 =?us-ascii?Q?K6X1WfUQ7GKArpLzLpih/g=3D?=
X-Microsoft-Antispam-Message-Info: AGthmjhEw56GZeOfg+tk0u53AVp8SpRi4Y0fHK+MtLXWG0xJddo/Cgyws6M8KJwddF/Tnt94KfygBuChJSa2bSb/0CjvEA/EwRJiVrnPLoBYx0QhYXDVx6kIAFrYE8O/7ifJd6yK9vgxusGEOiKKmEXjiy9Kjc3gH6AEc9Q/Nl+fFeRMCPlYhP0wwu1bgSQGffR85+PvNPOLG9t2u3y54IhD//KUBQjkPagRluHFn1vnrZ709g4gTI6Zuu3U4ND4PnxL5ezmBKaMx00sPeX8tqyKsMunOhL3Nizfk6SEHeKIdS/n5q2XwKrrnehatKPawbZe16vZFGg43eL9KLWg87zvRf4paEy9t4IFkb+bI9g=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:5RZ8p+bZIW8Cn2IHB/SUfpadazdUNPM5j/jqvCND8C314MLlq59AR+s0XkOn2tKH6xtqiX7SUtMu8ku0cn7NuB0Mv0bWR7V6DYVVeV2GMCFkvDevOEaPprAw7jAdm4kBXyez2rtYVaxBhvMlCph1886rVaS/Ud5jgFv1xg6170U+Lg5W7H9gZhhuktKG4ZVRsLFJ5rc1pbqHSJfYg/krjtr5S7+2Ngtz/XPQFD8aCG7YQszmeheOLOpQ62C575/SPBEkMrGraFZ/v/NZUGAhfoRgBufwlKiT5va7cA6m5nvDukcgFUzKJL4/W8/JucFyGqugrwfT5I8awSFpJsAMPtPhImNmnl1LnhtHT5dFf0u5M4iD/9QLBZh3G5ISo15FlTV1znYx905lTiO6cTTxYnsZh/A9WCj0BZ00vr5gW8JFqFhiRc17tu4lqX/5B6bP/kgTHS05T474U5tl9xX0PQ==;5:nRLnba7PUqmFwwpEQyFehAF6VmrVZ1Kjbg71LOJZJdES+kH0wZrHNO13qIxB9WBzQr25UOxrUtaQ5k7jHTjMfMLSSd9dynED2eJOG5G4VMQFOBZC2c5mi89+hgF4lt4i3CrAZQdXwReSiVVmV9H8ptHpqNZn3ra7cV0/G9eVTBs=;24:O7x8NmId3winI38l64Qzi/PgXT6z6IcjDu2bCdQCShReqUgtRpdUWcxZpbL+qoOdCRWnS1zG5s2YHGyM1JbkPJPL8whjazJYYMFUvM5+Ta8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;7:kFcqkyTejMZ5RpiOiVc91kKksmC3x1j878Vq8PNSPRHszpMXS86lId8/ikHD5GMdjUiMWCqaUf7biowt502B3Z/Y1WTuD3jOB7jpVXvqa4tSVQ1YdYM+no8aTBSD0R5qukgJ2RFIqDuiopNoW5A9U11OCyAUQKAQD6OJ+7GYzLVMsupd5e+Vcd8ZP56P6xV30XdylXWoyMCioVovjO1YSiJx7RApSLyuU7LIYjTAo0OzCHPOGn0GmLaQiyFgbi+/
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 14:14:38.1041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362390a7-3b8e-4474-4387-08d5d84a7f3f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mailbox devices may have only one channel which means the mbox-cells
at least 1 does not make sense for this type devices. Let's remove
that limitation to allow the mbox-cells to be equal to 0.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 * New patch introduced in v3 series
 * Actually there're already users in kernel with mbox-cells set to 0.
   See:
   arch/arm/boot/dts/bcm283x.dtsi:145: #mbox-cells = <0>;
---
 Documentation/devicetree/bindings/mailbox/mailbox.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
index af8ecee..c2fcd05 100644
--- a/Documentation/devicetree/bindings/mailbox/mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/mailbox.txt
@@ -6,8 +6,7 @@ assign appropriate mailbox channel to client drivers.
 * Mailbox Controller
 
 Required property:
-- #mbox-cells: Must be at least 1. Number of cells in a mailbox
-		specifier.
+- #mbox-cells: Number of cells in a mailbox specifier.
 
 Example:
 	mailbox: mailbox {
-- 
2.7.4

