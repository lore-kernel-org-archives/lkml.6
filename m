Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241038-2-9957632383056070985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241037; b=cYC5rgD2P3gYBQvXlJ6G+u2uEOBa53AyQhexrOPmZr5nYTbtVg
    Ss4+F/bKb+jmvp4VVjM37+OYwVFPRhC1QR2HkuewYIDA2OEGc9ZUpsH81j9e5h3c
    D9hVNHIRnZj7LRc8z5V1PQXzkXjXMbZ+QYfIcTQyDVUza9/ExGgFeshZwm6AGIPK
    xB8PBHz85uNM1x7vikszCWVtYfSaAvtxQQhGO/FDzpNv7j0cu+vgvmexMUJeDwDb
    vjG3htkgPxnuPxlNODYgOF81COmk0sGDyVuRBDvOHcdqRERVBY7awygZgyFrVGEI
    8QuOanHe/QyOe0WTChPZfIEepujw1Isaq+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241037; bh=wxkplyNnqe
    oJfTOwJjB+Uz6W7adMuiW3p06sA4xFOrY=; b=gzh0Fp4K+HRWwRZKjswMEs07pH
    2XGnAov4l1bsBRnKDzCElQlGkgmFLvZ9rHB0UnqGpAs5XF892OnDRlWSJLtDL8Wz
    KPu67oI9RKjOo+AYZQ+ZNesioVDn8iQD4QVUm/sr724m2kS07W/7NuXL2zqFp4MX
    Wnq1+dmIcX0+sleeTGYPn5Kqe1aM9ZnubbwHf4iwcNs6qIDYpscdjAjCXo3+QoG8
    fGU0z9pLtjZawPCgw7ohlDFcfCSCe5bG87pgu23dlLLa6ctHh7khHM8OxQxC9uOT
    GR8vZcmsVFAQY4Jua5C33C7xLG//ct5ViKU+iIxLQ7HdJ9RN70OOnb7wZUgg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aobuQ048 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aobuQ048 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC2Z/B1H8HjDswx5j/rNi8Fs2jIXs8OurXhNyXkoPqOOV54cpCheJB+SWNEeSSQv0mJkqouwuZxbgvQ9f8VgfcWH53wrQBZxiIxrFbb5XQb5tPJ65mbt
    kTV/uatJ6DQ8bWoo2X7TeJnu28VwtoGCt0MytbV1SsegMR6qP2VvhBxhQADVNT4pxatvoZMVd9hCgf1LtSIFWvBiwRq5wnnRPiy6a46SdJ488DeAWNycWrmD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=3DfWnJiXAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=RYVZukao_CL1VzEAM68A:9
    a=HWdR42TzdO_JRGdj:21 a=jE8EpxlFV5R1BAVH:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=fbZbCd7XTi_oNd1tYRxB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbeDICaV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:30:21 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:12595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755842AbeDIA2f (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 076/293] PCI: Protect
 pci_error_handlers->reset_notify() usage with device_lock()
Thread-Topic: [PATCH AUTOSEL for 4.9 076/293] PCI: Protect
 pci_error_handlers->reset_notify() usage with device_lock()
Thread-Index: AQHTz5kKG60HtASDM0iklGqio8LNWA==
Date: Mon, 9 Apr 2018 00:23:53 +0000
Message-ID: <20180409002239.163177-76-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:Fn87e1a715CHmp0gqUpjhhY2mHMK+u9wBnWMBnVyAEb1riErPLZIKfVSuM6BDJ2CU+dFXuNXs6YxusPfr76+F2pmLe9prDKwWiR/LcDnlGHMLGaj3P/coh2yN1/1WN513j+OIHIqpyfPeKai9MFDE4HnByy+FozOwFU/X1seLO9M0bdkwuVgKKIO2K4pen58yQS57Em95jhCz7PgSwp5cNKRN9zfd/RflVkRQh6EHnwSXfv8M/43I0AGPy7SoiMJ;20:T6tjxadHw764NbTsBdN9JrZ3ehrZ+hf8WFb8gguBIlPadnlqRbNngYsjZU8bXg/+F6v2Gm9e84FxPV0q2S/YUmvcaVxWSoOgrjV6/na3HhjYqlLgSq87x1UlhNdtD5r9XaUai3DivUKKJOd9C0d1UxyXkXivOpqf8YaSztIYJS8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 205d5a17-3136-4416-19dd-08d59db0d10d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807074D08872B20CF87D996FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(146099531331640)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(54534003)(14454004)(4326008)(54906003)(25786009)(966005)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(6306002)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MeC3bmhR6zmLJerMAUed4q8fg0vbtb/2GFdEb6rSY2B8f5o1ibxevspPSqoB4zS9L1Fq5QX/OJpxY9EIBTuQcsT+z+G1r+xw9xlU0+vy08mrZZqkGt1iCspUuwJKOOtb9LX+kGifRaDXTztEwv0VLTnfSyaMGI/eYSiwvcJkdG/j0TeDi4YLTXXUH1V2BNHAhwiPeEBMUWgd6PMr25LSNZ0HuPcbMrYFrbgFqzZmW6grymB5AV+YeoUeU6P+g1ZGvnKVdNvnNATLWZkXacqrF4/ttMF+L/CuSbaqI81UWjj/JCN0A52gTRjoFMnfU/y1XFDbRPB6GuaBpBN+GkvqIHGmW5lE1R4B4nxoX3Vnu6scZ69ZEXf/dFMmBxMBgZWCMbJA9MzdYFB4UXOkqh1oB1+em5C4alW3QsISEU5KtXQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205d5a17-3136-4416-19dd-08d59db0d10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:53.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b014e96d1abbd67404bbe2018937b46466299e9e ]

Every method in struct device_driver or structures derived from it like
struct pci_driver MUST provide exclusion vs the driver's ->remove() method,
usually by using device_lock().

Protect use of pci_error_handlers->reset_notify() by holding the device
lock while calling it.

Note:

  - pci_dev_lock() calls device_lock() in addition to blocking user-space
    config accesses.

  - pci_err_handlers->reset_notify() is used inside
    pci_dev_save_and_disable() and pci_dev_restore().  We could hold the
    device lock directly in pci_reset_notify(), but we expand the region
    since we have several calls following each other.

Without this, ->reset_notify() may race with ->remove() calls, which can be
easily triggered in NVMe.

[bhelgaas: changelog, add pci_reset_notify() comment]
[bhelgaas: fold in fix from Dan Carpenter <dan.carpenter@oracle.com>:
http://lkml.kernel.org/r/20170701135323.x5vaj4e2wcs2mcro@mwanda]
Link: http://lkml.kernel.org/r/20170601111039.8913-2-hch@lst.de
Reported-by: Rakesh Pandit <rakesh@tuxera.com>
Tested-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pci.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a87c8e1aef68..774b0e2d117b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4036,6 +4036,12 @@ static void pci_reset_notify(struct pci_dev *dev, bo=
ol prepare)
 {
 	const struct pci_error_handlers *err_handler =3D
 			dev->driver ? dev->driver->err_handler : NULL;
+
+	/*
+	 * dev->driver->err_handler->reset_notify() is protected against
+	 * races with ->remove() by the device lock, which must be held by
+	 * the caller.
+	 */
 	if (err_handler && err_handler->reset_notify)
 		err_handler->reset_notify(dev, prepare);
 }
@@ -4171,11 +4177,13 @@ int pci_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
=20
+	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
=20
-	rc =3D pci_dev_reset(dev, 0);
+	rc =3D __pci_dev_reset(dev, 0);
=20
 	pci_dev_restore(dev);
+	pci_dev_unlock(dev);
=20
 	return rc;
 }
@@ -4195,16 +4203,14 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
=20
-	pci_dev_save_and_disable(dev);
+	if (!pci_dev_trylock(dev))
+		return -EAGAIN;
=20
-	if (pci_dev_trylock(dev)) {
-		rc =3D __pci_dev_reset(dev, 0);
-		pci_dev_unlock(dev);
-	} else
-		rc =3D -EAGAIN;
+	pci_dev_save_and_disable(dev);
+	rc =3D __pci_dev_reset(dev, 0);
+	pci_dev_unlock(dev);
=20
 	pci_dev_restore(dev);
-
 	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_try_reset_function);
@@ -4358,7 +4364,9 @@ static void pci_bus_save_and_disable(struct pci_bus *=
bus)
 	struct pci_dev *dev;
=20
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_dev_lock(dev);
 		pci_dev_save_and_disable(dev);
+		pci_dev_unlock(dev);
 		if (dev->subordinate)
 			pci_bus_save_and_disable(dev->subordinate);
 	}
@@ -4373,7 +4381,9 @@ static void pci_bus_restore(struct pci_bus *bus)
 	struct pci_dev *dev;
=20
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_dev_lock(dev);
 		pci_dev_restore(dev);
+		pci_dev_unlock(dev);
 		if (dev->subordinate)
 			pci_bus_restore(dev->subordinate);
 	}
--=20
2.15.1
