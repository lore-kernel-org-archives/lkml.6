Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499181-2-14061612514854109627
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499181; b=rjYidjj2Cvymc8XFFb96M/Zl2WQcL00rZUuAXJUjaI/1LdJ
    zEu2s+0cv1MmOhQJhFmIQQaCaMEDcq4E2QlG3myt1wjJChJA/HWfo7flFTDBnN52
    F4rNUws23WXaH7zgXUV4VnlLWpHoUJQjrGK8w0+8EuhQ5wnKGp9oQ+jgByDskQTu
    KbAziPvNbSk7RiqHityObeOBnt0w1wogEJEBNwV3JDg9q8Tf5vnPwIIUHTwF7PHh
    1gmhtow3sdUrZGnnZP3EbdmmuwubdCVHi7yxbB7gh5cWerh/cbQMSH8DBPs+Di+F
    CqHN4iCY4hjGWB5BGPxpCxNPjhy+fFvSG/PHRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499181; bh=KVK29h
    GQz1CaHqvvZkhvXfP/bHzpA29DxqsZPA6gX7I=; b=AlGGDp1Vrkdxn9cG5gUdqs
    wiUWF/pVAfVn10Ihn7v6YZs4aqH+4bp6iICo7ytStoahHys6a6NTgpaKj6UPVkew
    iYBVi6uvaBpeMttIQfrZIm1DzOZWARU98hhqP06cwOlkzS0XCI5J6UzYXRMm4Okh
    m/EHaI1Ym4fgutZ+v3WQTk3dHA27Zbuvh0Cq3m6shteRqiZiVEQugWcRYMwv4O7Y
    d6VKr3eQOusqX97PKFiN9fvt9EEsPqeqYXIrBWz0AnAbwx93WxXILxnkvS+ChrDJ
    pvy0PvslGPKb866YY03bFJZ6r5SY+Xr6UTX/UlVDwrmQGJAIGofwxxpZHvO+gt6w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f3dAaILQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedvgeenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f3dAaILQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedvgeenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933400AbeCSWjJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:39:09 -0400
Received: from mail-cys01nam02hn0235.outbound.protection.outlook.com ([104.47.37.235]:46756
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933337AbeCSPr3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 022/124] watchdog: dw_wdt: add stop watchdog
 operation
Thread-Topic: [PATCH AUTOSEL for 4.15 022/124] watchdog: dw_wdt: add stop
 watchdog operation
Thread-Index: AQHTv5mRREBGWvHljUuaOhCGg0jODA==
Date: Mon, 19 Mar 2018 15:47:21 +0000
Message-ID: <20180319154645.11350-22-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:WvMiVzMSQuPv8yjcHfmsWFbTC7tzdX+QFTGYaED37e8ZRoyTdSl6yBLu7JOyIzbEMcLO0DeSaI5hWUzKVuLbDrbtj+UvZMOO2TF/QgmDc1sWj1BRHgcz8kq5wDdiSqcwF2Gs6lufhGsaj0OrOwD47eRnHfYQzgIng22KOtKMyjuGHvG0Tbl6MVQ2UXRYzt6uKTKUzaZVp0PFimFUu49IHFqWUfWv9J53nrw34voa51ozYiXD+lxYe7vCPQrQmDVv;20:2m37fYD2wsy0VVOFd8W8laHnxpcim9SJgYKFIa0VeEyjwUFAGRcAQIKC9KQzVmQGLeN5oNPeQRYW1L2+oyWpAvaW5NC9GIiAiXw3Pr0KjMwYHIRF+JZgsaArKa3UsNVN44c8jpB2Ym3KokoWAGB9PKs9E7v8u/17zn5P9nyJyc0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d345291c-9375-49ec-25c9-08d58db0b735
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099813D716DEC088092D6208FBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(207123002);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 02veuY/4zm6sa7ZA8I0GA9/Sz6PTaA7L7+JpszbWZdZ6PhJp7I70lel9UugPjBT5PyohpVStsPqgXOf7YcUpBkr3/FkfX06ZpRORBPkPdp24dAG0wn+N3m9dW2B4Wcjzvg9X8dSvVKKtzgVY3QpK6J0kB9fUz6lgs83TUPZbU5YNdkCp6SCLeoUPiEdyQhzL37voCGr50bVFKOjz5s8QETsQWhS4qqViK06LCDDE7vya/1/Zfp0EoU+ZiFZk+4s5U6YD8wgHNScefazrlonZzTJpYtgSRByzE+qJ0Q2VE/Ah6hxzq4AjweT4rVQMm5tCMWREYYHvqU2WzglYmsfrRmT+od4v1RGwV7b19C0qVSIfiduDtlzFRl6lqqfXDfuvKr1vl7T55v9UOgzsaD00bHifdEaW4O8QAMuVKkRLkEKIoBKEwGB2/ilkPpqhhD7DuJZaFaBEVlUR3n7Z7YjcDBHUZEl+xfaHEDdM2djMrUGHpYf9S7WnfEjF6v0XhEZr
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d345291c-9375-49ec-25c9-08d58db0b735
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:21.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 1bfe8889380890efe4943d125124f5a7b48571b0 ]

The only way of stopping the watchdog is by resetting it.
Add the watchdog op for stopping the device and reset if
a reset line is provided.

At same time WDOG_HW_RUNNING should be remove from dw_wdt_start.
As commented by Guenter Roeck:
dw_wdt sets WDOG_HW_RUNNING in its open function. Result is
that the kref_get() in watchdog_open() won't be executed. But then
kref_put() in close will be called since the watchdog now does stop.
This causes the imbalance.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/watchdog/dw_wdt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 36be987ff9ef..c2f4ff516230 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -127,14 +127,27 @@ static int dw_wdt_start(struct watchdog_device *wdd)
=20
 	dw_wdt_set_timeout(wdd, wdd->timeout);
=20
-	set_bit(WDOG_HW_RUNNING, &wdd->status);
-
 	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
 	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
=20
 	return 0;
 }
=20
+static int dw_wdt_stop(struct watchdog_device *wdd)
+{
+	struct dw_wdt *dw_wdt =3D to_dw_wdt(wdd);
+
+	if (!dw_wdt->rst) {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+		return 0;
+	}
+
+	reset_control_assert(dw_wdt->rst);
+	reset_control_deassert(dw_wdt->rst);
+
+	return 0;
+}
+
 static int dw_wdt_restart(struct watchdog_device *wdd,
 			  unsigned long action, void *data)
 {
@@ -173,6 +186,7 @@ static const struct watchdog_info dw_wdt_ident =3D {
 static const struct watchdog_ops dw_wdt_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.start		=3D dw_wdt_start,
+	.stop		=3D dw_wdt_stop,
 	.ping		=3D dw_wdt_ping,
 	.set_timeout	=3D dw_wdt_set_timeout,
 	.get_timeleft	=3D dw_wdt_get_timeleft,
--=20
2.14.1
