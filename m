Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122044-2-1326870087159584705
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
    t=1520122043; b=gMiIvw3HQtkgeCSdelGtydqbevjwMAbGWVLqv5G/f4bUXuH
    I9iq10lGKGXZa8SKAQaWtmTafu7zJ6qlkIntPBmkKlI122DgJtHzvtwGcm3pbZfo
    GEZse5EABMgRxJZhCN0Hb4teY42kbZYB7Z9dXTUb0bgNk40AqXOkzC1KH3121cSi
    WRHiPVUDS0RpaOqbaT5Tn9MhG1p58qOmMoL7F9F/8v3BjS1Em2zD8aseG6IN8mWT
    r5uUFtRUqgSUOUWUwA1VXDQYcximfEPVGj89Q3+uYBV//cZgu4ETb45uiQLn0gys
    wbdWutauXrRf/f3LqF+R0HxbfZnkIETEeoZE/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122043; bh=HXTVvV
    PoE8IxDb4eDzwTU4efPz28NDDCNHd4b9SntIk=; b=WKR2G9pfI8MDdNJifHSVLB
    c82De078xiyvFRGSFRl8bfdzA8C5EUIgEZhMhXufrA2ioYSdj3wR/N14DM5eAUKw
    /JfVrD3L4cAJA7sS96Ix4pQ92oRdz1tIQAB/7VIPjR4aAjCj3MqG/EX3iFLnwnn5
    DwfqP49A+qtv6nI9+tEJlH2KYc+syTG7O/bBOOXoQn7IlIvBUQvXXT9MqB9r5bj7
    +VvVIUYYohKufcavBpdGai0pcfIKBcUaOFsGTYmaqqd0bQLUg4ZgoomqsUkYeGeK
    XBYuMPsdZI3Pvdw1Yt3wLTL9pbiHQKjVhbb1AnigcDM9a6XLqhnFGOYgFwYvhvlQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZVcbvXsz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZVcbvXsz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeCDAHF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:07:05 -0500
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:54931
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933386AbeCCWbM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 015/219] drm/sun4i: Fix up error path cleanup
 for master bind function
Thread-Topic: [PATCH AUTOSEL for 4.9 015/219] drm/sun4i: Fix up error path
 cleanup for master bind function
Thread-Index: AQHTsz7lsadMh7nm7EeMT+iJjI3MYQ==
Date: Sat, 3 Mar 2018 22:28:04 +0000
Message-ID: <20180303222716.26640-15-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:31NUcRSsD2JFqyP9uLmt7HrmjUYyvj6+ka4rkUcDZcoNZ1RhUEs/Abgf5o3IOw8lvHT0KXhL4Ay0epuFYjOF+GD+ENe1DxkRAPMcggW6I/IeTIVXiftihNGbe9IR7h8t29DjXA0wV6LUjp9ieANTqPv7o2JQAPqXfmdZ45evth2GEZCSFTjpEPe49QwCIlZSPfWXD8OdQYRFKUaLdjs1TG9HB9D2q5hYxVcvyXZ3NghncMIAnfBp4aXZDHSb5xY8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e47da35-dceb-4306-fb80-08d581567475
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970DC9967AF87357A75BBF8FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201703061421075)(201703161042150)(6072148)(6042181)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(498600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: FEV5LVBEvWYftyVNMAkJmMWpin0ynmIr1msVm/kN21G56eW+CLrkf5PXKpK0Yj43fSNqmyVqSAlrBLVvIEvUjqEH1AU+WakAvBff2yJWchXbpn2AY/hrbXtITDV/omPed3foYE16PKq+/uyUo/1praGxvBNGkWwFQ2PFjh6YO6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e47da35-dceb-4306-fb80-08d581567475
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:04.1818
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

[ Upstream commit 9d56defb44b15427f4342c543a70fb7886fc06f5 ]

The master bind function calls numerous drm functions which initialize
underlying structures. It also tries to bind the various components
of the display pipeline, some of which may add additional drm objects.

This patch adds proper cleanup functions in the error path of the
master bind function.

This requires the patch "drm/sun4i: Move drm_mode_config_cleanup call
to main driver", which splits out drm_mode_config_cleanup from
sun4i_framebuffer_free so we can call it separately.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4=
i_drv.c
index 1feec34ca9dd..9e77fc034e0a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -145,7 +145,7 @@ static int sun4i_drv_bind(struct device *dev)
 	ret =3D component_bind_all(drm->dev, drm);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't bind all pipelines components\n");
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
=20
 	/* Create our layers */
@@ -153,7 +153,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (IS_ERR(drv->layers)) {
 		dev_err(drm->dev, "Couldn't create the planes\n");
 		ret =3D PTR_ERR(drv->layers);
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
=20
 	/* Create our CRTC */
@@ -161,7 +161,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (!drv->crtc) {
 		dev_err(drm->dev, "Couldn't create the CRTC\n");
 		ret =3D -EINVAL;
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
 	drm->irq_enabled =3D true;
=20
@@ -173,7 +173,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (IS_ERR(drv->fbdev)) {
 		dev_err(drm->dev, "Couldn't create our framebuffer\n");
 		ret =3D PTR_ERR(drv->fbdev);
-		goto free_drm;
+		goto cleanup_mode_config;
 	}
=20
 	/* Enable connectors polling */
@@ -181,10 +181,16 @@ static int sun4i_drv_bind(struct device *dev)
=20
 	ret =3D drm_dev_register(drm, 0);
 	if (ret)
-		goto free_drm;
+		goto finish_poll;
=20
 	return 0;
=20
+finish_poll:
+	drm_kms_helper_poll_fini(drm);
+	sun4i_framebuffer_free(drm);
+cleanup_mode_config:
+	drm_mode_config_cleanup(drm);
+	drm_vblank_cleanup(drm);
 free_drm:
 	drm_dev_unref(drm);
 	return ret;
--=20
2.14.1
