Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121451-2-5058958831961025948
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
    t=1520121450; b=cBcg3FcVsnHZ17jSnaA2RNonLJm0TpxwP1Su0HCv3hy5ofv
    mdOtpt6SJUbKBo38lR1iROm/0HnCEIAhr/mOFg9Yc4F9sw+g14gmAIfO6GD/T8yQ
    oluZWj6fAHWUdgPUBBLPSbJhoQl6MlxQaiSylhwyojh4vTkAgr72vMnj38qs8KXG
    yuiKES2RFIFtrBLxHEe/+L0SPw/hzL58YE8tas4DBStf9iD6A8pRmyrqqRBSgU0j
    hoHxoqWatJ24Dl73F+Pz/lE8ovvR/ffbtzQHisxttHxjDpjtvBEwOuEB7YuUTqkm
    Hoguhwi3wpv668Gp7hMuY857itB7I5Tx9wEdHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121450; bh=C5OOle
    rbsEcREgAOVI1QlfJZvF3flj7GL8OWdHCToqI=; b=ZPabzVHgGLO+giun1/ujVp
    pHbbUjedk9TZa1lrTu2cRmj//hAX2XV0qZ7gFe3s9n+9QwXAT7MBPD1aVi5NcuA3
    Yc3dzIdOZIt8jU7XEgKGz5X5/DCeGN7ugWrZ6po6NMiHkPvOZwAobpctCzSZ2bp2
    EuuDU/BtPD9DU/bXtTgQCHxqguuvDfMsWXpO1UiktythaPR2x6YExQEvNRyOo1+J
    QgRlBJ9WdD6FRplfIpW5vRvagMsEkpjV+3MHXOju9rIyxF6nDpGv4xurZ+mjJm5V
    a19EtBmoPF0tItKu3talsCjzvDg03BhNKNjdWDH5ubRnmSaGC73UPMrO3ERMrHjg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvv25zRa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvv25zRa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeCCX5D (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:57:03 -0500
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:54496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933819AbeCCWc0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 057/219] [media] media: i2c/soc_camera: fix
 ov6650 sensor getting wrong clock
Thread-Topic: [PATCH AUTOSEL for 4.9 057/219] [media] media: i2c/soc_camera:
 fix ov6650 sensor getting wrong clock
Thread-Index: AQHTsz70/3XDuDz0Yke45diVhBwoVQ==
Date: Sat, 3 Mar 2018 22:28:29 +0000
Message-ID: <20180303222716.26640-57-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:5yOgNPSNLt1GGMo9ttdCnqJuzV6MZgy9paNbcRh5pmZ1qWPqlqMbHoCL9PKSLbbJIoIaGtOzjBpVWmkHeQxzVNAVdTwaCmdGUbgFAeYjDHK2oM/TTKwatX+3xE0wF+IQiYhhvqB4DqVi8NOiCHYTLS7gSK9LAUcn4CJnLzWH9yNVAH3VwgUXC3Amc1nALmonKydtgGsBomTZDt0ZAHSsG4u7tQ9Ubc63fHm5y+S2IASjF+cSdpC0kEF95i/wQUeY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d87efe23-1732-4516-fcf4-08d581569e9c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036FBE74197146BBA720656FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(39060400002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(8666007)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: CuYm/tn18sbKolnDDiVgD+SgiLGMAbmUdmOkUjR4pkpJWvWZ+rHHRB/TcTP22ZzQDNoWNTKylCRS0c8NgZBfS9/CmnuUaben+pJAs09xFZl9A23B8l7I8Bl6Yc+AdvsIElaST/kY9hgdjmDa+eCb46pLjhHl1RC6/4kt9f/pZyE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87efe23-1732-4516-fcf4-08d581569e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:29.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
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
index 4bf2995e1cb8..8f85910eda5d 100644
--- a/drivers/media/i2c/soc_camera/ov6650.c
+++ b/drivers/media/i2c/soc_camera/ov6650.c
@@ -1033,7 +1033,7 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->code	  =3D MEDIA_BUS_FMT_YUYV8_2X8;
 	priv->colorspace  =3D V4L2_COLORSPACE_JPEG;
=20
-	priv->clk =3D v4l2_clk_get(&client->dev, "mclk");
+	priv->clk =3D v4l2_clk_get(&client->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		ret =3D PTR_ERR(priv->clk);
 		goto eclkget;
--=20
2.14.1
