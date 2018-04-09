Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237556-2-17324261475165368055
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
    1523237555; b=OWKO7CP60lMmjm6sDUwhg/4Lg3dLuD+5z94VQ04j9XczuOY6Nx
    ga2xEr0ir6O9X+gFDq9La46B/ezxTPhcDXw81py3h/BnToVZWjfPibUYJlmMiXbl
    gbtvj4xpAVx31D3D2/da328xHoVxJEWaE6MvYTOeGXOyyiO6QZ32RoQZ6EERYIm6
    emp4sYxVOSMsenTPsyC1hmehi3pVr9i1vbMhP23rytTeFa2PlD/zuH5Bbu1byCAT
    hIkC91wMBW+nQ91tYvSy1xi1MciaUWeYC54/xNyEqfRCZygRvEnpork2RblgCvD2
    j5PnGOumH/Pi1IRF24lsC4GgJNETvuFPLzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237555; bh=opADDpGdTH
    NMAAMyLpqBwyma6g07nnCQMJwGZJ/NExA=; b=fyqdir/23V74oiHBRO8sj0SK+A
    O/5f86JinNyTVZZ1EJMOfL7RFEdE/nL3hW6xoqA10nnCCza4rj2nvLEG9mVleK23
    P6GMfXkjpE+DVF6WTCDR4GvI3V7epFZUaTXI/jOgTkLRU91xXHmGmli0n5HZubYf
    heLv3jPZsJ4MrJx68kvFZmiyiN2JG+KHECI0RN3hGetl+TZN12kMf3maI2UqKNyF
    PIWCMohs6ezM9hMy8kkImH96f+sJ2U1kUZ7zMOmC2BWIakhlIhE81mO2iYFARvB4
    nWuiKUiPqNY9W9KGzN5YV+23SMBKIa5OHnbjnzOFWVvcMa5rYNQGV0TfsnmA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d3jk/Nr+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d3jk/Nr+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCd9yckftBrzeJMUGuAVEabezZrIY843wcsnkcYOY0u6YsLpmK38p4uRWp/mxAZdBlt8CMHkhYfU1to1Dc7myiH5D7xF98eAU57fni1TWY1usXbxL3HZ
    olQP5g6+lY5T3v/wW0GKiCmPAT98Sh6+P3rn2zAQcgiO+DhczbC2+lmJeLQR3QI/cRsUxk5b/FO9GXqXjXpa9CR6U2qsogtL+9Q0rQfzu45+3YlPX42GmFUu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zd2uoN0lAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=BKoL6aYy6hqYyL61QrwA:9
    a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756742AbeDIBcW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:32:22 -0400
Received: from mail-sn1nam02on0112.outbound.protection.outlook.com ([104.47.36.112]:45420
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755359AbeDIAfs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 036/162] x86/mce: Don't disable MCA banks when
 offlining a CPU on AMD
Thread-Topic: [PATCH AUTOSEL for 4.4 036/162] x86/mce: Don't disable MCA banks
 when offlining a CPU on AMD
Thread-Index: AQHTz5mibCh2+0HdpUKZAAd0snQgSA==
Date: Mon, 9 Apr 2018 00:28:08 +0000
Message-ID: <20180409002738.163941-36-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:Y16iSRRYD6WXK74cY5i+0Y8jPmQo4xdEX28DphkJcIDFphqPzeofXCguG7/yu8nEFkOzYoswwH7LTAVIpaVydJ/s68yCi7GfC5O8K5gTWsLfX+yTlohPPwuK+Rzj1HYH6ayRpAanSsFJGJ2hPDBOl40UzedryD1tjTWWbN6Kc1G3bH+cGHVkztiwH7CA28yQ0GcQenOo2kmuCXDBfNEaP3NXWpTk1pPr+eemqt9tZwkdzh58K1P3m+TBQsfdiaVQ;20:Drb/1VCY1UGnzabov7kPUT6Cq/hr6n+YYHle3NOk2NTvnjGhwTgEi1M83NGoNWVYHCHHLvW2YLvfRUb03nUyQNr7VsD7o9vd/YFseeVd4ll4MzgRRKfEIDvUJyRbHeSUm/4JeKD5tdNv251i78txxFUlvMWP6W/pWTiv8YnPvbk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c06437f0-1ff2-46b7-dbba-08d59db1d5a6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725E159B0560F9D24854D03FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(767451399110)(42068640409301)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(7416002)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(8666007)(81156014)(8676002)(6666003)(6436002)(7110500001)(4326008)(6306002)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2420400007)(10710500007)(2906002)(966005)(86362001)(186003)(15650500001)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Zi3iNh7K4xEQ295a90DXZYfE+WnrCNcgqSTClQC1+peJvMfPSl3l6sbqxVoF16khDO5BxRRjT1BsYuKyI+BEgZceMvvXUpf0hNCg6fo3YoPgZk1KFYsxqs7APK5BnEpCVI83M525oWoVSwxUZmOgfPtSGXqVTBHbeUWUhHnU9s1U3o8kJ76wkgoveknSDmW2HvhwmU+GZRzYkGoozDOuZSNDqgTk5ki+rO+JWdGHYN/qp3j2B5iwZoM/b0ljV34VPbYKAtTPyc5OaWOnOdL3O1VW1E/mNsS0fitpfnRh3KwrGLIeRYQQNdNHd3jCeJRxs0snwumUBNCI5O6nk0wkYUxLp/IU6k7Nd0kdznjph8LW6ftXdZGoQZ67fkkwMrl6J8B81N8x7zRWp1k/7S7M9+QPaFxPNuHlYbmVqvyeLR0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06437f0-1ff2-46b7-dbba-08d59db1d5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:08.8642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit ec33838244c8535b23b8d24b167996fd1318bb68 ]

AMD systems have non-core, shared MCA banks within a die. These banks
are controlled by a master CPU per die. If this CPU is offlined then all
the shared banks are disabled in addition to the CPU's core banks.

Also, Fam17h systems may have SMT enabled. The MCA_CTL register is shared
between SMT thread siblings. If a CPU is offlined then all its sibling's
MCA banks are also disabled.

Extend the existing vendor check to AMD too.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
[ Fix up comment. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20170613162835.30750-8-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/=
mce.c
index 6edb9530d7e9..8a79833e627d 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -2081,12 +2081,13 @@ static void mce_disable_error_reporting(void)
 static void vendor_disable_error_reporting(void)
 {
 	/*
-	 * Don't clear on Intel CPUs. Some of these MSRs are socket-wide.
+	 * Don't clear on Intel or AMD CPUs. Some of these MSRs are socket-wide.
 	 * Disabling them for just a single offlined CPU is bad, since it will
 	 * inhibit reporting for all shared resources on the socket like the
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
-	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
 		return;
=20
 	mce_disable_error_reporting();
--=20
2.15.1
