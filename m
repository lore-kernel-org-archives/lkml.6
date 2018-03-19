Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475601-2-10334291268546529106
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
    t=1521475601; b=rHx57kpVQcjjEwIg/2ZHu656Wfx/ObTsR1vUJKi8s/gqInB
    mS0vCC3Ms2P8kyfpSDNV8F8TrD2Ccwl7rzpcNuB3zTolqFrd4H6At5RWcJ2hvYKu
    3LJ+sO/TJ9Ut07cTq8R4FW6sZQGfIPT00Emn5xEWMazrxQQhsHLRkO8PTVKGCv4V
    zyYMMQOH2A0lk+/0Qd9gbyhdaovBxZ+/5X1m/zSxCI+GR/DUAcIfAQYlq9/uwt7a
    lBR3RoGJOZ8YQ0/OnxK45kti/D/QrEwS2SuWF1/auZVntRAT09DZn/2jZb9yULX2
    t34A39fjTpmNrY6OU/F2cTMGaKCzHFlO9KSp3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475601; bh=dNtGF8
    QOe/awBusVxExa9QomMZ1gcEhGTDly8qM+Aec=; b=Pvq/7c6KrurhNoi2vICJq8
    MFgv73JFuPirZPj5UgLdSZd49oUXNDbQDhva/tthxCX0XC83OrZwOeFvZLAx0zdI
    yoIGq8ufmfKN6Vvf//SZ3JYlJa6w7+Bl4x7lZA2CkL1GQQDp5LaW9ie8v9/X/pTN
    ly3oy29M6YpWRPYTEtCusw8J5I8x9Nq3xyhskW4TBES6M/KOEaGU9fCMr5pDMbBR
    h3jfbFDdlOIhCqZA/fFGUq0wHrFS528WHqm/maoV8O5EPJAuYjDcj5J2MF+5rG6D
    0HRIgzUtFqpexM6Kfcu441e3G8hynvcewPt5xWJVkYLmMhtx2iLFsDBiX2X7xRTg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TqMA6ajf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekhedvnecuvehluhhsthgvrhfuihiivgepieej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TqMA6ajf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekhedvnecuvehluhhsthgvrhfuihiivgepieej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965953AbeCSQGi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:38 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:13968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965910AbeCSQGe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Lechner <david@lechnology.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 272/281] clk: fix reentrancy of clk_enable()
 on UP systems
Thread-Topic: [PATCH AUTOSEL for 4.9 272/281] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Index: AQHTv5vLDiFOXcFh5UOB0DjwHhEMQA==
Date: Mon, 19 Mar 2018 16:03:17 +0000
Message-ID: <20180319155742.13731-272-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:IKle4z4uGBT/1F0piAOTi/6400thTFj/X1I3zY+Yq+G7j8xtKsA7M/aTM9vj5IgMK5KoyQZdUlp2DoqMq0wGMZJCM0LzdCRm5ambZ3PjXym9BtVx87GRqL4UWRCPieASKlzvy6VWZ1skOlDoiXGMwq5XUYVOpouvlTWfraVibjJwonH/U6hhmanGH/K7JUU8MYa8Hgi9LvKxXJNWXswJA3NlNs76eUM8chfGDA7VyFnyW+bHwcUEfctnEhpOMNIl;20:81d1993AwgeHvMbcVTbGNGKCYBomsJGrnMToqMv0MnRJQNZw8MIR6LZCjgXjgxlHa4QM+yWQn968YeCZchDr6lIc6FcttGDXa6DgSkO/tg5xbFe8jREnjUYmpJJRn9iZoFy0WCjHRokS5g0Qjj0Nv7MLfaHITUqMQWBh6G7MCfs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2f3f9ef-a35e-48f1-738c-08d58db36247
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728E7A1E385CA0CAC786958FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(575784001)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NpW+P93MVrk0ijvE1MoUJQfHPaJcxTLnnzF+WfciAoIr7KenCigL98BLhCIjKfPTgkDhjc2JA5bNndXSrpUX4ttwcMyLxq7ARvfQ6Ntc51hcBtDkkN2X/JlTbkc611jQjulLmeVZdhiOHfj6lvMMknLFNuIT4TiFQDDyxrTme6aTQFyaKt5cBR5ah9qQ4tLwmeBotcNAFGKulUFQwWHLRnKgIYe6T9lcSaMtH6P1EeiNATh46LNAImiXqW3ZEkDw0i6l1+dNBrX620h/kq2RR3zNaBTbSl4VvnQCViJ8yoDmyuJgxhsnRMx7jfKgO6Y7j68NAKmacDsgUOmeHySRxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f3f9ef-a35e-48f1-738c-08d58db36247
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:17.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index 0fb39fe217d1..33565a434527 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -119,10 +119,18 @@ static unsigned long clk_enable_lock(void)
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
