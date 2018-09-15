Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7534B208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PeWqoyv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7534B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeIOGyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:54:50 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729215AbeIOGwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUW9Gm2lZXoiYpsCLv/6kGkkLUcN6SIFCS2x8JjfLxs=;
 b=PeWqoyv7GK3yv/SDFHXACk7Ie6766h2sfRtC3A7WeMX9PUytZB1B6pFVxwmW4XbavkTBAsla9YzSaj5vzXvQ3Yc4Y6FAyLs8PF+wb8uVjdSxhV3WppkOLef2iJrYPHGagumFgdD3Xnu/DezJTEhjNpTDS1rRAumTFBYeCBNjbx8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 19/20] IB/nes: Fix a compiler warning
Thread-Topic: [PATCH AUTOSEL 4.4 19/20] IB/nes: Fix a compiler warning
Thread-Index: AQHUTJRbEcLLWzY7RECIDDLpMSyVnw==
Date:   Sat, 15 Sep 2018 01:35:16 +0000
Message-ID: <20180915013502.180110-19-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:wJai1gXADyeAmkvohGyaEYtlNomuy5UqbIMOehJY8Pg7OMuh/e+luggp2w159okSghm8hDI0+QUM0NJxCgYNITTOgGmT9Qo1mnnLwhFHuDeyqGBKTlwi2kbqzq5S2y9SX8E80E7a+xumq5skrqy85+jO0ugK4pwTiEm/pdzn4mR17f9pipOzwTr9mPV9FA6VlI1JkPORuqpg8X5E3qlUnAHX2NuJw2AsOOprCqrLTsTvqfKDmjeIIlArig1GjJfgIkrKjsfVQV+aNLVDg9UTjvzv4SEg16zi4y1PE7OjV29nxEY8DYoAHmawHf46CvTwkNnUOjnzk3UNOdJnrEGDDi2jw6rBsWab4z7RXwTdh6OLcBjURoAdMoVz4GtAdyHuSLJSBuE+bkuf1gB8N6np3IPWE0jiH2aJYKBJY+DDnbr23+AkOL6XM864QP3+aIwQbePAuoFh4nLT1377jv5Eew==;5:60dy8GyE+ISXv7bUeHJeaI0t7i3hENT0j1dfXLuevHG1phqmBmvhU+WnwNRLvyHasEtLIBAmq9Cbahyok/KWpMQ/kSb+q3XhYr34GHBlonM/7VXJb+CujiCz00aYGcq7gAmY26pFJUTq100fieEm1rFlEVZiInyAKclyY7HwFP4=;7:ByW5U9xulBVWJtw73AmQnP+eH/MNFqZ9YNSxzZ4u6ZOt9MXIUbicwYvOazWyBrsieEhvZQftIMobt01ENQXEXG9Gv07u1sqRk3xJR6pEsH+i8K4ZZgF6UFIv8W6/UZmbYKarzCSlTbGafLTnUbOA5mP9qa1jAu5t8E5upKgZ27WbMWZvC0AgH9gauDy7dNwsKdPxocnGS/j8yqGpFdgF2oTrGcYCqtb91Mp+lf2d9DfhEgl3bZ3aL3m4XvqyLmmq
x-ms-office365-filtering-correlation-id: bd40a33c-ab71-4fb3-98f5-08d61aab81ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB02805C7386B983D6C2979865FB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6666003)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: SoBJKhvd+7a6qkS99BouTN1BHxaWYpQNRmzQ1n/0e1q7oJ16mOSlJ9jlJDr01OOWSuYcB7pPb4DePltsHbk+ArTBESwmeG2uCwylOV1T/53prAE2MH/9nH+RWRIVGctQ/feTSTV/Sbo71ugb20g/7jqNqV5ytPj7qglXwTUNNd0nvR0VXoN1qU+eueQBQpcXFCIL59ygq1P4Kn2SBYmZF8eedJXd8bm2AB1XSBZhHAnje6++eVZ880y/S4I2//e9HMqJxCP9f9yzW+9FfNONI1gDN6oT1l26wG+Xpd0FcvJO4cutUSAevF2C850mVyU722zmt3th9cz0fAA3b07I+6l8JrkRpPWx954p/GFXwXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd40a33c-ab71-4fb3-98f5-08d61aab81ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:16.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 4c5743bc4fe3233cecc1c184a773c79c8ee45bbe ]

Avoid that the following compiler warning is reported when building with
W=3D1:

drivers/infiniband/hw/nes/nes_hw.c:646:51: warning: suggest braces around e=
mpty body in an 'if' statement [-Wempty-body]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/nes/nes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/ne=
s.h
index bd9d132f11c7..1a08483c6dd5 100644
--- a/drivers/infiniband/hw/nes/nes.h
+++ b/drivers/infiniband/hw/nes/nes.h
@@ -156,7 +156,7 @@ do { \
=20
 #define NES_EVENT_TIMEOUT   1200000
 #else
-#define nes_debug(level, fmt, args...)
+#define nes_debug(level, fmt, args...) do {} while (0)
 #define assert(expr)          do {} while (0)
=20
 #define NES_EVENT_TIMEOUT   100000
--=20
2.17.1
