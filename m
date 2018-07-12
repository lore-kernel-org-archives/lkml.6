Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE85B20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CQBztUoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE85B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeGLF4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:09 -0400
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:24333
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbeGLF4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsCpIXAQjUnLUkOfftqeqbFQ/uBzkbcEf4JQjCYYsuQ=;
 b=CQBztUoUMVkULl+HzUxHAZmSAjSTHvgMkHU49ZbgqEphx8DAksOCPn1/H/2UffHxrakL+SqByJayjHzg6Q63+zYk2Zre2+Ieh7SWPp/p0JoC27uMUX4e4BbXFh0+Df/0Z7S9DK7/x3hPNi0hgh1QaQxsn5ZjMfqlek2lin1FeA8=
Received: from SN1PR0701CA0001.namprd07.prod.outlook.com
 (2a01:111:e400:5173::11) by BN3PR0701MB1332.namprd07.prod.outlook.com
 (2a01:111:e400:4018::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:04 +0000
Received: from DM3NAM05FT009.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by SN1PR0701CA0001.outlook.office365.com
 (2a01:111:e400:5173::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:03 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT009.mail.protection.outlook.com (10.152.98.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUW017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:09 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:08 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lq4K029888;
        Thu, 12 Jul 2018 06:47:52 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lq01029887;
        Thu, 12 Jul 2018 06:47:52 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 26/31] usb: usbssp: added endpoint configuration functionality.
Date:   Thu, 12 Jul 2018 06:47:23 +0100
Message-ID: <1531374448-26532-27-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(36092001)(446003)(476003)(2616005)(76176011)(105596002)(426003)(106466001)(47776003)(2906002)(14444005)(26005)(36756003)(336012)(186003)(8676002)(11346002)(51416003)(8936002)(126002)(1671002)(48376002)(50466002)(16586007)(356003)(4720700003)(7636002)(305945005)(246002)(54906003)(42186006)(86362001)(50226002)(5660300001)(6666003)(478600001)(87636003)(26826003)(4326008)(109986005)(107886003)(486006)(316002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1332;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT009;1:W732ab+ueuk5sJ06fNkiLd96Rwc9NhLGxUkAIcU7zlQ728eLc0BHCVhAX8UUcIRm8Jh9x9bO8SxNIwtTKJUgIPirLuedIuM7lG81JkUIJ7qPE9FnfPsIVohMw1HuRMre
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c20ea491-ccd5-4e78-5514-08d5e7bb08eb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:BN3PR0701MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;3:Las/HoWO1STvJYJ+QtnB1x/KNTHvj7t7cK1GfOqyR0izQrNnTzY9rimo69OKvoC4aVWXEh73vj1XfYA/nBZ2IemrTXSdrjjpQnQSwd4FO9MmaT3ES0vBI4zZfN4ahz5BR2kNzJLEDW4ysHSyu2/+fiDdFtXyNDf+B+mn6gCyut29RAXAQvFnSUPuOQtVBAheWRCXUXSZMArP8+NsIXcFtwEU92iJ4vdSxqSWucrma8ySKXmZpf/q1ixmeJp/lp5di3Zg/86sdr+tN5tcGAuNOvdTN0DwJTtz/sm+1antoQ/msQNt+TQww2vMCyd8H4BT7igc3joaMp6Vf4GwPWtLPoihLHkhqwhPI5ApBOl99ZY=;25:WRQX6M0C5xC2d7dJAOMhC0hcEn5K41wYps0eKPwGFyrQZL3CGjU1xwVmDmIBwdOE4H7umltNgWTsjdK9PEfmgwPe30XcHJOA5phPuMhXFLaqqESgI8eBQriJVc9BwEBrgq01kXchwNKM/6b6prokQcUyoPNXXfdNQCanxQsh+wz60elpfgyhHsgkDR0CVwh8IxAmNqcOQVVNK3/U2vBiT0QF9xkjUtB1esYLq8OfPBk6EnSBBvqyEhL17ZNx2WSU51lI0lUG4f8ps/AqfpcTeQOHpQCsIzUU1w/d/NKFkpSJsrvJFgVk3y4WQ/i2loa6k2YiI2T+DRKcR21MShEztg==
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1332:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;31:VWmDMbLIl1yLCCYlAYGVkSuFoWAz6NDMwdG5xb4YIy89VNmgJgcq7i1ovV+OLBgisfsn6pIYEWY3KNs47leiBiCz++ldujmE/tDYEz4CG7XrloKYsRlaEM6gTPgaD/QUaXJDEfeSUgR+djblg/lERCCQBm0Iz40JtHjRz7lOS4lkT1wClNSBg2R+pBGDBhpL5CkiQ7LDHw+sh+ORPo3jzXUNCRuwrFWAD7n2d3a/wA8=;20:qH9LPHM/tG2tEXihmM7y2u6YK3BOyqJq2cwWkVvUqmDYxpyAXyn4zfgaeenVkEEKWOHDpafrFPlCfqJH2BvDnb/APubXCdpnQyszlOTquN4sfK9yVbcjBultL3EYYvNpkvq8Y0l3zk1nc44FPdMlUYp01r82tiSNJTd9UbFnPc0KzNG3t/NgzCHNouqegp/aBH9UWF45AuQYpkN6R/ajlfnn6k8Iw+PjeiGJZJAS8PuXXyuCRJETgXbGoC5H1aWthpFlJR/cgEvA8Kbje58CBoWHvKVbXGl2dt6cyeIqmU55HTVm7j6YGNWGZNaq0/+SM/d2VK8uNjHA6tEbjYRbAzSJjNWcX3T2ixfyFV6Pc4L58VJkYxUkXeIEBOCM7UOQyitGfgip2zji+OeiFeB7a3EFO9oyHR7W3MxcO51JGz3GHE+xXBz8amnH4D1qoJoGfkSGR9eT6rEQVOpKU4qsYeQqGT8quty0pbjn698UOITjYsJH4ppivlsjttYiUvQU
X-Microsoft-Antispam-PRVS: <BN3PR0701MB133251C47F440ACF39D2C678DD590@BN3PR0701MB1332.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1332;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;4:07B9BBY7uyV26a2S+v3MfVV3Gep5FlLws209DcJeDTZHIWZLORJEVyuK94iGY84aHDdEdCDZyEzFxf0mH//QmztBjbdeBe7rvEZance+TGxppkgSIbjy6f0pt9aLUaOOJkoxBU+oW3SzfYy4sSuAtr5YD1tLtbbVs5ufTt2gmEYGoaW1ZgYjcaoiR6cdsFltIpHfoIPDvPFpxjGjf0CD0fqNd7ChQvaoxGmnIUpCGdCPGzddW6QUFhyUd3ruap79l9lgkK/9uM1wjNvdg9RRSVOFF4ZR1SB7ALcK+O0lknz8kft1CNmZYYAPCDW4CR+V
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1332;23:ANLdl02eQ4jK9OTjVBUZkFtNZMygUD3FhZBdCcZ?=
 =?us-ascii?Q?gvNaqrxMwV61w68ceOFj66y2ViepTpvHKpdmimEmYWSWoaaxVlMhyeneyCuq?=
 =?us-ascii?Q?PCOV90+YVJ8eHp4W2+hFdVlW00WIIaRp2XxX4/+DpfEgHCD6Jok0eVtZZ/rD?=
 =?us-ascii?Q?SgpcweysB323EjwqjUUAD23JvZ+/nWaaHErttTZJKzU3jeldrnjocmcKVfZA?=
 =?us-ascii?Q?E66f8gara77H/u3Gh1CcV0KPO6ym+3Gkq5Plvb9SaUqpSwhFVJ7uYLJ9WYwf?=
 =?us-ascii?Q?jcs7D9SwGG9feZei5Dq9zeLhuvjgID7jA1fArGrYx+ET4iOJS3jvnziVnuz8?=
 =?us-ascii?Q?MpqCCIsvHuQ1n8Z/A2fdLpiLiMcdS+pfUX5JJgldPggx5WXqf4kE2RaE9Z/E?=
 =?us-ascii?Q?tzduZB/v94CbN1leHLjsHUPA9KCUUse1GPcxrJ/cyk2uvfpG2um6/Z3219XR?=
 =?us-ascii?Q?DPW/El2BheMR2PEClnSFPQ+2LxVWhwi3X6ihyGAVM+vPKjHPbOXp1UfHfvhi?=
 =?us-ascii?Q?eg5z0WvysWZOaqwvbTprjcrnyrn3782ZZ3PyOKvdAzZeSUkPLpxRddWtklSB?=
 =?us-ascii?Q?Hl4/69Hnwk0VHrVOeBgrUU32w1GrPcxpPygThZzJ9VcjCG6cXy91Haa5dkVq?=
 =?us-ascii?Q?8YKoqRhDveut42Jv1k6CIFgIWLLVZ0BP/MFJ/nv1WInM7i2hGXHZ4oR9sefk?=
 =?us-ascii?Q?+bHGYW0M52UVFNCGpsYSA1uuBhyjMvOS+CdGDEfZBxqz/pGszp7t8xCDkuos?=
 =?us-ascii?Q?2vECW7jtl7X4B2v2QpwN5hrMlyDVIC6wSA+D/TQLsJ++d8S3ypUllefmfI6y?=
 =?us-ascii?Q?g9gZHU276U5wHrkZr0BXeYYx3OVR8VlUFK2g1DqggMJVZkPb2XHOWVr+YYY/?=
 =?us-ascii?Q?4Zg3sUVSM9Pl4evPS+Jso0I/jvTxvHeZkTW6ENb6k9tWze+5778VN/YhsYeI?=
 =?us-ascii?Q?YDU6xD/ITOCvwOHPneQZbXy8/xmyonpHZ34+4+5FNs13w7lmiKu08egbkJJM?=
 =?us-ascii?Q?u0wQjE5sTpO6m5FtUi3PzTUXtN4TfasCNDzBeQSvzL9Dl0gOCRdTiiPkGgjY?=
 =?us-ascii?Q?8H14PTQUTrElRrYOP3BeGpySqdKLxVVFziWaAbL4MJgHseTQh3CpfpVhIlC2?=
 =?us-ascii?Q?6UN2hHhl9ory0XhmZK+4vNZyQ3kS9scfywz+ZDOgN8/4OhRtaCIwDsA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: XvxC5sQkWm162Now2D0bEeAmHmYCMXOYD3Mk5Ha2FYmCMnlEETjpKc/3twX13Qg0M2e9YuvHaJdPy6Is+x51e+GiALl3r2ZmQDV+KdoeRV6LZBC0wIfsTwqmXrZTHWQAFAMEUhIFbW53tnQi3zckCdsD3axoHHDAyXp+KFZtdElL3F40neiXwSzdkU0nlBr3fC1hMJZnjAhYii2Gy0Fss0bLP7NlML2MKkUQ1YlZ3xsBBZ9o103b7BtT3h9dVElt5FNXP98HzAENImnyqsUAqndmgVCQGhlKUIQsrl/oDBrDCE5pIP/OoWACWbkO/zIsUZaT5VghghnI1WCn2kn9gXV9+yNj1XdTNkU2n4Ari4Vfmc9e7jSYQHaVhVKZqw7U/MbYoGZCCn/Icp03ha3v1w==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;6:dgh0UE4x/qKTP5PM3pkNUWL709GMy1bWtCJMC57YC2+cV97Di3ie+XsJdP6BflaicwTNtqNjffLdWz96iYe6e3Ts8SgjtJpUKc7CglVOwdk8RErRUW0HLeMvmhFRoVrvejvowWKdtkS1aBoHoStS06Pdqs4onW7nMJ6moEhhOtkQ/xlx+HtAU3BkTIMGds9F9H/dArejdcj3Rabjze36tY/wKDSWwsXrHm8z1dH9EY58Cswj7fmxle/u/iQFSh+pELtXSqTnhIXdIYH9wUxQTFGWohSfQFeP7ZV6AIh0ct3rUn6NKKe3sidbElUK8R94w86e7FPFSuqN400KtFxJe3yA4Cg9hyolUPPWhbjb2xnJmhsV9uJHDLkiA7ypqf/kDXWQR9Hj8d+BhgHoCRMpiPambM6QVLJ54YtHL9gBy4gExjdvgsN1WQn4XdH8C/n1PUOKsDa6p9kkkkPrT7qqrA==;5:o0kiyor/paDf+VU6nmiSEFP1ALpBHJLgw1s/7ajPjtGJI6SaxdQ0P0mDkqPLpBraFudnM/ym+75an57jww8WLkyMqjNshUxQpc3/MePmGDN4fi00qarSGfJ/3D2iEVGaZMUykeG1GShIZvjjUNZgHrhcg5Z2xekTTCHmC+ASIP8=;24:FUvatfC1TZppg44iADdZqsJpyo+FwgMBC5D4+oS5sCW7KRHAvjj5tCD1/VMS9exxYQSOLkn2VjKQ+f72RemgoEpwUXx5BGsNJGcLAQ1Egp0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;7:d/A8NQkTCMkDRIGTr62AFVwAlUXbbq/x7Iishk5L0QkVuhRd0Nw7iDj1+2jTu4fMfuO0L9X7Ck1MMk9Ltw0uqTg5qiraq2SOek0rJjnXrDmnikSLPG3iAle4lf19pcJi6SpYdPInCQt/v+OGWJ9PW0polsPK0480uu5tJhgQbhE/8/Rl/MGhH36As3HDjfE1aJDpyBD0eCAgQEfeBYCJI+PznaNTSWfA4w4/K6TtZn4nbvTA5OdTwgmU7MujP16c;20:oF8BDFVgDmM4E6UY9WV0ZcFvDmDMnbWozMUFryF4nFQvFqawvieDPwTfycSylz3fu7nvYs91cwea13yosaphawhVbDZytIPpQm67VBXxQEIAmG9+Q6lKqk8EcX+33iNnBLtALPOqi8az0wv9g2z5JP7ob8/54Pms2cs//UQt9F50TBcmsHDUl2j/C1vcF8SpnckVEXZl0qcOdbGB7ezZfTeYCgdioU86emiyClumkMnnO+CAl8sEuZdbwqKfT/Kt
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:03.4834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20ea491-ccd5-4e78-5514-08d5e7bb08eb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1332
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements usbssp_configure_endpoint function.
Function is responsible for configure usbssp controller endpoints.
To configure endpoints driver must send Configure Endpoint command
to controller. To change some parameters of endpoint driver must
send Evaluate Context command.
Function usbssp_configure_endpoint is blocking function. It means that
after issuing command to controller driver is waiting for completion.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget.c | 162 ++++++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h |   9 ++
 2 files changed, 171 insertions(+)

diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 38df3d3e937b..3e461fca855e 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -703,6 +703,168 @@ int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
 	return ret;
 }
 
+static int usbssp_configure_endpoint_result(struct usbssp_udc *usbssp_data,
+					    struct usb_gadget *g,
+					    u32 *cmd_status)
+{
+	int ret;
+
+	switch (*cmd_status) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		usbssp_warn(usbssp_data,
+			"Timeout while waiting for configure endpoint command\n");
+		ret = -ETIME;
+		break;
+	case COMP_RESOURCE_ERROR:
+		dev_warn(&g->dev,
+			"Not enough device controller resources for new device state.\n");
+		ret = -ENOMEM;
+		break;
+	case COMP_TRB_ERROR:
+		/* the gadget driver set up something wrong */
+		dev_warn(&g->dev, "ERROR: Endpoint drop flag = 0, "
+			"add flag = 1, and endpoint is not disabled.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		dev_warn(&g->dev,
+			"ERROR: Incompatible device for endpoint configure command.\n");
+		ret = -ENODEV;
+		break;
+	case COMP_SUCCESS:
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_context_change,
+			"Successful Endpoint Configure command");
+		ret = 0;
+		break;
+	default:
+		usbssp_err(usbssp_data,
+			"ERROR: unexpected command completion code 0x%x.\n",
+			*cmd_status);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int usbssp_evaluate_context_result(struct usbssp_udc *usbssp_data,
+		struct usb_gadget *g, u32 *cmd_status)
+{
+	int ret;
+
+	switch (*cmd_status) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		usbssp_warn(usbssp_data,
+			"Timeout while waiting for evaluate context command\n");
+		ret = -ETIME;
+		break;
+	case COMP_PARAMETER_ERROR:
+		dev_warn(&g->dev,
+			"WARN: USBSSP driver setup invalid evaluate context command.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_SLOT_NOT_ENABLED_ERROR:
+		dev_warn(&g->dev,
+			"WARN: slot not enabled for evaluate context command.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_CONTEXT_STATE_ERROR:
+		dev_warn(&g->dev,
+			"WARN: invalid context state for evaluate context command.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		dev_warn(&g->dev,
+			"ERROR: Incompatible device for evaluate context command.\n");
+		ret = -ENODEV;
+		break;
+	case COMP_MAX_EXIT_LATENCY_TOO_LARGE_ERROR:
+		/* Max Exit Latency too large error */
+		dev_warn(&g->dev, "WARN: Max Exit Latency too large\n");
+		ret = -EINVAL;
+		break;
+	case COMP_SUCCESS:
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_context_change,
+			"Successful evaluate context command");
+		ret = 0;
+		break;
+	default:
+		usbssp_err(usbssp_data,
+			"ERROR: unexpected command completion code 0x%x.\n",
+			*cmd_status);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+/* Issue a configure endpoint command or evaluate context command
+ * and wait for it to finish.
+ */
+static int usbssp_configure_endpoint(struct usbssp_udc *usbssp_data,
+				     struct usb_gadget *g,
+				     struct usbssp_command *command,
+				     bool ctx_change, bool must_succeed)
+{
+	int ret;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_device *dev_priv;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	if (!command)
+		return -EINVAL;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return -ESHUTDOWN;
+
+	dev_priv = &usbssp_data->devs;
+	ctrl_ctx = usbssp_get_input_control_ctx(command->in_ctx);
+	if (!ctrl_ctx) {
+		usbssp_warn(usbssp_data,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, command->in_ctx);
+	trace_usbssp_configure_endpoint(slot_ctx);
+
+	if (!ctx_change) {
+		ret = usbssp_queue_configure_endpoint(usbssp_data, command,
+				command->in_ctx->dma, must_succeed);
+	} else {
+		ret = usbssp_queue_evaluate_context(usbssp_data, command,
+				command->in_ctx->dma, must_succeed);
+	}
+
+	if (ret < 0) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_context_change,
+			"FIXME allocate a new ring segment");
+		return -ENOMEM;
+	}
+
+	usbssp_ring_cmd_db(usbssp_data);
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	/*Waiting for handling Endpoint Configure command */
+	while (!command->status)
+		udelay(100);
+
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	if (!ctx_change)
+		ret = usbssp_configure_endpoint_result(usbssp_data, g,
+			&command->status);
+	else
+		ret = usbssp_evaluate_context_result(usbssp_data, g,
+			&command->status);
+	return ret;
+}
+
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 			 int value)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 38ae684d71e7..97ccc29792a2 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1686,9 +1686,12 @@ int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
 int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data);
 void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
+unsigned int usbssp_get_endpoint_address(unsigned int ep_index);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 		struct usbssp_ring *ring, unsigned int num_trbs, gfp_t flags);
+void usbssp_free_stream_info(struct usbssp_udc *usbssp_data,
+		struct usbssp_stream_info *stream_info);
 struct usbssp_ring *usbssp_dma_to_transfer_ring(
 		struct usbssp_ep *ep,
 		u64 address);
@@ -1756,6 +1759,12 @@ int usbssp_queue_intr_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
 int usbssp_queue_isoc_tx_prepare(
 		struct usbssp_udc *usbssp_data, gfp_t mem_flags,
 		struct usbssp_request *req_priv, unsigned int ep_index);
+int usbssp_queue_configure_endpoint(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd, dma_addr_t in_ctx_ptr,
+		bool command_must_succeed);
+int usbssp_queue_evaluate_context(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd,
+		dma_addr_t in_ctx_ptr, bool command_must_succeed);
 int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd,
 		unsigned int ep_index, enum usbssp_ep_reset_type reset_type);
-- 
2.17.1

