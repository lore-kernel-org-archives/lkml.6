Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498414-2-14447841031740756226
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
    t=1521498413; b=PREu127WwTGYn3pEm3f5AA1EIY86FKdFwEhJ2qpPVWOgU6A
    akczweTLfiderPIqjB4BlXgH37XgnauObRk4hK4S05ccBECul7DLHs/D3ihrEXsL
    p+UhBV+MT243ViLlVxEswr3BZt1jOnD4auEOIgykMUBQZdHbcOxi9NkX1m4UYiQ3
    DTAI4TG6SQdqlhc8Axqvc4iCIocjYcxN6MOgHBDbmrc9kPWl1pjvdpV2OV28dFC6
    SzXPgvauZqCmY3g+JtHYszq9OWLZEaL4amhHSHEO/sDFkGmzwLOEaKFLL1fY+xZY
    WyLiyvxHy/ihKLGtMLZAX7cB01lMx3pO14wtgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498413; bh=OZO8Pi
    iDvdp6oOzLr7v9IlskbPeD/7ohlfR5pEJgFuE=; b=nf2UNkzkel26RjxyZ1CYa/
    MhA/3BIMK1eBE4OtpHm8atBuoeyepLhL4Tvk0PqBltMLRcPSs8ONE+RJuU1eM53b
    bY5Hg2HwUYBCAH1KhHfCsmtvLt5rWs4pnq6wL7/gSA25/My26J15U3s9HBaT1Orh
    XnElrNhOFB+rhpKLON7PorbarVFWzj9Ksuk2HpPfHC10Q+ZaIGMH1Whihx+sDiVv
    lVEuEyu9IFx5iWdvqikc4iSzSCmJFY9S1bAaF5SRR/WfFJMHjAKd7Jcqs9o82Qct
    AOHOOCbIn3FEuQ21ILLFHE5A6pOmgH9vtQHx97hmpooNuN5SUlN6dAenaAVtYKZQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kd55tXgB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektddtvdenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kd55tXgB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektddtvdenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936462AbeCSW0T (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:26:19 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:18692
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933867AbeCSPtA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 071/124] power: supply: axp288_charger:
 Properly stop work on probe-error / remove
Thread-Topic: [PATCH AUTOSEL for 4.15 071/124] power: supply: axp288_charger:
 Properly stop work on probe-error / remove
Thread-Index: AQHTv5myF9LuyZCvC0eNEzOr+Q2Okg==
Date: Mon, 19 Mar 2018 15:48:17 +0000
Message-ID: <20180319154645.11350-71-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:Im76bKsbpqNjUSIXLjOiPARBidbGfr/vsWcK8tRuWBZRf84ckOD9WeMoY0CFzw3SH+vpO15uoQcRqTprjhwOS20L8h4VHrrjvzazIpZ/oOP+AVkTlVC1TyLI8qS0zgsFH1s0wr5+vTTfyA83AXo+7dXwBZ2+pttrrKhkq9Zkb+nAlEk1HNCkrDz7lULWOqFBi5EvwVJLfiXuWTkKcHg2vrp83VcUp1wE6Tept9IZzk4fP0CMh0otXxtFGoVxG/x3;20:NHv0925hrw060yTqBK4MJcoBOXouYbCxAB3+KZKQVsKYQTcgG5Qy7dzQhZH5XyXLAAOtWSQ71ka5tb8H/SMhXOdvE7X3E/t7c7yR9pSlfptQFyzCl73hSH6QbEceC2Gy8TleG+gTcYZcPI4h3t9OZ+i8OTCgRMkJ+uTNdiTquHw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2471d2f-43f0-4a92-4c6d-08d58db0eb9a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919A08BF6AAE29B3FA06863FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MoYCHiJwkkwCj94bIO8qDIfmrbsXIwvo5/1tMeeKuK38CyytoFIGSd1DWBosxVJn6XpsKZ+XWHOVq2oQhTRnjAQqugoGUe2icSUNAQJNEbx5fHazfQIOu826toEjI63EdjiVQMXy1db8iSFVhaiyn3BzjcjxSmW6DyhX1sdKblmWX4edaJR4XFIgIwZgoYDI5dl9/VWJ15lV1gnkvhJfvAWuEl+Zbi2LrQztpRtHU2Vmo+HpSuWc5xK8PmE3MKIO+Wcc8+xFXXygglDtqRpJGAgDv6gCzIakfW5ZxiPMQdz/vne3xfMzA5U+0pne7sqq2aru3Dm2KDRaoTRrNVS5xA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2471d2f-43f0-4a92-4c6d-08d58db0eb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:17.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
