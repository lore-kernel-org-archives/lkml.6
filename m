Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120329-2-3246356515843418827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120328; b=ozNTUW70ouytW708ntqSaEX3qHnSsKh9q61NP20EfIHa32G
    heijYxl5MqbiaLXzmybU/d5n0nXyik3kIlx12MowB7wteuRjuEiuEgHp+1a/yh3r
    jWFJ+BlCawpcDh35p4+B6hsMLVwB3w3CPNq8vHzG7LRpULXye5XZX2ENXN4dIWNK
    kc4FqWzwTUqT8qTmcdLLrNpXO84J4GpuqS/9UTUqxfFUWKmgYpk6JBIRf1/0pfPJ
    S7IAjON+5kXZqCb5L5WUzU/De3kUXWTbhkmRxeanRB4EDoKWPQZ8f3W/1pOW8mFq
    yJxkXQY2vlwWVyUDOFEDNcUx2Zux+GoQnNHYyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120328; bh=lo5iH7
    8F7Ew5m7Bs8Zdn+pu+p+Bcq/xgqjt4GCK5sts=; b=TqFdlcVdyi3crK62GrXgmh
    JBV5UtBnbEfoB+tr9UJol7oo7L7ssZjZZ+CFTz+gsRH9QddySrEtpu9DupCOKzBa
    xRBPg2qgcsB+v1Vo+pr/eD1UPS7egSWE2PiRyEpqzP21zWY0IJEf4DmQJt4ZqqYZ
    NJIOuAZkoLRAH9rDtitb4J7eTE8lAGocrcX8Dqj/n82cWiSYKqawtMEAKiZdnnj1
    lxQHX+HUHiTBNhlic3trT74Zsk3q7lF5HKrRhFG78xGhE2tV7R2StjK/fXppame2
    i2kOgr9zf7Eb62cB4rRSqK76cXJkUEaOzUqYkpwouab2k1VT01PXsNxeM4g5UNYw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V7/p9eFt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V7/p9eFt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932772AbeCCXii (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:38:38 -0500
Received: from mail-sn1nam02on0112.outbound.protection.outlook.com ([104.47.36.112]:45329
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933677AbeCCWfM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 145/219] powerpc/nohash: Fix use of
 mmu_has_feature() in setup_initial_memory_limit()
Thread-Topic: [PATCH AUTOSEL for 4.9 145/219] powerpc/nohash: Fix use of
 mmu_has_feature() in setup_initial_memory_limit()
Thread-Index: AQHTsz8S/zz2tFpZxkCodPf7zRIj/A==
Date: Sat, 3 Mar 2018 22:29:20 +0000
Message-ID: <20180303222716.26640-145-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:6zsrt+B0mvuKoWj7VGdkHGgtnkCxZfrG8z4Rsg5qnqKWbsxzfb7IOs/ZuOHUFzxafYZprOobtW4GRFIKKBTJzFHVEokap7cGO42Iu1hOpH4sXLnelMmPBW7/H0xnbDwR5gMWJ6sM36je7dQXucYm6WQ0Qxw99+PwGQsllKj9nzu/lHSYMSd9Q+n/YeYeP21Dd+yPFiBt2CcNyz+d0+oX52qxkMyv+QLSVtmkOoQMiKH4F+xMhIarz+3MQIG+FNQGXke/Ha0g4DfqWG9toAvL1xQDdQz2IK/yQhfCvw2amOVX/fVr1faYB6Q5YqjoAu1hHbFdgUW+ZqcbN9qRz2GUxnDd7cx1v5hhFV54COml270=;5:pwhTf0h+vILlcGx3vnSVjsMpaheYZmoQp+nMAeQeJdgvpf/IEz2U7sh6fTY9bKsWY92PUGlAvmRTEqgZ6xFtJnOK5mmj+DSlYf3T20Hv7NFoVfLCSJs0sY0u5RbC3ezEpfp4G0soQzpiM/0M5h1Qq1SPO5bmINtcOrGNZuHR5/g=;24:cbMOXhKkwdpQWqWAsZKnFzm6L7rowbck+AFh/NtCbw6R5j8Pq6FFH2VjAQmskBG3uwgoH/8QfdbAqQTUk+/w+hrXMx3qcZHeSbQ5Bofawkg=;7:bDKPNAVWnMEatUmlQEjLc8SfkK7oG1PBEAsJqbstTtY6aqNY1pekJmTH5qkCOKDnGl8oyU7f+RxAkNd+DgnBrOjZudTgAp6YSJ+5IkL9bVS6WCBfjgflzUAFLhqbEYVHTRSo11aUyGeqSXAaagvtONoWkVwKuhxn8aVKkWqDtQZRW5BoGz2m8KsvqzRl+I1z92xlfxYT1yOrZhUdwZ+Y2twGYJA8UUxn/51Zz1nB1KsSHvR0ViscbYbA80V8SRNa
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad7e3df8-cd1a-48dc-ade7-08d58156ff12
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB092472795BFCA47B8E7BC455FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7e3df8-cd1a-48dc-ade7-08d58156ff12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:20.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
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
