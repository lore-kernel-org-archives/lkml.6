Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52EC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D78D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Vo7d4p2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D78D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeFTRmT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:42:19 -0400
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:5536
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754728AbeFTRlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjlQDjYGCQLv94lgYwW7ASkStGE9wm5eiuKy8hKUcuE=;
 b=Vo7d4p2cL3KqI/QVhtWc8wdN9D0XQ9jqYRF6zPMI/UVioiZjJmDDg1Ufs6AcFlYAF37OGwed/af6ry7hWMm5AF5Noknrj0eeBYB68xeZ6+zdesKhz6OQEs+BGrXB55J4br0gDsFe4fzo0KgZDCYtMUQNV6mo22eYfBk9yBo8/fw=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by BLUPR02MB163.namprd02.prod.outlook.com (2a01:111:e400:849::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.863.17; Wed, 20
 Jun 2018 17:40:58 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0002P7-B2; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-7o; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHegt0027149;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh62-0004hY-7M; Wed, 20 Jun 2018 10:40:42 -0700
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
Subject: [PATCH v9 09/10] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Wed, 20 Jun 2018 10:40:34 -0700
Message-ID: <1529516435-7315-10-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(11346002)(59450400001)(7696005)(51416003)(76176011)(426003)(336012)(72206003)(63266004)(106002)(305945005)(16586007)(8936002)(50466002)(446003)(356003)(48376002)(81156014)(81166006)(316002)(36756003)(110136005)(106466001)(50226002)(8676002)(2906002)(77096007)(47776003)(4326008)(186003)(36386004)(39060400002)(9786002)(2201001)(486006)(44832011)(54906003)(26005)(478600001)(6666003)(2616005)(107886003)(476003)(126002)(5660300001)(7416002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB163;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT009;1:nC/bIrRcxryZm538QDW6pEGcU1bdchCi3gHojxzlWl+yeP6F6dbpEh0J8GRY6AzwRyla7h14oLAxNuemudfuieTtx+Fhf04XdWprMnF8Pm1Na8/0QS+g1Z2Npinsaw1J
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8090686-1241-4364-073a-08d5d6d4fae3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;3:24SiiynqX2uJTfVs9U2XEY+OdYIks5MGpOVudPVnII9e7bdDyLOz4FJlMA7itFKDee4fw4yN1pnNoP6TsJDR7njc6h8pvssD014fgFj4iMVHKRap9wWMhmRYEa47rFSEFxzOVjroTAnb8LHdjDZ5af7R+fFRB7GrexyMFFYp2s1AsK5JjjQ3l/JbHc6TVs8wOW0Fpr6nX1w8xplA2UwDINnxSLQLlpBRd6hcCOn1aGEYEFSqpmziQ2ilUNWwrNXdL0hsmRXa7EZ4qQtdcMLuiWQqE/qdVRpr06U8F/d9itXbV8E2BjSbDQuPi/27fLw2GxZt0Ux0xFBE3mtLMS5blXEFePWtl36dD62AUeWFYz8=;25:eJ9tx6Zcw8CyKe0Pjqm8+ZPj9F+13jVeUXUlUtmz6Xj2lqfxcrxd1Stt/+BjcAWdNkC4MOvT8N7IjxZR7NN53VchVWTc/DsWPsg0FFJMFs/ceUjQWYzs3ehQZLNtR+eEUngvpdnrAesI9iZ6t9CxUk2updhGfa6C4iU7AYDd5eJiQaoO6ygII8LEyXaambDN3khHoh66IOSKhsacEAUHALbFCVZI1U6yGOLEHq3RFojE94q8YZy+jjBOvpWsfsMoCUbQbwDP+3OQBqPJxoPLKx0E1Lfepmb/dpS38p8jSKi3TkA86JZtq4yBeWAimy/CY0ASvCvUQb7agror/PVXpw==
X-MS-TrafficTypeDiagnostic: BLUPR02MB163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;31:0xEciaJJdkQmgc3O7YhEUYd4Pib3MQNE9ZuAO+Z2x44u2PPcOBaYDovXYQoG4HnEv1yNP+GpOYCpkCd3icJNDU3vW+32mYxT2IFr8pOes6/mKhV7CnaYcXFiFkOX2o6G/4A5qRd6OLMm1v9hRPAxOi4R5/tJMAhAt5Ye0V6C+X6CQXshJjrBEK4aVYsFLiKHi2Xs8skHOJWbZGatUlSPZS2VoJKUxdu2z2wag1FAcJY=;20:jkMyWt06EN5UQJudMeLnZ/vl32KbsJO3/5kd77c5eCTEVKvYp+xdu6Lp/S2GC8jiP/XLQQLOhwwIBjYs1Uz1buf1pxM6M4K7BeyRmtZ3GXEJELxvJUBQ4GzpC5wG02ko0TTu4zGKtEq8K+1+jgIQ04rD3FrGhH5cq3rCCrluGp7r1+VnfXr/WoFdDgCvqpJf10gHc9XakvEHM0n13RDhZA5753B4wvrqBrNSXN6RJa/oPdhHgWDDs4q6HuaCvKaLfSQzAtu2DA6VhAXYOA3lQJkDk3vKk4JfK9Qrvk3fVEVX2g/RX0Rf+3sbSba5JpxmfKGiohHbtJJTdC7KAz8GkSBR/z4/c5lPpT+nrxt25DzBVoJ1WFioNTmMkg9oTbuKAfW5WJAXeeBUCF6mgHTZKCWcRzy6ZNYec0DV8IgDrPEesfIG/99mx5AvXBISzaNMoJPDLjGBqj/c2NK5iLaVLCLqO7qOKn1aDveY7o4KjMLKXi2I2aTilxRqlzJ/KlCN
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB1636E55E5A329A206C19B22B8770@BLUPR02MB163.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;4:GTn614oyHagVM76HKm1eicXWbGvyb6IqwOTyYNP2EsvI3/g5chhEsrdD5D7hhIOdmyy5424gmjptKbDO7cWruRyjjCBwkGS3XWsUis6ikwSB+/TGuhiT6Wfq0fG0k8isD607BY5uaSdk/nZZmmvSQBUGr3loV7eVo/LBPROg3PNSwVzr3Noh3vGxFFStAPBKV+KKO5V4zVaEMNRqFJ94BRNEUw49oRhafLd0492fUy+cQC3j1Y5Ezp1xVlhKoJ+JKGJlNE5YBkDHHGU5418c3mQVw0PoWDDFgukUyc6h064ULhaD9/BXVS9FGqvtXMqy
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB163;23:3oderzxyl4FEXKLaO4OR2T0XzoaWrXMvGCcZRZNya4?=
 =?us-ascii?Q?YRpshQpCQZWAp+oXXTVGkQYrOqsCjAqa5EY7YpWUTcaRDAk3Bzv2XbsYZVgn?=
 =?us-ascii?Q?Rdbj31ZD+gvagGJyGFvmI6kbhdEiGEOxKjfITQfJhaUpls3JmlfhPTVvW4Gq?=
 =?us-ascii?Q?85YBxnEqbYyP2lYsidTX0aCh8CK96k6Z95ibd05tjunS744TyqMaD6Njp3+w?=
 =?us-ascii?Q?v14ynRv88wuOcbQjCSo1ch5JsFIeWqRsOz1cNJWTgV00rrRux2HUr3BfBtTa?=
 =?us-ascii?Q?HzJI6802mY/tUWqXCG3mYnmk/SUSkzdOsJIA6kwrbgjC3DmJtZSxuaxpjA5j?=
 =?us-ascii?Q?cKrybIkckykHdgdmt3kkTayE30ep6R5vN150OVtkoqjHeHIchKZrjYoL+8RS?=
 =?us-ascii?Q?MPIqozs/1EzCw6sbUIGXjTRnrV1XC+SYAlATTOmqUGjrfq7uT1RP1eTl0Gix?=
 =?us-ascii?Q?DqueijXuL2x9BjlOhIWn681n2FwY4AmspvljjaYIeRpSyR3oWEn8LkR2D0E5?=
 =?us-ascii?Q?3nDLoM87aMswR1aGJQizmRqj33ohZ5QiUz9r3+BBWe/CJh2f3s3Fw8cyKxN3?=
 =?us-ascii?Q?ObSOB07VtmS7047RZR2zanh+gJvLb2x5jvs4L8gMnsqQ14xh2ZUaso02B3d3?=
 =?us-ascii?Q?kXOsdyyYfsERv3GzwASLvzheQu6ET4J9+wv9wDHwNbL4duuZLb96V9nmf+np?=
 =?us-ascii?Q?2Nk9G0VZBqOWo/e6ZmEAiiAohQBiEeK6WLdmMksoggp5Iw6waUTBox1vtPVi?=
 =?us-ascii?Q?C+la2TUkiNoLjXOj7QncM/z1H645H+mrnF6gy7F5zRNpeqOKGRBQJo27LqNU?=
 =?us-ascii?Q?05Cydd/QV+uKZdp37/UZxqTQ731d5S4CIYef66F6wGvG2zswR4DEiSAxNhBH?=
 =?us-ascii?Q?xvidvK6QsXCX/ZMiWKEgNker+ey/kseiT922y+NQu67lb2avVHVhKaerasGU?=
 =?us-ascii?Q?aayi5shY0e+O6izZ2MmOBJDPk6/dqb4O4ViHl2FkRPYth7Jt1gxl7x7Pb8kF?=
 =?us-ascii?Q?4Awmo4leGsD1EbxP0w47YiQwtfruoYYSZ35j+rx3MPVKR58vZrh7axvWcpw7?=
 =?us-ascii?Q?czDvcqhDzbRbG38K7+MMVCImkIiFpCaOY9vIxQVQOHbVez53xJvhpJfrdok6?=
 =?us-ascii?Q?Q1mNc6r4XVa0wcsXBwYBgmcptspLRP2Ik2MOSRrCDucExJuASHKIfaYI1TSt?=
 =?us-ascii?Q?et72te8R7jyMVLg8AZEjtiscmdTANiHOAtF+yWBHCqNliR3pCGwmrwIztMp6?=
 =?us-ascii?Q?M8jX+6Yu892koKg70/3wCz5U83tslEOn+XUZbzEgw5ywbne2ELggfMvqFCHg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: AqEVuPOuAKuvdgylIPXB4OEts+T8HIrsEHjB3LIAtF52UXgWZNey4lOvmCUF81Q47hr7A2ua9z+KXoSblAcvbXGIEHJs5ZCCtG2FGbLc7MO5/1z0unNaSjaUYApR3ujIV8WZM8G+DQ04NRrDjblRyGWCvQhyuWl4owEnREhJaOaOs9PIrdmNWP3LmIzNqmdY6cs+CSHzNzk8ZVY9qhSU7xnusUaH5BkD6hOagpmDDAAInRWdt/OKokRJzjkKXI4dKuuE/dBR+3lq0h5BxMe9mtnE+Z6Z5xIJ9n/Zofa+eD72Td10U940kNPNvmXTuJdAh90cH3zmVfObX9vDjSEOiA==
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;6:Db6U3Kj68u5NH9vnl9rJObpLk8Anx9pboWzIyXxVd2nbuCmknSczS2vMNlUS1v/VgCqva4J2REaVCIXJdp8DmYqh9uxVjeJRZDmDPwujuN69956jzrvLNUrePnuR6uP+wvTc0hq4NBUtKFoANkqrSR/vpWQtz4yUv3PkjFrxLi3oh/fpZ8IhXID7EeKEkW2FlaSjiYGirxZwDnDnKHEnLDIG4vR83AXWmzw1Pj90lXGsBqQpevDHzOWwn79zlC4JaHfmj0w+y49iMlxV+rtPn0Lp78INKx18m+0INJr3LyMgRxe7Vbnzcdzqacu+pzAoaisKAcGwRafkoPnquniTnBUgRkOMaLaSChvHxD4/H53xxlGi85Os5vq5EI7NxRABAa3jYuZft6+ZqTyARXOoJo/9LSPZPuOnzsNvMeYvj0SI4WKzvAY2bf2eGvTWSDFIIDSjgRmzTd73Sg/VgDcM3w==;5:WT2bEhxdzoBMicMTpZt2pwRir6eXy3yVF2iFPD1aBnPRGL0pGDnM1JXmQx8llPlQHHMcxcEtzBx1RRDqHfPKrwkt/YinbpWCsIppjV0wq+u8Y7em5xf1Xlp+V30wBp48mfG9rROJxQNZywh9GKuKVObYlEOETu6skLOLfUoCaUw=;24:RZParfKTvujnZJ5RaSsj2lQ7+uhuUsRFMT/glEzthds7DhaV/Oi3KXSMekevIwvfxpwDdyJ1iu7NGSZVQzcGj7fDsbQ3mzbXGY0kuhR9mEk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;7:99bSoG828Qm1sXXHWsSC3dyJscpkGvFZdqneoHdLl+HOmi7l3YlGrCtmkd9lRH0cEdHx0o1elVMr9JWHP5OblyeEGTzEweKkS8eDVEFFfb+Pikd1TOtoYGZxbfGmrENI/fOckyrBBXmyxsbpHEfvAnftLgdU/tVK4m2b+shFr6l1AN43sFCym8ZZNghbETrHxiMlbJcsDF6J7aKS46j462aBwwnWNSbexX9R50HuChxV/EEQqVxODd7Ai+sGhjUq
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:56.7448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8090686-1241-4364-073a-08d5d6d4fae3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..d215d15 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk : clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

