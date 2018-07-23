Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7657DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DD620852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="k9h2T9N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DD620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGWQER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:04:17 -0400
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:35072
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388410AbeGWQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBX4l3cRuACSUgIcuhst4CNhOnk1d7g16GIMo3BLE0k=;
 b=k9h2T9N/RuIhrIZhdLY3B+F9JXoe3r6Fy1fFpswcSUy4V2lQWFzgS/G08ElXl2+zX+66QBtZM90C7MZLaCjszeGzMxKKOIGBwp2aNH3To8ez5LIf05jjDU0ZKXbWmV6+NDfkSEGwtDbwNbv+ttq8InN6AG1b+Be4F3F/Gpc3M0w=
Received: from MWHPR0201CA0021.namprd02.prod.outlook.com
 (2603:10b6:301:74::34) by BY2PR02MB090.namprd02.prod.outlook.com
 (2a01:111:e400:2c1c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.21; Mon, 23
 Jul 2018 15:02:27 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR0201CA0021.outlook.office365.com
 (2603:10b6:301:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Mon, 23 Jul 2018 15:02:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Mon, 23 Jul 2018 15:02:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43473 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcLy-0008L7-2t; Mon, 23 Jul 2018 08:02:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcLs-0008VL-WB; Mon, 23 Jul 2018 08:02:21 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6NF2JEm013277;
        Mon, 23 Jul 2018 08:02:19 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fhcLr-0008Uv-ED; Mon, 23 Jul 2018 08:02:19 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 8D757121479; Mon, 23 Jul 2018 20:32:18 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <manish.narani@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <jic23@kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency value
Date:   Mon, 23 Jul 2018 20:32:01 +0530
Message-ID: <1532358123-23485-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(106002)(47776003)(16586007)(76176011)(26005)(42186006)(316002)(110136005)(54906003)(186003)(48376002)(50466002)(336012)(426003)(6666003)(11346002)(446003)(2201001)(51416003)(50226002)(2906002)(90966002)(106466001)(52956003)(476003)(126002)(486006)(2616005)(44832011)(14444005)(5660300001)(356003)(103686004)(81166006)(8936002)(305945005)(8676002)(36386004)(81156014)(63266004)(478600001)(72206003)(6266002)(4326008)(36756003)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB090;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT027;1:wYH8gwgvEGaCadvvkkZTuCIRPkXSlpE/eFVDtH1hSjVtFdC21r7rkVWpjyfpyDUe7TYUueKBjCJuQIuQU0PAlRF8zR9m/cB2aUv6vGU9xXoIbIASC6zMXLEkaXFx3CFq
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feaf4de1-1b31-4921-c32f-08d5f0ad4e10
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB090;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB090;3:9I2Scsa25W3gyADfLmeV4Fbk3SHtYVmlXfR/emR2THa+ykaCzrzzw76Q05SzKs7kr+6J2ND3zEMmzBIXwuMsVxSU8hJ/xM4LXPd8pgmCcDYwZ28QAwu0eQYnr20KY7RYJ6bsCmBFpJ4k351bFBrJWAmaoXv+j39nMDJhcMUuEoe/8xz38wWpsB/PqiSEF//KGrBEJF6kXKYihAHaGLOS9WQfYkjNmD11FlWlSY+Ecq0b+Vtz+Q1M2W/CbRVOa4X/1agal0R/fdzZCci0BuuJlvUCb+xXvtwxvnQzCDLAt62YFuuv8zT7xGpo3EJptTwu/XOlMtXfTdle7NdI/GSBzRAEnjQHP9rIAFhaNP1Aokc=;25:q49QTCAcUwUMlUoVZyXK/wOaSS+6Am1H2rr4XlHd/a6lQmQ3SzMbBDrP3U3/sk//YOy14n9efXskb/nxU/FzJN8MOah9jQNFJxP43+Ww5g4U7AfaSj6FMW9Sdcdn/d0tZE4sMpiswuupU/8Xn9rPqVZe0Ku1PcWtTWXCupoyY5mI9HI72wglagYKBkX/5QKsLmtWWRMObtr+oU9ltriKgY9Z6moiHAJYfm3zs1mBCRi/HciFccroorLG7W2P7Qaslo85b3z0oiycjKAhKPFs19gPfrEg15M6OvlA4gDuRFHUsRPO+uGhtYTgPd106EOoO9KO0jK9mGK1w6/bxj2rzg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB090:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB090;31:NkAL10hAPeU5npOrTYpgLqGITuKZzkFqWbAOvfVdQBFlptdMgT7XdbeMfRRAYqzGv9fRVAMW4cT66OlYurpTdhSDep5JJAI9Z9LREPJV6/wRXB7mTiQQvphLtF2inf5kH9/+wQLrwacBp+68sLZlQU6DZh8pdhtPs5gUgcq/OHxTVXY+1ccFOFAUzIrUG9fXZ9yD+m0ZApjPJ0b/R1BTvtheD74lew/nS33cXt7n668=;20:VexEaJ3r1ICAE5ygljnZXeNKs1XBghceWPiViDiVUi5HIGvsEQhzb2Ac5tg17Kya776YFCBbj0ffbbtUuqAISfmI/OHSD/6971k4DaFl4YgBDCR/DyjTq8boRQBNpFAGc/BStieZC+vQfJWzAC29urphDmY0d6FrsXp4c20W7zwLWaPrQrGDUPyI7u9XtrXzzcQR0EiSAoAXuTy5l7Yw+W9z/9TUsuHUKb/GFcR8EjmX4LmJD3Zwy5o/L00NhluLKvY6z2vm4zx3Y1Qaj0uICAkEyw+HIOmpcYWsr7d1VeYfmQZK4LlZ63qx96r+Wy+bI2Ix1SGQ6082ig/h96hJSAqrGKm81TSP1D6AV8pTp04e0e6LF0eQBwfGvvgndMIay7IHYe5AnYatGUd9K6E2SRTdsaHiewh6LpiB01nekktCSTPcRB2XICcsyH5xEWzT5NZZYkdL6g9f43fUmr9CNxwMlvKeM0xKKc0+7qauqlWcdOZmQgxQdOcUSVQfOs0f
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB09001885728432B9D87E77EC1560@BY2PR02MB090.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB090;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB090;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB090;4:Au9es/h9X9QF3wuPXFb1SmtKNyQlvt5voZ2hxy59lfpKQ+YYR8gGRoNIJv0bQ9TluTv+u66FaOdHCK4tFX8Fq84xHAmsV3tpVBa68P7IWynVUHRMvgnTMHiuMCdwlRpKKj97uDQs6asjFe+76N4iO+SbZE9VjJGz/YeIVJUfXQFuvfqP72un21lqnlmjhiavwnchVZrxwNedDYBcuA76dog/Xs6iLHi1IOHjax/+qD9uRtN/Io3GF9xC8HGXQLoffuOBRVSuSLJ3LyDVY9jCDHq0JzaS9f9xdt3Ph+JPT5FFcxnf258cbymKvZPIhvW9
X-Forefront-PRVS: 0742443479
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB090;23:nKA8U+ALs16Clr8ClYUNE4NwUFqtPTE0wrVUn0zyEx?=
 =?us-ascii?Q?GWxaT7Gf55afDttkWpcjRR9GYSN9PisyeqKlwxeyNvvl6CCcDX6hPJmpm/wu?=
 =?us-ascii?Q?nVrAk6+vhuJcjHRwajE/5UsZilSntQ+iKP3EnQLm5o/ym1rWwryakAW3UcAV?=
 =?us-ascii?Q?Ay5VpiiIhxA1UW82TSWctKdSzLdRYL/T5fSV6Ht6y5/CyxjSbLfg8GhnLLQH?=
 =?us-ascii?Q?Yqvk1dMyWqjhqCz7nWEjiAax6kKwscVr2dORJcLC246T1amWEWF0prAqVzdu?=
 =?us-ascii?Q?X5tcVdR5CskgewpNjXN+v84OpRyksAPzsmwPHkBvIJDKErhz2TonwNdgWuLj?=
 =?us-ascii?Q?ClWtm+85cKhJTI66NwLc1kb1cykq0GrfKAjp44REuN2Zbt7OyEblKNAuMcgC?=
 =?us-ascii?Q?lkaGCpyNSnsmswyVUoz24Fcc/FAv9NATYJcDM9Qps7ArhCiAB6nPouYT2Y/Y?=
 =?us-ascii?Q?+8TUipNZ7Id1Y5GBPnFmVp2Z2TSGJvSdEQmCd9VHcGqWiQTWsSjVs4aCZC96?=
 =?us-ascii?Q?h73uv5L5froDFiBxV7/7ywG1q8YtV0aJnZRLeuQhnPUO1xE20tRWhelaYK63?=
 =?us-ascii?Q?tW8eOqhIxb1VGRl9Uk0KsPYMkqaice4Mow4c7A4ZlYQQbw0DmqyiSoZgBGsK?=
 =?us-ascii?Q?v3DyH8Ifmg8x+v4Po73dHtS46Fj2ZFpIGObImFjbtdB0LUlm/UN4UDHT4fnT?=
 =?us-ascii?Q?EJelhh8RBMkJj/tGM980L2eX250YqYFXkJVPgSrf9+EBtRLvxd0hz9fukwHN?=
 =?us-ascii?Q?Tn8Tj2+QhQb5dHFKL5bRHA/nXJQeuHizL5aiqCQCbMPAGPsN1aneIxtAWCoq?=
 =?us-ascii?Q?b2qBbIDYzp6/XkqF8Q1ekF2t91HcLoIkndrAAW8HKfRFh/AvUkWsCcZruavw?=
 =?us-ascii?Q?LqTPH+6ZLMVL9CGSyitaS6nROnnS7BQnZcpHyOL1tIDr6M/wnkK4mkuaKS88?=
 =?us-ascii?Q?rZ7bYgfBCuwtAE/VQhfqMEzL00ErpvILooaS/i/Mli9DvN3MJo9BdTmkPMiT?=
 =?us-ascii?Q?W2YkxxyI35/Ek75XLP4c60YA5d4hN0qPWxMn+56vjHujbK6+3jLAJHXb1BHM?=
 =?us-ascii?Q?pXTFwAT2Bchfea/iOEinRLtsOZcYef1gKxHAhET9f2oStHobRpujAvceqPy9?=
 =?us-ascii?Q?58e5tFtkdLRWvvrLVa1uUKNpvs5JTJJxJQTjcjMJ5CAXiIK6YCTPQeVm6118?=
 =?us-ascii?Q?RTFbIapIevUeLQeHm1O35MwcDYZSOTDG0GK3Gr0vxhCVE8ij77FFXh3421Kw?=
 =?us-ascii?Q?CbUa2L5SaxkVpMsHxDYhMNMMK0e8OjKhgQ+Sx4f9Cl2P9KkJx9aAofUjn/FK?=
 =?us-ascii?Q?8FuSqtB03tjJhBfUvE4QdR+LTCBdYTHqIgZLvqK8jH?=
X-Microsoft-Antispam-Message-Info: tIB2yExaA8D9vCpFarRfO8UXOMU00qen4X4MNIe3n6RyEoDq61HIl9qnzk7zmR6jJXfUduOFB1CppaZGti6730igt/EHbSAzI/7Y2Y+zIHORRmcZlnQCnniRJrka+tWnHOUp6rp21g4GZN0y94yDEYXLzt2K7YzVekz2S5WTDdoTk0EX+g3jxFk7MnKgeY2cHCFsp+7YlxrCqvtPgL+DEIF+bmj/qMs3Y7q6nBUWoAt+Kv3CH1Mon9PYXvUVo9JtogcNAjjvfL4EnkzK+v7WxNvCR86IRa3JPMpDXw/1RXAz8yVg70yHSJbbhMyac329JU8NJSQwiCuTSbl9urTpJKtmG4oVX15Hg9Ztr1knO1g=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB090;6:cdvyNs63DBsP7e9PLcCklZzbaigmmOrjVlafIqpMWJx+9S4zLbup0f7ybAk8nKdsfJvGMIKOwU/e252cFnysz6g8KUBJC+BBSZGksq7Zh53oQv1pvEBXPil/pS+Y+cDfW2lyDkTDbpyJ0Qq43YNPMuoljDe2VxiurzeoIhj8/YtN3Khxmei4A0+jageurN48ECLAc9PubarFuifoIHdhFs2o5AUVHlY1CilLX8xXYeIcCGzowWwpLMevY8AOsSytXjzTEzhSevvWlY4v+dELyO57fyBUcMnp9DxT4AM+d9V1AShTX/V5wJuXAZHsxxYzRiJe7W9Qz9ASQzUTSujYnJB62lzJDBglG5/ksDjHpWPgHaEM9yi057xvsLkps9aVNFCtcTx3a5OHZmTt1yaYu0tgW3MCdvtXj1y6biyr4IxG2wGcx3D/0WjR/xwh1wGl62zUgYa1pgD/vG64s8AG/A==;5:b2Pv1AHvYlw29jlxDXtiu9FwC1D/TYgdmjBsnowEWKmCXx5Qw7YO3rnV75EOpNTWw3bkw/DqNGpBQge/d4No1ENI5lnmYxQn//dn/Xzb+TSaWwU7Lxwr+1q1vybR9JDSpcRvKJ8uofmIwoahiiWreq0Ho77zDyqJobFK/OqI3HY=;7:l++CNFhNbp34Qtri17F+MqygvPZKQpTjG+zWhsQ3fzZOBxBU5pqLcT6Z1tSdU/hgv61PZO3Zxqi8I59gEcrXClfi0ll9JFMEghF7ZYpscDkp+gaCk4gCwZlZtpMgBn+Lqz9VOOdtKNi0cqY0EYgUtji9rsnKkZakvdpUj3BlMdOZyY4rVtclgqAkrprmHq2/M+cEyL3Qoai1uJjydaOktnyEZPYAZzBSGuRGXqFnRWkwIHA7tNydgYKIava3yzsY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:02:26.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feaf4de1-1b31-4921-c32f-08d5f0ad4e10
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch limits the xadc pcap clock frequency value to be less than
200MHz. This fixes the issue when zynq is booted at higher frequency
values, pcap crosses the maximum limit of 200MHz(Fmax) as it is derived
from IOPLL.
If this limit is crossed it is required to alter the WEDGE and REDGE
bits of XADC_CFG register to make timings better in the interface. So to
avoid alteration of these bits every time, the pcap value should not
cross the Fmax limit.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 23395fc..0dd306d 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -322,6 +322,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 
 #define XADC_ZYNQ_TCK_RATE_MAX 50000000
 #define XADC_ZYNQ_IGAP_DEFAULT 20
+#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
 
 static int xadc_zynq_setup(struct platform_device *pdev,
 	struct iio_dev *indio_dev, int irq)
@@ -332,6 +333,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	unsigned int div;
 	unsigned int igap;
 	unsigned int tck_rate;
+	int ret;
 
 	/* TODO: Figure out how to make igap and tck_rate configurable */
 	igap = XADC_ZYNQ_IGAP_DEFAULT;
@@ -343,6 +345,13 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	if (!pcap_rate)
 		return -EINVAL;
 
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk,
+				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+		if (ret)
+			return ret;
+	}
+
 	if (tck_rate > pcap_rate / 2) {
 		div = 2;
 	} else {
@@ -368,6 +377,12 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
 			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk, pcap_rate);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.1.1

