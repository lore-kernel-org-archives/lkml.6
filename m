Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E6C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7CB20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zb/gxpb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7CB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeJAHPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:45 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729719AbeJAHPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GIJc8qXLX50gWrLsjVSyIu2r8Cc+TDeE7Wia57kXLs=;
 b=Zb/gxpb9At4Gt/93/tcgECYhIotfu/f4nX+VJfYm1ZtIsOlg6fB6Wj5VTiaJA/DgJp4GONkOd1xz1m2qnemnCq6bzFnIGGy+XsisfBMNTUVAHjj52CSB5fIfuhBeNEI2dgFxQ5bR5aKRK/pFUI2TAvm5LK01GaqCFiuNWVvtOw4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 35/37] xen/manage: don't complain about an empty
 value in control/sysrq node
Thread-Topic: [PATCH AUTOSEL 4.14 35/37] xen/manage: don't complain about an
 empty value in control/sysrq node
Thread-Index: AQHUWR8troF9VoGqJUyp8gTKWHk0tQ==
Date:   Mon, 1 Oct 2018 00:39:14 +0000
Message-ID: <20181001003850.147107-35-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:XjC7hk5mPE0lLgxvuk9m9j2yGRkLNFYOt9QvLlWx/HkuzEURwSsIRGDMm9sTJAr0I4wpzVjAAHsbDv1xga1ATU4UkiImt3dlsJsQ5z3+DweNvQWYOz/hmzMfLv1WelGi74EQ3gfKQCJK6ZjZA4r2zrozzreim6tnr/S3GFXh5/MQzN7Muylh+nfyTCFPunHWzMy9+B6XQsdl4nEerzpXXG2iLG5Aa0exnsGVsmuPnXaJncR146Y1bSIP4LqnXv2a7OIpDS2oOa3t7bCGIAvuLhuQZIzEBf2U61XtKcx3hpTEhNwcIM+iQv6AUEKS8Ldjmlh7CM0uGTVZhl3J1j00QBR2Xpjkl+ZApRZfwGQZZDgCCeWyFqlxnYMfnlCipBnjWePTyfY/fJWuRxwNfqulTxb4J1aw+0Bgewg1RFW6DwnZ9etrbyeh9pihlTYHHT6ILYdEKOe4y41+mCnU5LPN/g==;5:qwmp9rSDU3/C5/InAR91lt9ZxncZqtlRT4jsMQx9F+I9KDyS4lL5Cbz9q3dVZ0TGSBXD4XLqGqK7uta2oShzRBG6+r/kOXwWkAoiSFaRkm6tw7AUP5NvhuzIjxJNyOi7Yr7ZQvefoNPj0MWX3SCG0tNVeivR+tJTDTvBRjAv67A=;7:tIi0fOI5eJh9hPqgmDtVOHs8Tb62adRn97jwYFEJdA0tUG7ZFb4l6YwI9pR0/l18PeBrbWtVY3qm9ShDa0dvDMdMujctodK4S6qfX/q8yr43xOw4MY7OEKrXoGD8inDGjrOpFyUqSMg/mVCU2bCC3rxUVu3eLSLtIqFMnfxVToHp1BTYE6AxMgbNJ08kFm19C6vkT27lDXtzw4fgJP3iK/lKwb+pz9C7hf8DK7A0YNQTl4DbYg36/M0qDK4xeD3u
x-ms-office365-filtering-correlation-id: eb6f5635-58c6-43a4-3348-08d62736775e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB012054FF99F596C6A2992F81FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(70601490899591)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(551934003)(2900100001)(4326008)(6666003)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002)(13914002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Np8RPECR65b07QExGMziUmOZ6v7esRiXxHX7VKWwO/f0CXz7tHIQyIWsyro3vjZXTejep7WxxmVap+dI9aVr/ax/qLSj6nyFXNoxKvrICE6LU55U64XGlGZTFY9ko1oQ/z1qoTGNI8T91nt42ajDGvq/sKi9/fiopj1d0c3glIaor3DqRPkwtjmXW61/Lv52/RjnUInCMfD2yTUt5Ejjwgbl8k/fsWvMWqcHdzGN0diqNMcUM7RkRedMaL5wASR5w19YyXs5Ra+qsWSR4KMh9VAVHfnbKSAPKjbQGXOokthH+WNO+Y+qXb3auJGyahUDR7+NwnN91BD3MfYNvhFdEqPQrC74MougtItSQjFHyFk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6f5635-58c6-43a4-3348-08d62736775e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:14.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 587d12829925..0444ebdda3f0 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -283,9 +283,11 @@ static void sysrq_handler(struct xenbus_watch *watch, =
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
