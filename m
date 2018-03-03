Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118624-2-7319785576735480205
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
    t=1520118623; b=wPqk+5RNBOGQRIwhuLw++1/hNYE2rJ3ucrDLtqRrGvglluz
    ufglpxOpPyKhB4ipfTofO8JUBDvPRK62/enoBJht8eWIi5EKW0+5bik7XnzTEFJj
    ZAhX9sIaQzlMrRnn8hCGT7s0kjohjKbrISBrdmQ6t4W+qGed/2ZYViYI90xLDuJh
    /stWLCjnzkRIfAR9GyAn7XEp3HicCV33Scrf07BHpSMAaEpDfFtDUdAVlpa37Zvf
    IL2O4bdGMQj/zYnzfv1SwdEQcIJYn85tpOGx+5eluoOcGF3VZrZPVULCXxROTb8v
    Vc9MR6v8tLM63bZWIwko/A74HrCRlAEb4GLm1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118623; bh=JEDJpt
    8mFrzly9ZSfQYOSkahV0mfkyqzkq3Iof+cfVA=; b=Vgv3GB3lV5jHIvF/QWbolP
    s8AfICL+nDid3LTZxkSTOP2LPvn4UPgbrctK0tZ5Cy7Fb4pDo3Ln1FuNPZwTwiUN
    NPx/rWikCfPwmr5Zn4friWtWXX5I6D8aiZ51Kzl5NjzEe1gQGb3mJPZ/2RVoOgVK
    Crju/VIpH3qFi+Xxlf/G6k9xLiN2rPErekPFVu78BuW7dJPI9LZO69r8ER5nGq3S
    4uab7EQCgjM5aWtWcSrnWc8MNv9MK8SmZUtvJXAXYqgfgYVtYBiPhsKn3zzDDGe0
    HNNgysXyvwcfPakNT8HmceVR3gFZy1n15/iAIPUR/jFYyltzL8g3mNlkjo5PQ4Lw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SiMkg09O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SiMkg09O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935095AbeCCXKM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:10:12 -0500
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:14523
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935078AbeCCWjZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 055/115] ASoC: ssm4567: Add OF device ID table
Thread-Topic: [PATCH AUTOSEL for 4.4 055/115] ASoC: ssm4567: Add OF device ID
 table
Thread-Index: AQHTsz9aCAqxRgwjNEGjCOBzsabUOA==
Date: Sat, 3 Mar 2018 22:31:20 +0000
Message-ID: <20180303223010.27106-55-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:jys3LgdbtIzSHsQV+H1MGo4BERKAjbX77q+a55sNBa9CKHETdAJSZquLfTVOzkWR0hmDrVrYINRVZpiZg6/Ad25qMUCGr5yv3OS5Wv4nmNxuo3xqtgHGq0nQ0kaT4ne1NfKf66vvJiAQxZRyMBOBBFbsporuYYAPmK9IohJ3DuMemrqTZw/knNHfBV3s+j3Abr8LUqvQJCqQ3BuAm2rXDk2LR00HZswnQSs5gmbZAg8+7JszoXFi+I6r79x+66Y+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3021011-f432-4fb0-85a3-08d581579a39
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113941752FE9E291742E8CEFBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(6666003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: sqD5rfJYvUP6Bq8KTm+YHCwM+PS6bQOhQ/wjlongNIb2xBVxiThbpUqwf5cPs5VlYoR/6Jq+O600ciot9GGhpXOjrO+4Ubl30VPxX+gEC0iKgN6qy8mZ+QNoDrNSfheBWeU3RMnEW8cSUrxb5bFsCM+eya/aMlKDHO1gRZ6LtaA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3021011-f432-4fb0-85a3-08d581579a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:20.8228
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

[ Upstream commit 71c314d7ef2442cd798584a3dece8151215e1777 ]

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-ssm4567.ko | grep alias
alias:          acpi*:INT343B:*
alias:          i2c:ssm4567

After this patch:

$ modinfo sound/soc/codecs/snd-soc-ssm4567.ko | grep alias
alias:          acpi*:INT343B:*
alias:          of:N*T*Cadi,ssm4567C*
alias:          of:N*T*Cadi,ssm4567
alias:          i2c:ssm4567

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/ssm4567.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 080c78e88e10..c2446489c422 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -483,6 +483,14 @@ static const struct i2c_device_id ssm4567_i2c_ids[] =
=3D {
 };
 MODULE_DEVICE_TABLE(i2c, ssm4567_i2c_ids);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id ssm4567_of_match[] =3D {
+	{ .compatible =3D "adi,ssm4567", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm4567_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
=20
 static const struct acpi_device_id ssm4567_acpi_match[] =3D {
@@ -496,6 +504,7 @@ MODULE_DEVICE_TABLE(acpi, ssm4567_acpi_match);
 static struct i2c_driver ssm4567_driver =3D {
 	.driver =3D {
 		.name =3D "ssm4567",
+		.of_match_table =3D of_match_ptr(ssm4567_of_match),
 		.acpi_match_table =3D ACPI_PTR(ssm4567_acpi_match),
 	},
 	.probe =3D ssm4567_i2c_probe,
--=20
2.14.1
