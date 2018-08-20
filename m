Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1509DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D2B20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="A4iqkCS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D2B20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeHTNSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:18:08 -0400
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:10240
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTNSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvFSa1rPJfw6ccOLxuX16wtEH4M7FeLdezddmA1btkQ=;
 b=A4iqkCS6HGHmZodSCXx8E8Yl3p2c9JbAPMxF5CxiobpbcOsfEy+QuM8DWMKRhjCeRKtpPKM62DG6AHvqL8IvOe89y4KTciwhT6P4nK2EFK3gSUqerEv1cn8xqv8vh+Fny7pb/rjYfxGguG7QMLje3MDwj/N8cT6fES0upAlXCHM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Mon, 20 Aug
 2018 10:01:22 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/5] License cleanup of "my" IIO files
Date:   Mon, 20 Aug 2018 12:01:09 +0200
Message-Id: <20180820100114.22966-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::29) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34160115-ccc6-4410-6036-08d60683e26c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:ciXrfFkG77Alye7Qyovh7EtzkUBVzODKUIQMQ5pRsjEHjOZOjkHaZK2XYtNLn+X926GiQvRrN0BdoKS57NhgquZbYqNd7RlGyQ0YP6Ekkm7WfQdE8TpeGJKeKea9V24j7nXUcT9kZyhOg6hfOuxoH4gKlBiSpaGFyKR+NMqpsa51XtSWOZv61F6C2A/PfTbEt8igGC7G1Hz402zzr32TTwOdig4J1s8hGKUphucSmA3wN/SO0dOk8mvAndnG0AY2;25:5s5JTJEqM+/Rqv9w3nzJPiugZAdnYuJjI5amjUhBZXTT/GrwP8EAmGPeC9vsK/Uo5kXgGYgdarE2i7UmsLaeLapBMCK0qI+bfPCAsxy5uQr1EpZ1Taijs8TwzPqphoGOLD2oggHgl3223HaunwGaWaYvgG1lZCctwlNeForrTw+RnphGcdwx5S7ZyjQnfX2vTYmcTbYrxil5S71k4fxG6dI+UhvjLOVghKYxl22lO6WhCMEmnioXlvXNqLw/dxv5mLajFEN1aywRreYjjeIZJHe0gDFTlz/s0wCy2QAD7VgbfIqBxneRbNxbw/XHpD4fkQdz2eW/TGh2pJrrIHtwQg==;31:COzmtfYo9GUDvtyXkFMavrFT9M7D+RCNLECZ68akY7uKAZCvpeytj0cFAD2+YVC/GSIMVFVIe9mlkk1soqIlBdml0FFz2LbbeBsFAedZueBN6f8jyaDIudtKj6afBAWDKREIKcynhq6hnZ/rKDPAkV89PKYDnMpRzo5OTXbGD4IapSdAD7QUVfuIIewz887Yz9BQmTAeol9sqZPcA0miCsOjRq8l3DIyWP0+yetKM/I=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2451C746CDF8E0DEDFD2B95EBC320@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:8tBTUZkxJbBaVS8i22MbVcA0tvj49N8T/UaUo8p88G4D2XHyJ/USWgiOktjtfpKcNVVKBedrWaFjuDLi2YZbOO7OlgJQRaDVLx9EU5w1L4kX5an4V+8MheEECocLu6d6eS99lZ3KqO9gMAuk9yPxSFoSQH4RMzU/qzOSN1Ro+77gjxqtTbBvSJFrsIQGIUzLBBWbd8Du8NmGh8OSAUI0GdoFs5/6EZ+leTEWdC08asGi3Wr5UsvBZtuuqHziB6KniPJAXVXKlmlbFog3DPPYjw==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39830400003)(189003)(199004)(6666003)(478600001)(2906002)(68736007)(47776003)(6116002)(66066001)(3846002)(5660300001)(6916009)(6512007)(1076002)(53936002)(476003)(486006)(86362001)(97736004)(6486002)(956004)(2616005)(48376002)(25786009)(4326008)(50466002)(50226002)(8676002)(81156014)(81166006)(51416003)(105586002)(74482002)(26005)(54906003)(16586007)(386003)(186003)(106356001)(2351001)(316002)(2361001)(8936002)(52116002)(305945005)(7736002)(6506007)(16526019)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:z1nxUbuWnh/WNz6lOBRmcAF831NdTkg+ns8tzNO?=
 =?us-ascii?Q?QsgwAt06isfNc2fyC55F63V8bFP/cyhCVGyvKschD5R3PNMFBPXzgU/sIqSf?=
 =?us-ascii?Q?KcGWOOv3HNbmFxkscTyhuzz7d8ONxvCSb9YYBZoYRQPZrDJBsXjc+RWsDJsE?=
 =?us-ascii?Q?59kwJQ4Y8DbHTF8efAAF0Us12HOcNjwaZ2Tm90Ox3UkXLbHd+T5+AUc/rY3i?=
 =?us-ascii?Q?qP1ju6ZkE8c6VK8XCYgev5jTU/Rr18T8mqLcK3dEC3D1GBi0IgZiaUiXSgo3?=
 =?us-ascii?Q?1jFKSl/62pyaujFPlFxQjacC/STJz1QnuJkWsobJMLl3t0w2gDl6ciihBt4M?=
 =?us-ascii?Q?fG4v61U+5oPHtma4fEHpWsf2pFW412W8YQhzj2I4JukRq82Fm+jiYTV4zetE?=
 =?us-ascii?Q?pRkcWZvvqyi+JUtNLrETxu9K31wvlg0H6ovphBeRphF4AybpbKue/Ez04Nbb?=
 =?us-ascii?Q?Nvf9kHb7YkbF0f1T4xddGg9GA8wqTSAWDjSsBMrKUH6h8yVxNBZUxQwYMbc/?=
 =?us-ascii?Q?9EaEK6PJCj55n0LFuDWSMlFNLFfpFGseRkEkpboJmZa5y1JxiOBelH3Vme52?=
 =?us-ascii?Q?7OabyPIgybU+odeZUJ7m/aeBicYP6z0Poa8OMpvI+WeQrkF5HepqxAgsaBRX?=
 =?us-ascii?Q?cHb2y90+BEMvihVEolsWsCT7PnM2xQX4cS+Qtz934RGDu+m3FVMS6SGk+BmX?=
 =?us-ascii?Q?uUFyDhjR0+ly+qQApKZ7H7uvMEV5k4T+LpGzHxR4GLxfiySYBHSN7DVyv4mc?=
 =?us-ascii?Q?rSst5n4/S46khW73knowxUS48QxmQGtq/oIlENErMBE6UTZr6CS7pDM8sYSW?=
 =?us-ascii?Q?9S52mVd8pZVojHjNfRrL92/ZBgtEe9YXpvTGDSMRK5eedvzIYUIF76Zv6ejm?=
 =?us-ascii?Q?JhKicuXVupx5bWwxXjZVhVDqm2eHo24m51H+IZl0gBmNK5ho2fLPuidC8XWY?=
 =?us-ascii?Q?8FXjWi8UBbXDiWj+1Wy+MT26dj3QJzo8SgG33NarF1a5BVMdATiSoNyntjpV?=
 =?us-ascii?Q?8mFJg+EcVH1kY7y9vNXkipGfAOxVyyPbVr88DDIYXoV4hQvKmiKq3KPSTJr8?=
 =?us-ascii?Q?eTs1mU2eLvoDhbXWYZKqF/6eKDr8Gs/mf7SnyvheUamQr8jCLcqSbgFtPFP0?=
 =?us-ascii?Q?SucqfSoNhPRcBMXynRQpf8L6C0p2YW2zfNqDpPyQcQCWs8njkcRFJQHDJ6LU?=
 =?us-ascii?Q?dXeLgomZVKX38w2ixxPTWlBAS3FnCllR5vAIWGPJ0rARTtSX7tu3VP+HWfg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: cMZGUlWFjfApgEy+ifMQQTtJaX5gi/e6Utfxd3wttqdgvqHM3QDEeAMxH5SgDXeB+1qMQh1LJdZvZWiTUkw5e/JuhaFxBZiVtDPO26wyi2FDiflIybFX7Z3V1B3BqIDgZiIneKy2lZ+Q4ziZFv0GY0PtwmCnigMemtMSe3Car+RWE+8WesHATSqpszeiCpiuq2c5RM/e4/7mCImZscM+PYAlRF3gXJX2EYWRwl+MW8FEwqZ38IyYsoBQYtA7Z+XDcZ3qM03LIr2TsPYG1db9izsjeCYK8R8/SGqGVk2b7v+BkSYypHfg8GHLaiA3b/ce7+zr4RbVtfF6hqjnVODsLbRIpS5Imzf8dTDy/Q9TY38=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:ZRzPlJb9fZD4klpQH8CIcJMFrGnBmbYfsmn00kWSalWUGRKhT3QdNiltyk6x4Z4P3nlmHbhLhpb5dJv66IuZtrg19aksd0UReNbMdKOysxPS4nt//0rS4GRd7eFBEBd7rdLI2HaK9ZMx+J4nNrPb4cuoUSdqrnC6g9TKcV5uWBDmVoTmH+bWulIlz6Xas14wTBQ5U+mMIvVO3evtLyVBQrVlkUIVBsHc73hIIxh4Hzqm1XlBSU54J0ludiSNjtLFFvY+s6aPVwJZJvpwk/OK/RyoW+Qr6H68qbwBbXyUpIa+fpT4hP58xJUu4j73e8FFzUHltVfPlUlOSrxg2V+7SYu1uQZENtkWIO9r33qlqWnuUP6S1stUd5vZaXnYaAulcJDJVlTyE0XFusNAO3Xa5x3ai61djpazn6PxTtmVRfQwWG6R4Tjn9ejD3Bv7zFsB9ZFsi52iMMygmz+BXPq89A==;5:J+c31SprVD2KJG/0x4UC9J6miel6oxDzsalZd1KFlRxdb3oEd4V21gAijA421j/f0pD4fQGNeR74UQbrY6aTUlgLpeqq52Fqsws0u4r7UIxElBF3rPjVQhtG+AxJt9DUVYbYNxNO+5WhZRclVRbH675CE03uWdxNr97MrmeLNtQ=;7:qvaiVfM8M+aS3xFoTmIi8WWYuIm/FoFqNGwgMIVXlOz7414YgvtjqCTgVuE/fhZ20rDd74I/uV9nWBp/I126jdIZ8UWiIZOg2fTA4YsJEDEiID/jO4wh/0FnKHSjA8QJmmooWCrCYr9aF0xtiFn0cS7WsCjV+bftKGia7X1iVImTHBMDLYBoVwFLfqWALLa6XXicWezfa1meQXgbgRckZFG/qkagP5q26M12aR0gsJ6V71HZGsCxzXML76qJNcxy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:01:22.3224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34160115-ccc6-4410-6036-08d60683e26c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found a couple of discrepancies in the license annotations in
some of the files I have added to the drivers/iio/ directory.

This cleans up the trivialities that I found. While at it, convert
the remaining IIO files that are "mine" to SPDX license identifiers.

Cheers,
Peter

Peter Rosin (5):
  iio: potentiometer: mcp4018: use the correct MODULE_LICENSE
  iio: potentiometer: mcp4531: switch to SPDX license identifier
  iio: envelope-detector: switch to SPDX license identifier
  iio: dpot-dac: switch to SPDX license identifier
  iio: multiplexer: switch to SPDX license identifier

 drivers/iio/adc/envelope-detector.c | 5 +----
 drivers/iio/dac/dpot-dac.c          | 5 +----
 drivers/iio/multiplexer/iio-mux.c   | 5 +----
 drivers/iio/potentiometer/mcp4018.c | 2 +-
 drivers/iio/potentiometer/mcp4531.c | 7 ++-----
 5 files changed, 6 insertions(+), 18 deletions(-)

-- 
2.11.0

