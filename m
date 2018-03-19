Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481149-2-17721421288164500880
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
    t=1521481148; b=wlQmfNU3/x9Z/gyuUCRPB4payCCVJFRIOw1zUE7JXBeF0e6
    QgZd+YBgWIgs3mV/w1d3L8ksf6vhxW8TYzT6W5lX+EjhsrV9tvtbDZXJXTqnmZvB
    CKkHPlSZurecSXDNkVJ5iue6ARKZ/+ZH74NdeAo4yXv6653wTiaCsBZ5QfBNOmRd
    e2rTgGB6RN81ULDoIlCLuNreSNCqWmNFifHWyv7jLJhxEa8cjbD+Wl/NNhsWJcIO
    7g//7fX1Qy3aKXH6gq0qpyDacNm600B3kU35LoHtTbU7baY0bGoBpryLiFte2m8C
    n2EqrNF9t9WgWffgbA1SJPrPjWKz/slyCtPvWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481148; bh=5L5zyW
    8QHuFmPRi8RmA1xEbCW2emPFrPRr9hxnnLFEI=; b=JAWHvcmCMNpCvbpxa9Pu65
    YrXcR9uxpKKp5lpiW+7UgTUf67U38jrLdEsMHdJbPM06e587BvOcd2GAPVkyOPAr
    Z6UAWMBbXAYYZyLRHpKQkMVDz0QOK30DGCU40ibZJ6aJeFU+cd9u4j20yMjz5D3Q
    2nu8h28xrmBcUvNiwUEnc1EDBv8QRGXkmvCP1iGmmWyva/emAV1AFEQWhwcvB9tr
    /3rOVFa2A4vnj4wAjS18Hyzz/orYS0DptwVMOhPtpQKbfQ+RzT/zkqtJ4tzMiK+t
    JYY2Jsyk25i19dXxi/eGnjAsWkTGrIPhr3uVntQHsWyUu98NQfVHo9V1dKDdHSvw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PVSixUSE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeijeelnecuvehluhhsthgvrhfuihiivgeple;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PVSixUSE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeijeelnecuvehluhhsthgvrhfuihiivgeple;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965964AbeCSRiz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:38:55 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:13968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965958AbeCSQGk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:40 -0400
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
Subject: [PATCH AUTOSEL for 4.9 276/281] perf tools: Fix copyfile_offset
 update of output offset
Thread-Topic: [PATCH AUTOSEL for 4.9 276/281] perf tools: Fix copyfile_offset
 update of output offset
Thread-Index: AQHTv5vOyAl5+5x+zUeYOxzIWkY+jQ==
Date: Mon, 19 Mar 2018 16:03:22 +0000
Message-ID: <20180319155742.13731-276-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:1glN4xuVUPBxeq1yIUu8KzzHH6q/EHqNTs3fxUiUOFS2FxAxAko28t+HqfgdvVdSyJkPs4E53ugwIa8TpgvV+KBRwV3pWH1J0XFYtHWZeOxnd2MouN/Hx4nMj21RWSZ2fb7hWjmmADAbFWiJDt2SjIRvqnawYecYtbvkvJ5LhnGwUCPKtaHo56XC3/kYvTkvd9jaEVAQK3EIRtHdKMoO/obTR1cBr212ewHhf8poJrbjYQsu4OSVumJU52wPUDam;20:Gq9V8henYYYIQflmjB2JpmLr6aQyh5RHgXavEfUjtGzTAxSSgJxlG4FPjTpmVR3LVJCaMGUHHrEYbJuGES7b7arrfLWrRvCJkXiYneVl9W/Y0tZoaYdQh9Md4xVMIx7eecNz2RTE9L1y21iuYIETMAFOcPm3nfGkijB1ShFEOQg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a54a44f2-8cfe-496b-c517-08d58db363e8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728533B7CC3547874CC5512FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(575784001)(478600001)(53936002)(107886003)(966005)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(6306002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(39060400002)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YzKP0NGdVyrkbg7Joh9MYQcEvGUQzKN+UcbcPVoCZVKLHKDY+3QfE3Op+gbTIACNxLt7+FSzdhzOSE8T1e9bWBdzT6N8omCGhe7Y7+1lD5Mcq8tqF6A3kYE1/AjFvzCrx0yZ9pmAjVMNzc0y/Te0NEmAe1dhDHeT1LEe1S95Rzj0YX1yQ/KlWerihOz0HQYZiMe0RMGVrFF3I3EFWWUAa4Uib8cMOkRIOxkjnQNW5M29ibSd6y8BqrJG7yzE3cGreeiHjRpSINGqUY0Vie6VTuyTFaY/qHd5EtiGm3GhzkhRR9SaX5+Ko/vUavHphIsYxwJeJSVi0A2AVnokvhBZUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54a44f2-8cfe-496b-c517-08d58db363e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:22.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index 85c56800f17a..dfb010bd29f2 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -207,7 +207,7 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, lo=
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
