Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE05AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4282087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JEiy6p8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4282087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbeIXUya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:30 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:27672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731884AbeIXUy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI0vpd2rESHaHKa6ogQZy4aARSOL69Pc8Yj1shyqDWk=;
 b=JEiy6p8FsZw8VD9dR5XGgByvWkX5REKeiQgf2g/qyVFl5ewy0jm3TP6OefnKfjMTNEsVxP8jIQOZVz53Wr+Yte9WYJbcWO5NFf2WuW4GRZO9nzUmRFFv6t2nqHl+l7HHrEtdpJ89OLuMSzG850AAiN0giTx8Wdfso3RgT3v0jpI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0136.namprd21.prod.outlook.com (10.173.189.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 13/13] tools/vm/page-types.c: fix "defined but
 not used" warning
Thread-Topic: [PATCH AUTOSEL 3.18 13/13] tools/vm/page-types.c: fix "defined
 but not used" warning
Thread-Index: AQHUVBXm5Rgye+eXI0aZcmfb5Ey31A==
Date:   Mon, 24 Sep 2018 14:50:14 +0000
Message-ID: <20180924144959.164754-13-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0136;6:kfpAvrq0fVCIbXqeXXTvGZCzZG1TYwDp97o9gxPrv/VqRl9xyqzOhvcBsFj6kIfRaAC+8SCsuAK92hAX/j8buNqWKTcQ9nkmMeDV5iqWBCosW8dmRPzs9ODpxwInOv1BN5ovX48u80lZ5uWTajyWMZZhNuZy3EvQg8ktAiRjg04cmKfgUNf/ssE0UUZQKMeuON2BXix2RPezbqXTkStdlgpNh7++EBduGChclK2wrhCavivnThJSrLHO1ctNfmlT+6Cqx6uD/SVdAyf8r61EeeVT+xYy4A723tqubQajFpLvhEdOl9tfvS74naMMQh6VStOzIeaa80e9PG/RqvKXupwsbHAjZ1VPIya0HOhtg3LKQrGtDpUO+xfYnlcDOGnJ0r9vBBsW3F27mf4xh2+PvQoLh1qJInb/GZuMx8ZpxB2HkghJEmRBcGjX9CdaAUKObZ8gXQSI+jRSivFzt5aZQg==;5:kq3LFMgfE5UH6AwjkgnzWPLsAnpwcw+QF3ishwsk+PXzvsWoMh/crGRIjOw8nMEm3sI/0FMIEUXGMBynF91Hft5d2I9Wr094LZ39B2/+6A4jtTt+CJlT/kxe1nq1OINAOZc73jH1YFEqk6GMSE+A37gUis497WV50rKLubL6qqM=;7:s4pj00fjPpLeazwTpfExLGe88TV9/RN56RWXFVRjaAVnuDuu7488U6KXv64gp55oDZUkB1NJqWUHVA4Tm/7RYx6Kz3VCWC6NTOacUDFtJaXnQXZxHTj0LV8weZ6TceJc5ktPEqB5apUMQyedxtyDixCvr78cZ/Lv+nN2UsskOesUc6kvU9f4ZaT5DsiZQ9LxWnFUSLR8DtiqlpfIRugYenBefdysJnXEMNnbC+F52uR6cIvt3ik/qldrJ067MsYl
x-ms-office365-filtering-correlation-id: 310654bb-a439-4f1c-058b-08d6222d43dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0136;
x-ms-traffictypediagnostic: CY4PR21MB0136:
x-microsoft-antispam-prvs: <CY4PR21MB0136D73303544571A10B4755FB170@CY4PR21MB0136.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0136;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0136;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(478600001)(6436002)(2900100001)(2501003)(6666003)(5660300001)(102836004)(26005)(6346003)(86612001)(575784001)(86362001)(97736004)(186003)(6306002)(71200400001)(305945005)(14454004)(1076002)(7736002)(106356001)(5250100002)(966005)(6512007)(72206003)(6116002)(3846002)(10290500003)(6486002)(105586002)(53936002)(25786009)(71190400001)(8936002)(110136005)(99286004)(54906003)(8676002)(316002)(68736007)(81156014)(81166006)(22452003)(2906002)(6506007)(217873002)(4326008)(107886003)(76176011)(486006)(66066001)(256004)(476003)(11346002)(2616005)(10090500001)(36756003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0136;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7v55nuJ9QBicyNlNcirKw+GddK5n0fy+g0GVOiGKBXcrTQOp0vV7IbjtwtP0lmf+mAJLC1Heh40fIyqD33XnJoKmTTA/o/zRjlV5d4tRERCEza6O+h1pfgZWQM0yO3EvOaXz0XqbICNHYL2MKcrhnDMIf73WIZqF6Sn20kuElNpkLYrETAAPBsQ0cfrCaFNDY5PKap3TPqjIIJNc4ZMV2LvpgyINDjyo4D/SXUFhj0OT0gfVoUWtr9Ru06H2lBtJTqxyekE9uwd+yHp1TJvFBVfR2egDPDBWMm5OZ4/4hnVWjXhNrB3TIf6Wnia8V6k+dvleri/6gB9sToaTh7GyCYPuvUpn/aHfbRBY3NV1UJQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310654bb-a439-4f1c-058b-08d6222d43dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:14.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0136
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
index 264fbc297e0b..881bad578f1e 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -151,12 +151,6 @@ static const char * const page_flag_names[] =3D {
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
