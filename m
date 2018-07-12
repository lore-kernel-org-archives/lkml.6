Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2202147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nZVG9XlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2202147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeGLFz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:55:59 -0400
Received: from mail-eopbgr710053.outbound.protection.outlook.com ([40.107.71.53]:15264
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeGLFz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fP/LgnogNalyb7p5azSXFACiMt9koxONMw9cHc6wp0=;
 b=nZVG9XlGxv32ci9xD/GC8en4cZ7Mq5tfbN4R1O5sT9oweRyR9kV3AUXA9qh3xhnW1dqgcX+zttkhD3afU6qKIXPN9T+qiZp7/iPws9KQhOalnkK8ys1ZoUqOg16bsH3wDFhbWq7NacJP4fw/vj5k2vZ+3t7Vsg6F3xHbmQKmiuQ=
Received: from DM5PR07CA0078.namprd07.prod.outlook.com (2603:10b6:4:ad::43) by
 DM6PR07MB4716.namprd07.prod.outlook.com (2603:10b6:5:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 12 Jul 2018 05:47:57 +0000
Received: from DM3NAM05FT053.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by DM5PR07CA0078.outlook.office365.com
 (2603:10b6:4:ad::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:57 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT053.mail.protection.outlook.com (10.152.98.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw5032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:56 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:04 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:04 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lmXH029639;
        Thu, 12 Jul 2018 06:47:48 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lmOC029625;
        Thu, 12 Jul 2018 06:47:48 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 11/31] usb: usbssp: added function for stopping driver.
Date:   Thu, 12 Jul 2018 06:47:08 +0100
Message-ID: <1531374448-26532-12-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(199004)(189003)(36092001)(50466002)(336012)(7636002)(246002)(48376002)(126002)(2616005)(16586007)(486006)(316002)(356003)(2906002)(426003)(42186006)(446003)(54906003)(186003)(305945005)(1671002)(11346002)(109986005)(76176011)(26826003)(478600001)(87636003)(4720700003)(476003)(86362001)(106466001)(107886003)(14444005)(8676002)(8936002)(50226002)(5660300001)(47776003)(51416003)(36756003)(4326008)(6666003)(105596002)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4716;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT053;1:+3lRAzZ+2wYQaFBIZORI+UvSPrMElsiGLMt2WHyq4KHOVgTQYs0hIzWkdVU2OjBN5kvTbXnxvG1OZdbo4lR9q0GKLdzNh82kyidHJ4wI7iqFw1o0a4CMjGxUUuto4+0V
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da8defb-422a-4089-e914-08d5e7bb0564
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;3:PW9NkSOdH50hyZPSJEwouQVQeZ4n/7+r7c84emDDPVypJKx8MkZfVu3AzXJR/sULZYQBXbW8rjdEmexkjmZvfi0XMaKmDY61I0HlgWL3oTKp72yhoSwawdQ9JsNKAWf1RDzDR4qOosbqFnzb29Vxuu3EWNB6xptjCpnlt01sZ/+bgGgPXbbJALlDQpcwuTl7GMeMAscKezhsHXu0ZZnFu3kMYruOLGe7SZoa/lP/Ib8Yv1jc7vkIPaa/PXSBOfCxEABtU+eYH4VQwP752n48/FFA6JKEWMGjdmthekQpcfVmsquALEjO8Jw/sDPSEtFwFk6Fc/sBM3yR+5CNlPOaWanre/ec6RPSMEdqCcQlH1I=;25:fAbkpCnwE8AHUvRBVSVQ3nNqHYk8rUryAlY0kLCSmvB2NkNp8iX378p1/L8N0/0RTXJXsj+ciJLFtd2PtNQt1ou3vWxkjucR4nnNdrbKe9K6PLZm8RjQW93z4Y1i/z/G/9KEu8acvRHzRfTHhGHTEcKpMGHRjSJDSwXINTppA9mSH0f3R+NcX6qeUHAvXkAxqRoR/SgjgQaWj4IFuWfRxJp9UPP3gWOxpH/jKHoqYZQSbZ0GksdMtKygHNui3g2OYVxXCIeLJFd2XgJbn5JNHMh/1brNyRkLuzFLN52zkBzFnOHrp42D+072OAeBz0cOjAe/JmSdX/Cj+dPufKTshw==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4716:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;31:5rR4zppANR5NMtfD18ybc9o9UUTXa1P1AVIcaavNN87sHVrLv0xy5a6OyMQvz7Zy1L2i92AaS/zfZNfiJiEYJxsDU7fTo9osQ3FE96UHjWfHfVt+3DU1Cdooo9l0FOHTTtMSnMvn6e+e0nQ2/LCiS7bDh8QGpfjkmQqAMNR7Lzj7//4PDznDfKo9QZwzLEwaij+Fa6bgoxinnXfFkzO8tMY1zyHQIRUdsvhd49vRxaI=;20:/kk06/QxSVA1QbBND0GLoLA/1qL0daZmoo6EUnjaa7aZ2dIxVKSgYwFQd1v29o5MZc6L0hSdEtROtkfSok5zolIupzmlOOoGSubXToh0A6SvG5Tm1uyTSsbFGYtCmccTXXQDchYkkJ0At2sozMcCCaaBfzZR0Z3oE/KkIvwoECuvs1r2VMDTlYBRIYknii119hTzxjzoceZzNemPvluA6uKwvw/55wqyukpbFYKzs5Rhuj/RuKDdu8ui6e3MtCZzjW0WWVCWpnZhLw4DmVogtiLcKbX4Sx60dTQMPaV/xiO417jdcyeYZogV406kQUEBuGVxLMmaU0mnD8qlzkyFysDG0fTXpPH1QWoZZKju9wfLlIjSmxnlB9u8x2tnJ6Pu0fG85P8WG4RtdPiP9s9TWBHek/A61CfcF9fVxMNGYTe+ZWf5L5ezu1Zm0blxE6ceEyeVBsJdGgXBgKJNc585C0fmQnF48+7VtN78gBt0EA3R+ZRgAOxHyhmA+FVphNLT
X-Microsoft-Antispam-PRVS: <DM6PR07MB471697BFDDC8A8AE430076B3DD590@DM6PR07MB4716.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4716;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;4:4BGofLTYsRqEhMCGrHJVLf5yWylB26b5HuqTypCgaQhON9swOih2ldplU7qw9SRb5rN0W0l0s/bFXQ2cU7bw/7x5JVIiQL32H9wzYOjbUPgEYKJk4zhOg9XIxEmgc8ULeFc56JV872LDu8WdhSViO9BK+qQXv7csuHjVWNOH3HwieA6sOimBfIKKn6xRx5Oz/FMvk8RQkGjc+iqj7KYe4s4IdASE+Cbwy0DT+kCTf8FwMQykEXxyoBwbPxge2je5LzvWoJNETCRu1eUnrXgqPBuD85WBIl/Qf6+uBgG3RQtts7llceiY/a2YYz4U8Gc3
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4716;23:Fescimr9fEpckio3UmYmyGoEI9rQA65Dt3hwtnONo?=
 =?us-ascii?Q?zEhU+5i3oY+J07k1zgp44gQtAnagSHFjVBSZwYQL7Rmp6q8xvEU7v6xWk3WL?=
 =?us-ascii?Q?rADZaFvjwmWYYiSCVA5BnOjb7t0BslZksquZe+NjGN6G4zpjhuuW7V9FFv1N?=
 =?us-ascii?Q?+ShHRxmIQNLSVUbFJFDt0NswSyIKu5Jl+gNpR9HmqpR4D85SllqUYotwzMQS?=
 =?us-ascii?Q?iR1TiCyN3vrAsYYAp+B/ghyyWBkwSc8dPiIpjQSlic+Y7Y/z05Zc8ITRYrV3?=
 =?us-ascii?Q?MHEMNJCUGVZWcKrW7C7M/CdQnuONbAZIGccUJyvz75Z/5zszYkfY+0aKvEmT?=
 =?us-ascii?Q?Et0isbJvMdfUArCsXNHRjtklcrC3yOae3XxxTYbte4l27+g6ZocjHbG+Jfiy?=
 =?us-ascii?Q?jHRDWTsyiQcxevPQoXRFZo2PhPKzTcgVOSPUO7IdXEQP3MdMuV+FGehgayLj?=
 =?us-ascii?Q?v5sxlaDPTgvQGodrqqvJDfeNqWCCHiX82YSS6FwDUk0CuIGxWUmneVe1CKsL?=
 =?us-ascii?Q?iHvhZO7Ew1IpNYmfX6cxs47AilRM0GOHULULZZNlSYCF3sY7YlZhveKOr+n0?=
 =?us-ascii?Q?IYzWxHPGOBVtPHFmMEOG6t8Q4hWA5NhuOoZattNLVFveR6sgYoK4SEo/MsEq?=
 =?us-ascii?Q?k8VcG6r3e31b/oZNLQ02fvDvX0Uhwq3TLdkrPH0mkp7BMQkL+8NYSYDNmnsv?=
 =?us-ascii?Q?vxjXlzYRAaZJVnEIanPqnKaFsOAyLcd0nlmM99WKERJSir9Jl+YxlCcqnByl?=
 =?us-ascii?Q?Vhzfm7Ja5UtY6ZHZJBYOgLw6AvpdhiHIbGKhGGfQtxoTQWM+29cA86/4wp4M?=
 =?us-ascii?Q?fNsuQDW2jhh1Jp13RLI3ohhJTvFcGaVobSVUyNkuTTVNGps8l8Pw5g2h+pEF?=
 =?us-ascii?Q?b0XF62fa2qHzwBF8tvedDDNSbM75fNiB804LwFWhh7FN3pz8UwGly1TP91fL?=
 =?us-ascii?Q?FB6WyWUeSasFlmqH025hATAc2zBuf8PjSFjFI18YFVieJ6hA5/ltgMMZQJdB?=
 =?us-ascii?Q?azTEVgoLPXQPUZE0Xuwt6cWOe1JZ2gPO30tEcp3+QcEOWNcqx60k3absFwfk?=
 =?us-ascii?Q?EY2LNna4myUpbexDADqL+5rRoLhUc6Nt2hbvSHPCR8pHRN3pFiyMkYpzkfZ4?=
 =?us-ascii?Q?kzED0XhYQAzWm3suqOKaG06YXiJMPnvtdzxjTULamw9uJ4TsCj2dQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: KpnQ90fLuq5yg+nmG+c73NAJSzZ3gREij+yrN8V6C7rEIFHywURV+nqw4ySmlAv1wdtWWi9cH26zonbz9dJMM9tzjdOiZhZxjVRwuprdwYV9I6gcf7yk9Yq4YfH4cZ3dON5qYceAr7/of078WEtLf1MRqbUKtOcC9Olu7UYC5FVaB2kLkV0VZMm8p/LJnKWiNaChKGbLk+yj9+or0v9auL0kLalyjKER6mZjAKcVKbV6XJRLWzKSxLx7cy4uEEyq9DiuqwWmq0R1LKbghrOnracBqfIcHZaAE2r/8MBmPRyruX8CzTK5FGprdmlQiexfKzxwmBLOtvtpcA9IGMigKgeM9JZJZ97m1NMswinROhIuF9iM1+K49JjJHB8lhCGkayNEKQZpNCsEXpdb1KaGxQ==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;6:mClJj+f5U1BT53gOIv8AVKbgo5BI1rP84SPwOTFBh5jBVKEhRVpOL8q1UpCF3Ycy3ZRhnbHOYhJ7Vj1ukXtUxjGz5icYKBLZ6ohlKe5SDGxmIs/IubOhw8I0Ouzw5/ovLggQ0ZQ5fvvyzQUyW4lnsd6cchEDJTnsen65Hbd1G3NKup2ARurc7/SaSiiog6azD9rMUrpTJiDw1nYj0vvT/gyoUrYpFsZM0Ct4WPazgLU7pX+Ih7+lAWvNz/SBOVnsQrxZrcuL+UVjKOT4Hp4KfKNnD1j5zDjChi2SzEKMT/EYfHHBUxFw6Zg0W4vq1EB3w8Dyp16y7k68T6iRRnkLZNYFU1Xe20K+NCRC1Nv4nqcenqQu88Nvm4wKnrceMGqFH/n+0x40l2BeqRkO4YOM7qSi0L3imvzowQI2CbF4c8aO524cWEHbLYw7hFLUHpUKmbrwm8v0jvRwSLCCURT2Og==;5:OY8jxevzs0+cyOgb8VSheCrXRHtkcwzMz7a97L+e3gzeSa4A9Ja5N/qe3w5A8hL5YAPAytCwOhesdC1s3pVbq9aKJQUIPVfZgnz+z//ysCv83ElmpKgBKgJkBO4eOxNsAD5GfESZpVKm0gibhYPpfyDdWcZhcQAbJdu9xyfd2GQ=;24:DWOBMppqdaliLB+m+T77cMy3bFUzWFLQD2VMrmLFY4qZej/+Yjwy1yGVmOFFzfaccueiuxXGfTy/3v8vfF87y7R3Y3ySse08nm/BYMWDX2M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;7:MPaTaO79Gj7DkThwpgpITdnAYpJ5FoCl/Ks67yuQA6RvU33hEZDyV9z+FfNor7/Zb3X89rvxyW6EhC1oIiNiNrzKO+0w/ApJsnV0IG3Yvyq3UH+Ztlsx7wVXeyANKvaaxfe0EUpbJ6h/sgcE0Iy2i6jnm2iXNzwNYfvvmfjXcRfPtCqgTDwiaCSyMATj8uwc5hkkTX+wRL8hFpfVNz1jgeyI5Xe4m/tBBKcvgxXoq12qLbXFho1DnrVdY3X8TQCx;20:17c1E4dYKg6hap2z0RMU93uHvOfNvDZDJt13aY0dN6CxllojfFoLra72TwwKUCA3QLg8k7xb9mAu7/VYAw4LIWN2XKlAjljHUyIZ5gYRugV8rCRPEdbbM3GLy6IM38M1y43Tsz0A4Zz+Mrtxk2hQdfYFS4J0CeENYERU/ARj/wBAa3nPRgPgLMQh1qvz9uzjI2jUdjh6QQyGiFQxJryV4htUK4WxNwcmXn95pIyg7eXXth5GEnEH3t25OE+PlNpv
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:57.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da8defb-422a-4089-e914-08d5e7bb0564
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4716
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is called by the gadget core when the USBSSP driver
is removed. Disable device contexts, disable IRQs, and quiesce the DC.
Reset the DC, finish any completed transactions, and cleanup memory.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index a66209fc069b..e84821394e85 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -204,6 +204,41 @@ int usbssp_init(struct usbssp_udc *usbssp_data)
 	return retval;
 }
 
+/*
+ * Stop USBSSP controller.
+ *
+ * This function is called by the gadget core when the USBSSP driver is removed.
+ * Its opposite is usbssp_run().
+ *
+ * Disable device contexts, disable IRQs, and quiesce the DC.
+ * Reset the DC, finish any completed transactions, and cleanup memory.
+ */
+void usbssp_stop(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+
+	spin_lock_irq(&usbssp_data->lock);
+	usbssp_data->usbssp_state |= USBSSP_STATE_HALTED;
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_STOPPED;
+	usbssp_halt(usbssp_data);
+	usbssp_reset(usbssp_data);
+	spin_unlock_irq(&usbssp_data->lock);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			 "// Disabling event ring interrupts");
+	temp = readl(&usbssp_data->op_regs->status);
+	writel((temp & ~0x1fff) | STS_EINT, &usbssp_data->op_regs->status);
+	temp = readl(&usbssp_data->ir_set->irq_pending);
+	writel(ER_IRQ_DISABLE(temp), &usbssp_data->ir_set->irq_pending);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"cleaning up memory");
+	usbssp_mem_cleanup(usbssp_data);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"usbssp_stop completed - status = %x",
+			readl(&usbssp_data->op_regs->status));
+}
+
 #ifdef CONFIG_PM
 /*
  * Stop DC (not bus-specific)
-- 
2.17.1

