Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB00C20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZffkUKLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB00C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeGLF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:07 -0400
Received: from mail-sn1nam02on0057.outbound.protection.outlook.com ([104.47.36.57]:50976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbeGLF4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyWoClT1RUMPW402+S6vqVmTKHkCCcz0a4+CZgpuuSE=;
 b=ZffkUKLRkb+vSezHteY0WyRA6yZqU/AOKbbylxNrXy9V5/9Gg8n3g0VO3GIjRAfQAOz7L1y2Qfay6TcQflfOsQfutpGc194bgViyDdGNoyaRv02GYR4XihgqhS8x+yN5oA14wzzcedReD3XuM4xF8AFAzal4rFVUrDe5hqsch24=
Received: from SN1PR0701CA0033.namprd07.prod.outlook.com
 (2a01:111:e400:5173::43) by SN1PR07MB2302.namprd07.prod.outlook.com
 (2a01:111:e400:7a45::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Thu, 12 Jul
 2018 05:48:02 +0000
Received: from DM3NAM05FT009.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by SN1PR0701CA0033.outlook.office365.com
 (2a01:111:e400:5173::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:02 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT009.mail.protection.outlook.com (10.152.98.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUU017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:08 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:08 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lprl029838;
        Thu, 12 Jul 2018 06:47:51 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lplX029833;
        Thu, 12 Jul 2018 06:47:51 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 23/31] usb: usbssp: added implementation of transfer events.
Date:   Thu, 12 Jul 2018 06:47:20 +0100
Message-ID: <1531374448-26532-24-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(189003)(36092001)(199004)(43544003)(48376002)(446003)(36756003)(2616005)(50466002)(476003)(14444005)(11346002)(2906002)(5660300001)(6666003)(4720700003)(426003)(42186006)(47776003)(316002)(54906003)(16586007)(51416003)(105596002)(76176011)(305945005)(4326008)(356003)(8676002)(7636002)(50226002)(1671002)(86362001)(575784001)(106466001)(26005)(246002)(126002)(486006)(478600001)(336012)(8936002)(551934003)(186003)(26826003)(87636003)(107886003)(109986005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2302;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT009;1:0gBAazzTTlkxhj8IYcj3TvbCgfi+2t4Mezqk4QCpcHQbQ7WDH4mbmsoXp0UrA8oX5ORTrFx7T1TPNgwqHlZqGR2VPZD03K66eo7SuWe1QhaEGXLkPzSEUuCGcTAcZ4Q3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 052a9a03-2cf1-438a-0873-08d5e7bb0836
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2302;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;3:zr9wUWxxwAs5UxILMc15WLKsF72qLYIhjiOHimCeP9Qd1yffqXQpii2oLvWiOGviYyXE8FLI7oAgdZ2SNqarzu7n/ivPctTFAqgijrhYHk5/pseDahlWpM+g/ENEM9MzDLVmhzGiRtdnx7hNOg06Zic3aPw2nYEwFtKgDo8mBTsuSJGtQDqBuxnuxr2pZvN9gAdP+ka4sFHiGh+iZW+HLbe6TNeIgt0TDBLmo9Jc8JsIHFmJ2Jy/IsSZENTs5QKyOPWSfR13nieuf6PWYp1Y6J/DKpnNs4uZNW1yQroSBBm1Jwd8oJ8qPe4IpecAtRMETOv8daWhO9t7k7IrHEKoHOxj21OBpyHRkSMGGDUUtUg=;25:Kcme9OfHdBO50hVo+6XdmPO75nOh/+yszzLFwduwy8BwyUL+QGmbYnBmO3Y4dzmVtaeO9y5lLyz6R5AEmwKw+vAiNAgBmy2kpPhCrUPPYGzsO7OQDawd+3buPDE8u7DdrROPuzPxqfy9DKzU7/dFWYmMrRzDQNg/xRYU9T4EUZFzKh0CqjqFphe4QbIzTttbGEmJB+Ce+Uby1A0j9QytNPdbE9YWKiFMJ0z949wgoWswp1TSwtTEjBe+wdlTJu9tCsUlmlMyox/fHCcwY4W9j+92+xMx7QpQzPeDKqGmrnLuAeCrH37m5Su2W6orEtUde9vlOlnH5S8lA4Qagtc0og==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2302:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;31:H8tJSQcCLnZMUlB6Qr/THAumPNA3yXVkOY7wrl5FPiEy9vbbNZNcL9BD6aFGF2qibXI9R+UuLith1LlU2N7Ywsl+uiRqrtTGgvh8jadfeWVw8pK4fxHclP9B5ALEacAQwTM4qqmO7cwsfBpRWUbZRQvgcjSip5kNX31Gc34SH2WAK3WvK7n0Q9qbYIxofwYGWIgmWzGvh4dHSNSMW//JXDFukam4V4sfEJXcegewiUA=;20:D6Uuz2cuWE9bPvYa0mpOo/vsq2T1QTyCvzNZL3AzFwDVkHqjkbxUnq/6+RFoFuhr4Uhm/uBD6f4OQt7vQAZ9AegGn/EuVFyThYuig7PPEpPMgR7ZMrJfzNJpxN4P/ovpCAUH6GU4F7VN1iasuwUP5r9zuGoDl0Vb1JPyzMc7a+QndJvOcnyrtIvlu6FOcwhrl5G4qksZx8+165PtkzolZNChkxoz+JkcUv+RPtUtrHWVOjHdmms4SPE7pDcEknrUBXH2NElpzdNyxcjpCRaRL8tqCfFZRu8lxMzirMZyfq+KV68v/NVSbiCLYAzEu23TTN9XNh7iwxMMLUmr3ooMfXD1bb7V88LsImRVx9mgH1JysTb9wJ3JBKtkqyIhMT4CIbQs1zH81CIcTayT4oVi3C/98po2Hw2Th01l762dYYSG2DS0S/zGIjGnUurWiExy9BmHG1InmnwHaRvl1TnD6X6qn+UFlix3vPawsrSj/FcDc9b6eCW4fkFZV+YZ37pX
X-Microsoft-Antispam-PRVS: <SN1PR07MB23024492EEB76D12B9056AC2DD590@SN1PR07MB2302.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB2302;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2302;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;4:sxuKd4bSko3mHyxeYY/FRDnqGmTCRQ3fdFzjm1J0OUDAP7Rb8O7mTZMAZ5krKeMwIfvHCmY6r905NYzXhF0VKxtwJr26FH6HrFyWCpb5poI2zgI38E6O26m9aZVJbFq9se2Dm8btE4qFp9O0XFEvcb7qjLaoQR0FUQ0Phw4BtBkcMRqqDP203vxJ7/tma+vvuwR1VplnjwrkRxopChHOoq7wL3ou9xWD+PwrLX5nW0ckqimZ8nw6nvht3W8gTbuKfFxf3ozhe+YL4gri2rtWXv2YuSAuAbTE2Ab8eU5nnDH11tqpz3zWK3v0M+bbCR5S
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2302;23:E/h1QRu/BBlQzjtRL59cP31QKgcMT0jW4XQ9I6cGG?=
 =?us-ascii?Q?NFArWI8Nl97AsHnBZ2EAUj+9uwjNlZfM4i7P2khxmO006QFuVbGHzSDb386x?=
 =?us-ascii?Q?ecKWxSMyOuTj8m7MFO+/gNgT/9CvKF2p/Ve58ncO3CowLXwXvZR16M8OWg3V?=
 =?us-ascii?Q?yA2eXMM1Bsz5+brqOlXMWlSdrDPXlTCwmlGpw9Uf1k6+0PMB64gg3oUFHzBO?=
 =?us-ascii?Q?+2SThhYKsAJDj7Mg3nGL6S0hs5xd0fqbvX7/Pf4ljDgJ+duiddJsRirPhnPB?=
 =?us-ascii?Q?KAvZyMFkUX4kjR6Aw0Fjd0eHhaRMWy/PovcOS6CXq2BtkktfTiNpIN7RAwWn?=
 =?us-ascii?Q?wY/9ZcC7xGKv6/qws2sKmtTfarM3V5hOcDmYZVM/2iw/3IIF1O008Ok5zm3B?=
 =?us-ascii?Q?xgK1NUP4TAZork48NQuzihQj72M7R1+ZWq3ejPLMnp7SIbnwsjzUqDng0rtI?=
 =?us-ascii?Q?sfqmy1F9cFMICMeYlGBp3Q00pOQsGGyoLsrpHufA6hrLhue1GLvTRT4VwB1/?=
 =?us-ascii?Q?xALs/4R85tZlEjcdVikacQbhY3mFEjeo07uiGpp+FhQz/QfyTbe+HZ1gpNGL?=
 =?us-ascii?Q?VEGS9LsrdlqbMJDFbHtVbkd9mEdFy2OYINfKB/JLE5v4ss96v9SXoKiUvIDe?=
 =?us-ascii?Q?AFuKBktQzVnvzZsyoMvHzbM0O8tqhKAv1vrmMnrAUkTymXHtgXM9LSb93mwm?=
 =?us-ascii?Q?WuXtJKKOYtdpHEZqeBF5oqrF1Cn05YvdK6ziAnrb1tptNPObDb17PZba9FjI?=
 =?us-ascii?Q?KJGLTk7F6P4gD4pP6NwSS19vE7aolVX0ztRrWktJz4OAT4JLK+++2svV9kYP?=
 =?us-ascii?Q?sYZJ5nhg4anXnMWLOWVsIYtzJMkFHIWsDoje/80hSeeJqJFTR3XmYvJy+kM1?=
 =?us-ascii?Q?OW41JUHnMOKk0XHwiFqDMGgHykAZzkXdC3lQf3TF3+UMUVRHAw3tXpcFUFgm?=
 =?us-ascii?Q?l+0D5fltjVkerGCCQ3DbWwVkonsat0U8+RzsDLBnT56pfglPfF0ELu6+u1AT?=
 =?us-ascii?Q?R0e1Fnczu93rTqz4IROszqKC/Qj9jFFHAKB7gnoPV+SJgpaNO3nxekFTEXVB?=
 =?us-ascii?Q?wHwCsYa79KebjGyMjN47++H/Oe9VLEO6CQQBGQkfxxdtcA2lkmVvaWBRY4we?=
 =?us-ascii?Q?33W3uMJCJFW7XMcM09Z6gZ/kpscSXSr3sJxfl7k1+0UUG1mkGfIFQTULkwP1?=
 =?us-ascii?Q?SisZ3pl2z9zBw83zYv5Ov5iIFV9abCL29vYmi34LyMSEeS+dZRP/Tspag=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: RjPETyCdjuafAuskkZdUvHdERWXsCOEYRxdk0fBbaL1YEuQCutXp0XAeYbcCszio1WsVDoafG1Wti1JbMjFboSubcI/wUzLyqo42EAvW6PVmOmzB8AmlZvMYlhUfPpGCWXQTVc+Ns+OoKMHVUvcGQRPPce52pGAqVSS2VTPq0rRelFwpupXOYhTeFou6RBnHAkiVqjKh5zH/+DE6gPeTjPoVnIAR54INfrJBGfTbHP30D8i+5+xQ1sMAnW164+21nQKQKpmUeaZWi79RQqw72KYI8EZCpiUP7hX8/B2dIUTHBRNws667hO3oP+Jzb7wApLWSc9/4grCWZvXY6dk6CpozErTt9gI+ar69VK3vRYQLOfymkO6QP0cK6bc7d0Ljzie8YYxhoM9R9tJSzn4xsA==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;6:qm1QigOX5511FUWj7y7ZiZCFXdsf8mvTBn6U2d3H1KWWcY9OXU9XfUy44zns1Cp7i9OdbwKvRe1dPh1c0kOC1cZSuW+Ovi7a9+D47oNy06r2sQWThK6SZ4g/1jYA5mFes8lLpF2aYF43sUZUZ+zPBPLREMH9r4gH/AgIhizPqQzckq07pQXUQmNs4MICTkdfzmzjzD6Z44Wm0XDTbLI+5K29NfD/IFAegky8Iy86e5Rao/DXVFC+aURaQ4tVrpqF8/BX+WQv6ZHspWmkMdHbjqiAFxzq0Fnx0lJfi6/TfmJPSknNAHHGe22bcC9sNtD3uDVf2lNskmPNm999QXQS0WFV5Izi5/8B/Ynq8CeJQ9D9Mf7OWEVzNGMaZ8AsbqELrwYBBnQ0ia7xG3UM3I+dworqALWxBemwCx/jdi1VvcHm1mewmRsZAXI0Tp9sau9BjR4Kc6I/ArPy5qzXv2D74Q==;5:IbgmCKhs9wTYYIiNPMHJZUk57MpEZMmQFgQJj/xoGpNPXVmtitJOGg6xZIbtzXMB85m+EbCNZudzSb8JRCQgC5UtWHmFPCxm3hzAaHEarfrqjL3FBOH8Wv3AMOvSjq0wesDtdc27qD6nhj3pUZi7NflhXFCx3Jaad4XkgH3JZO0=;24:sMsBaHK4j/zqCumwfic7JwpGt7+GxsYgsFsDyXNCsnbM6VFaFJbAUZKQkb+BKDKi9TObq4SqHw9ESmetsiiM9XNjxLuJQz7X2ySyfOCqXUY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;7:CMR0ubYqEE9JddO2vSIbUO5cLxtruUERK13632NQWkA1Qe3O8fr+wgxz1DWCpsu2O5oL187eUCL7bwKitLTNfI1EPOVn7fEFrXSzO1JjJYaRnHDhjE3G3qrgHpSoLlqMUaKwCpjtZolN0r3SrO8wGri5FTI8GoROhJC5dT5YxM5iwZ6CJKBushY0909NDfCxraFQKYWSChJQQ7p3G0BzUAR188Lz+FSso/Vn0T2XS0UVB/hKtBB95OPNddYr6w/t;20:HkuXhq4fwj0Q4mK3eTSFvVdaPaA09ygfTEcMIietIFQtZKA+vcw7PKb4eh9yGCMdRMXoP9RdenlFlRdW6Sc0ngfLMUd9boEfZQryqhXXHAmrM61tWcUhuiBcPq6ND6oRybdhW4gEaJz44u6rvVEBFFhEtViyT7Y/EQOqXC7/kSZ0HwPrjq3w04Vv1WwES8imenvn8+GRb2ukGAWIY2WzYf5j37/kZfp4BbDZtoLP+pXBOPMtvDbvRhQyH4S/o/T9
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:02.2327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052a9a03-2cf1-438a-0873-08d5e7bb0836
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2302
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add functionality related to handling transfer events.
This kind of events are added to event ring after completion transfer.

This patch add supports for handling transfer events only for
control, interrupt and bulk transfer.

After the transfer, usbssp driver release the TD and informs about it
gadget core driver by means of usbssp_gadget_giveback function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  |   9 +
 drivers/usb/usbssp/gadget-ring.c | 598 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |   3 +
 3 files changed, 609 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 60c78d1d7f11..53292768a90f 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -558,6 +558,15 @@ static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
 				stream_ctx, dma);
 }
 
+struct usbssp_ring *usbssp_dma_to_transfer_ring(struct usbssp_ep *ep,
+						u64 address)
+{
+	if (ep->ep_state & EP_HAS_STREAMS)
+		return radix_tree_lookup(&ep->stream_info->trb_address_map,
+					 address >> TRB_SEGMENT_SHIFT);
+	return ep->ring;
+}
+
 struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
 					     unsigned int ep_index,
 					     unsigned int stream_id)
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 08597127d495..989d096f64ac 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -62,6 +62,13 @@
 #include "gadget-trace.h"
 #include "gadget.h"
 
+static void giveback_first_trb(struct usbssp_udc *usbssp_data,
+			       unsigned int ep_index,
+			       unsigned int stream_id,
+			       int start_cycle,
+			       struct usbssp_generic_trb
+			       *start_trb);
+
 /*
  * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
  * address of the TRB.
@@ -80,6 +87,11 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 	return seg->dma + (segment_offset * sizeof(*trb));
 }
 
+static bool trb_is_noop(union usbssp_trb *trb)
+{
+	return TRB_TYPE_NOOP_LE32(trb->generic.field[3]);
+}
+
 static bool trb_is_link(union usbssp_trb *trb)
 {
 	return TRB_TYPE_LINK_LE32(trb->link.control);
@@ -1528,6 +1540,287 @@ int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data, unsigned int trb_
 	return 0;
 }
 
+static int usbssp_td_cleanup(struct usbssp_udc *usbssp_data, struct usbssp_td *td,
+		struct usbssp_ring *ep_ring, int *status)
+{
+	struct usbssp_request *req_priv = NULL;
+
+	/* Clean up the endpoint's TD list */
+	req_priv = td->priv_request;
+
+	/* if a bounce buffer was used to align this td then unmap it */
+	usbssp_unmap_td_bounce_buffer(usbssp_data, ep_ring, td);
+
+	/* Do one last check of the actual transfer length.
+	 * If the DC controller said we transferred more data than the buffer
+	 * length, req_priv->request.actual will be a very big number (since it's
+	 * unsigned).  Play it safe and say we didn't transfer anything.
+	 */
+	if (req_priv->request.actual > req_priv->request.length) {
+		usbssp_warn(usbssp_data,
+			"USB req %u and actual %u transfer length mismatch\n",
+			req_priv->request.length, req_priv->request.actual);
+		req_priv->request.actual = 0;
+		*status = 0;
+	}
+	list_del_init(&td->td_list);
+
+	inc_td_cnt(req_priv);
+	/* Giveback the USB request when all the tds are completed */
+	if (last_td_in_request(td)) {
+		if ((req_priv->request.actual != req_priv->request.length &&
+		     td->priv_request->request.short_not_ok) ||
+		    (*status != 0 &&
+		     !usb_endpoint_xfer_isoc(req_priv->dep->endpoint.desc)))
+			usbssp_dbg(usbssp_data,
+				"Giveback Request %p, len = %d, expected = %d"
+				" status = %d\n",
+				req_priv, req_priv->request.actual,
+				req_priv->request.length, *status);
+
+		if (usb_endpoint_xfer_isoc(req_priv->dep->endpoint.desc))
+			*status = 0;
+
+		usbssp_giveback_request_in_irq(usbssp_data, td, *status);
+	}
+
+	return 0;
+}
+
+static int finish_td(struct usbssp_udc *usbssp_data, struct usbssp_td *td,
+	struct usbssp_transfer_event *event, struct usbssp_ep *ep, int *status)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_ring *ep_ring;
+	unsigned int slot_id;
+	int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	u32 trb_comp_code;
+
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	dev_priv = &usbssp_data->devs;
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	ep_ring = usbssp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->out_ctx, ep_index);
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+
+	if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID ||
+			trb_comp_code == COMP_STOPPED ||
+			trb_comp_code == COMP_STOPPED_SHORT_PACKET) {
+		/* The Endpoint Stop Command completion will take care of any
+		 * stopped TDs.  A stopped TD may be restarted, so don't update
+		 * the ring dequeue pointer or take this TD off any lists yet.
+		 */
+		return 0;
+	}
+
+	/* Update ring dequeue pointer */
+	while (ep_ring->dequeue != td->last_trb)
+		inc_deq(usbssp_data, ep_ring);
+
+	inc_deq(usbssp_data, ep_ring);
+
+	return usbssp_td_cleanup(usbssp_data, td, ep_ring, status);
+}
+
+/* sum trb lengths from ring dequeue up to stop_trb, _excluding_ stop_trb */
+static int sum_trb_lengths(struct usbssp_udc *usbssp_data,
+			   struct usbssp_ring *ring,
+			   union usbssp_trb *stop_trb)
+{
+	u32 sum;
+	union usbssp_trb *trb = ring->dequeue;
+	struct usbssp_segment *seg = ring->deq_seg;
+
+	for (sum = 0; trb != stop_trb; next_trb(usbssp_data, ring, &seg, &trb)) {
+		if (!trb_is_noop(trb) && !trb_is_link(trb))
+			sum += TRB_LEN(le32_to_cpu(trb->generic.field[2]));
+	}
+	return sum;
+}
+
+/*
+ * Process control tds, update USB request status and actual_length.
+ */
+static int process_ctrl_td(struct usbssp_udc *usbssp_data, struct usbssp_td *td,
+	union usbssp_trb *event_trb, struct usbssp_transfer_event *event,
+	struct usbssp_ep *ep_priv, int *status)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_ring *ep_ring;
+	unsigned int slot_id;
+	int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	u32 trb_comp_code;
+	u32 remaining, requested;
+	u32 trb_type;
+
+	trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event_trb->generic.field[3]));
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	dev_priv = &usbssp_data->devs;
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	ep_ring = usbssp_dma_to_transfer_ring(ep_priv, le64_to_cpu(event->buffer));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->out_ctx, ep_index);
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+	requested = td->priv_request->request.length;
+	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
+
+	switch (trb_comp_code) {
+	case COMP_SUCCESS:
+		*status = 0;
+		break;
+	case COMP_SHORT_PACKET:
+		*status = 0;
+		break;
+	case COMP_STOPPED_SHORT_PACKET:
+		if (trb_type == TRB_DATA || trb_type == TRB_NORMAL)
+			td->priv_request->request.actual  = remaining;
+	goto finish_td;
+	case COMP_STOPPED:
+		switch (trb_type) {
+		case TRB_DATA:
+		case TRB_NORMAL:
+			td->priv_request->request.actual =
+				requested - remaining;
+			goto finish_td;
+		case TRB_STATUS:
+			td->priv_request->request.actual = requested;
+			goto finish_td;
+		default:
+			usbssp_warn(usbssp_data,
+				"WARN: unexpected TRB Type %d\n",
+				trb_type);
+			goto finish_td;
+		}
+	case COMP_STOPPED_LENGTH_INVALID:
+		goto finish_td;
+	default:
+		usbssp_dbg(usbssp_data, "TRB error code %u, "
+			"halted endpoint index = %u\n",
+			trb_comp_code, ep_index);
+	}
+
+	/*
+	 * if on data stage then update the actual_length of the USB
+	 * request and flag it as set, so it won't be overwritten in the event
+	 * for the last TRB.
+	 */
+	if (trb_type == TRB_DATA ||
+		trb_type == TRB_NORMAL) {
+		td->request_length_set = true;
+		td->priv_request->request.actual = requested - remaining;
+	}
+
+	/* at status stage */
+	if (!td->request_length_set)
+		td->priv_request->request.actual = requested;
+
+	if (usbssp_data->ep0state == USBSSP_EP0_DATA_PHASE
+	   && ep_priv->number == 0
+	   && usbssp_data->three_stage_setup) {
+
+		td = list_entry(ep_ring->td_list.next,
+			struct usbssp_td, td_list);
+		usbssp_data->ep0state = USBSSP_EP0_STATUS_PHASE;
+		usbssp_dbg(usbssp_data, "Arm Status stage\n");
+		giveback_first_trb(usbssp_data, ep_index, 0,
+			ep_ring->cycle_state, &td->last_trb->generic);
+		return 0;
+	}
+finish_td:
+	return finish_td(usbssp_data, td, event, ep_priv, status);
+}
+
+/*
+ * Process isochronous tds, update usb request status and actual_length.
+ */
+static int process_isoc_td(struct usbssp_udc *usbssp_data, struct usbssp_td *td,
+	union usbssp_trb *ep_trb, struct usbssp_transfer_event *event,
+	struct usbssp_ep *ep_priv, int *status)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
+static int skip_isoc_td(struct usbssp_udc *usbssp_data,
+			struct usbssp_td *td,
+			struct usbssp_transfer_event *event,
+			struct usbssp_ep *ep_priv,
+			int *status)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
+/*
+ * Process bulk and interrupt tds, update usb request status and actual_length.
+ */
+static int process_bulk_intr_td(struct usbssp_udc *usbssp_data,
+				struct usbssp_td *td,
+				union usbssp_trb *ep_trb,
+				struct usbssp_transfer_event *event,
+				struct usbssp_ep *ep, int *status)
+{
+	struct usbssp_ring *ep_ring;
+	u32 trb_comp_code;
+	u32 remaining, requested, ep_trb_len;
+
+	ep_ring = usbssp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
+	ep_trb_len = TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
+	requested = td->priv_request->request.length;
+
+	switch (trb_comp_code) {
+	case COMP_SUCCESS:
+		/* handle success with untransferred data as short packet */
+		if (ep_trb != td->last_trb || remaining) {
+			usbssp_warn(usbssp_data, "WARN Successful completion "
+					"on short TX\n");
+			usbssp_dbg(usbssp_data,
+				"ep %#x - asked for %d bytes, %d bytes untransferred\n",
+				td->priv_request->dep->endpoint.desc->bEndpointAddress,
+				requested, remaining);
+		}
+		*status = 0;
+		break;
+	case COMP_SHORT_PACKET:
+		usbssp_dbg(usbssp_data,
+			"ep %#x - asked for %d bytes, %d bytes untransferred\n",
+			 td->priv_request->dep->endpoint.desc->bEndpointAddress,
+			 requested, remaining);
+
+		*status = 0;
+		break;
+	case COMP_STOPPED_SHORT_PACKET:
+		td->priv_request->request.length = remaining;
+		goto finish_td;
+	case COMP_STOPPED_LENGTH_INVALID:
+		/* stopped on ep trb with invalid length, exclude it */
+		ep_trb_len	= 0;
+		remaining	= 0;
+		break;
+	default:
+		/* Others already handled above */
+		break;
+	}
+
+	if (ep_trb == td->last_trb)
+		td->priv_request->request.actual = requested - remaining;
+	else
+		td->priv_request->request.actual =
+			sum_trb_lengths(usbssp_data, ep_ring, ep_trb) +
+			ep_trb_len - remaining;
+finish_td:
+	if (remaining > requested) {
+		usbssp_warn(usbssp_data,
+			"bad transfer trb length %d in event trb\n",
+			remaining);
+		td->priv_request->request.actual = 0;
+	}
+
+	return finish_td(usbssp_data, td, event, ep, status);
+}
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -1536,8 +1829,311 @@ int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data, unsigned int trb_
 static int handle_tx_event(struct usbssp_udc *usbssp_data,
 			   struct usbssp_transfer_event *event)
 {
-	/*TODO: implement function handling transfer event*/
+	struct usbssp_device *dev_priv;
+	struct usbssp_ep *ep_priv;
+	struct usbssp_ring *ep_ring;
+	unsigned int slot_id;
+	int ep_index;
+	struct usbssp_td *td = NULL;
+	dma_addr_t ep_trb_dma;
+	struct usbssp_segment *ep_seg;
+	union usbssp_trb *ep_trb;
+	int status = -EINPROGRESS;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct list_head *tmp;
+	u32 trb_comp_code;
+	int ret = 0;
+	int td_num = 0;
+	bool handling_skipped_tds = false;
+	const struct usb_endpoint_descriptor *desc;
+
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+	ep_trb_dma = le64_to_cpu(event->buffer);
+
+	dev_priv = &usbssp_data->devs;
+
+	ep_priv = &dev_priv->eps[ep_index];
+	ep_ring = usbssp_dma_to_transfer_ring(ep_priv,
+			le64_to_cpu(event->buffer));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->out_ctx, ep_index);
+
+	if (GET_EP_CTX_STATE(ep_ctx) == EP_STATE_DISABLED) {
+		usbssp_err(usbssp_data,
+			 "ERROR Transfer event for disabled endpoint slot %u ep %u\n",
+			  slot_id, ep_index);
+		goto err_out;
+	}
+
+	/* Some transfer events don't always point to a trb*/
+	if (!ep_ring) {
+		switch (trb_comp_code) {
+		case COMP_USB_TRANSACTION_ERROR:
+		case COMP_INVALID_STREAM_TYPE_ERROR:
+		case COMP_INVALID_STREAM_ID_ERROR:
+			goto cleanup;
+		case COMP_RING_UNDERRUN:
+		case COMP_RING_OVERRUN:
+			goto cleanup;
+		default:
+			usbssp_err(usbssp_data, "ERROR Transfer event for "
+				"unknown stream ring slot %u ep %u\n",
+				 slot_id, ep_index);
+			goto err_out;
+		}
+	}
+
+	/* Count current td numbers if ep->skip is set */
+	if (ep_priv->skip) {
+		list_for_each(tmp, &ep_ring->td_list)
+			td_num++;
+	}
+
+	/* Look for common error cases */
+	switch (trb_comp_code) {
+	/* Skip codes that require special handling depending on
+	 * transfer type
+	 */
+	case COMP_SUCCESS:
+		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) == 0)
+			break;
+
+		usbssp_warn_ratelimited(usbssp_data,
+			"WARN Successful completion on short TX\n");
+	case COMP_SHORT_PACKET:
+		break;
+	case COMP_STOPPED:
+		usbssp_dbg(usbssp_data, "Stopped on Transfer TRB for ep %u\n",
+			ep_index);
+		break;
+	case COMP_STOPPED_LENGTH_INVALID:
+		usbssp_dbg(usbssp_data,
+			"Stopped on No-op or Link TRB for ep %u\n",
+			ep_index);
+		break;
+	case COMP_STOPPED_SHORT_PACKET:
+		usbssp_dbg(usbssp_data,
+			"Stopped with short packet transfer detected for ep %u\n",
+			ep_index);
+		break;
+	case COMP_BABBLE_DETECTED_ERROR:
+		usbssp_dbg(usbssp_data, "Babble error for ep %u on endpoint\n",
+			ep_index);
+		status = -EOVERFLOW;
+		break;
+	case COMP_TRB_ERROR:
+		usbssp_warn(usbssp_data, "WARN: TRB error on endpoint %u\n",
+			ep_index);
+		status = -EILSEQ;
+		break;
+	/* completion codes not indicating endpoint state change */
+	case COMP_DATA_BUFFER_ERROR:
+		usbssp_warn(usbssp_data,
+			"WARN: USBSSP couldn't access mem fast enough for ep %u\n",
+			ep_index);
+		status = -ENOSR;
+		break;
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		usbssp_warn(usbssp_data,
+			"WARN: buffer overrun event for ep %u on endpoint",
+			ep_index);
+		break;
+	case COMP_RING_UNDERRUN:
+		/*
+		 * When the Isoch ring is empty, the DC will generate
+		 * a Ring Overrun Event for IN Isoch endpoint or Ring
+		 * Underrun Event for OUT Isoch endpoint.
+		 */
+		usbssp_dbg(usbssp_data, "underrun event on endpoint\n");
+		if (!list_empty(&ep_ring->td_list))
+			usbssp_dbg(usbssp_data, "Underrun Event for ep %d "
+				"still with TDs queued?\n", ep_index);
+		goto cleanup;
+	case COMP_RING_OVERRUN:
+		usbssp_dbg(usbssp_data, "overrun event on endpoint\n");
+		if (!list_empty(&ep_ring->td_list))
+			usbssp_dbg(usbssp_data, "Overrun Event for ep %d "
+				"still with TDs queued?\n",
+				ep_index);
+		goto cleanup;
+	case COMP_MISSED_SERVICE_ERROR:
+		/*
+		 * When encounter missed service error, one or more isoc tds
+		 * may be missed by DC.
+		 * Set skip flag of the ep_ring; Complete the missed tds as
+		 * short transfer when process the ep_ring next time.
+		 */
+		ep_priv->skip = true;
+		usbssp_dbg(usbssp_data,
+			"Miss service interval error for ep %u, set skip flag\n",
+			ep_index);
+		goto cleanup;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		/* needs disable slot command to recover */
+		usbssp_warn(usbssp_data,
+			"WARN: detect an incompatible device for ep %u",
+			ep_index);
+		status = -EPROTO;
+		break;
+	default:
+		if (usbssp_is_vendor_info_code(usbssp_data, trb_comp_code)) {
+			status = 0;
+			break;
+		}
+		usbssp_warn(usbssp_data,
+			"ERROR Unknown event condition %u, for ep %u - USBSSP probably busted\n",
+			trb_comp_code, ep_index);
+		goto cleanup;
+	}
+
+	do {
+		/* This TRB should be in the TD at the head of this ring's
+		 * TD list.
+		 */
+		if (list_empty(&ep_ring->td_list)) {
+			/*
+			 * Don't print wanings if it's due to a stopped endpoint
+			 * generating an extra completion event if the device
+			 * was suspended. Or, a event for the last TRB of a
+			 * short TD we already got a short event for.
+			 * The short TD is already removed from the TD list.
+			 */
+			if (!(trb_comp_code == COMP_STOPPED ||
+			    trb_comp_code == COMP_STOPPED_LENGTH_INVALID  ||
+			    ep_ring->last_td_was_short)) {
+				usbssp_warn(usbssp_data,
+					"WARN Event TRB for ep %d with no TDs queued?\n",
+					ep_index);
+			}
+
+			if (ep_priv->skip) {
+				ep_priv->skip = false;
+				usbssp_dbg(usbssp_data,
+					"td_list is empty while skip "
+					"flag set. Clear skip flag for ep %u.\n",
+					ep_index);
+			}
+			goto cleanup;
+		}
+
+		/* We've skipped all the TDs on the ep ring when ep->skip set */
+		if (ep_priv->skip && td_num == 0) {
+			ep_priv->skip = false;
+			usbssp_dbg(usbssp_data,
+				"All tds on the ep_ring skipped. "
+				"Clear skip flag for ep %u.\n", ep_index);
+			goto cleanup;
+		}
+
+		td = list_entry(ep_ring->td_list.next, struct usbssp_td,
+				td_list);
+
+		if (ep_priv->skip)
+			td_num--;
+
+		/* Is this a TRB in the currently executing TD? */
+		ep_seg = usbssp_trb_in_td(usbssp_data, ep_ring->deq_seg,
+				ep_ring->dequeue, td->last_trb,
+				ep_trb_dma, false);
+
+		/*
+		 * Skip the Force Stopped Event. The event_trb(ep_trb_dma)
+		 * of FSE is not in the current TD pointed by ep_ring->dequeue
+		 * because that the hardware dequeue pointer still at the
+		 * previous TRB of the current TD. The previous TRB maybe a
+		 * Link TD or the last TRB of the previous TD. The command
+		 * completion handle will take care the rest.
+		 */
+		if (!ep_seg && (trb_comp_code == COMP_STOPPED ||
+		     trb_comp_code == COMP_STOPPED_LENGTH_INVALID)) {
+			goto cleanup;
+		}
+
+		desc = td->priv_request->dep->endpoint.desc;
+		if (!ep_seg) {
+			if (!ep_priv->skip || !usb_endpoint_xfer_isoc(desc)) {
+
+				/* USBSSP is busted, give up! */
+				usbssp_err(usbssp_data,
+					"ERROR Transfer event TRB DMA ptr not "
+					"part of current TD ep_index %d "
+					"comp_code %u\n", ep_index,
+					trb_comp_code);
+				usbssp_trb_in_td(usbssp_data, ep_ring->deq_seg,
+					ep_ring->dequeue, td->last_trb,
+					ep_trb_dma, true);
+				return -ESHUTDOWN;
+			}
+
+			ret = skip_isoc_td(usbssp_data, td, event, ep_priv,
+					&status);
+			goto cleanup;
+		}
+
+		if (trb_comp_code == COMP_SHORT_PACKET)
+			ep_ring->last_td_was_short = true;
+		else
+			ep_ring->last_td_was_short = false;
+
+		if (ep_priv->skip) {
+			usbssp_dbg(usbssp_data,
+				"Found td. Clear skip flag for ep %u.\n",
+				ep_index);
+			ep_priv->skip = false;
+		}
+
+		ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_trb)];
+
+		trace_usbssp_handle_transfer(ep_ring,
+				(struct usbssp_generic_trb *) ep_trb);
+
+		if (trb_is_noop(ep_trb)) {
+			usbssp_dbg(usbssp_data,
+				"event_trb is a no-op TRB. Skip it\n");
+			goto cleanup;
+		}
+
+		if (usb_endpoint_xfer_control(desc)) {
+			ret = process_ctrl_td(usbssp_data, td, ep_trb, event,
+				ep_priv, &status);
+		} else if (usb_endpoint_xfer_isoc(desc)) {
+			ret = process_isoc_td(usbssp_data, td, ep_trb,
+				event, ep_priv, &status);
+		} else {
+			ret = process_bulk_intr_td(usbssp_data, td, ep_trb,
+				event, ep_priv, &status);
+		}
+cleanup:
+		handling_skipped_tds = ep_priv->skip &&
+			trb_comp_code != COMP_MISSED_SERVICE_ERROR;
+
+		/*
+		 * Do not update event ring dequeue pointer if we're in a loop
+		 * processing missed tds.
+		 */
+		if (!handling_skipped_tds)
+			inc_deq(usbssp_data, usbssp_data->event_ring);
+	/*
+	 * If ep->skip is set, it means there are missed tds on the
+	 * endpoint ring need to take care of.
+	 * Process them as short transfer until reach the td pointed by
+	 * the event.
+	 */
+	} while (handling_skipped_tds);
+
 	return 0;
+
+err_out:
+	usbssp_err(usbssp_data, "@%016llx %08x %08x %08x %08x\n",
+		 (unsigned long long) usbssp_trb_virt_to_dma(
+			 usbssp_data->event_ring->deq_seg,
+			 usbssp_data->event_ring->dequeue),
+		 lower_32_bits(le64_to_cpu(event->buffer)),
+		 upper_32_bits(le64_to_cpu(event->buffer)),
+		 le32_to_cpu(event->transfer_len),
+		 le32_to_cpu(event->flags));
+	return -ENODEV;
 }
 
 /*
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index f1cf120a2f54..8512ef727b98 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1689,6 +1689,9 @@ unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *des
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 		struct usbssp_ring *ring, unsigned int num_trbs, gfp_t flags);
+struct usbssp_ring *usbssp_dma_to_transfer_ring(
+		struct usbssp_ep *ep,
+		u64 address);
 struct usbssp_ring *usbssp_stream_id_to_ring(
 		struct usbssp_device *dev,
 		unsigned int ep_index,
-- 
2.17.1

