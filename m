Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496130-2-17606006762101753971
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
    t=1521496129; b=QSB8LIjN3htPYrwOfn0Ezj0QaaE+ZKrA7VMA87pzMBp1A26
    1Y+O9iM6PC2WYJFLyHGtjia8NWl/qctJGat8Wt0zra89yw29+bhs1KeBCxVptUvz
    5YkDVf21sFzzh4scTOb7ZVeJngB/4lbEGe3nY7FTx6UsggSO2UrFawnVn1QC7Z9g
    4+Ie7+tripND103PgBbGrCq6tFtK0oLwHHwdEmc2euflw29m72R8Oz34xEmAOkt4
    TshLMHEewgEbk1FUnVtZ3K8jAXez2oXjif9UBKy9/hbRGDV7wVSqCbYLhWfB49Wk
    1saUU4VP8qf6+ABS60W6XnduuvzoEOKAWCJlw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496129; bh=7r3blg
    iumllab9dm6L2zLJShrx4JCiG2Rn96m73BKls=; b=qc+VAVRYL82GIVmLXaYOhV
    jPTa9uwqSo15rOKzw9G8grTlRbWxloM2TJ4l5Ta8X1kATyxlC0LF9EsbZxDuGwtZ
    w9dUZR7qWcwgWo6s8KRhFVbAAc36bPibR0ioFFDLBGSUq0ZE1UwSBSHkh2ikmuxs
    ytcy4VLCoTmfprUrsludszs5Ez1+hv+zkayHP3lZv0luHB5Y5Iwn1t+57TdudHp+
    tVhSH5Wn/Ap81X1jxtZOlF0hx0obpIrbulCtNHUCycc9Rc3QgrntT+5Swr3hVzph
    TnOv4F4gJRCBKdIvrENCxAmXlitt07Y4tUyujfRnALbCh3mKmjWZZs7o01PvkQlw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kwF3ZHqr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kwF3ZHqr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934878AbeCSVsq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:48:46 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:13408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934651AbeCSP6N (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 013/281] mac80211: bail out from
 prep_connection() if a reconfig is ongoing
Thread-Topic: [PATCH AUTOSEL for 4.9 013/281] mac80211: bail out from
 prep_connection() if a reconfig is ongoing
Thread-Index: AQHTv5sRTxNWtg01MkKQXzR9lZQZig==
Date: Mon, 19 Mar 2018 15:58:05 +0000
Message-ID: <20180319155742.13731-13-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:2zcG71JIKqRUH5CUgLY/t8HvPznalw9bglSJX6XUgEZ1KVEKHWqDrVaynaH2X6slc55S/KzEpETvm7tlNSJadGU50CVCa01P77GpJZ+BmUXWweqp8bMRDMHDEkLr9IWwWngKx5mqKJrAwglpHkPXAnEYOxlRtxEkKIgah0L+Bzu6LGlpuWCZ9NJEgvSrB7opW3RpbhcG80mvOcC6XeMQWJPBilcDuyIwgXuzRKSWq6ew/G+KY6o6ZM/sZKJimhZU;20:0M8Oq5fa36trVFPmc1GpmRmFkjfryZC+By4GFmktRNleV3dOrsUiJi332GQk8yEF6/MXA50mlKSwKx6DTuPb0hrTZb8LkgAuBklI56nnl1gd3TF8juvckGdUzsURoqK76EEuAStyA0VKhgQl8LfYei81C4mJUtZpJ6lvJL79A/k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fab430c0-274c-447f-01a2-08d58db233c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB093393A2C762E93C29DA96D2FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(966005)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(6306002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: daEgySGB46SVAALMrbM3qsdocCLN+GFoTW3aBW31fo8Elrj5oHeECOcKSrDQf3N6UH0uDdVB7+BIiJzbtN7K/jgVUi1eD/1gfUJBsvVoEBEXAp2d3swWjhG4xYpU5P+cpEt19r8elvTLc1vwZ2uJ16UC0/x5J3kVPMpoobSNf60awKXy61aJbdAfBMOExIUjLAwLW2f908RtiOQXEy9LwBKATMqYMgrAV/7JS3eLZEeQrG67Is+Gh7VvFD1UfBkneDQkS5Pd6XRQ0tezRuJORvpTIbX0/38WatoxoIJX9Z9riiKWuvoW0CvfkGs5YE5W2gH200PyKbzJOxmQFFOJ3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab430c0-274c-447f-01a2-08d58db233c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:05.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index 1118c61f835d..e471b273d0f1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4322,6 +4322,10 @@ static int ieee80211_prep_connection(struct ieee8021=
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
