Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683520-2-16239814088617805585
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683519; b=REpazLQK05ScqGtXkX2urSJCu7VVzgWgBcVf2WyzrA/zgm8
    +b7TWfKbbutLyTxEuQ4sTqOm+HZpO9pM03uMTr7Y7YBIC0Ee63aa90ax/v8mx3Ma
    Pe3wv5MtTdouTA2Z96H8TKYIMbQ5wEfel5jPQpmcIDeFw4UczOl+pVzsXSI1EGOS
    j7x1hDhswpw2/0+INPVz/dVCm3Z2LfnX3NBRkEzu9glQGy37g6iBrkH23sMqDk7A
    BDCffClgu+b+ZSt0BJOtWtqc9O2ZXZKaF5BxVuJ6iDVtPpf7ilNYSpVQvgASpNv8
    bCvCZcmdXY2MgFVa96rO9HdRFzRXgOjx9XJnmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683519; bh=CPdBw+
    YjCpprJbFMrrmI3/8Pbb0jeWUCJHqwyUJjTLY=; b=HbQT0NwluJNNudLRyjghJV
    9C/wQzaTFKOe1Z2bBqvMI9uP5R7WrpnfaVBfdNx6mzimbnsoqqM4dY4zbizQRvpb
    qgkQfaYblqHARFnUnmxnaAJG/j3ItVi0u+bqxCVrxHA7dCoNbpCfKvOi8N//4/Ck
    5Wg19WmsNf1ECgOw1J0u9Kc3mET8dY+gHujHjwUk/EQ2rQXC2SoGTCE3tEoSxr2d
    qDYduhWNsCotKzDZGGtYSGlgZYXdntTcQoLUATWI0AcNgUe0zDrc/1pnKjQk6QT5
    mTjMn0yhljRPRKrN77S046FtU1Nk/I5SH/rPpuJere7qSJxN6L80k0MgsDRXeylA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V4w7znn+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V4w7znn+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755209AbeBCSpR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:17 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753156AbeBCSCx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 064/110] perf/x86/intel: Plug memory leak in
 intel_pmu_init()
Thread-Topic: [PATCH AUTOSEL for 4.14 064/110] perf/x86/intel: Plug memory
 leak in intel_pmu_init()
Thread-Index: AQHTnRjylMzI0D/X0kCyRlSe/K+0mw==
Date: Sat, 3 Feb 2018 18:00:59 +0000
Message-ID: <20180203180015.29073-64-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:LaK0fG+3eCdmKPjwv2F+irijTRbfkcgjKCpMbnGMMntB7DaoCRkm7OX1j+OAcm9/7NTouQt84TV2JMa5n88MjzukqDWFpM8I5QmT4G+4eA7+CTeeb3wvo6W/n8S5i2l39kp+YvEjM+rBCEgMKVfed0beF4QW67qBse1HOPsXkY/LR2iLp31PSljIqznaEN/zJycWc1mT7rbMKtCD1rMaZP6tzzf3chwUPMLJom2BBP8RRfbQskKnxrWDxoB1l5Dp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 992ca31c-302a-4b60-2ee5-08d56b303b44
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB1105A8C84AAF1E763B6731B5FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(82608151540597)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(575784001)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: w7P26hniqX00MOPdQh9wKP3tecIrhh84tYRF/Wf9Qf1TYef5quKxz+I6CRHQGRKzj1A9ZkqZojGzWdqYtttVGQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992ca31c-302a-4b60-2ee5-08d56b303b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:59.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 7ad1437d6ace0e450a6c1167720608ad660b191d ]

A recent commit introduced an extra merge_attr() call in the skylake
branch, which causes a memory leak.

Store the pointer to the extra allocated memory and free it at the end of
the function.

Fixes: a5df70c354c2 ("perf/x86: Only show format attributes when supported"=
)
Reported-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/events/intel/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09c26a4f139c..731153a4681e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3847,6 +3847,8 @@ static struct attribute *intel_pmu_attrs[] =3D {
=20
 __init int intel_pmu_init(void)
 {
+	struct attribute **extra_attr =3D NULL;
+	struct attribute **to_free =3D NULL;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
@@ -3854,7 +3856,6 @@ __init int intel_pmu_init(void)
 	unsigned int unused;
 	struct extra_reg *er;
 	int version, i;
-	struct attribute **extra_attr =3D NULL;
 	char *name;
=20
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
@@ -4294,6 +4295,7 @@ __init int intel_pmu_init(void)
 		extra_attr =3D boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
 		extra_attr =3D merge_attr(extra_attr, skl_format_attr);
+		to_free =3D extra_attr;
 		x86_pmu.cpu_events =3D get_hsw_events_attrs();
 		intel_pmu_pebs_data_source_skl(
 			boot_cpu_data.x86_model =3D=3D INTEL_FAM6_SKYLAKE_X);
@@ -4401,6 +4403,7 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
=20
+	kfree(to_free);
 	return 0;
 }
=20
--=20
2.11.0
