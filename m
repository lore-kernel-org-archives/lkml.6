Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3982C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740EB20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FaRZKvvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740EB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeK2JqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:46:03 -0500
Received: from mail-eopbgr770070.outbound.protection.outlook.com ([40.107.77.70]:27077
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbeK2JqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q21p/M+alnOi1GTrRO7vwZAGZQ2NEbTwr4rwgFtnfGg=;
 b=FaRZKvvLat0kiqVHYTPeHk6rCAX+TdEEi7dd836d+VL4gRPiZzNjL+P7hepWdMfhgQPRdKuvSANn840o3JX6Ycsvzi2VsQEmbER5aQQV2e+PpgKpNW1cUn6jhSzjY7nKf+a3q8cHfggqY63EWHRw25M6k4LJSbpTCjkWm8IF/vo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.236.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 28 Nov 2018 22:42:47 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 22:42:47 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] x86/resctrl: Remove unnecessary check for cbm_validate
Thread-Topic: [PATCH v3] x86/resctrl: Remove unnecessary check for
 cbm_validate
Thread-Index: AQHUh2uvQIO9iPqMzEeJwvBDdVQnJQ==
Date:   Wed, 28 Nov 2018 22:42:47 +0000
Message-ID: <20181128224234.22998-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:805:8e::16) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1145;20:92m93W60nlfAnb5L3psxjJndSZnUJknenmo97QCZfJ7Bw7q1RyAr/9jeX76XtRxF53o0vrTTOmnxC/0d0oGoa3mjcVF2zxXN+AtE/2qv2H1ZcqJ1omgKfUkdX1uxwV6diPkrEHzhDr3R5ECzu/39HukqzevPQyaIzxn2hXk15SOaWW2ONu2iY2YNgLPuQmwaVlKHal4DBVXKTY5SWnrrzWtuEsU3QrYhD8iUmZoUSCv3QQLUy1jo85yidsfXBHEo
x-ms-office365-filtering-correlation-id: afd8657f-2817-47d2-fdce-08d65582d1c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1145;
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-microsoft-antispam-prvs: <DM5PR12MB114527E2FB1C47E8BEA3C1FA95D10@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1145;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1145;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(4326008)(97736004)(486006)(2201001)(2616005)(25786009)(72206003)(7736002)(3846002)(36756003)(476003)(305945005)(71190400001)(14444005)(86362001)(8936002)(81166006)(8676002)(54906003)(110136005)(71200400001)(6116002)(256004)(102836004)(186003)(26005)(1076002)(53936002)(316002)(14454004)(106356001)(105586002)(68736007)(5660300001)(2906002)(81156014)(6506007)(386003)(2501003)(6486002)(66066001)(99286004)(478600001)(52116002)(6512007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1145;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6k6B6snx+vNnTTXBPj5wdVURQct8o7PB4dmzLS6tJ+EOgY0MCTdRLNOq1F+/lIV1s6LnLRg1fN3Da/q8sZS9T3TvENurYJhKRlnx5Uc/nDAdD/RBWu0xn2L/VTTm/7mQ65eXAuGon0qLP4VvEz/mjOIf7H6wmYCRQ2wAZtOcGeLimRHtbaj0RLwsDHgASvWclU/y/i0NDzjgMd+wEhZz8YEC85jfMwwQ2sRlHqXbiO/8scU9YezBjJrF85ML/efYDLlg38xlImtLDA+c+FxZqTBaVtjcPbG+8lGQ6g9twiD0yyPuSe2fu9+wt+S+456U7LC7Dewi28S5RyCoYsNqtFFQE3bxFUutDkhBmLjU0BI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd8657f-2817-47d2-fdce-08d65582d1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 22:42:47.5800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static checker(smatch) reports the following error after the
commit a36c5ff560fb ("x86/resctrl: Bring cbm_validate() into the
resource structure").

arch/x86/kernel/cpu/resctrl//ctrlmondata.c:227 parse_cbm()
error: uninitialized symbol 'cbm_val'.
arch/x86/kernel/cpu/resctrl//ctrlmondata.c:236 parse_cbm()
error: uninitialized symbol 'cbm_val'.

This could happen from the following condition if r->cbm_validate is
NULL which could leave cbm_val uninitialized.

if (r->cbm_validate && !r->cbm_validate(data->buf, &cbm_val, r))

Looking at the code again, there is no case where r->cbm_validate can be
NULL. cbm_validate is initialized based on the vendor check. It is either
Intel or AMD. In both the cases it is initialized properly. Remove the
first check completely.

Verified the fix running Smatch.

Fixes: a36c5ff560fb ("x86/resctrl: Bring cbm_validate() into the resource s=
tructure")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2->v3:
 Removed the unnecessary and added detailed explaination.

v1->v2:
 Added more details.

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c
index 03ee13235a45..ba11f54f5ab8 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -219,7 +219,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_r=
esource *r,
 		return -EINVAL;
 	}
=20
-	if (r->cbm_validate && !r->cbm_validate(data->buf, &cbm_val, r))
+	if (!r->cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
=20
 	if ((rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
--=20
2.17.1

