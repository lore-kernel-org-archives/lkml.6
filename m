Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C82AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3AC2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jo9kfjPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3AC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeIBRaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:13 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729570AbeIBRaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0TKlFgTY1QQmfcfDAsX/eezKvgs19fogFelHdUvEd8=;
 b=jo9kfjPxpUjCl0SNHKyrVEbxWP8MakvWBsP6eBuF4y+20rG0hfE+Z+Hbvuk2xgkSL+a7IumLXbVfOmrf6mKyDHEhxZhU95UFRU1SJXfYTV4U3g3zXuSN86tsU49VFbvrjQusTS9rJic7DnrV/2f0MV+IKmDosQZ5d4ocCvAVO9U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 17/62] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Topic: [PATCH AUTOSEL 4.9 17/62] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Index: AQHUQr7dX5jkjb8Ik0CS9dhrDzpADw==
Date:   Sun, 2 Sep 2018 13:14:22 +0000
Message-ID: <20180902131411.183978-7-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:oCLdOTnvT+juqZ98J4agDWjU1B5zoG9nNCf+wNio0HCtKDtF5gJQFgg1rW5c3/gL3ALhguEaa40l2WYz3/R+9wC/9uRKCde5z7Ssk7VqfIp0CjNoKEQoz6VOyAJja70Sln5ZjgbQXXQxuVZcd9VdR3Hha2eu8IJ/riFPiW9VZ8I655BNg9gjAf68QvznLJkswokk8CAL+LuIHLB+HehKfc8fTu6UjAmQ4SlkhqriTtdesni790EWnROUxoo9D9jFeAicbERVkMDpgF5fPpU9IM8sXPjbawdZxyo1QSxdnPpn/V8fOKJBGLliTXOEBaqaLh34gCyLbXCfh+sBr+kseSRGYjJX9PtqsL/LY6y3KsW4BxuHF6xmtKidnwDqcR/Uy1JeVdTF0kJrw4ywuyl9s8KjWcjPqpH/5axIgJN8UgBSBNfC+yEOURe7ntzBFYk6b1/mZZYB1TfjQXRQFDiOIw==;5:QIY9SQiKXa7IPtfdVrbJFsrvmEGst1RMNr22PDOfX4L8IZWh6Erf5n1fQGPT7DfOXm+7DmSI5pqz5jaIRShgWv/HARtANH9HRzPxdVQZPJ+jSzs8bOB5a5owVwjTWbJ2yE6gJbmlnXoDOQuQ4SOQ2khC/D3TEsDrn7nDYiVBUp0=;7:8lK/Wms2Cu6pzMdmRRGWG/o2I/jZrSsLbamWtN2PV4Gv+YtHQzMZ+6ZPFs43+nwUaR2VN6vR+ZhXufGz7VrAIx0xZaW701oQoINN6a6AowMxUSM6zmZ3sRQbIFWC/VtoWhZxhksrbydFucfCC8/uGRzZQ1drtcUBXipRXWhPHBI6ox4A6X/qM8sJ353XCegfTK4ygZ8MC8D1zcRCkodQAl9bK7GzBIG2aFharD8LQ4df1D8KVfRlgASMOeSo/3tP
x-ms-office365-filtering-correlation-id: c4ebc6da-d36c-4f6e-b004-08d610d5fffe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120E2A5562A2D89366D009DFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(46150409022019)(201166117486090);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OgU1langQEnRisvPK4h0201p6DaiF562eaNl5bDKGuFVwFCLuTWFs/0RHEaJpLbVxPYs7CIMbBBTdc7geu1r3MqS0X+FnjoKl6TOp9uvxKbvhg7CaKc4TIWpHuQm5Zt+9xJ67oGqnzl7Qwp0obrE2hdjimI0+eQIZotQNXR085Kfps9D29INvT7oZnZlcmoupz70Klf3s8dUh3r53ioXDC5OgrszZlKU5HfKpfOG/KUs/LdfRVlHG2AX/RocWsKsDcvn4ZNbAzaC0vodpZmFJGOckTwhaSFl6G/Ge3BASHA8HznV5YM33WdMWglztgmZoTNUpe7wWz2//8VqKrSumdeupaeIHmFRbfi+ldcPbIY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ebc6da-d36c-4f6e-b004-08d610d5fffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:22.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 576d5290d678a651b9f36050fc1717e0573aca13 ]

Add missing in_8() accessors to init_pmu() and pmu_sr_intr().

This fixes several sparse warnings:
drivers/macintosh/via-pmu.c:536:29: warning: dereference of noderef express=
ion
drivers/macintosh/via-pmu.c:537:33: warning: dereference of noderef express=
ion
drivers/macintosh/via-pmu.c:1455:17: warning: dereference of noderef expres=
sion
drivers/macintosh/via-pmu.c:1456:69: warning: dereference of noderef expres=
sion

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/macintosh/via-pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 91081dcdc272..32c696799300 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -531,8 +531,9 @@ init_pmu(void)
 	int timeout;
 	struct adb_request req;
=20
-	out_8(&via[B], via[B] | TREQ);			/* negate TREQ */
-	out_8(&via[DIRB], (via[DIRB] | TREQ) & ~TACK);	/* TACK in, TREQ out */
+	/* Negate TREQ. Set TACK to input and TREQ to output. */
+	out_8(&via[B], in_8(&via[B]) | TREQ);
+	out_8(&via[DIRB], (in_8(&via[DIRB]) | TREQ) & ~TACK);
=20
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	timeout =3D  100000;
@@ -1454,8 +1455,8 @@ pmu_sr_intr(void)
 	struct adb_request *req;
 	int bite =3D 0;
=20
-	if (via[B] & TREQ) {
-		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
+	if (in_8(&via[B]) & TREQ) {
+		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
 		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
--=20
2.17.1
