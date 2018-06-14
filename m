Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1DF69C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FE1208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ujk4RdO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FE1208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936138AbeFNS3g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:29:36 -0400
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:38628
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755325AbeFNS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL4iAhEb8WnCRtMCcMrTO8VhRxkUm3xnzqqZFS0wndE=;
 b=Ujk4RdO+K7wMVjFT5WJS+mPJ3ai1cIALq+LyEUdUVzY3G1tEIcqjhyEnP5Mh1sr+VKoWrA/fD/YSyvxomHG04rSIIsQVWzMTumZ6e+NPBmQzceEeLiP9zWPOFvNWmeCGlX+sKlSDd/bomPhxJin7pV+IMnzngRvPwwhFNXR0Ya4=
Received: from BN6PR02CA0034.namprd02.prod.outlook.com (2603:10b6:404:5f::20)
 by BL0PR02MB4339.namprd02.prod.outlook.com (2603:10b6:208:40::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.17; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN6PR02CA0034.outlook.office365.com
 (2603:10b6:404:5f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41023 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-0000Ah-5p; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-2L; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRtmb022831;
        Thu, 14 Jun 2018 11:27:56 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-Pa; Thu, 14 Jun 2018 11:27:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v8 04/10] firmware: xilinx: Add query data API
Date:   Thu, 14 Jun 2018 11:27:36 -0700
Message-ID: <1529000862-11510-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(39380400002)(2980300002)(438002)(189003)(199004)(316002)(106002)(305945005)(110136005)(7696005)(76176011)(50466002)(336012)(51416003)(8936002)(356003)(9786002)(48376002)(478600001)(72206003)(2906002)(81166006)(2201001)(8676002)(81156014)(50226002)(16586007)(36386004)(54906003)(59450400001)(36756003)(107886003)(7416002)(4326008)(39060400002)(26005)(6666003)(106466001)(44832011)(446003)(486006)(186003)(5660300001)(47776003)(126002)(476003)(11346002)(2616005)(77096007)(426003)(63266004)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4339;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT038;1:YygPtEZLXYLyA6viYi8TReUrq3nKvn/fVa5kpdIxtR/1fdCHphWyrwhGy/78g3FC1sh3h/IsLdg7pErE2o4kA2JUnGrwPfypFK60Bs2uPWO1QariJyFLVibdL4QTfs9Z
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0196f051-9679-494b-8d7d-08d5d22495be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BL0PR02MB4339;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4339;3:fGKWM+qePm3+67GX5ZWUvo6vczkTbd3FwQtDilOWF72xbaqTE9rCq6QfpFFHjxI3vSf6mraqSZBS0C5LoYLWvCzxVbUeKL2s3UljonC5jHb2LfgL7fkIpXWh4AlM0+H683u2r7MZJnpWGtOcpdcw1NH8dVMryugZwd0ag/zz5gCoUi0jMJYePQpOBCsOzl74EYONFvkXrbr3F4125RQTT7KxdmmA5vll1SpLQtyor5hG9ysBFbNzNuEo0x1NASY06c84erNCN4iAOZDz70PXuHalvszX8msLFpLwJvn7wTPmt9PXh7sJzQvC0JW4vKMZoTj3LlNvRPFNwa8+NDsioSZKi4qYp/lSe/hrcV9Oi+A=;25:IL0Ew4LUl5ruooNwufmn2nhfxi7iA/DRlY8Uc+FwUz78pe6KocVmuaHbx8fDmsZ0ugD2jJM7lC5NF9FPmGyw29japIfQfOyG31NZA6E3WY96WITH81UzdOBooMWhPJ5qwV3ADNyuKl4Gnrn17zGqth1eMw35Jv29AaYoS9R4NrNs+FRUbGfN2pNX/qMj+T0aS/GeBW/T87p9jDmNZjhX9hA+FPyxUMoqw3wCYGQ6FzML6IZ19v3tuVwAuqCExM15JSTM6HlnUAVYpglQFYmZq/3MTsCkp7TRRHNZmikJdgw7PBUxN1eLT5FKUaA+MkdEJIaNTT7zA1U6v/dv9tSkEA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4339:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4339;31:CK+aVnWzb6s1oJ0wwGGTQ6X1Y4ZP9bXaevTjGYMyJYcD0/w/nW6LNFTc4kGuJkQNV9K1Wzn8TI43QNgoBddT+174V+vokrPhoO1reGFFnNdYpND/IbnP6an+73KByB6qBr6AcFmSFzROB2tk/rFdeKgqe5tffbqagCj0BWl0lQG5KIElDVzRBQgs0vaANLbb4tTXp3PU+YBlMLE9BzxrQKmTkoGl6LDLq/ew1uJLbM0=;20:Qz9TG0Io4Uuv8nh3rmWI95uE8skl7ufOs4ju+8gcruo7MYl6n0UrffJJ84vP1XsqbYFnb4ZCP41+9dJLjNsEj7+q2qqCrbQsMo5cQVoyD/fZRI7HuxrYW3ZnUFm57UB8XgMeu2LuDMHKq+l4KvR4scC8HciGVpWLIkTkxhdMBDt7kNywSeMOaawroHY2bWGBBbsHnIkOmwAyR1oZ8hjl3GvnY+/DFW8dD6ujy4f5I4QmIqzcLr1kca0kjl80zekvKhf96FVhvQtYgBjEZXJQuvam5tOMyZ50NLGaD8AGKBTlOI7qcRR6rjssE6TKT26iUyE7DjImq2BpC3+F1eTr+hg59jxtpZlnkKVuVnGAxtLFOaZykmUNm1iuxMy8n2RLkOynriiEe3Aan8M237kWSFRAs2k5HBdtjdOSk6wiKb6176CWnXucReD3w6KJK1hA/rxiqH7BC6C6NbZmegkxjwWc1XVmbXTxsmhrOc7t4pA0xiSmNVVq1yJ+dIu0qBT0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB433928EF9055342F5CFE5A1BB87D0@BL0PR02MB4339.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4339;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4339;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4339;4:+W+In2XqEOdqY5GfNyXc8QjYT/TdHbOeWhaJmteK2lOQUX4v6HxwVwkW9q5WYbkrHR0Qh1qJAvKzW1qH5D2JaQDCSdc6PfGnux0J5v6Z985tsqWDtazYcsAQRpn+RncsIIlaL89H/dW5fepphNGojGfjfAnLPLff2lVDK67u6Zvmq/lxnjSVwbFp2DLnbDuQ7tkss9SitSDfxyEG4vRcBA8LPXH4CqgG+5X0mDom+4m5MlpsxrcDhzyxQAX5N7HPWBnfvX13D/WozqQYxebZzSr3UbWBkcdN+4yMKeGcdw8Su2pD/uMk0t9Xdw5fbJ7R
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4339;23:bx4CJ3JsP9puiMFAdTQSnia4AkScKi/4z61b71r/j?=
 =?us-ascii?Q?Q2uD2otP7bZ01WSX9e3bh+fEnzUj1nnWrcq5uKpL/BETe1eRsUGXbXdLtx4P?=
 =?us-ascii?Q?aJNFRUpzgUnswSTa2wWhO1+G0m3qlunGxDYlGMM5FloRGWqbS94IKh1u8Pvu?=
 =?us-ascii?Q?TtiHsBhpowGDO/vvk8PANrHjk0C62F2ycOtZqNqCS+4eJ9wosfExMlwfTG4w?=
 =?us-ascii?Q?1d3D1jeb4WzKJ0mIgIKEdr/GsIFSJUs21tomVKMR3R5AOLCA1a6XVb/s3Imv?=
 =?us-ascii?Q?zv6rtNq6r4DwBaGAQvbadF+ltO8ZMlKjVmrUubrOkSOkmGJAwjmRZgSWvHDS?=
 =?us-ascii?Q?I52VKJP9gYxyYIZRAPhBWqtaQbWyfXyZjBzzsfj7fJzmw/qlbGojgiiIM0Tj?=
 =?us-ascii?Q?Z75wejEqAH+cNfz/CBr0uAYyyT7ECXnGCO5GqFzPBixt4MYvrHbxa/JGYZ7S?=
 =?us-ascii?Q?U6NbNiIC90JbciPHCzCJvecy9Y0/VZKw614YPhAh0yYFw6Xt4/gs95cJvCe7?=
 =?us-ascii?Q?gJ8vcfWbTVr/vni7Ow9MF0GFQRssPOdf9osue/JyxUyzIm6btMaSrfIg64bk?=
 =?us-ascii?Q?2SixN6vSNBEjJwbF+0B/ZICkza9LdtsFJFE4Ul8psB6hFntDc0s7VYF/4xoA?=
 =?us-ascii?Q?H9SKP5DN5zkDVd32pUX/ZUMLqjKKBG1OR2UTATYBDWhffGO4f9POKCou77Ty?=
 =?us-ascii?Q?6HUL0U2P5pSV8+d81KlmBox+xFfIKeBM8LoLCM0rQLH2HxncAajxlRU3xMo+?=
 =?us-ascii?Q?1F0RSWhJPFlebh0FirH68o7nuJrOoroF0qR+4Rrm/eurQlvGWjU8X87w8A5q?=
 =?us-ascii?Q?Jtx1ehHYVzQ1kbfN2sw4rUFJOzhRNKAHMOt0mpiliMf0K0738nYfg1Hk3bgz?=
 =?us-ascii?Q?+xxUsA7wIuAio24PgeByQwl9QvsbtulcPS2nwwasJ9y/gfvIN1zMLzHp445t?=
 =?us-ascii?Q?x38UHEfyPgl2Qfkqt8c2Z9g8k4XW0E4xlEeKZW7SuWtfKnBwD7e6x2Diimwe?=
 =?us-ascii?Q?7x2UsslJ4u72eedyqDu+IaxRnthdguviGGJyBwUrDenaJusExO+tKk280bhl?=
 =?us-ascii?Q?27UFgg8gddGRFUFtrj0T8yrM3goeaHUEOhmASRytjuG7o13KXqO1e2Hs3idp?=
 =?us-ascii?Q?h8KGyy23akFwt6BqCqWKmGyT/VtBUL8gCWrpedrZBqeTLBQtUHEuJtFKiZKe?=
 =?us-ascii?Q?xK3hoUkcYtApNtrG1gJaVNlHMX7F1Ept+tr4K4RLYp4GkNbIWFpLZLZ7tyEN?=
 =?us-ascii?Q?B7GJZUwTiVKALUoCkv9lYwZmFGmLgTijupWqwvvTi8Jrbf9V0MbbK9lmrj7C?=
 =?us-ascii?Q?hrE159vtawufSCG41fQwBk=3D?=
X-Microsoft-Antispam-Message-Info: 8XxgR7otq3EmRCp4A8ZILPh8c/sOE8Ooov++R7lhDdLW+fn1tWslASzfC0WzeLI8W1bLz70vXjIG5mQB8dwKMxZRNdSGDETQyGsDtpTiOVZseTWg7FoGcu+pTbr3gW8lQHbbCBE50NZo/eSpc1XiJj9Vwq+PVwu9G/Ci9epVYUCKv6hNmfSpe08A8qJrIdsh
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4339;6:sHVjUASgxQOD7ae4sr6a/+SpgWVGS8qNX/68+xyATCY7hlHTCvZ4xdju3fufJQ06HkD68P0N2itZrlvTJ6fd4E3MnjyQhmjWtqBrmdBf4/5VDjItiZQXX09IBEoUGAS1IeNDFdUbK8gP8ZVzUELJV1DxvEDNSQe3eB7h+5hHDO6kvnwfuwzcP9eYT19oT+e/pb0PMH0qSGebvxFoPecdRbgJj1FIRnW+Jw1KZ2eURFFUWqofUR+oUGsbKcMXtnIhbTd7nrkurEelI4KBNmf3NUHUjfRM3SqvlxeBXsoLlcXEbazUyYGIuVSkIF5WxUAEiKfI8Pu/HvguWsYijxF18BwsC5lyScMzuI74UwoFYA4On6S0YckGVFBh42dYHk7jeOTNLmW8oUJj3kgDJCaltxbhkGKFcCOkwFFS4603ySoOt/g9CM8FE5RrxN/L7cHxWCW7AR8//Kh2ulUja1QZGA==;5:1Xq9c9Df+znXzOsD4ssD5E1+aE4fG3N7vtFSYB3DG67gBjn2qWSFj6SYEZuMJn4uKMbSwIX84O9I5ffKrOWWzNeO9st54oSELoZFbTEBFkMnsnLoZxvfwW3gqe82/lEWXTpVcmqSSYeiZlKGGPsfBRuf07dkDEmf+u0AWjofRXA=;24:FZmyWMt1jPzeT0ZwJQeQhN+pxtxv2e+5h7dQvNNMjBJRkQ9DaQohjgwa7EmoO2NP0xzzHfDKtCLOn17Ti+de82zcYv6oVXxrTOpv1dPlyHI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4339;7:Jy1lkcaT4smEGXT3bCN3WwxKCJkD/JOunsJ1orngwYLqYcWDApZoDDLQLSuEsNXyHd4bvIiJTd60Yq1jOXmL3lmex6pZ2890OcAbuidlJTW433pOa0owfyvOa5bpiJgvW4pyyalcw2W1DUIZVK1Ig96GP7LQZgi4/IEW+NHN3w7T2IgjTa8vrRZcU62vPq24M9nIdts8CcV5N3zxkzkc7kKPQkx6ZcqfCwbAe4mPM/au4/Crf8iIEBPQ0Oi586eN
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:10.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0196f051-9679-494b-8d7d-08d5d22495be
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware query data API to query platform
specific information(clocks, pins) from firmware.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 34c5ad5..86d9bb8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -260,9 +260,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_query_data() - Get query data from firmware
+ * @qdata:	Variable to the zynqmp_pm_query_data structure
+ * @out:	Returned output value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
+	.query_data = zynqmp_pm_query_data,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2eec6e7..354385d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -35,6 +35,7 @@
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 };
 
 /* PMU-FW return status codes */
@@ -48,9 +49,28 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_query_id {
+	PM_QID_INVALID,
+};
+
+/**
+ * struct zynqmp_pm_query_data - PM query data structure
+ * @qid:	query ID
+ * @arg1:	Argument 1 of query data
+ * @arg2:	Argument 2 of query data
+ * @arg3:	Argument 3 of query data
+ */
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

