Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495372-2-10313189466556742193
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
    t=1521495372; b=fpiWSn7eTGcxHq33gaYJiKXtSgK/BgLZr7n+RvYotGMqnsj
    31TJvhlEH7QgOoyWnhAaoX02ZP5oAuzrtTnGs0/8pjDFZqyTAYGONyAJKzyH/zV6
    WVjw3LuznunoZk+qpkFIu8u2vLvkFUZjoVAjWnTPGbJXPqzwVW4axEnPHfKr0kHS
    ywKoiYAeynEBCoVQobBRniAqRFEUZ3AZxxiQqXzr7LORsWKWCTK305OoXve7mNua
    uzF8hhm6agwSYZV1udA9je53WexILaO7JhhITpd+3JZhI9R6+noB5M0/KLjRU2ul
    MOM00HDuhPYvsqBBZr+lUMpWSe+YrXhblOaDFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495372; bh=kmqsWl
    dFA4WbWXkgOU3rLC3qj4os0yAUkCUoXTPIShg=; b=I7UWfrzYeankYqjUwYj+/C
    arXSnNcIcrfWN5Vl6kxO6J5+kiKfJsIHzq23MsS+67WrOpuoERVcezq3flM0BLrf
    pbP0HtmDWtGuBOAPzwetXPM7ZeoZIisrqT61u+jXj5aykxmYlv7mCru5MhMmuFXU
    fGkZwHqgNWR4gb+PWigu1pYcB4dX4pCq/TgZ6EhjcHgyjOCPpWMJtQa8KGt+Emnc
    4mtCKB4iVeLLVqwfnSz+aDMsi4D9/3axG9/KTCxEqVXAKhKBM91PSRhos9HMmh9y
    OBFECfMqY/0leaApgpH0OSAcTnumVRz1dURaB7bsy4XnFrnP49OhFdRaHi8Uycag
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LUrEmBUJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejiedtfeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LUrEmBUJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejiedtfeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970765AbeCSVfV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:35:21 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:62208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934614AbeCSP7d (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 056/281] KVM: arm: Restore banked registers
 and physical timer access on hyp_panic()
Thread-Topic: [PATCH AUTOSEL for 4.9 056/281] KVM: arm: Restore banked
 registers and physical timer access on hyp_panic()
Thread-Index: AQHTv5sv/tlVkctoPkGbwd9sU1eSjA==
Date: Mon, 19 Mar 2018 15:58:55 +0000
Message-ID: <20180319155742.13731-56-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:xLo6CXIvAjuI3GDsxByIrAdZ0L0/r7AJO2drLN1CWndFn2Y/lIh5Yq4nbwGXEFkQo87zrl6nXsvWqFDkBrolgPHhZA9TMgnDpSSNq/tDIMW3zak7dnDPV9NH1KBG2CF5oFZPDy5z33ZJG+CP4aQyGpPAbqVfOho4PMzSrS/6FvUKgrDFw/FFoO1L2Oxi12AFZCwV9Yu49AGFxGjzZyb2JnQOIxTdSFOIH1rrA6tGI/FkCPEw7Ma1CXH6p49LGs6d;20:o0iVXgUP8Ew5OUP5hJ/Fdygde9AXblfPm2QhVNj0n8G+R9EZ7ovCBI3tZBml4o16lN58LFPGuN8o3q47Mch+rG36mgUUFQFvvvfm9bn49wgtWAzKwZPcc6fs4Vl0qcUALaMY7bGDrqHA43EbiegLCSKAD6SIdT1Mf5vT6FP/rFM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b6e4ca9-5313-4dfe-6053-08d58db260de
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109217AB2543C1F669DD0ABFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(15650500001)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dCZUxMhQjOEdBHYpORQazwYJGGCtkgn0LDxlHQAiknfoo0EBAlXvL7B/J+MaGTFtAWNDl3/QVa8X6mg+SzhaqPkuZKSwQZjj6MdfyTCVxWvNUnTlSihpdq/UzpiYBo8EsxVnyJK21H3DGvD+HS4a73Mio+fwbkP1rHqQhoiSmUZdtcWr7NosWaaHdHvFl3ZAsUVw2XUWAsnK2uHnoTjtxsgOcCzcPtV+If//v742HoMUCQiY5IFab1hFznqY6xC0BwEd4zThDgHmzGycYnimk1r6IkNHzKEoJETLSG8VQgak5BOMbYgUBNRbLVhXLKFVCXdGAkcX62sEH6wRwMbyAA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6e4ca9-5313-4dfe-6053-08d58db260de
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:55.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Morse <james.morse@arm.com>

[ Upstream commit d2e19368848ce6065daa785efca26faed54732b6 ]

When KVM panics, it hurridly restores the host context and parachutes
into the host's panic() code. This looks like it was copied from arm64,
the 32bit KVM panic code needs to restore the host's banked registers
too.

At some point panic() touches the physical timer/counter, this will
trap back to HYP. If we're lucky, we panic again.

Add a __timer_save_state() call to KVMs hyp_panic() path, this saves the
guest registers and disables the traps for the host.

Fixes: c36b6db5f3e4 ("ARM: KVM: Add panic handling code")
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/kvm/hyp/switch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index 624a510d31df..ebd2dd46adf7 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -237,8 +237,10 @@ void __hyp_text __noreturn __hyp_panic(int cause)
=20
 		vcpu =3D (struct kvm_vcpu *)read_sysreg(HTPIDR);
 		host_ctxt =3D kern_hyp_va(vcpu->arch.host_cpu_context);
+		__timer_save_state(vcpu);
 		__deactivate_traps(vcpu);
 		__deactivate_vm(vcpu);
+		__banked_restore_state(host_ctxt);
 		__sysreg_restore_state(host_ctxt);
 	}
=20
--=20
2.14.1
