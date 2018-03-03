Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121630-2-6579172857420761196
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121630; b=GRW5JoTm5XzPhQp+NDuiTvMFYXwCyRbY/LvHxB0TyXTtydN
    n5P05VMQ3CENRM9RS9lFBMNJpDU7qVmVjOMp1hlPRJg8WkMe8WXLO57mzab/Iq8H
    0sD7B8tzBMv5HnjspEE7OplpD4lrBqWw7DXF88lIwNGHJ8AhJJ5gqPEqwgoWbELK
    QkTwzt6LPLX2JFKl+rHcTwxye3rFkQNOBlx8zpcN0fw+aCPb9q4fqYpwPk/ytTzh
    k9qgYiUObnziluDVKp6mkkUeG7qJAiZjG7xI2drVBeeTyFq3O5X3vFbCYYEYVW7M
    9qSAFw1ukNfueUZJdsRtkowWdHRbBLaR5J8KCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121630; bh=TgklLV
    ZTRDjRw0Z0jgB5ZQX57ArRRocw6OI0h9rEQUU=; b=a/CokWUQ7YRTLaCkA0kYMD
    c+BI6qeAFZR5PtuP+dyucKNg2HbxadfYOe4rAYlUUuFa+QHiOTZS4R+JAkPx5u2D
    9kQRPmxEduBLoDpgjtv6lQGlJAehmJo3shs3eiCLEt12MPs/agZz9g75ZUE5Qocx
    uU6EA9WePyJVWjNNLvms09QxeQ+czoQvP7lD7uB7ChCLTTGUnKNZQC0Y6a8T8uO0
    kSwjKXK/EA99QoMFnkqENsSNJUsFf9wVGa4Ea2B/x/35jg/t03UsGqdBc7vrQNeA
    G1PNoxvUP7jON5770zlteeHQV9YB8IgmhLpccLqFl7u8kFE7hxode7s5rK2YmfRg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cBxFq6GS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cBxFq6GS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbeCDAAM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:00:12 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933786AbeCCWcH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 042/219] omapfb: dss: Handle return errors in
 dss_init_ports()
Thread-Topic: [PATCH AUTOSEL for 4.9 042/219] omapfb: dss: Handle return
 errors in dss_init_ports()
Thread-Index: AQHTsz7u4e9uoFn9XUGA9fNkv70RjA==
Date: Sat, 3 Mar 2018 22:28:20 +0000
Message-ID: <20180303222716.26640-42-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:hrcxJanjlapy44d+qIZ1YWOp+bMPhu7vzs6sSzp+upHpSQ5u4t379yqUsJiR47Y1m7hCQfAOo1kFDyiFe0ZK3kgrAgNREdVQzBM5uDol6Ao0UPodAgzUNH6AaMUCisUkfFVXP37YTK4pRhnQ0e0HGYrNu4c1Az2cgstvb4+WsHTn7f7d9DCIkAEUjb1f9G2k0wmD8aZimT97QRtAeauPRiIHsa4Nk42B50L3zw0G7tc8B8Ld5YWAZEchxWmMEBJc
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9278bb4-69ad-479d-4c1b-08d58156962f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10834CA994060A645E81950AFBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(39060400002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fkGthzvb5l9WX7MsrOoavuBFGIC2TitSQ6M89SAG3oVWjxuJ5D7sBn+4+3ZWXVRFLyfZMVL5Tw3pBF+uIiE4BEfo9F2Nt9JPlxfY/0Od2o8Ln3nv9+PNKI9IskAFAc2MiAELBy5UMw2Dl+LRL2dDLW17wonO3fWwKZ3jW48EJzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9278bb4-69ad-479d-4c1b-08d58156962f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:20.1662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit 0348aaa34412e24ebe622a2b1b013e68d6ae5412 ]

dss_init_ports() is not handling return errors from dpi_init_port() and
sdi_init_port(). It is also always returning 0 currently which results in
part of error handling code in dss_bind() being unused.

Fix dss_init_ports() to handle return errors from dpi_init_port() and
sdi_init_port().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com
[b.zolnierkie: fail early on errors, minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dss.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbd=
ev/omap2/omapfb/dss/dss.c
index 47d7f69ad9ad..48c6500c24e1 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -941,11 +941,13 @@ static int dss_init_features(struct platform_device *=
pdev)
 	return 0;
 }
=20
+static void dss_uninit_ports(struct platform_device *pdev);
+
 static int dss_init_ports(struct platform_device *pdev)
 {
 	struct device_node *parent =3D pdev->dev.of_node;
 	struct device_node *port;
-	int r;
+	int r, ret =3D 0;
=20
 	if (parent =3D=3D NULL)
 		return 0;
@@ -972,17 +974,21 @@ static int dss_init_ports(struct platform_device *pde=
v)
=20
 		switch (port_type) {
 		case OMAP_DISPLAY_TYPE_DPI:
-			dpi_init_port(pdev, port);
+			ret =3D dpi_init_port(pdev, port);
 			break;
 		case OMAP_DISPLAY_TYPE_SDI:
-			sdi_init_port(pdev, port);
+			ret =3D sdi_init_port(pdev, port);
 			break;
 		default:
 			break;
 		}
-	} while ((port =3D omapdss_of_get_next_port(parent, port)) !=3D NULL);
+	} while (!ret &&
+		 (port =3D omapdss_of_get_next_port(parent, port)) !=3D NULL);
=20
-	return 0;
+	if (ret)
+		dss_uninit_ports(pdev);
+
+	return ret;
 }
=20
 static void dss_uninit_ports(struct platform_device *pdev)
--=20
2.14.1
