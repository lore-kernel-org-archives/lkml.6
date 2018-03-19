Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497793-2-1629646396767117642
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
    t=1521497793; b=ssjUHSUJj1FzSohNmlNJ1MjZkXeanWiVnH4vSNLdjaGBbs2
    WmMiK5zB3YS0Cz6QPmpNHXWsjN9UUHDDV8AcYM0HYnlIngEP1bcUyS5Gh/YzeVmq
    c9WweyxjxD4Wi/wIzC7+g3pj2lh6PxKaTsvgwBVEGaq+HHx8mfAD18FIBbZmnqq2
    LhRkcO1cLbMVsohP2PBCtYoDqzN38n+8YypFd820vqouhcSjJhd69+vOR6VimbRT
    D3uchMHcxsubwQUErsOf3CY1B3KRLODZNF03le3hr2pYWTJW/IFaoKdd86xjriYw
    cyCwmAN99ftY4NLhr6vu/xzqvuJ9gXp7YzAmHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497793; bh=iuckPA
    tG4mPbMTp5dXpRcO8Xjpvsfhrrpb/wLYhCMwI=; b=dPaX9qXskUmDiKkk3y80Az
    k4PMhm/HnEJbHWiCwry6xfuWZaJAHxJ7Y2xUhxBFy0nyGlsB/r2asPOFjsCLyBDU
    BOf6dwjGrjV+kL0jKmc6naNfhP+JO3gCupFI2ktg9Oet3Xb64TCr6p5X1tR8ZIX1
    vDGORU0UZ35svie7OKkWSyHZitZ7gXs372n++NDU7ViQSih9+WoDsNQ+U4Xkd4ud
    QbBS7SPP8k0RuQViHjnSd+e/ZU956PQS9jcALqB7u7rVLSc4xRuXMLQAR/L2hSbu
    f3bdst97fovCGOrqa50Ic6iOFMTV/6Xvge+CDU52jheoLf9pUwki6B3+4sToncmQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vy+t4KUn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeehfeenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vy+t4KUn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeehfeenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936314AbeCSWQ3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:16:29 -0400
Received: from mail-bl2nam02on0123.outbound.protection.outlook.com ([104.47.38.123]:41056
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934012AbeCSPtv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Lechner <david@lechnology.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 104/124] clk: fix reentrancy of clk_enable()
 on UP systems
Thread-Topic: [PATCH AUTOSEL for 4.15 104/124] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Index: AQHTv5nJGUwlmQMprEeYWg0XJMUefw==
Date: Mon, 19 Mar 2018 15:48:56 +0000
Message-ID: <20180319154645.11350-104-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:o0oNp7mTAll79hwjwc/jRdz03JseUw29rVRIpCFol0C1By0KowcyXHWs1SHM/xi8f69+bJdZT3NfDgWPvBAs+x8OcV7BgFA36aw7nSV+NxityhoBr4uvUc2z4wej/3kr1gKgv1FAMcbaMH+/DaM4JFSCyj4nzvcpoQ8Vb+QViwF0ZBBwzzP5MKR6fOU7zyUHJsNDHf8WOXiiHo7y70/2v+dgg09YmjnEjkV9zedIhdvBZ1SiyFrborcYTh7EGnTB;20:P8RFMW19FWQeOB1hTqzdyNDahymC/uW+tcPmsQx33lUOvD60Mq147r5BRPMkIuqWbhL6Wl6/M1SenHfmybuQqazaLTj3zqXdGreqtZZIBQhMg5EavAXiL6QZ8V4EQ0TpNd8h8ZfnCRLVTAuCjsxT/qEKVgB/OaUsy6FGIrCoLvg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37c56910-e4c4-4f3e-a822-08d58db108e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110929BE80523D17A5F77953FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: IepFU700ldisaeb5engKyK1oSHK4sxIBaZj4nWbARf5sM02v2oJZSnfVf9aY+fujmscZkqFzMZvFCJuWP8jQ8M5wotYfph/CcrB3/Ws8c5SBhD0neRF4j1RiKhcahWs/pVoqrK+x0J+Vsjpm0Bn83KPFbBCxHjgNhrmAyTIHl70v3T+UkWPvi503fZ1fpqoE3zxDSEyrMGxcnVg4WdKfaSYGXZyp3wEY0RB4DJ+RFrI6o5pLdKt/6awZhXoOL3+LjJbKwi6jv0eJbyR1dxRro8aBgKnIC6krLyRIu68hbqM8pKnCXkUbzBzWY94hsK7fs0oHbTBPsMMFkFu9T6NFRA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c56910-e4c4-4f3e-a822-08d58db108e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:56.2991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Lechner <david@lechnology.com>

[ Upstream commit a12aa8a68dfef5de181f2e555aa950a0ab05411f ]

Reentrant calls to clk_enable() are not working on UP systems. This is
caused by the fact spin_trylock_irqsave() always returns true when
CONFIG_SMP=3Dn (and CONFIG_DEBUG_SPINLOCK=3Dn) which causes the reference
counting to not work correctly when clk_enable_lock() is called twice
before clk_enable_unlock() is called (this happens when clk_enable()
is called from within another clk_enable()).

This fixes the problem by skipping the call to spin_trylock_irqsave() on UP
systems and relying solely on reference counting. We also make sure to set
flags in this case so that we are not returning an uninitialized value.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b56c11f51baf..a6575359de58 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -141,10 +141,18 @@ static unsigned long clk_enable_lock(void)
 {
 	unsigned long flags;
=20
-	if (!spin_trylock_irqsave(&enable_lock, flags)) {
+	/*
+	 * On UP systems, spin_trylock_irqsave() always returns true, even if
+	 * we already hold the lock. So, in that case, we rely only on
+	 * reference counting.
+	 */
+	if (!IS_ENABLED(CONFIG_SMP) ||
+	    !spin_trylock_irqsave(&enable_lock, flags)) {
 		if (enable_owner =3D=3D current) {
 			enable_refcnt++;
 			__acquire(enable_lock);
+			if (!IS_ENABLED(CONFIG_SMP))
+				local_save_flags(flags);
 			return flags;
 		}
 		spin_lock_irqsave(&enable_lock, flags);
--=20
2.14.1
