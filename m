Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481325-2-13091792208737618984
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
    t=1521481324; b=lMVbUBgqih0jfwUFhlLb4KOse600EX/tcEldIAUHlfpPMTI
    jl0mjM0w9OoZzBz9KqFDb2ZJWx9+X2d7jNhpmY12R2nacRWd7IF2if/h5iw4t6cO
    vwrgK6T76pibqIxT8dJ0YcxIyaeJko2Og7g3SuGHeHtIdjqAAm8HIUcRJ+/WtcWs
    9IYdK4mhYC5AdnbntJ65jUsYx7GX5kO5BpQi/aPe3Itdk9TgpV7aGkjEmTKHEc1l
    5xY4zLYRK4FhfK27zNwcRqIKPd19HEsZ4d+ENkuMlI0kAstyD1ZaozHXbX4PaHop
    ohtPmDBNVC/HnY/JWe3f9wfCNs9ZuvsmuBYis9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481324; bh=PYI25G
    OEYtEwLiz6aWIevU99da9KRatjgjtfvwsiR5g=; b=S64jUunQsT2l1IXc4UmkQF
    vpgRQUOcgPI2D4ENQJTyAfzJ/Vz9DmJ7iaEAAK6rBgarC6h2kd3QEtNS/iqgDR71
    yMo4R8h3CEOcYjsKQeesvC6mWCtPfr0wcIEnHRpliBFKnyijybJbC3Fp3iTI/PXa
    0FmdZAILdF7te5aTlrEoHM8lmcZC6x9qUm46QbYZjwCYs//ZDJ1GjzK7jG80lE4Y
    UlnGqddU1O8FQXroSMFdLqkzhtplmghZzyI3A0MgStSKuVzCWlUGDeyYI64wz+T1
    WRIPhMBaAbW8+Zad+jFNhUxoriVJTnIMs2ZqtILxEzUCVY1QkdZipba1FsrT9dAA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CjrkDctw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekjeenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CjrkDctw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdekjeenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967451AbeCSRl7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:41:59 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:2671
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965865AbeCSQF4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 253/281] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Topic: [PATCH AUTOSEL for 4.9 253/281] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Index: AQHTv5u9e//74PBIZ02wHAgzqcifNA==
Date: Mon, 19 Mar 2018 16:02:53 +0000
Message-ID: <20180319155742.13731-253-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:tAM0DikA+aLplsxITXJcLXmofgDTZ2qqLQMuRG1j38ntyiZJe8pFtV+A76iNuF5HJsCrgm9cAbEbZ4hmUSBRGjppw5b+Ybj2hKzF7x97hAcH6EHvTEdI2c1RdKDQ2tkCB0kYwKTx9J8olMgKNCf+jFd1iMbiqjXPF7Sx3Xay5TImMaRzl3a4vEPfNrM4p2a5jwD02aH4CRVmDKgyF8T/AaY4LWhuYjLv8HIk7Hfdgy0ubWjt97PA537/takuBypT;20:h6D/RqNzjrES12cPHrwqcr3aHNzO1PDgnjozWo7OtotRtnPBwE9ub9UQI6vdXgYRtE1QdfdxDg1vcdQpzUdYll/Ka4pEermsvdy7MxvSuXi8aKv0kyqCOhD87ArUlzukVj00kUpdkVFQZV5SFnQ4PbTscQAIwSfJdz6IlR9KPcI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5dea5930-42f2-4781-e43e-08d58db33f05
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07278731A516B2766C82D5F7FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: L+tqwlI6HJYpX19ERUZLdbgNkRXEUePNeLBKo/Hrx28fUJs7xDFWylC/xmFDmcr7/kxmSljZoYKxNo1xp7Cj9ltRCkybjqfzGmaXSuv4gV8jQjmC3IRgVyH0xKdBPA6SeoZwcGiHv4Z9LYBuzZdmLLbyQbQ0WreJDHiynsI/JYMmhq16t4adyPmScci4o++VBs55TAYgMJvLui/sxby1b6QSj153uRBi4XUKGBLlQroF0oNaGJEWe5FbFcLf8fJvw5OlcPOjJiyzk6JASvS7OXinbpKN+De4l7b/YLmOkBYOTBwUv4bwWUcZ3Fl2/GCYeWcHZ44BlCH4+omcY3qhPA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dea5930-42f2-4781-e43e-08d58db33f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:53.8034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

[ Upstream commit b2cdd8e1b54849477a32d820acc2e87828a38f3d ]

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd (drivers: cpuidle: Add status property to ARM idle stat=
es)
Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpuidle/dt_idle_states.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index a5c111b67f37..ea11a33e7fff 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -174,8 +174,10 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
=20
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
=20
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
--=20
2.14.1
