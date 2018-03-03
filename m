Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120422-2-4370428453735032015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120422; b=THvsDSXha53wG8Qfn4Pl8jvli9VlKyte9CyOhp4jBW2xGor
    PLvDdRe6ypPNkK/ZNlMZJkCdhcf2maFH7M12BhUYPaxGdzilgTPV1vZdZw+xBfpb
    7BGKEs2sQpQ1WHbQT9bjnTWCqOACl9avGS5K9/D+zX8HK1W+eszBZURU/pIMKnvK
    T0sEq8xt8AV4NZkvATbpnEzvTLJUu4OozNowMeWdaWcLsaizkw0BQDubpy1E0deL
    gE5Ds5WsFi7QbrShgeqyWw2xokEFCoBlAWXYBXiuQKx6iNCzArioIqoh32i+32Ts
    AkJCaUaNcItJt9i25/tFv4pHARhXxD0ZWz/Ay9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120422; bh=mTnGJL
    1Fxh0QinD/COuhWgso/CYbjXpUKc6Q/IEJido=; b=ld7KYkzGCXDHOu1PwusRIS
    wOB2noTU3KTN5mpXX9P79ZDpGVADuVm6Mz5EqN/emNAX9+9+hOYqTrtU2b9lVlqF
    640pF6cRTD+U9kJ2zspzRt6B3ucr22JvOpgzvKE5Q44WUDSKDgv8vaWM8ZygqhvW
    Im5bxEGpswlfiplnqW4xWqdCdDZo2YwISMrYltjyypxn3wITA+0bcDutdqVXnBPl
    r7kupCvXrcSXLeBfuBy6v+j+kIUD/VBvBazp62GByN37tXxyFuTs7OHIWMzirwVU
    KLSBhvHbwMD+g6bbLprpN0l+LOmQi29BwEjCvtNgEK/6sqKHv3Pg6l2dk/1v8tKQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FSQQJDXw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FSQQJDXw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933841AbeCCXj6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:39:58 -0500
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:45030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934008AbeCCWfI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtech.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtech.com>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "petar.jovanovic@imgtec.com" <petar.jovanovic@imgtec.com>,
        "goran.ferenc@imgtec.com" <goran.ferenc@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 138/219] MIPS: r2-on-r6-emu: Fix BLEZL and
 BGTZL identification
Thread-Topic: [PATCH AUTOSEL for 4.9 138/219] MIPS: r2-on-r6-emu: Fix BLEZL
 and BGTZL identification
Thread-Index: AQHTsz8QdrbDSzchvEGasdnRyEGxMg==
Date: Sat, 3 Mar 2018 22:29:16 +0000
Message-ID: <20180303222716.26640-138-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:5LNwd0GTMkKvfxGPxhhBn+i6jX569fKSylhMl6oq+rIzTkndg/an1aXLzp8NcwqPdUk8kEXwJ0rl2JINdXW3M7OfmYfkz1wy2J52iD4Ls3MvSszwqaTSIffSBmCq4qS+J4VssSjA3ZjRKyqtIjI/Sw+GY4YAE5iTOmG6K4tF8sFb3CuDRpFOoDP0ALik4WvZ7yI1Un4xoPNJswGSjK1erecfDOs9WA27kls45yysbY99bq34Y2cCkFFjJ5CelSFJMlgUtP9dXvbqfSj+jENSsRRr8SEjB2lBrkMlXBO5R57DInnePPIQ1o6qw+4eSykfnMSBMAgs84GQ6/PYDtR1YNvjY3iy/e9+AeyIgkrmrhk=;5:dyhrFF2+ZEvqAoPod5KnLahIlG2zmG2XjB4GWnAnvOhYPmpMaBIULbd1wvU0T+SDU4mn3Lc57kh+hUxb7EAT1CeFjCRVpUvRcWDUaCqLbw/nEB+nW+czkWsyUS8+Cy489dGvbjh5VsuMg/19q4QQhJAuvR/he1X1ciVIiMKtVn0=;24:YJWiUW9IrN1iXaGPtQu0GDmvAWt9uXhoDPge+r2gTkv3qmxDMLjPgMURQLyqK76YKm/gvsIpgSWAfIPk7SMWleqMOxB6qmB7OpRWopB0gNk=;7:EFMcHbPKKfBiPVOIGvy0aiKFw/VTkYnylwUN0y+L0GOFunbLG5c9+QC+Y3ysDMyZ9RybER24D26FrwK0PLJV/G7iDepqn7CmDeLHVdMlO9EZmSEgQ+9cGjCl7gZSyylZT6zMNx7yYOnUNnuLf7kdUG0JJDeyUa3xzTzifrwnJ/DakK78c983Ac/a1jr2jEi5bO0tkvWmK87FSXN0JLOJ/CPJLUkZvRCs0jGaIL6n4CHVZ+Ub4Cmvje9mzViWkgkG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01b3c708-7a73-4488-ed2c-08d58156fcad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09247FCA4DC97E5F0BCF2159FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(7416002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(966005)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(6306002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b3c708-7a73-4488-ed2c-08d58156fcad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:16.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

[ Upstream commit 5bba7aa4958e271c3ffceb70d47d3206524cf489 ]

Fix the problem of inaccurate identification of instructions BLEZL and
BGTZL in R2 emulation code by making sure all necessary encoding
specifications are met.

Previously, certain R6 instructions could be identified as BLEZL or
BGTZL. R2 emulation routine didn't take into account that both BLEZL
and BGTZL instructions require their rt field (bits 20 to 16 of
instruction encoding) to be 0, and that, at same time, if the value in
that field is not 0, the encoding may represent a legitimate MIPS R6
instruction.

This means that a problem could occur after emulation optimization,
when emulation routine tried to pipeline emulation, picked up a next
candidate, and subsequently misrecognized an R6 instruction as BLEZL
or BGTZL.

It should be said that for single pass strategy, the problem does not
happen because CPU doesn't trap on branch-compacts which share opcode
space with BLEZL/BGTZL (but have rt field !=3D 0, of course).

Signed-off-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtech.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtech.com>
Reported-by: Douglas Leung <douglas.leung@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: james.hogan@imgtec.com
Cc: petar.jovanovic@imgtec.com
Cc: goran.ferenc@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15456/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-=
r2-to-r6-emul.c
index d8227f289d7f..9a46e52864a1 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1096,10 +1096,20 @@ repeat:
 		}
 		break;
=20
-	case beql_op:
-	case bnel_op:
 	case blezl_op:
 	case bgtzl_op:
+		/*
+		 * For BLEZL and BGTZL, rt field must be set to 0. If this
+		 * is not the case, this may be an encoding of a MIPS R6
+		 * instruction, so return to CPU execution if this occurs
+		 */
+		if (MIPSInst_RT(inst)) {
+			err =3D SIGILL;
+			break;
+		}
+		/* fall through */
+	case beql_op:
+	case bnel_op:
 		if (delay_slot(regs)) {
 			err =3D SIGILL;
 			break;
--=20
2.14.1
