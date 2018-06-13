Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0C4E7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D462086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ij2BXB9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D462086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeFMGgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:36:16 -0400
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:56560
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754479AbeFMGgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwM3fikNbI2PeYjB51XtHp1POmJIbOYPY+DkpS3/EJc=;
 b=ij2BXB9bx4qu7+GAXnTtboqOd1BK7/MyKOmoDntbYnYieWvgRCCqeZxTL6CMWGJnVOwCiaUpGO1IVwnetTNS3lRyLW5HF+VuWMq+lk/QHRNMLca8nLCWH9Anjrjp8criOJqtXqQ8HPCQQPGb4MA/KJrMkS0hCg4eJYm85ANwSDo=
Received: from BLUPR0201CA0034.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::44) by DM6PR02MB4346.namprd02.prod.outlook.com
 (2603:10b6:5:2a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 13 Jun
 2018 06:36:03 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BLUPR0201CA0034.outlook.office365.com
 (2a01:111:e400:52e7::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.17 via Frontend
 Transport; Wed, 13 Jun 2018 06:36:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 06:36:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56534 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNx-00053U-RR; Tue, 12 Jun 2018 23:36:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNs-0001Z5-Oj; Tue, 12 Jun 2018 23:35:56 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D6Zs06010577;
        Tue, 12 Jun 2018 23:35:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fSzNp-0001Yh-U1; Tue, 12 Jun 2018 23:35:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 169D8B20464; Wed, 13 Jun 2018 12:05:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] net: emaclite: Fix position of lp->mii_bus assignment
Date:   Wed, 13 Jun 2018 12:05:16 +0530
Message-ID: <1528871719-1681-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(486006)(76176011)(51416003)(476003)(47776003)(426003)(5660300001)(4326008)(478600001)(50466002)(50226002)(7049001)(186003)(26005)(36756003)(336012)(126002)(54906003)(81166006)(110136005)(52956003)(106002)(6266002)(305945005)(81156014)(316002)(8936002)(103686004)(42186006)(106466001)(6666003)(36386004)(90966002)(48376002)(16586007)(8676002)(2906002)(11346002)(2616005)(356003)(446003)(63266004)(2201001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4346;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT010;1:+CSm2dSafedresb4+BMzLvTRXdNhFFLCBDl3O3B3QuDHn5Tug+a05nbRmAnK4HqmFzqxzzTb/ixyuEgYN/CMsR4HHhjmX0cvIHx3f0AS+my3EzTCuiheZWAIHkoxwrgX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b4e9870-00ac-4db5-fc51-08d5d0f7eee0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM6PR02MB4346;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4346;3:vsbw0DLwRmGMuFsywPEWSIvzvQUSw7U2o2qlVVxA5V/g+tKCGL5Prudmco98ur6kvjJqc4iBQ8eUANhJrmCa2a/Ah2p77rOpEsM3/oO0ojrXJsk78vaWD3B3VqBKT51JZBbRRlLKMzEICMLZr1GnRx8ulaJZjMEnY8By4LvKBqddnNJCNHsWs+gmfjR3pjhYRTXYH7M/9xye9JVzr39ocWNE3+j3AV7OlZVV1Tuccd7zrr/dUbXjw3kcblrmCn9qPH1cHbypv2LbPn9JdlLeCYvfZ4fJQgGku6eNFnl/SvT+UCtDWWgCZQYtQ+QGHKAfDwYQnsKf7dOavo/p7VfyY5ru5kEDk3hl4bEqEuAcwZc=;25:N1HzjDDiPsCnx2i6gWPWLgtp0bd0M6kzfV5Yw5M96nQuAx9d7OOnH17f7TTVPGkr/oUsfF8fajJHxpvI0Lvbe/LM6Pa3Jsxzx6HK73TwTtiutWJFVuXiCcCXrKF4+V7gDiOEKlGLSCGSnRUd5FRvUdhsKzVClu9RJeRAweSE03Kgm10FDSpTtT+A6aUhWqtyCoGpylzspOWF5SpBYSd+k3o5McqB1+t94IS9b1vjeXq1XyDuuk0l5ZTbPpI5jeCnbk5eY8ghQlFOBVOCmHBGdZaelAFRPb5pJUqMxzze4HQIRJCrXo6j7WjF7f2Me2bITvz+AuZ30Dh+u+06zcwpIA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4346:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4346;31:mr3G2ikvKome9CWY2rL7qzG1LOb5FHKBE/z6FKtwPD5KXDC7YqNfvZHxQwgcCisUJG0qdjoQvVaCjKQbPBhWwrvvDjR9ST7dV/wH5RhwmrsuzMZJqpfh6EsigLlTLthk0A4OMpmoB0faqxERTk/Bu+uafyDKVsQlQUO2bTu4+wBv5DYeNQnc2Ag1ZQVAwGKB8ifL23RwL3zgfHqbPH3+g9gCmFd8ftYlJHjuBHWhejw=;20:E0YrojUZ8NN3lHOevgkM/FlIxWGHFVqovVyXKFVghOsRl5SPrsCzEb0tiGShqwVUnv0tmEEaoCBNQd+fIO4YwSvrR28TcGIuoEc8C6GF+VSKKgy9BrMPR4vlPJu5bADK7uOIqKvaBwQFDPK1OVNOclvPy9UssQWh/EwcBBvBqYuNW/h0nDHTwElsE6zXjbYcFzjsN/CImvbz6pAi6htYeU7xVuBPQz3ruvVX3/lRxfMKMYkGXa9MyKkyBVUAThnR2KeI81feZHnNf46rDGPsXeFLM6LmQi6me4u4kUgxnmTJ4QLygJ4TyC/5ah45S0DK+/hfQtBxsbs2K+deIzi6bRG4niuYMAs6PDgdjB9Ya9Ap9omOgCAhHXUA8W5iUGUmtgD6qgoeCWuQ/Eldla8yxCA9aph/Qn5yBl8oqTgCSrA5ts/aLpyDRtnrYjrGnO6ukmRWAk98OrlN/lcnKUSDjdkIUgeZx2cbQCh53k3dUCntMKtHqFvErv96pLd5PaTw
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4346D01CDECD89E20006AC73C77E0@DM6PR02MB4346.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4346;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4346;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4346;4:98DVNHrYpr8lz8E9bWDY+v6d/86u/GBhwPJgvkN5L+rzloVJ7EVYC44SwQx/64bV9J/C7pNSsVJgy6xAGwE7V8QheMGy5yzQprpdPo2Hywnv9/FiMpf7INL4hhTk6KUBWI3K/kNwMjfyogjgorm5B6XewRWGF7qE3t5Qjz1qw2jSKx150SSySe1eLas1s2Lu5LITz0XYPtuQeJ8KkxwTFbg0hjLVbWFFKnf1WnyY4xLbkDgXp58IWKC4/F93YW2j+XFmM5HJQaT7MjpfBnn9E7W+Y2ZFTNdDD6Moo4qfTCs14Q87s+jWiBsj2mJtK3hF
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4346;23:6R0M2FrAJUEEgT6MDyM2capykaW2Bj2LD2sTK/Vkc?=
 =?us-ascii?Q?77akxXnltsjxtngdqaOp1vx6EiVf1N6pcFkcgs7y9/6wvu4ltsXbxB7sAmQz?=
 =?us-ascii?Q?z5NG10yp6LvnQj6q5qelt3VgTnxtINutaTsyUxX/Yd6eeL67hraAc5SMNoIz?=
 =?us-ascii?Q?LLwMdgU1gm1Zs0u7eVRhxoHB3N9DE0xCpWBpXU3DTuIpwaCFkU7NGs1kpNGV?=
 =?us-ascii?Q?fx9LiwmDRROsB+8XZhKjmfgwfib7bLPo/OwLNIIYrzGAXq17/MhPmaXRcTNQ?=
 =?us-ascii?Q?IEaz7W/mpHApPb725cieKIrs1/7vMrdQXqvpYIiRRdObPYkH3VeszFFG5pyZ?=
 =?us-ascii?Q?qeZ4IddvNgjiayzGMzTydSqTa7NIsC8JljLbfai8B5wsq5vE5+7iBP+pTwj5?=
 =?us-ascii?Q?I5NL5S1oBAqdryI4g7Uk9hyMA96DOtcYBZoMNhYUqBaCq60pogZ18FWt80gs?=
 =?us-ascii?Q?/uWAQxkSJQ0TA1x6NSrfPOm4vd+u4qqjmGvy+QgtSscTbnnVjX/XkrDQ3MKh?=
 =?us-ascii?Q?PRc35/537/Sh68GrrGl0YUC6+kAJqvI/a4PHGWXlHmr2V/JxmzxteVZ3O3Hr?=
 =?us-ascii?Q?yfOhL+LOBSelrpLdcqYpNb2fa2wf4aCbH3xgHzLPGad16qEkBY1PLIqG7ZCF?=
 =?us-ascii?Q?2HWjgN7ZUzuO/viUlUjyqhSRvKboAx6A/2N+TvkSb211AbkOE9OUb/BnNVLa?=
 =?us-ascii?Q?9BVM2xgoYFj4xcTmjvYzQOPKD4HZ8S3fncugxCrrZuY+ioVv0BmnkmfRPF5B?=
 =?us-ascii?Q?bCVyjpxFv2KqJSsQydEfY8sUTBx2g4kHLDjElUQWlAFDVWZ3rfTDFl1ntKSW?=
 =?us-ascii?Q?bowS2hlKATWOmaydaTS8aFA3BdFTY32uFCwXn6Jsm+/qoHOHOyLOfWI5ZR6d?=
 =?us-ascii?Q?LX0gxGyFgdgY52NgwUjLDnxHFyQkB6SAfxd/1okD9yr2p0LrqiFI77gAizpQ?=
 =?us-ascii?Q?gNQKnRFf0/VC6NGTZW0Qagy396Clygv6b/OVcaBUZa5+ihgGXUcdZwKwN6s8?=
 =?us-ascii?Q?5dH5E9mbd51LUtIbURHdhhugnduVS7aP+Jb9mB1Y+BTeuGDeX8ooKR0geQOm?=
 =?us-ascii?Q?n0kXPOYTG4rACCnCus42yeaM2KolisdTS7kZVfU+RooE/LZQ6TDnum0h9sTx?=
 =?us-ascii?Q?hsKvflm1pbK63UKsjDYldWzovayGFP4vEkaC2cMnfgik+HAjhuDoaBZuRqWY?=
 =?us-ascii?Q?a6lAyTiYz6YiqwVLDwJK5nvhmue90ME83gt?=
X-Microsoft-Antispam-Message-Info: gFybXDeycZkIU7jioco6iw65YObmdZN03a0vHo8uLBD6Jn+etlJlLICc0P9960RJwzIjNTkas7IHmByifI2+vy8Od1wKejf307nCilWQQsOJgPjK731NEQaxqqW0Hm5643hMsIYoRt658AO937R1QBLtMBsuQVo2UXeKx4y0P/DFfjRtPrQsXF25iBApKTfx
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4346;6:khWIuH3vXxeiOACHYWDMH4rAN1eLDo77bxkyt3qMV1M0/XRzRTONCfliDubpTn8rcjbymFVHyorJ03GixPltelE09t9Xl+G5pAkBRNk3cqnRZwDK8uoUffJFqmEXYm4nu17QBMAFjLlZCGEStu3iRBAjdtWZ6oHWePeICSx9XRG7QwbeuCzrjUf+dlp1LcS85wpkSj71viVu7h647uPBtGmUEbkLUtA2CO5hM4SvZEtP2P9xdrfjMiP5PftV7RPpfnILQg1U10IvclJ1rGu9zTbF5MGF3NGQHJyE6YaScGXKth7b6Nf2p7qeE4HmpwMIEuCXvXMuOu56bqnVdl9sjD7zUY3+KiNOhG2Iyq495ffek3rFD206G9UuRPZxoWAmgYUA7tBDKTebe1F/Bo5VqpRt7ZCVHD6jGw5Mq4CfsXq/a0JzbwpBBsJZXpFeeTj4fnlhxe9eNpx21B406ad41w==;5:j3wAur6gGjoW2juczuo9HdgYtDlmCth3XsSUUYltK4MX+ZsFGWZrpF9DZFgQ7BTdWAWrEgQipKr561Dv3Tr5TxjPwtZGuQyoF9QK0RE/HMnhX2Y29vnK/hRht6erh4b260Q3bTG8GZ22YzLM4B3/uCjABlqykJ5eYgXJmDgwT4c=;24:eYmOEkw7+ySlA7t3fMzLnRN4ILC8dllT4/FQahIZXip7AO82cvRTqtfzouv9KMLfFkj46ixktOkBlGP9EtrPsh6xzHDr+/09degWxl45QU4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4346;7:XeIqdbJeZwZgixndlmMuBoSvwqgikxQC1OXxs2X5lvgGxp7rHkArpIY/H1zfw005NsNY2fMW9HqEhGt1JK1eg2cPb9nj9pxliIiQId54CX7NUIA0fU9vdHvYTWBkRKIbrLm/eNxGkJ1FZv6EHR/0Wtp5ku07ogsMrBg3y20MK5uaQbTI4JHR6aBaYXuVeImQFmFB8iK0s4eD6+IvEEic4X7tU8wHkDl9dbVZ9otWhVsViouaFY1oaIqF93HRJuMc
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:36:02.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4e9870-00ac-4db5-fc51-08d5d0f7eee0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4346
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure MDIO bus is not double freed in remove() path
assign lp->mii_bus after MDIO bus registration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 69e31ce..37989ce 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -863,14 +863,14 @@ static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
 	bus->write = xemaclite_mdio_write;
 	bus->parent = dev;
 
-	lp->mii_bus = bus;
-
 	rc = of_mdiobus_register(bus, np);
 	if (rc) {
 		dev_err(dev, "Failed to register mdio bus.\n");
 		goto err_register;
 	}
 
+	lp->mii_bus = bus;
+
 	return 0;
 
 err_register:
-- 
1.7.1

