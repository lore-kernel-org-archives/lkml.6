Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496957-2-3769752314591092562
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
    t=1521496956; b=JGrtZJ5j6m3cEmwTvJWPOOdcC2L8G2jH7MHNef0xIcZsC7O
    +KFxttkaTkzhMMUWxkrabZzyH5CwVJCPdJmjHy05i/wch/kUAIA+2EPYwYXwS/Bt
    pctHDTDjLvE+UD9AQ0rdh1O2MIrHR6Lxil4ei0fgPC8D9nWX6OPhmRqNDub+crNS
    /Gk73hmbEdsW3H4AGqwDDrTyjJ7+wvAmn3nl7oVZLkRRl0G/9d8i7jhcR1LjvC1z
    uK0r/RGMrEinFigDt6EpXX4Y9LqnquyIg+VHtkkpzQDe/dJ5QJldtdF1dcsPXguw
    qsrXnaMbCxK20hnx4SjqB7fp6Cgz4B5IEg2mTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496956; bh=OZO8Pi
    iDvdp6oOzLr7v9IlskbPeD/7ohlfR5pEJgFuE=; b=Qf/T4wkI0qRfUPPQ0wYN5A
    GJDDVONJYwIXwAq4r0wts97iSreuTqVa3W1fNaKb2YWogIedvLPnhTebqFGWiLYV
    peOL8SSIbGFsRDHr6yHAbGRJaDdhh3e48X6pgRD+2rocjYr5o5RrVJKCEl4QyJtd
    NaqDl7do5FyttqXIJO+traMyOF7N6OmMWJyeXuyJ9f06rDVrflKEimrHgX6u3Ixc
    bAGW9CNKbgWBqEGntjiLYs+1/aFZO/J1beXh9YQBf/fHFEvII4RmDtC1SIw6NGb2
    ZmEsNw+lD21n3oCL9MbfiZIBOM+XHQmCOl3Dx0vUgr7GEGxdIhrrvEKZ5vR3lGxA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IMTHuJ9S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleelheenucevlhhushhtvghrufhiiigvpeefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IMTHuJ9S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleelheenucevlhhushhtvghrufhiiigvpeefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933924AbeCSWBp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:01:45 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934438AbeCSPz6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 55/97] power: supply: axp288_charger:
 Properly stop work on probe-error / remove
Thread-Topic: [PATCH AUTOSEL for 4.14 55/97] power: supply: axp288_charger:
 Properly stop work on probe-error / remove
Thread-Index: AQHTv5q76LZ2E3jBHkuGMXNL9QG3Pg==
Date: Mon, 19 Mar 2018 15:55:42 +0000
Message-ID: <20180319155411.12348-55-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:dRuNXlRhcmAlZjjY0UPs7zBh+U5nDHQX9qFqyut9Lb0vqGiSOln4Do98BCqO4WnemZs39m+5+88HbLfEACua8k+MeN+MiCpINmBkWw43ouAL/FeXrRk60cVnjUCrHnvPw4KVTqqpPhD6s2VH4x7tqk0HtY0GZDUVe2RloSdckRA6sOx7f9fn+VKUCVSuck4gONTcvY/0aLt6/WXDmkXamHzkCvOlHMZKxrzbgkrYAqp6S0bjmP1ZRBv7WoEaBjYY;20:IP+xKF9LNhtey7qdStXUureRz8k7u7G5o5enDrUU/Uyn/1Ctnx6GITgmlhtXHslTm83XGvA96lC7ARAme0yy5DMGTFrwMK4uUjKdBMPYdgHAzGoHLUX79NEIeUZiFKB80djrCLQZ3dJ8TuDI8L+D4EDhj5haYckay++bqw3EBtg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7777261-8cce-4d25-5693-08d58db1e71b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807B996709A8E3659FA0310FBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(305945005)(6666003)(68736007)(186003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(59450400001)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /KQfrd+FlXyCJL8fDmqaAFf5TDY0dI/ERfo9cDc9agI6/+lUz0/yZqg7ncI23yi0u7Ytdo//6f75NYwizCiiBvlNh9i5xUBdbAvk4vOx+EDlWI3gyd/rwbSBXenaKzySpC3IZi9of/0XZhhtOSaq7pwFobSQkzs+6eO31u1SOq55lqT7HLuC75KDmVXDLHgWkUG8+YPYYsmZjicuKvBXUsQQVFBT9+5UmJ6WovhoqUREt/nh9BefgH4wgqfJwHYxPJAkkrXiwpaFYPVwmBuBSurZ89Fv4eq5w0Ykd6LsK/VM7l7Y4j7iPv6HeWZeig4ekzUZ4ORVQm5EhNwLfBiNFw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7777261-8cce-4d25-5693-08d58db1e71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:42.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 165c2357744e41391902a2a72dd170beb60c28d5 ]

Properly stop any work we may have queued on probe-errors / remove.

Rather then adding a remove driver callback for this, and goto style
error handling to probe, use a devm_action for this.

The devm_action gets registered before we register any of the extcon
notifiers which may queue the work, devm does cleanup in reverse order,
so this ensures that the notifiers are removed before we cancel the work.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/axp288_charger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/a=
xp288_charger.c
index d51ebd1da65e..9dc7590e07cb 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -785,6 +785,14 @@ static int charger_init_hw_regs(struct axp288_chrg_inf=
o *info)
 	return 0;
 }
=20
+static void axp288_charger_cancel_work(void *data)
+{
+	struct axp288_chrg_info *info =3D data;
+
+	cancel_work_sync(&info->otg.work);
+	cancel_work_sync(&info->cable.work);
+}
+
 static int axp288_charger_probe(struct platform_device *pdev)
 {
 	int ret, i, pirq;
@@ -836,6 +844,11 @@ static int axp288_charger_probe(struct platform_device=
 *pdev)
 		return ret;
 	}
=20
+	/* Cancel our work on cleanup, register this before the notifiers */
+	ret =3D devm_add_action(dev, axp288_charger_cancel_work, info);
+	if (ret)
+		return ret;
+
 	/* Register for extcon notification */
 	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
 	info->cable.nb[0].notifier_call =3D axp288_charger_handle_cable0_evt;
--=20
2.14.1
