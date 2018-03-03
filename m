Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122000-2-8854817025206101394
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
    t=1520122000; b=lXqCHrZJuPvAHwb6AJ9v2in8Aydv97H2aiTXxJCvHLmFAAk
    4P+YKheG/Bwc7ioFJG0iDWpL6po8oDhpQsu1N3Fmc7PyAcLn27QwNyIclXI8ZEz6
    NYGkE3RWTkaTBP2bFxMTHXRNRAcQTAhq/41g+IHgrYNmVt2zfUBkvEOs8vp4gmB0
    s54/fYHZLY33mPBxWPLl86GKezm2SNNk5uJQ3ztfA0rZpPzib6VZHQac2oVDr+nx
    pWq+5vUdvxBjNSB4yQluBrJbblm6tRUrnHXpbjeoghZr6gGd6OTsYU9Kkox5GdLI
    VIkEMbJtkI4P+RzB/4DTtu4u2UZMZPZRYBbAevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122000; bh=19EPAW
    ZwRNHHVf9agFmTp/lICVfx364JYVE0f1QSEqk=; b=Z34s+zoHw+XlkNz8c1b6hw
    wJzXipjLOXfKAGyoEbrt6uk2eO/bQ2ap7VqIpXTFWPycS1liyLVmTPCU83KHQib1
    2VVVwezbXs7uIKqhT7U6VIKsewAJKJd9iS67CNXw7VY3RMrLGDOR5V0hIXed3tp1
    wSmWQH9ZhStAaGQVzvXaEo9nizVxHHJ4ETRlZC58sWejQoG1cIeKnzYfao/IXBrc
    cUUD0+HK5HsCzgGANbFMr7d8O8O4hmkyIdHiLBUfffZxHFWLpSnzDgx5GMqEKYeB
    wsj/8OFNLPhAxD1CzWc6BmbPllqMFDIfp/bFo7kBEqPtBZG+FiJIQTexgYsVKWzg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lfhmvtdl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lfhmvtdl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933820AbeCDAGS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:06:18 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933620AbeCCWbN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 016/219] drm/sun4i: Set drm_crtc.port to the
 underlying TCON's output port node
Thread-Topic: [PATCH AUTOSEL for 4.9 016/219] drm/sun4i: Set drm_crtc.port to
 the underlying TCON's output port node
Thread-Index: AQHTsz7lVKqi4LdPLECQMZm1gYgWIg==
Date: Sat, 3 Mar 2018 22:28:04 +0000
Message-ID: <20180303222716.26640-16-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:EprVds+eCpNT8Sg4GGerUhYCfYifPh0m/q759EjYLWxTcHWdO50fQGUda4iUYKVQjQtWnj7+QSl9xixe43xp4sJF0LhV38gN9FioU9NqYUQRo2Bp/Azsvc1vbPpziesz1lFi5V5rpNNMkpxcCDl+TcXNPRL0f9P1qrhsAxtgJCNIRmhdILUWF27NvqJtjD0HZHjyqUteZne84Em50zc6vOq5UbhRd5dvgAgOKnsz5Krmtq2sQrNUZJ+bM9mSgc9pkl967pGwJ+SEATEJIkojjIO7vP1s4C0x+J+LjNImGNB0s5ljqZ5Mflp32e5R70wTu8jzb9GK65ceUozs7Tp39A4cFHp96AqozSPLIgLmBcUttIEerstbi5daPdoTKIE0;5:mPsBM2YgCtQ/fhjNKATTtUmvGZPls8ILzd71jS+fAiFJ2bV5iJU9y+gEBCLwQwlUqLOmllB5dMUpXkEEFOCI4E8rcHWkNnBKBv5W7ft+b4oYcKrbdC+ngQrrkr3wi7CmwSziPQipjBzQkF9ga+AFaO11f+MboHi3XClmF1wLqe0=;24:eSQQg9DxLx/OkBWgAUSVO1CHKB+xMvelQEoODGTipx6cKDQetY2ODH2E7tR8ovJVE8aC12eT+rwMktjUGb0zbv2J3xPT+5xinEJ4PTI2w8o=;7:NbE33UHenx0B5wCJs3PQ8j2GGYPZtL3ATYha52lpe10Sg0m6uV3bi23X0PqiRNKX8m7wuQ5sz0lRsErFRRYdq+DgFbUcfKVuKvtcEfMYTfzstBEQhaiMrb5iPqiwo34onuzoJ+n0v43U94hTb/78zkCl8tdYhm7vGJYVrUBxbRxb7AyFfQuLqmnujaC0MndXhl+AoU65WVG4sWZ13v2PSXM3kH4cxQlVnJvM5yT93bI9H/LFicETtmFVXLw8JHFp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b610082-9ff1-4d1b-6dae-08d5815674c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970905D27A993AF2434DA73FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 7nlufsXBcBOMvYQWWfPQBwO2/z16H0qI0sf3PStKlJK3gUbKXkZBiaww6mcZBuIrnD/duRlS7dOuk29i6Js8MM7lP1uBmyPfY2AGhHnTVZ7V0bc48cll7Qe6pv+l0BfJH5Yprjv6ffWnTAT4PPq2jD890/fSZdo70DFbSx3PaOQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b610082-9ff1-4d1b-6dae-08d5815674c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:04.7287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 7544860733d158e3edbf309f27e79e258c8f66bd ]

The way drm_of_find_possible_crtcs works is it tries to match the
remote-endpoint of the given node's various endpoints to all the
crtc's .port field. Thus we need to set drm_crtc.port to the output
port node of the underlying TCON.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun=
4i_crtc.c
index 4a192210574f..caba0311c86c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -19,6 +19,7 @@
 #include <linux/clk-provider.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
+#include <linux/of_graph.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
=20
@@ -136,5 +137,9 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *d=
rm)
=20
 	drm_crtc_helper_add(&scrtc->crtc, &sun4i_crtc_helper_funcs);
=20
+	/* Set crtc.port to output port node of the tcon */
+	scrtc->crtc.port =3D of_graph_get_port_by_id(drv->tcon->dev->of_node,
+						   1);
+
 	return scrtc;
 }
--=20
2.14.1
