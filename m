Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121358-5-490753916182492359
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
    t=1520121358; b=aLZM8i043B2EDhjVSFSAlQUpdsWDpyzCqq/xTrMZAyZsxd6
    u448BiDdeL0zoXO/O07CH4ve2OiDdYxpOdM73Izay9UnnKuR6abUG5IE0jkEUyuS
    BkzyhMshGizUP2RPu5A+s5C48fiHiCvm/iKKaAFrDxuT8PWacsU6y58r5viMzszz
    9ITwft13MUXlhaPWT5dujW8DfzfZ+jNzRDlWbuCocId+OoRFyXR00b0iP8p5xYhK
    HOfrm6WbWws7/lkR2DhbEaVPdu5HrL7QeRhmEKhenKKxyGqDo1t8Kw/Jt5PEgj+0
    PMBcfMSie527hb2yGCyooj0x+eikSsL6F+5MukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121358; bh=V+swmL
    wBuF5MFr4h6kmSFBSvV2PjDFmFU/KKo0dNISc=; b=JP2xoAfL566ljM8WDhYNZN
    g5I4TvtOdy18viWT+NNkPm8p7vr6YpK9d2Q2qQn13X99PoQQOP3Iw1nwDW8uBozY
    BeMoRYd6w4JfJIDLvX0473emZnQr/yQ3Xq9SWYp6art3lZfZX+7mMxiODvL0Bpo6
    b4l00S+Tj7KZrTBu7B9TGSUVpZpEVEic6VPdLnKKnqqx/axUcmMYhpcBCA3my0kD
    24yeK5KkYGq/Rk3r/sWFg85hNxuSQQukXhIXvzHmxYvS7pphHtOdiAXdA4fm0Gdl
    o6XWIP9MBpVeLjlFg1CTsLLr+CFXjN/wlAZrQv5Xyb0RXZLBMn2/pAa4HFF2WyCw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cs80MJeJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cs80MJeJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeCCXzk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:55:40 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933899AbeCCWcz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 064/219] ASoC: rcar: ssi: don't set SSICR.CKDV
 = 000 with SSIWSR.CONT
Thread-Topic: [PATCH AUTOSEL for 4.9 064/219] ASoC: rcar: ssi: don't set
 SSICR.CKDV = 000 with SSIWSR.CONT
Thread-Index: AQHTsz72Hke0IW6rk0uG8HDvk8/0mg==
Date: Sat, 3 Mar 2018 22:28:33 +0000
Message-ID: <20180303222716.26640-64-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:CJtf/hiqJckOeRPSDHVtSZACgvqY53gAsAJwZgrHvcenJ0JWPTMZ0V7aYD8cwLN8R5/18xAcDuhL9P3TAocSRWKjsFAJ6wYu2J5dyk17sKGifBoef84nCCvh8GQDCleMkNEoY9b4DHqvdS8gEIOWBiqbTWxB6MWoYMAVNPrUUhhOAjwGSYkDOlz25IgreymbCgFFWeLkR2KITLRB3UTpOfMb6lDx4A9BYZ+6yAOdP+mEFRKCQ2PcA+SpOTd3vc3D
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43ba9a88-1c6a-4ab1-af82-08d58156b2b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109811D4FB51277FF48250FBFBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pUtRwGgjedXMWzoLptZXZ0LZ2TfCKHQSe0rC3hfms/aY7AXGC6iZq9gYmHnX/k+WNCEXhGq+Qi7j4lsFHELxW9qiv5iPsQWRrda449FKfoBJBnZaKZTrY1S/6zxovQD3DCjqPavRuy8q3PKqEwzcIuDAhve2f0ptwkgZe1XdFBc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ba9a88-1c6a-4ab1-af82-08d58156b2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:33.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 6b8530cc056efd4a11b034ca5b1e9f7e9563f553 ]

R-Car Datasheet is indicating "SSICR.CKDV =3D 000 is invalid when
SSIWSR.WS_MODE =3D 1 or SSIWSR.CONT =3D 1".
Current driver will set CONT, thus, we shouldn't use CKDV =3D 000.
This patch fixup it.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/sh/rcar/ssi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index a9a43acce30e..fefa6ad5de8b 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -232,6 +232,15 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *=
mod,
 	 */
 	for (j =3D 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
=20
+		/*
+		 * It will set SSIWSR.CONT here, but SSICR.CKDV =3D 000
+		 * with it is not allowed. (SSIWSR.WS_MODE with
+		 * SSICR.CKDV =3D 000 is not allowed either).
+		 * Skip it. See SSICR.CKDV
+		 */
+		if (j =3D=3D 0)
+			continue;
+
 		/*
 		 * this driver is assuming that
 		 * system word is 32bit x chan
--=20
2.14.1
