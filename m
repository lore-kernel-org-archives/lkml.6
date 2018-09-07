Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD93CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8281920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kBrgwwlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8281920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeIGRzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:25 -0400
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:5216
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729310AbeIGRzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5Q9cau0y2Rjs9+j4B0MckVojd91G3BKlk3vIiI/Wv8=;
 b=kBrgwwlDOV50lCgBVMpz/CgRt/MIfTDNd9Yz6tdhR7G5iw5KkwATAbSbmhuwIfmlVKkuSjuK40BV1D0aYCRjU7ppg3lpEwydvgBxByE+Q5GSUc62xwmX/AGrV1UqebZPcqTgYyj4m+mlzaXJQcm94LQBvk+m8y38wiaA11ghP0w=
Received: from BL0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:207:3d::20)
 by DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:11::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 7 Sep
 2018 13:14:22 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BL0PR02CA0043.outlook.office365.com
 (2603:10b6:207:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46032 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000Wf-K8; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-Fr; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE63d019326;
        Fri, 7 Sep 2018 06:14:07 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaM-0005lN-LV; Fri, 07 Sep 2018 06:14:06 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 5262D60493; Fri,  7 Sep 2018 18:44:06 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 5/8] usb: dwc3: don't issue no-op trb for stream capable endpoints
Date:   Fri, 7 Sep 2018 18:43:46 +0530
Message-ID: <1536326029-16327-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(2970300002)(438002)(3923003)(199004)(189003)(81166006)(48376002)(478600001)(50226002)(8936002)(6666003)(5660300001)(305945005)(106466001)(63266004)(356003)(8676002)(81156014)(2906002)(36386004)(14444005)(186003)(106002)(51416003)(76176011)(39060400002)(90966002)(6266002)(26005)(107886003)(476003)(486006)(2616005)(336012)(446003)(11346002)(36756003)(126002)(110136005)(52956003)(426003)(42186006)(316002)(16586007)(54906003)(103686004)(50466002)(47776003)(4326008)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4937;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT027;1:5ALN1DI+O67MVdasPTmscTHtntvIPtt/YWtEMp8hQDZReis6+WWplN2avktBXo7EjBS5h45fOBTo0ythoezfavIfrrxmFKSASKmxVLxr0qumhs4Kn90lohR2q5WjvUhn
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d12565d-be26-4c92-8e4f-08d614c3d27f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;3:4P9nri/IhmGu4hU5bUlwIfIVZHzYtprvr15mLBlGIc41kUMrpXoiSAqLXWNKveDgDnUZA716h3U0xMmjLAVBgbkizmEByVBD/fYPcM0zJSmSCnAKOBFqBCA9niFEyZhEJ+CylJnBro4nv4/BDeeTozVH2GVRJv2+aKiagEkyWLE2/cuFJEWV2E93tlTMPWP9mLd4Z4F7uoW2C34cyvHOokE3ARosbkwO1k8L6Mkjb/aAsVSsX3XY7FgiOwKgDfPOGYzGJ6tTIBDnERyKr2oDgzTxijnMvZjG5o3IMQif4Jp3wrQgRS14be4sufh/4P6ODFaM2wO3dFil3PbnahQ+neK2xPt3hnlotW+QYNnzJ5I=;25:CVN9TlMBBV0+7yLHm8bb+ncluOGYBGiKpWFaCRR+4oPYKrKrrilRdHn1goAqrEFJF7umI6KyVQK5MN6n9Y1i/5x4kRE1fL+bwJYymlQrem/OL/wH8iPZCOZxt88dP1jYeXTGYdJ5HyIhZ8keJ/emxmHQVwzmDW9un77mRfgb2jf839q08Z92AWDgewNPgK95Pgd3lrgJ2KVkDjqFgDcZXEBJG/MqRcQ7ouaCwOWaoycKg6mrt5Lc7pWFS3qw4IFqZmk0PzjVAP8uUjnqgvjiy/F4FKxOAhOdj8g8xZziltJyMcZ6OLQAz1aV1w09BQOChn12UuHdljm3d4a++0mfhQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;31:dr7wPbssMSwdFDWAddsnV1wgM1PiyVpqdyjHznuB2GxF7SQJIoPHg2GW83qYqmzxig/XNcKuHZgHDQXfBF2/RrLVSN+QVU+I7ukUlxFsrll+Jf9zc08Ej2oqA3pEe1QyxwdRUH6nGjlY1LXBCOJyoL6uoXLrIfL5+0T/3cOF305WZ+TTmm/0cBIN2gHK4Jswqz0HsT1HCWPjucD0IEaKmvMLdf3AlTaXJCgGDXsmpus=;20:yY2giLiRD0DaVHnIhcSGZ4bNGOumdfNhkDKhixv552hoRTszzWcOl0F2QfVjHwxQJ5gdCbwhg0KxhptSjwMhb7P53oj18ahuMq3A8+5z2OTG0QoOgFtvmhjqrJ5vZ+lm3HmCsCsBwOwjKMoNZuzNEAP0a2u6zNlPDy7VvObrbVUftA5krOKayGtN2Cz7FIxnb22Wjc2uztNdoGSG0bnJ4T7YK2FTQ470CZRVWT2IU37fqFYCP0WfY3OpgMm934Lhpd4Gq8ke/xTlGZWjLlmSP05hPel9ufNA7w4yRVRRQ7iYekPdlO9RMVu08/loDsM9UCcIAJiGSlre1M9H7VxkJtmF/m3cHtD96QU24LP9LhWjwYONXD3qa38tSPQGm7T9OAMjiH/wPLdesjJZDnLrbwcybd7Cv6EF/1ZiJAr/6RfsDsZG9H0YrJL7CN3rYCehbyBsdbaCHWecLYUTceHVwOfUiVc5uzwQeWi4CMtdmSE7YeBIPmHDbSlz+Mn8DMjY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4937E257BEBBCEBB8FA8788BA7000@DM6PR02MB4937.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM6PR02MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;4:7vnxxXAf5lERcihCgJrODFmz6VTriiiN3Fgo1WyT75oTHYbK2vvpKedVmGR046Xm8E3VowPbk6P96JT0RqyYRn84F0+7RtdH9sJ+uR30J7DFahR7WoK6jfX7ROUkacSdO9GpLQUnQleAVn9C/4Gts2atqxo283ewYMTwxzEG4wtkdoz+wfWWqZlcA9dY8QB2lw4vzt9o+8VbUVExHNe6KlNAKlY+AFvG1Ytr/AVhdbFTPlpzAgmZurzez1UPggX/lgG+yeULwkA4jxxxRTupfXtXhdJXcCOE65jqRRInELZts8JEDhOTglEnmsGDKOsT
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4937;23:2KVchzXK7zHBsw3NOOjHbWFek22dORgiNHvf0sdkA?=
 =?us-ascii?Q?QTKsIMQbHpU5h1IGGfjzSdt6IVDtUxVNpfVzDcinB62z+0ZrlrsvDbn2teNR?=
 =?us-ascii?Q?+8AEBaGbasEPWmOY99mP97f8MFs85iqroJL1mvKyFKIDpxUnlrWwYi/yeAPg?=
 =?us-ascii?Q?E9qt1veiCi0usNmS/QI+xOb2QZAckLAqfmgZnSQJivv5s1URcae4gXUWK/Tg?=
 =?us-ascii?Q?jpnofPMVDbFtePBei4uHu8j/8Q3iBIb7S4QPLY1k32n3wTnYijNkYOdyDJh+?=
 =?us-ascii?Q?kY5BTP2ijg7zn5FpUjqwCuSs/h/PjeY/srGOVRXlnaBtgb+iQAQDNQE39k7b?=
 =?us-ascii?Q?x9nRdmPahy6pUlI23hnEzrvNR8MUwXW8r2N6XAmGJw9/IfNpdD0x1wM8Oa44?=
 =?us-ascii?Q?JCaYFvu/T2rnrT38OiKvsHzmBCp0+/lwU9LLr57S9piUwO2tzydOonrsHyj1?=
 =?us-ascii?Q?hWiDqjsZbv8k94F9ZuqJdaacGad2fvYA5V+Rd8U1ruFNWGNtQ2kSd50EEb9n?=
 =?us-ascii?Q?cQBQcY7iRwWfCbnT8xJb/VuU54/ZtpHBv7Xz7UGe9OR5HoD0Ply+ogyYbZSm?=
 =?us-ascii?Q?KmtKCv0geljgILxLdYVN8rru4yRE3zTFjiYku6s3DnXc2bte8BftSJycHb3j?=
 =?us-ascii?Q?pyWTDX0ygYJ613IYABO/x1G4/2zy+wCFLadV3GQdk0F2sUdqUnKSDJkNyrc0?=
 =?us-ascii?Q?C9VhyQpt2E6EAIqzGz7hL3EaE2XIW8ncwU7pWz0Yw7X7B/rK+oCFljneOKpl?=
 =?us-ascii?Q?AAgR89+pv042LSjJu24JdK3oFCWYNCJoXzOBa8/Rj0UA8mkDuwHk9LgiGYxt?=
 =?us-ascii?Q?2NpSmQR5lCzN4xqFViMxIyJhR75+M1zAdCoBF1xyI57NMj9w3W7MJQMXXfJE?=
 =?us-ascii?Q?IOwPk82IfU3w8It/CXZkiYUa1JRkVkP4cNTWtu3sFnapeExgUr5chHGbJWBC?=
 =?us-ascii?Q?dRWbxirRrtBIiz6tBTvx2ErIr/rjcTobuZJUt14DgbAedlzRaHUNBjYSSm4O?=
 =?us-ascii?Q?8bnTdoiC8KApk/0zMnkUBb2RInLpcX+jeIj85jMbay0SxM4+euRNuObu3Nt7?=
 =?us-ascii?Q?fKY6DR0l8jte3dvLonrOT18JPbDj5XWCXmsUEflyBHNXOpMyvDTCcmBKRSbx?=
 =?us-ascii?Q?oYsp97sL2Ajsn6XfsgScfaKKPjkbgXM6gDl/eHwUHIrlrxp8qpcPtFjIMlnh?=
 =?us-ascii?Q?tQWQh/z2ei8yxGxWaAVXmO306eu5UVQ83+SG6lGutedF+3YFdentQQbSzS2o?=
 =?us-ascii?Q?0h8xCsihIWqY7Vo/jY=3D?=
X-Microsoft-Antispam-Message-Info: UYTBcrrpNZhMiObq2EpQVvPeFY5niisWs0qYCHClMzB6QlqC8SAkmBVIBQ4wUrYY9tUxF+rY6y3v//+HmzKJ28H3RQoJYA4ZsUEW8ZFznOF7/diJDWLwQQC6bqL9egq3Q37g2klto3UOKbxdOlsRjdwycVxTt01xG+TWXOF9P+AHlhmGxCjUjy5q/X9JzUGnASNROrSTZvTiilGCKMWG7aE0VslYxlJg+SabPFq+Ibn13nj5vR3h72UdXEjfjE8SQ8aLTVy+fe1vV27qBaY9hdg7hHrTdNjrhQl3d/jfttEFNJhohHrWiPeID5+pDfe1NcKLzrJQrz8r3U0xnMiiKmlmcFMbFLpFQd+WT1xOrXw=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;6:WL1im1EGbRC0ZJeW2TV8Ebk5/9zYsIKAzisVzFkeWDmHgbaLflnUfG4cgznmoNT/NpGLQOMXvWfiFopnKnJFzQ8+fT/cZSzn/z2qDlhZuZnOwvlKJWn7Uy3LBl9l5IvmNY+Zc9BvFRVV/DGF9Uj3ZgxHNMj1t/OODSHTRNCjQ4ypqHcHD7OFqKnbLn0Mz3YNPQ9Mclg0GC9NZYevOGFWRibmNNRGmb5tK/QE0bKsYc+zdxxR3kkUz3mF89RC5haJJO253VGbkXq0+NI7dY1I/0TwtVRBwi1wZBUmiegxvXB2c1dlQCHxbW+WTcfC8ggh1y4H3gemUXn6a5Zl6kRg9ky2O+R7PLtvRKoDySoP1FqzFmPUCLaBpe6gMw7SPmatTYPI6IEnXQcZ3gJtJuLu3Hg1jyXIgeYzoSNtRM7uLkI5qcDyIo7uCud1FRNLlgSZEEzY9Gm5ESElKN6T+f/0Wg==;5:5cV1hjeE51XdoPEJ6/XcPjd1G7hynTZ/ysKoKJb6IrYo9BPfg8RLuKq3ltK4dr1cga/Yl0iY592MamsfpDV1Lttge+beb27N9d1aDsfyEPPiVHQzBSeTE5QtxfWZGQ37M7myhrY1a2qFm+fTn8FPsqtZshPWOWgNW9OL2rLH5jI=;7:lRIxSfel0eD3bxbBhi3p36aGc6hq+ZcXMIDWBDmy2aV2eCwjSFtesXtX6EkrAPC2b3LMmXmoZ119dWigmh3HwMaTsE/TeFLZVEV+KxIQpQ9yes42bl9euwQzsygRvgtPbKATvpC30pBQK2dIoZw7hZHXwEPRubER8yGm3V2Yk4aaDypQitzxFAdjhueN7yKbm4svq/omkybPZQo0A110yGntObfAYmsN9yuM2KZYE7Vlgg+uesYL5QBOex1PgFi5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:20.0381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d12565d-be26-4c92-8e4f-08d614c3d27f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream capable endpoints require stream id to be given
when issuing START TRANSFER. While issuing no-op trb the
stream id is not yet known, so don't issue no-op trb's on
stream capable endpoints.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 98e5f39..6936adf 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -668,7 +668,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
-- 
2.1.1

