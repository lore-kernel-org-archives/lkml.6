Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481837-2-14885851133308548622
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
    t=1521481836; b=h2RFZITAPwfYkUEvihQ+ZLzdCOI/3Y4FKocUXlK/v6jVeOo
    ZORu168EuS51n8HgJuJ2ZBv1vGxm26o3Tbe+BI0EwM/eUfr57kuNy54Iqb6IFYNi
    LqNbsabvFvV15XES88ZC/Ny0ttxsnnUFRFjiqx7aTyZ5denrlTXjMcMzDR1CS3s2
    qdGpjbpzgLJZf0FzQ7upz2WZuv/gcsBVeZ6RSIrxrh5ADRP8qxHcTXWnqbS2Umgf
    fn6mZREeBiqYcVLQT6cV59zhrGA0enCy5cY5Mik/lIMvWwRC11WEScalhKPSWRbF
    xQN8KwZFSRWBwU+xtFFnp5CppKySO3xyMkzh2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481836; bh=D9caQn
    TRZfd85DEkYWolTwBKklkQVWMF67844zbnq0o=; b=uTVElWv0u3/A8S0y6RFp/n
    y5dgsjwV3hzgneF1k8CfAU3Pw0Laa8p7pknTFv8pPfF2ESaxfEtEcX1ozn9fLxqV
    XIaJE5/2KSBO9Ek16qYLpBT843mbBxI1xEqt10tKePdLZWjZfP7cefQqsUHZEmOL
    uJ2aqhjJRDQvSuOTHizqPXAmJSHVMaJgdZ1D4+9x1lThXdEs/8gpXppbqoptuDRU
    2BtrOcqWjZKIwgYdyYGaYqK4s3FYJLcQo8zx2YzOPSFHXeRlydwVgnLMZK6/Eefy
    mazlRn2bBm4ietcw1FqFz87EEKkNGvwcMD/SJoB19aE5R27NryVsmeywWilComDQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cLf3sKqP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejkeeknecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cLf3sKqP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejkeeknecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeCSRuC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:50:02 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45241
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965734AbeCSQFB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 229/281] perf tools: Decompress kernel module
 when reading DSO data
Thread-Topic: [PATCH AUTOSEL for 4.9 229/281] perf tools: Decompress kernel
 module when reading DSO data
Thread-Index: AQHTv5usgdtXWIM68ESgB+cykhcHmQ==
Date: Mon, 19 Mar 2018 16:02:25 +0000
Message-ID: <20180319155742.13731-229-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:TgdslkR70ZsFzvZAJ0Ikm8SHqQEty84R3XpFmNWsumMInH0n+G9AQRgKVOSqef8RQWXzNk81kUvojOdTvCdykhLBrvV8yDDtJ/wOVPnLZbmNUmrR/Ico/NO9WJQ9Ct7U/uUm4siE+YuoNx8MdsNrXRXyy9ph95dCaVc7rVBulk+zk5gxMmXpvsJj88kfoHajfbizo5U9MUMR3wp7ctOkAt2G2C/rpcGOEekFIxPXQegZi6ix0+QIC+giiVxfSf20;20:g9Q6aYVJViLbbRnelj+y4gwnSAFsO2nA9mtsXKuGpALjiKQxJV3peyFs534lz9UTJRt/6Bvo5idJJOUiLrO/r3xqbMY4hqE/00TbD5NCeG0pRLmvSSsU50mLVENHpCQPkwfHZkF18qxuLG3a+KtFkq5BJY6q50Q+YrvCEQ/hXSo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad90d2b4-a62a-4c38-7e10-08d58db32523
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885BC0AA99B0BA0050E0C0FFBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(39060400002)(8936002)(99286004)(3846002)(107886003)(2900100001)(6306002)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(966005)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zdqe/z1jyY6QwfmxbUs50+sX3XJjNFQycRnqk35/8LIxi8praYHTMUFruBWjYI/g+ars+JEQ84wlS6opCsRNKGe0cTqP3qbLe1y3PvhhG9zzKM9u7rcuydrULXXpPybepLW1iWUtb9CgPbFttplJx2Dz2kL1nWyqD5/oZR1yqWdNfaprppLXKlRTv/BL5XZgFwl6b5Oorahiqukj0vnMCzzYB4K7M6UfdJ7y4s2dh4p+SsnByUtThD1L7SB4RzqTVtMVyzopveR0BcL+cHK/Wf5gdSZ8VxKzB72t/Iu302IvPjd+ZC8DxSD7MkwoQCdraQF0VXWYoCvCZ2qG+HZa5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad90d2b4-a62a-4c38-7e10-08d58db32523
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:25.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 1d6b3c9ba756a5134fd7ad1959acac776d17404b ]

Currently perf decompresses kernel modules when loading the symbol table
but it missed to do it when reading raw data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170608073109.30699-6-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/dso.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d2c6cdd9d42b..4bc58822416c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -366,7 +366,23 @@ static int __open_dso(struct dso *dso, struct machine =
*machine)
 	if (!is_regular_file(name))
 		return -EINVAL;
=20
+	if (dso__needs_decompress(dso)) {
+		char newpath[KMOD_DECOMP_LEN];
+		size_t len =3D sizeof(newpath);
+
+		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
+			free(name);
+			return -dso->load_errno;
+		}
+
+		strcpy(name, newpath);
+	}
+
 	fd =3D do_open(name);
+
+	if (dso__needs_decompress(dso))
+		unlink(name);
+
 	free(name);
 	return fd;
 }
--=20
2.14.1
