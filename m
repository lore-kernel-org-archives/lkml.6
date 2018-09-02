Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF2FC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624B9205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VMD07gqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624B9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeIBR1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:27:11 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727712AbeIBRXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udrORY81PnpCDjrqJ0TW1mTHFMFMfBQuD+0SZrzcUU4=;
 b=VMD07gqRQOVltANNe6lVFD6H2pgt87K+GBht2Opzg4dyN+ijONdVrGy11A9VmAa4NHYmECKkCSfDsKH5aEa5U4U4/CROUGozu6WKbC0spthOfH0vF1kEkOFUVtffT05oBAesRy3yM9JYPUAhO40PEtXYastC6BGM6CDsZXwnBGY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 34/89] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Topic: [PATCH AUTOSEL 4.14 34/89] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Index: AQHUQr3PmKIVWTCnn0u+3unyYZUbHA==
Date:   Sun, 2 Sep 2018 13:06:49 +0000
Message-ID: <20180902064918.183387-34-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:IIXQ8dtPQ/8nMzcThIBORCKLY1KW54MbnfFV0rI9NaVm3HPKzyUWavlaQfSWsI/q9Pluvlv/b8KKFn+8OEz0AKww2JkTy5mVI7wLsS+VOBMTaUifawxCEZl9T0zmRalyGmEy/tLGyF0GvIeJFlV1gBXD+M/MeBi2QoOa/AF7C1nMR0fGEhicpmOHIXYVV3ciJ/iR9c5jYKKszmd0tIclxkb0Re7iWXL1T7JKtsu5k9M6n+4P5/dYHtge5PwAqE1kuOKe5GGUhbxijBCwA+EeoJpfy5Cs+FiSUscIglbh3IE2KJsdX+a5X1aHweqR5H/NdPWEVGzIppbuvtzc9x3ODempOwjY0QVbVwPgDKoSTrqVrn0LdHn+Na8GQmpMoEWOQEFKvJ8vxQhjUevIDki/8ATPJZp9tAt7oC2/R1oD+3weWS3uiabJKUSQtFrO9dFs1zWVHbih/lYfToNX95dvfw==;5:JPy56AKNKyVAtahBI/Z4AkNxtIg6kz6O6r5eHXgEamll6mLDWAIGN0+BQGK6uVUyHOdctVeBC6QvI9GgR46nVkybbeMfs4YNIWc0dIRZFOrMTNcYURnfL72svxy7oxbPe9DR6+OpJ61jt0y6QNxRVgd4jpC9wJvV7CMw9l1ydk8=;7:ChpmGdCXO6uoVGmh+WWLeF4ccbMkjQeCwQOZwPkWNFvV4+3NOx6adSkgn058x5JbtIR4D09IYWanuh+p/vToYEOamA4MmUQJdC9M3erb9VGuaIj36rpvbToL3zDmYpXG4HHZDnHgecT6nGPzXL1GW3hARf+9mfogUl7pWio1aKwHhWIPHgd4UvDCb8s6c1JhBUENXwLP6pdAIdZZj0TAwXaQnceMPVmrjNm3s83hxEkAlGU1i9RVH08Yg4MJ8Xpw
x-ms-office365-filtering-correlation-id: 179a1cfb-28e5-439e-51b4-08d610d4fd1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0856010FEDE06FA233802119FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(46150409022019)(201166117486090);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1eN4bOa+1+ht9Eg5m2P087ewmx+dUitf6n1s4OQBQu0ikUjZ/BEZnqBTY74n4X/lDM6qDQNJdqQyr/LVKMpgz+3z2c0U0Kjug1xh+8cWxtvW0NA/JdwvOqc+a1U16R4RP6YhY7RFax66y/wmoT89KfxnlDO7S4dkzZLDue4EjM7I1pE4lCBf4XxXN4Kn8wD1+9AQ42l72nRISIwXuAfyjVMUU36IWqFWC/HQ+2VUva2U9gTn9/s81CxKb3EbQAwUJReN4m6Pd1KPmlAJXONF5yoDHbbZqulQjt3ztLzzBcJ3YOIJ8+/3RCxRYVIL4g6O49eQpl1j5dPWnv9cS5uKwzgeIpxj28vAm/yNbKwPfDg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179a1cfb-28e5-439e-51b4-08d610d4fd1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:49.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index c4c2b3b85ebc..f6e040fcad9a 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -532,8 +532,9 @@ init_pmu(void)
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
@@ -1455,8 +1456,8 @@ pmu_sr_intr(void)
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
