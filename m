Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482689-2-2665856066498682491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482688; b=YjQ6SLICgdhRVMKfpa0FgWZtRkBNiNPWedOcGkTB1qT2hUF
    YogC69Y3yHXUAPYUNwEnFjV6ov5mMFSy1umf0+0+w3JzJira6KRwmmG1soaiFv4U
    D/B7hO4XRe8Sv5piBOKTexyBr+CjoAINJTkafSZkbROcGmTHgs3zlWFG4TTo3VM+
    2YNQapeUi877AtQDh2tbzxKWYOtyK6Z3a2mW3lZDX6S+kxGFQEDu3/6w5jhvwFsP
    mkX4qphqGIL+V0snCuAwt+dyRSl+Dws46YxKqyLNARrXZpvTysudDZGbRDbvyUo7
    7gbKa0Rjju5os/Y+HP7JCD6BKQKvPkHoX8bUyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482688; bh=2q3iJF
    wdgb8G7Te2e1mbH5/cI+WED9TpWwicyYxAK+Y=; b=f80RRmFxgXndHxMLwygOC0
    UDOna6WVuz8OTYmmeox2K2Ro3RsVAF9noeGbsT/qMFvjF/eN6SNycdjdnFC44ff9
    tp31/fVNf600zOPprRKSUG+t+wc7wDE95tyF/CqtuhmIqTiJ8Z+nyUHmRTTrKdgW
    uoRzcyOlHVIEfdNZKDcHmsV2HIhfk5IYXpD+LJc7yNGf+hS7ERX0ataizoUcNX14
    kuIknT+bC1Ge4HL/ZRGecB/It8s08psoAChzea/UsJ8gEyWTG1XIGmdP23yxLyD+
    4WYb/X1g5FARYoCYqD60wZISRM2gWf+7db7r/QTs7O8ts8D8rj53uYfEGV9poSCg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TjhDuXil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvuddunecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TjhDuXil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvuddunecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967817AbeCSSEm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:04:42 -0400
Received: from mail-co1nam03on0096.outbound.protection.outlook.com ([104.47.40.96]:50816
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935026AbeCSQDu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 182/281] perf trace: Add mmap alias for s390
Thread-Topic: [PATCH AUTOSEL for 4.9 182/281] perf trace: Add mmap alias for
 s390
Thread-Index: AQHTv5uKqxsRsmw8UEGhNKqbgxX/BQ==
Date: Mon, 19 Mar 2018 16:01:28 +0000
Message-ID: <20180319155742.13731-182-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:smayR31seTLqfiwNIypXQIhyVM8M/2aBe8Oh0eMAMJmSKJBTV66ql221pzl6PLx0nxcnjhzDItZQbzixCha/NAAjydHzdQVPf6wEYsJXQ2gPIPrD4Bn0s5J6tgkkPrVo+RQ43y1MxKxC2GywUaXoTfItTW3AshNKvQPDWUwRk7gq8wq8PR2n1HYny1V+iqDt+Hv8smy6YMw10sGXkBOljnMKhM4DAcnJTOP06pGGIWdHBfcmf4mF5l54Rya9rg9q;20:RrnVnE62v4Szo+VmHKzfbz8uZtpKrXXWwn0Ksve/ivrvipLfFKcwJABtu/rVXgRFp+ShvtmwNn+M5RdzE4DxhQs1DJOiz+H/SlXXxP0mRx0NGZhgUq9IblmGZT1jGNWBnuzPObglTrGWxEIPlnos/8wP9DW0IyuYiK1TdrrbXwk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88e16091-87d7-4289-5bc8-08d58db2ff96
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10942E3D87709B91BDC6FB11FBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(105586002)(8936002)(6486002)(3846002)(6116002)(3660700001)(86612001)(68736007)(7736002)(316002)(1076002)(305945005)(36756003)(6436002)(2501003)(39060400002)(14454004)(99286004)(76176011)(4326008)(5250100002)(86362001)(81156014)(81166006)(25786009)(8676002)(966005)(6666003)(54906003)(2906002)(10090500001)(186003)(2900100001)(2950100002)(10290500003)(106356001)(3280700002)(110136005)(22452003)(478600001)(6306002)(102836004)(53936002)(6506007)(6512007)(5660300001)(26005)(97736004)(66066001)(107886003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0tMToPat7xft1x+Cw4pCfLZ2PphNsc1SKow0IUfNA7bvRgaXfQbEBBAAJZzUP+9/XvgKolBt3UfSrbo9nPmx9MY/4nhfFUZX103cRUcx9Rk9ES+d9VljSB6WiTgShU+t43gATNCcz8mJWE4LZI3ShhM00pw4IE8gxMI84Q21JqAtyznhYs5ArlA3k5Glj9U/R3g4bP7RmHwnAH6CmEF793rNM9ouC0kQ0bDtxL9UaF3TLv1P12xHV2h8SRpleqlilT7t/uJlOUx/lX/E1MKNUXJRNzgwvXMCiCXF/zjg4qk5iqDHmYwenydOoOZtreg5nLEqZ//CM+OsnyFp0i/3pg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e16091-87d7-4289-5bc8-08d58db2ff96
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:28.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 54265664c15a68905d8d67d19205e9a767636434 ]

The s390 architecture maps sys_mmap (nr 90) into sys_old_mmap.  For this
reason perf trace can't find the proper syscall event to get args format
from and displays it wrongly as 'continued'.

To fix that fill the "alias" field with "old_mmap" for trace's mmap record
to get the correct translation.

Before:
     0.042 ( 0.011 ms): vest/43052 fstat(statbuf: 0x3ffff89fd90            =
    ) =3D 0
     0.042 ( 0.028 ms): vest/43052  ... [continued]: mmap()) =3D 0x3fffd6e2=
000
     0.072 ( 0.025 ms): vest/43052 read(buf: 0x3fffd6e2000, count: 4096    =
    ) =3D 6

After:
     0.045 ( 0.011 ms): fstat(statbuf: 0x3ffff8a0930                       =
    ) =3D 0
     0.057 ( 0.018 ms): mmap(arg: 0x3ffff8a0858                            =
    ) =3D 0x3fffd14a000
     0.076 ( 0.025 ms): read(buf: 0x3fffd14a000, count: 4096               =
    ) =3D 6

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170531113557.19175-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 21f8a81797a0..bd7862a38c23 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -679,6 +679,10 @@ static struct syscall_fmt {
 	{ .name	    =3D "mlockall",   .errmsg =3D true,
 	  .arg_scnprintf =3D { [0] =3D SCA_HEX, /* addr */ }, },
 	{ .name	    =3D "mmap",	    .hexret =3D true,
+/* The standard mmap maps to old_mmap on s390x */
+#if defined(__s390x__)
+	.alias =3D "old_mmap",
+#endif
 	  .arg_scnprintf =3D { [0] =3D SCA_HEX,	  /* addr */
 			     [2] =3D SCA_MMAP_PROT, /* prot */
 			     [3] =3D SCA_MMAP_FLAGS, /* flags */ }, },
--=20
2.14.1
