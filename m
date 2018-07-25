Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ACBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603B320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l9tXBkFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603B320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeGYNDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:23 -0400
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com ([104.47.33.41]:51362
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728899AbeGYNDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kseCC0xZ7YIlqIpcH8Rvl4Lh6yI3ITlFDbRTl7l6tVo=;
 b=l9tXBkFNvYs13dv0Nyxa8k/Vh8rTxR5YAC4IIIlyo2R/YikOCc5Av4+l4TPmVg2LIS4hy+qquWB0evldidwIjsRlycf0lG0e5vZf3sdNCAE4l+RTn7CklqxymQqin9BvK/kB4EU9bS6xGMzaxdVrxhE0JGlvC+D1N32h4W0DsMY=
Received: from MWHPR02CA0017.namprd02.prod.outlook.com (2603:10b6:300:4b::27)
 by BY2PR02MB1622.namprd02.prod.outlook.com (2a01:111:e400:5267::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Wed, 25 Jul
 2018 11:51:56 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by MWHPR02CA0017.outlook.office365.com
 (2603:10b6:300:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKh-0007iO-Hu; Wed, 25 Jul 2018 04:51:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKc-0006dG-Dk; Wed, 25 Jul 2018 04:51:50 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpemF027054;
        Wed, 25 Jul 2018 04:51:40 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKS-0006ZM-3a; Wed, 25 Jul 2018 04:51:40 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 40DDF60505; Wed, 25 Jul 2018 17:21:39 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 4/8] usb: dwc3: implement stream transfer timeout
Date:   Wed, 25 Jul 2018 17:21:27 +0530
Message-ID: <1532519491-19502-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(126002)(63266004)(81166006)(54906003)(107886003)(39060400002)(356003)(47776003)(6266002)(110136005)(8676002)(478600001)(42186006)(36386004)(81156014)(50226002)(14444005)(51416003)(575784001)(476003)(16586007)(8936002)(2616005)(426003)(5660300001)(106002)(6666003)(11346002)(26005)(2906002)(316002)(486006)(106466001)(48376002)(186003)(50466002)(336012)(446003)(90966002)(305945005)(4326008)(76176011)(52956003)(36756003)(103686004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1622;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT018;1:Re1SgtBp+6mdKBj0ILiWRILravb36v9UB11nRq3D4rMgvBnAz5zZLilZA6koSnGMdvAAMFTgH25I5Lhpuj1Jz24tDnQLyXacTOLNoa23d5pbC4zB9dR7g1FjIhI1HoVx
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8386d945-5310-45e9-5f36-08d5f225059c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB1622;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;3:cNQv5duNKLCw165FMCPhRJ/qvrh8IbZ+ZrXJKkfKpoDMlPBvzvsriGFIZs6P86Aynf7E34K5eCZhwpjilds/pO99QWPlKsDk0z/MfdDdX9NYn/sSg0EJfTXDEAx99y6l7DmQ0OcVVEvyIYhwPY8/PCdU5o4wsKmpE8CGcBfIeHfvdKHP8+5myFU0Y3bjoBX+A3t0F1ynE33oyUsCA0qydaUmVby1g/ptrfufKG7WIfurSc7410CipdBpTN9ZloxaC9l4QSqpRh/8fherSqj9HIk+ccxMIJf3TG8HkxugPyGbku6Wws7w5RSxxeFARmzL8fWALx3xUz5PNQ1RI4WGApoOrGdH8+ub8OO0JXB8p1I=;25:LSlJW5wOahDRoCQWggvU/Xs1vDAZZ1/T0PMTS2VcEHcjA1wN5W2nhqJlea+nXCqWLIITQS6W2hUTQMYs8KqixCSgpqJw3DDVfDg8zczrtYwLwNiai+td9N4wYZ9fjIK++dVhW5e59oVoRKwVP1WP3tg7qk19SmOpWdYyoRSIHFFNGrmVzCBblQaTz5LqWgAOyXplVSejcKREvhzMWS7Y3di9HdnEhxEOq52hMM74BnwAa1VNvL8ztz2v0FPPVgwsjF6LopqeHsl4MqZ3Fjp9F2V20T6zVsnsZIW/EvC/NA4uDypUXXtFrRzmhNRDB3GFLnco6jaQ1YcKWYMA3U8fwQ==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1622:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;31:hm+a3l02oi1yZiolRVjcyN8/dzV9uyHykX9QIR/ASBWXOKsukmYGwGlV+lrKzkNSFo6NbUEvvw9WOsAgYscOQ2ohmrGplSqA93iVWJhlWCdiyoZXkSbZK/QexHLjeT9/A/0eoW4dDNULRpLalmZ5xmN8MkFSR7Uzu+DC2Oia5WkkiSrQRLMMMkgMI2BYBFWGaxOfzTgAJfOhn2N6BVdncAuQpCwyaN5aWzrD8mQWLPE=;20:5+nb7E/WYNQ5N49BP+6dJUC5a50bVIbcGiYN9Pi+suju9lu9cII/gNpgpE1wHoYugWqLgoO6Mpn9DPiJrtNJyWHCH9604HNOGz+EKaUpvpXKzNrrUZXE3umGsgJyFrPiKB6zyQGj7lUvtjO/fppjMWgayW72+zmdXzDs38TnC4RTh7ujEvDa2jzr9JZ0kefeB8ghBPexpmE8xj8Ctd7eTy7I2JhPqRErgJQ23wn36TUt9SAT68TAFBqhgfjNMJK2azZ0ziwGDhioL/FGxj7OGKLsWVvtnfPDCs8QA8UqQ87IoGZ2fP8+Z/LZuwdEr1ONyP/Cj/GQ0EIy6KOPdd8XKZzO/RdTgQSIkn3XAMRP2RrRumnvv8suJvxMDICz5GAOpW+GTZaGsU4yWGN/OAERb+viwlLMr02stiuDT8aiNpp4RqxqSUbMbqf7Uli17bZWudVyyCXUS5RvNoUV8t8O/24w8MOtj+JCPcU6JmIep+dvtF3yQyu04pmJKUt7fxQS
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB16223055C9DFDEF57B8C3AFAA7540@BY2PR02MB1622.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1622;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1622;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;4:EGG41dolYvOBmLBBYmmZr+hu7+VNdc8IepQZ78n91kQKx3ttvyuX0SMFaYap8LkxZ1wF12aZZAr7VXRzgBTu6jwt5n0jGG4S9G5GQnHs2EzUJoKsMbJ6pyNqdXxDsPY3+eD+EixwPrzmLh8PhmUfUtRnTmDVgOMm5IOLwj4Lp/FCn+bKAHGRM+Ev3No6792Lx0HWG+fL4IGlLrCGtHBdkeykWLssU1S3zct/+FA/3vQB9hyS08RUGP6UOvfLrz/Xni7yaFrq/PsuBifkQzdbBennVRBNOJfvVWhSg1allPnB+ouokqoMel7MlTD5I8VG
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1622;23:mlg2T+quKLR4F86zzEla0/tNjjCWS1CDgHGf0xHyV?=
 =?us-ascii?Q?hUaqyVyws3oQgnZaqbydjPvfwMSyoRRS6x5DWkT6wWmD16IEBVA9wNjX+a4N?=
 =?us-ascii?Q?YcRfn2eVHksC0NgNjiPjCYqpoiC4029xq+vAkI0JgGzFi3UKuCb7Nwr/oRJx?=
 =?us-ascii?Q?kPZfcbao0vhpSblajP+ObYU62TejMIunjq7se2xOvAD9R09hp2hS3U7oiFTB?=
 =?us-ascii?Q?bPXxEAsZPwm1X3x1UjoaxoWJ7zKw5RxI5jG1yrjVLGaBPlvdTZwHwk7G3WCZ?=
 =?us-ascii?Q?qumrBgjCo0h7xJ85zraZAm2cPX9NK/flY44SQfs3C0HBEUJo24xJgCkFgyqN?=
 =?us-ascii?Q?d1ONWdKbmkOQXpQhqGEADzqXoCYAvv2iNLweZyaQqrKu3OR252xMRHUgpMm1?=
 =?us-ascii?Q?KQu3Zu2RXXpgcNKra+En5BCxeUG7Vd6q2pGpggkkorRE3ZFbPX2lbYC/9q5G?=
 =?us-ascii?Q?BrPf/F97p5ooyY/3G+6F/7b5xtpugiZ81KVSopdetn8URUpWptCVfNVJOVY3?=
 =?us-ascii?Q?3C2OeDW0qUOwqr4rvzU+ufLNRHvLzyMll2L1PBzk1QHMR0LvsmODrjjAebzS?=
 =?us-ascii?Q?9MN2xeC+AhelSR1TwEsQcHrk/bAZkvkVKca3iod1+pbJRHFNwd85sEy/LAHJ?=
 =?us-ascii?Q?Bqqe+sFqGVLPB3Px9Zp+5NqkZEHrEC76vdGIgbIyF9A50MfLpNaAnQkpnjF9?=
 =?us-ascii?Q?wL0PipBZ+/VEYeyYNGHBOcWZXKp4GyeAbg+uaDQqx75tpTY4uE893F3kwEum?=
 =?us-ascii?Q?LeUEi4OylYR7uJJ7sRDkB54y8oiIW10KO56CKMBCSsfLe919THLwns+Q6AKU?=
 =?us-ascii?Q?nYWzdY1LDVzVXiqwcDdgVhHbJe5BS5J1u/l/WhObQQ2gGdHMi6+8oA8N9jRM?=
 =?us-ascii?Q?uSTY+KuYHaEcYoJPgYZXXvySfUL+I9Uyty7Oh8VtoLKf/pp9ThSIjRotcezI?=
 =?us-ascii?Q?mRJKfb+5H83OmMxOWVfPlSYJkCirOTsMC1WxDyJ6W7an6/VAKXyJYRTvC13n?=
 =?us-ascii?Q?yDC9AMuwoH5XTy8Ql3vyeJAQz/zWQrywDRUfdvNkcMgMttdSprIIH5jSQQou?=
 =?us-ascii?Q?UxWjSSxxatRt1goE2x4QaqG6Y8MkHn2oqUxHXCK0kd3N4S4HklMDVDDl/KdM?=
 =?us-ascii?Q?qmxxBpEvXaTpk/fMgQEJsHlohFwNwZt1716JpeVytJ+kW/Z0x2bykSVDq/q8?=
 =?us-ascii?Q?o/YnCidGW41HSs1mHodxoTRZAQ9/wjbNzwJZkChINWcb9eDjkOmlXxZ9g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: kWdRiyijboObt5rbZsZhO4jyoQJT8mnRUuHO6xCYeJtIAN9JYyAg18o6RUKiEL/HdSltcY7tR4IUabT4aoCdMcoagDn1ouy6KHhhFGw6XB3TMG33tsP69FLseL3TNcsbKeAhj+qM+iLXgtiBPVWFHWkZP82CfMAbFUY5Mo3TyyXLnZCOwVrkuXxh0mkoCJmBgFK1ORxv/equ/TIn4iZMUHMh4tdmIaOwVbKFR1FqREaxaeE/6UHIPsSov4iJ6H5NjCeYCRIHoCS5W70T+G03Ng/VM+sUbNl7AaK6ukPyMIKRGcj/Yw5A+f0dL05hS+4n7Feci4DUSfWWh/JQYtUWwFuamwjnQZoRzqWYDcnme8w=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;6:byBFS0yUs34LqpSHdbstGqU+KVu13LgqpUKWZTEWa0i2xCA1dzILfRNR1K4w3qZQr9x1q9wcy6lXh+OcEeuQ8wj6bpaDw9+fdVc+MsmG524YA7j28cL03yENvwSiofb6INSV+wuXp8tTiNMyxuwc3MVY9u4KjF7R7l7xDj8CpOjtZe9YQjVyuLilFnXcTGzx0YGwqAXla86SXzAQzmSw+ZNhIZhtdM7RkdXqUPqm9lbn87W86BB4MO7ST8Z3B6K9b12zdHODp9716UKMROuKJKCCX2dMergiI/SoRcLzZbC536Ko/eHww9gV1SNbHS53YGvDwPiSl0XGiF1ILOLlz6ZWGV7nXlPHq7PbOFJTVrNcO98z8SfvdtOA6nqf7Fm2LD8OiZk1Jo/UnsQB3442baSZZsY3a44+kjWLRNRamycxNy4NfxSdCt9mfagC9REOif2rlAXMbmCyRbwO94pH4g==;5:DushbzTnNTgd0KZ2LbO+w3panOlR7irmtNn/temMXWR66u/EI6Wl9cHtjRS/8M8okfRNJEanGivNAIxPx4Csz4SGkVUpe3/9pK7r21e4qOLz6mg/lpQ9o0JekjwG68ShBVngvbxkdSSDhBo13VLJ0jZ6gIkrdQ9NeFyoI7PC/h8=;7:/B6sDvzzG1fDo4sg2wgX14QIy8sOuC2SCnzSAj/RbJecBNf/q2FSEkmKQ7nUO2cS1Hy38SaghHuIYTLQtccwBo1BgIOhqAkAiE8kMO7VyI2p6+nFuswVvyMD+DkXQ9iM1ygUoap79c+oNSHp10eNZLqsyXF/zWRTZofvuZnL/Bbk1L2B1M3htt+VmznXh/MyQoQjUNowpGoZZ8u9XmhGAcaFUzOtO0cRSaX2k7RQMf8KSaxVENkHAdqOsnWMTmsU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:55.9638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8386d945-5310-45e9-5f36-08d5f225059c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to dwc3 databook when streams are used, it may be possible
for the host and device become out of sync, where device may wait for
host to issue prime transcation and host may wait for device to issue
erdy. To avoid such deadlock, timeout needs to be implemented. After
timeout occurs, device will first stop transfer and restart the transfer
again. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0e..581f619 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -619,6 +619,11 @@ struct dwc3_event_buffer {
 
 #define DWC3_TRB_NUM		256
 
+/*
+ * Timeout value in msecs used by stream_timeout_timer when streams are enabled
+ */
+#define STREAM_TIMEOUT		50
+
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
@@ -642,6 +647,7 @@ struct dwc3_event_buffer {
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
+ * @stream_timeout_timer: timer used to aviod deadlock when streams are used
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
@@ -691,6 +697,7 @@ struct dwc3_ep {
 
 	unsigned		direction:1;
 	unsigned		stream_capable:1;
+	struct timer_list	stream_timeout_timer;
 };
 
 enum dwc3_phy {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b3e9e7f..e2ccb55 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -254,6 +254,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 }
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+static void stream_timeout_function(struct timer_list *arg);
 
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
@@ -574,6 +575,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 			| DWC3_DEPCFG_STREAM_EVENT_EN
 			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
+		timer_setup(&dep->stream_timeout_timer,
+			    stream_timeout_function, 0);
 	}
 
 	if (!usb_endpoint_xfer_control(desc))
@@ -730,6 +733,9 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	trace_dwc3_gadget_ep_disable(dep);
 
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -1257,6 +1263,12 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		return ret;
 	}
 
+	if (starting && dep->stream_capable) {
+		dep->stream_timeout_timer.expires = jiffies +
+					msecs_to_jiffies(STREAM_TIMEOUT);
+		add_timer(&dep->stream_timeout_timer);
+	}
+
 	return 0;
 }
 
@@ -2403,6 +2415,13 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 			stop = true;
 	}
 
+	/*
+	 * Delete the timer that was started in __dwc3_gadget_kick_transfer()
+	 * for stream capable endpoints.
+	 */
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (stop) {
@@ -2486,6 +2505,14 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
+		switch (event->status) {
+		case DEPEVT_STREAMEVT_FOUND:
+			del_timer(&dep->stream_timeout_timer);
+			break;
+		case DEPEVT_STREAMEVT_NOTFOUND:
+		default:
+			dev_err(dwc->dev, "unable to find suitable stream");
+		}
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
@@ -2587,6 +2614,18 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
 	}
 }
 
+static void stream_timeout_function(struct timer_list *arg)
+{
+	struct dwc3_ep *dep = from_timer(dep, arg, stream_timeout_timer);
+	struct dwc3		*dwc = dep->dwc;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_stop_active_transfer(dep, true);
+	__dwc3_gadget_kick_transfer(dep);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 {
 	u32 epnum;
-- 
2.1.1

