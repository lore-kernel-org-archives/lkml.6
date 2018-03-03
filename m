Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119216-2-3753055927561186681
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
    t=1520119216; b=dwjlMhgd2eOVKlm1ZIAhLOJlxoTZvI3FquTb3gJxCyLZJ4j
    7bbMMgsTjoZSf29vLO+lWTEYeBhheGnkygLE64kreuV4vglAaalrAPcCm2eWgnGh
    fF6vozkIzvu1gmk+vq6cv0ok37yc9Up7utDjjs308zdxDzMhJ5tqB5WbamOsb2zG
    a3YPv64g62DvWTsScl+OmO37mx8gM/M3FpPO+rYjj/N5zHyr47SR7xn2uq590LAx
    8eoNXznLem/5u198qlLdQsO8jKffTql4hIpOdbXdM3SF0TeD6A44vGOhdrd2oHKY
    Cm71w1tjE5iaY+sDIcnLBhk5bOenPgHVlgDFNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119216; bh=igiX9X
    OqbnjmgBun4ZvbCJju6bwCo+FeUU4ph8qeGmc=; b=LRAylGqyYnNieoIFiD5qwv
    yNFeNtVn3qVqSeQacMfKLQG5KXuoHqgSlmS2ZiHKbrf5AGBb1ERb3+UnrjzfjdmF
    vhbYU2YUMf1z65E5xqt6abGHZSKZKiYdwVGuvyosksYC4OhxE2ExswU+xn4SB022
    NLv1ncpmJgq83xzksUN0qkGQItfsihkd8AdPQicTPyImSpKzg/q6hPzKsoeT4L1N
    NvNifG1wEDNlr36nurjd50woFJx6oMrd7mZmXkTtzxyjAeMF7+BkiqWGWVa09NOV
    gJpzm4M2Wy4f8S5FAJwK9pmXsbcts5uHAVcQaEDPW//yGAYdjWN+swKKiLvXSnuQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M1C410wZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M1C410wZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934330AbeCCWiC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:02 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934750AbeCCWh7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 008/115] net: mvpp2: set dma mask and coherent
 dma mask on PPv2.2
Thread-Topic: [PATCH AUTOSEL for 4.4 008/115] net: mvpp2: set dma mask and
 coherent dma mask on PPv2.2
Thread-Index: AQHTsz9JFXYjUNzgzE68Vots6nha4w==
Date: Sat, 3 Mar 2018 22:30:51 +0000
Message-ID: <20180303223010.27106-8-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:CsZRHg8XNnNopHuZ6cwpu2B8setu8yStOeT/VIO8GbLtm6eVBD65eRX+64+0UU8bXWYd+6x5FC94gCmTTJ84Gv6QUcuAakrDO0702IbQjnpJ/z9EG+wOdYBTpxTSXGCRc+5lAuUCLJgZ0Aa2ZvJef0m7WPkZc0vkwhAitovpQkuewWaZjRn+QCFAGNNINum4zYbWjq0JgUv9A4T7oO0m6/JvnQqnhZ5TV/2lx5Qd+4tf+YD2TepLRuf8cSbSfO0k
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b330aea-dacb-4d04-4166-08d581576874
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11008EE1CE2E4E6F4A5BACA6FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(575784001)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ipKzXDzIbSlzQODXV0BnhapxptaSExgv0XKEV5gWSrx23Cy2MR89AqrQG7SsZJRa6lbxvEhadyqOWkAhIlUk8vQ1A8M1SdeZtqDBImNd6H0P7FeXip5JmBA3sDJGhzEQV+xkz569ludNZhNbu6w99SGQBZxC6XpNz9hOPlN1KRk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b330aea-dacb-4d04-4166-08d581576874
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:51.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
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
index ac92685dd4e5..b961860e4389 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6448,6 +6448,20 @@ static int mvpp2_probe(struct platform_device *pdev)
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
