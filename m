Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236872-2-7331640999405936600
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
    1523236871; b=WoK9qhzSnGm7zfsGB6JqZPwIeBumSUeE+zqRFUnyspYdkX4Hrv
    LFSL0XwQrDRr1BBu7uvI7fRad7nVPLdVoAQkmGr5Nit0LGfWYCOdpeZZxKSwLDPs
    hmBK9BD9MJ49r/ortXCnH5HeoJ6WgNwx4LHdFsbIUyueHy3Rrh874DjucuQSWd7f
    2qZicuDvikGxf7AWmw2mDhZw+QCscPwMXrZsoZLYSS16nJ22bDdf+oDC9R9RKamN
    iH/hDFiByxXYmzla216DCYjZaUKtQE7qn85w+Vuh/6H2VPRsFEq8fJcnjdzyKW6O
    NSatEWSo7F0mMdGgiT+Jga3gCq1I7jZ7mimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236871; bh=avTkr7d8KH
    na2eEQ0+vo0pgXqHOb5wU2F/wQmAHQJIQ=; b=jvXY1J0whyTmdGxre6yvEcSExY
    GORdK9xyvv2rCOpOHxurAxNPSeOFLKFOsXoimrG6lSL2iPUu4/k2+0wsDQXve6md
    4ysVBej6rEBXoolCjV1A+/Xcg2H8sqQdaY3fo3YgLSdb+ei5wDlS3ipVt+N+87IX
    VOG3KWg2eWleaH2juPNrLxErtyQiShohfzyvTIT7Ng99CIbzhGEW9/rFUwxvcBZD
    NXOg0jyf1Ib5SSclVmpXEjbaYWPsjls6a4rZBZ+OWwglOBbj87cri6jQeG1Gu+Z0
    +/VK5rf1SdCxRMNtHgiPWAiCwnLyJs+XuxCbjaiTx4tKc3MMyb6pXSjSYPQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i/5+IUjJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i/5+IUjJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO65WUixq8V7EgUQhd9ZIAdUX/k8CRBD3R1nT+llMB1l4UUjdjSLbx28iyarnlWXpbhxDUYCmvPl/ShLhtQRE+KFTSWjt8GHopiYn4BwCPP7Plw6yf/i
    C7/d632Vv+TP82+/CXo5xwUxNolvo/yE7Lpd3UZl5kmAyCIyFpzKsn311q/mcaUvv/WG6pfMdjWsF+l3q7hWyaNu9JLRbocOTEElrwB0RNZSjVUWQoHZKUxh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=DK71M3eg1XlkCCJWKQcA:9
    a=q5JH5klM5hVBZkxl:21 a=Gx1OJJjL2uEIAqQd:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeDIAhK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:10 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932744AbeDIAhH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 080/162] s390/pci: improve error handling
 during interrupt deregistration
Thread-Topic: [PATCH AUTOSEL for 4.4 080/162] s390/pci: improve error handling
 during interrupt deregistration
Thread-Index: AQHTz5m2lA8DqZ0680+8ss81b3nX/A==
Date: Mon, 9 Apr 2018 00:28:41 +0000
Message-ID: <20180409002738.163941-80-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:vFSFBYNpnrFfy+bQqrVfJtPXag88zbQWjCU1LLjKlpIQApnjfzycVmMDFEq9CCdq+rg3dygmYjqL7dw+FABbHv8O46MToWRbcsv6bWvVXBbG0QPHZ/AW0cZ+B1JIWoa6LCVOpv+ETGALCj9IZKG8VbwqW1b0QZ8STkdT8jUF8JSRuzLffr5FMdIHmkCtpw5g0SrLzD7OCb41gqz9c/BEsikfKLBWcqwMONw2LPq1tRYhlk2SMa+1Z3Mz9B0RJPNq;20:7w9Y1NTynVr78kY4iNyCqaHMBOyGQJ59lzxU+H4WksmSyjFgWogD4ePzpWrzi+/r6y7xdXnQ1bxPM+lo0bdKrsMZKlbbgH5SE/hbNImVrLUwNlFohyjB73TNM8wv+kcMzRtJQsYNZkAiNw+kZZyRZ5TPVaJdY1FGkJKxMtZvQxA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac4fc6fe-ebaf-4839-72ec-08d59db202a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885507329EF64E982E8F9DDFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(575784001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XQmrjtMeRI2am8oJo2MUmJKlv/Cl/JBE6Qi3aAMf0Y0VhswakXrgOYBB1FiWU36raKzPFlSkh0HFMGzT5nCVJ6FcvBPpRcw8XFg8cnt0IoW04FCG1BWc+2QVgs1RdhjgY00Fu8tm7hiYQTPGadDl9FguqB93V+XJsqDHrFevFLI16tcrpwH0hV14CJm7obhS4rnye0nkFuBp+6K/Oyjd8qT2a2gziqplL0y45PI2CGV4u950axDCTRrzgts/MpseCyQ8ORBGU/ULk9WHH99696+DFrVq6eFKVcDmIqCTKx3A/4Jbu/HCBtfO4yEiaULxWs7XirAhHj3IbGOPfQSX1lzYh5NQhBjyG3RLez15OBw24sxkyry3nEohz+dKY5+Gc6LLKC3kXmTDL8XBgIbJ01TfqEQcS24HyPC73Ow1G08=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4fc6fe-ebaf-4839-72ec-08d59db202a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:41.9739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index ef0499b76c50..d95bfffdcc2e 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -113,6 +113,7 @@ static int zpci_set_airq(struct zpci_dev *zdev)
 {
 	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_REG_INT);
 	struct zpci_fib fib =3D {0};
+	u8 status;
=20
 	fib.isc =3D PCI_ISC;
 	fib.sum =3D 1;		/* enable summary notifications */
@@ -122,7 +123,22 @@ static int zpci_set_airq(struct zpci_dev *zdev)
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
@@ -136,13 +152,14 @@ static int mod_pci(struct zpci_dev *zdev, int fn, u8 =
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
@@ -164,14 +181,6 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dma=
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
index bc065392f7ab..c005dbb01563 100644
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
