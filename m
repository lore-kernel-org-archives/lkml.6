Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496195-2-14112982092503722095
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
    t=1521496195; b=JhKAv34Bhw+aqZXKOxls57Jq8gJUv/SC8Ra0bJvTAu25ZQ7
    /KpQm8V94hw4HEIGHeHxRfE/LwwalimCbOiXktJYbNHuVdT8BSel2/Jh77Kwz1kj
    1UqVDtSO2W4sb/18CUcyOlsP/RvEQrUQZ5Sd0ReGBu2s6jDEyPtCBYr7cCod7lpe
    Lhw6+AyASXcFZ7KOYoZdLcCiBhL0vG2ftFbd+3s3O99WfJ+Vreszq68JAlnvA3PQ
    Kf4TEiWOxwXr0Gqpf3X67gXBsjAXfJVMGJSYEg0OfEDA1wBDva7XZhTDV6u/kL2G
    JUF6YZL8uh5lN8Fd/kLV7YzT+8wcSLiZV3+upXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496195; bh=B4uFO5
    gh0rgsU4i97SgOITvCrsfD8pPgFf8UKAhz9ps=; b=lqhuQ61R/b3+DYB4lUsJEe
    eCldeo+MTtc+LL2FKoF7D61qan9G4zwEAH52CNG48Yi2iCx2Rs4VReOt6pnZeDhC
    6fwdNCsiNJqwScn+joytTlh6gwRyHFupnk8IsGVks+8XM4vCxHgMuPl50FHslZds
    6IICBxftGnBHfab35EqCAiF2znqcIgKWZNVpIz7Q4PL6lvTD2QYIGARycg9RhEpa
    KL7bSLxy4rW7/zDEMoO3GbEAmMrdfoPqoGOHAgVKmlV1D/euJCd9j6DH/NnJr2OG
    ayRmszqFdV97f56excRPk6uYNA1Tkw7se56ClWOTl2oReavQGApywwBEPKuBnqJw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fzT661UK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fzT661UK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933105AbeCSVtF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:49:05 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:30064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934394AbeCSP6M (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 012/281] af_key: Fix slab-out-of-bounds in
 pfkey_compile_policy.
Thread-Topic: [PATCH AUTOSEL for 4.9 012/281] af_key: Fix slab-out-of-bounds
 in pfkey_compile_policy.
Thread-Index: AQHTv5sQ3T9K8ixWsEG7KzUjBLOaEQ==
Date: Mon, 19 Mar 2018 15:58:04 +0000
Message-ID: <20180319155742.13731-12-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:IG0+f+4SRzDWB64iQQVzra3zFm5isQ1y3nv1eBTGJFUBoTvYGki49/ycGFSNSalxS6RmpxDcKIPidIhYSeCbiYp8xcEddBOGqv4iCWi74uyIGrGh87cyUTxd9u/qykQ825OMZ735K14nsmyxc0gYa5TVjf0cFdKb60DbqTh1I2nloCaV+cIMs4soZRWj+HkofT665ZK2Q+tVuQa2IK6x9JoZwQG7T3ZrXlPmOBCVKn/JAJ8oxn8qqfssxd3yZqsW;20:3ORyvcXuvXLkmtP9INRjfyb9to1NomRm7XxdmJ23F2WOQaIYG5YNQivUt3gjK+GWLTSNAMkdi3bGV53SSN8+CggkxVVd+8txcRqc7FYAzrG6xJKvFo5R31lidJ/lgI8iSA9O6xWI/2pfeQkBIjpUxFH+wA8wEsKUZo55eKc8Svo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ec11aa8-a649-4cbc-88bc-08d58db2331e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933045868976185B7525D61FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 4LaIOGpkGAMvKgL8BStbM8hJVqjdDyde0igLvq7VjKuY7JWw6G3+cBDOjcz6GuaIH3b5QZ5qAj7Xz/flInh1oO3XpUbYmUBY7/7dtSwgaKJUCKPoSgp1T+c88NBvFfpiAFjjOOSLzUkDf1vsMfwo+/SlTLoZJLzIxNRZHFkOOg3VDecd864vStAMIHAxxXbZ5JL1IsxKvlLL7sJVB8COlRXgwp6QKtrkyuY6tCSPw+fztqebrPf/DUWUtNRF0i7IGaH9BT0RmRLQw+gu5NhkNCrrlf0jbsCbeRQIwn2Z4V+GOR7f0g/vwc0LNR/Wf2BK6aggD+z6NpUklfoM7SWicg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec11aa8-a649-4cbc-88bc-08d58db2331e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:04.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit d90c902449a7561f1b1d58ba5a0d11728ce8b0b2 ]

The sadb_x_sec_len is stored in the unit 'byte divided by eight'.
So we have to multiply this value by eight before we can do
size checks. Otherwise we may get a slab-out-of-bounds when
we memcpy the user sec_ctx.

Fixes: df71837d502 ("[LSM-IPSec]: Security association restriction.")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 6482b001f19a..15150b412930 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3305,7 +3305,7 @@ static struct xfrm_policy *pfkey_compile_policy(struc=
t sock *sk, int opt,
 		p +=3D pol->sadb_x_policy_len*8;
 		sec_ctx =3D (struct sadb_x_sec_ctx *)p;
 		if (len < pol->sadb_x_policy_len*8 +
-		    sec_ctx->sadb_x_sec_len) {
+		    sec_ctx->sadb_x_sec_len*8) {
 			*dir =3D -EINVAL;
 			goto out;
 		}
--=20
2.14.1
