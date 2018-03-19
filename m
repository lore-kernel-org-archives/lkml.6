Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497191-2-12130069265004693459
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
    t=1521497191; b=pr4kaJ2fghForPdmY3LolwHQoYybkLfbReKPrm4r3ToG3rD
    I2WpoL1grUVh1zuQehtiz9bn15667ziPlNa6qdeJS59wV/lXddnmZAVjatWOqZfI
    eiuuOYxb4qP7PO4IU8EtFmhxMfNRXiL2yvEM/2+QWvCuleAiLNU53tWmAM2CgLeG
    g50Iei3iCXNscopszKNKyNvb772t7XhkdYy1dN7nDWuPeHDtUEm2nvXYpVFQulO9
    geH/XNf1jEK27Brb1etujXBWvDlonoCFKOswO4WBCujNEDHGE5ziUgtNaUO2aWaU
    rDvmv7E60AUltIZFRV2YeX/3M0mOouBTeh/w8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497191; bh=8SLHoR
    TyIBrc4cGh+tmLxl+afvcun8IWK4rM6GWSDlo=; b=A/XX20M2tH3WkMYIJQ2XIS
    X0Vbw9zqUB103/7OjLJc7toRkdi2T1qvMV/iRViSz4afV9S21+tqAe9l3g5vWy+C
    2QN0zL0C4XeHTv+JBAGR/WQ5CsjKUwtePCHAm9S/+cwNGo7pYTgiUISscBV2PMID
    R5wHgzrw9cWEjpa3EkH16u6EwMh1Kkrk4YCkDwKQKMQCW/jYTOXyXcwpC3I21VIr
    dtt8ZWcJzcbrw7CRMBeoMF8qtn5qHJKOXsICMrIR8uNZUyEhCSN8fh8oiVmh7nSS
    5I18QVy4TtoILNlRoOd1fwYoPvKv+22UOhbSU0AnuQpq0Wq9oHcfxEwwlWLFd7yQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cMtyYGiA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeeltdenucevlhhushhtvghrufhiiigvpeelfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cMtyYGiA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeeltdenucevlhhushhtvghrufhiiigvpeelfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934148AbeCSWGX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:06:23 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964808AbeCSPzG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 22/97] PM / devfreq: Fix potential NULL
 pointer dereference in governor_store
Thread-Topic: [PATCH AUTOSEL for 4.14 22/97] PM / devfreq: Fix potential NULL
 pointer dereference in governor_store
Thread-Index: AQHTv5qekZ1W4LGvlUm2yaF6X3BxhQ==
Date: Mon, 19 Mar 2018 15:54:53 +0000
Message-ID: <20180319155411.12348-22-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:euJcXHZbwv5+PYD94nkkF8f16qPpylvna3dU+33FmPZvv+KRGlG2ePQ2requZ57s2ZoUZ/rk30XDW7SlqccFcP88gXCh8FFy5DJRNwlt3MtX1Dk7/GQTG0QPGQewARxagYiCfLTRxhy/BV+qXMMTFi22tAVTk5ggEmIXQE916MdQ/Z0YjnmCuPLAGlib2WNkqPqZ1Ic0JxQ9fkM2vz4V36Wn1Ld9lJwGmUuLb1fVXwXt40LzPxBViYSMDPToUU1r;20:faKYck2I/aTdISHbDn8C8e2Mn5G177D9skYlvNEoyQRRIaMxQg8/BQoLGaSVCOtWH8ao3lfcNJL5zYsze0LVYBXnaLM5UO4YEu+U+3fWNJ6btv/tiGO4YzF5XnehpDu0UfATsE5nv8bSKpGY5XcrMbDwiKX1v+TKiI/3GjI/Xto=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05648eea-ed37-44ff-8019-08d58db1c1a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08069286FAB6E39B3F77AA2CFBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: D85I5IWMIHuIPNDZRcjFMqFg1kTMt5Jy53qv+L+PaElMQGw8p0LP+4LXFqhGynE6XLcixxcDNVva4Hn5X97YV9QctQHPKMVdr5GNkmf3vbWOoPQ2RacztMAimhqrVsy8W4sHS+0gdlwnu914bnN+1g9nK5JARSmrhhh4InTLIdYXuU0DGKUNr/aqq7piru9jgBaiel9Faf3E16btUwpRgFCJU+qS8+POPOdePWw71FIWwqop/0Pz8fJA6yddaylMxDg/d/OngbYSgX4XZdlJ7t1Dy8heLRWHD0Q7nhJGKtKLBHAbY/4JcyGcSNAfWAfmU5VeX+zks+lQMdXPz4M3AA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05648eea-ed37-44ff-8019-08d58db1c1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:53.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit 63f1e05f7fe9ca509c60154d6a833abf96eecdc9 ]

df->governor is being dereferenced before it is null checked,
hence there is a potential null pointer dereference.

Notice that df->governor is being null checked at line 1004:
if (df->governor) {, which implies it might be null.

Fix this by null checking df->governor before dereferencing it.

Addresses-Coverity-ID: 1401988 ("Dereference before null check")
Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/devfreq/devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 202476fbbc4c..8a411514a7c5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -935,7 +935,8 @@ static ssize_t governor_store(struct device *dev, struc=
t device_attribute *attr,
 	if (df->governor =3D=3D governor) {
 		ret =3D 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if ((df->governor && df->governor->immutable) ||
+					governor->immutable) {
 		ret =3D -EINVAL;
 		goto out;
 	}
--=20
2.14.1
