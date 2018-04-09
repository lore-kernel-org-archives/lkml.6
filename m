Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236920-2-6425114227639807729
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
    1523236920; b=tfjqrQbYB/GXHbunsoU5ejM2iUsLd4thjr8EqDBVYqWnJB+J/G
    cP5I9Tg97hsnkN2e0oHyJ9lW04rjUaQeK0w9XoVOM6/NZJ27Ejd45Al46DIcgG5x
    86NU8fWXct0OvqprsJO2DZtS6p3VNfFRhzBNUup/5o/Oe2TIO9m7+6Pkpvrsps31
    u388Rcws/35Eb0HwUrqM0iONRLUw/F6iH+07bLBopiU5sfWutGbm0aGV4Bbz/t+n
    LAVraJ1zKLtNoXv2yIa9R8Z9/qmCJdUGilkOX2VCoX3+Uqm/ABVECJ5fWwwFTDWM
    BOjH/rHBiV+vo4Mj3NHQwkbM+tr/cpbHVJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236920; bh=tusPP0etyV
    izF48I1TUvwHdcrkotY8q8IWwcepcuQ3E=; b=i+RNsuWESdTvf2D/O/InHOi0jI
    VU2ERl3NZDDr71uKgmCgUP61ayTqzXkqZ6moS2WIRRR+7I8EZNXxhULYwUJZmBdp
    jCdL3Efr8jieXvRUQ8O4gP2ZjzJ2kgx2LvpHkb+I01dw7KMZ97EdVmL2vt+nRty5
    kOeFDLanucqR2eQcKkLO9Gkwu6mtXuweTxsh8eGYYAqzjasMlUMyZ/qRz1WtNCVV
    dXfEJaJj1RWgd0z5YtzSKRnWHWOfSVV13XOezZY6A1STB/LCUs+nQkVZ1dEKZYp0
    bM7Ho6fAxJ97Njwmg7Z0QcZg8H+jDG52O7YiqaxS/yePkK6NBw78dx1s1IBw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GA7dB92B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GA7dB92B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNX8Ti6pHnzlHjaM6SnOhjJ8pe33A0xQWybojADD9xfUEEpGeXrIyPIw4+OhVhCTGQrksUCfrqBFuTpeNc111Pu3YWAIVig4kpA+HxeV7uvpeZa55knC
    Y7c3BqWXsBOVMprxIo79EKtgXlVSjMGaD44lbn0MXnvGrgSzEkJnC5TggptLMclfnLqPaCt/Kqpy8wG/GCEOZAY8H7Xzq3UcuAm+06mUcd4yzhHIkZpOda1o
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=2iGazB43HB0AJ_O2iB0A:9 a=g0rAZlEUfkR_pNrd:21 a=GOcm9bT77Yt5Mh04:21
    a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755939AbeDIBVq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:21:46 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755364AbeDIAhJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 085/162] MIPS: CPS: Prevent multi-core with
 dcache aliasing
Thread-Topic: [PATCH AUTOSEL for 4.4 085/162] MIPS: CPS: Prevent multi-core
 with dcache aliasing
Thread-Index: AQHTz5m4jPCq/48YGk2450rvjMCLug==
Date: Mon, 9 Apr 2018 00:28:45 +0000
Message-ID: <20180409002738.163941-85-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:l/krA5maP751xcMEcjkk+Q416SZ83EJXgpYoWzfD7Hv9pSp7iTuSv5a8RYq8oaPcFc5I1HzYXw50d+HPioS1bsjfF7Jc1ubuE6ANxn0PRe8873iJVQgmO708yQLN9wGpDWiRWN187JaH7Q7ctE2QH4Gj9XDx8vOpy6r+YacBEaWTKMbZ16tBPr1TyeyqkD4v0dpbzbwgjokKj0n39qg2PF1zDgiSRJ18+Onk37oiprF8A0UD5OWCbh6/IaIy39C7;20:cxlClMkvuFj4viGLreiFrkGNnpciKd5Sl+ske5uukj06Uw+j4x6rBSm6pYnN9sPmw37hfxNS/nHq9lFTQzx3QIbXc7T+KvzXLYI5iQIez75ij/hEDLuhZPtCC3NnLU/VUnvUw69HbvxmIIniWGwABmU1/2WGcRIw5v78n/2arCo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: af529c92-7317-48b7-481e-08d59db2049e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103123A1159B9A906F82C740FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WffPFkdITJJe0wqa2IUgAbIl4kr5KjPQgSE3q11ChnJLl0GdFucMi84tV95e3b2tJU3SRbNnAdp4Kuijn4zSnx7+/ztyehnSsaW7PBgQGi7ezz3paLAwWk8+kGVcyNfyWVNQAFee1rFyw5Wc7zUr10ZVRLbE/IweCQgQ6iPK3mLfJlFxdu/ATyOUMioOZMzAq1sjOCOxtXU53ql4r857U1C192QbLOLYgFmEec6sHexmbr9CkPB0wbttlv7VHmdIEfdFNCtCyXOeoNu6iqIj5EOLy7L35MBkzkrsPEv9bW1mVXEn5vC2BSQpK3os3l3P3gRH7lgN3MwUAxSYw74UWJ35bqd6SXgo6iN5UHVVqKb63ZX6dOvVMMGNtE8rZJHBbE1BWTMnRnw3la+0jXTyZ4gmeU0dSWlDWX8eFkXKYJw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af529c92-7317-48b7-481e-08d59db2049e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:45.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 5570ba2ee920de4e7760a2802b842771845b2c32 ]

Systems using the MIPS Coherence Manager (CM) cannot support multi-core
SMP with dcache aliasing. This is because CPU caches are VIPT, but
interventions in CM-based systems provide only the physical address to
remote caches. This means that interventions may behave incorrectly in
the presence of an aliasing dcache, since the physical address used
when handling an intervention may lead to operation on an aliased cache
line rather than the correct line.

Prevent us from running into this issue by refusing to boot secondary
cores in systems where dcache aliasing may occur.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16196/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/smp-cps.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index e04c8057b882..ff0993dfeb08 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -122,9 +122,11 @@ static void __init cps_prepare_cpus(unsigned int max_c=
pus)
=20
 	/* Warn the user if the CCA prevents multi-core */
 	ncores =3D mips_cm_numcores();
-	if (cca_unsuitable && ncores > 1) {
-		pr_warn("Using only one core due to unsuitable CCA 0x%x\n",
-			cca);
+	if ((cca_unsuitable || cpu_has_dc_aliases) && ncores > 1) {
+		pr_warn("Using only one core due to %s%s%s\n",
+			cca_unsuitable ? "unsuitable CCA" : "",
+			(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
+			cpu_has_dc_aliases ? "dcache aliasing" : "");
=20
 		for_each_present_cpu(c) {
 			if (cpu_data[c].core)
--=20
2.15.1
