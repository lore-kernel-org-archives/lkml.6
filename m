Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479396-2-6025300911767350278
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
    t=1521479396; b=CzEmKOgXELl5CPnaSxKCEFxiWFZegKxagfZccMq6bX+smxp
    DzKUjX2DTlQQvJtqKJW4UYr+o/nxqeyZvV0TKRVNsezc2cOiTs2BybjMjfSZOZg0
    UjLeijOzIZA2Tm7wjZDxgNnOIRxQ54+Mu9x4DJvyzV6fZmV+Bwchk1Xusv9oB1DE
    lreqnUXipN+yL2eX6wFdQw82XLZL3HJllj2rLYmh2+d4LyJPhyQsHI4xx/lLJcAe
    dkYlMGXmrf4Kdjsx6B3ZHUDd4kxJEADP38o64Pob5F9sC7Wju1hcPn0G7jYtFPbz
    zF4ZU2BPSsro1rbCSAhRnNUE+aCkXzyQLtu+Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479396; bh=HeJbPo
    jc2H+Lu/TuNMWB8NaKScmVD8k1fhgtDFtHzVA=; b=OQZG7LevPAeHSstFckXGiO
    FrxtQWM1JPdCQPjKbq08/tJUPZ6eYFFFR8OEQ7i2SMFbZHXhNgiurBo/ikJ4t2jx
    QgLLeVjszSVpt+qWDY0xkeQO5uJTHuY7x7Yf78z2bFF7Ya5SztvLiq/Z7naGXV5u
    ZZ91HijN8oVCHBkEhAWeePN4ViBeiNnaxijTBlwkBefq6Dxxv3p8dlBht4mXQbWO
    tzS7/11AtzVJYJUIq2DhqEzjjfUPnIE4wWWrTmmD1yaEpDDe/S3YOJswjRRIGi8L
    dqWXJU7KA8+/YgGPv5oJBs8pK28ZqqLbdxWjhh8VC6Hcfwo+RcTT1XLZk6symSBw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=diVBwdDp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvddtvdenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=diVBwdDp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvddtvdenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966153AbeCSRJx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:09:53 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:62326
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966637AbeCSQKm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 125/167] perf header: Set proper module name
 when build-id event found
Thread-Topic: [PATCH AUTOSEL for 4.4 125/167] perf header: Set proper module
 name when build-id event found
Thread-Index: AQHTv5xzVa/D7PZKRUCG8JdJ8RKr+Q==
Date: Mon, 19 Mar 2018 16:07:59 +0000
Message-ID: <20180319160513.16384-125-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:dqhRQdoX+S4pkqQ3+k6ScKMil6Gag5wxi+4w9ST/CuXKlFqaukv/OA/oYKdGkS8ss4C+VRJHMjbXFInDMoqX1MaDLVT6gNGTE8T3D6eYqUk6L8Cj0hyShVdeVhUD0y1mJZof6idEjnlvi7TaiTtXuPJmYfw1trvLGuxsYWuk2FJP8wTH1Aw256zNQQNi3AnVnSHBGW5X+s6kHVbKP8Hag7FBC62GQjPcFxOKF35ldaUDb0MpafOtzh8Y4JklIdqa;20:sV0y+b083UC5wO33RD2LNSeBLa9kbNvQiHEOsSjoJ/uQ2ltT/twEmwQKZZQzpvaKVZimwg8+dKL8IX+0Qi+6XWWMWQUv5zQe+1oFfga1sp/pyX2E1jCaJPQPI7lHpH76AhCliyE6OjYViqTOnyoa+7ozNsmv2fE89ZVhTLqbvZ8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b835ddb-44f6-4119-0694-08d58db3f30a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10452E51A3416380426ED783FBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(102836004)(8936002)(6512007)(7736002)(3280700002)(6306002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(39060400002)(4326008)(2906002)(14454004)(81166006)(316002)(966005)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: frDWmRWZY+JrvQm5feNPfrpaaNM9/4pzO1R2+FP6ZP3AiyusG9tVU0n6bqCMowRepO+u4S1jXNVwiq4AcBJC4em65pjQ8tG8xnGwqqVsmivWRViFukh3mr8OlZg+l4ae4A4F5Vcnr7lApB0FeFq3TJ5o3ypcNjUz8mfgS+aA8my/DOjXmyeEO4LFlmeKRH1UQn4PWaN3BTM630KPZLG3gB5YEbEa3Iv5PJrjs30hoxyKIzN3J7hEXipUs6DC5EisNKosIBkvviY3g6dMfWkG0+gq8NXQ4uOQUbsQKUOpO4JrsvSiQMgzLPseFbCODk1m7LXxjK0hM1clCgTVoM96Hg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b835ddb-44f6-4119-0694-08d58db3f30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:59.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 1deec1bd96ccd8beb04d2112a6d12fe20505c3a6 ]

When perf processes build-id event, it creates DSOs with the build-id.
But it didn't set the module short name (like '[module-name]') so when
processing a kernel mmap event of the module, it cannot found the DSO as
it only checks the short names.

That leads for perf to create a same DSO without the build-id info and
it'll lookup the system path even if the DSO is already in the build-id
cache.  After kernel was updated, perf cannot find the DSO  and cannot
show symbols in it anymore.

You can see this if you have an old data file (w/ old kernel version):

  $ perf report -i perf.data.old -v |& grep scsi_mod
  build id event received for /lib/modules/3.19.2-1-ARCH/kernel/drivers/scs=
i/scsi_mod.ko.gz : cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1
  Failed to open /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko=
.gz, continuing without symbols
  ...

The second message didn't show the build-id.  With this patch:

  $ perf report -i perf.data.old -v |& grep scsi_mod
  build id event received for /lib/modules/3.19.2-1-ARCH/kernel/drivers/scs=
i/scsi_mod.ko.gz: cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1
  /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz with build =
id cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1 not found, continuing without s=
ymbols
  ...

Now it shows the build-id but still cannot load the symbol table.  This
is a different problem which will be fixed in the next patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170531120105.21731-1-namhyung@kernel.org
[ Fix the build on older compilers (debian <=3D 8, fedora <=3D 21, etc) wrt=
 kmod_path var init ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/header.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 43838003c1a1..304f5d710143 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1258,8 +1258,16 @@ static int __event_process_build_id(struct build_id_=
event *bev,
=20
 		dso__set_build_id(dso, &bev->build_id);
=20
-		if (!is_kernel_module(filename, cpumode))
-			dso->kernel =3D dso_type;
+		if (dso_type !=3D DSO_TYPE_USER) {
+			struct kmod_path m =3D { .name =3D NULL, };
+
+			if (!kmod_path__parse_name(&m, filename) && m.kmod)
+				dso__set_short_name(dso, strdup(m.name), true);
+			else
+				dso->kernel =3D dso_type;
+
+			free(m.name);
+		}
=20
 		build_id__sprintf(dso->build_id, sizeof(dso->build_id),
 				  sbuild_id);
--=20
2.14.1
