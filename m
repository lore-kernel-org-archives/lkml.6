Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D57ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA748208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="a8BH51/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA748208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeGMJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:41:12 -0400
Received: from mail-eopbgr710046.outbound.protection.outlook.com ([40.107.71.46]:24546
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbeGMJlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQKnDOFXvboHZmeHTJmb9GoJgg3mOA58469J7HNnuiY=;
 b=a8BH51/fHK5EGEFaFcUF/a+I2L3ZqhKCmOLD0IJDZ/RFWeSWqsgMSQecTJ0Ihbuas+LokRgi8LFd9MYfAtknj3/tLPczEgipqzSbzck2ojGXsXWd5Qoco+2y5X8EunNqeOI241UXBQ8ey1ahCxxXaSQQwfje4nSgdmQQNX/oPk4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2637.namprd03.prod.outlook.com (2603:10b6:300:46::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Fri, 13 Jul 2018 09:27:16 +0000
Date:   Fri, 13 Jul 2018 17:24:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 2/3] dt-bindings: arm: syna: add support for the AS370 SoC
Message-ID: <20180713172457.6193a92f@xhacker.debian>
In-Reply-To: <20180713171712.05f58a74@xhacker.debian>
References: <20180713171712.05f58a74@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MR2P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::35)
 To MWHPR03MB2637.namprd03.prod.outlook.com (2603:10b6:300:46::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff69fb3-dc1f-47b2-b854-08d5e8a2d492
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2637;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;3:YQQPSD0u6VVDaXLPCrSLK/tM1BczJGAwVR6bVnywT95xmcoGE1qI6PzyU2EJ/Ns9HFbnI/Rp3yluNVZHKw97wBGuFuZEeOq7TwtIbeUZ1VTx2P/5uCWEO/KBKNdjSPIEJcolNSK5COlaIpANPEFmglJSt5EReVjOvjRQ0In7uFhCUm7TMgYUAcZPmCGyYCsHSG7t+ym5cRXsL+FjMiBMGCjVSDLHutrR2eHB2pv5nGIS9/tNNvzcORAjKnakHv8U;25:M8fN4oLQhKHmMykfBMkbj6sSJp7GA8LE9I7AdLuHfuIKCrfKT1XHf2PKcsbyo7wDN1aBRpSubFUG7vJIabRrLyBAabGlEmsc5AqklWsF/a+qX29LiGMDQ6EVAPBFgbCQoq0Wl7toPs2kSB5A+aTzFfGto+d97CRxucy5yh0RS++A6djl7nVP4IyGcEd3tinVu+AKmaKAw6kP6/rvY6coTCDf4y+0YzL1EKuaW+h+5MYfdLifH5Osm1aXKnlyiirdVsZuJQEfOJRVcP4dV+Gt8vK/hvna+2Yr4oes/fyIHq8BRxdo3WiBMshz/9x2FGZ31MplblZgdaETslcGFVHo/A==;31:bTAk4aZcH1oPfb67psSPMOwDrsYFYmszlhZS12BxLrgyLxniql/Xh8LCR2NpjSYXe/79SC4AruFYBUTmHkHnfH5zxVZ2SH0phpVtQ3a8Vy7bmDuHz47HDehpDEhjTjauC82wGn7TS/pLptzo4AxWb/LB1a0gxLiqC2De0SrO8jjDMd9Oc3UEZyU/us1OSYERHCS6RpcH7DOLeUU3h4pgDSXMNHozQ5gaeJVkfU4LEYE=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2637:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;20:eRP8TolaCoXy9OYE3jDFjmqYTdXpP3h+IpEy9GUjw+EcxII/ouL4r57mna6IyRnRnmyjhrHJk/SoO/HtV8b3nhmOriU4LQzmlZ8W9PypmT6dVlPrn6zsJje4hZfXnA1hmQiS+/FZVBtMH4dYglf7G1CPcE5X6MTAj5x7jjP32iUXfhXe3NlND2iFXdLeViK6J3vFGYBwSj0hKzspo8WCbo/6bO05mS8ZwuvyAJ1Qx6c7mNTCFijS+iYOKRRiAbGs41CV0rHCMWK7ttBc9gOV63b2H9UFtfCI6SjZVduuZHdDgj3wwg6qREHaQqJAOhMuhHSBSuCZE+v1nCjLBwbN1aefqiiH1IZ5xMtQs0FoIDrBuXo5YxUyLHmVyCSqg3NDqz3pkbNnjVkyqSqwYWtmv/Y833Ge4maHAsuxWztNx49lkOP4Wj+gNKK1puH76WsN/An1+Fy4b+Nyn4oTtDWzYjXjeD9NlDpKVCmFNjeYC/VxTmwQftrALhGgAstaTCwl;4:FyjdVLr+T51JdulGwdMbf7tgwekHF3e+qYY6PMA55OoRQbR4AKD2xLgMdVeh0jwtYNolBrvbbcBW5j4cA5XcMJ9x0i2I5O/7xBru16QIptVUWUKcL+jgswtT1rKC+i06XVFNj3hta4UIPoifl0C+2M+FM6QIz8ehp8M0OAMtB5afnKS3pf3jBoIWFvJbJi10ksr2A8PHan3PVdBDMY4/Dzb0dE9axNe2zcTx3s8pyCUl1dhtl/Spl8hzmF46kWq1/K/IJInno+JTe97qccdjhQ==
X-Microsoft-Antispam-PRVS: <MWHPR03MB26377422C8118A84423954DFED580@MWHPR03MB2637.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2637;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2637;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(186003)(53936002)(86362001)(16526019)(110136005)(11346002)(81166006)(3846002)(8936002)(66066001)(50226002)(106356001)(446003)(23726003)(1076002)(8676002)(6116002)(956004)(486006)(316002)(105586002)(68736007)(230700001)(47776003)(97736004)(476003)(81156014)(72206003)(55016002)(2906002)(4326008)(26005)(25786009)(33896004)(386003)(5660300001)(478600001)(50466002)(6666003)(76176011)(14444005)(7736002)(9686003)(39060400002)(305945005)(7696005)(6506007)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2637;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2637;23:rYZnrbIq7UriWuMqMJt468PdGY3xXsU7/DZKHNhwA?=
 =?us-ascii?Q?ekkyXyJE18Rn8vcycjzGQunmHVDMdGhk5nj80T8INZCawRMD0qDQeFG9rKIn?=
 =?us-ascii?Q?q1CyyGq+qxmsLgT8EJ/87kJo7HUgKsjPfEhjmMeFMN9/sOyhzHR/tc16AfSH?=
 =?us-ascii?Q?LhMNE29q0t4r+8b62L0e4h6wKeR1HTSezt/u4XO21jyecffRFKxT0/Th7jpS?=
 =?us-ascii?Q?deTZTmOeSYstz5kroe/gSTGYRFrOgrUb004aUYLSFEnh0f2xy4n9evwDlHIm?=
 =?us-ascii?Q?NNYqEI2hhyqF/+Iixm8fQsj2MA98Gcw+ATsb4Lro+lkMhE/nRomSf9x5K12B?=
 =?us-ascii?Q?pfE10jrjnJjFl0QK8cbk9QhRasXPLN1a21c/yE9wXqXO4zbpN5asXpjvbKTJ?=
 =?us-ascii?Q?DPEm+uqBSYLXfy5QVKL1UwKgf/xpVlORT4BBZvjnokAIv5aUW8TkC5u9qJZE?=
 =?us-ascii?Q?KvnBAkVk2Q/TNvk6RHF2jSFsuPBwrz97Xcb6n1QkUdiFdagGsCCgauvf0Kth?=
 =?us-ascii?Q?sRxzn7Ejqczh7p5dn3yOwogHv32fGJLMAf74CbX33ift//tyRJ1c/6ybTUcj?=
 =?us-ascii?Q?4LEeXc3oJj0CNYYUvf75cBOSc0Q3qbdFOY/1/WVvAFAoYjha7tIjTguX43pW?=
 =?us-ascii?Q?CVXRPAxGqhz98PGDrVS9MG9AjYbtAfHwbasnfupkpSLxe+9Vn98ccDiXWccp?=
 =?us-ascii?Q?3vJtMLPoCFsqpSqYzkRW2AYMq8iJEahaVJ/O7K/532eWQ3BuBzs66+Gn5ToS?=
 =?us-ascii?Q?TAWjRqUKZ77m8MaBIPQ4HXZ9Q+Fv/wcZ2BHTGFvBA1m9uUbceWkxxG6a3+Do?=
 =?us-ascii?Q?xoQbAsSEzbZ8G/GHO5eNtamohyx1+/zwsbChk6j6RnvUPwE4Pcn69lK1DG4n?=
 =?us-ascii?Q?BZKJbLU7e8WOzNPX6ONXrM5bpijzfUxIM95H7vPvFgKZwMW9dFxg7XqMD0ek?=
 =?us-ascii?Q?mqaGT083FmFIMUDdLF88abYgTn6KNk4zOA6KPBBm9ySCHI4MuqvaACjEKbNw?=
 =?us-ascii?Q?EDnd0VIkFCcgUbCtWIBh7hAIirHFVHpInFFIf80rRvcrwiWvqhpKRI7wPGot?=
 =?us-ascii?Q?gmBwUcmWxUAl70U6qMsyTZKJEz9rC5w6ujO3UNE6ZcGT8xQM44PFceBGrmNY?=
 =?us-ascii?Q?9pvoo8iUx3cVEPHczjqqE/4OceC2yhlLAky4iEyd8UMWgwxmiKt1r9GrCfka?=
 =?us-ascii?Q?AIw8eYZupnvxzrHtuxmHU7wRywO0dfvmbZDVz3BdCfXd9c0DHiOV1tpJBfNM?=
 =?us-ascii?Q?zYGsUYorRjbbUB8CtZmKHpD7Z0h33cUE1Wsu9Yk?=
X-Microsoft-Antispam-Message-Info: IQvbspCniUdsPxww38Slab0+HD5zAlPK92eILlfXPQysV5G4ku8pQEpHnU4ZcgGfr59FsUStnKTQuHyB+83cwAstBXbu4wGgce3v6b8aWmCTZAUXJNQvQq8bDJAUWDh0Oz3ZsmeQYA3dXMXJ1DF5egjNKOxlO38h8Rt1zGshjAkcEip7LX34jH01M3INJ+BVRn5bxjgHAiU6Oo3PN8mvf1M8uQDZs8S5jgZ2jQrO+S9+nnKQkq2zDP8gZZCKO99Whs1iYtHe3QWS38YY8Ho1P347u8mcTGMVQc+wtV516d84NaFF5p7v+RCWQDgjRILnvSnvRgxr8JpLMNIkXgl7/6hTmnnuZOqVoDMH+TfB9jc=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;6:BOc52+ytB8KlwhVCd+vqwHqa3Zwv790KCtxTMPvdnbg9p6eQSLp9zBes7g5ejzFF8yaeUkepGuPYWA4zkklV44i5mWQYcz2GI1yyhVfi2WGdyjihP5hLnyV5kl58S3VjTTTaBcWIaF/98740gzPn4KtGmWFlaMb+F0kZNURNeE9nawuynz6tETVo6t4smfEIkad+4f1PeLb9Y6dSp65zeJFEuaqJAL51SbPLEwy+IGnFTF71bMjgsjRh6WoZo/c8rFjPSAdYDjrNuCAvT//XtKO6K7uFqyP75UGbsSCG2zOTM/cz3bWAKLIMRaYx3DsrBvAwPO5k/XDa0so69eLw+R1XSdJbLJnFxWk6fLwLO0ijleqEiyzQe4rh5A3BC+eZJp0aKFcSGlLuyiH/XTpDKEJq5UnftOwig2sN3xiavvB5dTEuBqoJxrPxwGJQf0Cv+Dn3LOvFIQK+tI6TxXq76Q==;5:U5ni/UBSK0MCv3ddH02bm6vEf4jDbyoe3WLwYFkyzTBOYTOqbHnRO0f2l79ONd6uW6wwMXpjgYfpiBluW6U/x/viiIBD2xn2zzl0syQZxKhBJ3Gb9CHc6hvEI28/Zh5vvjzIuA+U1lajBH0M6AQewwQSMGA9mKg3BW4/GxF/fFg=;24:IwIqJK2MZLuhbT3l7qfBDSgOnpvIjKDDZYM54RXsMJ57+ygy3IhFjaPIIqnTasJbnSXJD89Z6/GHWxL8UxreVw0sPxu5e/BOBvBmeUvvlg8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;7:DJxxaHqV9SccD+cJDbblcGIPNDEThdwBJFpS9qkp+itHOlcMAOFpSlhcr+/gFvzdw7qFIg55YmpGapHPqfLqxS7IbDkBIsxQGamntvCSwcPjDrPSf3FRWHLIUrpAa+yip7zTon8ofwojZoRhPBwDUAXXdHnGCehN5QCMwoHsSUByRh478m9+uD9FE+NcpAHNqZGULMg7IkCS3aNrCnwiBJwlCR4ibuifUaCHHsoGfcrdLCVtufUnIfKFg9J9CFBJ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:27:16.0818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff69fb3-dc1f-47b2-b854-08d5e8a2d492
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AS370 SoC is a new derivative of the berlin family. The only
difference is the SoC isn't named as berlin*.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/arm/syna.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index 3bab18409b7a..3ba1d7b5ee74 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -1,4 +1,4 @@
-Marvell Berlin SoC Family Device Tree Bindings
+Synaptics SoC Device Tree Bindings
 ---------------------------------------------------------------
 
 Work in progress statement:
@@ -13,6 +13,10 @@ stable binding/ABI.
 
 ---------------------------------------------------------------
 
+Boards with the Synaptics AS370 SoC shall have the following properties:
+  Required root node property:
+    compatible: "syna,as370"
+
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
-- 
2.18.0

