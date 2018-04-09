Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244742-2-2445811748719842766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244741; b=oRR+teRQVtR9kYxnDmk5IOhz3v830js8UbRyvJed3ZLmFYvndU
    XE4bs94Tfu5QahfXtWk+v9aSykBQnzDzJiQ8kOUTQFvz7flybRY6qwnIA4xFOuRG
    7o3HmIMqcsek5VYvVyYBlhbiQ5X+m6OsbybWkRCvzN5FCYTX8SD/zUCT8lDwfq7p
    gJR/VCLg8v6N52DI4Eq0RmLjHWrWZWbPe/xRETjDkVk2rtIbHJTdDuCfGceeD5kL
    x0a/yE9LgzJrQdYgc8bXvWnlqphQwYPtal5w/GqnoG7v4tWZFmbeoobzORSQETTt
    FcsYUSyqqE7pp4VdtmjSwQ3ZYMAReJY+tVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244741; bh=vYgbATmCGz
    xzKKTJo2/E/zI+alH3p5l+TgQfZcD7WAQ=; b=d8h4X5niiK9WMPyvNPY+WdIHx2
    4evbwL9CPj5s78dcgSVrhouCIgp53tLSclGAEem1hlrk/egFlHpCGGjOVfaKXAD7
    /JCWY9jW9MY5PjF4eHQmBYOLdtiyK0Fy3XUKqVoj+t3WXHbU/XUoPvSJ0BJzVeCb
    NgLgY58E0kJxOayPkKwBNJ+vRJUDGrccUVoyrJUUevgxjoOSvKkqYElRV+qvA8v8
    IW/iM1kGH2ukv10PPvmtPaIZLCSz/ZDMDeifc82YjYpAZxRnOnT6yoNbzezemAVk
    M9WIycsGLquytyDzQ5GvYZDed8W9cXy9y61W4IhnAKEmZQFH+3p/aIicTo9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oAbvbDIu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oAbvbDIu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAFXtZkJayLfFg4wG2sxqVcOoiP6rSg+QbmKzWn1JhjPntEChcMtsLXcorxLL6WTT7fdX6RBMyV61z92I8oPjDRDQ4+RaAIW39ReCg2ulku1NL/fa9qE
    SO1kiXKyWvVzQII8eI/pl43/johP07VXkWcU7CkA6LACgtzhfhByHhrG2aqvUGvrgYPR8av0/9vM7p1MuOAmEToLKmettKMMBTRDwmYR5LV845I4jTJR49q+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=h-CReTGHYNPUMB0j7bIA:9
    a=-ZRfwKw2pXXrmNcL:21 a=54B_tP8a_e45yvh7:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeDIDbw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:31:52 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:35872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754521AbeDIAVx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 185/189] powerpc/powernv: IMC fix out of
 bounds memory access at shutdown
Thread-Topic: [PATCH AUTOSEL for 4.15 185/189] powerpc/powernv: IMC fix out of
 bounds memory access at shutdown
Thread-Index: AQHTz5hkrDQC9LZq3U+hUCJ2OTPYAA==
Date: Mon, 9 Apr 2018 00:19:14 +0000
Message-ID: <20180409001637.162453-185-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:w+UTS5edFrkIuPs1qJgd0OtwT/gT8cybfbCLtTwtKJSSo5lX3FvPisoezO3WJ82gD955Z7hyW6f4BZ0cxnYVtXKEP5zBicmKXaj8AbCgEtgHVyXURo5gMhK6C3bNBlTwPunxCnuk3op1OVi6F+c9AKARUKrygW0aSsLmfiQefhwBYRbMt2wBXIAH+nHYhcGzYRaROVJWrQVYeiqunY/op5B+KgpvlcdXUwd8hV/6eASUuL+hA+gOap5eGdQ0MiKN;20:jJrHbVVPyE9F7gKE6Wo7RaSO87wU3B6PM8sq+ouIqBzbyH/ZeCAk2prmYhREITsLCOPg/6p+ZoS22asn19nlgwl5Si6c51j1QcE/j0CUwF2L5/Ims1/3IPoldfWfkrdEdY8+6eN+bnTX0bDFAVXBFP/N2AzWFF5zjT3+yeZxKLU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b36ab66e-e7f5-40f0-effa-08d59dafe417
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09363D2494C10A28FECD58E0FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(575784001)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(39060400002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: F3MzrRs5F9BZiBjUn7kK2tKLEXS2qZZ9Fbm5nxAsXHd1HJdfYDjJWqg/HwTbt5RTfny1Kxo3WyKxPU2zGgVT5HEXRXGmKM5y8tiW+tDyhB0rnbEtSxrCloeJXQaFRSYWGRgVdaxxWc95+7osm1R/AaK7XQARRrGQRF9We5/Q4fMjobgmhtrsy04Ryd2cwcKTCdE6kkSxfzMV+TFCN+f5xo+9i9/P5BrlnljbrzPBYd3o47brfMAREgTnb7Qc5lUavpsH5pQ9T6SPbVazT4WvKKayguZMCa6QKxJQRKHDeDxrpD4LVSNcNsCYOKhdlms6u0zPywYcRW9ifFFQg/QN9ALcYX+O2xQuHYZ4FKtjw8ufYIPPkgUFgBBkF/AtZ93RZ0l5PblVuRGRSoVfjFaR+G3GqzqC456dm4ZF9i6EJJw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ab66e-e7f5-40f0-effa-08d59dafe417
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:14.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit e7bde88cdb4f0e432398a7d29ca2a15d2c18952a ]

The OPAL IMC driver's shutdown handler disables nest PMU counters by
walking nodes and taking the first CPU out of their cpumask, which is
used to index into the paca (get_hard_smp_processor_id()). This does
not always do the right thing, and in particular for CPU-less nodes it
returns NR_CPUS and that overruns the paca and dereferences random
memory.

Fix it by being more careful about checking returned CPU, and only
using online CPUs. It's not clear this shutdown code makes sense after
commit 885dcd709b ("powerpc/perf: Add nest IMC PMU support"), but this
should not make things worse

Currently the bug causes us to call OPAL with a junk CPU number. A
separate patch in development to change the way pacas are allocated
escalates this bug into a crash:

  Unable to handle kernel paging request for data at address 0x2a21af1eeb00=
0076
  Faulting instruction address: 0xc0000000000a5468
  Oops: Kernel access of bad area, sig: 11 [#1]
  ...
  NIP opal_imc_counters_shutdown+0x148/0x1d0
  LR  opal_imc_counters_shutdown+0x134/0x1d0
  Call Trace:
   opal_imc_counters_shutdown+0x134/0x1d0 (unreliable)
   platform_drv_shutdown+0x44/0x60
   device_shutdown+0x1f8/0x350
   kernel_restart_prepare+0x54/0x70
   kernel_restart+0x28/0xc0
   SyS_reboot+0x1d0/0x2c0
   system_call+0x58/0x6c

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/powernv/opal-imc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platf=
orms/powernv/opal-imc.c
index 465ea105b771..5f27854b57aa 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -126,9 +126,11 @@ static void disable_nest_pmu_counters(void)
 	const struct cpumask *l_cpumask;
=20
 	get_online_cpus();
-	for_each_online_node(nid) {
+	for_each_node_with_cpus(nid) {
 		l_cpumask =3D cpumask_of_node(nid);
-		cpu =3D cpumask_first(l_cpumask);
+		cpu =3D cpumask_first_and(l_cpumask, cpu_online_mask);
+		if (cpu >=3D nr_cpu_ids)
+			continue;
 		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
 				       get_hard_smp_processor_id(cpu));
 	}
--=20
2.15.1
