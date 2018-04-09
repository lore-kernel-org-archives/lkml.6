Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239996-2-14014704941084590421
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239995; b=VolbSxhLsAzEngomEHwiWoqQFZ899LwCNGjOyyU7lDqUw/mJ9n
    LcOGIjHlAxnhrlVI9BZqamGAlu2i8fvnxsg8nSioLPcWDj9OWMEM5sjbPFbA04+x
    Q5rTacaHMICl8XteY4iDUpBpNmFNLAsV1FIp4+5UAnlmQGInq9tMY6CbRxI+EeIE
    kKVYcxzMYGmFq4bO93Yv9zo5ohP/pmgSs/ovrlIMmzuEZs1PeQd0em8Hh3Do+wnT
    I+f+OrRZRNqLS1D7iwixPhRPZWlrvVsef6Hb6yChvaqVoiixx9elaNEYr1AEefEg
    vuwidOlmyuM3ZQr3SFOwZXX0H+JwParqlNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239995; bh=TysQ1PN5+s
    DdqcHDiZdKjFUB+YI3lmx4eLemUSFOxc0=; b=n9EJ2JIimxunjP3EC9CcrK4kWw
    Ozw4QC8GVNqpnZ7amWxCyseSWwI8F+C+AXwHCJ0lbpr27M2UeU4wyM1dO7w4MOqE
    OuiTmAgJ01G2bIIOD2is0wm7iXzfZuWwKjTFsywc3JXKfLEVa1si5YJ6P95OJbEI
    6HJZt1kjf20Dajlfxln6SVe7c2Vc9OYPB+HvqE1/AQGsOh0PBuqX9JcRV0Sj0HEZ
    vGU9Wm7MJliFBFIsloWsDMmYMQ1V10iZDdMHT0nv1j5pQnDBELkEfURvDSGValsW
    f2Sy1poxJPT7vAx9bTL6xJxayQaA5oC3R61NbBv5fogtyhzGnwB1dtiQjvwQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aREfpiz/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aREfpiz/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGynurnZfQWfbEgivjXbRrG8gjkvnoKb458o68DLpXhggv49gAwpychIcBk7cuswV6lzGnrOdssjwWo1WaZe5i2bNOdQoz2wccaMsCMfR/ykxNlnoQAd
    RCiiIgjId1m6BjsQJ9bVIDNPY1rHFxG1j3K49yZ1kvP8yP+SlCTS+8tEtQY5T7N6geLZQH+6R49PvU70Nc0yZFHLjjD73zHc8vGsrHQvwfDNb6Ej7yUNlG4r
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=DK71M3eg1XlkCCJWKQcA:9
    a=q5JH5klM5hVBZkxl:21 a=Gx1OJJjL2uEIAqQd:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757876AbeDICNK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:13:10 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756191AbeDIAbL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 157/293] s390/pci: improve error handling
 during interrupt deregistration
Thread-Topic: [PATCH AUTOSEL for 4.9 157/293] s390/pci: improve error handling
 during interrupt deregistration
Thread-Index: AQHTz5kvsDq4E594cUqZYssXKjhPdQ==
Date: Mon, 9 Apr 2018 00:24:55 +0000
Message-ID: <20180409002239.163177-157-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:P0o21XLIxY6HczMdZXLcz2Q+PcGWY222d3aib/+2MNQDfgWhd7MZ8bemnyMSGj1p9HlpGNwpiML4DGYQhoRP1MUCj+zEEdm/aJ/E6OpxCHzdwtNZGWGVpel98EMMIi/rDstCn6EPa4lnFA3RN2Kk30LMysMJhxm6vAPUBzNdN3yFEoXkQpJ4PZiJjKK5jxlThgb4ZVZMxv0gPHrGnhMBjBLO+oplsLwzwllMoQfu41g/z0CHkJBmcFza87Fi3yZs;20:ukYkIywpgvml+G4w8dNB5oty49BRxfzzZ2eI5jbvegir78qsvHHHZKtNqY1JELW21rlHG4l6uHT72p0zGauASrDc/ogIPzDt+nqsES5rMKRl7qDY1jv6ihDpUhkKuGHUWJ0+ieBQkWQvGqmwXs2aEUu5ovTUIxUnWlji0HbEJVk=
X-MS-Office365-Filtering-Correlation-Id: 0667d41a-05ff-417a-d84f-08d59db130be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917DCD290F4923C4306573EFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WyXH9MzTacl+IXbcjDST3gNSovotOpCP1Cs3jLai5UPoeebSyCMzUa9TYaa5CRoqmrczJfP7uYh4Vj/afs8+XT/c97vtL93NatqScuQc0Pk2QTm6uoUM4Wc1JNeho9lOkEwBFC+LVCUqJHzQKXVIs2xDJ7JiY3BxnfeH+/mMWbdlgoLwe5khED8MsAdv426oyDtQ8z//N8XfAyOrSEFLxV4NvQmwxIOw0tMHkSrB2OvAqA7956Sf/nCEjLyrlCjcXkinhQMl05blcDb+y+7tAzxS+Epyuj32B8oDFuSjoqix6lYNAgbpqNUpNEbTQh8TBEePzUOKgRhMdlE5bJptNJMFOO5874Y2QRnPGSV8D18ayRWSuW+J0ByWKaqcL43T4cU4Edny27w78UQUuGlXsi74E0pT6oIm7u03LTRfgDY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0667d41a-05ff-417a-d84f-08d59db130be
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:55.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

[ Upstream commit 4dfbd3efe3f0cf9ff1325b87491e1b1fe07afaf1 ]

When we ask a function to stop creating interrupts this may fail
due to the function being already gone (e.g. after hot-unplug).

Consequently we don't free associated resources like summary bits
and bit vectors used for irq processing. This could lead to
situations where we ran out of these resources and fail to setup
new interrupts.

The fix is to just ignore the errors in cases where we can be
sure no new interrupts are generated.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/include/asm/pci_insn.h |  2 +-
 arch/s390/pci/pci.c              | 29 +++++++++++++++++++----------
 arch/s390/pci/pci_insn.c         | 10 +++++-----
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/pci_insn.h b/arch/s390/include/asm/pci_i=
nsn.h
index 9e02cb7955c1..a74efc02ad2c 100644
--- a/arch/s390/include/asm/pci_insn.h
+++ b/arch/s390/include/asm/pci_insn.h
@@ -76,7 +76,7 @@ struct zpci_fib {
 	u32 gd;
 } __packed __aligned(8);
=20
-int zpci_mod_fc(u64 req, struct zpci_fib *fib);
+u8 zpci_mod_fc(u64 req, struct zpci_fib *fib, u8 *status);
 int zpci_refresh_trans(u64 fn, u64 addr, u64 range);
 int zpci_load(u64 *data, u64 req, u64 offset);
 int zpci_store(u64 data, u64 req, u64 offset);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 03a1d5976ff5..17f81991ee9b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -116,6 +116,7 @@ static int zpci_set_airq(struct zpci_dev *zdev)
 {
 	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_REG_INT);
 	struct zpci_fib fib =3D {0};
+	u8 status;
=20
 	fib.isc =3D PCI_ISC;
 	fib.sum =3D 1;		/* enable summary notifications */
@@ -125,7 +126,22 @@ static int zpci_set_airq(struct zpci_dev *zdev)
 	fib.aisb =3D (unsigned long) zpci_aisb_iv->vector + (zdev->aisb/64)*8;
 	fib.aisbo =3D zdev->aisb & 63;
=20
-	return zpci_mod_fc(req, &fib);
+	return zpci_mod_fc(req, &fib, &status) ? -EIO : 0;
+}
+
+/* Modify PCI: Unregister adapter interruptions */
+static int zpci_clear_airq(struct zpci_dev *zdev)
+{
+	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_DEREG_INT);
+	struct zpci_fib fib =3D {0};
+	u8 cc, status;
+
+	cc =3D zpci_mod_fc(req, &fib, &status);
+	if (cc =3D=3D 3 || (cc =3D=3D 1 && status =3D=3D 24))
+		/* Function already gone or IRQs already deregistered. */
+		cc =3D 0;
+
+	return cc ? -EIO : 0;
 }
=20
 struct mod_pci_args {
@@ -139,13 +155,14 @@ static int mod_pci(struct zpci_dev *zdev, int fn, u8 =
dmaas, struct mod_pci_args
 {
 	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, dmaas, fn);
 	struct zpci_fib fib =3D {0};
+	u8 status;
=20
 	fib.pba =3D args->base;
 	fib.pal =3D args->limit;
 	fib.iota =3D args->iota;
 	fib.fmb_addr =3D args->fmb_addr;
=20
-	return zpci_mod_fc(req, &fib);
+	return zpci_mod_fc(req, &fib, &status) ? -EIO : 0;
 }
=20
 /* Modify PCI: Register I/O address translation parameters */
@@ -167,14 +184,6 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dma=
as)
 	return mod_pci(zdev, ZPCI_MOD_FC_DEREG_IOAT, dmaas, &args);
 }
=20
-/* Modify PCI: Unregister adapter interruptions */
-static int zpci_clear_airq(struct zpci_dev *zdev)
-{
-	struct mod_pci_args args =3D { 0, 0, 0, 0 };
-
-	return mod_pci(zdev, ZPCI_MOD_FC_DEREG_INT, 0, &args);
-}
-
 /* Modify PCI: Set PCI function measurement parameters */
 int zpci_fmb_enable_device(struct zpci_dev *zdev)
 {
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 248146dcfce3..81b840bc6e4e 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -41,20 +41,20 @@ static inline u8 __mpcifc(u64 req, struct zpci_fib *fib=
, u8 *status)
 	return cc;
 }
=20
-int zpci_mod_fc(u64 req, struct zpci_fib *fib)
+u8 zpci_mod_fc(u64 req, struct zpci_fib *fib, u8 *status)
 {
-	u8 cc, status;
+	u8 cc;
=20
 	do {
-		cc =3D __mpcifc(req, fib, &status);
+		cc =3D __mpcifc(req, fib, status);
 		if (cc =3D=3D 2)
 			msleep(ZPCI_INSN_BUSY_DELAY);
 	} while (cc =3D=3D 2);
=20
 	if (cc)
-		zpci_err_insn(cc, status, req, 0);
+		zpci_err_insn(cc, *status, req, 0);
=20
-	return (cc) ? -EIO : 0;
+	return cc;
 }
=20
 /* Refresh PCI Translations */
--=20
2.15.1
