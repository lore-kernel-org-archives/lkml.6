Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A522087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DGhcg7zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A522087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeIXVDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:03:10 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:46976
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387733AbeIXUwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aunIi3i14ud8t0GXaDrQjCnmEKinGx7sH0JLP7Tg7Y=;
 b=DGhcg7zOeQOEtH01XShWv65USqd77K+gWbFrgUUo5j86laiTE18Yqv/IS5xqhF35Vq33otNKmj44T3MKoYJfMhORPeCjlOfx5GrTv76mbMoAo15CwVcS+2TJjYLauztkG7Hp7vCEJhjRqLK5fT3QZFBT3pgLO753+feaaPQPnjc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 72/76] tools/vm/page-types.c: fix "defined but
 not used" warning
Thread-Topic: [PATCH AUTOSEL 4.18 72/76] tools/vm/page-types.c: fix "defined
 but not used" warning
Thread-Index: AQHUVBWwFKPJ6cg5F024DrNzZeRsRQ==
Date:   Mon, 24 Sep 2018 14:48:43 +0000
Message-ID: <20180924144751.164410-71-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:znjYJjy6/xum0BzVhZg7OYzAtOls54XJ/NS1fJKOXtWrKf9/ZdFP2pYi60r2g/zXWnbhgmZp3dsmL3KG9VV6BGMbYjQqyF/JRlyXPJ2dvxFJc61vk9ZnReEFn9oWx4Gihw0iE4Nno65q1soGPCv+c10tvxoMrSXUO8VhjReAYzH45jFCwvi/HfOTGLhDCF3j2tar0jeRX5ZbqPL3D5mpv6ITMiQAwTb9Uw8bWElJW62ovrBk+zwK8jylZMZRrxMbJ05EqLJLm7rKtJCAyHshtGY5jhPM8HbwZPJQFhKvSDxIuAQ4jtZH4ObpzDJHPq8qUZ3qITT53rqPcZu1catrCcAWIaUVQ9rC4wxsMrNW2BC9SC+nP/BAMzmETSe0ZyP6bzTxdhitBG/EmV4ISsu100zf5ZQ41K+TNtAGQ33c0Ja3tcORp9D+fy1Qhfzhe7c6212MoC6wRgM+rEqud5X5Yg==;5:VqUmtPgsch5mIozQXVHmg/Mk+yKJyQI4bpq3bmjm41b/ATzC/Tpm/SBRW22L7PMty618hI2tLIIjkGT1mbqSEM4AYhK2qi5/FuZQcvKtFlxVyo42dUhpTOE+aR3UOREHOZzZWj8gWGkSXzym9I0ZMFBdFoiwX0vfsKxkKpI5xEA=;7:L8e9odKHZDLj8viyQinlAWD9FzlBZ/QWXWTn6wDgYgboPBwgvRpsKh2hx9ovcGyoJcqkXz0Io6uN29lEOreNTFyB5v9EQAh8dM+U9QTzOSWpyP+tcsapJkw7rG5s5y9atsU21ls3OCDsh1iSbMAEvW8/wInWU6Bzjj72tc+ktGo12KR0OogIsRpGQpPGhPHVOmz7hfurJfXcDz64Im/PWRb19p8rovjsOvUJtRANdCtqkmK3c69/gSAWMDdwcs+I
x-ms-office365-filtering-correlation-id: 66e97d07-ca1d-4d08-58f3-08d6222cf360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04718B879A0F5B47665ABB2BFB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(966005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(6306002)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AhZJiolexZrq8Oyhhlc7WAa6SOh5E7j9zVdzoqYVLp6/JdndScblyv2qHXgWwHMVr755M7Oc/r27HZA0ShGVOkBZohX/TCoRDYSQAoPjMx4jlDi9iUMGxz6UwXm/7GlJge4DhpvYFN6rSiIyhk1Lk3KZ01TA6nc+PFXs5UzaG0mPBOeOIhD4GamhGJkEM6FZKQGup5YM25QEMcotmGCWJH8+02GpmW1uNKsc/snpYb/CzSx7nec9WqzfZSqJj3QUXjsclbULXN9d0KzIqdDIYGMccFazd7qPLBs1/hHLajXm5VEbj5KTQG66cErxxFHSv1brGKsGjsj4rkE8IwWJQDukd2m/L+jGUx4/9t/qV4s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e97d07-ca1d-4d08-58f3-08d6222cf360
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:43.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit 7ab660f8baecfe26c1c267fa8e64d2073feae2bb ]

debugfs_known_mountpoints[] is not used any more, so let's remove it.

Link: http://lkml.kernel.org/r/1535102651-19418-1-git-send-email-n-horiguch=
i@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/vm/page-types.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index cce853dca691..a4c31fb2887b 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -156,12 +156,6 @@ static const char * const page_flag_names[] =3D {
 };
=20
=20
-static const char * const debugfs_known_mountpoints[] =3D {
-	"/sys/kernel/debug",
-	"/debug",
-	0,
-};
-
 /*
  * data structures
  */
--=20
2.17.1
