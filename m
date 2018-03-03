Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118653-2-2205347070902272867
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
    t=1520118653; b=M9Th45fjdyW03mCaGZi6AahW9aOTgxUgFAJageN+vMPJQRM
    xSU9AfuOLerKnQTV6LKkANFGlG4lrQWw/5+hrZNkxVoiE2l4OudqMv9BFj5gvfZt
    S1uXh0acRCfxsdWcILKqw78xomgyZ27/0I7klfrU/hpZAjJWkDb2TM8yMLUBLAbj
    g3uO3TvuKku1rz9UOSi0i7K5cfhPW/F4TAw4QO/EjYk9aT7ZevWtdb8VUU64wbfy
    WWnHZuTgb7nZWHCOqTdXISvj8HbTETKROKeuvgXWsaBKUi12F1jNbYa4cvBOy6CH
    sySKVHTgPorewHvFUmwlTb2jgyy1MiKRqJL5vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118653; bh=PoCl0c
    CcfrIru9PvUg7mXklL/7KlWdIvRL0/rIgqWLk=; b=ol3nZACd7PRXxyNjkrwZAu
    uzyKnMaus6GKcnJgtL4S4skYsdgPCnIdEBSxNzh5tXUyTeahMTMwlhFiYfdN+lZL
    gG8RgIigHTBHoRHOipl58RUXkAm14IxdQBmwFMkhPGCoiJPBF6800LjKHUOQlX6a
    hiCZFM0T55Q38jozpLUthyuE/yb4zad6SKkL09i4/To53KNbSP72Kb9PPQptjMUR
    r3+DONwUtx+vJWitjD18CbRFJOFO0zF5UWpTMVHICzhlUHFmOuOmdiOr1ha0zNfq
    bo9KsDbnYbEWgWezcVK8Z/pLg1FuwUhxBjuiYZuaAdgddmfP3IjfkyqRMKhAR9Yw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PlrfRCDq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PlrfRCDq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935134AbeCCXKL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:10:11 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935066AbeCCWjZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 056/115] ASoC: wm8978: Add OF device ID table
Thread-Topic: [PATCH AUTOSEL for 4.4 056/115] ASoC: wm8978: Add OF device ID
 table
Thread-Index: AQHTsz9axUXCujMbzEe7sCmUtayJ7w==
Date: Sat, 3 Mar 2018 22:31:21 +0000
Message-ID: <20180303223010.27106-56-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:gE6c7ukSpVe1APmBFTngKMkI22WAH88BTyxB/WC3VkxIy3ZuwPzPkMlLSzu0zs1lZeDz/00Wbtth6RER9hK490uZJUNwtz5Mrk/pnDmj6Z6FzC0ooxYngS2E6Flk2qm++N+oDLIy76ip1M9xlY5ervx02DMG8jPe0PmSeb7AXnow96tb56vkSPZZekzL2TOBF+/V3K4xH/y/PwxSS0votHplSS7ae9kybh9QzBG6WXeORVLu73W6zctu+rfy36W+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3eca2ce2-76e4-4dba-5bdc-08d581579a70
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB111379608D22B540D16B2102FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(6666003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Qekc/AoG63QZm+eaB24ijWlkKbvhd12DBP6rAZWQQ4mmSSCmdahUMgak2nhL7v34P3E4NbDy2WQR7auAfnKu0EUynldgC2vxfq9huC2M+9+tA9FTXJ/y9O2HrvoB4Bt7cNM0qHiQamOrYDnS66Lcdp+E2/RWg7041mmk3eC2/lg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eca2ce2-76e4-4dba-5bdc-08d581579a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:21.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Javier Martinez Canillas <javier@osg.samsung.com>

[ Upstream commit 5cf015d9cb02c360582b624497b0a1716881cf28 ]

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-wm8978.ko | grep alias
alias:          i2c:wm8978

After this patch:

$ modinfo sound/soc/codecs/snd-soc-wm8978.ko | grep alias
alias:          i2c:wm8978
alias:          of:N*T*Cwlf,wm8978C*
alias:          of:N*T*Cwlf,wm8978

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/wm8978.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index d36d6001fbb7..c4059c330077 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1069,9 +1069,16 @@ static const struct i2c_device_id wm8978_i2c_id[] =
=3D {
 };
 MODULE_DEVICE_TABLE(i2c, wm8978_i2c_id);
=20
+static const struct of_device_id wm8978_of_match[] =3D {
+	{ .compatible =3D "wlf,wm8978", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8978_of_match);
+
 static struct i2c_driver wm8978_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "wm8978",
+		.of_match_table =3D wm8978_of_match,
 	},
 	.probe =3D    wm8978_i2c_probe,
 	.remove =3D   wm8978_i2c_remove,
--=20
2.14.1
