Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116791-2-7880937650831830593
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116790; b=SlDG1l9VmDmWeUT6OCi0TW0NEPDF8VNeI0o5rM6ITQF6UTf
    y25MBWaWILSGBToHadFskox/FQp2osImNQAsIehFN82m8HoIdJWsmOWqFIIWskqI
    aokL1puKyS1kllKFZ9kakt9lIAtP8jpLoFPd3kiKdWC+AzROB3JagkEMEQJvrozr
    L6uKblenwp7ZY6Vvejiz1rVYdK/HxKHuGCH57A7WleqqyhSxHw1i3PTf4YV3+SNe
    IrlIeZfiQNxvAeyg2+4rcTriLXlDNCVHyUobS2ciojC4FKYaB+UCkiMb7P0cUD85
    dOOkkTxE+Q6beykq4bsHogH5sfq7hetMLI8gYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116790; bh=vvKFin
    FwTtCD4n09A/A9YO4eabEhls7U+0xUDeRshBc=; b=D8x3YOdn7b/oXXq7biCiQo
    sK/2zOxekwYa+uVROT783NLzn4PbFG6hMzFIKAQEiN2/V1byQNgJhlKI0+1dTGup
    K/IBIpaQ1/Cr43C2aA4er4jvziSvfPvnuxPAcRn0tSo6sa5IKejywxz+RHOzIi/l
    SfbfSs5MzMPIWXA8MeBMRcCr1QTYBUA8qdmNcQR/QPNgN5O9hRC6t5MGerFhQIYt
    bEm8qVN5533sNsBO6tUrcPmOTUAfkibM1bEcqSnZ3vy7teAS/7XY+0DzL2U/7UZU
    xb1bKWebCefINbcMWJJVQGRKVFX0eVTMunoxCrIIUMRtSYMm1vjYVG6auwBLLxHg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NBO219IQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NBO219IQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeCCWj2 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:28 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934560AbeCCWjY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 054/115] ASoc: rt5645: Add OF device ID table
Thread-Topic: [PATCH AUTOSEL for 4.4 054/115] ASoc: rt5645: Add OF device ID
 table
Thread-Index: AQHTsz9aPpgLZHrzX06ElwCKVTI5Ow==
Date: Sat, 3 Mar 2018 22:31:20 +0000
Message-ID: <20180303223010.27106-54-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:mVqafQIMG/tVqLEsdFBRDYsyvBd5XLtO0yZCSeH8Zx1xhOIoW0OWlAC08fGG0lzOlzLLx8EiQNv1C50e+6xBWrHCtcqkfEdrih4AZn0htQEmyBh7uVphzHWprUI05f9lN0/UZQx/Lv4x5nYmKGZZ2TGGTYY/bthwfEYWbQR/wRfl8KRhlpqDDbwgVGpAWDZwwpdkY21Prhnp+9HTBXrqfj8Ve0VRBDQB9noqD6k2KPW2mdI2/+XVwyqUknqnKqvx
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eebdbdb4-cad7-48c1-af73-08d581579a02
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB111306708A309188C5BB5C54FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(6666003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 6pzwiNTrRFSL93vxOwO1iZVxZOY2PzvbRb+nqPi2p8w0eetDJclyvGl+1oKyDAGH6WY8szf3wSknhV8rog/hjutcu156keJX5pv+UTWJmlEh8wnBScNO/cSRnmJlmeTpE+TPuA7suBtFIZsVyv7tIQ06ttPliCuG8W1rjiIRPI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebdbdb4-cad7-48c1-af73-08d581579a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:20.1196
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

[ Upstream commit 9ba2da5f5d18daaa365ab5426b05e16f1d114786 ]

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5645.ko | grep alias
alias:          acpi*:10EC3270:*
alias:          acpi*:10EC5640:*
alias:          acpi*:10EC5650:*
alias:          acpi*:10EC5648:*
alias:          acpi*:10EC5645:*
alias:          i2c:rt5650
alias:          i2c:rt5645

After this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5645.ko | grep alias
alias:          of:N*T*Crealtek,rt5650C*
alias:          of:N*T*Crealtek,rt5650
alias:          of:N*T*Crealtek,rt5645C*
alias:          of:N*T*Crealtek,rt5645
alias:          acpi*:10EC3270:*
alias:          acpi*:10EC5640:*
alias:          acpi*:10EC5650:*
alias:          acpi*:10EC5648:*
alias:          acpi*:10EC5645:*
alias:          i2c:rt5650
alias:          i2c:rt5645

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/rt5645.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index b74840b5becf..327f390be09e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3329,6 +3329,15 @@ static const struct i2c_device_id rt5645_i2c_id[] =
=3D {
 };
 MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id rt5645_of_match[] =3D {
+	{ .compatible =3D "realtek,rt5645", },
+	{ .compatible =3D "realtek,rt5650", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5645_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static struct acpi_device_id rt5645_acpi_match[] =3D {
 	{ "10EC5645", 0 },
@@ -3702,6 +3711,7 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2=
c)
 static struct i2c_driver rt5645_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "rt5645",
+		.of_match_table =3D of_match_ptr(rt5645_of_match),
 		.acpi_match_table =3D ACPI_PTR(rt5645_acpi_match),
 	},
 	.probe =3D rt5645_i2c_probe,
--=20
2.14.1
