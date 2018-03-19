Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493368-2-4052757074493939309
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493367; b=OInE70iQqVnB5VQQ6Hxn9L94hYuyYcRHX7TQiHhXdFznLnn
    xWLKOYB1dX0F/rD12Lde3+548BgRR5zj2HlNRP+54ThzzjS9Ez1NgiEu3WfORNZa
    xm4Xr32QAuGY4cc+KcBgULQchoKLUXIPgwO0pRnT4ihKif0h6HtYW/dniPJ3XWdt
    sMJ6uhGnSgFkTqz8vXG10pctUoajHxXgJ0d/sibiwn/c7N+xZYAjzD/DJkinVU5E
    PApyyhZNMJ9inYzgsiBzInz0blRGc7j/lkdpvVmCcU1v8wDA62pjDMdSYGY6XXT+
    ET+l5GE3uM6wtHDwROvQXyu7yPD2xIZZfY/fp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493367; bh=NoKc1L
    AqNDbBf5AUJttUbSc2h+Skj+E6GEiJjohBoLg=; b=Gc3IvJ6wTBAfdYeDEZDLRv
    9EUX2g6OB5U0+kmOR9ZdsYCmM3OtsXAN2GHonElmZvwNRnVpoZu2ps6XFTRcLKpO
    didoqCEDdo7D1eyvNyTVHdvGI1dksGHOugg64QLPGhWeykt/78cheH+SkuYhWwQU
    Mm1TAo0+Vlmcy75MPO57wlyXrZFoPhjAfHIodVisexHGYQ2VF01WOlqhlZOBfPHy
    bDQM1weue+UVeS50K4Syae94NtNiPI8SBivfy19DXNugaN5qzZqSh2zAWT0zoMiD
    4loeYya0qQwvxEdvz/I2fvnnFLWwkTwLGTH4YeW4OQ+XafnM9RrYxv8XgS58LdEA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2AJsgL3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieelgeenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2AJsgL3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieelgeenucevlhhushhtvghrufhiiigvpeefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeCSVCo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:02:44 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965224AbeCSQCs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 159/281] backlight: Report error on failure
Thread-Topic: [PATCH AUTOSEL for 4.9 159/281] backlight: Report error on
 failure
Thread-Index: AQHTv5t6o1e4yVJlL02/Wbb6ZoVlxg==
Date: Mon, 19 Mar 2018 16:01:01 +0000
Message-ID: <20180319155742.13731-159-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:+jraJQqPSvKyvrOfRrHn85SxBuJe6C4p+XeJ5i1XL8hDN4UI0GGrbC9hn8dEigH2WmKybwAfDWRlAxjjCsIX/3BbqSOU1eeYe5K77xPhoFLGqXsv2xDrVcdeud7rz/oAuAO4DoYYf//ht8ctl7Zyp2fe3VJ/36pTerMj1LOJqqQzCS3uMig2OUsKsiq8t4g9QLEFcNbCqny53AIFKQYAO5lsYfVKbXxuSTtQ3U8aBChky35vkO1ERnAPjxsH5kAT;20:Tpqr+AePsGyy1Z0SgehbjpdCoFo/Cse9bnkKRRva+u++4YVvVE0/cASSq/8EJq6OmBxAYIfBTa2JRrJWmvw+XEiXipxxp5NN/EPjengl2S6JVwijhQ5OFmdQLdW6Nkq30dpNKYAIvWT0hF+y9qXhWCdWLgcOijh95HEIwJfJcPM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edadae51-5c2d-4bfc-bfd2-08d58db2d737
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10627AEEA9943B9C2957C4B1FBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(59450400001)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(86362001)(81166006)(81156014)(8676002)(25786009)(2501003)(39060400002)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Jd0dztacVFX1VqgY0In93Kpb1maEfFLiUPIUQsq74hZ68Brsi6le++Q3xS9Q/8ZDBEazNbIhnSt7vhcCD+FSqnefdPrZYlDGyuE9Yojev8jLPwXtmiTC58bNx79vU2znX1Osg5svQH3O/BtiMEau/DWriCJKlNg1xmzU6rUaWGriRH7+BYZFXKajZRrviid1m9fC7MybYuDJtxF7rloMJjG/4mBgekwO1dN+Clpyl6LMeSFOVqbChdb+m7dXU/j893IlEwLkVENuWNgYKKIIHbM2k0BKiVmbT4Wav9L3WkRkwTfwP7oQ8wYXgEsj62TnWPW4JKT3563PwgVdzMbCeA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edadae51-5c2d-4bfc-bfd2-08d58db2d737
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:01.9211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

[ Upstream commit 7e715c2d9c27c23f3187454157c58cf292ed103e ]

It is possible to update the backlight power and the brightness using
the sysfs and on writing it either returns the count or if the callback
function does not exist then returns the error code 'ENXIO'.

We have a situation where the userspace client is writing to the sysfs
to update the power and since the callback function exists the client
receives the return value as count and considers the operation to be
successful. That is correct as the write to the sysfs was successful.
But there is no way to know if the actual operation was done or not.

backlight_update_status() returns the error code if it fails. Pass that
to the userspace client who is trying to update the power so that the
client knows that the operation failed.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/backlight/backlight.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/=
backlight.c
index 288318ad21dd..8049e7656daa 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -134,7 +134,7 @@ static ssize_t bl_power_store(struct device *dev, struc=
t device_attribute *attr,
 {
 	int rc;
 	struct backlight_device *bd =3D to_backlight_device(dev);
-	unsigned long power;
+	unsigned long power, old_power;
=20
 	rc =3D kstrtoul(buf, 0, &power);
 	if (rc)
@@ -145,10 +145,16 @@ static ssize_t bl_power_store(struct device *dev, str=
uct device_attribute *attr,
 	if (bd->ops) {
 		pr_debug("set power to %lu\n", power);
 		if (bd->props.power !=3D power) {
+			old_power =3D bd->props.power;
 			bd->props.power =3D power;
-			backlight_update_status(bd);
+			rc =3D backlight_update_status(bd);
+			if (rc)
+				bd->props.power =3D old_power;
+			else
+				rc =3D count;
+		} else {
+			rc =3D count;
 		}
-		rc =3D count;
 	}
 	mutex_unlock(&bd->ops_lock);
=20
@@ -176,8 +182,7 @@ int backlight_device_set_brightness(struct backlight_de=
vice *bd,
 		else {
 			pr_debug("set brightness to %lu\n", brightness);
 			bd->props.brightness =3D brightness;
-			backlight_update_status(bd);
-			rc =3D 0;
+			rc =3D backlight_update_status(bd);
 		}
 	}
 	mutex_unlock(&bd->ops_lock);
--=20
2.14.1
