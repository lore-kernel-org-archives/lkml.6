Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495765-2-14529322667161654663
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
    t=1521495764; b=CalrgZoHZTBkKyLdduvFF+TsknoQsFAco8B8D2kJtsCuDWA
    WZhH5+/Vey7NcaGUQhRnJAYQYHqIvAi7EqFEECb/9B7DufrgDIljb/dfxf7OLfQe
    i1j04PohUIEJQ8eJC7wVgsLZJJUTdU6EM1eFAyLjno+5+/uj1SaZTb4hBatZdWDs
    Bs6GsCJckfKCQ88e4yymCvncZy520wAcBmfdEL0k1N6FkL0VOQqCxAG3FCyK/wHp
    kjnIrikq7dcIafy06La+MmyEM2AfnbOayacgNmETF/DIzebMUqj2IN+xHnfcuoWz
    k9th9X+A3TZH7cZkMyFOHKpdBPVy3n3cE4H7T9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495764; bh=rR4cma
    pI3mNy90Iqo4RdpnxpPardz+886QsOaabdRAA=; b=EdYzGvdzoKejznN9YsQm+F
    z+btRv6JBsgOA1ehwF1gdUUY9VFsdijzJAH56zWmzZRE0Pg6OTKJBUxRbQDtMRVf
    np2T6H9c7fTkHQMF579mXPcGR9ZKU3VU4dL4Lj3ol99dzyhvQnVlBkVMoi5sfSgd
    R0HgGx+yurDTf+sxFdvtdzsdx6BWBk5hP1oohpWKT7J80GtqzoxmM+YNf1diOa6F
    hkb/LWyjtqA7o0JkS8fNT2qrqhBYtvUv1UktV7IrcVl88jjRPJrW1IkCBD4LxPwS
    fiIa7979YP7corRw4UnZQ/wpVm2WBCmb/fh7/IbcKVItJXO3p1QNQdk2FSrCLoVg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NCovltbi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeegkeenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NCovltbi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeegkeenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934599AbeCSP6z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:58:55 -0400
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:58464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934643AbeCSP4t (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Lechner <david@lechnology.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 78/97] clk: fix reentrancy of clk_enable() on
 UP systems
Thread-Topic: [PATCH AUTOSEL for 4.14 78/97] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Index: AQHTv5rOJn7Qlcmz20mozFRzI8zB+w==
Date: Mon, 19 Mar 2018 15:56:14 +0000
Message-ID: <20180319155411.12348-78-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:eQW/4OTd2aYAanFFvsIj/Kv4EuvO3Tv4Jj6koNytU5nJl1IgzjWWAaKAeeWtcCvtcPJLOb1jREC28Uof6LxLx8OA3VRK8BhQlDA/Kcv++ZDWeWHlp1xOE9smSEeMwb9EKL/4YoHVV1SFlb2yiAaAiC6TmBxHl1D3r9EpAjUYc2VjjKePiqIwyyjyEQIs/s1y7BYGrt/4GY3Pz/NK4WeegNJ3UEieT9Gq4s7x3DdVCRHrocFyKyFzPEhKfeiPdnVu;20:R8ELAiaCLH7NPIHpeQF4LG7bM+CRLJ3/bN8zYwVXo+AP1MeScFVkQoeYS5RrSzbVkCe/+gMiFFpD9doLPmANbJGrwG+NbDuh9kcq9ln/sQX04PUWt6k27MDFzuPBO9u+DzT4jB90rdSIHrJD6hQ8Cwe/cQcaj12/pl3zYcawkk0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8933dfd8-4ffd-4409-e348-08d58db20075
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031DB55A349FF2D13A1BCFCFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3wg99tE9Ti+P9MAFhr6PoEyURqgugt5z9h4cp6cQ/uDk6EWXF6Hi+azxxw434NExKF718uJgZJ4DXJ+NCBSuerednP7weHb55U148z/bnVRA11z0mP01ZKnJx37QA94Bpy/Gf+LwKvHS+FuEjKbtN0z4LQDgBLtvi6mnH85GexJlJJN3FoQtWGO4xvBDaFe2wX1FISHGY9MZeLcZrT5xKx8uRP1ZH9hnPYedojaPIbw2nqgyf2yBQ7nRBW0byT8wt7CUgjcH0q04/JTW9PiZNkwIiz7ihVYtCsGs69sJpDlSMQDccG+ewU0FGszgn6I35ebrbaDmjH/g84IKZxIdRw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8933dfd8-4ffd-4409-e348-08d58db20075
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:14.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index c8d83acda006..f6c9d6205d85 100644
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
