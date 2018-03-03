Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120710-5-7229957475781269696
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
    t=1520120709; b=qzGrgffkMYzzikElYPtjos7LMc4nGA/vdkR3qsllOxxp2D9
    VOwV0W9zgbY1iIxSYSSH4MVTr7YxOo4OdD9H3ctQUtDcMCI9FKxFA8BHz20A6Tfh
    AbpcSVlTkcFWsBSdVwz8SjOvLOWxM2XAyN9UZ/TPyodoc6REYJSnAOyWcUQrWr8+
    E0yDrStPjSvCNs4hBQuuQuXmYcd22tRTBO9EvDRwfTr23eGsX5exUE/wfcMlkPCc
    GXCV649PtqMAkamxVm5eFgD1YTCiiIvPPwdpXJFMTb16B7ZDEE0uxXu6JZBvkgWu
    MrRylnUcKwJYOYv8Ort1B0ZgtlkgyHYBG0gVmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120709; bh=v/25Bu
    jwtcFkgNIwluYsEfXEEaAaDhYZG1cchk4qAmQ=; b=OEFJNYT6OeBcZKzu8BdV61
    ekn3BZfy1oQJQ+0SZIa7sKhuBj7NuhyWPc3dEPyurCXk+X8lgxvzzIW1jdLTPHZr
    68AjwroGwlANdj2jzxkpVOKEpIkuzEHA9w1kpIIcUwo4/o1HtpC8gUtfMWkHy0uW
    m5C4tzzxuRix4eQIo4TRAE343EzRSw1KoSdEVP53rX99ILRJTss709DIzHjC6PdE
    EgrEndEwtZYBpBhfDhwc4lM5Wp+8YYeFf2mrVI+RXnaU+j+6ATpINatrscHxePpe
    Qk3o2uoSsRZBdze/2DnBe8OkMY5YL9M9D0Vlcb+QTKIDcNa3hdhQI+Yhh7Sdb63g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y4vYKWy0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y4vYKWy0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeCCXpF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:45:05 -0500
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:51939
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934164AbeCCWeK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 113/219] ASoC: wm8978: Add OF device ID table
Thread-Topic: [PATCH AUTOSEL for 4.9 113/219] ASoC: wm8978: Add OF device ID
 table
Thread-Index: AQHTsz8HrfFCP8u9iEyowp4o08NqLw==
Date: Sat, 3 Mar 2018 22:29:01 +0000
Message-ID: <20180303222716.26640-113-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:eX3JE4uiWfPt3xBA/7gS2kc1u8AouYYnSjZNNN3FWKPGjYqEXqIfu06RgS1Ipd5k8sm1wtWMgffa0Pm1as+7LSTNsdnCUYKgDgcDdUwGfBD7jTC9RjmUF1yLEV0Hhum1k4BTPPPkFns/vzHmKLqEQxqViUbIkL2fqUYlTem/Ws8kGtW5wHaJaWj3FgTbgXFdgsG74Xe9BzfrVueBQdzknI7Dc4Ld3PgKv3j1cpK9QPCR/kdG1GjFXKh4S2gTQ1YO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2062871-9adb-4361-2e99-08d58156e060
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10682CA6FA1E7C01BD8D79E4FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 4h/gIt49GA+/G4oZJqK9y7nr6yqPb+JHsyDwGWrtaRhSLQtWvEj4iZkUa019jwWF/AUERUt062AaGjBt9mP6kcgFPrmhKDVyVyMNOasDwF2q/Lwb0rIL90Q5ymBq0jByj1bRy4m7FvfFfwgY77pdTOBc2J5G4oznDqO/PQ7xqKM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2062871-9adb-4361-2e99-08d58156e060
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:01.6976
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
index 90b2d418ef60..cf761e2d7546 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1071,9 +1071,16 @@ static const struct i2c_device_id wm8978_i2c_id[] =
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
