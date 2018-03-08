Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487815-2-9045189210178831080
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
    t=1520487814; b=wKrH5y73zXCAWL4EQqkkDdqpqWdJO2PX3mquTAGCDKFGBKV
    cDQQoQNZzqQjTUTkRJ+yi75Y7VYIshbM5GtPG1t7K0xXMwi4npoXzhm0m5Qz1nWB
    NSme3afWA/PGegChpvaVzlN1/wSHFWwv+uH5eBgB6fxtdTp28464+7tBDci0FHmC
    oJC5D3S/tjwZlzV1UmngGVAqh31ZTtFw4l/h7eP96+t/8cGFFkzRBHU/jUFN+tY1
    5JKwK3qj1NC3vQvMf/WhELDaeb8l19fgFaOb9nXxG/cwKGvM18hr2UrS89W2rSZr
    Q6EEguLo4uJdj87klVYB1zh9albg3JPWLvNq80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487814; bh=6tRrjz
    SlkmFVblkflnn8TqQvOWQrIxuEsb+vS8/igTY=; b=vgtnPjYle6szVUk7Q5VG6h
    X6Nymzk+/A6SBPBPoauoBHFKPtRFvhb1zRAixdkAHYKemgeNTO6bLNN547D53WBt
    IPK7F6qXl6JGxDKu0BGpUhMxPhNZxQipTOq/lBVJB1+rePRMLqsnADlp3gs4YAIr
    +eh4InRkYtSlUGWKEt8ciSgrlgW2/0Wg2qXQJQ7Pt4S2afVLLUMCsNOg/qN6TBzu
    wNz/oT/j9n6xcefcAMifmk3HEXgQxomNiBEiuINabLZQFn5D5yoDVw8lbLkj7ljl
    B1g1rjheq6kxIodLuIzLdB3R89PytmunADFZNS1wpEXa84Vsai3KY6R7Tkp38x+g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iJldpfRI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iJldpfRI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966202AbeCHFna (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:43:30 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:45409
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966201AbeCHFFT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Suman Anna <s-anna@ti.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 030/101] iommu/omap: Register driver before
 setting IOMMU ops
Thread-Topic: [PATCH AUTOSEL for 4.4 030/101] iommu/omap: Register driver
 before setting IOMMU ops
Thread-Index: AQHTtpqJMTlP5wCqZU6s+wxGYZ1qvw==
Date: Thu, 8 Mar 2018 05:01:36 +0000
Message-ID: <20180308050023.8548-30-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:reOOYV1Iwb4HxyIM9RMfJO9VBCAG41pDO0S6OY89jyKonkslYOzasNoYrYK73+5Mr3jqTYgBt+oixLXaAeHKm37JOelpgZeF9K/gnqEKjL5VrBnTO/Mfq+VG/WXap8NLMBZL+duvtaxkQUCAh5+9BvgfOJo5E47L7uO6xw0g76w8PynwzNX48I/Sy6BQLs6ozw9k7gipWXYivSnteI4AMvWVw3Ck0rEmXLCWbyg87mt7nSpZgbSLhDq1mhBn2DCz;20:efY4MFSvW/40sqQX+B7NOlWNEsYhd9iggIQsHZRQkZQnkWMJsSGrZyeMDH+1gvWaiDUX8MP1AyoiZ8BEuvNlf9iDFpWkWtD6nM9MUpGfW4w5h2SYM+GZWW+uiHV0FbSqPQNyOY99FataQMXTsoUe3sDI0gLehfxMrROP5JPzXtU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f1f562c-19de-4645-0d01-08d584b22f39
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104696AD4223A5C610B8B7C6FBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ycSMeM++Fj+iJPvpNS6i6ah69+fAni3QJ9TzjEzGLbWvxP+MK+ffdcsALJD9tMny5mO5B4Rs+SkZNPz3fUTCNGFuqP0bzKRX6QpC2/j1IJ0zF+S1pU7Y2VtMULj8ofiquzQh7sBEdt2NODqVO0Pmf1/uNwk4MvxjW7pnnHLqvcpE+J9n6DJpB4zqK9Hjn+MQpZd/ziuhJPsB8g1YvwMbvXjQscncSrOhWQQZMy/GZPVf2QU+rgqLCutyTgsP2F+9NUb/uxttw/9xr3YEn1BusH333Mauzj2pPsBmK5jauysa7yugPiPtGOu2VYxhhEjU1v+WAVtuF3KPETD1v6Q4QQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1f562c-19de-4645-0d01-08d584b22f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:36.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index 3dc5b65f3990..b98d38f95237 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1295,6 +1295,7 @@ static int __init omap_iommu_init(void)
 	const unsigned long flags =3D SLAB_HWCACHE_ALIGN;
 	size_t align =3D 1 << 10; /* L2 pagetable alignement */
 	struct device_node *np;
+	int ret;
=20
 	np =3D of_find_matching_node(NULL, omap_iommu_of_match);
 	if (!np)
@@ -1308,11 +1309,25 @@ static int __init omap_iommu_init(void)
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
