Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480954-2-4864840438180712629
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
    t=1521480954; b=SNokyTHCQ8tTt2oOcB8nw89PQMw6w/UjkJ/mNSmlF1Auw95
    cGn/EE9xfoILzQxmGSiyZbNddn/pJ5dLhnLhQFWGEQCjPpar6FEWFbQPlWxyl77z
    T/94aB7FQvoxWgVxLp1L2S1bP0KYFvgdb05QKKEPyFbz4g+0OaTXFZ6Jm95BpsQr
    gmet1+pw2e3KobWJHVzpL2SWLhA/AwvyxMVbgBOxwAYwNgt5pgjYPJVHsZwSrqR/
    rRGQHwwvr+Gj6NWdTxNxY8OQJdq5KsdkydpF65QpXABBgdkxV5u1IAfk+IyUIAmq
    6Dx4L6lCm489kSkjmq9r4qld7cpKD3rNn3J/n1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480954; bh=HOqQMo
    CDGUkRLGfcZ3TDDT+L1ooU2xe4c74+zNQRG/M=; b=kisV6BAHrmawRCShNmbjTM
    +d7mL6AoTH3hjOnph5ybcyAGykMO7wanUXhnbmxEWb1c2VnBVU0TqlMFJeToLj/j
    OVG1K4EyJPC0khI5yQvR6zTJkmOOdR9U8W7HNV4e9lADTIdkqIV3vxh2VREwI3b4
    lM+raqKd3z2uwKalSL9VbrkH3SE0oAVpC6Zsnq+umfz4V2I0LZI7k++s6bgnHH9B
    OS/AAc59EZOfAwIfEzdDnrQu6eWDXewiyME8HcKgxW2PWks4QNXspZEy8yzUVj45
    UaPQJd5gvRhId4MzHJ+rwbK7yP2fAUuVq7ubKfFpESkZeVpiGWsaThwudHJrwFhQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XwqIV0lP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvjedunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XwqIV0lP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvjedunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966009AbeCSRfw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:35:52 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966026AbeCSQGr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 008/167] mac80211: bail out from
 prep_connection() if a reconfig is ongoing
Thread-Topic: [PATCH AUTOSEL for 4.4 008/167] mac80211: bail out from
 prep_connection() if a reconfig is ongoing
Thread-Index: AQHTv5wa5e0irY9KvUqzQ0nSdVKJHw==
Date: Mon, 19 Mar 2018 16:05:29 +0000
Message-ID: <20180319160513.16384-8-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:6Wyv5Tqbkhdwn8vRXvjJVpiaYjEcSbMcSoPC7FdmSplrDT5N0Z+9G8eJTvlHIfOb0mlpT4uawMJIqeqXD+x84XTOS5dfGsD1mNNICv/b1hJh2nf9mBX6EAP+N/g0+hptxGSIOJuvjZgN+LS7W/jljsGA61na6hu0ABvP5N0I2wReZU6xsd0GN2Czve7pIzbqBHWXN8UduLJfv5blS+kxvNB7qWWPssXNNV27MOUYHu8vb35mz2fts3bWFYDMZn/F;20:s57YktQ0RB0BQuSkvbGlTcv6ybJwj9BEDjp4eGVf9f/2WUUxCGCYuhdqvDk0P+ZjQVquK992CaZ0WUDm0zayjCH2TYYEGcZE89IdkF19NAyw1xzPl7ZwkJkE3b4awj3p/tbwD4DjR93njdaUG89xM1iP+VSK4m0oEcU7T8DGX4g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49352736-b728-4f63-1612-08d58db3684b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920BDE1668229D5647E4A41FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(966005)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(6306002)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /BbVsFyRY7FRnYh9dzYk3pdCU6NSPH501zCxKhVg4o3So/HQNn1EGJEGqBuSwCNLXgDJ5U160mDJqkzZKtdL1e3BqYrulSbNUC6azayIXpgUb3MIG44n/zPbv8p9xD3Q3TMw7NFKUTGMCgZRwcYQirRfi2as5JulEckCY9IcwbH68AmuAiYnODWGJXM6s63uho1kTIX4dASdRwcdccGDWzMzEggzValBEFGeteFMMgqgnZOw4YoeGdomt43RN379U8UqWCMHI4jhD7UDQVeKtFFYZJYBjowiDrCrAnlzKfDbMORanynRuyWsaq9TkEA65S6BvRUxrB482i4YAYu4/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49352736-b728-4f63-1612-08d58db3684b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:29.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 23095d5e0199..005cd8796505 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4326,6 +4326,10 @@ static int ieee80211_prep_connection(struct ieee8021=
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
