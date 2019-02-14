Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A418C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63BB222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="pL0/8FYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437558AbfBNIjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:39:45 -0500
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:61941
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437487AbfBNIjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxWBuJfU2OqjrsYM4j3Ia3Jpc8WIziN0XmydrkM72ws=;
 b=pL0/8FYpBuAtxFqBC7KxUFctXLmpoCppJyaZV0brXNOgGseF9twU1uKP3J/7XDg70Fo4xwNXeIPtMR2BEwMARXGQT5IbNNTw2bvxpUziWO0jz8jXA+25N3XL8/uhVO85NmW+t7AjdgVbcFOJWVmX5u159P7eUy/0UUcRgVomxaY=
Received: from AM6PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:20b:14::25)
 by DB7PR06MB4726.eurprd06.prod.outlook.com (2603:10a6:10:56::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 08:39:36 +0000
Received: from VE1EUR02FT020.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::204) by AM6PR06CA0012.outlook.office365.com
 (2603:10a6:20b:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 08:39:36 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; lunn.ch; dkim=none (message not signed)
 header.d=none;lunn.ch; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT020.mail.protection.outlook.com (10.152.12.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 08:39:36 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:39:33 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Thu, 14 Feb 2019 09:39:32 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Andrew Lunn <andrew@lunn.ch>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] i2c: ocores: improvements
Date:   Thu, 14 Feb 2019 09:39:32 +0100
Message-ID: <4284641.8ec35d25Ci@pcbe13614>
In-Reply-To: <20190214030733.GG24589@lunn.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch> <20190214030733.GG24589@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(2980300002)(189003)(199004)(4744005)(305945005)(74482002)(446003)(230700001)(50466002)(316002)(356004)(9686003)(23726003)(43066004)(336012)(8936002)(9576002)(46406003)(16526019)(44832011)(186003)(8676002)(426003)(786003)(6116002)(6246003)(4326008)(26005)(47776003)(11346002)(86362001)(3450700001)(53546011)(246002)(126002)(33896004)(2906002)(6916009)(476003)(478600001)(106002)(229853002)(7636002)(7736002)(33716001)(106466001)(76176011)(97756001)(54906003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4726;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620820ee-a26c-4231-02fe-08d69257f388
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB7PR06MB4726;
X-MS-TrafficTypeDiagnostic: DB7PR06MB4726:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR06MB4726;20:KB01pcTMPV9Db++CHz7wAZuEplssBdupmTzddj/677u6DEO/WRGUjs9iMsRlXmTkp/DPE/WdEeYCXs5lvuee44KBh36OVcwudh4WZaQnX6j1+0ScZf+7XU92bOM9iWPaLJbKA/jNV6xN89O2kpWm12kD3cqw1biaYzxxF82UfH44vFfpQGeD0X7U8ZbypoCrpwb0cvangfvEilwwoKnWeI2Koq5qB073OdFqd4AjU7KoLOHbabid1l4pK/cqsGYDQD/vN9t+HEEIydu+2wAQUEU/8+Gp00nrJeJMhX4M1D9dTkbgoIJMAzLQLkFJMMLupw/nVqsIPEC7zmQWIe7P+M2GZSY8B3ZObeEZg2mIWOmQc9zimrlpxvrlAgk4184YWfpb6QAS3J/9OdgI1HJw3sEgWXrBtaC4yYRNl9rN7+nxdQkPMX0v74ZmtHtVfPnWdwh7iQ90Pu3XJK7afm84FIHOomHWkT9BKOlbp7mzuPWgx/UGXy0hUDElMme30uTG
X-Microsoft-Antispam-PRVS: <DB7PR06MB4726594D2459FCA29A779CE9EF670@DB7PR06MB4726.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR06MB4726;23:w5CXibddsgxiWf187leigM0Zxrguwr99xQ2g9k3ES?=
 =?us-ascii?Q?ZFHdf43lEqqSg+mQHprLCRD21Lasfw01etsQC/EPnHcUgReJ6cZrSUlexxSE?=
 =?us-ascii?Q?kywgwZFyIGpcGF85KfrsjeWLDiHoUg2gVl5msu5e9/7tYVKRjyQlqLElMvNV?=
 =?us-ascii?Q?9PTaqlqj3pJtKK1rvSSUxAN8L5gk5HUcg84S5GTOAnJyDAk0LoRgsc/a6s2K?=
 =?us-ascii?Q?FGxqhcOfwRYGx10VxpbQjCn8ZTzDFm2tWTUdU0ub2wYmCeUBKeSchtIs+0DH?=
 =?us-ascii?Q?u03FjwupfuDV4kmXvogtK54g9uth/Jp/0LqWTtRVYpa3Xx89NLkjNl/FHkqZ?=
 =?us-ascii?Q?jJhzFw9LVoAyBBqe9JfZSwoizNmWy4748PufTKlDkm0cJbSq27JtlE297iYs?=
 =?us-ascii?Q?uJaktdBesNvnpS++t5wjQOJ2d3CULPESxyBNA1gYc+7OOwlP54/XXyziFqfE?=
 =?us-ascii?Q?i+48WTrG8yBlFvMnD1C+HiWCk+hMsNWmwEFSchIiSzOe+16L4P7UeBqMQcga?=
 =?us-ascii?Q?zfq5TNUM+EQi38ZGi5AtQN1KHM4syKDe3eCittrmR/+iMIcXLOTvKgvElRsf?=
 =?us-ascii?Q?7ntNDqgWQdSz47rmFzv4Ty7017/P+b1qWbZcFYgqoGo4FRyMCM40CSFC2KDP?=
 =?us-ascii?Q?QWnK/78VAi1/2RK7EWQdDflc5x8tAB3OWaB9v+09BJ8OtWQi1omC6aS4sVlT?=
 =?us-ascii?Q?MxnioieZ7SKM9mFWcYigLm/W+sRJ9GZZygbC6ksuB8s8oleN9sxqkMizFhZq?=
 =?us-ascii?Q?OIpAcibtbyGesTZK9X3CZ/DhVq79ej/mGvtfg8MUAo/G/o8W21o8MIBRcfUe?=
 =?us-ascii?Q?nJ1Cta858pI9uYPg7fDS/2nYnMZgkSxHKQrXkfh+yxLUZHTg7xhJlFirbcZd?=
 =?us-ascii?Q?UjWawgyU6Lyl1J6DXynMifZGo0+DB1WFKCOvSb33W+sQ34KjJpHo4+tKhiGL?=
 =?us-ascii?Q?BdAte2plLa+KyWbtYBEM3xmjrT6Z/ZZdht4Psvuauu/5Wp99AUt9mPPtr6u0?=
 =?us-ascii?Q?JbxH8GYM8GU1RrP8Jyv6H4IKpftk73SyAF2MQXdtgGtMKBOBd7id9kx2ZbhJ?=
 =?us-ascii?Q?f3gxjGhLK2u7ng7mqI7jo34wHyPteO9pso/Zy01F72orXTYwidH3nS1ZRKsr?=
 =?us-ascii?Q?aR+WXK0HLIhvQXIiKXwUOMBEfpoDY7ar3OgI8yiODD7QhmoAJG1P7eaje8GB?=
 =?us-ascii?Q?TiyrEAAgxdRvNE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: EHcZhzJwRxXjYgfzSthm1/BhS+eUCqdUEBoGHndE/hOzO+2ZHkk/msYisPRa6QzpbEMHl2hdhUILpYqpO/Ax2oCwPOOWW+oPh1iGmle95Aw1j5F0nOhRPv8/NZKf0oXYjg+krnSNM8qgQGdcxQwhVXeBQDn2tWvBt3v5QwNeLEwO6sps5QpdKTH2OikdsYVNpSzLS6pnNub135XShjzwMtXK81BHTeTQF7AA5YkI9YiWqOKEdIsW97CVDqVwSb3tSrKVBSEl7mNyU21q9SzjWJjNoN57ZzZZye9q86LXg3GvXvS6ApWsNyaBQ14Zeb5d8RNP0wC/oWuqFkcWLFywQRx8Fs27oFuzaiSI8qP0QSXOduilCgBjQJ1cwhVtlsEzB1ZYdnR+KjjXULrrnrn/EDaVincRkBwiWC8mOriVVr0=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 08:39:36.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620820ee-a26c-4231-02fe-08d69257f388
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 4:07:33 AM CET Andrew Lunn wrote:
> On Mon, Feb 11, 2019 at 05:49:08PM +0100, Federico Vaga wrote:
> > This patch set provides improvements to the i2c-ocore driver.
> > 
> > [V5 -> V6]
> > - remove redundant code introduced in V5 (double read control register)
> > 
> > [V4 -> V5]
> > - deterministic status of IEN bit in register "CONTROL" at the end of
> > 
> >   ocores_init()
> > 
> > - more style fixes
> > 
> > [V3 -> V4]
> > - add reviews-by/tested-by
> > - add comment to justify the formula in
> > 
> >     udelay((8 * 1000) / i2c->bus_clock_khz);
> 
> Hi Federico
> 
> It looks like all the reviewed-by: tags disappeared from v5.
> 
> Can you add them back again, and then we can probably merge this
> patchset.

v7 is coming (@wolfram) with SPDX tag in the header file

> 	Thanks
> 		Andrew




