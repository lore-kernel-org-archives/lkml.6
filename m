Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235158-2-8935981541485942172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235157; b=TTZm+BgPT9neXgkdX/c9Mx6P0nKRGa8OmTfM1NwAbKhTZ1WSwC
    C0tQLBNKTAdGMAThEuJ0oxFmkZFh3r7G51xd92PM5xbebyRLCpwBTTdIF5YGuDMU
    7sujMBlL1+DVZNVARYkSfzAMGzgBYoN5beipWIYPysMlpTemERfdOFl8UYCovIQ5
    FYNy0zLC4hg0cbaDqyfwpDcUF+WVEUJkQSmG3zF58KKq+3eHod0lTpyCqfmwTaJe
    XxrZA88UoAdjBrqxOjhfjsxOK71CWp1YwJtotnhFDpz8UMSHf4B68NK5VopGZ7NB
    x/lClhYB0xAyriI5NEqRB3095DEUwgZMTTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235157; bh=ETpSDIUmct
    ZFBuoiMugmT91mErHtLTaZfDZu+n5RGoo=; b=DxC9YMCGD1HZ5HsKY+dh/AtaRd
    PTuiQTfFmLm0xnV5oH6PC94dOU80mSJ8pScC4pblzJeR8Q6q8JU622xkzpCmAJP6
    lsmaTonuqQ2P4Q54Rg77z4y2jQP15L/LmduDthnKb+jakIVXbyRQh5nkSdZO0Z+S
    TQDauRsvjlXOc1kCE25GJg5Q/RlFD/XWK6K5+1QQtWD4XyRJymvm/x/ycJnX7Saf
    XR9+Nh6byChD8vJDjDV8S8nLL+VjXTojC08eBm7KHEfqY11xpFiBFF8iMVNCwC38
    VxTpfteSx2X/Fbj6iw+HQUAxj9U9AgK3412sR0f829jIW/j0UAToz7Sea6hQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ljfiD1S/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ljfiD1S/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIVlQZF8gpaiZ93OenlhBd5nxpV/fcqW/PzHrQwYZ4venhdr6r7+PDbI71LOF5H1MnMy6SO7crdM5jXOUQLCu9k4ZIYUPTAYPzhH5zukzTahH/j0UVsl
    aqsAEcm9X2xR2AeqjseKIRu7mj2asHI2wETvx/GEwLIYqZZgZ2c/c0q/nTTT5gxkpump97kw414Orbbkv5GhGXeTZiIpz7qurIzZe7BrLg2+FASKeT8DLUiR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=2iGazB43HB0AJ_O2iB0A:9 a=g0rAZlEUfkR_pNrd:21 a=GOcm9bT77Yt5Mh04:21
    a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeDIAwU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:52:20 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933418AbeDIAlX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 055/101] MIPS: CPS: Prevent multi-core with
 dcache aliasing
Thread-Topic: [PATCH AUTOSEL for 3.18 055/101] MIPS: CPS: Prevent multi-core
 with dcache aliasing
Thread-Index: AQHTz5t5hfy9AXwF2UONPkjHDuMJ6Q==
Date: Mon, 9 Apr 2018 00:41:19 +0000
Message-ID: <20180409004042.164920-5-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:DdzenvLVrQyUzckLwLgeXi1mrXwDUfSuUOrPkjjs8N80PCCUCtkjDmguDerKZKSNEVyF19uPnYIznSzgFAawy6JT1fSeF1cQ/2US1N41MSmB3Sofd+kGEq9h0K0eJKkLwPuqfJZ8nF36K50Gxq1ldTcUroV8GMzcOwHDxSn4r2FGG2dTYRSLQ2lgmhCYxJncxIhu69lN6GZ8VvYhqFSYY4PqdmVgckRoLdDgz457GoHeF3eIK712+Pm+a3Sx3UPo;20:ewDi7JcVk5/pLnge9cxPzb+1A8SXq/kbUAI2MV4g4QDoCqLBsm9alY4xVb6avnd+ppbVI/2omwfsDglY6cdQrDMn7XbsY9aZcBcH1UBDCEd2VItDFv2sNohojhmJs2aNYUQbPXSyYWHn+17AwRbFKiIURGFVSa5eOkKq2I+ctU4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cf96232-a29a-4a53-0722-08d59db29d7a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901DA603103FFFE072BD719FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(6306002)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(966005)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Kiev7TG0NIhFzX+2H0Ix6tMHs2lUYI198IXYRHBKMx5JYtjyQVDEcNaZlu0x+CStukei/EICEqoppyxl3Og+v18qWgbzhsRCnHzi7UsJzc07rFGCO4Ga1LrlQyPLBn9Fmj1gW0ZHRCoSD/bSknN8y1+qiSN29jgvmWdn1SnQTG0OZVeoGuaLPgnNu9Q48DnoRkHuVEL5zyr/xAq8uZ2BnE+bf8BP8mhAkz0H6ELcO3fgFuZVZ0AYYn2SCDl3V3onL0U9vJZOk1AmcWUthyjk4zI8qzOQ8FGcgKjMvKk2wtNAMlDFDJT1BUZepi1PvD1vIhvyqmWtxUB5S8mO87TPqRW+eO7Sh+fRs64mK81thiRsKzzDwEgujM2Clnxh2C2Xge0B95BBtaXJu3e7uPA1Io7CGja8oZmvw1G4x8bWvr0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf96232-a29a-4a53-0722-08d59db29d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:19.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 0854f17829f3..0e5ef72c8978 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -120,9 +120,11 @@ static void __init cps_prepare_cpus(unsigned int max_c=
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
