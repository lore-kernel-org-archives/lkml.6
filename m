Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242442-2-16501728291401900455
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
    1523242441; b=epLewkyU9IHG1TU8jKhDnJCteCi0ThRiun5iQcMLJrva/oLJgy
    aB6Q9zwQ8M4tvu+4fdMCq93HpzSSceUBMsTM9yAlmoec4Ov2SPV4EUbh+U2Ff8Es
    0OnEJ+H8OhzusAv9Zb1yWfrSaAQDuaC1mpG7t1GLksjqf0J7GlSOy9/oS2NU9lrr
    hAVMK17ZO5P1e7j/mOCA5JnGIsuTd0an8EhndhNbMQaoMtciJLGEZ16Am4rbJT5v
    hOZLI+Ua0u09vtQcQhrSJ2U3QU9Nmx4d2o+LJ6u/uRShd7aPGSoiRA3eegzSjs2R
    gm04Ctcd/sYUtknacncep+8/vy4YJWx7s+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242441; bh=QMHXuAOShM
    ENbz7jC+PGZtdQY926rd1CBzcOZI14zKA=; b=gA8fYySJQrl31KoPwQmBrvZUHK
    19c3myd61m0ZFxJy0Yri2p+aX0A69qNylCPWCiGo+VvURHJ5CkDM+encP0Vuovqk
    4dC5eEKm2+RmDC/YrnxcHduwqCkZ61aOTvxkr6NNwxOeeJAGhH5/gZTtxgnoewQF
    P9dH/BbWcp3tAF3LA056Cw3d4FhqD0+wji0eiyL+xdw0PAT9CpCEh//5qxpTxxCH
    7gwVe6y/5P/zQhAnVLiO+qLxzuUEQ6FOgCdz5AQ+mYv7ML77dNzc/gzakEZJJw0n
    61OrNuPY19pwzQgsYHeXGR3dFFfnM0jc7HDfk3Y9gmn6Zk5LcZCHWrK5BVJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jTRjVRrS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jTRjVRrS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIKn3Batuy8Cyq4e0/wSzMi4BrkfMK9ifC10TD9xFPk8msEG4Vdcs2C6B8xoh9jWT//ix8erIgn16wgABBiiExvVv/BvvR0ywyVYDbtatM4PnWP6ebmN
    sK2yfHB1+OcJXuIwnosu9EKD1Hf3Dww3kbDNb2cBpcLj3BdX9kR98zq8lZ+wzOywojNgcfZranJjN9WuhmUo49tX7AIdAuJZ4iNczGJQTQSmaCnc4PULvl1t
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=h-CReTGHYNPUMB0j7bIA:9
    a=-ZRfwKw2pXXrmNcL:21 a=54B_tP8a_e45yvh7:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758084AbeDICxP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:53:15 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755331AbeDIA02 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 157/161] powerpc/powernv: IMC fix out of
 bounds memory access at shutdown
Thread-Topic: [PATCH AUTOSEL for 4.14 157/161] powerpc/powernv: IMC fix out of
 bounds memory access at shutdown
Thread-Index: AQHTz5jIiUndb9MpO0K2qhDML+3ZKA==
Date: Mon, 9 Apr 2018 00:22:03 +0000
Message-ID: <20180409001936.162706-157-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:xZ8JkghLDgPDPMMbCZxyokMwJZR94i24hvk2c5jKYkQaoq5bfTfmBx9IsKgzpLEhyt4VdXAcMMri7CB20J1LnwNe17K7t3uTstJ0kqWeNW+uNgpXXrDvAusPo7+6G0CUEhOPjzPgPlaueYDFr8BtK0mJEZNWp/dD0HxULOMYk46oV2vTngruqqI/pprbBkIpX6xjpN4G+uD/GMtArMRVyl6fMh1U12WglDHO/XNwWfbddYTb1KWdh91NfOg4NkBM;20:s6tSAeMt+2KOG52yHAYT1euuo2bec8W3rFyZ1wUCPw4oBRfZYfZjhMw21eShduCj+hddGn1HvfC4w7wn//5uNOGXMv1aXdr1egg7Hl0DVCubHoSttuZU2pOWLTuGCMRx81dv/VoccDxtQwqt4EYbYE6eXITcghI57GpTnMQSI/A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e7c7364-86e1-409e-12be-08d59db087b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10155C4ACFE43DB53452C400FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WmOY0PHMJtRgO6heUA0PqVzNiReZ21bsCnHYSqWRr6SM5CJHvYU1tt8YMswTHiBdI1vYcx1T4s+fOOMcKBx3I+0/dIejMdESiYuwilS9pVJ+8IJwpceENIek7P4Zbx8LA10N/uavSeu4qpgkDglociPG30vHJ+d3LLUPZWIcSlu2OqaMJ6AogLMzSV9dAsk0bnZBfeY/6WgDUQXIijoZSsNwiu6AtiEUE1p2rFB2wn3cZ/IwgV+pMR+9gTqCr4o6pg09WJFb3Pxp3vER17MaHQ+c/FjDiswbTcFyKl1e9JoCmp5pUP1w2YeU5gAKOZww+rCrxIyim9SaWCmEqypfO/iobigWAH5ZjO+ankpi3HeTZr3tmDh5a5kkSd+KTU1FqlwndlSqh8ydjFsIfdl9peaQpIdTTQYBUhEuTwrtghQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7c7364-86e1-409e-12be-08d59db087b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:03.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index b150f4deaccf..6914b289c86b 100644
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
