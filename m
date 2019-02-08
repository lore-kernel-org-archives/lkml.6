Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34791C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC9120844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="no1297wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfBHQMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:12:23 -0500
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:42496
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfBHQMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXbnnot0xdVW7bF83WkfShnLbXyjRIV7dsnkGiKeaMw=;
 b=no1297wTpo9SP3f7NXcT9RMeI63GKCjHSe8grB1BfBa9Zwt2uINtIcIrFH5PklhaY2MPObUQ679D7LE4++dIGZtk1052cPvh0S74t3I1hkdv+7PK0hRN6zjJLwuICDg+cjDJu2oVJCHfllTCpmmH2+KQ79OTc2i/3XDy6GV4z6s=
Received: from AM5PR0602CA0014.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::24) by AM0PR06MB4001.eurprd06.prod.outlook.com
 (2603:10a6:208:b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Fri, 8 Feb
 2019 16:12:18 +0000
Received: from AM5EUR02FT059.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::203) by AM5PR0602CA0014.outlook.office365.com
 (2603:10a6:203:a3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Fri, 8 Feb 2019 16:12:18 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT059.mail.protection.outlook.com (10.152.9.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 16:12:18 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:13 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:13 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5]
Date:   Fri, 8 Feb 2019 17:11:56 +0100
Message-ID: <20190208161201.7860-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(199004)(189003)(186003)(8676002)(305945005)(7696005)(51416003)(246002)(2616005)(956004)(26005)(316002)(7636002)(16526019)(336012)(126002)(47776003)(476003)(7736002)(86362001)(14444005)(2906002)(110136005)(106002)(426003)(66066001)(16586007)(786003)(54906003)(50226002)(44832011)(8936002)(486006)(4326008)(53416004)(3846002)(6116002)(74482002)(48376002)(4744005)(966005)(36756003)(1076003)(6666004)(106466001)(6306002)(50466002)(478600001)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR06MB4001;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8914c293-d7ff-4209-e380-08d68de032b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:AM0PR06MB4001;
X-MS-TrafficTypeDiagnostic: AM0PR06MB4001:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;AM0PR06MB4001;20:kfO3AIUlNjfVy63II+vE2lYgto0nWbpBIKOPge6RWhBfRyXWygbhBgeHa8OOlnp09r0vP7Wp0R6xioQeYttvNV0+KiACWiSWhKCZikogbS+HTRTBvo8smv+sImp46RaC3DoyYSSDozFFkxjwZw2rONbFISiQK6UAbRk/NpmEXLHLizPLcbnBNuNXGuE2GPDMfahTqQlZ8fZ+EEqPcTLmpmj5HZNL8ICmc16kyjV8YfztgzsL1uNt4fQ9O1+LsVTPVWffqcHAj7AG+Tb/XaIMSQOIwob5yzmiJMhrDjSJDRSVMUFFzaN46ANtzd/t2Fbj2qBLs6vISfimWBY75+luJqPh2RtRTr4/IGaO5dTBArUth/A1728bDoRQLEB0LoJvifuVVtLdGtvigLQnijgw3PLXigqOmoVHkFihkR0gjxAj9uPTPSdVI3GMCpu3sD8pn7i6SBawKKBApgEMadGF75UCetIVzpMcrcYvVKBdKETB13dItLJIeLlOuLBRViJi;4:XIdMWweQCMFH0U+XucYxxJDZmUqmyx2uM8OgUPuXKd3WlQkEsnUdqlV4E0qEr2quaUev6tQSuc7FkOGn7zx75exhUcREZR8YnWW9zZv0d14Af3ZTafFvDjU3vU03eCgB35+RYMuWoD72Ye3zAXi0l062sryjkRQkgSV9G2ySaXlt3tAMpgc61GING+XeG/imatTBHD9keydHKrrPQGksD4+jPxc1CLHjA88z56iHerhSZk+kIDYiIitDoLloCIXLDTC4fZPgkEO3X9SVEUOpKUJG6b7KSAMtfzXL9rzbetNxrkdlgzq72043N3GSYBvG
X-Microsoft-Antispam-PRVS: <AM0PR06MB40011F682420ABC9DA614746EF690@AM0PR06MB4001.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR06MB4001;23:YJbad3X587FbSkLsiFUdPrHxJiU2VXMsLguKSVW/Z?=
 =?us-ascii?Q?z3565xtmdGnfsZNfUj6BF4JOoWYFOzKciGYw/zCjkWc601D0QFjy6cExULbM?=
 =?us-ascii?Q?zSi09fv4rQS9ls4hQ4fHE0IDq/3QOjxbQHJN4GJhF1ISF5SdPemwm8lwhseE?=
 =?us-ascii?Q?2A18/hELzvXR5wSgnWMLi5nIchxKvR1qkh2NARkgnl3rDg52Oi0OehcYNX7I?=
 =?us-ascii?Q?NA32ZG3/y3TFYN09fKvhdhvbbhHaui+6hcyvqsyL3DNPmqdOdJklip3mGfXi?=
 =?us-ascii?Q?7PtXyUnYvb+yddvhsmHO+lFuCDvdoTfoA20Af1ecCsXgcWUynYkDq7bi8Eu6?=
 =?us-ascii?Q?EYI+wfMb0ujILdZwx8WlI6SwtbEH4ZEau1Zzl0Z6QpKjpXUv8m4Bbl7p+u7n?=
 =?us-ascii?Q?luOpvH+jYlP+TyEj7jKvzNcpABdNNBBKVxV4fd76B7yMlBDBWcb5RBgBfqcS?=
 =?us-ascii?Q?RzlSdaPd4AERJMevo5u4MX5e+M6Ssox41mq7SmvU/qw3YFymLlBWvwzKg1IU?=
 =?us-ascii?Q?52kci91ElljWfEnYIfgL5Ihk6pBdFX3kT4jG2J9HLZJd70s76/yHrz5gPCZ5?=
 =?us-ascii?Q?hTpX1BpvuX5s1n1c88oFtZ01jWLvRVZpA6RcWuKKK26VxUIZsb4yKWgca1FF?=
 =?us-ascii?Q?8vKUBB83omBwsVNlhtwJoYUx/hLAkWoC86W5kGsGlSVcA2Kl3rbiqBm6YI7m?=
 =?us-ascii?Q?DHZsHroQjDH22kc5eaYgFlws394uYrUIwyZ1cUdpKDg0FhMa2HtOB1NMsKBn?=
 =?us-ascii?Q?7m87N62YEh9ynqjXzyDTSNr6z8kbdaKQccroZ6EY5SspguR2BWW6GwZSO1CD?=
 =?us-ascii?Q?Je7u8HYI4nD+e4uE/mCbO6P5oJp5Ml4mnGQZU6P8yky6ZkpgyoHfU+1L6eGm?=
 =?us-ascii?Q?h25ISQxet+6EsaEQFvGyqZ2cr5Yheqh0uei/i+9W5C32BPqAPyoRxCX/wzJt?=
 =?us-ascii?Q?Wqs92rnTANfT4pI3UGEg/cUENesNff8gZ1sBlmIPVALySAQ7oY8Ag/8qLmUr?=
 =?us-ascii?Q?PLY7YzA8mP7WnoaqtOldwOexjmY21Z/c7ezTfJW0UiIhAJpPgsnkSALgN/0S?=
 =?us-ascii?Q?Mvoq5jPbjq6il3Ce3Ol86zk6xh3rJ6R/sJJ4KOsGSrK5stVgvj426q92BOF7?=
 =?us-ascii?Q?ygnGE1/jz5NysGTKgFAt0DfZyHL8GT24UwCNJ+uttG87GqCNCga8/FyF13x5?=
 =?us-ascii?Q?qaG87qIHx/LtgY=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2ILj2dwL+sHg5gWYM5PDuexIoFVCDIXjsyO245MKouhkQwppsFzHfhzDM+h8ge7TOqi6oQfdjxeqku9xffECPUZCti4GtNwFQbhxYPHA0GyzZ4m+CHes1+ooivdbh0jD1foEgA71+cdE3nnH8PYA9ZfSRpEdHJ8BG7eykYPJ0npoOSxIMzwl4UVDGSTsz3ZlblgBNwEyMde3r6FDGHJmYWvuglGpjGHJmIBGUVP4kDXcF1D/nM8NSTFnP5TBsiiPtOmPjwBrb496ofyCPkhNzqJSTUqe08Y19uyb9DyzES5851NOXrvg5nFFAWOG9XNR7WfoQTMn8zmnhx3HDfjDfia8x+nm5pHIeTadDsicaf6nxznIvONRuolA6JGwSHTuOHaHGR9JZo81OtzHq+cDBQOP+g9B3H7jsbsNRt4npcM=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR06MB4001;6:m+4sIV0lGXx7eFWdDY/oZaWgHA2THw3dfsRExnJUftfcTvgOnhbW2ngY5e9omZLtoz7GLPeHZGsBw2h/UPDR0/qKG+OJwg1Hqi+2SSCaYc7qRKY0G2fBodrqBS8cCtLWfb7F9ylKKVDLVUtK141fjAQuZ/CiVN2w3XndAKNVKW0Rl4RZJPHVGywcjvImGc9wZsXWoaw0gc08+OSkbD4Bjgt3HjCYbn/QNA1R1XXHIyyrsnLms1x5xbl0wUs5BER0PNbU92yyDOQxp/ORPXBourikCSGsS7F+HIYCtoFYXyE9TCAFF6n7fwWw7/CBdPIc6rNFyN+DHWyOMx9tYWyD1ET/2xlOPwZML5ie4/jrKG9YdjBpXhceoaoY/yUryeE+x32yrME+N7784+yhU+YwwxjuVk58+QiIApOnOzYkKxHe+LOFhgh6+r5MEaRCoGbG1IURyCD4hsleVjB3XF491A==;5:ah4lL3UZLRSM8PANaD7SzHWPcP4xg4EOQehva3kSAk/LlgSZjQG7/VLv6bMsJtvdyMDl7872p8vqHnuR5lJBkBTlgGUQmW50aTn0WAs/41bnDn92ObMvdgpFAAKYHvOnBoW7V7ZenhuwCxUt09nFBAcnNC1xP5ZbdajqYhbBWpUo+/HV/WUg8FXPU5SGkMIH6jxzic2N2yfVYcBhvCa+Rw==;7:p9xlr6olK8wfdBBmo6yvgSHn3ZVHJO2dNNOYGYe9TYmh+a/ewltVD1b9fw1eUPM7l4BMTmMqpOUN4Jo2Ii35K0rs+nlCmjU6Qsvy4peXhorGpuCAbk5xdShGBr7UVHq57NISIZEF3khymHQQL7qaAg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 16:12:18.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8914c293-d7ff-4209-e380-08d68de032b6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides improvements to the i2c-ocore driver.

[V2 -> V3]
- fix error condition on platform_get_irq(). Copied from
  https://patchwork.ozlabs.org/patch/1038409/

[V1 -> V2]
- replaced usleep_range() with udelay() so that the polling version can be
  used in atomic context.
- added dedicated patch for minor style issues
- fixed delay computation
- use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is always
  necessary and a trylock would generate an extra interrupt for nothing
- make the driver ready for an eventual master_xfer_irqless()

