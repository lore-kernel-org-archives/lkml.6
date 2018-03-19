Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495490-2-15288962649896484854
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
    t=1521495490; b=qRz5V5w+dRmb/tpyHAfbFYUXqakOkO+4JhMKnWyxe7qYlAv
    X94ggGt2yDxrR7BCVt8IWNRFh29XvJtvrZYDva1LxDo2429mgv0W29wTMRMbCV+M
    ts+3v8To6igEfpkz+z8JtDxqLQgzD0nE6m37GugDZW9W60MDEPfBd9gZvIv2AwQA
    0kgkd62XveyGmKOQb/1ig2ChA4XGtFQee5of7FMfG9gDfz7nqQOmC/4PV8x1ybCH
    qQXQBXOdCHSRLSr8/6RDZyUkRxty0L9otFLYNgHF6OttalGA3nl/eUIi4YcJVA2R
    3NONYuJ2D5oo/BMq4hUThx+S0S8XMDwlXroDwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495490; bh=ZzDesg
    0p7H3QQWpTxTuYtwVNiDQ/I5IhQLeA4N/sTvs=; b=maiGJtAfnN8ex/VZ4ygls+
    3b0b+X0KFugiQjYe0j7JvczYFLc/ThwrS+EUQiXy8fQ6SzAB4dsSVw9693CcwQfX
    CGrDkckUDCULMTcIvM1WKyR/8KeBcCchCKxbppzmLpA95JjJG5OTd/qwfgShr1H0
    3RV9QMeum3sCGELEt8kslVUvd1ZNeWnWIzmY17+C3ohpnRBmOg/Kst9dlTWw8cB9
    ZR3Zp2MLOVm9KBFaAuXoUZl/DV/ISv9Mg7emkEJ1yiHiEN5lCCtdOSs7LjzBLunY
    Vzgbu6wBXYBs0vC0O1+t0aBCCOSzXxT6lza9gZifPsh2gFhPnpOKhk7+q8q2YsFA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YgNNbqgY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeitdehnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YgNNbqgY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeitdehnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970973AbeCSViG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:38:06 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:23168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965089AbeCSP7V (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 049/281] powerpc/modules: If mprofile-kernel
 is enabled add it to vermagic
Thread-Topic: [PATCH AUTOSEL for 4.9 049/281] powerpc/modules: If
 mprofile-kernel is enabled add it to vermagic
Thread-Index: AQHTv5sqv3yumrPbQkWtfmTjzpSQkQ==
Date: Mon, 19 Mar 2018 15:58:48 +0000
Message-ID: <20180319155742.13731-49-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:l1FY6CoSe1w3gEMl4kHwYt1REBAdzZQZQ3yBJozXUHvlpOPZ0vlaReXbg3AOfcAyaXpM6O7bnFwL1QsjenORvRTcZ/MmdbRcs61OL2XYzlnooe/o94ewqMh6MgYByHPmowXYpoatpOqgeYbxczyoxZYtS5xvch3C8JBsEfTTu/+4UXlajWo+bO2Jz1EVa/BausYBAighxyJbYYyLwClM+gpuBPFs1YfTG0ZfgJd6SxGpzHkh6R5DjvWYgPWRzAk8;20:p4d3WjV19ZtCcM4zwxN0OXInVLcLHWMi937tLHqyu1oZx3ve+SPrW4CdSqANVymB+LiCOudrhn9LtkvlSzcbgbaNSWdsPE53c0ZaP9YilIDi6cswB9MQsYma67vE+vA0pyw6GXhXHTdbi8nNxpic2V13LtOg7y1WmaT2u4ljTpw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5bfdc38-984a-46e6-2486-08d58db25e8d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015ADDC269D43155F152302FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: wJpqYEkjhpQ3wgZWJ+nJS5WZsNvLnKgBsXABSZzqBzONTXv86Ms/1lQvBSNua5t1N3viS8H7urNR8FE2nGI0cGISRMIRC9UGAwPcgrIpccdbbbrdKWAYUWpmcra51llDEM6hO6CJkYgtT40hFn2+FK3Dntcnsy2yN6ihxv8UeOsxi8cdbHMHNNfHUgbMVZGlQ3QDvVJzftTX+31dXdQtvwiYArneJ0qQ/SKVxZVYzOhjEABkJBMHb3rb0V0yCarQ7BisGB3FOCDnf9cMym/i4yJqexQdQRFJI27ox45EXBj4A/mVBbW5+QGvwpJHvvkKzsRbt4JCDnod5kYfU+fgLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bfdc38-984a-46e6-2486-08d58db25e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:48.0594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 43e24e82f35291d4c1ca78877ce1b20d3aeb78f1 ]

On powerpc we can build the kernel with two different ABIs for mcount(), wh=
ich
is used by ftrace. Kernels built with one ABI do not know how to load modul=
es
built with the other ABI. The new style ABI is called "mprofile-kernel", fo=
r
want of a better name.

Currently if we build a module using the old style ABI, and the kernel with
mprofile-kernel, when we load the module we'll oops something like:

  # insmod autofs4-no-mprofile-kernel.ko
  ftrace-powerpc: Unexpected instruction f8810028 around bl _mcount
  ------------[ cut here ]------------
  WARNING: CPU: 6 PID: 3759 at ../kernel/trace/ftrace.c:2024 ftrace_bug+0x2=
b8/0x3c0
  CPU: 6 PID: 3759 Comm: insmod Not tainted 4.11.0-rc3-gcc-5.4.1-00017-g5a6=
1ef74f269 #11
  ...
  NIP [c0000000001eaa48] ftrace_bug+0x2b8/0x3c0
  LR [c0000000001eaff8] ftrace_process_locs+0x4a8/0x590
  Call Trace:
    alloc_pages_current+0xc4/0x1d0 (unreliable)
    ftrace_process_locs+0x4a8/0x590
    load_module+0x1c8c/0x28f0
    SyS_finit_module+0x110/0x140
    system_call+0x38/0xfc
  ...
  ftrace failed to modify
  [<d000000002a31024>] 0xd000000002a31024
   actual:   35:65:00:48

We can avoid this by including in the vermagic whether the kernel/module wa=
s
built with mprofile-kernel. Which results in:

  # insmod autofs4-pg.ko
  autofs4: version magic
  '4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269 SMP mod_unload modversions '
  should be
  '4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269-dirty SMP mod_unload modversion=
s mprofile-kernel'
  insmod: ERROR: could not insert module autofs4-pg.ko: Invalid module form=
at

Fixes: 8c50b72a3b4f ("powerpc/ftrace: Add Kconfig & Make glue for mprofile-=
kernel")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/module.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/m=
odule.h
index cd4ffd86765f..bb9073a2b2ae 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -14,6 +14,10 @@
 #include <asm-generic/module.h>
=20
=20
+#ifdef CC_USING_MPROFILE_KERNEL
+#define MODULE_ARCH_VERMAGIC	"mprofile-kernel"
+#endif
+
 #ifndef __powerpc64__
 /*
  * Thanks to Paul M for explaining this.
--=20
2.14.1
