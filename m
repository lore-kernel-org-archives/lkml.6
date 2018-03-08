Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490958-2-2383716914470737231
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
    t=1520490958; b=NPUYnylsLFYbBT4vdJGuZzAiK7TLqtxI71BWzFDpaoFIOwg
    a59rnWoPnuhQ78e8TvdDSR7y9D5etZP56bhbxDQJXDFzEevO49zXzHDdvsCnrYPv
    PFK0BaRaFXf+y+yj5IdQT55GXWBP8J8RURhojYfOtF5rTucUtFtciAnnqWlVrBEp
    hlSH5Gm3Ejhb0vAZYX173GobXkxV1t5K1XmZzuHig8QPjy8TmRF9PyKR8fXxeZp9
    DHTPOGRlkUB7947nyyWFGmIjlxS9TANY6ZsEdNWzIpxggSRZpTngr011niwLPc9t
    fUVsZ+mpK0ACAx1tmOSX/5+wgH7M58Puq4+trzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520490958; bh=lo5iH78F7Ew5m7Bs8Zdn+pu+p+
    Bcq/xgqjt4GCK5sts=; b=sRd0EUwDU54oXwjy+chWnvj77T5e0Nn8Vfe1Cq3RiG
    M1BcD3SLpA1pBPtqXTjp8aQbDA2KpnGOZ5n7S0XeG6Gce1pUpW9pWH4etHqtiFBS
    oAPrzwmtrMIEN+xU1bdUglg4+wtjX/6yXW0a2NhQMO7iq+g057bVrDc/EDYoG7FM
    vtMZZ9M+Az2vmyciGZe7+UjOGZZCUOIqtLi/PnEcncn5FqIYXInNXUP+Orc3/ohw
    7hPIU7BdthTbxIDoQaEKn52HFtFhUhYP7LdKt8tkbvs425gwBNGVGy77E30gwitt
    2e+2RIFYEJb4Dg6nBX0FPaQgb5qwzq9eCUTXh7/8KmVA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WPmln8Pu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WPmln8Pu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755319AbeCHGfi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:35:38 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965486AbeCHE7z (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 001/190] powerpc/nohash: Fix use of
 mmu_has_feature() in setup_initial_memory_limit()
Thread-Topic: [PATCH AUTOSEL for 4.9 001/190] powerpc/nohash: Fix use of
 mmu_has_feature() in setup_initial_memory_limit()
Thread-Index: AQHTtpoj8bIFti/sx0yVCAWGaZUjuA==
Date: Thu, 8 Mar 2018 04:58:46 +0000
Message-ID: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:B8i/qMgEkq65g0cta9CNj7R5J0TTGhn61oVQUHS/crwXMpkmRaaSDhxCa6AH7OfSzjgwjDUcxrPHcqZNyw9VKwnWSYOZ9PUQ10jU3LIUu8keQe0wsHwGkQTcRJ+fJngUcva+Ter6w7oGqAG364W1m1yoCO1QazBx510Z+R3oYovfYfPcV2GdJbpF/R55I2604mFkNOY92TTcFRFr7lbdJW9bCjw0Lm+tWMlEaY8Hg9bLOIXJYIa2u1lvadrAXgBK;20:OmrSSC5Mq0y8qf+yBx4PcCEbaMiLvTsabb+6NdEI31Td6zH015an0dGZ3wk7sc3LVLzZxrzsZ1XR+4pO7zv78k0UY3XsjUQ57/xRjMoSFVsiCnGvo4WxUAin/Q4jzmCvTmhwHnT9mmf1DEBV/70zEa92yEpAcsDc2RX9s+XRfTU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a087fc38-5b60-4c8d-4e3d-08d584b16cbc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920FA6B920255D41ACBFC15FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: QWKck0c4zFmD33IBF8EonvisrZ6nc0skNprAsSWLy/RIo4j5R9VNJxYGB6v3r3r+VYwameKfX8x9s7+KhS4pzWSpVUkKblNOOtq60T78a5zU3n10uwQ0FIt++HYO1+y8AGqB9i0uFJHg3rw5Tc5SwytU/Kze/aCp3/0nuOWWDCrkXkhJmUAyYMRlDqjxjE7qUze9PrsbJoCpvNlJdQvVb2RBBdGZ1Xl0AUhNMTtd8IbO9yzxbWv/b6ND48/c22RzS4HXD19WJby29Fz8jpXnFwy05BELsjEBxlG6JOh+qNjzzjvjFWrky6b/IhwFk7tDBPd7DW7x//D8/iVxsvSluA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a087fc38-5b60-4c8d-4e3d-08d584b16cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:46.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 4868e3508d1934d28961f940ed6b9f1e347ab52c ]

setup_initial_memory_limit() is called from early_init_devtree(), which
runs prior to feature patching. If the kernel is built with CONFIG_JUMP_LAB=
EL=3Dy
and CONFIG_JUMP_LABEL_FEATURE_CHECKS=3Dy then we will potentially get the
wrong value.

If we also have CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG=3Dy we get a warning
and backtrace:

  Warning! mmu_has_feature() used prior to jump label init!
  CPU: 0 PID: 0 Comm: swapper Not tainted 4.11.0-rc4-gccN-next-20170331-g6a=
f2434 #1
  Call Trace:
  [c000000000fc3d50] [c000000000a26c30] .dump_stack+0xa8/0xe8 (unreliable)
  [c000000000fc3de0] [c00000000002e6b8] .setup_initial_memory_limit+0xa4/0x=
104
  [c000000000fc3e60] [c000000000d5c23c] .early_init_devtree+0xd0/0x2f8
  [c000000000fc3f00] [c000000000d5d3b0] .early_setup+0x90/0x11c
  [c000000000fc3f90] [c000000000000520] start_here_multiplatform+0x68/0x80

Fix it by using early_mmu_has_feature().

Fixes: c12e6f24d413 ("powerpc: Add option to use jump label for mmu_has_fea=
ture()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/mm/tlb_nohash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 050badc0ebd3..0b50019505a5 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -751,7 +751,7 @@ void setup_initial_memory_limit(phys_addr_t first_membl=
ock_base,
 	 * avoid going over total available memory just in case...
 	 */
 #ifdef CONFIG_PPC_FSL_BOOK3E
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned long linear_sz;
 		unsigned int num_cams;
=20
--=20
2.14.1
