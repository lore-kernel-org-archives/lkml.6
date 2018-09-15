Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4564ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF66208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VHpIYO7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF66208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeIOGxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:53:11 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:53808
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729303AbeIOGxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUW9Gm2lZXoiYpsCLv/6kGkkLUcN6SIFCS2x8JjfLxs=;
 b=VHpIYO7SQM1jbN30FvVkwtTh14oNNCnwXpnZMrXGSxI+zhCG3+QdNhX6ARwbFcAfY8j4s+QvarcHNg4+iAB5YTnYQsVQfxTuuF8e0QxUqOb49LhpTdHqq2eoJ71G42+eD6byBthhH2Yh4UGG4QuAsCR7hikI///uTBmEZHuD6Vk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:36:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:36:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 11/11] IB/nes: Fix a compiler warning
Thread-Topic: [PATCH AUTOSEL 3.18 11/11] IB/nes: Fix a compiler warning
Thread-Index: AQHUTJRj/8W/6zHJ2EyXSlW58K0KoA==
Date:   Sat, 15 Sep 2018 01:35:31 +0000
Message-ID: <20180915013521.180178-11-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:Y4fVEE+Ap/y5mwPTWKKiexZmyr0za53RYdM97c8W0XSPFjDRD27hpIMJ+0gDfZE3YCXgzWmNYAxw2SZ8UZyHqMh6jJfwV02iqvhaQLOTSWDMhjS+NtopqQoDsXYuGf6FyM02OBuWIp3iGTkUYQocGyzz1FakcogTdtCfiHyS2ymJANsB00iObI3EQvEyuD4BDbT9JpW1DTRy3JVJsNUYh16fWDXeSGpyffyAJOe6rQ064s5r5KRLXDG6thRTzOkIZUPw+PmeuYnsZSt/GveQQl4CNLVNNCkpCRz+ya48u+bTskj4gnLNBrcWjB62HHb9tuS5csx0LxoN47a/Q1AK/JwSZD8dF4dK0x4+QFbiD6/Gh/czHm6JlY8Zu5rg7Bxs6z6sQqKRsiNNn+/vT2v3daRjsyii2ZfDdMdnO3RbfbEsH5KTYhBJXQPuRid9U1vNuJOJSHo89+Z3T9QLjqC2oQ==;5:+NLLIY/ZADtYfVN0paz7D77E3xZ+A1Bd1Q1S3RqzjC87ECmmvXKEeCFconWBWnuei6KpUtif5S/fmWBNtvHFkehG4oI7yD74Q4W8/PrKr0LE4pu68QCJEgqBB8N8J8q/y5FrASBaSZ7DRkiYGnuCFooP+s+u/9h5uUGxIl/Tqrc=;7:vb1e2zNqZwgA88TD3WhlSjqz7mij0+vzYZ9d3T7DRgolzpaSwKmhiWFUf1zVpx38BhZDihj42c8ZMV/LivF6CMvkYYYHLZ1HMsUWZycLLsfZ5wRjCOcs15jHcs/nlEPjBFWROFpME+ZOhdX0pRyCdQHbGN4pOoo78iJV6KVN1oJVbcj9gnGsh4hBpCZN3dKKcjuWvNBbfNtENHKiEOt3IM8ov9TgJ1be9r1RyavYmkhEDeZ0zHcCDz8fs5tJhpIE
x-ms-office365-filtering-correlation-id: 3b5cf835-1782-479d-e91f-08d61aab97af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB02802E5151FEDB567AEEE7C4FB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6666003)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(86362001)(8936002)(81156014)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pewtuT8JD3+xHaYb7DLLgI+KIJ2tWejo17fC/2mj/Q3cHVE5PHcOGiW5m17Gy38L9jXajxcRMRA6TUPPpo67tlzs70qjRJ6UHtx+8EZI3nzPuCufdRMBGC3HMSBql/wAw8y1yUbs6Bsv7zg7JJERSHOwiZ+22Ne83wflEiq+Hw2VZ44KAg/YecB/ZcIneuuUr6KkHCX5Agb90Tt5lN6MG4dhILrB4GUhYvn+vKSPQ7urYvdbkk3aSNDCKbZZbOX/tuC8R40Bzw+2JcJ+aiahG7Bmtm4ckKR1GnvSH5H6v19OoDG3EXaimmCBukoKyhs+wxT2cf6afz9g/thlCd+4Y4zfCFRObR0OLUcPGlpam+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5cf835-1782-479d-e91f-08d61aab97af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:31.4098
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
