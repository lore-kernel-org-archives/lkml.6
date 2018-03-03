Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120709-2-9488183071644552894
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
    t=1520120708; b=i+Aa0M2Q9UPuFGwlhsOrGRTaCxDpzwLV7Sh7Mh2U/1RKSQj
    +XeWkAEtJ9b/2TCX0AlaYQ7omp1VyfSRQ0Yt6XBleJxl9L9J7UD9lyjOwvDY25xk
    iJULBX1pG5sVzzrXyueA1cjldN/7KzdjpE6bKwEk/RLB2jHTdiMj7EicSKqej9Vb
    Q0v5yRzCxZJOv16ld9Ywvv2Q4OUSqNGP4ZR6LuW+Pd4eEOu5eCbUDsVt0vD6yP3f
    tj7Z2mDoispflRBI96LRbzlpfX/tSqlnEvvCjZATKLeBRdKlvcyh+bXJ7Q48HVdU
    5Y1IxgE1G1S/V7M5SpxeiVJ0TW3nvVtnJ45qlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120708; bh=zksrdS
    0apNOBfwUqFuC1XuFb3XRhGuNoqnqkz0rTjPI=; b=hz/fJomnO9kcg2gI3CTVx3
    vbEdadZ8xttyphSacNY6M0+Z3OhKqL/YTJJWBbocxjutnYqD4lvWAHcL3LhVB02I
    3abXwp8hZ3N8yMfEin2LyN7pM3PQYoWmtXIG7OnCc4CO8hPcRaFmzpwozn+wg3M/
    69ksrgJR5Xh/+mFJ9MthUfKoZH0VFVw+WbZKWOQdi1GhALitDapOvzW0VBVkT5MK
    qpMprPV0/Nk4XYJPjgdP4m3E1pPrlfTfn4UgePfgLDUOlL7rFn6h/8ZEqHtcB/Wu
    ZygZFapYGtzSNF+iKGybYOT7P13bnmlVLzzYuHwebI3P46eknfAyEFHHjQuAopzw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jPx1nNk7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jPx1nNk7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbeCCXpC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:45:02 -0500
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:51939
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934078AbeCCWeL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 114/219] ASoC: rt5677: Add OF device ID table
Thread-Topic: [PATCH AUTOSEL for 4.9 114/219] ASoC: rt5677: Add OF device ID
 table
Thread-Index: AQHTsz8IQt3MLg3It0WGUDi5MZbpPg==
Date: Sat, 3 Mar 2018 22:29:02 +0000
Message-ID: <20180303222716.26640-114-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:zQbC2EX9Dx/C9gwONRnCwO9MluI7Ws7DJxGayYxss/FF692vy93xzF4gHFcrZqxD2R0dI1T/iMGutM1DWZdErxhSfTfvgSXZ2afQJVjq3Gq1L6zCCpumduT72g1OM9GaIloAibm+IHoDwhnw11ooyejh9Xvdw55Avc9TtOLT8TB4CQSBJOY8PThTZQP0UpSQ6t0oFlj+2NIqWtFjhI13cXoCHIsuKzst65+bcKfOGhjyEcs0hfTWXBofAkgINH8Y
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ddb34f2-fa08-43b6-521d-08d58156e0c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10680D6D37627C7CFA7AD1FEFBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mGy6EAys9n5k8U/LxO/j/2wYQn06Ux5TCGrzQFLlJEklvYt2o/QMFZIDNJJKd68Gwo26MyEqXMcJvsvCfiWyzpiA1VLXN7ZLkMt17hdV1zmLanZvqztur+9McfUdqZ9kMxLHs5gWC8PX0tiD0lBGUOVgdimI9QTMLNv6gbBcn9Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddb34f2-fa08-43b6-521d-08d58156e0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:02.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Javier Martinez Canillas <javier@osg.samsung.com>

[ Upstream commit 7b87463edf3e2c16d72eeea3d1cf3c12bb5487c6 ]

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5677.ko | grep alias
alias:          i2c:RT5677CE:00
alias:          i2c:rt5676
alias:          i2c:rt5677

After this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5677.ko | grep alias
alias:          of:N*T*Crealtek,rt5677C*
alias:          of:N*T*Crealtek,rt5677
alias:          i2c:RT5677CE:00
alias:          i2c:rt5676
alias:          i2c:rt5677

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/rt5677.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index abc802a5a479..65ac4518ad06 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5035,6 +5035,12 @@ static const struct i2c_device_id rt5677_i2c_id[] =
=3D {
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
=20
+static const struct of_device_id rt5677_of_match[] =3D {
+	{ .compatible =3D "realtek,rt5677", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5677_of_match);
+
 static const struct acpi_gpio_params plug_det_gpio =3D { RT5677_GPIO_PLUG_=
DET, 0, false };
 static const struct acpi_gpio_params mic_present_gpio =3D { RT5677_GPIO_MI=
C_PRESENT_L, 0, false };
 static const struct acpi_gpio_params headphone_enable_gpio =3D { RT5677_GP=
IO_HP_AMP_SHDN_L, 0, false };
@@ -5294,6 +5300,7 @@ static int rt5677_i2c_remove(struct i2c_client *i2c)
 static struct i2c_driver rt5677_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "rt5677",
+		.of_match_table =3D rt5677_of_match,
 	},
 	.probe =3D rt5677_i2c_probe,
 	.remove   =3D rt5677_i2c_remove,
--=20
2.14.1
