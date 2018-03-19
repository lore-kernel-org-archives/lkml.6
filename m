Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478103-2-15737278924288315601
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
    t=1521478102; b=K+6QnFraw/964AdehJ0Wgfta8msZdZRNC78oRifMvGUpcyI
    gSqQ12ujlXd31S464aDSQ198Kd9f+NRLrCxJeJ3TpsztfxyCR5djbiuLS6J/VH8P
    bQr2GBLCv2ZcUZkajadtJlaI9yB8KY1NueLk7W50iH3HYFZprBTXy+dWoTfRjn4c
    pw8mU/8HMVHqEdkFd0BRsoGfraBeZxUy9TxysY1PYhzJsqmwv+t/1shrsdYZT3Y8
    D8oTzPquJRbYv0OTCyNTubiSYHGn08HxhVj/oIfRPt9jrNXPQ+sxJ9K6JOsldg8/
    q8mofg0pWqfXK3UfqBPZMnCOCwDh1o8KP4zIveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478102; bh=ZxWUmZ
    QBkT4H9lBWkK/YVkfhSIQlqdWOUByYDeyktT0=; b=uJAUMeqRKksMraqIoN4y9W
    hMjtWS3V0RNKDekZZY7v3vBPlgrJ/VnPjZBDyXAyxfQ7uZxpett8GpudLEDdbzkp
    RODxMpmOp48POv9P7B4H37XFJfl2Jm/d8TnR9lMLk1fB9TzZ7EIsKbJy2/X14lwg
    H4AdyQ95DLRhVB83Eo6UOgfeEQmmRNds7ZjLgszaIiEvxZCq36B4N3KndJLTMiEQ
    pCDAaRedZuYFe6Llig2BEKxSI1BFDPXxs1XAsokk/WrqjnpOrmyG1cTgUjLio3b8
    c2Wp/9txMAdKiuXciMnGzKIUz1AaSVhHi01TO0dzImqbNhfspWHfZgggRqP70igg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iRWEhdAZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehuddtnecuvehluhhsthgvrhfuihiivgepudduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iRWEhdAZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehuddtnecuvehluhhsthgvrhfuihiivgepudduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964858AbeCSQsU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:48:20 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966781AbeCSQMF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 021/102] x86/tsc: Provide 'tsc=unstable' boot
 parameter
Thread-Topic: [PATCH AUTOSEL for 3.18 021/102] x86/tsc: Provide 'tsc=unstable'
 boot parameter
Thread-Index: AQHTv5z/DFG28PD7xEinW2HAUhCPwA==
Date: Mon, 19 Mar 2018 16:11:53 +0000
Message-ID: <20180319161117.17833-21-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:8EspRVLjE5Wx/V1UxNznEhJub08HmCnFKkLGrIZQtasSNPkA8b3fLi+7FcZRKvFc4Whu3kjf9KnVvYfpMfv9R26B+n5A7MmN9pDXOd4GMwChxmojtjyR/FRjQuIG6gaBXN/0RI1jXjWS7y+vQ2W4vLOuyv/DiPfAzG1oDYDotBQamt6gKvnF/bL5/t05wVFeD+rlGH91k73oESlCxPpTedppKiC0FshO0sprSA3BqR/0fNgciPlbLecJSXB5SUYI;20:MuNmsIq2ZVNUoLx02FEZp8twMMh0g+7Zg5MUmmu77aGH7+6YhPgOXIi16omFQ1sIm93v8vhtJKBl774qbZPFGkVTJYR5/8EBSyeM69yz9f1LaIsiCDT6zgf7siJvGDnL68dH4Ag3/AAmiiF+hcz9vM/AExZWjQYuCIgoZt2p+zY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c89a22eb-80d8-42c6-0e6d-08d58db4220f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920FAD22666B472E8F373F6FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(9452136761055)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(8666007)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Mt/UWklIisbCdn1oy/QLL9wWgbe36Z3q8b057X8OqJGzN7oHl3uHH9MgXIGqTe7n6fbtEA+UVp4jG5mO/cdynTfpgk+tghVYGJEHaiHJaT4Fw7meeX26NKuJ7Gyc3r85HjZtv0Oh5EAGaVQR4bnXWDz8a9aDXoVTNhnO3GO+WwQKn/ZcF6AgtMpdnILuen3ChltNu9nDNFV7ezywy9J/5ldVktMmqoj7xWI3wvzojSZV736Ej6crnG6Ek2gbaWyDVRKnR7+7eurHCyawuBbCeP8EjLdEElviROxcj9TdF4yqtK6r957TYdbbP3qrY0CIMS+Aym1aTXN2P3G2ngnLKg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89a22eb-80d8-42c6-0e6d-08d58db4220f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:53.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 8309f86cd41e8714526867177facf7a316d9be53 ]

Since the clocksource watchdog will only detect broken TSC after the
fact, all TSC based clocks will likely have observed non-continuous
values before/when switching away from TSC.

Therefore only thing to fully avoid random clock movement when your
BIOS randomly mucks with TSC values from SMI handlers is reporting the
TSC as unstable at boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/tsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 21187ebee7d0..37bae0d67714 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -356,6 +356,8 @@ static int __init tsc_setup(char *str)
 		tsc_clocksource_reliable =3D 1;
 	if (!strncmp(str, "noirqtime", 9))
 		no_sched_irq_time =3D 1;
+	if (!strcmp(str, "unstable"))
+		mark_tsc_unstable("boot parameter");
 	return 1;
 }
=20
--=20
2.14.1
