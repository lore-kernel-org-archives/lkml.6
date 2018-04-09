Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240065-2-2709302042229182726
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
    1523240064; b=pMkM3Hu0DBVdPLslL5+sxGYzkjC9ncxIm9BsDLmt7vjmnWj1Vc
    oW5fixPxZJzX3524Mpm36tXXBflOXwbDgopXpdis4AqFHddMcAPHSlihixYaknXR
    zSJ2sgGfZNgY+mSKC8+BKEoWiLUbYVkKOddwpkYj2pB1y4TAfsG5qiqxIvFWr+E8
    gT/LWfq7aXCAp8wtYJ6z73zoNDKYKJ9d0wKjOQtv6AmgmiDHiitpDzSXLyaFrE7u
    orUCagXs1g5hD9MJgq/biaP1CmzexlsL+2rpU0SGbmb5q67LO/La/DOkycRsdp6f
    2eu8SbmBSf/R9SqTs7qsluYBLOL8IsAeDs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240064; bh=YbjxocVPs9
    oD4Ep9oO9gr1v2MfZhOHHU4bgXL/00JGc=; b=XXWOrXLMMANXGuN3VpdkAV8sSM
    ilVV+v3p4Dz+Aj2k+pKN7naMSbWm9NuOVriXjhWuuZX3HgtbzaKy4Kvq/Rk6X+T7
    ij6KEHND5YG2v2PGS+O87yEKm/w7F0Eh4Lll0coP4JyjA3TXavoeJc/c6P8VyhK6
    830F+yv5e6b3yVJe1NC1AUoQhN8WBy3SBfrp3nVetePBHsqTJUj2zMi67TkQusQa
    uGMWtWPMr3hbXDNqC2sLfq+Y/4Yy/8vfyc2y9uZ0Di89RQEOuCuBpsRcVALORH9Z
    yr4g0ORVVwgedQTrfCcV6Xju3xFUuQZ4cCIEvnNucytjmM2bB1Q3ocOHXJeA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Uz+w58mY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Uz+w58mY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF09CpNU1VJaX+di1Ona2yKQ0PfbLYYyDb/PYe/ZCRwKVtaQTRRU4DEPRBk/hQ4rKoqNukVX8dC76xzqNLfBPmkw5WuS8xsOjljJgotGwnSbHdK0NGT5
    AhFrXScw0ArjX8KYO3WZxYwtWcriltpvC5KmJqeQevdBVei+Kp0j/3DlSmdPZTWDdwiEJeQgp61i5HOPcg0dENR7rGtPBr7zj0ynSQP73K+cdwRyVbgc3IJd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uAS_uZ3KAAAA:8 a=yMhMjlubAAAA:8 a=oIfBM7T56LFt2f8VNdUA:9
    a=wPNLvfGTeEIA:10 a=_KzJdI3Ai4rueFdl_XLO:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756095AbeDIAan (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:43 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755318AbeDIAai (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 149/293] powerpc: Fix /proc/cpuinfo revision
 for POWER9 DD2
Thread-Topic: [PATCH AUTOSEL for 4.9 149/293] powerpc: Fix /proc/cpuinfo
 revision for POWER9 DD2
Thread-Index: AQHTz5kstkOxvEBRfE2Gm8ySPf7jUg==
Date: Mon, 9 Apr 2018 00:24:50 +0000
Message-ID: <20180409002239.163177-149-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:OPCdhs9X0BQv7YLut6ycq8wI1dkhEJBJuZBkSn/mdfUbtId17TtSJBG/oC6/NgKh5gaIGr1GWE9NG3Yq9QhsX5bpKQWeyyYu2wJY8JwzdOsa2k0V9TGNm5mPmjbbpx+VNHE8QSW3dR1i6XqTXYJIHMLE/6Td5plsAGWURlpz/eK88j6DHrlq0o0rQ6n4HoY2hG73GmCWwLPwKPYSrGZHC4KlXs28/xk+BBDXNc2h+I+2lAy1rlrUPGhgToTFvRGZ;20:dckChLgwgl1f7a+JKP7qh2uUjDk06ZjxgtNHtX8DIBYceM9koJIyJp81IUmfCniBxvHNfZUoz3FRwp2yyy8M2IM1PMSu7FHVKObogiaHTM3RHdDZpi/gYAjSxTut5cS4qJQf6X8Bjz+jxNrO8zypAFfEbmkUyuUnGJcVUu0YTkA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88b99fc5-26fb-4572-a21b-08d59db11b2a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080709A968E34238C32FA64EFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lUIuORH2QcbSJcZMnZwzHXcOT4VcuqWjYtxXgXMNEEsz2iwzQWB4aXWpcXb46b/cKQnB3VQ4SD17CC6PzWn/RVxhUU+ha10EQR7KVioOKDpedegOFLu4hkm6XnhQ3W37Fjj4diZjBRHbCVDfbIJV0Imv1JAzHPWMqDkyssgAPMYuZJBrJ/Zpl16O7885pxDP+WwckS1Kzswv4eyrpoXKfJEAdPBgwe67CHMSvg4YA4blRs4J+KVJhoTOJyAipyBaxQzmdsMX31KS1u3bLIYIBHJ/Pxp8K2r8PMnv+c+bg1jZgdq5l1b39fo66Ht2ArMK7Lh8aex5dsf+QNmIu+TlKkQHW8/An+FvmNK7axNb82wGwZieuqcaje5/fuPgO/b6DbN9sk//74m28J6lP8jT9D1cTq+XZwkmkC9RvuLlizc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b99fc5-26fb-4572-a21b-08d59db11b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:50.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit 64ebb9a208c6e66316329a6d9101815d1ee06fa9 ]

The P9 PVR bits 12-15 don't indicate a revision but instead different
chip configurations.  From BookIV we have:
   Bits      Configuration
    0 :    Scale out 12 cores
    1 :    Scale out 24 cores
    2 :    Scale up  12 cores
    3 :    Scale up  24 cores

DD1 doesn't use this but DD2 does. Linux will mostly use the "Scale
out 24 core" configuration (ie. SMT4 not SMT8) which results in a PVR
of 0x004e1200. The reported revision in /proc/cpuinfo is hence
reported incorrectly as "18.0".

This patch fixes this to mask off only the relevant bits for the major
revision (ie. bits 8-11) for POWER9.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/setup-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup=
-common.c
index f516ac508ae3..319a886b1098 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -321,6 +321,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 				maj =3D ((pvr >> 8) & 0xFF) - 1;
 				min =3D pvr & 0xFF;
 				break;
+			case 0x004e: /* POWER9 bits 12-15 give chip type */
+				maj =3D (pvr >> 8) & 0x0F;
+				min =3D pvr & 0xFF;
+				break;
 			default:
 				maj =3D (pvr >> 8) & 0xFF;
 				min =3D pvr & 0xFF;
--=20
2.15.1
