Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497354-2-16123258828243965040
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
    t=1521497353; b=YBcErKVbYKXB5KPefBkJQzPweCLySKUEmN2b9ITJBziKg2Q
    e+CTSeLCC0suqhygrJzD4EJrbLUvj3st28+RfrlPiYAhX9W5ai+vLtzMCqDHcqPn
    cNGFjJffsTorj2L2ZLTKb6fXEpfL1qfV+bABgGFzwkArOSz4dbrTXxJcFqWzQyHj
    7fTx+aCbnvzYzotbLvYiKG8ZLQYQVu8qvA3hoEJ09ZeGDt8bwUwKpIpiQ3xxW8Va
    +c3otju609bzzgL+sOCl5JePInCGnNcipaDXUlMP2eNlwKsh5XZxYJYQo2Lp62Mb
    8toQoQ8+X0WBBtNQMir+Sx78TRWOzPrBGQDQSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497353; bh=KVK29h
    GQz1CaHqvvZkhvXfP/bHzpA29DxqsZPA6gX7I=; b=ndHMnIKnD6Lwl7KaxJPyIJ
    vWw9I+qqWcvpVLnPUGupSFzWSk39Adr//bW5hPlbKjsl/3QIzWd6OQSCAvinmf2o
    UO5BloEjk0xHgNWpGzw12emr3EeyrVpJwOU8oldMI/Gru0CAXq/RvJ8CIvwz/Jw4
    UgctTZqfG09DSa07czOB4xK/dx2BYl/W6NYOzRcN0aEcQ46gm3Playh//7u3JFvP
    UQ0XW2PEomfIcM0ZlBgf7flr6y1mAeDLq4a640u4vw3dEBQfV5BQyYNvlzb9u8hS
    lu9ExMeCfoNoHR+DVwvDlSCj99uZ0BxkN4l/7SZq/GweUk7l82uOQfK9/SvwdWcA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hQd/en3o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtieenucevlhhushhtvghrufhiiigvpeekke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hQd/en3o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtieenucevlhhushhtvghrufhiiigvpeekke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934324AbeCSWJI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:09:08 -0400
Received: from mail-cys01nam02hn0244.outbound.protection.outlook.com ([104.47.37.244]:40168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934154AbeCSPyw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 19/97] watchdog: dw_wdt: add stop watchdog
 operation
Thread-Topic: [PATCH AUTOSEL for 4.14 19/97] watchdog: dw_wdt: add stop
 watchdog operation
Thread-Index: AQHTv5qbfUCycLwYqEiNd0yDZZe70g==
Date: Mon, 19 Mar 2018 15:54:48 +0000
Message-ID: <20180319155411.12348-19-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:kcHiAMUMPZzuV5IUd5EEvsV2T4NvjctzPUG6CR/bR9CSlRRjKzcXEVoi3ZlCZdVKSTu2ObICyltA+QwUQleAMRFYxIQcIREAfMbFnUVVf0TqDXC1N+GwpvbZCYB0uSxMVu51/FfKJ8v+mvwu/kqkgZK6ZqbZP71TZb2E1rp9IpvbUhWix7+76DKFDjydYFU53ae2lnw8YJ4N/jQabrFjqoQLQq43LKPxw9d3QBQnIT5DfQgSOzzleZhLI8i/e/Bl;20:raplxfcMDAM6FEkdpUaqk4b99j9Oh9xD7KiZP5rl+g8DNODyN/JVq/KhZF2IWZNtltcHjd6htJSdmKyuMVFWXKAT/DjejHGBLclOvnVrAsuGBTsMMwSBydDdp+U6XH0ehdQLFpFlhKKX4OJ/xtBPKI8e6n/F90gIeWrbfPIuhVo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e59c13e-9f15-462a-b032-08d58db1be95
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806EE32E0F973F022A1A0EAFBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(207123002);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sMH7ezJoS+IVH8Ru1/BkYdG2BR8jm27Aa5+iRLy1qhK3bdR9Q1etJ2g0FoHu0ZG8vIu+ytZQvICQ05pwU9TE5HmHlApY03Gxym9nUsbm2pu6pYuk4iBdzwn0MoXFAeblIe1gHphyURf6qAEn1Y/6w9dnBxr+LcGkr/L9TtvYB6aYiRw3Z+Yqy9gRpwuxDZJrn/jg3TPXyKvlW2zet0RT5GWPD7nXk/qSByMT+TWebO2EII1546zaIrk1SX4EyrVSWoKxQ1b9ov+uCHIkir7KqvnO4F7W6U7sJdRKDgUlUxV4gDlkS1XGRLfVoMuzN1qV07jLt1IwlTicyMQbL1lTGRN7mS4KbXkXbXTNiTPlCjsiKUcWbAYsSFvLOlWfNQAl0pE/zH/+SX6y8581O7QeBY7MXhgVhUnhliZMOzNAFtq+fkXrBm8S1B72q3GjOjlgz0V6OT0b8Jo817u7DSeDfdhNeLvcm5hr5WYO43UejpOu53mzGanXCybf9V838ZZM
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e59c13e-9f15-462a-b032-08d58db1be95
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:48.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
