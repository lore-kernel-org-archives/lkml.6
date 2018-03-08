Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490013-2-1394360957934075842
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490012; b=nEgL2B2uSObdZRIeI2L7Vo5YcC9dnPXn5JUZR/2MGUq81uf
    /vmb0cu/RYMjXFbZicmUtbuPednGkFNx+BKXWs+jyWg5R58+40i6m9mFlgDwBtPA
    mRBVjLeLrOiz9WcvmwocmmxAhUs8i7XAslDII7cnasCUJCm9n3vNUufzeQXc14Lj
    WW6FWCxImOm93XEJbsaUI5X/LdzumzakkP8X7p6zFwnMSpEtmaqmwGXFuyD0l4wv
    BCK+MR48npFsptlB9h/RUEIuDffgW3nuSMjpfny+9s7zMX0cdjyejRw/uwLVynzB
    V7clBHevkZEjjs3VtwV1UabUs3WSlcbN+K/wfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490012; bh=+2YX6y
    FOoaakHaG+m17uY8q07e/c/pw58IHrjW5R5ig=; b=SW0x1OuWA9GtD8FTFOShXZ
    rYz1s0wTaRacvtZKt/CmASseB3KLxXMuKoQr831kPlwm74R/ZtDkB9JpOAVJIKZp
    JTn1H5v2F/ZbV7F5I943ZTDoc2yklqW15c5EkedMAsmTDTdTa5OdMjP1X83iiKxR
    +YkTawNus/kVR4iduJVpqFyFVyj+tWbEIynp0IjPOGf5svkuLKvB0vF5U+g1n9NS
    X3ALlUaJnHbC5gCvNV6JiDuyXiTy8q4Pf9oY3cT2lwLP54lG4h9HfMYlJ7WhIL3H
    IOr9p9VwUtReEPiM5ciJdaIGFiYqf65fqfJt4+ZHx4ikTnuiiv9uqBLSxRwG++ew
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SwSWc7fe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SwSWc7fe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965592AbeCHGT4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:19:56 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:45505
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935421AbeCHFA6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Suman Anna <s-anna@ti.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 055/190] iommu/omap: Register driver before
 setting IOMMU ops
Thread-Topic: [PATCH AUTOSEL for 4.9 055/190] iommu/omap: Register driver
 before setting IOMMU ops
Thread-Index: AQHTtpo1BMgL04AufEOFsoBl6y3hUg==
Date: Thu, 8 Mar 2018 04:59:16 +0000
Message-ID: <20180308045810.8041-55-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:x0ajnLz2Urj5iHq5Q7eGcsVKjPzIRMzBIZD42NMbgmZ72NShA57f9bdDwLv3mT6p7aTNc+Etq9xqpJmwkmhNfrxCHUZRToZvh3d1MWIHu1yN6e5G8r+JDzdZbCWdsgCN4cKBeSs7AZnQMWbavhmyY6oGNFy+LJRkorxWwRLDvZ+P14634WIj+HDmVCTRhxkCuPmNQH5EH+4XS1Pr/uGQR2QbJNMgroLpEE267NmOCRhoINVK39hzbYBM3l/XUBpk;20:GCknoPtUIbNYAvsblRbssiXOpFk7fUQlmDSlyzWOIyd3iNbkcZPnPDlfoyg2GjwSoTY4cSTkDTOA26nYfi555s84dJeHuqApj1SXNQKotXSzciE/rLSms3xqML7eFAydP3TT9Sm6LnDdouLg78BvXarS2+1DbFbvTMr8fKXdET4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35f886ef-0378-414b-a7ab-08d584b18e05
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11091D73C791B0638CF92F11FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: UKNjy4AR7cieWKv1d/zsaZYtBATHk9ZmsJ6og5bVv2jHf7aWKLsxG5YExBZOYVKBQwGnT2NyFC65hmneZ3oKmfzd92hEEyk9ViSHptXgum0t1jhzyDgLZ4lDhjQxSXMRthyoztfzwfwQ4Nt9ScxSm5gF0ktThx1+d1zF//vCIy3d7Xnh5bG7TsP2lncH7HhO1SOQX7HuQOy29UkHB3SAX5Keimqjv1Si5BJWfMCeNqMAjeBKPaEmBeC8/gWH1DK1z0PZIwWWcKcRDv4lIzYEsBlyHDj5y3apUwIgj5ec7U8GNAUbd8y4dJ2GIor6bXogvFZcXWPFrjX5jQkMHHqwSQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f886ef-0378-414b-a7ab-08d584b18e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:16.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suman Anna <s-anna@ti.com>

[ Upstream commit abaa7e5b054aae567861628b74dbc7fbf8ed79e8 ]

Move the registration of the OMAP IOMMU platform driver before
setting the IOMMU callbacks on the platform bus. This causes
the IOMMU devices to be probed first before the .add_device()
callback is invoked for all registered devices, and allows
the iommu_group support to be added to the OMAP IOMMU driver.

While at this, also check for the return status from bus_set_iommu.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/omap-iommu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e2583cce2cc1..54556713c8d1 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1299,6 +1299,7 @@ static int __init omap_iommu_init(void)
 	const unsigned long flags =3D SLAB_HWCACHE_ALIGN;
 	size_t align =3D 1 << 10; /* L2 pagetable alignement */
 	struct device_node *np;
+	int ret;
=20
 	np =3D of_find_matching_node(NULL, omap_iommu_of_match);
 	if (!np)
@@ -1312,11 +1313,25 @@ static int __init omap_iommu_init(void)
 		return -ENOMEM;
 	iopte_cachep =3D p;
=20
-	bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
-
 	omap_iommu_debugfs_init();
=20
-	return platform_driver_register(&omap_iommu_driver);
+	ret =3D platform_driver_register(&omap_iommu_driver);
+	if (ret) {
+		pr_err("%s: failed to register driver\n", __func__);
+		goto fail_driver;
+	}
+
+	ret =3D bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
+	if (ret)
+		goto fail_bus;
+
+	return 0;
+
+fail_bus:
+	platform_driver_unregister(&omap_iommu_driver);
+fail_driver:
+	kmem_cache_destroy(iopte_cachep);
+	return ret;
 }
 subsys_initcall(omap_iommu_init);
 /* must be ready before omap3isp is probed */
--=20
2.14.1
