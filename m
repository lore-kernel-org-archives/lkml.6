Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495493-2-8143610354201245847
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
    t=1521495492; b=edJ9LvNaF5HvS1DNgakgZqDp3WhSsl1i9H/f+UxWI1dv0EO
    2fnl1O8ODSN2vq1XFz2yJnfF4fvI4Gqxq4X4fgzB4/BgSZLlQXWvBxLgD4xfutZ3
    VpfILOiR1/MbouVk/31vD+EntDXKyYBw0VJgm33UjXQ/ksmjZtSIaBg/5wX4RgaM
    J3gua+ctTPb0efyFS08ZwA2xYT5qmlrPPFjfC3Ucn8ZF36GfPd5A7TAERGt7ds5l
    PFsakSWez+dbBtbZb2c3sa3XZzANiANECeANnvNCo/RieE8VfEcoAgoiMo7FJxJA
    5wt7NVgopZTgSiEts4LaCXo9JyVPqzHz4YWt4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495492; bh=WVFJey
    0ovNR2TGlSbCoDlj3aNjAohZkZU06bpOMVzvs=; b=NMr8b/GEBsNx7k8rxW5QEI
    3q5sy0wWse8K4DcalZOuK+RHhyo4KQX+zPjGbfGpX7jTGMOL9//xr971gNNwO+Eu
    rR/NjtLzXYNFdcC24VxrWy3EXPotyQUKPnQwwHxJyyGAAkIPEMorLXslV0RBkPzw
    dmjjEzYk63s734wPliocc00WWw9YxZg4Pu03t1b/bhYUgsv7+nFdl04FUBES6uOB
    v/vTxH6bHimGOh3z0dp9jnNCWkA0Jkw1vlnYoqg1lgVZEkG8E7fy7LIyfFl8lk9T
    X9NrTGdnNBTpWOiuOprt1hwxO5PhGm6+RA0WzFzCAdhJQs9lxxytY9Zte2zMpOeA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TO4Tqh0C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtheenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TO4Tqh0C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtheenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971891AbeCSViJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:38:09 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:52960
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965086AbeCSP7U (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 048/281] x86/tsc: Provide 'tsc=unstable' boot
 parameter
Thread-Topic: [PATCH AUTOSEL for 4.9 048/281] x86/tsc: Provide 'tsc=unstable'
 boot parameter
Thread-Index: AQHTv5sqkPPd7nphV0yJivQn9m0eWQ==
Date: Mon, 19 Mar 2018 15:58:47 +0000
Message-ID: <20180319155742.13731-48-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:YHMd6h2Ry0wwXt+qkIlm6s+L2psDWEx/zhCEhu51C0weLVCHaQ+ZWbb4y45odJ4W31ZMjwLJbplhT1glpl2tcLJylg2tgTYBlKozM9soIF0olZHArGY83ezFMPVGGpWKnHCdBRX3VMiiz/Rvr2hqCsk0iPXqLUisRn+jLcbKmPG+46f6NvOUTJYmWdeQ3wINxbGn0jdifshHFk2Vc7gQTxff/LjBMDrE6EcTw07kWSmjAGCdWZsm0KXs89jDeGWF;20:xLYbzv3H8vpb/QBt3H772DM6ni10HdDBZ8NYJ7++LOmY/BB0eqAQJyGmuCNhGwMhb/oJ6n5CSVoaS5rWT5+YrVkCVxTQjwW+lMb2EAnVm9J1NSbnAL1HRO7NI4HdPxVbMe/OR1SaQI69DNOWCkUOlrMXXBARlsA6Kuw6VEz4nY8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 861bb802-490e-421c-6bde-08d58db25e20
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110954E514165043CF66118CFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(9452136761055)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(8666007)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tWkVPV4KTmF9FSo7NODsMwroCj5gFQGMdHeMtO0wEmQkMdlj9E4GtQ/4ufmkIfl1pQjjRbIsrBs6+Gl+C/kG1twRWucCN9+lNgpikJm1lMecFhHKoEd72BM4EJb7k6WfShTZ2YOWWAT3owOEIVIiHMNEhQ6ImX0vl7bpHtVG9dv/pAgHK5HS+IkAQuL27WeppOf8rtp7YQNKi2+Sr64hzhfnyp0+sJStvLTh1Ws0IOWMPS0kwri5lbsqp5diSkKV3OFvTe1frFpugTQN1UoudNKQTjafvD9dqCaYUX2Aptg8Le23XJRDU2I7Hp1+Lo6p7RtuchRvpd878/lOYyy1Lg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861bb802-490e-421c-6bde-08d58db25e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:47.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index d07a9390023e..bbfb03eccb7f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -366,6 +366,8 @@ static int __init tsc_setup(char *str)
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
