Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B452C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5C620C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ehSViwNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5C620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbeIXUyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:45 -0400
Received: from mail-eopbgr680104.outbound.protection.outlook.com ([40.107.68.104]:38589
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731951AbeIXUye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVCU60EUKflZ6qwwXTgYsm57fU++D5rlG1PefgdxrMU=;
 b=ehSViwNcaHeTqL1g4fXPVxXmDSlum6hyUdCzjW8iag+oVdw1kCwhvL3Honac0coHx1ee+YDZm2YnRGu/9fGJPjv52PHTsXEgphrTZFoJaE0t3WvSPy5TaZWMW8jpaHW1/SjAC/yRAuqkdGxP8cVlmMBNPI05SESMojcF5sx8HsY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 18/18] tools/vm/page-types.c: fix "defined but not
 used" warning
Thread-Topic: [PATCH AUTOSEL 4.4 18/18] tools/vm/page-types.c: fix "defined
 but not used" warning
Thread-Index: AQHUVBXaIYM4beJu8kSpd5ccqTWvNw==
Date:   Mon, 24 Sep 2018 14:49:54 +0000
Message-ID: <20180924144942.164688-18-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:znV8/iTLB6WCcLCHEXVtnt49d9963xcZBmuUsl83xuZ5BxAUxS3SsqrR7WInnDY2ARM64xxZDd0xeDmzT6z1DzPfnReM2C3I7oaQS83+KQW9mLyJ5qCsvAhuMd2lGJo+JBsuJIZBa1vVQmexGtBDevOZWU+XamqY4cvt9PIgoWcUnq5/pN6Eoz6RzWcbBPh9aVzevcVGwxQkz6kEpb4/q4Tc/kib0l50mtP/unwDLeJQ+dhujSwkGm1RoXtOh5y0lIY+6TrjLEAR75xYKU3EHFke5TjSoT4ThTi3/n7HtDY30khqYgoItv7w5JzG9WkbRAcLSzej6YdjzhoxGGVCbmI3FV3lZDRHGrNQTpeIZbam0McwRuKjYhmCWrYK+OrxAi3AuFRTfvDJAQbRJIDmJgpZU+F4olz+nYvYksKou3wHgSWFHtGdJ4IZpWU3p2RSW/uZLGswFqisLekSLNyriA==;5:cc2vBNapJbXZ8yI9yV8v3nEndG0N4qUp/nXn7/dNTECq8sIV1m6/tQ0xfge/eZefkiS3QhI+QACHaihy/xrBMQznCRwoGuS7PEhbEaAgHhB5jOtlXZQfsH4r3HIeuCFetBMakpOfM9SP5+SCYMC+0rQJnNnnVNCOwnKtvRFTAEw=;7:Qu9C2jZZyErLeLqTK/JOj6jBvOUwqeGXaE5N6Dv3HQ/7g1uxUVK4GrC5Qp23lKDTg+pyJsHPqA6q1jiFluu4/6F/IQGT9+1NTZGRogJFWQEDzEUDSoIEAgHUnNa2/+bmCPhwq0ZcFZrdtIQYpu1hsbQWSR0x+ga3vTMf+yP8EJrfhZLQCGvNc2Z7KLtnOz+aNjuCsJFT+VREuA576d87VW6iwXQBrjVbrJvShBtBLCA2kaktW5KLfDRlfgdaZLcN
x-ms-office365-filtering-correlation-id: 82c5a895-3927-4aad-0e8d-08d6222d408f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06318E32A7E9D1BBD4052F26FB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(6306002)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(256004)(86612001)(105586002)(966005)(14454004)(86362001)(575784001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mrq93U2np+OreaFNmZCL9EAaHC0k7I8OYtTR7QJtVSMEmtZe95Zy1+8vfVvhITI047TFjpgwmi8bgk90IFUae9cPtVTb04/je7xOVYkyWBIttIYUNebwxac307vtZqNUgXekxQTQvuhVQ0waHI5YQRRtkCLJ1xqESnW0w1Z29uHud+x2iYHSY7zl/q/vzUZv6ZRFoqN4mKngUgwkzpXenJrA6mgprTel+F0xdoSF4+BE2D/JvO55Fxf7KcJdn/UqTuK5/lTvt8HTqGxT5/f/w3bGrrRV+byOgjCILLlpKycawPJl3FBvMSHz73dxF580jfBYeZQIabCLOMVRG38CmxuAF+LCkyXQilh7UCP1ngs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c5a895-3927-4aad-0e8d-08d6222d408f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:54.5966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index 5a6016224bb9..c7fcc84fc0c0 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -150,12 +150,6 @@ static const char * const page_flag_names[] =3D {
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
