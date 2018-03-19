Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478589-2-5276898607255001341
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
    t=1521478588; b=PtqSn1h6PAEisYtfVRZf4EtNK4s97sDAvSxGhB8YI10W9gV
    q7dWD7l1IQ0UtvsW7QmmtgOw46IOhWug6aIOnpNOawxuqhgJhjvneNQQk+J4z2PL
    XPsIRA0K7X7VOZUcrZS3+iz81P7SOwpcMpxjPfaNO3uvNqi39UfV4Zef6iRVR9P8
    iQHubd+DZpvdTQspyhs31ibGOddTKmDtbUvpaZoguLDGfMpRCm3vKHhEHqCUpjPP
    dRBjnZJZ/71qpMgh2EippaGfxdylMJVtkGFZLlf22ZE0+Cmk5v/P1+IUQMaFf4Qm
    UNeNG9CToFLA/X5y7Y+PcmFFrWuBvsPbg69BjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478588; bh=jSIvbt
    /0CJH+EQL3JckLhcV3xRF3RUDafsi/M7UhFQ4=; b=d9vsg8GKIZmnNxqiNwFahD
    sWDHdySENvCcJkn7KLjZlqhEuOq40U2+TZniP3tsU7BdmlP9Ytyy2XGrwcAXqgy7
    ZOoK15g9LPWsuZSmrpGPltOZziqHBY+jN6h8V3qJ9iKfsxH7PQy1UCnh4qoC6i41
    F7lZEtU0f/UL9RItBkV837k/ds5z5EeiVxYTSWe/Q/1Ag/VxIlUc+CU51WahcFfr
    SfzRau/tw3ckvyC2J4WL2z/VaQxxXgIgNMiZdcV7mDnPUL6aepQ9b17iLVJWFj1F
    HEPPJthHBfgt8cImrgMgE6e4+ldflf01wfr9tkfgfOs0/r6EAChhFIyMRHHk0PBw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dbAYWAUq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekhedunecuvehluhhsthgvrhfuihiivgepvddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dbAYWAUq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekhedunecuvehluhhsthgvrhfuihiivgepvddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967628AbeCSQ4Y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:56:24 -0400
Received: from mail-dm3nam03on0111.outbound.protection.outlook.com ([104.47.41.111]:6417
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966752AbeCSQL3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Lechner <david@lechnology.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 163/167] clk: fix reentrancy of clk_enable()
 on UP systems
Thread-Topic: [PATCH AUTOSEL for 4.4 163/167] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Index: AQHTv5yQ+Ey0MovVY0+Ieju5xrvkPA==
Date: Mon, 19 Mar 2018 16:08:47 +0000
Message-ID: <20180319160513.16384-163-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:qq2Nz3rTqWrv+3hDRWW8R2b3T9ItSy/xDKPiV3gX4qWm45K7Tsd+wqSIqEcPArVpOEN5mjDsLGHwROrf8DyfhedcndjRSwQ7lSAMzyyBK2/rAAcQyQeAQsFFew++lxFkyNeA6IPH649rwhN+jWuXFC1nXdTIYG24Ien0xsIIBUa2r5QBCERPuv0LBHXuC1a4mm2NKgynU1a6EcRzGqacIMmkjzi0V41jj5L4pN9mll330ac+sCmfRy8yj49SFuOL;20:pXpzvl43ZwgLESvkrjHy7Il0a96VCTe3PJOcDOQwmHqMb0B5Z4NNdFrBmWwuuXkG5riVEskOcugC1rF/YUeoasI09SPED3qI4ggHzB5QG+xw1XyNXyyNg1q6fmYNxFeLgPxCwv9udWllMibnUxJPKZp95MEp7cLLArTIGYtiX8U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6ba3f88-11dd-41b2-a240-08d58db411ae
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08055987CA6359706C453C17FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gPQr7R4JS00GmLQC5JzL06hyMJSncNpnuhq2eUmrTaOuuTHO2VwfLJadDEIvAfolG/JNM34UDu1KCfGm7yTsuCJKdAzKLoQ4v1uaDyNYStP+xcDdVilvgbfnUOc0WVAUGr8raOjFqfZPUHWyEJAIOVqjbLlp9BQTffguh+SstFTX1qMThuRk1YyhoIXTBwGPetUq7fInBOSWGiWqNPuYHrD2S2IoNJtYkSZltH/jjJwCT5By+nKyrbFgB2X6Pw+jQsslbERpjOGHlo5kmb6vsTpFMti7RiXdaVrsOEbXc+2dVLumdT6zGvicNc9Jy6ul5sDj3M4BetsgMqwk76ZV/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ba3f88-11dd-41b2-a240-08d58db411ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:47.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index f13c3f4228d4..a20538c4c2fa 100644
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
