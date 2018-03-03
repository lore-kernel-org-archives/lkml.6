Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120524-2-61055841165098391
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120523; b=aRSC5BB6IR+xAbY8BfWPkUyBjnkwHPm4YzgNRg5fa4Yskxf
    WTU5pqGWMLRT7u1wVw8n0zYaLuFXlFr6CdaecAqIAGJfGV++GquO7bYXendIdAzs
    T5Gzi+Ng9Lg4uFj2zG0rJrU6cRy7hW0cXob7wYxEz55KabQ2Hy7MGk9PERntP7S5
    +K0pJj4NBbLjT4iMGhJoiWmeZ6gb554XuOFKQpAHTHOkHU8QIQCivZVkdDQ6UBJp
    oZT7+D0XU51Wd8OwxLKNUxtMpwPC3var35ockttRAlflx7V6lvV5owPYRIXyiD8r
    I2vQt/00oT7w8kEjzf5hXMDm3Qt5NRbhFobnr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120523; bh=jUOUx0
    DRfsqRE+cwHLf8+bsBF1MdtuVPcpmx+MBzfIQ=; b=OrE6zt69ptoy1LWVmQ0JlB
    8xXiZalO6z5mFwPlRxjlPk/2lnbFV5f3JDHLD76NQAvjUVtZyHQ6EXoQM0CTKM/1
    4lebJ3pqiI33czfiIM9eDzw/fIfZmZLUt8/r/m189LXhq2jXW4gd0HUGC0TVu4l1
    fM2RYp+1u4pbvrAv+KH3R33UxUw+JMdRQO4w82qgpswp+o9dtIHiDg3TrZtz3rvt
    0qyOBhyRJZiDACpf96ZMgN+9uqReePwCi4Bm+U2e6jdtFdpGTQBV31COqn4IDt8C
    X6RcFjA6FBA4qTkq8kbgK3Rt9oK0XXA4u6YabLSLShAeqoXvhD82AaN22o410RyQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iyfjX3BB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iyfjX3BB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933295AbeCCXl0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:41:26 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:42080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934294AbeCCWe5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 130/219] drm/rockchip: vop: Enable pm domain
 before vop_initial
Thread-Topic: [PATCH AUTOSEL for 4.9 130/219] drm/rockchip: vop: Enable pm
 domain before vop_initial
Thread-Index: AQHTsz8NyuUYPkf4VUqao+bAJSbjUg==
Date: Sat, 3 Mar 2018 22:29:11 +0000
Message-ID: <20180303222716.26640-130-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:7Ob4RXCT7Urd7SLWfqoMrkqc5dEvVUHviuH7scH4pXg5dkoXOnL/YO2Q71wtU8bcAXfRiXOou1TB4gPKOlyS2ZaYTdSIiKcg0c91p0ei9ZVnlhY0zt3ZbEMwtp0DL9X1fx0hspY/eEvJ8REMV4gj1Ih+98/vPAERFbt9j7ddgofcNBED8+R/rzeUwXLZjudAMnLJ4EnUQBeTEZ5V4UO0C1NHb+8ydvmJEWLOTyLZaFOy0nvZNMI5oeenwGWcmmW5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e61db248-31a0-4a06-9c0a-08d58156f8f6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10684EA58484C2B7D7FC7381FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(966005)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6306002)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gVeDxC+fqYQC7NhSpBfUj/LBSAWp/dcz1NPCHvSE2Wi+q+0pBVvgdUUVcEEHy7Wan9lSXWjDvwd6mmfyUUjK4PXMYUi992KNAxRB0fw84CH+HvSuSJZpgkapo+8XcyXTjBM9cG9dVkSzQvzJOSYBuVN6qwDJpZA1e39nh6B58r0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61db248-31a0-4a06-9c0a-08d58156f8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:11.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeffy Chen <jeffy.chen@rock-chips.com>

[ Upstream commit 5e570373c015b60a68828b1cd9d475cb33d3be4b ]

We're trying to access vop registers here, so need to make sure
the pm domain is on.

Normally it should be enabled by the bootloader, but there's no
guarantee of it. And if we wanna do unbind/bind, it would also
cause the device to hang.

And this patch also does these:
1/ move vop_initial to the end of vop_bind for eaiser error handling.
2/ correct the err_put_pm_runtime of vop_enable.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: http://patchwork.freedesktop.org/patch/msgid/1491481885-13775-8-git-s=
end-email-jeffy.chen@rock-chips.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 29 +++++++++++++++++++++----=
----
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/=
rockchip/rockchip_drm_vop.c
index c7eba305c488..6e3c4acb16ac 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -503,7 +503,7 @@ static int vop_enable(struct drm_crtc *crtc)
 	ret =3D pm_runtime_get_sync(vop->dev);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
-		goto err_put_pm_runtime;
+		return ret;
 	}
=20
 	ret =3D clk_enable(vop->hclk);
@@ -1348,10 +1348,16 @@ static int vop_initial(struct vop *vop)
 		return PTR_ERR(vop->dclk);
 	}
=20
+	ret =3D pm_runtime_get_sync(vop->dev);
+	if (ret < 0) {
+		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
+		return ret;
+	}
+
 	ret =3D clk_prepare(vop->dclk);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to prepare dclk\n");
-		return ret;
+		goto err_put_pm_runtime;
 	}
=20
 	/* Enable both the hclk and aclk to setup the vop */
@@ -1411,6 +1417,8 @@ static int vop_initial(struct vop *vop)
=20
 	vop->is_enabled =3D false;
=20
+	pm_runtime_put_sync(vop->dev);
+
 	return 0;
=20
 err_disable_aclk:
@@ -1419,6 +1427,8 @@ err_disable_hclk:
 	clk_disable_unprepare(vop->hclk);
 err_unprepare_dclk:
 	clk_unprepare(vop->dclk);
+err_put_pm_runtime:
+	pm_runtime_put_sync(vop->dev);
 	return ret;
 }
=20
@@ -1519,12 +1529,6 @@ static int vop_bind(struct device *dev, struct devic=
e *master, void *data)
 	if (!vop->regsbak)
 		return -ENOMEM;
=20
-	ret =3D vop_initial(vop);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
-		return ret;
-	}
-
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "cannot find irq for vop\n");
@@ -1551,8 +1555,17 @@ static int vop_bind(struct device *dev, struct devic=
e *master, void *data)
=20
 	pm_runtime_enable(&pdev->dev);
=20
+	ret =3D vop_initial(vop);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
+		goto err_disable_pm_runtime;
+	}
+
 	return 0;
=20
+err_disable_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+	vop_destroy_crtc(vop);
 err_enable_irq:
 	enable_irq(vop->irq); /* To balance out the disable_irq above */
 	return ret;
--=20
2.14.1
