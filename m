Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412B8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05B32199D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PKGpOxmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05B32199D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbeGCIpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:45:03 -0400
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:29776
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932702AbeGCIoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O1Y6nQtO34vN2z9zlsZk8gu1n5ULrNZRbhJ6PXhzx0=;
 b=PKGpOxmX05fSjw61j11uHfHVk+ivUpIIwNkR2YGgftiPMyWVl1lIvUY/Jp0gOT16ZvgETxDzNsHrVRB8REOEtLV+bhYEppBxMMJItTcjdLchxzdqahboFYXMlCWIX5FZ8u3p6BAQqRGgnudSRA2tEBL3AsgR58STqkadiKmia6Q=
Received: from BL0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:207:3c::28)
 by SN4PR0201MB3518.namprd02.prod.outlook.com (2603:10b6:803:44::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Tue, 3 Jul
 2018 08:44:53 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BL0PR02CA0015.outlook.office365.com
 (2603:10b6:207:3c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 08:44:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Tue, 3 Jul 2018 08:44:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54310 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faGvb-00032D-I4; Tue, 03 Jul 2018 01:44:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faGvW-00024t-Eo; Tue, 03 Jul 2018 01:44:46 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w638icWk032402;
        Tue, 3 Jul 2018 01:44:38 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faGvO-00024P-7J; Tue, 03 Jul 2018 01:44:38 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <michal.simek@xilinx.com>,
        <navam@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [RFC PATCH 2/2] fpga: zynq-fpga: Add support for readback of configuration registers
Date:   Tue, 3 Jul 2018 14:14:33 +0530
Message-ID: <1530607473-6362-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(438002)(189003)(199004)(8936002)(8676002)(81156014)(81166006)(305945005)(106466001)(6666003)(63266004)(36386004)(356003)(36756003)(476003)(2616005)(126002)(77096007)(186003)(26005)(14444005)(47776003)(426003)(336012)(486006)(2201001)(2906002)(9786002)(478600001)(50226002)(16586007)(54906003)(110136005)(316002)(7696005)(51416003)(6636002)(50466002)(4326008)(107886003)(5660300001)(106002)(48376002)(107986001)(5001870100001)(217873001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3518;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT020;1:QemeH/n+TuzbmaDgiOd6MlcBoexLomcXiCsR3ute0KcSBKxbI9LUsRUUNt6jSgHoGUm65Kh1UTE3BGBY4xXFFEZSeMNn+zVugjLgdI3rBCzRzCg++qYyBo3i0FGf4Esf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c783af3-70a9-4c0f-6fbd-08d5e0c13e64
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;3:HBBEXxlDqb1fFBh0k1qZHTm66CuT9gC1YavYw47axQLIfPv1D4HN49w0Bx3itYjnGdwtZ9aQi7Ba1WpbaKYhzv/AjHBarz7cx0rqRd+QbQd1J4RyaaQ/2VxcQJF5DzNnhHGkgTndmRXUmP4ZKu/vi+Iqi29S+fvYeZmpg1/KMW4b0LUq7z1UmSUpxb/ubx8vPZcuD6V0D1kdKzOxdzQ9AUctLyugitx7qAtgLQzHTnjWb4UuMEU9NvgKoRkNTK5iQSCIXWps1sFLhPLTNCjEWvkv2bdfLICFiVlrtH9uwFmo6Z7M9MKJHfUwb0amafh2lRUnKEyJwoBmvDSJerDOitsLLWJBRk73viuMqUETMEE=;25:uxXX1wa6TMrdyONJpsnNNFzkhFggWBZjbTB2HeJbWxAEsd3LfVzIL8lzO614SE83VbvwsRvw6pOSEwW1Sp4gvk6ZewlvvEPy4nwZexeDzfHSejjx8hH2+1nG9op7Qtpud/ApLuxCwIw4A9mO66z2whcdl3DPMl7UKDjrM+MUmRjEkdRhK2+JjwTRB4kseRUD7g/w8CJYaatsjRLZOt/4qAkRHY1nqps8VprEajZqum1yYolFMJLKRpzvBgjjB3AIejdAwZU3PPIsQzvyFl9pmtuz3Ws4+pJhsMFmuvcS4XzQyCy7aOrblgGyW7UQ9snekh8IM5QoYkm2E6cqYjk5IQ==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3518:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;31:ZKHU8fKI7Ok5IWn/pqzxziIa6L749yUpbC8PSlKb1z84e4zGyjcoXefwLr00G+egVvMyhUqflr6cL/u5XoiRRuAZ2KRLSOwjGb7ZOd9696Tizk9LbkJGuXCOI1N16Jwp5ladQ9CjqN2jpD9r2N8m54+rgViiMY3URB6a+zwzQNkfsIq7A+N7WL8oGARIpmBMQcmLbnNPKFqUgr8YWdGYnb+UWlF1Jzw1u6JACyOFFUE=;20:zOfAk66vBMloA18heTOBWUS9LbpwEC5RstzbjXqDHpl8VYKFl3PAeLVdjJsL+Pf5Ck/TXBNmoFTPf10EBoKXVR0J2UL+et6pIveQPEe9HeXJ3JZ63ktBLWy6Jz45ku8XCCg4U15RX2Q4NnqDBHMPy8zJBskoQrGbtYUg5l5TrK/KrDsNbCyEy7ZTJrSvS8z2Td1hX/6QXzQuebGPT+29OtrKTB37NAJL/gjdAH+c2J6YndesxTagtk8MIgXnNsVfVW7Oa5ucYA4mVZh0+9+izT4gn1sQxBJAxqd6PJEKJiS3sPakH8/zIWSaOsgM/MY5tv3FRI/eqgooLa+0kg0lc31FyIqWI5+i8o0mGm6iJbzvWhmA9Uoldop66gg2ifz2nALPXNGN2EabETst7X92C07Pbv6qzXXJhoIbWI5IRwf8Jfj5llErrPEt6kiSYVZbvHs3x68D9y0C5i+3GQPHL6spZASghq2o+lZHnWY91g39zFKZyctBuc/Z7l7nY/5C
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35183A052072E88C2DDE61B1DC420@SN4PR0201MB3518.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN4PR0201MB3518;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;4:vu5iA8lKIkS9c2BVV5JYoaf5XHwra4GIL4phmp2OJuzEchYIWYANBI5nYN6yH5QlTdkqcwZqNNC7167/VXC2zPy2IAPH4TPvaGS+///z8TJLnL80WvrxQ/RKZbYQOfmnpf9pmyP3zX1kfse08cePN+cBDMlmqi1wXKRdCmBI9ZzPGg8fQ3F57kw4MkfoTAUOP3Fmq5ZEdwtngyGVWbvY3XAOcxHfI0y/vQ+lMhaJkOyvPA/pN8khtEpZ2JGVVatubUpkow9+l884/6zi7tx1GbbgTWsoQAdPZjf/jpxJGA/EiowX1MfkfssNu1I9KSE3
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3518;23:1+yqBDpxinLR9MqjMLwPTvhxDUNw/ZBhvku4x4P?=
 =?us-ascii?Q?DlbKkIYQUQMuw4u3BFGeUMgCA4oEWbUaxg/SLiQofJZRM6ifDbHp0ANu78vI?=
 =?us-ascii?Q?AuR3JE0UE1uAbzkJP6hdK0KsIvCtIKdjraWvsGjdNCZBsA7mgGm4LPgSxeKr?=
 =?us-ascii?Q?R2MqI8ocH0llNxhyJ5MseXTGsfo99AZAbg9+neJUKPQ55GVHwDdqXtNF2eBR?=
 =?us-ascii?Q?c1eOv2Kuz7uX5WVV0qgFuSrtpCUZu+aOxsWEcy0ZhXGmESF+OKkn5bg55GHY?=
 =?us-ascii?Q?x5XcZ/zQWovJr06D2cBXVwnihxDMZOzVU+ZaeJ2+tyap7KMpILFgLcAovHgB?=
 =?us-ascii?Q?uN3fmeVXDHxBLxlHbEGtXVxldSjBK/6jQgBK3sGzGNlDEWEBORv2XY2xhKq6?=
 =?us-ascii?Q?NSrlfOv40XvZvBORWKNRac0N/OZTYM+1/scAAWXh/6EqFc6ubrgK0RGrBfZz?=
 =?us-ascii?Q?5GwE0Tyqr9jYDyHbZeGX1pcCJqQgFdPJz5rxkoJ1zWDWp5KVDc3utIM0ZczS?=
 =?us-ascii?Q?Xrn1uY2kFsmSiObY1UaNv5UNGoQ9On9CAST2emCaROGVAEmUk9k/ZfJSb4yz?=
 =?us-ascii?Q?RUNvHvoMe4xpjEpFcVAvoFzfbfhVt/2kmzLcwKI0QmAjO2zsbNLLsq3vNxBH?=
 =?us-ascii?Q?OlhElqLLcR97pLQu7QBkTEUmxnoFDg7qvXZ92QnFJQvWzepSqwvdavZjSb84?=
 =?us-ascii?Q?0caEDkPE3jL3gxju3lTlXbk0ihXR/Mr42H9DPDE8kdekckOmEMNHCL8Q6wEp?=
 =?us-ascii?Q?WfxbDr97NJh+3DLEo4TIxdQl0GZZdcQHNMwXAZORAAiDS5To/yRD/C2gXhuY?=
 =?us-ascii?Q?gjm02ncaylKExpBID50yCMNJImeS4J1GbYpDorfbVxhpiZrzBHz4HoQo8/+n?=
 =?us-ascii?Q?zGZfVervCnp/MLaRxsYc8acd8bpEI0mjejSkwAD7m7EC2KgSN7pO+Ft7jVid?=
 =?us-ascii?Q?DmvTpv5XTjlcOmtu6KYgj/his/vXyJJZ/5YRX59HnUlbkqdhPcctULbUmYGq?=
 =?us-ascii?Q?obbQMjMkYniwvJXdSYjo0DT93HK0ssUxSPrxWy5rOFXJX8ahk3fEzWeXDI1a?=
 =?us-ascii?Q?HjiFV2uCh+0GGmV+RuZ+HXrJ3n40A/hcHgH5T1ZTkro+u9IqvJMhMaOIl+1B?=
 =?us-ascii?Q?SeK0xmq3ABZdsyd0bK4cX0NOqHbeCb3uq6TpPUqAUhXdwUPQOHjeMqz6FkiQ?=
 =?us-ascii?Q?oIo973xOq8D0NOUM=3D?=
X-Microsoft-Antispam-Message-Info: M3m3WkE12hLLPIjkeB0oY4eh0Hroz24qgN6RVS49bcov3wo4aPrU4lu1wWo4VXEMbNO2LJlDfNg3vQfmP9eHjitghBkPRAx23t/6DI9z8Dq/QOBdMIc3kMb4vl+plHW9sL4BBvf3nn7itSef0/V7KdpUYJDpsv5XQLf8a3GWt8LmSrA+zK72Sd6qoc7WuDTlyvcrWLlCOGjBTugnAZM0ce+PXQginzNofRtJZzf6ROJCt/haYWLn4aN2EqD9ar5gDxFxQfRBmxk/nEn6YSTnAtg/YGeutn06L1nwPi3bct4p/8ZxXVB0MjMQAS59P4MkXj12uT+nv+RtLQA5pzSHGVg4B8s4S+s0mjuUpE+07So=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;6:dj3D5TVuf9sW6af+fekuW2RrAmxs89KrzUWdsOSayjoGSlTjD5Km/wDEr+lEszeyeECGmUclAD5yUaNTAHnC5JPwtWYS1Ogg/+fUvK0d9IERxBGAd184TBgYgOey1wiwoEOQvYkGChfn7oWkwG1czrPPIBebrVVqO3/FcSohRlvFwq0CEwU5RMsJ/g1mdeV6s5XwgmP2gKRB7OuzMCHAmCSQNm7xcF0bXLpFy5ZTmh0H7NSDMAD3g//EomBN2f5kOajSr9iMmbsD9DSEH30gRTGEnLtE5+dNZjHMtN0dDGe9Pu1un7YrdjJuH9wMwSlknI6GlJLmlysTJfpC04jJUTPKIfbfRaJXzAwJgBNJzCW7Rie4Wevp1sjQqlWYhU9pxqWZkktH2/CLBFd2qUMmQRSeyKg7dX6Zg1BUWiW5LBxXnvYnneThk6UeYrE0MS1xEyPa40INTAFVT5SHB7CAFg==;5:iIY2D9BEM/Su754vaAhhvvyqAWhzb13J64OQyCRrnYzh9NesHSsf46xRHaRqeGkTXFa/CIg8AJLWcyPeCzS+yT1QO0iWl3hWZFDebGW7FQHmUE2FfSr2fReBcdR9Jx5AasLBU9H/ctEjT+aM855jp9OW5223LhorPbGLov+rC3o=;24:tVGD01sgvtNwW7VFYEJ+bCyCP8KGH/przoIwFnpkAkekIBojYALGW0EipvqYoHjsooi02vBpDaU/aZwT0/bDOqrEM2EXqgkNeIzNoL3i5Ec=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;7:M4IL/JZMF6ead0QUDTDVseZM1BAJ419VV3hkrFmtPvhjMYcgKP/bsgCXXiQ3tublZOpHeN72mjxf++bJWOZ+/mE53i/4CnuHdGvO/osgaD+heK9m1pax5e7B6tKOLHZVZaMF617H73cLxaaQJgSdBb25WUFamv5cn3P5fwGP/tmSY4kDIctZ89UWdLdDa/+ISq3iDpadZ7me9J9G/cK8GDCxsOM+UiUCAWrL9U/9anHdGZIOhvTEheArWlxUhyGd
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 08:44:51.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c783af3-70a9-4c0f-6fbd-08d5e0c13e64
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Read-back of
configuration registers in zynq.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/fpga/zynq-fpga.c | 254 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 70b15b3..31d39f0 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -25,6 +25,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/pm.h>
@@ -127,6 +128,49 @@
 /* Disable global resets */
 #define FPGA_RST_NONE_MASK		0x0
 
+/* Configuration Registers */
+#define TYPE1_CRC_OFFSET	0x0
+#define TYPE1_FAR_OFFSET	0x1
+#define TYPE1_FDRI_OFFSET	0x2
+#define TYPE1_FDRO_OFFSET	0x3
+#define TYPE1_CMD_OFFSET	0x4
+#define TYPE1_CTRL0_OFFSET	0x5
+#define TYPE1_MASK_OFFSET	0x6
+#define TYPE1_STAT_OFFSET	0x7
+#define TYPE1_LOUT_OFFSET	0x8
+#define TYPE1_COR0_OFFSET	0x9
+#define TYPE1_MFWR_OFFSET	0xa
+#define TYPE1_CBC_OFFSET	0xb
+#define TYPE1_IDCODE_OFFSET	0xc
+#define TYPE1_AXSS_OFFSET	0xd
+#define TYPE1_COR1_OFFSET	0xe
+#define TYPE1_WBSTR_OFFSET	0x10
+#define TYPE1_TIMER_OFFSET	0x11
+#define TYPE1_BOOTSTS_OFFSET	0x16
+#define TYPE1_CTRL1_OFFSET	0x18
+#define TYPE1_BSPI_OFFSET	0x1f
+
+/* Masks for Configuration registers */
+#define RCFG_CMD_MASK		0x00000004
+#define START_CMD_MASK		0x00000005
+#define RCRC_CMD_MASK		0x00000007
+#define SHUTDOWN_CMD_MASK	0x0000000B
+#define DESYNC_WORD_MASK	0x0000000D
+#define BUSWIDTH_SYNCWORD_MASK	0x000000BB
+#define NOOP_WORD_MASK		0x20000000
+#define BUSWIDTH_DETECT_MASK	0x11220044
+#define SYNC_WORD_MASK		0xAA995566
+#define DUMMY_WORD_MASK		0xFFFFFFFF
+
+#define TYPE1_HDR_SHIFT		29
+#define TYPE1_REG_SHIFT		13
+#define TYPE1_OP_SHIFT		27
+#define TYPE1_OPCODE_NOOP	0
+#define TYPE1_OPCODE_READ	1
+#define TYPE1_OPCODE_WRITE	2
+
+#define CFGREG_SRCDMA_SIZE	0x40
+
 struct zynq_fpga_priv {
 	int irq;
 	struct clk *clk;
@@ -140,6 +184,7 @@ struct zynq_fpga_priv {
 	struct scatterlist *cur_sg;
 
 	struct completion dma_done;
+	struct mutex mutex_lock;
 };
 
 static inline void zynq_fpga_write(struct zynq_fpga_priv *priv, u32 offset,
@@ -164,6 +209,15 @@ static inline void zynq_fpga_set_irq(struct zynq_fpga_priv *priv, u32 enable)
 	zynq_fpga_write(priv, INT_MASK_OFFSET, ~enable);
 }
 
+static void zynq_fpga_dma_xfer(struct zynq_fpga_priv *priv, u32 srcaddr,
+			       u32 srclen, u32 dstaddr, u32 dstlen)
+{
+	zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, srcaddr);
+	zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, dstaddr);
+	zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, srclen);
+	zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, dstlen);
+}
+
 /* Must be called with dma_lock held */
 static void zynq_step_dma(struct zynq_fpga_priv *priv)
 {
@@ -546,12 +600,211 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static int zynq_type1_pkt(u8 reg, u8 opcode, u16 size)
+{
+	/*
+	 * Type 1 Packet Header Format
+	 * The header section is always a 32-bit word.
+	 *
+	 * HeaderType | Opcode | Register Address | Reserved | Word Count
+	 * [31:29]      [28:27]         [26:13]      [12:11]     [10:0]
+	 * --------------------------------------------------------------
+	 *   001          xx      RRRRRRRRRxxxxx        RR      xxxxxxxxxxx
+	 *
+	 * @R: means the bit is not used and reserved for future use.
+	 * The reserved bits should be written as 0s.
+	 *
+	 * Generating the Type 1 packet header which involves sifting of Type1
+	 * Header Mask, Register value and the OpCode which is 01 in this case
+	 * as only read operation is to be carried out and then performing OR
+	 * operation with the Word Length.
+	 */
+	return (((1 << TYPE1_HDR_SHIFT) |
+		(reg << TYPE1_REG_SHIFT) |
+		(opcode << TYPE1_OP_SHIFT)) | size);
+
+}
+
+static int zynq_fpga_getconfigreg(struct fpga_manager *mgr, u8 reg)
+{
+	struct zynq_fpga_priv *priv;
+	int ret = 0, cmdindex, src_offset;
+	int *srcbuf, *dstbuf;
+	dma_addr_t src_dma_addr, dst_dma_addr;
+	u32 status, intr_status;
+
+	priv = mgr->priv;
+
+	srcbuf = dma_alloc_coherent(mgr->dev.parent, CFGREG_SRCDMA_SIZE,
+				    &src_dma_addr, GFP_KERNEL);
+	if (!srcbuf)
+		return -ENOMEM;
+
+	dstbuf = dma_alloc_coherent(mgr->dev.parent, sizeof(dstbuf),
+				    &dst_dma_addr, GFP_KERNEL);
+	if (!dstbuf)
+		goto free_srcbuf;
+
+	cmdindex = 0;
+	srcbuf[cmdindex++] = DUMMY_WORD_MASK;
+	srcbuf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	srcbuf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	srcbuf[cmdindex++] = DUMMY_WORD_MASK;
+	srcbuf[cmdindex++] = SYNC_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = zynq_type1_pkt(reg, TYPE1_OPCODE_READ, 1);
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto free_dstbuf;
+	}
+
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+
+	zynq_fpga_dma_xfer(priv, src_dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+	zynq_fpga_set_irq(priv, intr_status);
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0, dst_dma_addr, 1);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_DMA_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for DMA DONE\n");
+		goto free_dstbuf;
+	}
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+	src_offset = cmdindex * 4;
+	cmdindex = 0;
+	srcbuf[cmdindex++] = zynq_type1_pkt(TYPE1_CMD_OFFSET,
+					    TYPE1_OPCODE_WRITE, 1);
+	srcbuf[cmdindex++] = DESYNC_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	zynq_fpga_dma_xfer(priv, src_dma_addr + src_offset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_DMA_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for DMA DONE\n");
+		goto free_dstbuf;
+	}
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+
+	ret = *dstbuf;
+
+free_dstbuf:
+	dma_free_coherent(mgr->dev.parent, sizeof(dstbuf), dstbuf,
+			  dst_dma_addr);
+free_srcbuf:
+	dma_free_coherent(mgr->dev.parent, CFGREG_SRCDMA_SIZE, srcbuf,
+			  src_dma_addr);
+
+	return ret;
+}
+
+static int zynq_fpga_ops_read(struct fpga_manager *mgr, struct seq_file *s)
+{
+	struct zynq_fpga_priv *priv;
+	int err;
+
+	priv = mgr->priv;
+
+	if (!mutex_trylock(&priv->mutex_lock))
+		return -EBUSY;
+
+	err = clk_enable(priv->clk);
+	if (err)
+		goto err_unlock;
+
+	seq_puts(s, "zynq FPGA Configuration register contents are\n");
+	seq_printf(s, "CRC --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CRC_OFFSET)));
+	seq_printf(s, "FAR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FAR_OFFSET)));
+	seq_printf(s, "FDRI --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FDRI_OFFSET)));
+	seq_printf(s, "FDRO --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FDRO_OFFSET)));
+	seq_printf(s, "CMD --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CMD_OFFSET)));
+	seq_printf(s, "CTRL0 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CTRL0_OFFSET)));
+	seq_printf(s, "MASK --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_MASK_OFFSET)));
+	seq_printf(s, "STAT --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_STAT_OFFSET)));
+	seq_printf(s, "LOUT --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_LOUT_OFFSET)));
+	seq_printf(s, "COR0 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_COR0_OFFSET)));
+	seq_printf(s, "MFWR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_MFWR_OFFSET)));
+	seq_printf(s, "CBC --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CBC_OFFSET)));
+	seq_printf(s, "IDCODE --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_IDCODE_OFFSET)));
+	seq_printf(s, "AXSS --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_AXSS_OFFSET)));
+	seq_printf(s, "COR1 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_COR1_OFFSET)));
+	seq_printf(s, "WBSTR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_WBSTR_OFFSET)));
+	seq_printf(s, "TIMER --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_TIMER_OFFSET)));
+	seq_printf(s, "BOOTSTS --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_BOOTSTS_OFFSET)));
+	seq_printf(s, "CTRL1 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CTRL1_OFFSET)));
+	seq_printf(s, "BSPI --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_BSPI_OFFSET)));
+
+	clk_disable(priv->clk);
+
+err_unlock:
+	mutex_unlock(&priv->mutex_lock);
+
+	return 0;
+}
+
 static const struct fpga_manager_ops zynq_fpga_ops = {
 	.initial_header_size = 128,
 	.state = zynq_fpga_ops_state,
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
+	.read = zynq_fpga_ops_read,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
@@ -565,6 +818,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 	spin_lock_init(&priv->dma_lock);
+	mutex_init(&priv->mutex_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(dev, res);
-- 
2.7.4

