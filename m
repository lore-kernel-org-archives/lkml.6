Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE27DC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D652083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UlEtvuiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D652083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeJAHSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:18:16 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:31049
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730160AbeJAHRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7gUr7LNxSlWgxRxDqxLoDdI8IbhrbFaz6mZgo23Ppo=;
 b=UlEtvuiRIEux5GKyORJqjqaD2gx5YT9lcFhtMhlR4CfhjbVl6jzNf9MpLt6SnkJyh+ugJvL+hYpZB7zPf2VRX3pUVO80KA8cu43neR2Gyhuz3OF+hdEmCJ/cOTITg5wWayX5U/fvR9KhjOMFYj0WbGa9YNnlIIAvcmFSXavVthg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 12/13] xen/manage: don't complain about an empty
 value in control/sysrq node
Thread-Topic: [PATCH AUTOSEL 3.18 12/13] xen/manage: don't complain about an
 empty value in control/sysrq node
Thread-Index: AQHUWR+LCllsCCAj7kKc12P/+0m7TA==
Date:   Mon, 1 Oct 2018 00:41:52 +0000
Message-ID: <20181001004139.147341-12-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:KFXopPwVR2wTm2dxyVRvCYe3j+1nW2fyXFP8BuY3sjP4+oKNa3bBWKI5LORGOZbjpahT8XVRKy4kiT8cNtcmCe3Vc16Y4Q01uot3M543gXL43IGqZLKYoabn2hID18jkK0VJRixKtYBEnLgEENkZMiYQtMycxsP0mR5lT4BTEp2Q/Qb8+K5ywHmroAmgddF7p2OezVq4DAkkWxCNdbrv6tBY8tNAgh55bvIeVnvAFShxjyT2upTJle7OvxMwwI61KeZIB3Q1zxYStseNH8sou7t6souA6ijnHPbpvuTByM09KhWEuDpuMYeQ/zPSsEL8J6M4EktOWe4vY+mapx/jsdnJuxLwWKBdCXMcHUrJV3O4OTqG7sVDJh8y/mxP+i63MIBRDZM3OWyLoMjtEpZFdzpRRMaAVoLC35eUVo5nNGN6KLqYo0lO88YgaM/3T/p8A0H2B5OWYjxgaQnic+NBDQ==;5:5lstxTofZUChAqnG5C9orcwiCbxdW1xu4XEDl3OpjLi9Bhk27ZZdUi2WKnhscyTyAJxQPs10WtnOvl1Tv4PszhGHHcg5OF8PVOljYpqDZ3uGm89DT2dA5xvBgPWwKvYYX6Zv9D+BL4Hs6y5PQzMoLUkxYmbStEUD5RI0D9QbezM=;7:GvDRQ1RoLJAa8cPpclftMRr0u7IHVFbF4eFmu6fxRdlQi9bB/AN4brNfueJpUWjmyIDJKoCpi82XwC5JaeJDH6Gn8uiJQ7er4wQbjOr/b7xGUediUKbGitzYz+LkISA3UXmRC79tdUEKZqzPFo9JVBdbshqg4UGQOmoW5zgBQWgGAFWM1GFpOg60sZCmxjJbnoRx4VttfcIY/1zX5wiB194+cXK7JMqr8yjuQtXSLPRpedzytl1T/6iqmUKF3y6h
x-ms-office365-filtering-correlation-id: fbcc7b8f-01c1-45fb-eb57-08d62736ae7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0184E81ED8961AEBF1882955FBEF0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(70601490899591)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(4326008)(72206003)(99286004)(5660300001)(102836004)(11346002)(1076002)(256004)(14444005)(186003)(107886003)(2501003)(36756003)(26005)(105586002)(478600001)(6512007)(86612001)(446003)(10290500003)(86362001)(71190400001)(5250100002)(217873002)(2900100001)(3846002)(6116002)(66066001)(14454004)(34290500001)(71200400001)(53936002)(486006)(68736007)(2906002)(551934003)(22452003)(316002)(97736004)(2616005)(10090500001)(6436002)(54906003)(76176011)(6486002)(476003)(6506007)(106356001)(25786009)(305945005)(8936002)(7736002)(110136005)(8676002)(81166006)(81156014)(13914002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gubQgBjFdmg7kaW0jKFz4uHnp05nEClc4jvzaf/DXd/Nknh385DSDAlwesAQgsMEskU7P+y/EHwNyBNZi/JslSEWWHLvGJvHVnpYNfvs5d1ye9gXnYPYkOAYupbUhnwWtmQcT8+/1bD95pISwnCGO04JC7Rn3qi2vGSHE3xWT9ty2LM07Bk3z6NB1I9/5Lm4uHrIR22q/fPwvQiwzcU1/GrSlYlKaS9ZQvd8Hrs3YHbqTqitcgXR/ERnjI50tpmrWth15gCjL6ITwXDQF+X/LDDPA6IHzSI3BbuRVvPY7cQvNul6N15pIjMl6YjBYHyYBXadOqcTSHRYz6aJ5y6la0syMzOdEEUdsvbPpMOGffU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcc7b8f-01c1-45fb-eb57-08d62736ae7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:52.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 77909a2c6723..101189fbf032 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -277,9 +277,11 @@ static void sysrq_handler(struct xenbus_watch *watch, =
const char **vec,
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
