Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474862-5-16905429608247916530
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
    t=1521474862; b=RrfXGNUnyQwBKI35ap6UPQdiROODC0SThpgsd6RSMMfQ76f
    Rnmf4dYDAROZr7FPu/K65PoGaFhNTXr+5pvuynSix9zMQNP1ViR3UbtkjijS7X6y
    r3A2rf7qkooNtOomZGEeda28agRT4Cfx8UgIo+d1pizgFcG+Jfv8ifdpW8cpsIpE
    asJRsERvy6D91NIdHu8MHuOEWNHH9s0ztS0UE+gPz/YMoPZyD0i95KTcTDvlaMDr
    0P8BQRQx0lP1qXC13RbB498uraowvwXXFEjJVbnyXpqFs/t2X3vNgcqoZBrs5m+r
    wOhn1Ay6FNNY8KvXQ/99CbLnwqdshfoVmWT0WLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474862; bh=YsZdcu
    4v74aJzFKX7JbWxmWEgboy9P4e1Z++Fh/z3WA=; b=RKCZVDk0qxeu0+5C+AdJUQ
    IY0SLY9vUY5W0dIyb6vGpgDqR44ElEqPcDCUkK0jS2qw1bTrDVcfR77cIsd+6Bn5
    Faw3mcxA0wEK9ymvtjniHjI12NjnNAhLdKYddOJrUzqiov60rwpBoEYBpWc6tMBu
    WtGPcMcU2uwaUn7I2C0UX9I20Y+Q9katXcQYJiXct6zUKXBVtMfcI6GakbUFmdVd
    rt+DPzE4+DeT338xSjhK6OreCt5Gvj9tppu6I0D/wyd9Kq3u1B3eGAQZQurfHYue
    tBvEManVWPtzftMqN3cspr39Evk6CsyhnMbQk1bp0k5Moftd04b8nenCSv+Ti2hA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lm4QA3eA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhrvgguughithdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeftddtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lm4QA3eA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhrvgguughithdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeftddtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933771AbeCSPyS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:18 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:9280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934022AbeCSPuK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 113/124] Input: goodix - disable IRQs while
 suspended
Thread-Topic: [PATCH AUTOSEL for 4.15 113/124] Input: goodix - disable IRQs
 while suspended
Thread-Index: AQHTv5nQgGQB2+OzkkW33FTHeo3xWA==
Date: Mon, 19 Mar 2018 15:49:07 +0000
Message-ID: <20180319154645.11350-113-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:I3Jsgck6/btDG+YzpqqcIkJefaDGAV/5Bbp4AKPoHPib5CHtQwB+FNqjZ47JFAjnk/3izv/rxapJJ6sKI1tunxNavUsF/zcOkp2ENHQSKo8FjgbjvUUl5uNo/qtPrk0LBQeg31/DE3aJ4oPkeaFX8+lYGsIdR0VR/xWhgrF/OfmMKWnvfxp6Z5zPXUoqkBPbJmZ5lCwYG03AWGo6MWN4s7PBjO4+WtoP9yxuVhW/i/jFB36htfsWUQP3DbNPvKUL;20:FOjkbC0fjV73vFvIYak27ooZnekYE7eeLcZ+X1PgsCgjY4GelRW43Tt2xZpxWZfjGf1JtKBqzij1faPikD/ZNl8+HobtWAfwIT6QqLXbijhdhAbEOk2Pjh9s6UnrmLyLw+u9jdHMouQvSztmmDdiO5h7KFwaEzFbjdCbs/OVDcg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58aac93c-9df1-4722-4a86-08d58db11218
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11096D73AC78489FF1442E34FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(15650500001)(14454004)(966005)(76176011)(66066001)(6512007)(39060400002)(6306002)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xAskwIBWM6ratDislV7KfPOAQ+KZWU0kcwpddgrWQeWgXFnvD/vt6+BmEhOtuTLQN+A59GFklm+U3kUiEnxFoBp1sgTPI5PuMpCL9OfWDQQHhx2+ejV1iWrqUTu5qCmLekgt1IUZtpCMsWnoypgKai0Dj2X9YBg18ZVtomwWtwaaMWE7dOEBcThpFIBl1/1MNjt37wKXZ1WsDH3OwenKX++sxmmQlBLMXjsCaBaa5M/NQhTkw19PrqB5NwOidA1+4Pez/wzhkcdLAvrnJr9B61UNslzWxFMBOgDnlPH1GO/GpXv8g460AXk9TfsYqJteesLwVLi/eHIJQzdEvLBXMw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aac93c-9df1-4722-4a86-08d58db11218
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:07.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit faec44b6838312484d63e82286087cf2d5ebb891 ]

We should not try to do any i2c transfers before the controller is
resumed (which happens before our resume method gets called).

So we need to disable our IRQ while suspended to enforce this. The
code paths for devices with GPIOs for the int and reset pins already
disable the IRQ the through goodix_free_irq().

This commit also disables the IRQ while suspended for devices without
GPIOs for the int and reset pins.

This fixes the i2c bus sometimes getting stuck after a suspend/resume
causing the touchscreen to sometimes not work after a suspend/resume.
This has been tested on a GPD pocked device.

BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
BugLink: https://www.reddit.com/r/GPDPocket/comments/7niut2/fix_for_broken_=
touch_after_resume_all_linux/
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/goodix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen=
/goodix.c
index 69d0b8cbc71f..ecec8eb17f28 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -878,8 +878,10 @@ static int __maybe_unused goodix_suspend(struct device=
 *dev)
 	int error;
=20
 	/* We need gpio pins to suspend/resume */
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		disable_irq(client->irq);
 		return 0;
+	}
=20
 	wait_for_completion(&ts->firmware_loading_complete);
=20
@@ -919,8 +921,10 @@ static int __maybe_unused goodix_resume(struct device =
*dev)
 	struct goodix_ts_data *ts =3D i2c_get_clientdata(client);
 	int error;
=20
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		enable_irq(client->irq);
 		return 0;
+	}
=20
 	/*
 	 * Exit sleep mode by outputting HIGH level to INT pin
--=20
2.14.1
