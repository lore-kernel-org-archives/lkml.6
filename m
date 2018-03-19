Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476456-2-4656996168801357494
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
    t=1521476455; b=f21wOWcKnwP/xTbN4uiWMrxF1EqNOMTROL7zMkI5jJIzcEn
    9jTe+p1aiehoLVX2fgy3xkb5KkhPp4oTj2ek8ABeshKmaegSm81AjmYKAOI5CTpC
    xnUA/y6yxh03zwHd3E9b3XzFeztQCYY8yJM8f1AO1EawueTOyPvmyiX4MO0OEQ3F
    bA6p1c2dmWWUGajmRco+XNYelUEldKCnZPWAnHHs4EEm4us0sXYEjrE219Q4gpn4
    dn3OqF+RhYSTWiqGTTzTPfKvnaSrf4sxqsketLoLWXE+z6qmG1AHLUGdR2oANy5B
    h3vguAbziS3iHg1QbmQ6UP9gqbNrf8eyRAQHEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476455; bh=ed27tq
    UE1SPU1z6ESt4yTj2iMs4mA9NSm5y5u0B0q1s=; b=kiVAlgBUv/gkS6QRW2AuSN
    g3IZPJ9p+9T1t0VLG+xvc71dxQgobKWRYdhxX7ESt5q/h9Yx2LfoOEc9To0CLWOx
    wKFpsCqz9roYX8fOt9RH5DRwJbkmfAxhwu5D+6IDF3dz5/Y1Ui+VEDqu40+SmX4c
    d12iK2c2s0rdldPI34z1q0lRGOtwf1b3lmzowIEOFPo9rBM5/x82kw88wuDZyzOT
    mOb8Rl/6gNegtOWEUfziJcKWzkQqh+qymk8oTtVM4Vg/pxBnssQfjHrl7Dx/42pe
    KkLw+nSzSDhXdlbYOOSBFc/RjTj7Bzu9w7jCzlqXbEOBhwN8X5Y5aUTjqPIka6rQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H2j+9dJQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehkeenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H2j+9dJQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehkeenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966646AbeCSQT7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:19:59 -0400
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:37504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966955AbeCSQOW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 089/102] ACPICA: Events: Add runtime stub
 support for event APIs
Thread-Topic: [PATCH AUTOSEL for 3.18 089/102] ACPICA: Events: Add runtime
 stub support for event APIs
Thread-Index: AQHTv50yBPwTs1RIFkScLys/rcKK3g==
Date: Mon, 19 Mar 2018 16:13:20 +0000
Message-ID: <20180319161117.17833-89-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:NTo78xan/usJRm3B6rC7176Gbd0a58UoVJONye9yg6gR1JbLwbd2G73xg5YZXO0IozvjNXNjRgli2papjIq74JicEIdCMDoIL52SRGQCVNvhJ/tkS+8S4NL5MASuBx+rhPy0iYba6OA06Ld5lDwt9MngjkWWR/HXb1OVU12Mjd7LeeH1naKpRAz80f/vrW9BRzD97bT4sMuYToMNTiyOhkkv9CysquDz0Jsdrw6lZb30meQSuEC+bnRVF9nj9NHp;20:bO2mfykWUbmZM27sdG0PSq1MvcL7ROnLQ5Y2OyyUFETX0WQDnnxdHjSgGBTHYUDDzggh0ziqUETyuWEK2CXKEZPMdp3HD8N7UcatTHiCAWQzGk5M4rDRRvEecDs9gOiRVP300iwyyl0fMOfQp1QvKSFY22hInrH0CMlbef9OFUE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f8991fd-9564-4b39-68d8-08d58db47636
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11121261B3B7B2FCE23D56AFFBD40@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(53936002)(26005)(14454004)(36756003)(2501003)(186003)(305945005)(86362001)(107886003)(316002)(7736002)(6506007)(110136005)(5250100002)(4326008)(2900100001)(25786009)(102836004)(105586002)(72206003)(10090500001)(54906003)(2950100002)(478600001)(99286004)(106356001)(6436002)(3280700002)(966005)(3660700001)(10290500003)(66066001)(2906002)(6486002)(6306002)(76176011)(81166006)(81156014)(8676002)(68736007)(8936002)(5660300001)(6666003)(22452003)(86612001)(6116002)(3846002)(1076002)(97736004)(59450400001)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Pe4XpKHqbX+aCmxpzC5GEF6cPKkCUCm3NIzjvkDD0W9lQXMXyknga4oi2GgUH+qN52FLaicm4rO5xaVIibSKC+Lhx4+AAa/IIEixY3ltFGlaBhPTd8xviyw+5ya0jGN17qWQZHoDPTXCsBJJqFJjGQbEhPul6y0AtS3j2kecovyOlmULmCGDpW7exyQdQ1EbWi/MH3HO37OL8PEfoj1By7bd5kqKO3YJd2++3zow4KjfegDYsMmVLtEIDPZCMNJs47Hon/fGk14Zl2PWEnOZQu9rP0as2UIiA3tfrTDihit1LKAkJzpBYtL3svF7rDXkI0D6mRUO7e84SWUaue2gsg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8991fd-9564-4b39-68d8-08d58db47636
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:20.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit 861ba6351c520328e94a78c923b415faa9116287 ]

ACPICA commit 99bc3beca92c6574ea1d69de42e54f872e6373ce

It is reported that on Linux, RTC driver complains wrong errors on
hardware reduced platform:
  [    4.085420] ACPI Warning: Could not enable fixed event - real_time_clo=
ck (4) (20160422/evxface-654)

This patch fixes this by correctly adding runtime reduced hardware check.
Reported by Chandan Tagore, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/99bc3bec
Tested-by: Chandan Tagore <tagore.chandan@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpica/evxfevnt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.=
c
index bb8cbf5961bf..d375968c8072 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -180,6 +180,12 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
=20
 	ACPI_FUNCTION_TRACE(acpi_enable_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
@@ -237,6 +243,12 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
=20
 	ACPI_FUNCTION_TRACE(acpi_disable_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
@@ -290,6 +302,12 @@ acpi_status acpi_clear_event(u32 event)
=20
 	ACPI_FUNCTION_TRACE(acpi_clear_event);
=20
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
=20
 	if (event > ACPI_EVENT_MAX) {
--=20
2.14.1
