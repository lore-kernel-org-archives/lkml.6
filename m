Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121975-2-3335493314872014844
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
    t=1520121975; b=J4VfpmxAmhh4i4zW/K7dqNrOn1VbCisjo5J/yXVq6GnBjIs
    6DNP3q0whOa2MkAE4mcV9cYSk5OUwpOKN9/r0vf4NAVaDjbOv92yrvCrHz2sTC7Z
    jz6Plwvaon4jdxD2ROIrEViO1zKVAQrsSZyyL9EL7nC3LkSxMuTe1WiqUzbtlqts
    S4DckvyGuTpbl9BcDP8nGcO8SpEEbTFuSlEJMuCHLBF3aaULcWD4SuRj0qoYJIOw
    Ug3jarovTCkwipUJE9tYK/ZewZ89sYoYKtuB16D5zw65OxRH1UT3nIfB4aZEFy41
    6bkqOikMZ1QNqfsuF+EJ6GGgNL7WfWfY9010raQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121975; bh=qMpONl
    wRB4/1N7CKpyzAAcN/PAX39mQGbVDOaKddEdk=; b=HRfMbwLhCrsAk84TxpTufq
    Auqi7QQA82vvH7ZcsPytNM6KuMeXa8zGss7XbThwcen1jOgoP0jUtEd1kTDO9oEQ
    Qnv0KDRaSYXnO9Zb8OulSjLR7hwtID8v7H0tLwfFCeqOSnMvrGLhTqIGU3w+js0+
    Cu3omUyWShfeh4j1J2a9Wu8wR0XFSDqwyWk7WM/6OXgSHEQjXhkkgnTCqFj/bmSi
    Qx+1W4K0eERfIh3E3vxY+j3c9/N4db2AYP1nXlXkmN+OZH8u9Gznv0Dd3U/ZyChK
    o/ldKW6j+o+XDSGfDuHMS0SGSBpZ3lVxFWxfBSK1zhKYknI0T8da4HFRcYPMBH5Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dE2nC/34 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dE2nC/34 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeCDAF4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:05:56 -0500
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:54931
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932969AbeCCWbP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 019/219] net: mvpp2: set dma mask and coherent
 dma mask on PPv2.2
Thread-Topic: [PATCH AUTOSEL for 4.9 019/219] net: mvpp2: set dma mask and
 coherent dma mask on PPv2.2
Thread-Index: AQHTsz7mxKar5FIWJkSznT4hvjdHKg==
Date: Sat, 3 Mar 2018 22:28:06 +0000
Message-ID: <20180303222716.26640-19-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:cAxH0CtR6x9K61ZZgnHEPkghU+8kCehMK9r2T9n1NvXDQFy6nnykcUukD1i7QS0gnqb4o2PYoFL+xN3FdQnKeLfQMCfuZFHRAPaYK532ga2TqoAr7zmDKmm1vWDMvsZ65sYtNwmNOcDXiE1cTIJ7GMsbp2GbRCm3i0Cw+THxUHjCl9RwW89kfKTGs+sOURCw6/c2md1UPaD9tidIA/6Jd4z9QD9F4zUGaz3w/L3Y+dgg5hAzxLW48Ul/4kAmuKad
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 027e4e5c-b744-4f2c-feb2-08d5815675dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09708AFA157D853F1208E37EFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 437p3J/okn8k0YI83xDIRghE/jDaurjbb0aA4PPZwbPBTS4WGk+YP7wZmeGhSp8De8fkMa7bObe4a8sP4i/Hi0VMwKQYuMAzJU0Cf8rBcYNytWZ0ifRpGs+8FxQFsM56+0ta3ktdMt6NVY3xzMi1n6txfjptLWdQypezrBLDZ1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027e4e5c-b744-4f2c-feb2-08d5815675dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:06.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 7e2ebfc565ee..28dcef283c69 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6420,6 +6420,20 @@ static int mvpp2_probe(struct platform_device *pdev)
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
