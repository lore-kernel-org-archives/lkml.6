Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474786-5-15674654849896992324
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
    t=1521474785; b=oYzHp34dFL+ZI0N+ciyGCOQ6kbPyTG4G9sgxMby5Qm31CRp
    AekiT8BbNBOIDXaFZpVkXtBt2aiL+2x6izuAJ3vmellG5+nTK6dISvH4qzGFkiE2
    kf3dZuEoRgI3txNyaEXoJCx0vUFuy75mfCamX7bMiM7f3l1OW/3739TwfIOJmQgI
    i5tDNdP2m82DmMYt1XZApvuJYmA73oksvEZ4nBW9hJILYKWg/eu4HT6n2gYKgAnl
    n9MkpltXQQ2VbiUd7N11X6P/WjrHm2xp843WCTsHvuJEgD9Ij1Dm1SlRhREDoHWr
    CVmdmisKs/G1ibuKyAXkvpnknKjdke4qEuuijsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474785; bh=c/g/XT
    zwtK+vkaTDK2Fbcbb2BGmaxVvdjkOSyCkJILg=; b=nSPVzwjWVv5Zvee8qTX0hL
    yfBtcDj7ikLFdjEgi9Jxfj1CSgC6eyrxUcZkuPyWS03i+cR650HFcMeAsmJMlUEc
    qRMLYKy1Mj6E7I3Jn/4njUehO4oNzH9acNyDDJjojI2ua+FBTUcOmebe/vlTqel2
    7rp8F2h+J1P+wzhnYKH92yzqOO7xROW6VK5yu9AS1hxLjNf9RnLo2IzK2yWuVUIC
    a4rtzPKMsMdOSyrCE9AQ7Jc59UeIF1vn78MT+HUXxZbjKuLcHAaLjcF1P1cN7bwd
    WdzQRxvLLme2qy82DOn7GT50euc6pDR6GdAgGlffEEXuxrb2TRlwdbLT0mkLNYiA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N/Qn2e1z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieekudenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N/Qn2e1z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieekudenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934079AbeCSPxD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:53:03 -0400
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:57771
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934075AbeCSPuR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 117/124] perf tools: Fix copyfile_offset
 update of output offset
Thread-Topic: [PATCH AUTOSEL for 4.15 117/124] perf tools: Fix copyfile_offset
 update of output offset
Thread-Index: AQHTv5nTbHKKsryms0eLaTrAmNk10Q==
Date: Mon, 19 Mar 2018 15:49:13 +0000
Message-ID: <20180319154645.11350-117-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:yZTattNsLoWhEQDgCRHiScdxOnHufsscztP3b2ymPTQ+4IiGCuvO9Ak+lIFSrs/vZLU+wEyCNfmSSCSsUYrrXeuDHFIMITbih7+FosSD474JYUmsloR41jGhdxPVFjp6ejFDkLdafC+KxzmGfqFQpPBmQYeim9hrfxNk9N79fxTbDanD48t2d5MzPBySGJxOk4CBXNo/ln2tVbZuoPlzARdT6MnYD6inIxW3khPaxJVFwUy1XdSzrgZjR/wwlrIg;20:afKqco97LHn+CkEOoId4XD1e+8YzEYTwMO/ewdzdh5xmHx3L3hsRT9BeV1VfvyexEpUKAcADAFjH5qqmWlyFR/OgT7ww6Kb2OADxs7FcO6CifAe4ZCYnouPHcc19x3JaGf+2iKaz06NIBNyYAZ87vShyV/UF0t1Xg26YCN+zUXA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb8d2afb-fc7c-4e45-8958-08d58db115b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109D0AE5EC13AFA05C3754BFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(966005)(76176011)(66066001)(6512007)(39060400002)(6306002)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: uWzxf1ApvUICyrm6fv04y0u1IYECnnDs4FKP7uGkqkVEhxUJ9FIaxI2f1wtTQBDopG4ltu0gMGA5bKn4p/Gbm0VzqNCTeuDrz1XKu4oKtkAA6jaDqp8lCCGkdDh1GChp627eQDQLUXqjhK7+EpKiQNLzSM4KuwwWqcsD488iYnpGjIJsjglotX9na0o9/ZvoIUZzEJ3EWQgpQGjz0mVb8kbm5w/X9YC7iyKsoVCL3y5/fYsylgHC2NLPXIFSRRD2A/TEpLpNCUf8djC0CfbQ5eq8MuTVxescpJS5Omu0VGnyAYmTtrVT3Y+MaDEPDzVEOX2+EIE68gtsh8VKbDbBYQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8d2afb-fc7c-4e45-8958-08d58db115b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:13.2679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit fa1195ccc0af2d121abe0fe266a1caee8c265eea ]

We need to increase output offset in each iteration, not decrease it as
we currently do.

I guess we were lucky to finish in most cases in first iteration, so the
bug never showed. However it shows a lot when working with big (~4GB)
size data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 9c9f5a2f1944 ("perf tools: Introduce copyfile_offset() function")
Link: http://lkml.kernel.org/r/20180109133923.25406-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index a789f952b3e9..443892dabedb 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -210,7 +210,7 @@ static int copyfile_offset(int ifd, loff_t off_in, int =
ofd, loff_t off_out, u64
=20
 		size -=3D ret;
 		off_in +=3D ret;
-		off_out -=3D ret;
+		off_out +=3D ret;
 	}
 	munmap(ptr, off_in + size);
=20
--=20
2.14.1
