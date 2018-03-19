Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478714-5-5208462031123745699
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
    t=1521478713; b=rANj7z9uLpMb7WJdnfqShJ+WiYs87VrzGMOuc3N01ul7h/j
    GEo9cqSmoFCOVjumePzwQDoiiJKzoOOfuxoWsiHU6DJE4qy496BW0Aawpgpg0pBa
    BuLp00VPpCcZ/gfGPY1x9rWAVj8GGUDlCep0JxJnM/P1dDMDcxFbBugYwm/9wWGg
    Ldd7hb5NO5iJw/np1rE6kTZ8v4cK6k36oa1gfOQ/mdZSirNAQnAz4W5nRrmcYcWW
    RB/mi3uYY6cL0Tl529fsZXF8oN0gm3L6DWlcGWYMCSCwjKNHXnWwqsVt1mz6DNsO
    /rg7v9WPmDZ72Ooai12hfJgwqIf9s5LNGWGBLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478713; bh=JC4Fzm
    /jLa3D8l+EzVsvIZtHGDxx2r9iaJbw23hGVe0=; b=GazojfC+q8YK/hkpXBtyrc
    iavddW6soiiJLbYzGRRQaJkh21Ni4StH5X5icr7m9w0/1fisgaPdW3WbClhsSa1E
    DqEmyaALTBWms1kxxiOtRSfzImJ7ZNb3x+vZPrZIuItpZuiysI5kyU+S7ApTSX0u
    lTQucPz8ntv5OQFTEIxwyj1FSP3B/OqWYwfigXlKYbALLCmRd3a/uMg1h9RkNveP
    lVuChgyoQVND96KA6XqZO3E+wXpoqqPPtsHPJWj4/xFxIXk1GVO+dXmQCGvmvv9R
    KKb4KvfWrBZWxIGQxcmbEitIz/yeUxP3/4evMIFmfntOKICvpejTpyVHGYZZ0fqw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LJoU+uWl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieejkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LJoU+uWl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieejkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966536AbeCSQ4V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:56:21 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:3838
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966430AbeCSQLe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:34 -0400
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
Subject: [PATCH AUTOSEL for 4.4 164/167] perf tools: Fix copyfile_offset
 update of output offset
Thread-Topic: [PATCH AUTOSEL for 4.4 164/167] perf tools: Fix copyfile_offset
 update of output offset
Thread-Index: AQHTv5yRM5VKdpyKWE2npXMiMjzUVw==
Date: Mon, 19 Mar 2018 16:08:49 +0000
Message-ID: <20180319160513.16384-164-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:5ePcS8e6EZT4AVHPzlnSxsK+rfPKIMVwhwXXckRq/FE8kFRUXDfqlZ15baDs3IwD/+nscpl9/mBWI3VTQDdJmVGog+KNgnEEx6v9hrQITl6kK+dyxmbCWPa+Yyvt823+YD9IvbWwBPGH0VzLYbwjnGfPemhwK4vKeFJ46PNjLdAadDopTCGL+7Pk4yyBoebqSpMhgc7jyqhpJY3cSPJDHEBaOKXpSQDWzIl85kIE+5Mw2Z67INXhh0rQx1wnyuQQ;20:HlwoSkyPTP2OckTTJ3lViii114gNNrsJkQTljaHYZHTsZm0BRRMS2nEsEywVzKqSRRPpNKZpx56XWXhFUFJhF780ZcWltuQzzwpgDJP5rt/FAs1T/jlfG+bHB7YWogX0tJrYcFdVvvhGpqnVpbDWIecBYLE6aeDKVX7CBuMUUK8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4176cbe-4528-485d-4edb-08d58db411ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080529E780108AE66A29A499FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(39060400002)(2501003)(5250100002)(53936002)(3280700002)(966005)(316002)(54906003)(4326008)(6306002)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Rh0NSULSy2rHSjakY2GKrWSU2dArc5gwISCNGCQPPLvhe9ofZirveC+b/X+J9CCYOUnkpBrt7dYWt7Nx2TB4fhIOW0Ud0PdC+Vz6KIvAV2WM+adSKuAtR/AHPLM6LKZFfJuvZkz75Dq1QDhgizEVGVHXkH6iPZFhrKgu4/PVtKSQ74g4/USNGKXJEBZ4UkYnDPlFKfngihybx0RSgLNlriczSh2SL4hvjfyih2il6qUD4YHjRPqiqc3fBjYjdshSTtOQ7PMNWRP0MXbUTBhQG+2E6EuY+4AhAJdlFUDMjIbRRJeuzGuoNlqgNytalQKKbZxQ9jpyuRY9nqdw1FfL2A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4176cbe-4528-485d-4edb-08d58db411ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:49.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 47b1e36c7ea0..9adc9af8b048 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -162,7 +162,7 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, lo=
ff_t off_out, u64 size)
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
