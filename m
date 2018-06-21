Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF30C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A6A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="E3T6aCho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A6A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeFUGnZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:43:25 -0400
Received: from mail-sn1nam02on0069.outbound.protection.outlook.com ([104.47.36.69]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932564AbeFUGnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0vwaUmdGFV38EhMggTKaTLxpNgGd6arKe/00awJnDo=;
 b=E3T6aChof9cJl6p1SJnIaP6kzeIybFDkSeyxAnXReWjlsZVdy8DjAj+J+PrgpO2yxUfHm38z32RtLt1YLSt5LatnjpsyzETDdRQGGnfUQr2C49ezjcM7iyhKm4LBscWf2ng74zcXYSPvk9pInc4v7vNuRiCfUVAvJAkBVJmv0KM=
Received: from BLUPR0201CA0034.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::44) by CY1PR02MB2154.namprd02.prod.outlook.com
 (2a01:111:e400:c5ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Thu, 21 Jun
 2018 06:43:08 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BLUPR0201CA0034.outlook.office365.com
 (2a01:111:e400:52e7::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 21 Jun 2018 06:43:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Thu, 21 Jun 2018 06:43:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53973 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtJD-0002Sj-Dy; Wed, 20 Jun 2018 23:43:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtJ8-00060U-Ai; Wed, 20 Jun 2018 23:43:02 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtJ3-0005oY-RO; Wed, 20 Jun 2018 23:42:58 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface
Date:   Thu, 21 Jun 2018 12:12:31 +0530
Message-ID: <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(39380400002)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(8676002)(2201001)(486006)(336012)(50466002)(9786002)(7416002)(53946003)(575784001)(186003)(39060400002)(48376002)(8936002)(81166006)(81156014)(36756003)(426003)(446003)(107886003)(2616005)(11346002)(5660300001)(305945005)(356003)(126002)(476003)(26005)(478600001)(4326008)(47776003)(59450400001)(316002)(106002)(36386004)(106466001)(16586007)(51416003)(2906002)(76176011)(7696005)(6666003)(54906003)(110136005)(63266004)(50226002)(77096007)(921003)(107986001)(217873001)(5001870100001)(1121003)(579004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2154;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:EXcFmTiNGkaQIGfOxJOMBm0ZxsltnFIrj56Z7XRRLqNUwXyA4359SH9i8/mgHhZy6UGVqs6UfCNt1EMT0ptRIs94+saXRNgsHHfBbgLirTmrR97uQk+fPkzfLEGNj32D
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b910d11-ade8-43f5-a2a9-08d5d7423ffe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CY1PR02MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;3:MzOpDOWF1ueIfklK4xAspy9MM2CqSg86UfGGHLKBgiEFRND54QQaGQwpW6RvPMDZrhdYqf23mKDFs+EYmTyB7G38OIWJDJzr9eO6tUQeAaAU/XzuStEeCI+HN6FsVcAFGCR6sMM+9POxz2PcppXf9Y4f7Z2L6qZgHUux86T+FQApdwWgra4xbOnjtQ2UhQ7ndCe/zC+VmUUPUZIPZCx2kB7YH8MHMtHICrba4Ws8mhgL7eBWbkA3B+ARM7rRWEmeD4UZs1HWVeVW7Cuqx0ykWkyZlbN5k26tIOaMS5nDoHx1DYE0dWANM+km1vjhrSk5pYSxA73ESUYJ2L862p+w1M371TRwb1Cbya2SFu+Imqc=;25:Xh715WUnPemhZzAe+6/lD66ZdUhVec5JHZqro9Y9yrrGXm0F02jnb9P16QDALVsIajaXoG6DeJ3DGNCe40cqQ2/0lwgoEUZhFIq/Tct+3WbCocw1Oy+a+UBHQx+UW2xQn9yJy4jrRZQ4K8ACFUxyFkdJwFOXsRSxwuXizgGClDBg45P3bsGRuxDDazXMlCdBtxDey6Gs3L7aHBnXt6FW84dr/Knm2KNAXUBap3wdzdFXoGb4n8gXbUepwlxSo5JfNm6HEJpwiawYWaXJv0gdzg0TLqmIckCCrCkTGajtpc8dxWYWMdoL6a8dN98dGH3oBQRZhRw3bWUHvbNzG/envA==
X-MS-TrafficTypeDiagnostic: CY1PR02MB2154:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;31:eMvjKivMU5AfQ1WbJMIra/uz87yrTqpMR14FWcNiWC4usMVFpbH/Xd0VXtQVAhAEDbMAuFmtMZcbf8aIdleSkWX4BWtJmJqhfelcOiIWuiONxIfH1nFiYB3WxlUSludqjGZIIQuIRYQlU/fTylPUjul7S6YV/enply+gjlUjdRN4k5WuPYEZmL8vzzZoMvhJbwGfd13QJxY/lqruBV2Y640ZmMkPszBwww8uNjdNlTI=;20:MRtP7PHNyzNQqNyMzfTBBgCUcfCnTxxSwRLyXs4vT1yjk3/WbhWGBerUcgKblK1pQfWqUucswwjnbWjsTZyihK69q5vu7+EmyqN9oZUKp/0+BzsRXSVRiuWxlXMfiSSIiVUJVmF3c5P31oYHD7gSxFvxbpfTBSNrHtFdW2i1dNEIIm5Pm6cwV54cr2NBvnWo9PXiit/94nI1LTw3Ig8QiklHm7vhFFbYcJaJ72j7Ahtxr2JrRmu1e81cCL/HPDi9cyeMs2KGfTc138k2s/50AhA3v12SJqcg20IYGhIjuz10Wc9l+ADBetwpbLeG5hE6974YFfnH3F4wPRp+lCNsWl3EiPCivYLvwuX41/lXKUgK3v+FwCf2SvI7OZ0TiwVxdU6RJH71t3TS0ZE4n9GISEuwv0qUPVpaJ9t3qIqhWiFwdGn+gYl0gNGii5xx0DXLKEQmhCs/GwzL+nzfG2QiAKWfLElnHhk4sZXWdg+ynK01pJhQZ3FelOEHrGGOlLFu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB21542A301CA7E4F8FECE81BBAF760@CY1PR02MB2154.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB2154;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;4:fFhNP91u2OZ1zN3FQVd0nm5pa3V/M6sz2dKgrik0k+8ktSamKGdRNS5PJ0n1zksKqZGoSZVMxc5TrVFrDYrl9eAH04GCOud5Jz4xVjVEtCy5mmjMgjUPlHZCBUzU5t3LuK3jl/ZGPECZqVEdyIP1sOXZ9OFggbcY7dphbAL/OUwQ3iEA6CDRL/ago3zbJGVu1OHkf2PSsvL3hCy5dnNy0yc398woKVxYQL8hq+XSdoLp1UGwX4ATRazvgOBCeRnqTHncpmPQTMe7yjjayuxX20DNRcSHZ2V7rhL7W3FuJzn0DMJCvKVTGaEiNT+yEaPz
X-Forefront-PRVS: 07106EF9B9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB2154;23:lztxtZ7x3JQKQipLO/MOjoMzWbikOB30uS6u1XN9V?=
 =?us-ascii?Q?7WuXG207yen4QpaofNSliE205/ui5R6MQBKQyvrmMVQHorfugCnDjn/IMg+S?=
 =?us-ascii?Q?244m9byCl4LwMZvVB3ny3vCFUzOOq7l0ZPqIWfrljWRaOfNL0eS+yOvlAnXf?=
 =?us-ascii?Q?U/tRM0rlPBd6OjN/WqcsNQ2xAJ/EXLE7znf6FIG2qXQLtRTRp0nDCGnvNTIw?=
 =?us-ascii?Q?ieqYd6l5ttqMn3sI1Ps8s+GZ/s5DHHO06p4ozzs4vNg4Qx+LIfcBAjkPA1TR?=
 =?us-ascii?Q?SIFHj0icycADLzHPu5mFfo9j+o/hIdEnSYI7rP+OeQYV9coY49Ou/U/x6ohG?=
 =?us-ascii?Q?JQtUJp4iqKs0mkV2VAuoZsqJQl1/8Hq1XXWe8oyNj7DcTuL6Akr15fFvCNL7?=
 =?us-ascii?Q?5BLq4umug6QPIj5oqaiYayp8ay56lKXSd1ve42HIDdTnZ28VJ4Gs8xOK5A8P?=
 =?us-ascii?Q?1PU9Ro5GDXP36pGgbN1zxmnL4A94rOz5XrOMWVpsanHw4r5JWSqbb0DniE6K?=
 =?us-ascii?Q?L6Hn3Y0SQBqWlkwgL0bVIspVlGH3LIHKV7yqOlxn2hw4OLbfFCa6YVM0u0NI?=
 =?us-ascii?Q?u0dXNuMXy8DSFMstI5etscdbHRZjT1ybsrWZHWQMhpygv6rZIGIPHXqt0ivd?=
 =?us-ascii?Q?Ht5IlT5krETHBJnSDrNbUnVwFswWl/PDJzp0rcbVuuklQpvx91Fl5gnBDum6?=
 =?us-ascii?Q?HcSH23MYn9E4kQdXc2wMQScCk2whkEUVVkVifjEc2NSvmABbbLGSC3uYGgNX?=
 =?us-ascii?Q?zPXDhR7CJ5p13l09n2Cc7SB9Lc/Y+4m0tvM8Z/d9RWUyNlQ5PEXuFlP8BiUR?=
 =?us-ascii?Q?QtyH7pRax9d61lIuA6p3bSEjqxf4UJiNwjuz1rJxLoQ8LC1sJBBk4wLTD5of?=
 =?us-ascii?Q?D1314E9xFTW4FX9M15Ldh52gIHBNoGHgas3yG0sgAH6bHWA4RScNqqTGyKL0?=
 =?us-ascii?Q?KMppv9VkvN1vG5d+w7FjuUzBk70ORZM38b5Xka4vV6dZujYKL3SPocMH3nwA?=
 =?us-ascii?Q?jqoRudDpFLz0xS7cDuow7yMWdulxRr7RDCXEvSxQ1mG5FdTa21GKj8mwvuvN?=
 =?us-ascii?Q?ABv7nXL3z91/ygQ4bRKPLZqXMX1rByZgcf2kkwH8HCEYIjlzm+L8xmwqRMJK?=
 =?us-ascii?Q?4uGYyqiIRsIMWobjhaOa15l4U7sgh9ECbfTrfOopW5PUnZwIWODqtRl1kRC2?=
 =?us-ascii?Q?eSaIpPls9ODPI/6LJwgVm0/XvmKxjoCOf4ZnM++qVfmJ0G5vaNJz0f4U/kZQ?=
 =?us-ascii?Q?sof4PzfBYq851RdPLISk7rPaXsG5zwRFVqeJ6KNy2h81js5ua+MQCgPKvjtA?=
 =?us-ascii?Q?0saqRP857B5+vhcFiBDfrt/nlC87H6tFUrpMMELrMirnW6OmJRJ8veFqQS1/?=
 =?us-ascii?Q?TzmpkzhHVd5yakuEYzrtatO3TaIs0tKMsjCfL64bRMYWlHbhKVwOXWWzxhyz?=
 =?us-ascii?Q?4wgdhZIzb/4qXjB45LL5Y04XsWWIHdx0r9Bg/cubDCFeWJSw5ZL?=
X-Microsoft-Antispam-Message-Info: 8ktnA+8B9a0xkQTuSnWCgzvpZMsyBqAqEZ1P6InlOE2b8gvrIGIy6GorFS2+kNQA0iSqWk9Cdd5olOc8bvoROacDhrlAFMMZ8i22wS5Jseera3GqOsdZ8oy+dJDPHvGNwX3i8QqAkbTAoeK7vyXnQkw8YZY+ote/0AvxS2BfA/CsK+lxLRiJq2N38DBxXtEqhaTJ7BmR8KoLznuP4m4wzJ1MWK2A0lA9x78up9IrdMhwrV8m77ZogM35gmKJEHpMwKcVa9fANZ7mxxe/n72zUB4ov4MVJQbcdixbbDZlI+s1jD4ceGRY5LkLfunv0BHfEQt6bqbZKCldSordzsIXJQ==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;6:cGoN4qH/aGQRjmqj8sdnaRoXyjE3j0BcSa/VoyTcaR1Trg7pYb4HSc0exuj5d5U/L6DuMmIAcGuswbtGNtWs1rKecvVmADBXf7RWoukMB26NUWr1UfvGusNFeJy7agUvlUN3qynA+p8MiftX+RY/IyQCqljmLIoZItmLNYnm9jPBkuW72ynLckZMv/BznAPFZmSaGvgv5OM5YzXfMFGk3Shz0ojirN31ZNC+PaJdeKJ37KJFxnuBfYHxPXyDRmkVyLPgYnKRH1TRxiu6pEFsLIdHvYu1Y7EAU3kCu5ncLX5MJX89tpagLn76ZKj43aO2CVu+RFel9H2MoQteKaqC8a8Nve/5HXfQ3OScsgBF80v1E6sUroyVraACq2CSgPqC/nteGHOcTdV4Ot/5Msg4O4izA1HKzm1QcUXaC1hid3umnjCPWcFIcLuCI20r+7f9iAf6qsTyX1Jvvxyyv4eu6Q==;5:vm+py8/q1Ofh9pYxr468ky0nhW3Xg6cDQJhyeuItK5U7aA0uMfaxtzrEJCFLJaPpgndONLI91XcGgmNwdCXFa7OaCPDFyPMdEXcggNCELakX0Ol3HV3kd53gvPl4g5sVtKC7DvNLCm4lDeATfKXlqu8pJzVxgrij5AttSgn/Kyg=;24:TfLsLFcGW0wzIHLaD5oza+YqP/JQj9hfrhCNryB4Vyir9MNM+6mWI85U7qmjNYa12h/BO6pyVfKuJL0VGKPGV2HWWxQ//9UPgYVXF1eGbyI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;7:NeSBFAquZDTC3mCyoKCcxXHESmU/zQOg0gKpbkvZrufha0vf1hNeg7CSMulEPYikuT/8Z8rINeIlSxi0oVqHNw7tfUIDcilkYfbcCyPvDMFeJ0hHVSNsH6i/7CxsqQBM3r1hVb0fFAIqvebXANmhDxR+WzmOreUf+vOvhE7REWxoWeOWFL0oAH+ydnvwOGhYuo1V2OSPKCyGGXg2wCjpwPtFCgBL8JpXyiqOcz9nY2pXqPnmBxBOmWC7ajt2RkY2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:43:08.0508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b910d11-ade8-43f5-a2a9-08d5d7423ffe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for arm pl353 static memory controller nand interface with HW ECC
support. This controller is used in Xilinx Zynq SoC for interfacing the NAND
flash memory.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in 10:
 - Typos correction like nand to NAND and soc to SOC etc..
 - Defined macros for the values in pl353_nand_calculate_hwecc()
 - Modifed ecc_status from int to char in pl353_nand_calculate_hwecc()
 - Changed the return type form int to bool to the function
   onehot()
 - Removed udelay(1000) in pl353_cmd_function, as it is not required
 - Dropped ecc->hwctl = NULL in pl353_ecc_init()
 - Added an error message in pl353_ecc_init(), when there is no matching
   oobsize
 - Changed the variable from xnand to xnfc
 - Added logic to get mtd->name from DT, if it is specified in DT
Changes in v9:
 - Addressed the below comments given by Miquel
 - instead of using pl353_nand_write32, use directly writel_relaxed
 - Fixed check patch warnings
 - Renamed write_buf/read_buf to write_data_op/read_data_op
 - use BIT macro instead of 1 << nr
 - Use NAND_ROW_ADDR_3 flag
 - Use nand_wait_ready()
 - Removed swecc functions
 - Use address cycles as per size, instead of reading it from Parameter page
 - Instead of writing too many patterns, use optional property
Changes in v8:
 - Added exec_op() implementation
 - Fixed the below v7 review comments
 - removed mtd_info from pl353_nand_info struct
 - Corrected ecc layout offsets
 - Added on-die ecc support
Changes in v7:
 - Currently not implemented the memclk rate adjustments. I will
   look into this later and once the basic driver is accepted.
 - Fixed GPL licence ident
Changes in v6:
 - Fixed the checkpatch.pl reported warnings
 - Using the address cycles information from the onfi param page
   earlier it is hardcoded to 5 in driver
Changes in v5:
 - Configure the nand timing parameters as per the onfi spec Changes in v4:
 - Updated the driver to sync with pl353_smc driver APIs
Changes in v3:
 - implemented the proper error codes
 - further breakdown this patch to multiple sets
 - added the controller and driver details to Documentation section
 - updated the licenece to GPLv2
 - reorganized the pl353_nand_ecc_init function
Changes in v2:
 - use "depends on" rather than "select" option in kconfig
 - remove unused variable parts
---
 drivers/mtd/nand/raw/Kconfig      |    7 +
 drivers/mtd/nand/raw/Makefile     |    1 +
 drivers/mtd/nand/raw/pl353_nand.c | 1309 +++++++++++++++++++++++++++++++++++++
 3 files changed, 1317 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 6871ff0..1c5d528 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -530,4 +530,11 @@ config MTD_NAND_MTK
 	  Enables support for NAND controller on MTK SoCs.
 	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
 
+config MTD_NAND_PL353
+	tristate "ARM Pl353 NAND flash driver"
+	depends on MTD_NAND && ARM
+	depends on PL353_SMC
+	help
+	  Enables support for PrimeCell Static Memory Controller PL353.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 165b7ef..1c702e1 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
+obj-$(CONFIG_MTD_NAND_PL353)		+= pl353_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_amd.o
diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl353_nand.c
new file mode 100644
index 0000000..3a0acbd
--- /dev/null
+++ b/drivers/mtd/nand/raw/pl353_nand.c
@@ -0,0 +1,1309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 NAND flash controller driver
+ *
+ * Copyright (C) 2017 Xilinx, Inc
+ * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pl353-smc.h>
+#include <linux/clk.h>
+
+#define PL353_NAND_DRIVER_NAME "pl353-nand"
+
+/* NAND flash driver defines */
+#define PL353_NAND_CMD_PHASE	1	/* End command valid in command phase */
+#define PL353_NAND_DATA_PHASE	2	/* End command valid in data phase */
+#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
+
+/* Flash memory controller operating parameters */
+
+#define PL353_NAND_ECC_CONFIG	(BIT(4)  |	/* ECC read at end of page */ \
+				 (0 << 5))	/* No Jumping */
+
+/* AXI Address definitions */
+#define START_CMD_SHIFT		3
+#define END_CMD_SHIFT		11
+#define END_CMD_VALID_SHIFT	20
+#define ADDR_CYCLES_SHIFT	21
+#define CLEAR_CS_SHIFT		21
+#define ECC_LAST_SHIFT		10
+#define COMMAND_PHASE		(0 << 19)
+#define DATA_PHASE		BIT(19)
+
+#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
+#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
+
+#define ONDIE_ECC_FEATURE_ADDR	0x90
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_LAST_TRANSFER_LENGTH	4
+#define PL353_NAND_ECC_VALID_SHIFT	24
+#define PL353_NAND_ECC_VALID_MASK	0x40
+
+struct pl353_nfc_op {
+	u32 cmnds[4];
+	u32 thirdrow;
+	u32 type;
+	u32 end_cmd;
+	u32 addrs;
+	bool wait;
+	u32 len;
+	u32 naddrs;
+	unsigned int data_instr_idx;
+	const struct nand_op_instr *data_instr;
+	unsigned int rdy_timeout_ms;
+	unsigned int rdy_delay_ns;
+	unsigned int data_delay_ns;
+	unsigned int cle_ale_delay_ns;
+	u32 addr5;
+	u32 addr6;
+};
+
+/**
+ * struct pl353_nand_info - Defines the NAND flash driver instance
+ * @chip:		NAND chip information structure
+ * @nand_base:		Virtual address of the NAND flash device
+ * @end_cmd_pending:	End command is pending
+ * @end_cmd:		End command
+ * @row_addr_cycles:	Row address cycles
+ * @col_addr_cycles:	Column address cycles
+ * @address:		Page address
+ * @cmd_pending:	More command is needed
+ */
+struct pl353_nand_info {
+	struct nand_chip chip;
+	struct device *dev;
+	void __iomem *nand_base;
+	unsigned long end_cmd_pending;
+	unsigned long end_cmd;
+	u8 addr_cycles;
+	u32 address;
+	u32 cmd_pending;
+	struct completion complete;
+	struct clk *mclk;
+
+};
+
+static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes);
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 8;
+	oobregion->length = 8;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops = {
+	.ecc = pl353_ecc_ooblayout16_ecc,
+	.free = pl353_ecc_ooblayout16_free,
+};
+
+static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 52;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 2;
+	oobregion->length = 50;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops = {
+	.ecc = pl353_ecc_ooblayout64_ecc,
+	.free = pl353_ecc_ooblayout64_free,
+};
+
+/* Generic flash bbt decriptors */
+static u8 bbt_pattern[] = { 'B', 'b', 't', '0' };
+static u8 mirror_pattern[] = { '1', 't', 'b', 'B' };
+
+static struct nand_bbt_descr bbt_main_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = bbt_pattern
+};
+
+static struct nand_bbt_descr bbt_mirror_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = mirror_pattern
+};
+
+/**
+ * pl353_nand_read_data_op - read chip data into buffer
+ * @chip:	Pointer to the NAND chip info structure
+ * @in:		Pointer to the buffer to store read data
+ * @len:	Number of bytes to read
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_data_op(struct nand_chip *chip,
+				   u8 *in,
+				   unsigned int len)
+{
+	int i;
+
+	if (IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
+	    IS_ALIGNED(len, sizeof(uint32_t))) {
+		u32 *ptr = (u32 *)in;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			ptr[i] = readl(chip->IO_ADDR_R);
+	} else {
+		for (i = 0; i < len; i++)
+			in[i] = readb(chip->IO_ADDR_R);
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_buf - write buffer to chip
+ * @mtd:	Pointer to the mtd info structure
+ * @buf:	Pointer to the buffer to store write data
+ * @len:	Number of bytes to write
+ */
+static void pl353_nand_write_data_op(struct mtd_info *mtd, const u8 *buf,
+				     int len)
+{
+	int i;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
+	    IS_ALIGNED(len, sizeof(uint32_t))) {
+		u32 *ptr = (u32 *)buf;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			writel(ptr[i], chip->IO_ADDR_W);
+	} else {
+		for (i = 0; i < len; i++)
+			writeb(buf[i], chip->IO_ADDR_W);
+	}
+}
+
+/**
+ * pl353_nand_calculate_hwecc - Calculate Hardware ECC
+ * @mtd:	Pointer to the mtd_info structure
+ * @data:	Pointer to the page data
+ * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
+ *
+ * This function retrieves the Hardware ECC data from the controller and returns
+ * ECC data back to the MTD subsystem.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
+				      const u8 *data, u8 *ecc)
+{
+	u32 ecc_value;
+	u8 ecc_reg, ecc_byte, ecc_status;
+	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+	/* Wait till the ECC operation is complete or timeout */
+	do {
+		if (pl353_smc_ecc_is_busy())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		pr_err("%s timed out\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	for (ecc_reg = 0; ecc_reg < 4; ecc_reg++) {
+		/* Read ECC value for each block */
+		ecc_value = pl353_smc_get_ecc_val(ecc_reg);
+		ecc_status = (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
+		/* ECC value valid */
+		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
+			for (ecc_byte = 0; ecc_byte < 3; ecc_byte++) {
+				/* Copy ECC bytes to MTD buffer */
+				*ecc = ~ecc_value & 0xFF;
+				ecc_value = ecc_value >> 8;
+				ecc++;
+			}
+		} else {
+			pr_warn("%s status failed\n", __func__);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+/**
+ * onehot - onehot function
+ * @value:	Value to check for onehot
+ *
+ * This function checks whether a value is onehot or not.
+ * onehot is if and only if onebit is set.
+ *
+ * Return:	1 if it is onehot else 0
+ */
+static bool onehot(unsigned short value)
+{
+	return (value & (value - 1)) == 0;
+}
+
+/**
+ * pl353_nand_correct_data - ECC correction function
+ * @mtd:	Pointer to the mtd_info structure
+ * @buf:	Pointer to the page data
+ * @read_ecc:	Pointer to the ECC value read from spare data area
+ * @calc_ecc:	Pointer to the calculated ECC value
+ *
+ * This function corrects the ECC single bit errors & detects 2-bit errors.
+ *
+ * Return:	0 if no ECC errors found
+ *		1 if single bit error found and corrected.
+ *		-1 if multiple uncorrectable ECC errors found.
+ */
+static int pl353_nand_correct_data(struct mtd_info *mtd, unsigned char *buf,
+				   unsigned char *read_ecc,
+				   unsigned char *calc_ecc)
+{
+	unsigned char bit_addr;
+	unsigned int byte_addr;
+	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
+	unsigned short calc_ecc_lower, calc_ecc_upper;
+
+	read_ecc_lower = (read_ecc[0] | (read_ecc[1] << 8)) & 0xfff;
+	read_ecc_upper = ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) & 0xfff;
+
+	calc_ecc_lower = (calc_ecc[0] | (calc_ecc[1] << 8)) & 0xfff;
+	calc_ecc_upper = ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) & 0xfff;
+
+	ecc_odd = read_ecc_lower ^ calc_ecc_lower;
+	ecc_even = read_ecc_upper ^ calc_ecc_upper;
+
+	/* no error */
+	if (!ecc_odd && !ecc_even)
+		return 0;
+
+	if (ecc_odd == (~ecc_even & 0xfff)) {
+		/* bits [11:3] of error code is byte offset */
+		byte_addr = (ecc_odd >> 3) & 0x1ff;
+		/* bits [2:0] of error code is bit offset */
+		bit_addr = ecc_odd & 0x7;
+		/* Toggling error bit */
+		buf[byte_addr] ^= (BIT(bit_addr));
+		return 1;
+	}
+	/* one error in parity */
+	if (onehot(ecc_odd | ecc_even) == 1)
+		return 1;
+
+	/* Uncorrectable error */
+	return -1;
+}
+
+static int pl353_dev_timeout(struct mtd_info *mtd, struct nand_chip *chip,
+			     unsigned long timeout)
+{
+	if (timeout)
+		timeout = jiffies + msecs_to_jiffies(timeout);
+	else
+		timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
+
+	do {
+		if (chip->dev_ready(mtd))
+			break;
+		cpu_relax();
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		pr_err("%s timed out\n", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void pl353_prepare_cmd(struct mtd_info *mtd, struct nand_chip *chip,
+			      int page, int column, int start_cmd, int end_cmd,
+			      bool read)
+{
+	unsigned long data_phase_addr;
+	u32 end_cmd_valid = 0;
+	void __iomem *cmd_addr;
+	unsigned long cmd_phase_addr = 0, cmd_data = 0;
+
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+
+	end_cmd_valid = read ? 1 : 0;
+
+	cmd_phase_addr = (unsigned long __force)xnfc->nand_base +
+			 ((xnfc->addr_cycles
+			 << ADDR_CYCLES_SHIFT) |
+			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			 (COMMAND_PHASE) |
+			 (end_cmd << END_CMD_SHIFT) |
+			 (start_cmd << START_CMD_SHIFT));
+	cmd_addr = (void __iomem * __force)cmd_phase_addr;
+
+	/* Get the data phase address */
+	data_phase_addr = (unsigned long __force)xnfc->nand_base +
+			  ((0x0 << CLEAR_CS_SHIFT) |
+			  (0 << END_CMD_VALID_SHIFT) |
+			  (DATA_PHASE) |
+			  (end_cmd << END_CMD_SHIFT) |
+			  (0x0 << ECC_LAST_SHIFT));
+
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+	chip->IO_ADDR_W = chip->IO_ADDR_R;
+	if (chip->options & NAND_BUSWIDTH_16)
+		column /= 2;
+	cmd_data = column;
+	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+		cmd_data |= page << 16;
+		/* Another address cycle for devices > 128MiB */
+		if (chip->options & NAND_ROW_ADDR_3) {
+			writel_relaxed(cmd_data, cmd_addr);
+			cmd_data = (page >> 16);
+		}
+	} else {
+		cmd_data |= page << 8;
+	}
+
+	writel_relaxed(cmd_data, cmd_addr);
+}
+
+/**
+ * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read function
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ * @page:	Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			       int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	chip->pagebuf = -1;
+	if (mtd->writesize < PL353_NAND_ECC_SIZE)
+		return 0;
+
+	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+
+	ndelay(100);
+	pl353_dev_timeout(mtd, chip, 0);
+
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write function
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ * @page:	Page number to write
+ *
+ * Return:	Zero on success and EIO on failure
+ */
+static int pl353_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
+				int page)
+{
+	const u8 *buf = chip->oob_poi;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+	u32 addrcycles = 0;
+
+	chip->pagebuf = -1;
+	addrcycles = xnfc->addr_cycles;
+	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+	ndelay(100);
+	pl353_nand_write_data_op(mtd, buf,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+	buf += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(mtd, buf, PL353_NAND_LAST_TRANSFER_LENGTH);
+	nand_wait_ready(mtd);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_page_raw(struct mtd_info *mtd,
+				    struct nand_chip *chip,
+				    u8 *buf, int oob_required, int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_nand_read_data_op(chip, buf, mtd->writesize);
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_page_raw - [Intern] raw page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_raw(struct mtd_info *mtd,
+				     struct nand_chip *chip,
+				     const u8 *buf, int oob_required,
+				     int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_nand_write_data_op(mtd, buf, mtd->writesize);
+	p = chip->oob_poi;
+	pl353_nand_write_data_op(mtd, p,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+
+	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * nand_write_page_hwecc - Hardware ECC based page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * This functions writes data and hardware generated ECC values in to the page.
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_hwecc(struct mtd_info *mtd,
+				       struct nand_chip *chip,
+				       const u8 *buf, int oob_required,
+				       int page)
+{
+	int eccsize = chip->ecc.size;
+	int eccsteps = chip->ecc.steps;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *oob_ptr;
+	const u8 *p = buf;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+	ndelay(100);
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_write_data_op(mtd, p, eccsize);
+		p += eccsize;
+	}
+	pl353_nand_write_data_op(mtd, p,
+				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	p = buf;
+	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
+
+	/* Wait for ECC to be calculated and read the error values */
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
+					 0, chip->ecc.total);
+	if (ret)
+		return ret;
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+
+	/* Write the spare area with ECC bytes */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_write_data_op(mtd, oob_ptr,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_write_data_op(mtd, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/*
+	 * Apply this short delay always to ensure that we do wait tWB in any
+	 * case on any machine.
+	 */
+	ndelay(100);
+	nand_wait_ready(mtd);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_hwecc - Hardware ECC based page read function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the buffer to store read data
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * This functions reads data and checks the data integrity by comparing hardware
+ * generated ECC values and read ECC values from spare area.
+ *
+ * Return:	0 always and updates ECC operation status in to MTD structure
+ */
+static int pl353_nand_read_page_hwecc(struct mtd_info *mtd,
+				      struct nand_chip *chip,
+				      u8 *buf, int oob_required, int page)
+{
+	int i, stat, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	u8 *p = buf;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *ecc = chip->ecc.code_buf;
+	unsigned int max_bitflips = 0;
+	u8 *oob_ptr;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+	ndelay(100);
+	pl353_dev_timeout(mtd, chip, 0);
+
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_read_data_op(chip, p, eccsize);
+		p += eccsize;
+	}
+	pl353_nand_read_data_op(chip, p,
+				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Read the calculated ECC value */
+	p = buf;
+	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
+
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+
+	/* Read the stored ECC value */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_read_data_op(chip, oob_ptr,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+
+	/* de-assert chip select */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_read_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
+
+	eccsteps = chip->ecc.steps;
+	p = buf;
+
+	/* Check ECC error for all blocks and correct if it is correctable */
+	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
+		stat = chip->ecc.correct(mtd, p, &ecc[i], &ecc_calc[i]);
+		if (stat < 0) {
+			mtd->ecc_stats.failed++;
+		} else {
+			mtd->ecc_stats.corrected += stat;
+			max_bitflips = max_t(unsigned int, max_bitflips, stat);
+		}
+	}
+
+	return max_bitflips;
+}
+
+/**
+ * pl353_nand_select_chip - Select the flash device
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ *
+ * This function is empty as the NAND controller handles chip select line
+ * internally based on the chip address passed in command and data phase.
+ */
+static void pl353_nand_select_chip(struct mtd_info *mtd, int chip)
+{
+}
+
+/* NAND framework ->exec_op() hooks and related helpers */
+static void pl353_nfc_parse_instructions(struct nand_chip *chip,
+					 const struct nand_subop *subop,
+					 struct pl353_nfc_op *nfc_op)
+{
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id, offset, naddrs;
+	int i, len;
+	const u8 *addrs;
+
+	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		nfc_op->len = nand_subop_get_data_len(subop, op_id);
+		len = nand_subop_get_data_len(subop, op_id);
+		instr = &subop->instrs[op_id];
+		//if (subop->ninstrs == 1)
+			//nfc_op->cmnds[0] = -1;
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			nfc_op->type = NAND_OP_CMD_INSTR;
+			if (op_id)
+				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
+			else
+				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			offset = nand_subop_get_addr_start_off(subop, op_id);
+			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+			addrs = &instr->ctx.addr.addrs[offset];
+			nfc_op->addrs = instr->ctx.addr.addrs[offset];
+			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
+				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<
+						 (8 * i);
+			}
+
+			if (naddrs >= 5)
+				nfc_op->addr5 = addrs[4];
+			if (naddrs >= 6)
+				nfc_op->addr6 = addrs[5];
+			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
+								     op_id);
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			nfc_op->data_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			nfc_op->data_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
+			nfc_op->rdy_delay_ns = instr->delay_ns;
+			nfc_op->wait = true;
+			break;
+		}
+	}
+}
+
+static void cond_delay(unsigned int ns)
+{
+	if (!ns)
+		return;
+
+	if (ns < 10000)
+		ndelay(ns);
+	else
+		udelay(DIV_ROUND_UP(ns, 1000));
+}
+
+/**
+ * pl353_nand_cmd_function - Send command to NAND device
+ * @chip:	Pointer to the NAND chip info structure
+ * @subop:	Pointer to array of instructions
+ * Return:	Always return zero
+ */
+static int pl353_nand_cmd_function(struct nand_chip *chip,
+				   const struct nand_subop *subop)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const struct nand_op_instr *instr;
+	struct pl353_nfc_op nfc_op = {};
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	void __iomem *cmd_addr;
+	unsigned long cmd_data = 0, end_cmd_valid = 0;
+	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
+	unsigned int op_id, len, offset;
+	bool reading;
+
+	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+	offset = nand_subop_get_data_start_off(subop, op_id);
+
+	pl353_smc_clr_nand_int();
+	/* Get the command phase address */
+	if (nfc_op.cmnds[1] != 0) {
+		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
+			end_cmd_valid = 0;
+		else
+			end_cmd_valid = 1;
+		end_cmd = nfc_op.cmnds[1];
+	}  else {
+		end_cmd = 0x0;
+	}
+	cmd_phase_addr = (unsigned long __force)xnfc->nand_base +
+			 ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
+			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			 (COMMAND_PHASE) |
+			 (end_cmd << END_CMD_SHIFT) |
+			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
+
+	cmd_addr = (void __iomem * __force)cmd_phase_addr;
+	/* Get the data phase address */
+	end_cmd_valid = 0;
+
+	data_phase_addr = (unsigned long __force)xnfc->nand_base +
+			  ((0x0 << CLEAR_CS_SHIFT) |
+			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			  (DATA_PHASE) |
+			  (end_cmd << END_CMD_SHIFT) |
+			  (0x0 << ECC_LAST_SHIFT));
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+	chip->IO_ADDR_W = chip->IO_ADDR_R;
+	/* Command phase AXI Read & Write */
+	if (nfc_op.naddrs >= 5) {
+		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+			cmd_data = nfc_op.addrs;
+			/* Another address cycle for devices > 128MiB */
+			if (chip->options & NAND_ROW_ADDR_3) {
+				writel_relaxed(cmd_data, cmd_addr);
+				cmd_data = nfc_op.addr5;
+				if (nfc_op.naddrs >= 6)
+					cmd_data |= (nfc_op.addr6 << 8);
+			}
+		}
+	}  else {
+		if (nfc_op.addrs != -1) {
+			int column = nfc_op.addrs;
+			/*
+			 * Change read/write column, read id etc
+			 * Adjust columns for 16 bit bus width
+			 */
+			if ((chip->options & NAND_BUSWIDTH_16) &&
+			    (nfc_op.cmnds[0] == NAND_CMD_READ0 ||
+				nfc_op.cmnds[0] == NAND_CMD_SEQIN ||
+				nfc_op.cmnds[0] == NAND_CMD_RNDOUT ||
+				nfc_op.cmnds[0] == NAND_CMD_RNDIN)) {
+				column >>= 1;
+			}
+			cmd_data = column;
+		}
+	}
+	writel_relaxed(cmd_data, cmd_addr);
+	ndelay(100);
+
+	cond_delay(nfc_op.cle_ale_delay_ns);
+	if (!nfc_op.data_instr) {
+		msleep(nfc_op.rdy_timeout_ms);
+		cond_delay(nfc_op.rdy_delay_ns);
+		return 0;
+	}
+
+	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
+
+	if (!reading) {
+		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN &&
+		    nfc_op.cmnds[1] == NAND_CMD_PAGEPROG) {
+			pl353_nand_write_page_raw(mtd, chip,
+						  instr->ctx.data.buf.out, 0,
+						  nfc_op.addrs);
+		} else {
+			pl353_nand_write_data_op(mtd, instr->ctx.data.buf.out,
+						 len);
+		}
+		if (nfc_op.rdy_timeout_ms)
+			pl353_dev_timeout(mtd, chip, nfc_op.rdy_timeout_ms);
+		cond_delay(nfc_op.rdy_delay_ns);
+
+	}
+
+	else if (reading) {
+		if (nfc_op.rdy_timeout_ms)
+			pl353_dev_timeout(mtd, chip, nfc_op.rdy_timeout_ms);
+		cond_delay(nfc_op.rdy_delay_ns);
+		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len);
+	}
+
+	return 0;
+}
+
+static const struct nand_op_parser pl353_nfc_op_parser = NAND_OP_PARSER
+	(NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
+	);
+
+static int pl353_nfc_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			     bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
+					      op, check_only);
+}
+
+/**
+ * pl353_nand_device_ready - Check device ready/busy line
+ * @mtd:	Pointer to the mtd_info structure
+ *
+ * Return:	0 on busy or 1 on ready state
+ */
+static int pl353_nand_device_ready(struct mtd_info *mtd)
+{
+	if (pl353_smc_get_nand_int_status_raw()) {
+		pl353_smc_clr_nand_int();
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_ecc_init - Initialize the ecc information as per the ecc mode
+ * @mtd:	Pointer to the mtd_info structure
+ * @ecc:	Pointer to ECC control structure
+ * @ecc_mode:	ondie ecc status
+ *
+ * This function initializes the ecc block and functional pointers as per the
+ * ecc mode
+ */
+static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
+				int ecc_mode)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	u32 err = 0;
+
+	if (ecc_mode == NAND_ECC_ON_DIE) {
+		pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
+		/*
+		 * On-Die ECC spare bytes offset 8 is used for ECC codes
+		 * Use the BBT pattern descriptors
+		 */
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+		bitmap_set(chip->parameters.get_feature_list,
+			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
+		bitmap_set(chip->parameters.set_feature_list,
+			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
+	} else {
+		ecc->read_oob = pl353_nand_read_oob;
+		ecc->write_oob = pl353_nand_write_oob;
+
+		ecc->mode = NAND_ECC_HW;
+		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
+		ecc->bytes = 3;
+		ecc->strength = 1;
+		ecc->calculate = pl353_nand_calculate_hwecc;
+		ecc->correct = pl353_nand_correct_data;
+		ecc->read_page = pl353_nand_read_page_hwecc;
+		ecc->size = PL353_NAND_ECC_SIZE;
+		ecc->write_page = pl353_nand_write_page_hwecc;
+		pl353_smc_set_ecc_pg_size(mtd->writesize);
+		switch (mtd->writesize) {
+		case SZ_512:
+		case SZ_1K:
+		case SZ_2K:
+			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
+			break;
+		default:
+			/*
+			 * The software ECC routines won't work with the
+			 * SMC controller
+			 */
+			ecc->calculate = nand_calculate_ecc;
+			ecc->correct = nand_correct_data;
+			ecc->size = 256;
+			break;
+		}
+		if (mtd->writesize <= SZ_512)
+			xnfc->addr_cycles = 1;
+		else
+			xnfc->addr_cycles = 2;
+
+		if (chip->options & NAND_ROW_ADDR_3)
+			xnfc->addr_cycles += 3;
+		else
+			xnfc->addr_cycles += 2;
+
+		if (mtd->oobsize == 16) {
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
+		} else if (mtd->oobsize == 64) {
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
+		} else {
+			err = ENXIO;
+			dev_err(xnfc->dev, "Unsupported oob Layout\n");
+		}
+	}
+	return err;
+}
+static int pl353_setup_data_interface(struct mtd_info *mtd, int csline,
+				       const struct nand_data_interface *conf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	const struct nand_sdr_timings *sdr;
+	u32 timigs[7], mckperiodps;
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return -EINVAL;
+
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+	/*
+	 * SDR timings are given in pico-seconds while NFC timings must be
+	 * expressed in NAND controller clock cycles.
+	 */
+	mckperiodps = NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
+	mckperiodps *= 1000;
+	timigs[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
+	timigs[1] = DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
+	timigs[2] = DIV_ROUND_UP(sdr->tREA_max, mckperiodps);
+	timigs[3] = DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
+	timigs[4] = DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
+	timigs[5] = DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
+	timigs[6] = DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
+	pl353_smc_set_cycles(timigs[0], timigs[1], timigs[2], timigs[3],
+			     timigs[4], timigs[5], timigs[6]);
+
+	return 0;
+}
+/**
+ * pl353_nand_probe - Probe method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function initializes the driver data structures and the hardware.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_probe(struct platform_device *pdev)
+{
+	struct pl353_nand_info *xnfc;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	struct resource *res;
+	struct device_node *np;
+	u32 ret;
+
+	xnfc = devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
+	if (!xnfc)
+		return -ENOMEM;
+	xnfc->dev = &pdev->dev;
+	/* Map physical address of NAND flash */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xnfc->nand_base = devm_ioremap_resource(xnfc->dev, res);
+	if (IS_ERR(xnfc->nand_base))
+		return PTR_ERR(xnfc->nand_base);
+
+	chip = &xnfc->chip;
+	mtd = nand_to_mtd(chip);
+	chip->exec_op = pl353_nfc_exec_op;
+	nand_set_controller_data(chip, xnfc);
+	mtd->priv = chip;
+	mtd->owner = THIS_MODULE;
+	if (!mtd->name) {
+		/*
+		 * If the new bindings are used and the bootloader has not been
+		 * updated to pass a new mtdparts parameter on the cmdline, you
+		 * should define the following property in your NAND node, ie:
+		 *
+		 *	label = "pl353-nand";
+		 *
+		 * This way, mtd->name will be set by the core when
+		 * nand_set_flash_node() is called.
+		 */
+		mtd->name = devm_kasprintf(xnfc->dev, GFP_KERNEL,
+					   "%s", PL353_NAND_DRIVER_NAME);
+		if (!mtd->name) {
+			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
+			return -ENOMEM;
+		}
+	}
+	nand_set_flash_node(chip, xnfc->dev->of_node);
+
+	/* Set address of NAND IO lines */
+	chip->IO_ADDR_R = xnfc->nand_base;
+	chip->IO_ADDR_W = xnfc->nand_base;
+	/* Set the driver entry points for MTD */
+	chip->dev_ready = pl353_nand_device_ready;
+	chip->select_chip = pl353_nand_select_chip;
+	/* If we don't set this delay driver sets 20us by default */
+	np = of_get_next_parent(xnfc->dev->of_node);
+	xnfc->mclk = of_clk_get(np, 0);
+	if (IS_ERR(xnfc->mclk)) {
+		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
+		return PTR_ERR(xnfc->mclk);
+	}
+	chip->chip_delay = 30;
+	/* Set the device option and flash width */
+	chip->options = NAND_BUSWIDTH_AUTO;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
+	platform_set_drvdata(pdev, xnfc);
+	chip->setup_data_interface = pl353_setup_data_interface;
+	/* first scan to find the device and get the page size */
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		dev_err(xnfc->dev, "nand_scan_ident for NAND failed\n");
+		return -ENXIO;
+	}
+	ret = pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
+	if (chip->options & NAND_BUSWIDTH_16)
+		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
+	/* second phase scan */
+	if (nand_scan_tail(mtd)) {
+		dev_err(xnfc->dev, "nand_scan_tail for NAND failed\n");
+		return -ENXIO;
+	}
+
+	mtd_device_register(mtd, NULL, 0);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_remove - Remove method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function is called if the driver module is being unloaded. It frees all
+ * resources allocated to the device.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_remove(struct platform_device *pdev)
+{
+	struct pl353_nand_info *xnfc = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = nand_to_mtd(&xnfc->chip);
+
+	/* Release resources, unregister device */
+	nand_release(mtd);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_nand_of_match[] = {
+	{ .compatible = "arm,pl353-nand-r2p1" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
+
+/*
+ * pl353_nand_driver - This structure defines the NAND subsystem platform driver
+ */
+static struct platform_driver pl353_nand_driver = {
+	.probe		= pl353_nand_probe,
+	.remove		= pl353_nand_remove,
+	.driver		= {
+		.name	= PL353_NAND_DRIVER_NAME,
+		.of_match_table = pl353_nand_of_match,
+	},
+};
+
+module_platform_driver(pl353_nand_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
+MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

