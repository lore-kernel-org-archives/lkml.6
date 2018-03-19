Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479151-2-731348746623891890
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
    t=1521479150; b=SJ8sWeRyqp4FQjQSuHJpc8rSRBMH1Eu2d6NEVm1tTc5rZqo
    TfygGNv+2/KcwN28Y2gHcLTLPuStctmXdNC14jKRnSKrtgx90nNDnjW4WqlzejvE
    03KEQBXUHQ47tSlF49NkzVoYI6FiYYkVppWZzyeLC+eSJFCKVfnJQAiEnHiW3ywi
    z6LIqqdtt0T/Gju8lJ5SxT5yNNb2eQXNycTiqXcYePWVKNRIa5uzGQlj6ne/RazP
    ctba30WpqQ6VDFk7w/bBc+MNzxsVvjDihPuGf6lqxeboIBEifKwORVn+ZI3+Da/p
    8wChOHgTiQbNL13ne+omrHThTmEHJdETgIa4tSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479150; bh=jrElcw
    7FqZ9WKYkEX6lVv/ROCK1Qz+WvxzYGLDm6Zs4=; b=VeCy/09HqPAYhB0hdugBsy
    V8Zgcpol6TpzPRF2tuytNbpNTNlxYiPjgeHKaS6680Ibry1dCqFJRH6PXsxEr1Ef
    okAaohDXD20tLPoV+yYPzmopv2r3HmLMOY4Y2chDY4qKoefw3KfO6Oob0R7Lf0+M
    u04IVKVYjNSxKTMgj2ty7lzUCNWCpq2aVgTHD0dO9MA0L/XdFdddxZ/WilPFq68x
    VTGStUn6BFZJPuZpCpE87Hs4np1pOoaF284SlMjmIbGaZz/AHo2mKW2KYPH1/etB
    NGazA2XPwau4D8D5eeDGiXVEacOpAdV1HcSoy8BfcVGnyW1F6Nu2kPYqE2mGe1Rw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ldFyTSu6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejfedunecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ldFyTSu6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejfedunecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967816AbeCSRFq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:05:46 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:57012
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966366AbeCSQK7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Ian Abbott <abbotti@mev.co.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 142/167] xen: avoid type warning in
 xchg_xen_ulong
Thread-Topic: [PATCH AUTOSEL for 4.4 142/167] xen: avoid type warning in
 xchg_xen_ulong
Thread-Index: AQHTv5yAdtO1BDdpfkGrbK/0/u58Ww==
Date: Mon, 19 Mar 2018 16:08:21 +0000
Message-ID: <20180319160513.16384-142-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:yhv6B/IeZGpLtBkBsShX9i+HWxhovBBfWmokp7siInJ0x+NpkjNb4Yrk9ZYggpKY8q4HOZKF8RnzmQQ8+C1Sl4hfeX9qrVWd2QFL0b7B77KW0UBj+aq6/RkXzzRgGjlHAMYvQo2RZKFNLbsPagZFHJvfLx5HxmXWF3QzdTGA6wlItfZAdw/dPfH2DmjJDo7drsW7YN0r3bEWCOKYFeD03G3slm7Iugfz7jHkbZZQ8/WlSSvzAkfAKYAk+LKfDERM;20:2iTUakcwbBQSWEvYMXaxwLjV1lBHBAoqA5KrUK1ZQPwMuBs+5FAfQ4gJIMyJVmOAGbYCXv84dW2MadYr8VY8Rpeq5PP3wklrCKCA/qDeOjiBAvrIEtKE2zouImCXGDMLtLxFHF6cO0uZcepcyuvM+JtfUoPOeLRoC8ULvAiEF8o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4a641ca-7ac3-4c86-526e-08d58db3f930
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095454EFF2928E37111C237FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 26KkxD7SOD0C3bdCYGOOa3PVatzsmo+PLGiwdejrGrUnJ5NsLRkFF+iFp0oOBRpnXrlGBiSStjbVM7JHZYqmiMvY1JsyhAC2jspFV/6XphN3pwtcdCDCAyQjyA3dIIqo6qALN2SA7/7kwk0zRGFSA1vdnw0BBIoV8B3nUlnaBeBAXwgEWkEJyM6U8lBYQ8mQwxWDAL7TnpD6krH85PNdqw8pswx7GtWHffQBN+BkUsqceFlB0HyKy+h+TPAaRqLmfvrd1PL4HcBfxR3Rz++81ZvUyMy5SQNL6QS/etPwNJtsuOm9O7/tCp/dA8TK0Ne1fz9zmKNJ7PdxO4d/UCmsGA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a641ca-7ac3-4c86-526e-08d58db3f930
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:21.3472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9cc91f212111cdcbefa02dcdb7dd443f224bf52c ]

The improved type-checking version of container_of() triggers a warning for
xchg_xen_ulong, pointing out that 'xen_ulong_t' is unsigned, but atomic64_t
contains a signed value:

drivers/xen/events/events_2l.c: In function 'evtchn_2l_handle_events':
drivers/xen/events/events_2l.c:187:1020: error: call to '__compiletime_asse=
rt_187' declared with attribute error: pointer type mismatch in container_o=
f()

This adds a cast to work around the warning.

Cc: Ian Abbott <abbotti@mev.co.uk>
Fixes: 85323a991d40 ("xen: arm: mandate EABI and use generic atomic operati=
ons.")
Fixes: daa2ac80834d ("kernel.h: handle pointers to arrays better in contain=
er_of()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/include/asm/xen/events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/e=
vents.h
index 71e473d05fcc..620dc75362e5 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -16,7 +16,7 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
=20
-#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
+#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((long long*)(p=
tr),\
 							    atomic64_t,	\
 							    counter), (val))
=20
--=20
2.14.1
