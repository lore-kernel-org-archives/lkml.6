Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237499-2-2058084973401745808
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
    1523237499; b=uv6S/n4D1J8cmGcm3yXi0paMQK6ZZeiI2UDAUNZZogT5XESiTs
    uXAaZQCEZ/MvlD8XWlaNeZ6Fxa8PmP0tcj6J/NjCKIfU633cO9fDNfrKH9YAEJ+f
    6AGilANIYVjmXmp1A41ZfVifSvQ6Ou1nFh1gutpoUzwQ3E8dFYMVyCJLZgskqttx
    Fe9KRCOcsWnhtRF4POl1dLzr2LB/vbG6Qq4YxxuUnmZWJD3sBm/pBwXqlTVvPwJt
    J/ZUnPLGTDnO17dcj1qzaPoqzsc2YXuv+cABjRrvoeEzsXu5MGK1Z1poXQv4pJZi
    ZDhIXGPn09KmMMejIZ4zPqZDwilRtajKTSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237499; bh=9TN035mVTl
    63mIPtNY2WnomuQntZqv2/0BXNZ5++kLA=; b=D/8pIyP9TvHbKn+IFwDJ1rhSxV
    U72T1R5CGOIT5MHXDppOGrQEkpb7W2kbtS+i4oJ7AvAMAkYX6oVOSUTQYOnFmTuN
    gx6gy2M7u1FZOy+OC4SmQCzXIVAFlwPxtuqRqdoKsIfdrBA9RUBdCkF7U49Z48d8
    GF2eicOVjawwu4940fp/c+o9OgZovwng7laUzouERt1bvPaJeLlMKLzL9gd+fH0e
    BdOz6tICJNwlZSnIpk15uS6IgLCrQXJm6V59V1My1Bn9KXE8EQnuyc2dSKB2MSdJ
    bp864bZRjO9RCHQE7RYoah2JMMcrxOVIthD77cGXaXOxwapm7hl0vf36Xeig==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e9RzMC6C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e9RzMC6C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAC3SHPS0z1ZAkZMaPWaq2ivZ6Gf2A8AGEtjKQi4aCq5UMoPL62cVuMQ2pITmdm7WC2hQQayai1A4gPG3JRErgqXXVRJsORuc47Z1Pzt6bzVOa0JWRyP
    GQbIC9hLdidXxHVFmVXJVfhAjWmS9SWNvRqqbDUhG2/j5++NZv54o6ieB3SSnlR+jKepEO2E1jo8mK6LjbCKkJzJKtHbXKm3YuMXKuh4KDfFnQ76vZofzChq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=3DfWnJiXAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=RYVZukao_CL1VzEAM68A:9
    a=HWdR42TzdO_JRGdj:21 a=K-QbpUguztq1HNLl:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=fbZbCd7XTi_oNd1tYRxB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756608AbeDIBbf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:31:35 -0400
Received: from mail-sn1nam02on0132.outbound.protection.outlook.com ([104.47.36.132]:23728
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756607AbeDIAfv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 038/162] PCI: Protect
 pci_error_handlers->reset_notify() usage with device_lock()
Thread-Topic: [PATCH AUTOSEL for 4.4 038/162] PCI: Protect
 pci_error_handlers->reset_notify() usage with device_lock()
Thread-Index: AQHTz5mjT5QLJNv2uU+LQ41gaNP04w==
Date: Mon, 9 Apr 2018 00:28:10 +0000
Message-ID: <20180409002738.163941-38-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:Uh6uLqysISR1h/hH+Fha+9attBDNI1ObnkldNXGkRQ8u0asPFwhF/NWBxANjyUQNiO4ruQ7hJBnTevfxikCQEAi1lwIyKTulnlnmihra5VE2ifxYIbvXZx3FvyYFzK9pqjVmzXNwVwEbIgzVGlg0ukHBsey5j8XMcegwumSDZ5CHz73cqOF2EPbqiPZn9IFGPvcIR1rxk31+2KGvUGzgcYuady3Lgq1TesZ2yteXTg6wg0cyNt+jqpsB8IF4/7tT;20:sMIyZAzSHqbtO8TMMTHCamCP7qncmnKq4QFqX8gxCc/O5L1rXK5WXS6j2SYggqFa1BB8uUFs0XPBvlZ5JVMg98fQHQ8zY65gDaG9zzkALkHkZzHeRalyI6UfMugxYHsw735/NTr0O8k7KMiXzYxMucsxLtdGYJVPPuBC7uXoZQw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90742c00-2f79-403b-6201-08d59db1d794
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072557CDF0446EE82E68D5A2FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(146099531331640)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(54534003)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(6306002)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(966005)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YA9xzn0D06pbNvTvrebrqiGi1OZmSOYk1ZjBvmzhqOVX+ktdqsKcGh8KGDL6YUL2ywYvepf7lvKliqnxmVScQIBaw5tNQH1Ipu+RN/4rGRtBGu68Y3eR2YUhcwlWUWpHzGJtNCcqpdZwgjFT+SAuC6/kIufKL/giDciKN+XzAszVCJxnjT0QTOCfpA0/1t6Mr8wOU+rNH47jy5hbSuoh8DHLErB1oXz6dlIgUVUO4g4y8/7X1SULBf4OITosIYwyOQ+j72F3dPTmWgbzR28FVYtPmMMNt17y6ldDl4UWueFIGjmRjGgI0X6Jcfb4hm/TWJTMgGcgRiq9ZYP1J7MBrI1bjeW727lkEqwFYEdqdJLfrtZeylnHZ/Z2G01nnW7Hitk3CQ3clwlwP+Q8pzWlacCOy6UH4LSR+b/55mc3F8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90742c00-2f79-403b-6201-08d59db1d794
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:10.3955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 295bf1472d02..84854f522291 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3672,6 +3672,12 @@ static void pci_reset_notify(struct pci_dev *dev, bo=
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
@@ -3807,11 +3813,13 @@ int pci_reset_function(struct pci_dev *dev)
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
@@ -3831,16 +3839,14 @@ int pci_try_reset_function(struct pci_dev *dev)
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
@@ -3994,7 +4000,9 @@ static void pci_bus_save_and_disable(struct pci_bus *=
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
@@ -4009,7 +4017,9 @@ static void pci_bus_restore(struct pci_bus *bus)
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
