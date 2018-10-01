Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF46C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0354E2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nLLxK1sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0354E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeJAHOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:47 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbeJAHOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMDVlDqOSceLBV9jVZjUNKnHDGf+iA3jtz5+xXkVDvI=;
 b=nLLxK1swiiO/DN4rLhHpYf8dv+mVOInO4jEn3D1OaFYSyF2IDNRYN3Wvd1FNFo0BrPTP6FQU3P5da6xsDqHapHkW4TbHZzjYYaDrvEvctgRSO3zkyA9kQXEfqRAirEyqbz06mKHZL9jIe/nyhA2mFBvZiRig3eDYBCMmPrbEl04=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 62/65] xen/manage: don't complain about an empty
 value in control/sysrq node
Thread-Topic: [PATCH AUTOSEL 4.18 62/65] xen/manage: don't complain about an
 empty value in control/sysrq node
Thread-Index: AQHUWR8ZQQZeM84ZYk+O9P7xsJBXvw==
Date:   Mon, 1 Oct 2018 00:38:41 +0000
Message-ID: <20181001003754.146961-62-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:qoHKXAQ32xFDHtItHCW+VCirIyJCZxw2FlOLspra7j9MzHSlJanJOzd5MRsg1ujc2vx7LtHgN1+v7pwW2DDWyI6Wy1mbHHlZDTAlFSNkagoWPFDqVL+tKiV+RA29GrCA9h9tXGck9zccsOkTpAwqYBIwH8DTwkoenwvB93YxqIKvvEOSZCX7t5Tb3J7IYXRiwiiiuHEXkBYzvC4dqHWvd4o4OJrsHKasUtZlAZxybCPhxYoSQAOaTDNVJIO83LXF+bj49vmHS0vmLl2vQ2Icy+Aoz4DFF2gKSQGPKC7NtEaOATVXUNth+168d+PUcQP0vaCVergA9EXG82YmjEGv//QWZF06d5Ulbn7HDP7XvBlFmJkpYGtEA7S01seBipgITg9LC0vjsT7YbxypQNl3b/T1INQr9ZjueANZ2Yi8UOwb9pd1s6uzeSiuN6UTWimgEmZYZpJXXuSbPV+nWHejzQ==;5:q7/Rgcau7F7WtqMsj1WFYsWO7JGqnlA/QgY8QmADkxX0lgZW8mg8Yk6a+GL4K0UkmSH+JAH66/HMZMhiDDLqDvI2wk8r/o+wYqQ8vHcmJB1Wm42AhzvihdjNgAR1+nhg4W5FLfX9fG8yNlzzCUa2YhRXBVtAALxg/A30KyeeFxg=;7:zG/YUUN28EBHGbz32QjVVK6v+UZMrc+Nu3hpibyB7NNXmh1hCSch6VJ/8dsqzxutQMO7XLvelZ4f2xLHUZ2QEWCz8C0/m3QD5qC8LCzOfVixOvj69Bp10NruvIwxVQdsI0tXcCCKm3hzt4/3w4iDg5Zwgiq5g+T1IXXUaBkRJS/rjnj6L7CcvUWOMr9T8MiYHDA+xHauaJigSzZli1GNHhZXs1tDCvJyxBHw1kB0dNloMkzPtSxbcOPcd3fDx3Og
x-ms-office365-filtering-correlation-id: 20c68a10-e02d-4117-45d0-08d627365d5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0696F7ADB849CE4120664BBAFBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(70601490899591)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(551934003)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001)(13914002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 489aov1HjcykKrWZb6pgUu4EcdeQybWqm8mF5GX3oTduIOR08N3UILAkWAXzio2yB4BVrXzAsK6Tpn/31A+mz/wWRBTP0RahvW9vJwu60/e2nT22E+gRWPPpijTvssYLtzR4SHZuBenkTlMnXIorlYEi5hK0o3QWW9zojZqO1Ma0tXX9IT2KIvmwNHQ7jpsrDP0YgCIVsZqTaAkrjTBRdOvKirwxfHin+zyj+mxNUFd2/ISdB/C3lnL4ihELNozYMDcvSHHlQ3UhliEsTsRjpvJrVZE57B+6YCBlQnO1uVoz1FJS62PoKTeeHszdyGEypObQfttq7t5B8Uvm7KrxQov5m/sgyJ9lP8f0z0ikZ9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c68a10-e02d-4117-45d0-08d627365d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:41.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 87dffe86d406bee8782cac2db035acb9a28620a7 ]

When guest receives a sysrq request from the host it acknowledges it by
writing '\0' to control/sysrq xenstore node. This, however, make xenstore
watch fire again but xenbus_scanf() fails to parse empty value with "%c"
format string:

 sysrq: SysRq : Emergency Sync
 Emergency Sync complete
 xen:manage: Error -34 reading sysrq code in control/sysrq

Ignore -ERANGE the same way we already ignore -ENOENT, empty value in
control/sysrq is totally legal.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Wei Liu <wei.liu2@citrix.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/manage.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index c93d8ef8df34..5bb01a62f214 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -280,9 +280,11 @@ static void sysrq_handler(struct xenbus_watch *watch, =
const char *path,
 		/*
 		 * The Xenstore watch fires directly after registering it and
 		 * after a suspend/resume cycle. So ENOENT is no error but
-		 * might happen in those cases.
+		 * might happen in those cases. ERANGE is observed when we get
+		 * an empty value (''), this happens when we acknowledge the
+		 * request by writing '\0' below.
 		 */
-		if (err !=3D -ENOENT)
+		if (err !=3D -ENOENT && err !=3D -ERANGE)
 			pr_err("Error %d reading sysrq code in control/sysrq\n",
 			       err);
 		xenbus_transaction_end(xbt, 1);
--=20
2.17.1
