Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5297FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC3228064
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mL9sjRHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3228064
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936755AbeF2Pbg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:31:36 -0400
Received: from mail-by2nam03on0048.outbound.protection.outlook.com ([104.47.42.48]:51856
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755079AbeF2Pbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JptFFXKPWzHFGvFx/yYW8J1iuo7aoM4mkEbfS3Yjk8c=;
 b=mL9sjRHeclTOq0MxVILlOfh5VEeUK+v/CloaVJdhbF6JS448O1WDXCBaAubWfUsPp1JWm32v60wgLRTU1B08/yptTyBxKh8lvjlpVdV7HbY8XfI0k9rygJ7saO27VdRCPRdISRDS48JW5Sx1o832Kc4Cz2jiS4dyUupffiHALUE=
Received: from BYAPR02CA0007.namprd02.prod.outlook.com (2603:10b6:a02:ee::20)
 by BY2PR02MB172.namprd02.prod.outlook.com (2a01:111:e400:2c20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.906.25; Fri, 29
 Jun 2018 15:31:29 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BYAPR02CA0007.outlook.office365.com
 (2603:10b6:a02:ee::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Fri, 29 Jun 2018 15:31:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Fri, 29 Jun 2018 15:31:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54511 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fYvMt-0007Sz-Ld; Fri, 29 Jun 2018 08:31:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fYvMo-0002SW-If; Fri, 29 Jun 2018 08:31:22 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fYvMj-0002Qz-8e; Fri, 29 Jun 2018 08:31:17 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [RFC PATCH 2/2] net: macb: Allocate valid memory for TX and RX BD prefetch
Date:   Fri, 29 Jun 2018 21:01:09 +0530
Message-ID: <1530286269-32235-2-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530286269-32235-1-git-send-email-harini.katakam@xilinx.com>
References: <1530286269-32235-1-git-send-email-harini.katakam@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(438002)(189003)(199004)(36386004)(7696005)(50466002)(316002)(51416003)(16586007)(8936002)(106002)(63266004)(48376002)(106466001)(76176011)(36756003)(14444005)(478600001)(110136005)(81156014)(81166006)(8676002)(54906003)(356003)(39060400002)(47776003)(305945005)(44832011)(26005)(107886003)(4326008)(5660300001)(50226002)(77096007)(2906002)(446003)(426003)(9786002)(476003)(2616005)(486006)(186003)(336012)(11346002)(126002)(6666003)(107986001)(217873001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB172;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT005;1:kTq7DzCQdjRxduDMkpYEkDGzBGVzmNwbqIikTtpABckCnjgTBSKKwI/s4nf9kkR6nEgsriesOOvIml3Eihmvj5WHVubKss8f9f6RohAJA8Mlm9jFvHcW2OY+II106ivC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1e17455-97b6-48db-1f5a-08d5ddd561ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB172;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;3:+DOg+MNk4HnyPKo0woBupMSwgclGbTegNzaTlC83JQNZotPqycBc3KkUv2hYNFDMLx+4xqXOs24mmVYXoxIK7Kr7ebuw64PtZWhLbf5Jvqt5kZeWmhwcJ5S8fOhxBPfB67qwNx6wwlTCp+JQxdSFap4rNAwoc+knjpe5imbRaUYj6zTM6dr3TOHw7mvxlmoO87NxC7cV1UUqyi+l714nwfFD64W5xy8snYlUxNNyGaahDLnrQl4zKB147plbcS9iuYYNKsZIPa0wnSi1M6bL/5acdyjVAuByFghX0ltugqBhI0403NsBMY7dIZgn5jitxSfOMxAmAAPi74lrKtW4p+2V+QD81MEYlIhSQfLCAGU=;25:z1ZIXB/6RbKznDUaT57o8RWg8u+MJp7ADHD0XqQK2m3qZ2RJBngLyfPQiIHn0JdYzHll6s6VWcvwjA3TvkQFyt3y/znxKXopu+4e4MbTPSvSk20WNty3K8x99vzKqt0Y17ubwHxXxRm8AoLLCBu7SKE+oDraDBqnnDfF1oqmRsfAxjpiHvj7XbXwACKPUyEdztI0Bw7IM8qkOaGmPgVhjxvdjhWGlVCZliz6/tGGNYL/e0tHVdY/D4uRmlN/ErmbU9bkunnds+ASzZ6o349UxCuvwPrsP3pwyxskP9lmYJTc4r4iQiKmS7wk/3Qq2m/OnL+dIqA1SrK8wk/Pq0QsbQ==
X-MS-TrafficTypeDiagnostic: BY2PR02MB172:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;31:GGDeFoHvY6MO4bnTAHYetwz8casrkPUhiPQVle3s22oaS02QhFaLqK4K2ueIfw/X4kJGimOQZ3twTLamBU6xXP7eOvvo+wJW10a9Q0xqVRaK6APRcLo8dxnHJ4zbfpo3qzlkx37AS1J7Wvks+uu4qdkgUjzbWl+/VZMAN0Vxdd72GsBW6RqLFiaquHdNV2hefKuEhfwEgirolEIJzpO/eWsU4PKc9+LCJoKzNP98PEw=;20:MIQavZrE/X5Jo5EBtcLV+CZpv6GX4UCeJiq3Zoli4NvXXHMNkPufvZIj5CvRJ0Ggr+EiBrOoCAIrgE+y7PDxNkTCslCUlBAXGOvqDf6wEeghlM4g/qcT7PhvTrchtkNOJxguT7Xhu44mmZvnMEgYhaP/onmu2UdIAYnIYhFZDjKNELtUyzc6leCooWd4czGzY9paB6d2z/PKSz7htCd6QAY0TsQx7N447dYSI67VfoS/YSmNPpv522c20ZyvZ9hKTKM0Xgmwn0kM1M5X5UsvPtOL4S0Hd576Ushh3L/kFT6I8RMtJlO52kXxe71L/hYagHoUK9BNNO5CstzGQ3WFZkDd5d0WBpW+uUhKd39bh91j5JNPZlROanjD9ZXVP7Im7aN2Dyoo2oOZh/aT8588Iu/Ig0LWGvaxUdYUcO/FoF8UK7axr5sfYiH+xWMTGrE3Beh5Kg0a96iq5DoCUBLqtBxBj7zX3ZmjQ1CjfaRhVSyNftR1KqGuMVABwfR60GqK
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB172F2E0F95B25922C4585A0C94E0@BY2PR02MB172.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB172;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB172;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;4:JBSZnaLTDBmIx4m+FECNFbFvEGwNgSu6s/QScy29afp67sAGHfyyB9NZWGadshCOPjdxtGGWDXfqroBBxaErL89Cy5OJN0xQQ/c1v5MM3Oi2EZfLE4z5uKrvtODBtKdXUtgtHzlxk9PqRDd+6wyPNuCfvZYgox1hOrSVafkhTk17UNmQVmCUSnjAipHn2ml5avn0E/iYlmBz7aWytrxbOBJvmhugJzRI1Oo3xlgWPDijsSuqDt3MXFHMaiyA8N17Qr9WsE/BVSDvAZV1KVkw61NPRNPsqpQ7ahidlXqSwO4rP1Ib0ynZhjA9J92Zzt2d
X-Forefront-PRVS: 0718908305
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB172;23:yImxp6f25q1+TBJeVvxEMnX3pyLmpzDlXODvmQzaaq?=
 =?us-ascii?Q?QWINxNOnKRY9MKF6mZiUauXOue8dUujOoNrIi/JycTWyfLddKjPodp02DbKn?=
 =?us-ascii?Q?qluUm597oplbzBOvfPsbwv8soCAwla2S+LmX6Z/SgiHh5CYqO5e7MBY8bovt?=
 =?us-ascii?Q?SqResWgl+BBxgZfhfEeU9CyrgblTKkYqpwshJa/6phvY0jTtMSBrTdVwkyQu?=
 =?us-ascii?Q?NPYAm11YF5z6cHCyibYarJ+aE7meIqTjsizq7MwYAlTqwp3zwtUaw9lj69JA?=
 =?us-ascii?Q?tikidYXS8U53AF1GZ2lGJe/YyOB7x2zS1n1FLxaSKGW6vQWpFr081j4giNhY?=
 =?us-ascii?Q?MbLmelzogaSGGkFNpE0GV++6VoV5XaURLYuXgJ5kWAsVt+QKxFqQJGjIhpYw?=
 =?us-ascii?Q?9DicUxVqSTLYfgvSyX2urgZ0ONUkhelKPlAQgOeqjJLBWoZlLQwVTdvv8rEo?=
 =?us-ascii?Q?L6LdVdTsyct6kNjpxxLLNXqX2Tnftn3jHbTG2vmdrije5De33+UDcFgz6dRI?=
 =?us-ascii?Q?vHC2rK5GpqzousxcK7Y6ExeCiIurqUCMXbGdqs7lvWT9pNPSo/YFpx9ZrYT+?=
 =?us-ascii?Q?WeuXX65xy+E2c+BjXrmDHECTYC+/C8sDtorzDqn9ZooEmKj+fy9Ab7yLVWoG?=
 =?us-ascii?Q?nVtqyChixNcBTgls4XXBW46paVpO8nYm7u9/iXxr6WfDnIWB7hvGYaG8ufVv?=
 =?us-ascii?Q?6Ok9aC462Ia9qdc4d172u1RwSpVsLnhh0DEaytqrJ4m8C8xJhf2w4/B4Ytxd?=
 =?us-ascii?Q?wNaCfRmFYVNg/RHH6KEPe+DtLQmDKd+FtQnwVlFP2clP5Szrog0xCbZo1LgB?=
 =?us-ascii?Q?EV4i56IrGE0FNRyX0paOtzzlAplMzwraWE2Bi85taWGHtZ9jjpA5cwlb89Ay?=
 =?us-ascii?Q?iHWw/PKbb1qj+XM55Y7z0gnlXfxucLJYFI6zMk7KNjwd2LYx2Y71FwACcdsS?=
 =?us-ascii?Q?6x14iVGGWvl/mmRJETGq0LNEEJ8OFxuLANJYzBRpkuFALQWqK+Jfo0ASqWZb?=
 =?us-ascii?Q?t4vpulqviHd+vDKUA/RXP2H+bFuSBtvl3wU8hfXY9pMEHwwDplxZXO3G5Be+?=
 =?us-ascii?Q?pnBSh48FoWKERjjcYvcqbvLF30b3VDU5E6QBFKlV8loHUiQnp3gfT8uNclm7?=
 =?us-ascii?Q?t44P7Z4MG8omO92ETI7DBoqbNLh5OPuzYQwAW45EJ/D1GldUxdEFH+hStb5N?=
 =?us-ascii?Q?unV+9lNDklRnSXmlKLhYz88N8HWeLU7MKLvjOoRHhhih/uz8JQ8egEhA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Vwnp9RLqHp4rjACiznum1Rv6amIM+BnosV9/AY4waK9J7H10FP9Qq2A405M3IfoSGw2yduFWMLa6m7k7wI76kF7n+1UCwPxPaBu9jSLYXePN2l8bsh7BJXK7MM1iPXplSZd0iChutlgX3LeWkVxWl1iNN1S4VT95SAi//pOf26pnaFBsf2AOkUmRJFNkjOmKLplgbsWgaS9K7kxROFuEVkZ9VcAzdgi3hrtZSr7ffbcJrhF3UXZWKqO6bB/+0uJKdK513WLfgY89Qb1ktRkUszHL7/nf0dVMSZvaG2Qh8BrLu4ob3oPQJGN6bW17IJrOfdAUA7Kw1MsgGd2mLXIxlCKqlZlEF2j6VMojkNLSKF8=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;6:TbjzvjMSpMrhUcKzRTbW3SRCOKRAUv125koqYeTn17f9dj6QpBr0CWiq8WbOfqUB1ft8IkZWnyFu2Wj5mPACFyks3mSPyWF+KOY8E+iXXc4nrFQ0zo7xcPkp3xdBM1aZkP+G/dBaBw5WD9m4Q21N99KLcmrHz1FHn8+vGXoVlvr7CNe3+0w0n0MJIl6UwIYLwvhcpqTv/L4jF0jH41NgqAF7fOydRVG7GmdXXcrX1w/hpS5D0xiPMUrR68SFGWFtkPEXOk+psYzBxsDpKgAAQIUtgZzJBrbqZf/VH/MWXomhX/XG13Fy/ncgn+Pn/sqwp1F20dR2xqDb1po3f3TFivV633xOPFtslNWh3mvHJzePfuZnqgGuLrEF3DRnTU1FoynX4ma6bkIKFbsdd6Xg2YbSP7LFsGyuPC2fe6QPHoTxxczeu9yXiW7/HzmvdS7wrBDsX9hS+GnkVP8ID+0+MQ==;5:mXqzQhPDGSVoCrD6oL6R7xrx+1nlnXl+kCefhXwI0GwFz8YIlIwJPoE5l0b7+4R7uQeT3PBg/FJ2T7inzO3tM4PuYTWEQELG79xoJEpUWtPfITDlV5C59Ue4K0RytYm20265jVGmJMVjFyBRBqvidfNqHABoXdRHQ7MyPqWIS3Y=;24:3a/KuIvLu0z1pxDjByWpL059a4YNLzy2bWS4deWZmJtzTONjIW5g1fGZAY0lrE5tz6ti2yye+mUIj3+17CdRBSsFaNw3FVssRVtsMadLlXE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;7:ELEYBu9ZoXA5nqEENkf7nPYpMeIHytKUn6H5GvP1d0njEGsdKGz64uGBGF8AfVzfFba18F3Qxopk81cZur8BN+sOTzq4dXa+HFe/rVjoOD+9dvpaCm8sCAu2Y/PLZdMO9MsDb/jkk6Xqubnl+Mrw7Md4Sv5ywb0kPzeVUI9VgUeJ3Gaz6U0O48wDa9iDITmysyhbPSF++5mqrzqzAg9geJpxPlF/vIEQsPf+APNseY10OvsJHSlSd+tPqptkbRUt
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 15:31:28.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e17455-97b6-48db-1f5a-08d5ddd561ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GEM version in ZynqMP and most versions greater than r1p07 supports
TX and RX BD prefetch. The number of BDs that can be prefetched is a
HW configurable parameter. For ZynqMP, this parameter is 4.

When GEM DMA is accessing the last BD in the ring, even before the
BD is processed and the WRAP bit is noticed, it will have prefetched
BDs outside the BD ring. These will not be processed but it is
necessary to have accessible memory after the last BD. Especially
in cases where SMMU is used, memory locations immediately after the
last BD may not have translation tables triggering HRESP errors. Hence
always allocate extra BDs to accommodate for prefetch.
The value of tx/rx bd prefetch for any given SoC version is:
2 ^ (corresponding field in design config 10 register).
(value of this field >= 1)

Added a capability flag so that older IP versions that do not have
DCFG10 or this prefetch capability are not affected.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
 drivers/net/ethernet/cadence/macb.h      | 11 +++++++++++
 drivers/net/ethernet/cadence/macb_main.c | 31 +++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8665982..b267a7b 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -166,6 +166,7 @@
 #define GEM_DCFG6		0x0294 /* Design Config 6 */
 #define GEM_DCFG7		0x0298 /* Design Config 7 */
 #define GEM_DCFG8		0x029C /* Design Config 8 */
+#define GEM_DCFG10		0x02A4 /* Design Config 10 */
 
 #define GEM_TXBDCTRL	0x04cc /* TX Buffer Descriptor control register */
 #define GEM_RXBDCTRL	0x04d0 /* RX Buffer Descriptor control register */
@@ -490,6 +491,12 @@
 #define GEM_SCR2CMP_OFFSET			0
 #define GEM_SCR2CMP_SIZE			8
 
+/* Bitfields in DCFG10 */
+#define GEM_TXBD_RDBUFF_OFFSET			12
+#define GEM_TXBD_RDBUFF_SIZE			4
+#define GEM_RXBD_RDBUFF_OFFSET			8
+#define GEM_RXBD_RDBUFF_SIZE			4
+
 /* Bitfields in TISUBN */
 #define GEM_SUBNSINCR_OFFSET			0
 #define GEM_SUBNSINCR_SIZE			16
@@ -635,6 +642,7 @@
 #define MACB_CAPS_USRIO_DISABLED		0x00000010
 #define MACB_CAPS_JUMBO				0x00000020
 #define MACB_CAPS_GEM_HAS_PTP			0x00000040
+#define MACB_CAPS_BD_PREFETCH			0x00000080
 #define MACB_CAPS_FIFO_MODE			0x10000000
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
@@ -1203,6 +1211,9 @@ struct macb {
 	unsigned int max_tuples;
 
 	struct tasklet_struct	hresp_err_tasklet;
+
+	int	rx_bd_prefetch;
+	int	tx_bd_prefetch;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e56ffa9..a7612f6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1811,6 +1811,7 @@ static void macb_free_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
+	int size;
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
@@ -1818,12 +1819,16 @@ static void macb_free_consistent(struct macb *bp)
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
 		if (queue->tx_ring) {
-			dma_free_coherent(&bp->pdev->dev, TX_RING_BYTES(bp),
+			size = TX_RING_BYTES(bp) +
+			       (macb_dma_desc_get_size(bp) * bp->tx_bd_prefetch);
+			dma_free_coherent(&bp->pdev->dev, size,
 					  queue->tx_ring, queue->tx_ring_dma);
 			queue->tx_ring = NULL;
 		}
 		if (queue->rx_ring) {
-			dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
+			size = RX_RING_BYTES(bp) +
+			       (macb_dma_desc_get_size(bp) * bp->rx_bd_prefetch);
+			dma_free_coherent(&bp->pdev->dev, size,
 					  queue->rx_ring, queue->rx_ring_dma);
 			queue->rx_ring = NULL;
 		}
@@ -1873,7 +1878,8 @@ static int macb_alloc_consistent(struct macb *bp)
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = TX_RING_BYTES(bp);
+		size = TX_RING_BYTES(bp) +
+		       (macb_dma_desc_get_size(bp) * bp->tx_bd_prefetch);
 		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->tx_ring_dma,
 						    GFP_KERNEL);
@@ -1889,7 +1895,8 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 
-		size = RX_RING_BYTES(bp);
+		size = RX_RING_BYTES(bp) +
+		       (macb_dma_desc_get_size(bp) * bp->rx_bd_prefetch);
 		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						 &queue->rx_ring_dma, GFP_KERNEL);
 		if (!queue->rx_ring)
@@ -3794,7 +3801,7 @@ static const struct macb_config np4_config = {
 static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 			MACB_CAPS_JUMBO |
-			MACB_CAPS_GEM_HAS_PTP,
+			MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_PREFETCH,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -3855,7 +3862,7 @@ static int macb_probe(struct platform_device *pdev)
 	void __iomem *mem;
 	const char *mac;
 	struct macb *bp;
-	int err;
+	int err, buff;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mem = devm_ioremap_resource(&pdev->dev, regs);
@@ -3944,6 +3951,18 @@ static int macb_probe(struct platform_device *pdev)
 	else
 		dev->max_mtu = ETH_DATA_LEN;
 
+	bp->rx_bd_prefetch = 0;
+	bp->tx_bd_prefetch = 0;
+	if (bp->caps & MACB_CAPS_BD_PREFETCH) {
+		buff = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
+		if (buff)
+			bp->rx_bd_prefetch = 2 << (buff - 1);
+
+		buff = GEM_BFEXT(TXBD_RDBUFF, gem_readl(bp, DCFG10));
+		if (buff)
+			bp->tx_bd_prefetch = 2 << (buff - 1);
+	}
+
 	mac = of_get_mac_address(np);
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
-- 
2.7.4

