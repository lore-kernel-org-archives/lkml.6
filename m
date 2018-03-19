Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481798-2-11343975360533024459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481798; b=de3jZxIUS1vPwRd6Ct1uEhI0/u1FX6x/RfWxa5j1RzZ0lpJ
    mPxR+eNjUkq4XRdeVkfQldEIV7woyceAhZ3lXReQ9F/77b3GQuUVc45oBZoVQO5w
    2BCBB4rqwKfXVKdUG+kD1o2IrW20IDyd6CAPb8HVYJfW/0Rgb9cRO5tzxdnQZQHT
    xfmJlHvrCgBXHbHtSBd3p3MHtSeHANZWA8/0ZQENvNY25/izgdNYNH/fbH87sShp
    N8/KVrMdNeN6oeSutb8nijJFD7RXbVXxh1zOLMG3bYTWzmmcguQYe82s3m+aSqaP
    62sHPwvfGPjQUhQhfOFGJS4Yqx9LF6Vso5IY8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481798; bh=jrElcw
    7FqZ9WKYkEX6lVv/ROCK1Qz+WvxzYGLDm6Zs4=; b=KBbOXcQjzOGQRSmMwLe9rr
    i+S7z4tzXGTsJMR6kZ6j8f/5t2iwZcEZRpjubQGjUwPqss4agoDXn/qVZOj3MY4/
    f1mH0C4HK0s/6cHbIwD1G2JchPa1F7qlQV1gPPtyLRdF4Zm2UNZyqTF17LDOHaZ2
    luzRczyZNjJs88QeRHx/r+Zera1htW4qxB+Y8MKRnOAlScxer3GSt+2N1F1KENfc
    iCtgg6Tczrdy93KE7RERm/O8/s8bW44ess1wM1czsYuw773zoEtu+tCcWtzMSfcr
    k04XVCYOp9QepG6ZjeiwV9/AW2kcKC/oenW7dcthooOEWp0Pyd0x5QAtp1NYe39g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cOlxyII6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeefudenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cOlxyII6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeefudenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965776AbeCSRtk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:49:40 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:7948
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965675AbeCSQFC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Ian Abbott <abbotti@mev.co.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 232/281] xen: avoid type warning in
 xchg_xen_ulong
Thread-Topic: [PATCH AUTOSEL for 4.9 232/281] xen: avoid type warning in
 xchg_xen_ulong
Thread-Index: AQHTv5uu2nV7b403cEKyB9DV7+TdOg==
Date: Mon, 19 Mar 2018 16:02:29 +0000
Message-ID: <20180319155742.13731-232-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:8CyQ2B6K55Ad2sl6YPZkPk96znN0SJrpX6M7ku4YD8nkOQ/RmUkRCs5W5TqbuIYCSi5XP/ljaUq5cTgbV+/5tUEkP0eXf0QZ+jTeC/AM/S7726lZoD8Ub+IPxJuhRR1KqCDPoyC4m0w5FKWWF1gqYDI1hS1aLf5S+ONEbc0Y9dubPZDohwsWKRAFY0MipUwNwsy++jQAmmGziUQ6TgD0++OoIRMw1o5j3oF8TfGiTW9XyJSQpfKEOW8p5ysjZcF9;20:Sgr/G+7tj7xAlZeARbvGz1k3geDRjGCZc5bfAd/6He/k9dwd2lXWGBxTMI0kP71ZyF30tjhp8hJUytL/fQQrmMkdh4Az+3rNiWTgr2QOwN8oSE5u8rq+iC8lRCp2HZ7O8esjAUyvnEDL1sNyvFndPPzo4Hx8uGLRoyGhjWLz0KI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94c21027-3158-4c93-3fc8-08d58db3261a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885B20D9F34153F178D86FBFBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dsc9NMxdZF8ROiC6D+Llz95InFP+Hci584nW5rib6zdBDnyTg5nZtnLxl3xfI34z3UMy2Jj4B/mVnUfNn7LxXQYtDp60JZhGflXtFaUZsJ4cmj/Uj8ot0+vXUY1lRehI8ZpAyTPxby35+UxwM6LWG8vqRr3Ov3IbGE14fohk1XBENelmyFVmpdS4dLcC/ROMkhp8840+31muCrq17ybGzqh2sumFkm0D+NP2yP8piSNCI/iiOMvf/zqxhkjb02hbXfsjFyWlrTrFOAgqy4R6KBUNXphEtrMAb5YTM0ZALGUmh/77H8xUXgCkgnRVlJRLAMbDlnMNtdNKBrL9hSP+Wg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c21027-3158-4c93-3fc8-08d58db3261a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:29.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
