Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496380-2-16267819538660888918
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
    t=1521496379; b=sT76Vgsu+QVNfx1WpUe8BWC0as+Ci2pbkQbP+LELOmgQdO+
    8xdE58ocwPX01X6XhcMFXEnFFGnMZXAaVXYdrsWRsrTYp0yvmahDAKZa8WvZIdg6
    6J8P9JZYliIR8pEYM1AQhSY2kspaNDg1CeHM+emFCZ4RWNKvhXPMosIQM2PW0F7G
    +4abd5QctpncETotyLOYrNiqjLgqsu5VqFM4nMMvSvbc5k+GKl2GRSUOvrB0IMn2
    COTXSEYwtkKGEBL5h0x3pCbWRaWoSxvJMmB9uJxt4pMCUwfaaKZ0zJZr1+b93/c6
    Qo2LPQ/d8dKuTsHCF3Qxa/RAaKgWUsMMC0ml6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496379; bh=aicwdn
    SwCjOUP/UysK+W0AgICeNttFqemYnRaTP/lv4=; b=TVfrh9aMAcB4XtMSzD0XZt
    7CLaAVETLL17f8nln+V9sCedtr0Cgg78YrD+l3Ckj6MFnUkQuG7Ikxu/gt84vM2X
    PBCVB+BP72gjdve1e8kvIg1f+BQZOYU9Bb0XqXBEeXJPyvuDwctkOr1Ymgx2xrWB
    d2+EcYzoUuGK6dLOitXXr+EHCf49/+RPdXqfubW5Etc/HSTlgRjs7Lb7YVvBkBwA
    Fq5/AZSDnpg7zeCj6wlxnNDBjmORa5o+BzeYm8qvkphLZADP0A/hck5tIj5If8mp
    PgF0CEzKg3Zm5jJVFCoahKNaU2cY0JbnbHnUXp3K/fDn1WvTE4lONEW+d/P6sARQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DgC2dPrU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeihedtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DgC2dPrU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeihedtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934204AbeCSP5j (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:39 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:31200
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934719AbeCSP5h (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 97/97] thermal: int3400_thermal: fix error
 handling in int3400_thermal_probe()
Thread-Topic: [PATCH AUTOSEL for 4.14 97/97] thermal: int3400_thermal: fix
 error handling in int3400_thermal_probe()
Thread-Index: AQHTv5retbYTWDE4tky7mb0nn2p7+g==
Date: Mon, 19 Mar 2018 15:56:39 +0000
Message-ID: <20180319155411.12348-97-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:D1aUSwZXr89sCMZwJi1S57PM8tkpxLBVKelphkoFuUu+NMKYoR4g2vmlQT4WF0Lv6g6L7Ua6leGmau1knLp2ASH7UkjS6drLs/tvV+i5W3RSlll0YJeiQqHDaKSAEKYZDD6C4o9GI1p7eo46oPV9jQT4CQ/dwJGMX01Iom72EgNdYq8OAdCyqS1mR0tjkqUaf0xC3v6+fWo7RY149RX0+GZNysZV3EZcQgNWHn8PkEgW4zqyCtEUhq0bYGFz00yZ;20:MpW7YEUkgILpK6CZtz/0a29xDa4Xk0MRJxl4aautUAUU8D/RVvlkUqkTI5iGy8nj+uS5tz1JwwXRFgcATgxl8uRVieFL6GXhMjKtEz1L/SoV5IFmTdf+yy5bukIf4HRBZ3Pn2XCYICZCYxurLWgNTykHI52Ah6dVaa4f5puUiso=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdade1fb-648b-46e8-aabf-08d58db21dae
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10967AB565AED2A182CB1334FBD40@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(54906003)(59450400001)(14454004)(53936002)(36756003)(107886003)(3280700002)(22452003)(15760500003)(6506007)(5660300001)(68736007)(186003)(99286004)(478600001)(76176011)(6666003)(10090500001)(102836004)(2950100002)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(4477795004)(81156014)(81166006)(8936002)(8676002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(2906002)(6436002)(66066001)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dgUQJHGqAls70NaBl1149Nw++w4/4TLDJN0WBUO+8j2pu+p0GsK8sAt3IW9yFsqCzvT1YRuE82tNVNhse0Cq0yNCzjvtnAwCxLc9K1fdhgAuYmu2MuKlWIGCrkvtQ/w5gjeA+kfWNodsfNB7X5FuD9+TTRKmOoGbmeXEwh6K68ziupUj8eoS5xUVqmZ3TC1gSMS5IJPJiqPCjeIaYZqB5TzOMz9R+c74v9w3wBJG4o7+uhAgNm0lgaZipESu9dAMea8HzDxeKEi6shKyZ8Sf5HDwIqIjTbkX6zdMfnyyVCr5es2BPU7EhU0F3JptYXZ3KEBYpduigb/1oQ8Rkmdq/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdade1fb-648b-46e8-aabf-08d58db21dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:39.9468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 0be86969ae385c5c944286bd9f66068525de15ee ]

There are resources that are not dealocated on failure path
in int3400_thermal_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/th=
ermal/int340x_thermal/int3400_thermal.c
index 8ee38f55c7f3..43b90fd577e4 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -319,17 +319,21 @@ static int int3400_thermal_probe(struct platform_devi=
ce *pdev)
=20
 	result =3D sysfs_create_group(&pdev->dev.kobj, &uuid_attribute_group);
 	if (result)
-		goto free_zone;
+		goto free_rel_misc;
=20
 	result =3D acpi_install_notify_handler(
 			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
 			(void *)priv);
 	if (result)
-		goto free_zone;
+		goto free_sysfs;
=20
 	return 0;
=20
-free_zone:
+free_sysfs:
+	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+free_rel_misc:
+	if (!priv->rel_misc_dev_res)
+		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
 free_art_trt:
 	kfree(priv->trts);
--=20
2.14.1
