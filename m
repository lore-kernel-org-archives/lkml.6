Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239856-2-2294951764008227743
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
    1523239855; b=doHmwHbplVG1JZkp1q1tTZQLoSKFVRJs5ciwcobwxATtlVpkE0
    DZVe+rg560iJdg0FWBVRZ5k9vfIB3GBX3Cl5F5o5z38SSEmOVaOndvPIPptkuyzI
    d+DWd2tJsddLZmpgJie90olxc8BBWsF1lqkHkAw4I9+SQRSKg5GPvftp4wgIHzAY
    FvoyfiYet/B6zKiQJijWCuyCSLGFG4mA6y3Zsd/rTSdwEaHLQNuPCq3XiONbFRk/
    nBKtsGV+R2XRmpN8JBRH4OIHc6fl0oioJUvVkfHQy3TfmXdbGMmqTF00aOKrmtik
    xXeLKYNj4wHuotp6efGisBZ+K0hEB7b3PflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239855; bh=4i+UXHWHhB
    1L4Vt9UTrP5O2z3Dsw9prpIooljoLUbUE=; b=JYgtlSNNiP5bTZuYci2rPUZNPd
    EPTwAYSijTy3VxIJSJYSzR7FFX1wKtOzTJ/RgkvHbI5eII4vlAER6Lv6N3HuDmY3
    CMNP05/8y4xBCvzNRXJBf3dvT2lZgaMfMVxSFGs9+T6uWtJz719c31Ouc1+S4seG
    V3ii/wUl1pSSdCkFsX9NQ8XPKgeCGiQai+XN2rKOVaGIwg7bTG1qjrMDZrVAt4f7
    Lrj2yiL5iPh9duOH5XhH1LicIvYKeYSJzpmMwGe3Odl8r957Z6OTUSz2HhIi9PqZ
    PWA6tZOlUEZBJ/TFqYCtSn0+UxH//kmrwVg9afC3TDdgr8WTJWoNLlAbjvKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QA00U2yd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QA00U2yd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKDaTgr1iESyGkNJ2vKhjYwxUHq8IYapGDRTdUDekp1Du1Y4gG4PUliB5qQY/QMzLfokcen8fissFirWAM72CGnDABJm6L2w/dF40MZMLLoktEzofxWu
    MG8u4klRxass/6hmYGRpIv7NnQPgCScgdmiR5GH9ozW3nUK8nVw9tkY7yisue7VOxoyPjoKGZkIQXuvDpXVg20ZEjHncwaNvJqdIY+IVc1AKoT7+lgpQtE5M
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=0tlCN2Q2Qm8EqCUN3ZkA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756211AbeDIAbQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:16 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756192AbeDIAbM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 158/293] s390/pci: improve unreg_ioat error
 handling
Thread-Topic: [PATCH AUTOSEL for 4.9 158/293] s390/pci: improve unreg_ioat
 error handling
Thread-Index: AQHTz5kvETJh8c/cx0m2OzfjOOBGgQ==
Date: Mon, 9 Apr 2018 00:24:56 +0000
Message-ID: <20180409002239.163177-158-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:50W5J6zSgRSzG4ncS8JEXz4e99gQf/l8ZyswnbK4cTzl7itmAKVLofkbZGTwRKsySNKTCqJ41iu4uoUcsVBqzHrm4LSxYFqFTen7OZnfPzoEM+PebGAZkLoj88cZO0f4g2yeTWUvg8ECg5MV9xxRmoCw/19HgKJgVxxBl2oLeTZu0Bc8pXrqdBxJmAyXrLdMk7aTKul+9nExcj77M3LmsrRk4iJIYe6cdS5MKvQr4SixmxJV2VuzV8Nwj35sRHQM;20:Nfoe/cmQxYOvLb2pVnzEtfxWTafmrPwf1BDwIaqM71Pb71nImgNSMezLsStadAwimo/AWxI9uwM+4EFZrkZwqsdpWeSTg0y5monVCHHf2c6A4PrsVCR630CGePulkPM78WP3LijkrxpVQHdHg3W6186KjnB5X39P1colDPNGxBo=
X-MS-Office365-Filtering-Correlation-Id: a0812d03-22c4-43c5-0f7f-08d59db13117
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917DC9268E1EABFDE8E4D5CFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xmxdGS4q2833DPj3B2YhW6yesbBBXLzh0ktJ2WboknFdphxb/hut5JxJ/O/t5h5eKl7IcPg21ra25m1QWDzl696aGHa4vsKRutbxpHOvf5rektiXvuJw2V88cBnBR93bLBmlyO+9o1G+dItIGbuE4TGOOq+BuXzjRueIxISaa+2eGNTfhn+KoFNWtOA7hDCUR2wLV3I8YIe1Mbk465FL4l8T7aHnbQU9NfqfXMLG6p0JwekmTitYQ2807UVqi+aPfx6+WFb1LUg4nBLTvI+WSrUlKPHUFFxuj+hZV3ZlD8Or2rNB2USBhWxVFvWEyF6WzRj0I4eOt1zh4TqAQ1aN3wFxkluoO9bOU7K2/tziVLI8zAAuKyQk8DR6uXRYb/8KCl1mAjQzm1o9fgXjzhsLS8EYBQH7JDbglWcBJ8rKubs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0812d03-22c4-43c5-0f7f-08d59db13117
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:56.4876
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
index 17f81991ee9b..c22b4734fc12 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -169,19 +169,28 @@ static int mod_pci(struct zpci_dev *zdev, int fn, u8 =
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
index 049e3860ac54..be17f05f645e 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -600,7 +600,9 @@ void zpci_dma_exit_device(struct zpci_dev *zdev)
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
