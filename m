Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242167-2-339103054208049405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242166; b=eyNL4eN8+C6wVO/HwqKmodL+f2PIKXh7r/2ESo2fQTDBU+HPga
    IMKOHR6fsAuyGH+9Boq3A1xHv1jor8d/j5A1lyMYJsl06H7NaR9z8wzRSOAS9ES6
    bSv8p83vf3A3wFCbz3G6Ufei4BwCI9SuIuGsAhd1+kSIcbPw8mvuofWoKU1PtTXz
    FuQ/pDmzNyc9fRKGf1IWQ1QkRjDYNt2moThSA+thDvvH8WXq3kFox5glOM2gPP4p
    9OudToSZDfMOYIFGSPp62e4zRTTY9/LzqBI+Zd3Opfnv+rycDDWJO4Ms+g9Tkkcq
    Euw+kEWrJopmcMpcf0s4t0s0MhWCy46B/Iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242166; bh=pL3aAjKKuX
    gecQcNj1TFVJ/cndlp8RXLYTfGIB1F5io=; b=SL/AwOMTAAVW5zFwcvdvWv1vVU
    xu0X8zTX4pi2WagidIyMQfLhyMDMpwA06KmNSnO+hESODVkOZOSMCFY0DtzQbPZK
    YC3RBjXRnMSrTTYPA6gRRW0l0BHMYfEEQrsgMThTXW3eFfJOa8ku4uK2M1I2hRNh
    Z5unWpZrhbN5/WxretualbLrKbWnBUBLb9MMHWRZJ0V+EWoxhOkTgcn9u+x5qweY
    9gvXomZYJ7riIn9lhl2riWJp8hScp8Dj93bZuEOaFHe/D1zArXGTJK4VA0w9tCPJ
    fy0RCCIjWxo9j5fCLUakkLbSDlRxPfUjIMaWw1v26PUgA5Rsggxi3dwlqVJg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F07AZrtJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=F07AZrtJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBR2PIDMs7FYGH270VGUTtPUO/fR4cW/hWX8jdAGZtWV5F4oETnsP4PzKMDxpeN6+3dkClUVKRL25ioTKWt7kghWEmLjaBMXf/u3rCzllS7JbN2htriL
    ErBSk9+WwwMww8t0GNRsIYFlj01dSrtjhw9Dpw7XZLrq0q99P0VCkGjtLYE/vVL4KCPGVcLftbH9X54/TtSd6eJ1A8vELpypESfw3yCcEhPtR031vrWmIf/c
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=eJfxgxciAAAA:8 a=yMhMjlubAAAA:8 a=JCfHVUu5gEkzvycj3xwA:9
    a=crMyCahZqQ5rOvfK:21 a=CESwFkRpyRYus6Mw:21 a=wPNLvfGTeEIA:10
    a=dVHiktpip_riXrfdqayU:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=xM9caqqi1sUkTy8OJ5Uh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbeDICs7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:48:59 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:4960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755362AbeDIA0f (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 155/161] x86/platform/UV: Fix GAM Range Table
 entries less than 1GB
Thread-Topic: [PATCH AUTOSEL for 4.14 155/161] x86/platform/UV: Fix GAM Range
 Table entries less than 1GB
Thread-Index: AQHTz5jHsYAcyTUw0EmELQwh0iyXQA==
Date: Mon, 9 Apr 2018 00:22:00 +0000
Message-ID: <20180409001936.162706-155-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:VuJF5kWT1BB2KGRUybQ4QKWuuvJ8LsECx2njJucC5rbcNdAEzmhuQBX6w5Q1J19zBORFCdxkUILxqZgNW9DMNu9TlXLbSCk+MNBnkNauA6SBNFdMocqXDZElRUXumqVKGX9J7M9KTQ7EQP8Rrot8/iVCL+HvEVhHYa+1nW5QaMVjZnc6mWdtbu6tK9QORQjXxel5D6c6eggPpqgEjgJi74IDWOtpboIey3XjGmVlUOHDWnHmSDTVbaWH/Y7+e9aH;20:0eMATQffp7sppbPHxON1ZnsK50Ji/i7+naQ5CCpvbaPq6wtTP5zl6W9CKYDf914AY2FKwMDHKM+j566yT87LNdsGTkKx1TtlpcXtUQGrkVSC4jFMcV6BWuHwuxzf4PPMSPvRfZSSSWoGx/D+GBPZ1aXSRH2HX7YcOi5J/vowliI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a29f283-b041-4f99-cb4e-08d59db08709
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725F15586F49FDE456BE65AFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(89211679590171)(42068640409301)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(6306002)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(575784001)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jwlixcnAqTDtYoj4vJiFlGUSmrJJ/gIHfCj956ovtnd4tNR+FfqTIXyDC6Ibv5Zbcv3P7NJVpbnjQIKC8vNHbSVkM45OZK23h2Rdnr/exT6Rwy56qwa3zyuRoU4qK2BCIQtLkuRQt9phZj1NjHAAJQh0w0F6pmvrxmj0ll6t20g2bBkrQo1FLNDTBj84iR1SSYqsH6FIkdyemRXGmAAJzj+teXiFTzTsPr/Tt9jgxWPPgSviC678PYJZs10R+HSwnJVYDHfJWBspBOcgGluEyC3z0lVFMmZcuJB/B4PKdIi89t7A+PPWDS79F3UrU8YutBd/o10KUeCOdw84b0m+WSUe4wZ9eqK6F2hTkDL2Bwz2CxJABUQ0lvqD1cDk/Cg6Z5j6D7LPTd8uMKaPgyK4TMCzu4LkykZNp28uXEbrwAw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a29f283-b041-4f99-cb4e-08d59db08709
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:00.6904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "mike.travis@hpe.com" <mike.travis@hpe.com>

[ Upstream commit c25d99d20ba69824a1e2cc118e04b877cd427afc ]

The latest UV platforms include the new ApachePass NVDIMMs into the
UV address space.  This has introduced address ranges in the Global
Address Map Table that are less than the previous lowest range, which
was 2GB.  Fix the address calculation so it accommodates address ranges
from bytes to exabytes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180205221503.190219903@stormcage.americas.=
sgi.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2ap=
ic_uv_x.c
index c0b694810ff4..02cfc615e3fb 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1140,16 +1140,25 @@ static void __init decode_gam_rng_tbl(unsigned long=
 ptr)
=20
 	uv_gre_table =3D gre;
 	for (; gre->type !=3D UV_GAM_RANGE_TYPE_UNUSED; gre++) {
+		unsigned long size =3D ((unsigned long)(gre->limit - lgre)
+					<< UV_GAM_RANGE_SHFT);
+		int order =3D 0;
+		char suffix[] =3D " KMGTPE";
+
+		while (size > 9999 && order < sizeof(suffix)) {
+			size /=3D 1024;
+			order++;
+		}
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
 			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", =
"Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5luG %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			((unsigned long)(gre->limit - lgre)) >>
-				(30 - UV_GAM_RANGE_SHFT), /* 64M -> 1G */
+			size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
=20
 		lgre =3D gre->limit;
--=20
2.15.1
