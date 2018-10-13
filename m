Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47881C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC9720895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WlHHN3OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC9720895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJMUwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:42 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:6146
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726399AbeJMUwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHrVLkNN0xdPfRpHRQ+2pGAHilJKSlasnaYCxqr8070=;
 b=WlHHN3OU1ft6TDEHHQQ2BuzNSFz5lrTFBRjuMKhJk/E+8cBMXQaqsSfqTq2hFCtI6NHDk+FInmHuhR1Zh1hL4SfiCEmPknPSmS+2cisKHJwulDaBHA2LUtotAhFsa+LbbyaGwI57aOCsW565OHuhSH83aCDGe1piViiwWv27wek=
Received: from BN7PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:20::41)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21; Sat, 13 Oct
 2018 13:15:27 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN7PR02CA0028.outlook.office365.com
 (2603:10b6:408:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58073 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-0001Gh-Lg; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlC-0007wb-Eo; Sat, 13 Oct 2018 06:15:14 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF5bs019356;
        Sat, 13 Oct 2018 06:15:05 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl2-0007oM-QO; Sat, 13 Oct 2018 06:15:05 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id CC47960503; Sat, 13 Oct 2018 18:45:03 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 02/10] usb: dwc3: gadget: Add stream timeout handler for avoiding deadlock
Date:   Sat, 13 Oct 2018 18:44:49 +0530
Message-ID: <1539436498-24892-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(50226002)(76176011)(26005)(186003)(305945005)(6346003)(106002)(16586007)(54906003)(110136005)(81166006)(81156014)(8936002)(51416003)(8676002)(478600001)(107886003)(103686004)(4326008)(42186006)(50466002)(39060400002)(316002)(48376002)(2906002)(336012)(7416002)(47776003)(2616005)(446003)(476003)(11346002)(126002)(486006)(426003)(6666004)(356004)(63266004)(2171002)(6266002)(106466001)(36386004)(90966002)(52956003)(5660300001)(14444005)(36756003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT027;1:yMa9+HZQ7gIbeVYXpOkoohNk4cE4QvLNnjYQHsV6/D+YowuoLBe73XzrHGMv4yGaDNc8a5ixkeliHB+5TMuLboPliFcpLqfoTMHMQLzAYSaJzDPFmu0hD0tLPe/WD+ri
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15cb990-65d2-417b-7f03-08d6310deff4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:QBY0kpSulyhMctRUT5v86Uw3Chli+sFO1PQ4VK6UMCb9ALthP9bslIzvqhUkXOuf7E729Q4D3AeROk+fAxMjr0Koxos3SmnSoPwJk2Vqib7bR+ozgGLp9q7aoVwZ3UKMa6Pa+AhGCYYEnDwOk3R6fWNdBBSF4sfWWM/6XIHYsrBFdNBF3X+02X6iOLeRtWclfS2MLRWcEzylDTlY5AmrhRIoHdWL/Vz35cfd3nzBE5janlq67yFlDOsoUyIoTAvwG/l+Fc3dgmKujIS4aS+IiPtHe7v2RmXyFPmlIVRQM2pjpcS1sN/juVZljAF3M+rXsq5vCHYFX5hh3j7CcpYsBdr+uWb8tNmfSAXkN+70TgM=;25:HJVhs6SCP5XjZqxTQndY99sLPA98cFUhXSGQCCeNO1qdivqD4jODjcc0fAMuod7061Ncte8UvEy09jPQJoVHhaOc2SU4Wz4VeQh30z8mf5fe0cWK/+zj9ZdcLtlS9SI4/DKvZAkx+QgqiQZ+XPwlNvwGyMwyEk8DYfdc2x/OcLQ+MtVOJLTWmGPteUjBgx3WRdsRuZOWqretUB/nbFOtMy45qdumGhqSPrQCE8035lN9LDH2ycdo3J+ccOZyVuI8/rp9so8S0NFCUu3nxSba9GulYT17f/1fXnWiWlPm9ZQOwvxFND8MHSWD92F1X0x4R2TKW50slCmiPqdWGY3clQ==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:UaqzEro/Jypv1ihz4zpbfuhw3Nwxxeca2gGKk6FsPCq3Ky+5arRkScpE8dNkVEkm0POCZCBBXOkcwKWRdzzTwa+jq9uYLMujnH+Kcb9HM2WKb14P5b5oUPLRmPylJdINvcPNNeKVz0q2TWJ2Q+xnxa43zBzmoFj8gvxG4/USaivUnP5xQSTe8/UpQ2CzzrG1ttF5OVr7L8z+sBHtuhtV8edEPkzNTfXNL9EppjNI9Z0=;20:T5uJ4V81mggbdHLxz8nN+5SRtIm11IHcttF56HAktraS2BXYTiMoGkEz5OBRLrkKA0yp4OOQ+NeosZfPQ0gSy43ABgnQYuCR5VKnShCswshMwAc0+jBCi+CEalaC2O2m+pH3IaUsvgdvpYEOnoBaCfHLhZMccDYKTKMHtFyr8PnksNzIt/wxROfWUPCtis06OC1sS1VBwqe1t/CODhljJ9r1Z1gVE67ZAIIbUJXwNbhpvwrw0J842/CblS7uBeshideZzneMWzhm2KUn2Qo8XItxoeKyxBGsURKLb5msw4WQueRBuaZP3Pvd27sg/C4NT/LBmLwR2MvA6gqHxeFcqR5nVp++bL4rwi1qvaWR4EyAGgLbyO0bpdIsHU/7UmOQP0Q3B4p4D0/S9ZQkTWBZEinDERoXYUQEL0jVMcOA6Qr+7UQFcA5HRE3JevGWU42Zh99nCQ+utO4IM1x8snMHL2IAndijvM/PwPLfDQulwxVMFyEtBd9d+iTliW7ZdxuD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB351014DAA2D7E0F68C6D1320A7E30@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:DM5PR0201MB3510;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:OgYfVw7WRsobZ3GnBd0krkiCYD85H8qRewrfkPC8mEIeqJULUlSXr4mvx4X/K5/BqYMoq0rpe7mZyzZL+J7QcpaozQ7HO/ah/9KPsOzfKYfMkb16tbQ8MgkwBnY8Drzf8M/PVw6JtLL+SMz+/7mIwNOXtXZ0JSPv//elHb3ggdqTdaCbqmOzx7s/zHbCD29CX1SpFUqXhjUXLeZMjwl1jIBrF4aOs7E8eZyuwY4t6HFgq5me1tHyL2qcICIVoAfd0KSvyyrkMDKwFYfWY1gm1qH+4k939bm8IFF/o/d3nFa9tS3KUm9m1CNcYF+8nX3B
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:cN7Iq2sgNFwXMYP+Kfru+/lbkHq45krJFAXtDmS?=
 =?us-ascii?Q?h/vvPU1pR1YLBIKUOmvthtt4jYRa1vKAjgtNqGLRWqtGWDv7HUJf2l7l6EKn?=
 =?us-ascii?Q?xA5qZcm2mHQIcxyk48VSGDZhR43aFwJJMsZa/UqGYqcVQM/3vufiUpcW4/S5?=
 =?us-ascii?Q?5OZpSXlzRsCGvoQCkFcecRRUztXocPYLmJhrEJ8JWRHsAP2IS+4nVsBsO/Hc?=
 =?us-ascii?Q?WG+9FRSt5PUkRvytmEGfQ0F4gABmK1+r8TrCwgUk139dPH+UG0WlGX3MF5Fc?=
 =?us-ascii?Q?uGRCpiGjTC6enKVbW5KhFGjQEoIpCjcCxMBa1u7RcKGVZi7hKWtTeUgTx46J?=
 =?us-ascii?Q?rjhr9BsJAb/hk7rYzraxf1EintxMJyogyx+zesSQTlZorahKns8AwmD2KqXT?=
 =?us-ascii?Q?GZ63w9zcDEuqB/mj6oR2dvE+Ag0rPtNPqZ7+RZUojE18ZV5QZEk2vt2HuDiy?=
 =?us-ascii?Q?9khTXRVw4CIcu3VrqmsRxdvCPJFEJU5iVVojgh+Cmt4548a6Ht+H6P0slTvS?=
 =?us-ascii?Q?Arp93iXOhyQC3bdFmwb8MfcNOqjkse7ny5rdU06V/hjerZ9h7bvsfRYvgfrp?=
 =?us-ascii?Q?3IB7bguPTuKymwblf3ZjG0IOLegOP4gtaUq274GHCvlkcK8jSEnb/591ZGj9?=
 =?us-ascii?Q?zINzolA02NejlmUxpG4fMlqIAyRYQP9eXkd9jBbEv3xdqqNtdXzF+fZD858B?=
 =?us-ascii?Q?CG59jMxHKu43DCl0O9QPptewvsHlX4LcsqPpGeq7Sh8CkyBEJE+QNlcdVG1g?=
 =?us-ascii?Q?cJBxtLajeiy0JIfa1wYCZ4isSa5nrHJlEuiAxNCWag/CJLE94Sm/rMXgJUG7?=
 =?us-ascii?Q?5J8PL92GafRSJ8WKpI07wnD13YrWDXhhyzFY6uOYAjHA2mdUAZ+ofRrgVelR?=
 =?us-ascii?Q?5qdWN66vYNABKuF2s/zzFAqfB1zEdWQGAI4djLd6bJFdRBoJ0/vGkKFWFxlS?=
 =?us-ascii?Q?YjcebGmvFQrKfKx4z2rr/+QVRvpm+owhKUB6kAl2AoFKk/bDahb6quGlF2wS?=
 =?us-ascii?Q?5AzpCXIuSXMsZKHV9oFYf4y29iuIYzWuYifVd7yZR0dfbeLMttbsiuHmsHoh?=
 =?us-ascii?Q?vQiRx5YO3t1EhyfZuRu3btWOxDIy6mGITbYgVjbf+07xT5A+b9bsTZ2ul2qU?=
 =?us-ascii?Q?NbPJlFAhX94C3SmlYXhJomQxYNAIGRXfuQ+pjx2Vl9b9qTXYgKOOugwzjN40?=
 =?us-ascii?Q?h61dEGh3YpIv/Jxxbn7lZfW9cJlWYx//DATceCPMi2i2DPh1gkaUhLog5Uob?=
 =?us-ascii?Q?6JlfrjdDaGr6he7dGxdLfrHvWiKVoLg/BTP5j5t1P1pG3G+T10c8NufWe29o?=
 =?us-ascii?Q?JQw=3D=3D?=
X-Microsoft-Antispam-Message-Info: hNKNSoBzfouGlO/6YXka2yS1W7eXjNJ7y9cV5xK6NPspmw+wtW07PhoUpG8J/I1LhI3PcdMlRfNdALKqNuzXJLwzc+TakBVIVIM0gxEbyJ2vr+dAmpyNkc0A+VH1Y48/S4PnA+etVwV3msDWsRJpFAE68/a5qCabaI4DpsEj8zJudI5s4C6mGt5ymKNAsFBTYIcrbtAhFTuIa6sPsY+GdSye905aRA11Yq2QCAumTgZBmSw1bspP6bWskv8yZxndE7bRRjY1xFO1pFKSTvxjcyGWV7DapJzK1YxnbEdoxBaSIDP34P7umyt3LNJwS/gekF/nQ/gl+1/9biLq93zFls5zSbM78e6Nc3kPANRmc7s=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:SYr7sTzKgNqQdZ5JiZjaaRklCpm6vWVj3vPou/hSIB4k5ODej8Y3ctCrnHTOiGw4jcCXAPBZbNts2VxgHnwNgeE8mwXqAse5rFH/nOyJkfDvwwnxYfXUEJSIezqO4o/n83DaiHTepVhT/n1NyCxOxpgH2cUwk6tLHXAFQomlrYG0S6uidsb/MLMFoZyl46iSvrZ19B78O5XQsYji+o07kCHKmDYbaSB1g2qV/8/OkMlvOeVQ9iS6kvoeI9avQuHW0PHHri+jian6xK3Tw+ULgGQ5tIDAacng03wEoo2m56dqwxgNjKKZFXHyF9GMx6GX5NC4Qj+esx9w/D+xESD2OsUdhq2xiWko75YisrEu1VO0OlYITIPAeVx6UJgC+yX95PPTT2YINm2ywaACnogqKsEy42aMYkDa7bkFXG50cycDhstMmfLiaVTcvs8BU/Vi5ewMeLPw/e7THswYPcG1CQ==;5:kPEg64e8qlf/j/nV7gJ1qa4dfD/S4qdv4lHiootOd2DozkHLCH1EFA/8R1FWq4dPLgyftgprwmiJLwKi5PxbekaB+ooDGgZeJiksKiLR6rlWAvFEIUyESJ8sqVzYzZk4PAHKkuhCa0hGlhY2QorMGnHigEbiLcHhEQcbvbggkSs=;7:iDXUE4gOndd49ZFqBcIc2ma9Q9+h2Qu9rbXHdc4Nzwxd3yhQIwwjSr3hJcgy/i/KTxxW0uHJVQ4+KDIfaWNgT7WUFHiG9SbGrqvaTynJ2w2qpAb3L2XZNynqtQ9+qXhgRCRXEl7bVyg2K+MKNidorh+QYsNovYNAWqyH2Z66JBCwEBNubJH4L23VLpAVUmCFL3VV6jB578xtnDnvNB0Wu5XR620knGp64GSXV0/Mi4q9XnkNhzOTGO6XMZN0QYpt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:20.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15cb990-65d2-417b-7f03-08d6310deff4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to dwc3 databook when streams are enabled, it may be possible
for the host and gadget to become out of sync, where gadget may wait for
host to issue prime transcation and host may wait for gadget to issue
ERDY. To avoid such potential deadlock conditions, a timer is implemented
in udc/core.c and which is started after queuing a valid request in
usb_ep_queue(). This timer would be stopped by the gadget driver when
a valid stream event is found, otherwise the timer gets expired after
STREAM_TIMEOUT_MS value and stream_timeout_function() which is registered
as a callback function to usb_ep->ops->stream_timeout is called by udc
core.

As a part of recovery mechanism, the stream_timeout_function() stops
the active transfer on the endpoint and starts the transfer again on
the endpoint. Doing so, will reset the stream into ready state and ERDY
is sent to the host, thus the deadlock is avoided.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v6:
	1. This patch is newly added in this series
---
 drivers/usb/dwc3/gadget.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 032ea7d..aab2970 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -573,6 +573,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
 			| DWC3_DEPCFG_STREAM_EVENT_EN;
 		dep->stream_capable = true;
+		dep->endpoint.stream_capable = true;
 	}
 
 	if (!usb_endpoint_xfer_control(desc))
@@ -1535,6 +1536,18 @@ static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
 	return ret;
 }
 
+static void stream_timeout_function(struct usb_ep *ep)
+{
+	struct dwc3_ep	*dep = to_dwc3_ep(ep);
+	struct dwc3	*dwc = dep->dwc;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_stop_active_transfer(dep, true);
+	__dwc3_gadget_kick_transfer(dep);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 /* -------------------------------------------------------------------------- */
 
 static struct usb_endpoint_descriptor dwc3_gadget_ep0_desc = {
@@ -1563,6 +1576,7 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
 	.dequeue	= dwc3_gadget_ep_dequeue,
 	.set_halt	= dwc3_gadget_ep_set_halt,
 	.set_wedge	= dwc3_gadget_ep_set_wedge,
+	.stream_timeout	= stream_timeout_function,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -2469,6 +2483,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
+		if ((event->status == DEPEVT_STREAMEVT_FOUND) &&
+			timer_pending(&dep->endpoint.stream_timeout_timer))
+			del_timer(&dep->endpoint.stream_timeout_timer);
+
 	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
-- 
2.1.1

