Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117815-2-10892359801780021265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117814; b=lq+EwKayidn+nzSCkznYZY/P1DSsia4glrQc6FbdIM7RX0D
    QTd2E6nLwABFkonvCEwBQaRe1tSaXz9O2sgXPiKvG/Q1sNYIxwhuzHbY9P8TekRa
    E6bGTw9xfzGsGXMm/rcOETAUCLxV9R4KW8OCOl37SyTgVv24za4i+78k85rh2WEs
    AkyaSc76f6f+0AywAimbDFaTp6QMaYbMX/oes7EWBkk/l37FRgJldl4Y0In7dxnf
    Z/DfKlugI6Z/FblBXjP6bypKN4BvmO4IztVBQao76l4KW3uUOklVW60A43W+K0rQ
    ZRZ1yia7dcEt+5dK3ZGzYMxg1CFiDI+h2WGf7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117814; bh=S8Dy+e
    ouZT+LkCfOPBdHQkdDjaabCY+yTsJohCcPP3k=; b=M+lWY4wrnCbUPU4838F15A
    cm8m6cNbj7I9ueAo4c3jozzQyKiVS4GtuHVObtoFiK0hzJQjK2E+HWtzb1PWn4ME
    GzU9Dib4sw3O7q2uRE5tmTYGr8keyfchr01zso/3clr9wVYHosoMHlKbytqiyTh8
    Cq3enskEuBPedRQQENNZvP+MX5MzzIn3Nn/ytFsiq5D9AVyvOs+7BacvUOxytX/2
    ZVl2AvIv5E4gydp7r82XighwnhBQQBDNiGQdrIaGObjJvF9+Lx7oaDX04wvt/6jw
    X7FvcLmSauPWzhWz447kIwGQBtuvYloyqEJ2gSaZ3IeXJWc8v2q27apnnSiuEdPA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B0Kify8w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B0Kify8w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeCCW4i (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:56:38 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:30112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935356AbeCCWk7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 04/63] net: mvpp2: set dma mask and coherent
 dma mask on PPv2.2
Thread-Topic: [PATCH AUTOSEL for 3.18 04/63] net: mvpp2: set dma mask and
 coherent dma mask on PPv2.2
Thread-Index: AQHTsz+bghc7jxP6rkm1WA1QyLs3GA==
Date: Sat, 3 Mar 2018 22:33:10 +0000
Message-ID: <20180303223228.27323-4-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:rZ/1fKFPGRw1MdMOJQy21nlwdzxgxybjAodUYZuupwUMiB2UyjmodsvTeSMDcG6Mgei7E0Zl9n2gD533TSCTtg2myX0kFCYXBWLxVu7MphnRm8x9mj9uZJJYCT5O9CeUNP35VDsp9g2C1oOWdPAY2PoyJmBVNCQqsqF/kz1dSbkI/Qdnp7EXu8fYunOjHXDP5vMz0tiAReNJvhZMijVITBG7CVYF/ca/ouKMFr2ixEcY0suT9u0wq1JgPjwjRuXn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 020b9d17-ef61-4df6-9c7a-08d58157d3d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3445615978DF607EC3CFAB1FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(8676002)(5660300001)(5250100002)(2501003)(6506007)(575784001)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: av1DVD83izxjso/19SJ4C9EJgq0VgqiGOz0T2/NutnHz2Ohow4ywv4BA9esj3aMQnsNjelr5I/iSIB8QK2V1nOcdotKwMpFIKcJqbIIuEqJEeF/RFRxYsA2aI3n5LmT9bbQla1lJmBYCl5DWXSXoocGdt+/p7UKZX7vxhtHhe6A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020b9d17-ef61-4df6-9c7a-08d58157d3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:10.4972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

[ Upstream commit 2067e0a13cfe0b1bdca7b91bc5e4f2740b07d478 ]

On PPv2.2, the streaming mappings can be anywhere in the first 40 bits
of the physical address space. However, for the coherent mappings, we
still need them to be in the first 32 bits of the address space,
because all BM pools share a single register to store the high 32 bits
of the BM pool address, which means all BM pools must be allocated in
the same 4GB memory area.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/ma=
rvell/mvpp2.c
index fdf3e382e464..68a5b71ec5c4 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6339,6 +6339,20 @@ static int mvpp2_probe(struct platform_device *pdev)
 	/* Get system's tclk rate */
 	priv->tclk =3D clk_get_rate(priv->pp_clk);
=20
+	if (priv->hw_version =3D=3D MVPP22) {
+		err =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+		if (err)
+			goto err_mg_clk;
+		/* Sadly, the BM pools all share the same register to
+		 * store the high 32 bits of their address. So they
+		 * must all have the same high 32 bits, which forces
+		 * us to restrict coherent memory to DMA_BIT_MASK(32).
+		 */
+		err =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+		if (err)
+			goto err_mg_clk;
+	}
+
 	/* Initialize network controller */
 	err =3D mvpp2_init(pdev, priv);
 	if (err < 0) {
--=20
2.14.1
