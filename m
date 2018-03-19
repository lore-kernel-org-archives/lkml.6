Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480960-2-12494989364268233099
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
    t=1521480960; b=LhkaF0gw7lb39MdDW48yNcvrNwa5KxHI1BWENz4p6/YmYjl
    Er6zAfiORwYw1fThzLuyu/oTBbHLfoBNxuy2ShNb1YuDxSaM78ErZqm1M+PbtTdu
    BWu3J5HoUV4f6RwWTVNyyxS8PeAy9lGOzu7Ifjvr3wXdwqDAvMxtR7AM5xKgYAg0
    H15KWjUME1712srhzwowZ12vb9YWcqaPgYuTa0w2Va/6sl+CxlG9qCTdaaC9pvc2
    x3erCnllQf/z5xX/DgpI1NNQVhAxdH2HjWORow+TmOlzPiXnMt5AzzJArz8oc6Kj
    jLozFa4eygbGATPwBhiBFIAenmMpQkjxQaZkDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480960; bh=B4uFO5
    gh0rgsU4i97SgOITvCrsfD8pPgFf8UKAhz9ps=; b=PL88l1ZsYeHd7UWNPCzBDI
    +bFulxcixrg9G72gTzJnzh4lApobpyfCegME7h05cUBXqf+Y6k8LTNG5ZxS/VJbI
    lDzkG36fE2GAv3r3XBtj2nf8abbDEwTLkU8fRYe9hvw4bjnfj6pp3aFR+KbdO8uO
    xTn+sjVeEEOLKNHw0afHym2F3C7SnDtrG62Lpm+RK2L4L8AO6Q9Fj37aYhWQ29BE
    TCcN43zm7zi8RR6h9nIKAvf6AezgnLZcbtYu9S+Nsn29svUXOaVQCVBV3XB1jVa4
    sxZfw1rahDagWhn2NvWsXtJqZ6Cx4FTN7Ym6ydMIc7bP38IlZ85QqTUm7+1eZymQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fY7FK8L7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fY7FK8L7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967208AbeCSRfz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:35:55 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:31931
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966003AbeCSQGq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 007/167] af_key: Fix slab-out-of-bounds in
 pfkey_compile_policy.
Thread-Topic: [PATCH AUTOSEL for 4.4 007/167] af_key: Fix slab-out-of-bounds
 in pfkey_compile_policy.
Thread-Index: AQHTv5wZ8mY4PvAcc0i+tevM2KA17w==
Date: Mon, 19 Mar 2018 16:05:28 +0000
Message-ID: <20180319160513.16384-7-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:oR1YTPrzxjo++eTY4sZY9/yxIM9hWwnEwnameyI1fe2pAUA4pS6FWnxt2/pbblLFPUHiop7k1c//Aue1gVNVszoUj6GljBoA1teDUqjhrV3h08lBeycNIJifGS/QCycKBv/3nS6Y41t+M0kcWYYVMFWsq47HAU2Bbebjso5wcqxqA1ulqrKGxLnr48e/IcXuheDj/A0eyXzFgIyoJ/8Nc8+amivCLg5CZEcOMDB8bdZ32M9P00oG5lx7Sas9EDyI;20:c6PcU7O37MHtiIN96laOzP860jh5DwHVESpYC0jXaIeICGUTXaFFHls61PUWctG/jMTXi/rYcHUVOiHDbYryBTPDOsss/BUWcToZ44g99bezTRMmr9MCWXSazz7c1lTJMYBYkFPAmp7N7mUYsEopX8SDMONm6ZiNwJuSQYA7Hug=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbff2d2d-bb0f-4b52-9e50-08d58db3680e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09200CA20365CB497C53E016FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UbW91xF8mLV2XiDtCrkgcWnT4c1ufkQvbQZFJshRpFQMHrjwp305OwyAaG2DiAIBTQFi2pRG9ds5EfM+mbjhCOrVfr/U2wHIT/sAJsGXa8qOHkWPrV9udI+qU1CLJzWBrIBfjo0ipV64Zo1CsR0pYcsjbL89/mmifEOZmO31fSsHvqUwJVefGYmNXZ9k7B7jU4AT5t6NcP4JfjPNlXYmHDnqNEjh4JQR9W+WEZ7R0Uuput4ekUHflIa2r1bC7UYzMfn7SNjrPKSpPINhYtIHqZ43/mjlGy8lQMiOnFC4sCviW9i4/HLgPgII+b2lh3sLFLKwFw8mrI/M5OC1oGQ7FQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbff2d2d-bb0f-4b52-9e50-08d58db3680e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:28.7489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
