Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120805-2-10758668889996465429
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
    t=1520120805; b=xAscF0Q3DbQDYRs1USNieNqevfUuqYEJvoda4Rp1tRHVJzQ
    36XmBe/YDFVGL+qcqGDMl8T9TJ9HYW0ANM21BKO0Fmj1qeBt8BsIMLsLoPZWdbE5
    xzX8h/ZQmT+wwS6c+DEWDSlXKywBm9DzQN8EH7ULOUpouxbxEObYbU1a4hmNI3ep
    Fu9aYtBaW8I2V7ODZlhSqI3N3duNGXXt6/LAUrkFmQVXc4cfnoVPJe2PsFBTvxHP
    VfMsd0F5b98KKi3UXc8yPNTtjx1dQWyIEHc613F8ELR9qjwd/ipGJWkR9RES7lC0
    pI/RIltk0EFtEAt/hMejzYIfqk7UfhXAOp3wOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120805; bh=kcsz8X
    Ozpw+e+2oQzQrQzKtyzaGPJ2Y0bdN9VSeE4t4=; b=NY4wFPrlkzUm6UugbHjFGR
    Jt8jLSJWnKRPrh2Y9J1fcMiarjBC0rDaA5wtwDYbHeMUced25j9NXwBY9vh/TDBj
    +rBJpLTVU59Iii7pTIVTifAuViRrm9jE8SWRCdF+Cx8Zsph/RQFgUV4ZfvEIs7Wg
    P7kh7M9IjtRPgwarYQ7ydoQXP471jznWvmLqVyHwMEs7oVR6sw355aGW5AEAbC8J
    WAKY4e6yyv3cp5lScGlX5GnxlIGRRoIfPdKo7gBuETYVDyXJIyAD4KgaCosbSQYY
    6Fmk9MRD/tceBxzwzKXrR0NwsuQXwkPAuDjtuWzTOcs8b3yBFB6qC940rTYlM/9w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=obiGCwyG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=obiGCwyG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934081AbeCCXqP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:46:15 -0500
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:51939
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934145AbeCCWeI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 111/219] ASoc: rt5645: Add OF device ID table
Thread-Topic: [PATCH AUTOSEL for 4.9 111/219] ASoc: rt5645: Add OF device ID
 table
Thread-Index: AQHTsz8G3m7zhT9nPUWUywJnKNOuCA==
Date: Sat, 3 Mar 2018 22:29:00 +0000
Message-ID: <20180303222716.26640-111-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:W4iFC6oMaYI4wwJYMjnlJyCsI2jeVJD4JCjoXTWsgeggxboAEQyXrqahDKPDTvJiwrO041YdGjh7aycKY40mHL5GtHk4PFaRmPf9r36AZJ4J5oEuw0DyCcWS2TrqyOLIcr+k1dPEw/D+rn1BEs/4h65AXfrTl7p8L8StPzc9kwFQK7JXpy4TjgJP2lRf1hYaK8DqlN8XafCGirmAz4AE+HaSsder8buCl/9vFN629YJpoVSh1xag1Jk+5tLT8Msk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 892f51a2-3bc5-4e34-9835-08d58156dfa8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106875456A8290D0A5CFA211FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hR44G60lIy1yBcR7ZZzM1rbGktzuKHM6Erg35A2tT2UrHaESXotj5CBQE0RsB6UN4paUwUAHcDAd9Bdfk3fp7LUEFBvLLb//btN/fyOO46Rg/46WMyKp8KY5lrvjyZM5pMtvbYl9UTQtvTHe0PiJGDF3eAHKE1XEF+3H6wp4dcY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892f51a2-3bc5-4e34-9835-08d58156dfa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:00.2132
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
index 1ac96ef9ee20..959d53725cbd 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3542,6 +3542,15 @@ static const struct i2c_device_id rt5645_i2c_id[] =
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
 static const struct acpi_device_id rt5645_acpi_match[] =3D {
 	{ "10EC5645", 0 },
@@ -3904,6 +3913,7 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2=
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
