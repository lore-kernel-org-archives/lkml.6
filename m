Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E82C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E722087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hez4jtyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E722087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbeIXUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:41 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388864AbeIXUxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8lVVGpOQUzzvcoKiQMOAT0WhOLx+h7+3yaJQJ0xVIc=;
 b=Hez4jtytaFGyHsPym2szEtP0Qzuf0CWkKvpBwtvH8Una5f6ySdSGTd0yDraKFJ9oT60cf3RNRVLptNsmu3553JkMZGI4EGbLE/T+yC/z5LN6MZB3V4VAT6btShspRpCYS8H3U7kjcvZ6IwrLNNalsZx2Qw/w6sfdMEuZ8ebDivo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 23/23] tools/vm/page-types.c: fix "defined but not
 used" warning
Thread-Topic: [PATCH AUTOSEL 4.9 23/23] tools/vm/page-types.c: fix "defined
 but not used" warning
Thread-Index: AQHUVBXQ8PQz0wQ1J0Kn1juv5rJT8g==
Date:   Mon, 24 Sep 2018 14:49:36 +0000
Message-ID: <20180924144919.164617-23-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:Rmt7Ui362h+zWkRzXqI9RXAiS2yk8A2SvtE4InplP0lj5yOJDUZdGJveyQRjLZOGci1Qj+e1AVCQDEgT956NpoUtNI4nsGj9+D3f6Xj/1YHTEwHzfhUkc1ibayTgSToFEug4XsXPeZTzKB2Wa7gpe81RnCGMchjYiBJ36N7vBiXQxUh4euOWTnmPGYmEA2mpzpbNIWwN4gfJXJh+rlY+9MatLuE5I7s/2C+p7jYV7SjP3iz3sqdZ/kLHYwe6/Jv09cFDp4HCXmgG+ZU1kfJiuByMxTUJKtyiIaz2k3zIHcykpfsgJBgoSCSnrRD3wAkIUwUPdiNAt3oIFze/k0WQsnZP+ULJIeHHBLsL9oIbjS1J3jUaCCpr+obIVaVmGkeZ6xyJINmVGMH5RzbOILWR823MMWTJOoKIVOUHxu0YiAX31iwBWXp8WzNufpyJteAViEtg+PTtQWgMCjhok+U2jQ==;5:NczpqLmZK0NgfeUBgCyVKUHoH2LCX54+2L2ffD2ajSshwLyvVj5WzOK2058H8rh0sVREPa4EtR5Kz4n11I3fSnx4s59kttvFTbm+ghE+QQyHCdNP+VzsgKDfgiojLSkdXDHenG+9dXlORb0LfY9Z/CzgnqNQmUxJ5siTwNwjWE8=;7:3sT42bXsp9xh4F82L6ZEKjxhrQP9PTnzIlj0YcYwxsen53i4M7qj4jXLBwHBVFX3JglwxVrpPu0lkFfNZlblSWpwZc7q2R3lFqpJBa/YpIBnErlcuiljqcxCFPpM8L1QhqKYxwGtuXRv3Mk7o8498RrC7enQstc3EhUzOVCZseALhqiIBdhnfxZQ+xIeJfjQqu87BTxWxz9Ho36NSMWe4RYRXuHU16jjEiaDZeO2d0E0xCsFcY6hHQB8/Wm9B1lS
x-ms-office365-filtering-correlation-id: 45255b2e-1066-40b8-7c6d-08d6222d26f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08218598C90C569FC862DE8BFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(6306002)(256004)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(966005)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LEbmKH+Wm7ssQEqZfPO+r7LYOfrwkF5cwYS6OzVMsP9dFkpbvTue3bwKr9EyO8qmnEUBcBYnA2QmRUtuuoAzLhx7R0JvDf9avIu0sBpEHZ+W4j6l5YQLKqBFyuIsMLaMB3kU2yhMapYtfjs/270bWcKFmq64xMivrLXNanvQbtRR2ScaJJum/w6mRxqDDnhm7DanynWy9vnkspoKL2FJkScRPaWWC0bhSIbAgJV9e3vcWEsAvWpu+MyMbS4vWd2lyR36ZNcR5YMdF2cnrUQ4f4Mqg5v/J4riV+hdBC1UqkvNEwTAr/FRcUmL39gagpPbBA+XjMBcJNyHMV4xekMJRc25SjrpRMb0jGNL/SQPjUU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45255b2e-1066-40b8-7c6d-08d6222d26f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:36.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
