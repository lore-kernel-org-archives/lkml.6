Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517680935-2-6669535614204684830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680935; b=v840qihRiZDTWHK1N0L6EgWumfQBjSJcnG/JowIXT+Y+A+0
    nw13BZBL0qw8JynmKpU8hMQ/1xXj/Tw+xj2AobwI2lDiasBBrJ6YkEFPYWj1wpuk
    JJ1WGNvkG6rMYsAALWtJTCgacBsi3G2mmWQ9BXkdfYLnSmNOf3q0PBvzpxXdQrAU
    pop2IYGmgcZ4IhOC+bH2gpybjA/m220A/5eeyr+5wXsUpaBR6aoKjSWoInwq8zBu
    B0eKu4Cdc92ihqK8L6LeIr5As+QotuSOvOgZY7niv3wJvlrhFFFCv45yqH3rRAsO
    KNnjxNLmCr6/zIY1lSKP1KlKY3eRj4G4iWgxefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680935; bh=yeDzaH
    pZtzBh0fpkrCIQAHoRwiWuyXu9SyR2gaYfXHw=; b=C2IArWquZLh7ewHSWa2oyq
    Rp6Xk+4et3AUCvkrDGu0m4urtpOFvLyHll5XQUa90DoOwpNE3FPXWqpzehIdzqq+
    FDrOyLe4fTnG8ENg55mWCb50n6lAi/fe+9JbDkiS5G8yQSNnPNbE7fUrX8QSRnNV
    cjppskfEh+GhmankVNtPlksbSMJnkVFz3s/qLtUDYqCUBpXZKyE3cuAI6x8PVda6
    FyPYCiwze0Ui3XOoiHfgZx6GX1xFkFpu0HwoRzk6Y6Y0cCHjYZFfKJRnCxN74j9W
    spbP5V2OQfHgotvLI8HiHt+JDmDB7yxX0ntbW+haDxtZUTIp9NTMOyoDgHP1X06w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G2VplzjQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G2VplzjQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeBCSCM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:02:12 -0500
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:2624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752821AbeBCSA5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 023/110] drm/nouveau/pci: do a msi rearm on
 init
Thread-Topic: [PATCH AUTOSEL for 4.14 023/110] drm/nouveau/pci: do a msi rearm
 on init
Thread-Index: AQHTnRjlWjwSOYA2+EWuaVFnDiGxjQ==
Date: Sat, 3 Feb 2018 18:00:38 +0000
Message-ID: <20180203180015.29073-23-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:jv91weU8XkNPeQwxFYgKAgy746wHCTLgFvpjvfsSMp/4SvRj+2wdFR+ZI63gqsv4tkAyZ16Vvwl39SofNM8qkKa6ag9qfSPywCuxkM3HhISAO4069888rii9z1xNPNcYMLje1Pyzgkb1UqqzM/rpvZdQ+VJGzxix0LDxLzFUIztYZQQf0dZKUv6RGK/wNV1K3O49p73i1U16qYAPum4GCwayq6MmYBIHJhNdkUXORF89fZpWDq5XUQUqiGNzPnWTjPjc1Hfu7YRjybl6X/l+OE8rGn6iqnZ53lGcQvPWbGAL8qW6BVzRRbUgdz0+uZWqNdgtqmQThlFpUafFoUSmWiTYnwNtjfI+Bzo5EszxyMcmgzHQ/C85zEUQNXTVwq0a;5:J4G4wWId7vPLiBH0xsCRWfutTpjzIkxMsKzE8vwE3ETbk+0lp4U0D6ZpZzxkANdk5ZlHdQqsA574zDA+Z0zRwJatIjbcmUZoLXZOjx8jk5X3sCIrkMpAzRCxusM8JHZKJOvsJCria8imZVMMFVi5ItZYKsxHSGejfF8PiCJDePg=;24:IR5BFxEkcTGmAwNWCOSzwh3pEf3RYLIJREbtDC4QPnbaEoz6vjlOCogtUgbMZGg1ZMLWMmwgAETHKhPIID6lARiWKZzeiM9vWF4KvJroU/s=;7:4+cV0O1P1uZ/OA4aGQfAeUPDyyqd+HdExMsR7699gOtlpLPxRR4Zw6uXisd2Gzq47q8fo2gTR/m6CcK7G8cmiHzx2r7BTX9Lz4vNIFWrmFS3M/OArL+fxWu7qawwOYGkzpBtoQeOzccYJmISHIHJbj0/ZP/UE+y/zLffqdOIwQxSvCopKbf+YSwFzJnQLHuHsGF1CbB7ExztjiUDWJtMTvR3q5Okx+AdRT33CNZu1vTntkcr6/BOjv6n6XRimfR7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c33d9e5-9339-490d-547f-08d56b300a15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090A99EA696F0AD5061A22DFBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(575784001)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: R7xQd0WlXYAkE0rDWKf16dvDuO3sRcJ5TPWcQb5lFql9vVexYTdQqBvOokkOlLOXDSvplTlVMgR38OsZHXB43w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c33d9e5-9339-490d-547f-08d56b300a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:38.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Karol Herbst <kherbst@redhat.com>

[ Upstream commit a121027d2747168df0aac0c3da35509eea39f61c ]

On my GP107 when I load nouveau after unloading it, for some reason the
GPU stopped sending or the CPU stopped receiving interrupts if MSI was
enabled.

Doing a rearm once before getting any interrupts fixes this.

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c b/drivers/gpu/d=
rm/nouveau/nvkm/subdev/pci/base.c
index a4cb82495cee..245c946ea661 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
@@ -136,6 +136,13 @@ nvkm_pci_init(struct nvkm_subdev *subdev)
 		return ret;
=20
 	pci->irq =3D pdev->irq;
+
+	/* Ensure MSI interrupts are armed, for the case where there are
+	 * already interrupts pending (for whatever reason) at load time.
+	 */
+	if (pci->msi)
+		pci->func->msi_rearm(pci);
+
 	return ret;
 }
=20
--=20
2.11.0
