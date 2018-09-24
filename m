Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9985ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784E520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jGd03whC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784E520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbeIXU6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:58:31 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:21344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388621AbeIXUxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8lVVGpOQUzzvcoKiQMOAT0WhOLx+h7+3yaJQJ0xVIc=;
 b=jGd03whCWayhCULh2lghZfpkQmiKLYT2gK9PUz1f9k9PyAcvmKe1M6HV+DiGJKcuSDEbi6WmXIl1Lcx8WZkO0S27XJ2I02SXiyTBulOO75rVqEQxcUv8tsOm/aGAGiVb+gpp6yjmgbKSQ3/UrQ8IYY+iZkOlSDs5hKYG0xcy77Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:50:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 36/36] tools/vm/page-types.c: fix "defined but
 not used" warning
Thread-Topic: [PATCH AUTOSEL 4.14 36/36] tools/vm/page-types.c: fix "defined
 but not used" warning
Thread-Index: AQHUVBXCY3fCESK/RUCYp9B5t9uang==
Date:   Mon, 24 Sep 2018 14:49:13 +0000
Message-ID: <20180924144851.164533-36-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:1pWzHwRg2AWjvixpaUhYTND94zQw1Zr3OY6reX7TfCV82FayOAWPH8updi4J3lVxoe/w0wILKaA2kUNeEzTT5kwVO6F7SpRgJOeA7lWpqqp8a0uvxXSlQZTu2RrYNEZZWw+msJpNgKPMhpHO+pklYSrzzVIz/JLJoxEKCzrYHWt09Z3gnGpcqlMWqugiSvD16Y1UdLGxP9NwDSf/jlKlISiujsWzWrpu1o5ReCKxPl7lxqDR5rhf+rkMM2NxPk49AeGuAN6XDgCZLkor33ru+hKFVZtgwOiBAG2nOqtAUm3NhmkqAsU1UxOcNiPRUy16ApSXB4hFZrZAgdAzryJg472VMhdkjdCX5jcGXVQcFiIg2fetmB5hRRiCcZc4sTRLzFTPDjEnQlxK4ZyAmekVBuzX8s8c4rRTrPpOJj4kgwEOSVqB0YAUEwMtCpe5psDh1EmX7QgxqsoIhXntRv0oww==;5:brk2SVoFjFDh5yW7GDjS5/DFbJEgYlUoS/raCYyD/PiNQ+L3lHjRt5Ubzr5fKwHlxDsH2anU707JlREFrNQcXin6S1pq5j08hPRFjdpwecVjJTgYc9m86D+wGLRKqsEpKz38pRoA58pK6wC6SrbPPnkkFbkYrVdNMPBAV1DDHFg=;7:HBOOCne5Zg+Xk5hn3g+CxFxEet63o9V+XlB5AqAk5VOOSePNhXJUA/5Opr5JFPGZnJQXjzE4t6y3Xa+vipEdaa2r/EZGLnoB9vVLZ9HhWQFjrwJls7sNgaAIqGrNOIZKjSnCOCjY1a8Ot6+J7OrCHPDNgudGdEAm95XPL2jNhfhI7ruWzafkoMJsDdH8gC85Bg3APbwIae4c7AcBzMumbkf1ppOPfJWtXKfUR2U1UZILMIOm5ACb4u7agjQ39Yxl
x-ms-office365-filtering-correlation-id: 96710d72-9931-47bc-a8fa-08d6222d0eb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074466FA4B8E9715ED5F0EA8FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(6306002)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(966005)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vrz1ETSyVRSlzYbHfPZlSrUzVdZhIFLCbnnar/12vXcVCNFQwweccHiFMfPskqQFxkSnfYLDZpNoxFDsek4A0tbgKGSOIRN04KhHBt7Km9o2OQZMYJjlb3fFu2nNu261VpAFkn2YJEjeYbdaVobQBcgqEQvVe6kNz6cTWxTFQdthj2mNghHwrcyTjlrNwr/pRHLTrJfmH0yL4huNblVTMaaXbeYlmyZ92mjWfHyQ9WWaixeI+To0PPYCa/lrsIG75y3ahcoAym073hiVfi0xHzoTsFE548ld+V6VAObTzfp+njPNn7mqhW5K3cEZ/yvvf2ZPp893+/QQehbX4hRmMlMl4AUO8oAzfrmQ+1AhADs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96710d72-9931-47bc-a8fa-08d6222d0eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:13.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index e92903fc7113..6d5bcbaf6193 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -155,12 +155,6 @@ static const char * const page_flag_names[] =3D {
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
