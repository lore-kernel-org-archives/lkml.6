Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236980-2-5620335931105819870
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236980; b=kKxvuJFHOM4BExsRaT4f/dCDTe3vENElsfF+SYcuh26WCD5HJU
    J9tIHaE3VDgdy29oHWYqsDEatThJfRGXLInfKL6RcCoBUJTroG2TMUovD7anp4Aw
    ohg5L7rgR5MXAzCIELmuCeubMLxoODzUOX+bRNw8p6j9jiZKucHaHqiCBEo5VXlO
    DK7opoB/M5VNprxRKKj0bWwH0cCTyqg09qjn1kxf+WkVE+8ixLfvLaOz7CpUWMn+
    xDdGwAqPJUqSDgNMGnxlxOQWMlMwQscKDoJ10IN82B3vojn9SjhveZiiLiW04KNI
    CMMpS+KGiCw2R/owRoxo9LnF1BroDfYFf+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236980; bh=32TZgteCVV
    Lm1HKCkAMZffwxwvYXfowvTW+rHW9kBTM=; b=GqAxjH9buADzVTU5HscXm7Al0l
    GEYSfO2HxW+jZyaHwCYEmRWz24UzfvvlhEzJ06s9QQCpMRVERDkTXKpICZRqLxs1
    c3LhnJB2yO6s8NSOuT9dIHQYBL0PdiRXzgGftQIg/Jg+QfF9eI87QfOagndCiNuJ
    pEpUUVhN9dgMJcdu26Ndskhuf1lpfE2OO53Hl0d0qQkT63iplivYCjw54lErflz1
    1aBD6hG+QiBgxIc4PLmMha4nblM4ZZ5+75Dquvq4fGK4cgRVO9504y3e/tPgb4L2
    qr0ADbNsg4t7ICtM1nxA186H+1raPTRPSXeE9pIyt+52oxeRg8ZZUl4p1NNQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eRBaS8S7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eRBaS8S7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEZvYrnCjnZF6k+jEHwnUSzwGNMeRGBwHykW4mpAsWnEWX64ssq+EGtW4W71cfChkoGKDaOVMuknnnB4K0VC1m+40pYfwW119GpC/ZxMkcalp0Tg68AH
    wC/hqxiuu2VgDac985V80PpqqO6FhZIdeCqqMnU2lIKP9L0exiJpfx+8ZDVxSNudJs9cQyMmr/Eln3DaA6oruYM3r5g2rwOxObNbr+nRZ8oNeGRtwrIFYdqP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=0tlCN2Q2Qm8EqCUN3ZkA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756873AbeDIBWo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:22:44 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932728AbeDIAhF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 081/162] s390/pci: improve unreg_ioat error
 handling
Thread-Topic: [PATCH AUTOSEL for 4.4 081/162] s390/pci: improve unreg_ioat
 error handling
Thread-Index: AQHTz5m2k7pZN3h0YEeMeeitpRGcnw==
Date: Mon, 9 Apr 2018 00:28:42 +0000
Message-ID: <20180409002738.163941-81-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:8HLQH24iynW+hs3GVWs/NiJgB7pI+SvPxzU1tYyzeNmsJJOKQtJclKTvlY45W78ELOBe7BSJA6NsqG9mDCCv7FUxH7yjiupgCyItCIZKeYzG6SrNaFLIvyUMNGZUZbma/UtinQf9eyM0MAAd7l9xHyl0Vp8AMVS+VKbTBvre/pbHqiiNWPUIudAZyzJM+4U2RKwxHRj4sJyYoL0vlAT3UzDaVayFPtEOziQudaiVAqqU79s7aq+O9H018fgVYY6r;20:BLxwg3UfvXZ8U8cQLwCuAGIAlMhiLxifFm8OKLk0WW0lgiRKgpXHcBr2j5IMonTLVvxFbhso06AZRyKmv0hZDw/uUoR9IX/s3jI46rUXmMsoDdbELrZFuGfWeVRd09CdPto0gSGYx4sStvFmz8tFQrRH1eQZVzFMxBa0lhycTiY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e7f8936-e3f7-437c-dfa5-08d59db20371
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103115D7616410BBC505911EFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aZLDsskdSZQXN9WKtCp7jWJtB5dQ3KoR96NRAQhDBgbw53yvWY1Y7rwY4Xv0Jm75RxLZn8fbj7WXw0Eg2ULC14u6xKM/x+ZglbyIYqDoB1J5o+XTjlhvbxClxZ24NfKPDSxKXW6SKtrvKZdW+TH25UF+aRn+dEtWq3X7Mv96+Q/qvmBz5SWjXTWbX2XBV1ECrXa14pwRTPinqB8YCP4kM0QUo+xMtlonFrC0EHpLVayZjn74eI0h5Ydnub7J3uiFa15Hvs7A6yvCgrit/8usNyE1qQSOp1Y6TDi1cYoSORJiVNtwpFGahwSVYKsmqM08uZVXe4RGygx3tawu1Z0zDKH6xgSs/crKf6JIiSt9o7ATV2mQbDhucG19YuzggMl6x1l2D9a6xT7shGuS/60sTNspt84jM4VV/MnG/JUFaFc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7f8936-e3f7-437c-dfa5-08d59db20371
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:42.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

[ Upstream commit 725708349172f00b86e2bac5c03de360b79aaf65 ]

DMA tables are freed in zpci_dma_exit_device regardless of the return
code of zpci_unregister_ioat. This could lead to a use after free. On
the other hand during function hot-unplug, zpci_unregister_ioat will
always fail since the function is already gone.

So let zpci_unregister_ioat report success when the function is gone
but don't cleanup the dma table when a function could still have it
in access.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/pci/pci.c     | 19 ++++++++++++++-----
 arch/s390/pci/pci_dma.c |  4 +++-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index d95bfffdcc2e..a23140fd666b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -166,19 +166,28 @@ static int mod_pci(struct zpci_dev *zdev, int fn, u8 =
dmaas, struct mod_pci_args
 int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 		       u64 base, u64 limit, u64 iota)
 {
-	struct mod_pci_args args =3D { base, limit, iota, 0 };
+	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, dmaas, ZPCI_MOD_FC_REG_IOAT);
+	struct zpci_fib fib =3D {0};
+	u8 status;
=20
 	WARN_ON_ONCE(iota & 0x3fff);
-	args.iota |=3D ZPCI_IOTA_RTTO_FLAG;
-	return mod_pci(zdev, ZPCI_MOD_FC_REG_IOAT, dmaas, &args);
+	fib.pba =3D base;
+	fib.pal =3D limit;
+	fib.iota =3D iota | ZPCI_IOTA_RTTO_FLAG;
+	return zpci_mod_fc(req, &fib, &status) ? -EIO : 0;
 }
=20
 /* Modify PCI: Unregister I/O address translation parameters */
 int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 {
-	struct mod_pci_args args =3D { 0, 0, 0, 0 };
+	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, dmaas, ZPCI_MOD_FC_DEREG_IOAT);
+	struct zpci_fib fib =3D {0};
+	u8 cc, status;
=20
-	return mod_pci(zdev, ZPCI_MOD_FC_DEREG_IOAT, dmaas, &args);
+	cc =3D zpci_mod_fc(req, &fib, &status);
+	if (cc =3D=3D 3) /* Function already gone. */
+		cc =3D 0;
+	return cc ? -EIO : 0;
 }
=20
 /* Modify PCI: Set PCI function measurement parameters */
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 4004e03267cd..49ff18f8cf99 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -503,7 +503,9 @@ void zpci_dma_exit_device(struct zpci_dev *zdev)
 	 */
 	WARN_ON(zdev->s390_domain);
=20
-	zpci_unregister_ioat(zdev, 0);
+	if (zpci_unregister_ioat(zdev, 0))
+		return;
+
 	dma_cleanup_tables(zdev->dma_table);
 	zdev->dma_table =3D NULL;
 	vfree(zdev->iommu_bitmap);
--=20
2.15.1
