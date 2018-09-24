Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557942098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cP1KwuNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557942098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbeIXUwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:13 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:46976
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730550AbeIXUwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppTm+256gDvX3EPFXx7uQPErfdipw3kxkNzVhM8Jf6k=;
 b=cP1KwuNwA0aZXkerJDyuhvXUdxxO6aFLVZgGU6D0oiNrrQrnjVqMv+JPPOd4HIjWnyu4rpVa4owx1UAogD9YpBmjNbUVqv8v2/wrj/8N7GTnb+blbhSsgMKdEr16Zw1RMZ0RBfRwKrwpyoEzsSluyVuIq4/63Yv29mptWCHLC64=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greentime Hu <greentime@andestech.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 66/76] nds32: fix logic for module
Thread-Topic: [PATCH AUTOSEL 4.18 66/76] nds32: fix logic for module
Thread-Index: AQHUVBWuf4/ivVYFnUCy6c2yN097Ng==
Date:   Mon, 24 Sep 2018 14:48:40 +0000
Message-ID: <20180924144751.164410-65-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:gldG567vPmrpUdZOz94nESfXuOt+LPOy6SfKgqzCD+Pbj2dO4kE8ZBhd55OEPpqHYVDopkOEbsCe/jxtk1A9eJFqdgdJgMJE97IN89QoMIx8ZYqOlLu78xZBH03D/2Y06mFLoFZCguT+YsR/sXP6H+lvqrshFGA2xldQ/PioU2DPk/IkoT4Dl0Eg1cVEGqzGXahF61xX23YGMU1KQ2Df+C6NzOmG0Sc3JFjVwORifi13s4aSKAESgC0KM0W9VYrmacwSRR6HYpIuasqXGOJgXKVwK3MUWmaMl3zO8eyvZkzgPIrVeqTPTYfgUXLS4fJe2WpiiJZ0wJxT5LoWaQt7Dk3OW9jX1/Pkw/YQDquflbu/BdaR/IWXCVM9HjmhAYiOr0nIrLq3JLH5kFwXbHY+N7OS3TFJDKhFckW/AaypmK6MiD5imkKtWFzYQj+uGRCosi0DZnYjUuze3pWUkpHBvQ==;5:PeDxDudlehiMEIoEooCN0lh4UrBTPFQum8Dy50aE8VOJeP4eIMGkgOJkNYUwtShj5ehbTStlraDugLnkcPsrOBawA7Axmc9Cb+P4PvNzYYaWYGlYQRIsU55CgZ/CQKy0YymAKwmoqwsJlRf5eUD7YXTwU/+L710wpwnRpVpUBV0=;7:3j0KNLmOTQ6RbwnXLn/QVstlAULlbgXA5nQnRhoVV9eQb+qJtPLXKc3Hv5FLh/vzWAeH1IXUM2zWG6n35cg4Ex2kwvaZJA/NfjRtEURSiVeZC1GcXdOhhdyPJhq+Iowz5wkBk0DbmtLdFgS5OxKg7MDJ9juLgys7ls9Z/54tK55trOFz7ZlzIRDdbi4oMtHXIvYcdhq0ZYJRa5vbCoMB0OzWEesMg4CvISkcvfxlAm3mkiJ9EgR/10cnrEKh/ZtO
x-ms-office365-filtering-correlation-id: b43c8a1f-a1ee-45ca-de61-08d6222cf1e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04710EF45949D58F7960615FFB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(575784001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mJQwTXd9MM6dFG2FmAHZL8muUazgr2IONjyU9K0L8ayY8y1JInTKv9M4nrPBgkhjtCsy1bQmRPqKAyXDhEV8aOW332ktgry5Evw12j0eXW7X/MzdEvoorXIdKvvZ9JYakWdmthV3iWkCojjNNn/NijP7gN/ClSKQgzLzCd84kvqVe21iVdjOFs9DD+qnIcx5nGc03PQxnGVkDbD5DKr7ynQbEXRwaZY6pyDnEjASWVB2f7IUhOVoa6t/STSF/Sh/AC33zLj8nQ/yWPkVj6dquEHLtwP6qpMUb16HWw0ulHCj5M/PbqiB9tbFrbxRp3MuWG+XVzUZjJJoWdghoiupx8H1yN3RMxml3d1C/1XcS/s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43c8a1f-a1ee-45ca-de61-08d6222cf1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:40.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

[ Upstream commit 1dfdf99106668679b0de5a62fd4f42c1a11c9445 ]

This bug is report by Dan Carpenter. We shall use ~loc_mask instead of
!loc_mask because we need to and(&) the bits of ~loc_mask.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: c9a4a8da6baa ("nds32: Loadable modules")
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/nds32/kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/kernel/module.c b/arch/nds32/kernel/module.c
index 4167283d8293..1e31829cbc2a 100644
--- a/arch/nds32/kernel/module.c
+++ b/arch/nds32/kernel/module.c
@@ -40,7 +40,7 @@ void do_reloc16(unsigned int val, unsigned int *loc, unsi=
gned int val_mask,
=20
 	tmp2 =3D tmp & loc_mask;
 	if (partial_in_place) {
-		tmp &=3D (!loc_mask);
+		tmp &=3D (~loc_mask);
 		tmp =3D
 		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
 	} else {
@@ -70,7 +70,7 @@ void do_reloc32(unsigned int val, unsigned int *loc, unsi=
gned int val_mask,
=20
 	tmp2 =3D tmp & loc_mask;
 	if (partial_in_place) {
-		tmp &=3D (!loc_mask);
+		tmp &=3D (~loc_mask);
 		tmp =3D
 		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
 	} else {
--=20
2.17.1
