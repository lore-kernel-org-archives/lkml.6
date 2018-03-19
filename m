Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478444-2-2732802602111241851
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
    t=1521478444; b=UGHo8Xw8DFrAVeeuzXq76GdqPVs/pGtGeJcYz4DQwMFAlwt
    tBSZ27CkJADn5lrTBSivyMgLCok37SkEdvR9k1VFGXSULQ0z6PAGTQAG2qop1L0v
    JpyKubkMeyAEsEvW4mKg0SGFynTyysYbOMXUvuun3kfuDqv5RlwwoTqrQ43nZdA/
    eQRdJcIh1lvaeqnck3F8faarqEJjAWaTV12iMrYp/8xC7Gu0VtDTJ8XiEqmPtsms
    8/+LFO/egr+DXNS+CckWaHfGm6HRwL9dgEfgKRCbYen3kQRvJRuZZEuIuxALwQo4
    PmUVSn/UcZlEbtLnZsEflqNUEVtEx5EuLo2AEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478444; bh=PzYbLN
    yWuau77ooVLBzpPbLXG8iF3f8+MOnO5xKUHZI=; b=bUrmlRpqiJ3gCwXPcggg4W
    OX1V4wCVqHvtZm/CJevEbXYwdKbPGnaMmQfnR2k/gLjZahSw9gg4zpB06LqD9fhU
    ILHtXvC334gvOi5tGpHgM/UiGn20/hCRr7DUq+wokhsyMKrmZJBziQho/oknLBUc
    z6ztuxUmceD3vAP9DA50HEJis+Wc1SgkA5wyp2Fx4zWMMHqWFBHHnMZMYue6Iyor
    FJ8I+TClTulwKPT3UZY0dlL3CUwyswpMuuRBYaisH88xVjOEl3f4xGglMkQPItmw
    dxvb98w9nnF1vwwO7fWcaG78tiqxwDHBCEjeN9w8tWU+RQMWutb/lPi98QL3b4RA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mPxcAzC0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdeifeenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mPxcAzC0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdeifeenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935124AbeCSQxY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:53:24 -0400
Received: from mail-dm3nam03on0111.outbound.protection.outlook.com ([104.47.41.111]:6417
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935115AbeCSQLp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 004/102] mac80211: bail out from
 prep_connection() if a reconfig is ongoing
Thread-Topic: [PATCH AUTOSEL for 3.18 004/102] mac80211: bail out from
 prep_connection() if a reconfig is ongoing
Thread-Index: AQHTv5zwO3TL5wmxaEKPe4tCf7iXSg==
Date: Mon, 19 Mar 2018 16:11:29 +0000
Message-ID: <20180319161117.17833-4-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:cZ8ZkacPkrbWW+DMQkFhG9y6MILqEHWVErN4jRJL0+jRJdOaRbJ+ugNXdOE4IJFfMYWtWEbBVSFvTkZr5zXkGS/P27/4/v+MsS4AnUt59+Tx7UPFPqPqfMlOmhzusqp4bspEgHzYn7vcyi/Rrcst3Cep0Lzs7ayRJ6BQnW65SOMSZldsOsDlZ+gemTVxusH/M5o6YLAma+HiS6YjW/jCS7o0KMTvO/xFO9S3t1vdlojbw0/AAo3YpcG6dLgLgJfV;20:6HzWr8+UZAgngagiH43LP1rHb0sXu4ElFcsXzZ36tMjvxI/f2TOagdeivKrHnna21t0CEEJuAvZQdwRB7Uo+OaNuqn5+fnObxMuvMx0dK8qn3sgQ4b6JMTK3LJD6IwVUttUc1GFYhcsa3+Dc+SyXx756eBYfiavPPoY9XklW4Sk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82b515a4-07d5-4adb-e698-08d58db41418
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08057EED43DC9FA205C082B5FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(966005)(316002)(54906003)(4326008)(6306002)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 91GK6mCr50fP24goMeWGchdz+D4hlo9jabBhlGwHWW/xx7+9bWtGpBFI/kKj4L0GYiHaR4BNQ/UG7gV225GDzHBXDT4RwwFmDf9Srv1If+m5upwuSU2eX+y6TagaSAMJ0tkQLIM1hYxw6XrwfkDf8WaSrAm9kGjsEbk46pvWdwGqv7VL+4AoFkVS3ZOQoXJl+I+DP8y1cD7pVGXPmqRQ61Kfc9Pk+N/VbNOE9w6H8rzinBaSQuaS1jqT27IMn2DyakTBBexwOP4vOYP+aMLLV0Qo7DZ356PG3bHGq13XAzedMN0dyr9lkt27xX4/gk1jQJ6S3tsi2t7JlKzXwzb1TQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b515a4-07d5-4adb-e698-08d58db41418
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:29.4175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit f8860ce836f2d502b07ef99559707fe55d90f5bc ]

If ieee80211_hw_restart() is called during authentication, the
authentication process will continue, causing the driver to be called
in a wrong state.  This ultimately causes an oops in the iwlwifi
driver (at least).

This fixes bugzilla 195299 partly.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D195299
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/mlme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b13634c677f1..156e8e13ffed 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3995,6 +3995,10 @@ static int ieee80211_prep_connection(struct ieee8021=
1_sub_if_data *sdata,
 	if (WARN_ON(!ifmgd->auth_data && !ifmgd->assoc_data))
 		return -EINVAL;
=20
+	/* If a reconfig is happening, bail out */
+	if (local->in_reconfig)
+		return -EBUSY;
+
 	if (assoc) {
 		rcu_read_lock();
 		have_sta =3D sta_info_get(sdata, cbss->bssid);
--=20
2.14.1
