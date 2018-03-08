Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491741-2-16554668693411769033
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
    t=1520491740; b=r1XJYKpzQCm2JPw8agAjel+aLpsvVK4jPxsIAHruxyyF7Oz
    ESLccuVbldtlsLNGQa+xlxSMUR8k9gyLUo1E55QmXIi4T9qTDO4SzXkrrnkjm/k7
    K3R0NTG0KQb/4O2dKQNTbCcBCnHALCw3N32cBC0RdLYhGgWBtZugZv9V/f6VE1qy
    2NAdz820mAe0DJmarywdgkfGxSEWlPXOCpJBXSdj++kKryNN3GsWeDEi7JgL6wHp
    vR5RNL/7MHe5lv26GXQdBj6FMPYB4DZElZ42xs20v4i2XIHAKi2J92hw9yXom5H0
    uiWViE5tTK6p0RjtehnKrTc4JuaiHuz6w/oXxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491740; bh=AkJhVf
    J1nAur6Od7PlwDuH0UJiq+I5seQQeV+TnQWkY=; b=UVV6a64MmZlT7RX0BRyIDj
    6JoyBGNweJjN4gE9ce0l1txPfOKZOPEvmKa+ipzzMnAUuYwgJbxF6F+sEJ89pdGF
    gS4O0AQWEn6vf0nwaghpspZGS846mgX68WnmeQN4tXcdRCHRK6spd636KgS2Y/Wk
    hORud20nUsJkFfaVHu6lNEh2OhCsIfDBv99bntvsCTUeubBA/p1C9OhCpofPmBWj
    xSnviHNWDxL13rsPLdXmuyaw5loEvggQIGHq9U2UzQ/cOdxBKOuJfHNOgAPp8peY
    GQn1OBoV8flUokFLhRnWtCRv2hz64MJ/Bmr2cdwlunYCQHMU/ReJ7jokYWKgkR/w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nai6UNSw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nai6UNSw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965191AbeCHGsb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:48:31 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51511
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965081AbeCHE6Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 22/67] cros_ec: fix nul-termination for
 firmware build info
Thread-Topic: [PATCH AUTOSEL for 4.14 22/67] cros_ec: fix nul-termination for
 firmware build info
Thread-Index: AQHTtpn8NZfzmEJMo0mQQ6AKYueXJw==
Date: Thu, 8 Mar 2018 04:57:41 +0000
Message-ID: <20180308045641.7814-22-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;20:eLYrs0UkF7kdJ6oUlB9WdA/nlwqEVFa59/0UInfUnHQ+tMjNsCehByHCEbRV732FjPmPb5PQYzRlMvThMvKAg2oWVQtU4mlZBV3ln/reWzqD2LAHc3yU6Po+zc1yxPTH+TLriTuYYriVWIDCeETPzyaUh9WKlVDnmMOd7LZvsD8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67921cd6-1585-4abe-252b-08d584b1331b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB108010D213FE121950628B5EFBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(575784001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Y8h066lhHBk7M/vcEULl7yxZtCA4jWDszoBsN28ELDXYyT9+5QCwpEY9z7dxqr5cy+JSGFxl0KrG8JQcR/lIeOw24eRId/mWQ0poscun4Ia1ENy+p4662djOPasCxujbVHNv4Ts8L743pwcDc90GPp2/QQbaI4F3PcSfbIg1Bir/wKBfth0zJzSMOBDtdVWxwSCisofugh8ibm8K70yjgTvHNahqpVXBv/UsQLWxmhh4HGctXEXyexL/wc91SBeUUJz98QxR1rasqGmxMfYt8+Q5wAJ0sICe9jJBQRrcQ2/SvP4cPgcXbw8k/qHxvcDCbJFNSiTwrUC1kkUiWINNCw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67921cd6-1585-4abe-252b-08d584b1331b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:41.0655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 50a0d71a5d20e1d3eff1d974fdc8559ad6d74892 ]

As gcc-8 reports, we zero out the wrong byte:

drivers/platform/chrome/cros_ec_sysfs.c: In function 'show_ec_version':
drivers/platform/chrome/cros_ec_sysfs.c:190:12: error: array subscript 4294=
967295 is above array bounds of 'uint8_t[]' [-Werror=3Darray-bounds]

This changes the code back to what it did before changing to a
zero-length array structure.

Fixes: a841178445bb ("mfd: cros_ec: Use a zero-length array for command dat=
a")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chr=
ome/cros_ec_sysfs.c
index f3baf9973989..24f1630a8b3f 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -187,7 +187,7 @@ static ssize_t show_ec_version(struct device *dev,
 		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    EC error %d\n", msg->result);
 	else {
-		msg->data[sizeof(msg->data) - 1] =3D '\0';
+		msg->data[EC_HOST_PARAM_SIZE - 1] =3D '\0';
 		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    %s\n", msg->data);
 	}
--=20
2.14.1
