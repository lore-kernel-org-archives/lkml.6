Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118984-2-13489318128288927839
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
    t=1520118984; b=lbfzkf7h+KFgN5Ms50gMwL57pGsBHi41SdwKrlv2q6CukA3
    ExHCiZJhdweqCkGAYVlIbTyXGSQa4s7m1TYCUvPB1Z81l/h7n8ydK1xzpMzY4reN
    dGocz9H3ax3khpW/QUSL5G2rEtFW7Xd04VRV+keR3QuBCv+AVnGgbrs9buzfAEpU
    3D3rnW1bAWhWmm21zsinGQSfWBVf2w8lmbUbvz0yjrePqanpOhhBPNsOdNqDQ5R2
    Bm7C6JC2Lgp5pNPeiPyelmEcsryi3fHwTnj2Uhq8uNfkoEOT/4qo2V0QPtBndnrW
    RdTNZeQJxRNHI1TaMfa5g93DOPl3d8NF3rOdu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118984; bh=kct5s1
    GMMF6rcCx3aTzrn4VLpsyBjbn+0Mk8NeZa3Zk=; b=kc+wchhehQwEfvyQ0dYZZ5
    y9BwTUkH2YDkAU+HgVetbluDfrrhsedQRttNzKg9/QLAwUW9rXLHy77d4RNsbEVm
    NJzkS4gwh4gtL42pxGOYVxqmrcZM9aBJaab/5+TFVi23IM06qBtIxl/5prI9VhSV
    j8IsfgIvgjxuyq0sprG7ATq2rPWpY+bQ8D2J++phGgB2BzUuzeKaosY5X29ZSWkt
    iHJicqQP8X4Z14iE6IuRHNvJhe0XkNtww43jefk7mUe7kbkisYLWPZxzi5WAO7ro
    LSUP1SXu8vzmfOM/mcfz3dI/JYGhBhpby/eBfYOUzAEs6ck9g3SRWC78f8l1VUFw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ak3+Xulw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ak3+Xulw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeCCXQH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:16:07 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934905AbeCCWiO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 026/115] [media] media: i2c/soc_camera: fix
 ov6650 sensor getting wrong clock
Thread-Topic: [PATCH AUTOSEL for 4.4 026/115] [media] media: i2c/soc_camera:
 fix ov6650 sensor getting wrong clock
Thread-Index: AQHTsz9QOTglGdrwSEGpfsGsgVGMsA==
Date: Sat, 3 Mar 2018 22:31:03 +0000
Message-ID: <20180303223010.27106-26-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:MFiFHgT3QhxPPWfijsMQODXWHydmEJfaOYW5p79HR9OsAqxdNqC2lx0rUKeCTMlByEkh227YE+lfrRk5zYQtcF9Z7299Bk/7RBmrHMT5ar+FOPn3519y/dDeKLQkFDWQ8r7LVfQyvlIrHI4Vc9Aryz56Y7+zkZy1lg1jPV6YR6puy4RUm8I87ovjAwZ3mQRjwOjZ0y0uF/wS3afChWC1yiR+VlzVDUL0rKWtDZtsSdmZrbEvVeV9/iS2z9taDfrR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 103019b9-de6c-491e-8756-08d58157708e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10672B2CD3AA5DF6A023504FFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(39060400002)(76176011)(6116002)(25786009)(3846002)(102836004)(575784001)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(8666007)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: enGlDa0gcMm1j84GwrDdyrrloNnv4Y04Pkn+y7GmWNA4LXEv8QTV8j7N/FHfJAmJ6dI7biD/G28KzEQEIce0VHpuQvlxKuy+KnNE7tnqw76AU4az7A+uQXRn8H1qs1hbCwDsKf78OIkIV1D9dr76NowrRYesEUjWC4R+zyC6fao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103019b9-de6c-491e-8756-08d58157708e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:03.8852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index 1f8af1ee8352..1e4783b51a35 100644
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
