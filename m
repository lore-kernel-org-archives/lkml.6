Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482390-2-18442186245586088771
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
    t=1521482389; b=QWExz3YGgcVBdRcz2ULvSBTzEz/Hv44SS+DQAFFUS4zXAaq
    OnPzSRPEqhAcOyz/DXdo0kZFOtf01yOO/aBDzXmFEYWTaeB8Qw8OdYXZfWki6I1C
    dnEB3rtLzt5NmKo47gGXYwlGj2F7k2TnhxKa0avAOfF2MGitwjM4sqfSM5O0otEX
    BUvBDlwvG+00LQuqWrXNP4GMttJW7lmHH9I+kiCsogC+Qh69q+h1nDaqu9SxZ+/C
    O+p3dPWiNM+MOgv0zSBmP5gQOXcBFvLkE3qup+7b8Pk0ADANNiLB3fYerCZ51CF8
    vMXMo0hrVFL//b1M97n7H+wfMU0/peQLOYCM0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482389; bh=kcQPem
    eMLh/sbQ206f1HbkGdhJmCeeOemTdIut30eKw=; b=tJ1X6KceFihaZthHPMsbye
    5RDOPIX2q+h8qKcbXpl5Re7/7uCWSfw/plzhdjXyLV94jj8lvdOSi648OeSQ2ezC
    lIb+Mk2N7gzi0ZQeSYF3fNb1DLsnCaR/M9fMHB9mI7ba/ZM6Xzpm4WqF6weYvedL
    XlfCVzH0rsIQGEdn/m20VptdbyL1G8f1sZIseovWGa9vlJPFs69zz2RYY3Sv9PFD
    QzFVtctJXeffwjv9vi28UBFU1cJuFGXyWEjkcTrV46LG16iLvxP/+pO3EM2qwA/Z
    hhkTMsADBO1hMOpTH0mjvoTnZCxUKorvuPRNUqidPGqiha0qpkcVQIGD1sHmYL7A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wqyft28U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledvtddvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wqyft28U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledvtddvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965651AbeCSQEU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:20 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:39072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935061AbeCSQEH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:07 -0400
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
Subject: [PATCH AUTOSEL for 4.9 200/281] perf header: Set proper module name
 when build-id event found
Thread-Topic: [PATCH AUTOSEL for 4.9 200/281] perf header: Set proper module
 name when build-id event found
Thread-Index: AQHTv5uX6sebI1CRLU2R2Y9czzOkog==
Date: Mon, 19 Mar 2018 16:01:50 +0000
Message-ID: <20180319155742.13731-200-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:dbTwYFmOZi784dE+673sb8O5tgNwvU52KG8/CTye/+fO+093oHX5QrSdivQ1XLWTMEkp2afkTDvEwKX7s7utYcSDTJoaznQM0b+ftn/9VF41F0QVelxs1EiZeb7Hezk8+NVDdJvLoNroVkwmpNHgneF2qnbM7K253gTXI2LS7+v5cpf/FZYhY2pli2G5lyMnodSbUygLLQOqHp7gf2tPnP7rcwCDd/ajpFZvFn4vWQKcdQkQeuDIPhlF0EgxJBiv;20:NyNWC6wFGHC0ZoQwMjqVEjmuYBKtfLGR0otiYR6Z9+MtXWU4lKVxmLZFtu/wEFDui0Cub479AVbGXkieivhtZvKJIdmdOHEi7fdiTiaK/m9jACxOkbxWHh2I0SxJ/PFz56sLmeE1yllmuCzvMJZm78xwta4h9SlnXkiifsKTbWk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0de9db3c-d9ad-432b-1a9b-08d58db305b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727B9B697C740A9EC1CFD6EFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(6306002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(966005)(3660700001)(8936002)(39060400002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: G1aluFDryvnwWjiUABE6XzmE/XG5MNw/7ajOMZ6SN+ghdsKKFx5qw45vun6JgbszwP+DrECWJvLod6svYawZbgd3K8Z4IBH4rBUqL+byp0oVkzJeYRdZL+PKM9ijCxwCCE3O2o3l8MY4gO14GVL/K4ERfcBc9SpL8soF5ymFrQijVSF17LpYLgPqXn5SAnVEVC1SYX6cOUjGZbnQ5RnBB4bzaa3oVJhx9rR6SQU4jYBHNiahFoDBH4YuBx7V/AhoUgUibDXD3e0iM6spk9ZqL0Cvd9jnQ7yu9xxl3efsFSjVi0kTd+wpGXHg2Vwy6LqQdgXQ+cf1jPw9DWqINz4O3g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de9db3c-d9ad-432b-1a9b-08d58db305b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:50.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 28bdb48357f0..ab36aa5585b4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1454,8 +1454,16 @@ static int __event_process_build_id(struct build_id_=
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
