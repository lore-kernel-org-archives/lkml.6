Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117640-5-9074464836766659914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117640; b=xCAV3Y2FLg3vX3nqWv0W/Rsznfy5EBRcVXU4MfguUdzbW5U
    BUl6AP8ZbwwygnbY2Xl/GE2p0y9VDjn8g2GYRLD0aMTf6U8um7fM/VF8oux1d2z9
    VWDIafdf6JZ4nQGJV98BH0s2tEuKCBRSSW7GxhxY4hkRVV1gOErAIMd1g4+CrURZ
    28jWkfGtbBSbkOn09KhpJ5mhujcfGVrTeBNea85Ea1xB+qhKVrfO5TUnT2JBGG5F
    xU0uynV2NAHrzkWH3nAzs4LvvBKaupQlB86stPL686obPXQWWdfQptWOPk3eQrnD
    SsKEi4aV2Js2zFBDSqKvyXGGZrNZ1PEaV1Dk//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117640; bh=X++CwR
    DZMiAhfXf4iA2f5KdCx3XUxGsctj2+UW1LRrU=; b=nzo9Kxt1DhnsZUtKk9um+k
    +/nTJgQX17hTaF1sUZl3CD/44XZmJ/mVBO5AzsPtDRCiUyKCB4YrW6OzJYhkbXBK
    V5mOGAQKB34A6Ww+v8MfdIu1EaYwEGEoZTOeAL69d6UUK8FeU8eBXNBO8FpDoOGR
    03A19qy404QfDgqs7wfeey+hesAQ3Er5KSj8W4J8iLfkWfvHnYrn69qkPlvJCXYN
    PmQPcTHCBGcoYVppsZHkfDYSuMiwqFFWib3XR9iKqpUO1PSOG4ULZlNT2xFh025V
    q9nPDm4jJOcoQjpSh3yGgzVhHRjuERupRLbxtcxFlafmUsuGrcE25fRzHg9Mfv8Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m3k/bfxY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m3k/bfxY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933793AbeCCWxb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:53:31 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935408AbeCCWlF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 16/63] [media] media: i2c/soc_camera: fix
 ov6650 sensor getting wrong clock
Thread-Topic: [PATCH AUTOSEL for 3.18 16/63] [media] media: i2c/soc_camera:
 fix ov6650 sensor getting wrong clock
Thread-Index: AQHTsz+glN6ak9So2EGOzDLJiLasxw==
Date: Sat, 3 Mar 2018 22:33:18 +0000
Message-ID: <20180303223228.27323-16-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:T8JmlJZbn3qwCe9kLDoeBna4t2GNWtu9kpF28RejkqRT8RjmGgPAAs/hukHHdObiuMsFq0jntm8dCNcpQMYS55eeub5xws4VTVwrc0dVy863PceNoH2vL742vACs2HJnOskeW2mKRNu6FNCNPz7q/3j9v6CGzrZcxME3Xm7LiRBgRFtcg52wcRt4rKLgTNTW9TE9BjM0fvh/0KgaloXBak/83yN5WZ8n1Mr7a9mhzegXcwsbpXDGzBHqCFKmGuGg
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26e8960c-4dee-4b7a-5344-08d58157d89d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940E5A18C61A07D54B11471FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(39060400002)(2900100001)(8666007)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8Je60NOVuTyAAViC8sq7xVx/DjC/lprlifX7rEuXfx1lHffhkMlpOn2KSUix1fvtflL7M1Rgntk73mfCqt1ZwvQwrGu3tHvbj7tYbmDWPGt3F1P3JxIYBABbOsA5a85/4CKdODzblyIGH10ycf9OVptJS9IrLtm+UOmRYeeZDM4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e8960c-4dee-4b7a-5344-08d58157d89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:18.5753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit 54449af0e0b2ea43a8166611c95b730c850c3184 ]

After changes to v4l2_clk API introduced in v4.1 by commits a37462b919
'[media] V4L: remove clock name from v4l2_clk API' and 4f528afcfb
'[media] V4L: add CCF support to the v4l2_clk API', ov6650 sensor
stopped responding because v4l2_clk_get(), still called with
depreciated V4L2 clock name "mclk", started to return respective CCF
clock instead of the V4l2 one registered by soc_camera. Fix it by
calling v4l2_clk_get() with NULL clock name.

Created and tested on Amstrad Delta against Linux-4.7-rc3 with
omap1_camera fixes.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/soc_camera/ov6650.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/soc_camera/ov6650.c b/drivers/media/i2c/soc_=
camera/ov6650.c
index ab01598ec83f..d8be90cd6e56 100644
--- a/drivers/media/i2c/soc_camera/ov6650.c
+++ b/drivers/media/i2c/soc_camera/ov6650.c
@@ -1016,7 +1016,7 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->code	  =3D V4L2_MBUS_FMT_YUYV8_2X8;
 	priv->colorspace  =3D V4L2_COLORSPACE_JPEG;
=20
-	priv->clk =3D v4l2_clk_get(&client->dev, "mclk");
+	priv->clk =3D v4l2_clk_get(&client->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		ret =3D PTR_ERR(priv->clk);
 		goto eclkget;
--=20
2.14.1
