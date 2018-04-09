Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235458-2-8705001563202369765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235457; b=XS6w3h2csu8HRx5uy3hYXLkKz8CqPoz3w+unzc1nsbYdco4TdR
    4w68zOrQwJj89OMd2+YDVnZgj1K1gEXPWbsUDqpIWIySqupo9dv+bu5QNQAYAGrN
    /qut4NFOUfJ54TUrLjfpafGZGGGdieXkDmY6fPhR3p1zJZhicWmVK0QSrXgBl5il
    GcgaJZgrfrVQUGK2B2XT35F3+0nTy/5j9dMkuIHHOn9GghYLUGuSkipp39UhBuZk
    v9ZMxQFnWgZN2RWRQlCRdUfDD5Xg9dGQraNVe68aEEHzm0OZx/RGm8KRkfDGCdbA
    Ae7tI6+X2MkuoSI9klbe3GqNpxv5pHhF4kMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235457; bh=77KC8siWkU
    Ft1USCJ6Rc2a1UuK2mPENgUFs68G3LhmE=; b=XlqWpE2WLDrYXW21DXScVrTR6M
    imrpwl6bsQVvLkfhQL2rqJOk1uMN1pm1Ja7Ga7Ql/sG8BEV8D+ye0EUH46qtuLuI
    Qyr7xrKVYlAWIARv92nWUAVIB5/5JQOyYSFd1/kjQOX3sH9TBHIGcfVOpr3EGvM1
    pt8/lCChxKXfqhoJ10IsaZjTx4QsN4kFozsbPM3q5oecp7rfp+yG6T6EVeDPpJoD
    EFBzNTb+Wnavb1yOBFtroPoyHqOqYR+aPTbNPDFVgHuZShzsEO6NpjEqc4ViY7F+
    f+4kTT1kqftcNo5lfySIUphXcQ7d7rWwy4UXSvPzpSesONLC1/R9WAdXVx6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EyaicNWn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EyaicNWn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIlqEAcTxrXiWWy8z7YsbyLEmqKLmy0x6OsYc1l5+kngM69xPtz20oC4dAbXmrAgKQhG0MIaWQaBHtRvqiA1e8XmUdi2RiqivrKr40aNJk8H3NkY3r1W
    wloyUyts81IxYXm42Y4TLLkuOeMgP2bvJu0YTBeH0dzQxgcT/b13FrbXaYkrQcaPT6vEh8Kb4CN+WNieIr2QvS0fBeQe0FTadn4X9xJP9wOhSI/8p9BVYT/z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=3DfWnJiXAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=RYVZukao_CL1VzEAM68A:9
    a=HWdR42TzdO_JRGdj:21 a=jE8EpxlFV5R1BAVH:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=fbZbCd7XTi_oNd1tYRxB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932943AbeDIAkS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:18 -0400
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:41805
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932553AbeDIAkP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 031/101] PCI: Protect
 pci_error_handlers->reset_notify() usage with device_lock()
Thread-Topic: [PATCH AUTOSEL for 3.18 031/101] PCI: Protect
 pci_error_handlers->reset_notify() usage with device_lock()
Thread-Index: AQHTz5qv6OsF1ho/pEyaKasZk+s2yg==
Date: Mon, 9 Apr 2018 00:35:40 +0000
Message-ID: <20180409003505.164715-31-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:zFY3M2flnHCShoNHlH2lebyB3vZxJccmcftOUVpcyNiRFdGypTSLeEK0UXqVKxm29MxVfM7pSH3uLhHRyv618Kvg26Z7YfWKUHwOaK6qV59R+t4nCInhQrQEQjbbUeF0bmsnqZ1fjYWzvS/cPdyRhdR2O6PuyNU6sS3YOw7mcFbSTOYH5Rp6+H8fuiKqCGUjf1TdFGFmcmMwWLzrvZW96MXE0WfeuAuflQ8TRW7Xx15U8jlX5ak1+lh7rUCvG3q0;20:xSNu3LHrxm/xszi7RxIlMd0DkOYkEnj8goFPpOOJoNPpzE8CaKcYo1XGjLVrFlYW2YN8h+7irPmYBHuzJMyfLghp61cb4AcefcBkoRHF68OlesUGzUnEDL7Tk7Gbhw9nyLWu64jG0zq3l1shUL9913g5KizjWfWGOy9MIySURsE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe95ec3f-c134-4120-89cd-08d59db27577
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966BD085550904A4DE55F4FFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(146099531331640)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(54534003)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(575784001)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(6306002)(966005)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: q7hcxZX/iR/oSgN/CAx4TgQLxyNCWC03gMCS2OoXfayGUQGtP+HpcDH1A3wg7HmogisOrpLOdVF+sFKRwx/KJI3Gpm0E39oEwQQonChD+wM9c3tIwIPFdVEXmqvDzPwC1LFhLSIn40D/oBOfMUx57ZjCdQlB4G/bOJuFGGx9mBbmxQIV/XRBOj+Q61jkRksBiTDv8ilDVJGjtLkAbgVAbyPFJ/gp6BusTv4h+/u9EL/GFwT9eQIF+kY52ZloeBlmQMrRAuxavvHxjv8JDuwaOIsQ0h9dprGh/1dmlmInZ6XFPagVtTFRmyWAFNc8FgPpNGxe4GpyKwt9/V0LVRBajEKYEKf8HOFrM0QrlGJ8m14yh+u0WyLvZBHYYFu8spnN0gCbZVk/dnjufPjUp9tQMhR8xQuM1GEXJhqOBbxLyX0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe95ec3f-c134-4120-89cd-08d59db27577
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:40.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 1563cfadeaef..3f8d4c0c997c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3402,6 +3402,12 @@ static void pci_reset_notify(struct pci_dev *dev, bo=
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
@@ -3537,11 +3543,13 @@ int pci_reset_function(struct pci_dev *dev)
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
@@ -3561,16 +3569,14 @@ int pci_try_reset_function(struct pci_dev *dev)
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
@@ -3724,7 +3730,9 @@ static void pci_bus_save_and_disable(struct pci_bus *=
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
@@ -3739,7 +3747,9 @@ static void pci_bus_restore(struct pci_bus *bus)
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
