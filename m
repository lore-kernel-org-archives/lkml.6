Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244866-2-4776036791239138537
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
    1523244866; b=TQUFGfe1pcBHb2nzJGxFjDWstR40T8PBTdggB0L8XAm8UCxJ6L
    NsRF1WlRJqgh/0LDFgsxpgQxHKAK+mO6USuQT8Dy9hklJrNwsk5QKZBuzcdRrodG
    M0EVE6SE/1l2tAj7ZubOg2LPZ6vip2GTMu90zxpb3ZaCK4tjoaoSi5JeEhLvmOJk
    936zTHBSGUtPulnc1TjZLEzeiY+6IN6zFEw3XoKh2Xjd8Bt+EdbqpuOswXKBwRcx
    o9uN0PBv4qbv61wUCWZfy53pD8hOTzsW+ai1E7QZP90GvJqu6kZ1bwU3i/961WNj
    DQLL6X/6TyxVdv62xjj0BoOqTs0xS726F/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244866; bh=WAcEfqbuCD
    MusKtqfp3KH8Te+KjpF87/rVI4Y1U5qDA=; b=Ebe4Gpoz5ZFduZ5yyRSizvkxqt
    m+kxtda57Jppg3lVscdKNyP8ZdAJRKaX5wMgR8brEIvFDZM1UdKvWsSarHiS7W89
    mG8+Bh7S5I+J3/ofUyCwteaen6GPY0oCkfn8bcf6fsp0K5FT4UxonBREZtLKHYTL
    zHyfiDtLKYyCxnRQQAbdX8v7AEfn+gAwj/xDfeEgQGpQgFvxISku+CHD9tkSQbcF
    spg7dzL3eTCZbdX0zTHr5D+At84cVuh/j55Pw2TaRIfCUJMUGrPAQ6hCxbIzdaEl
    uZ9JIenVA7tt5t/dyNjU0BZHv5SJP5oO32XlCknnR+dyrNG134Na1VoCxI1Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VNpIHpxK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VNpIHpxK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJI6ai9tkvMsZgi/q3IERnrBKEN0G6XxoiKqSEvTtd4sdc2SMwSRRfy9bRuFq6S6pW3v2W2UsWWrxSYDYuWqv4tsBoVhj6GW5s3VlBm2KHph5OV4w+HO
    tA1nsr88T+NcFZ8OnyyKY5p8OnIdPNHsWwDbavpIF/wuIu+vq7L1dj2bVXuFd7IHju0jQV16+4PHHwE5nZWlTekKqlTr7xua/geTXVMUGDY6jq6TzNGPSNXg
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=voM4FWlXAAAA:8 a=yMhMjlubAAAA:8 a=djgKTt-8hIgr5ABG4PEA:9
    a=wPNLvfGTeEIA:10 a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeDIDeJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:34:09 -0400
Received: from mail-bl2nam02on0107.outbound.protection.outlook.com ([104.47.38.107]:21664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754436AbeDIAVS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 174/189] KVM: PPC: Book3S HV: Fix handling of
 secondary HPTEG in HPT resizing code
Thread-Topic: [PATCH AUTOSEL for 4.15 174/189] KVM: PPC: Book3S HV: Fix
 handling of secondary HPTEG in HPT resizing code
Thread-Index: AQHTz5hfkpakKxfJS0irQYHNCn4Uaw==
Date: Mon, 9 Apr 2018 00:19:06 +0000
Message-ID: <20180409001637.162453-174-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:WFk4mFcbe+xmGIz+JTFn9WXzFmH37FHDUIL0KBTpg2w8x2pnKI10MQBkHLnITF4y3LGT1BtL6XM1Zb39N7O7AGmECKr1SvFGjjZ/VsENfl/G771lRW85ad4MzTqGtLM67UDIK3j95LGkBMzZUvvK88h0eunDhBxmxPqA+p6QzAsKcTjmV3KVOT0O1SSa0jgt2zhEGQgrpuJz2BuWhC1LKO639CZNmFz+SV3CbSwGkXto+pONn2GVTuluIgbg7SJd;20:LNsaKgYiS+Awa/D4smkPbTSOoP5aFpIm31goKUQYmAXHJGu6nV5u08Ba5BfLfQZ5PzXccDOQKAS9eY2Q7GyrLThtZedR2itZ+wn7A5L/edBVaFwjpVW1No9ooI09XiAptDk3tZWY9cJGNXc8dmM3AcpKHuClAAOkJm2Y4rStjNs=
X-MS-Office365-Filtering-Correlation-Id: bd4b4eda-ccdf-453b-bbc3-08d59dafcce9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125CD97755F26E200113784FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kyoB4n87hHJHuyZi87pgjBca8ZdFWQIMDG5xWSbEfdR/oYBRHRDf9Tru8+0kWwipac6fzoN+/xKxKYOUaaTh9SHJr84Prvc3K7ST6D+BbHAt4dymERogOfmIrhasuwGLerX26Fi/bBUAgNwVCgpL21lUgfAr0zZ9/ZIpsawCu4UEIqhj4j+W89h8ezBDwsogPHLJNnWTPVXwpGlnyVdzU4VCa3w9n1hGcPFVuqSwZZ8ANtIwKQflMpu9neLfvqAXT864iLAn0fkWsEBcSnQ193GrTEWPquIoHdeKGOxTWw/hbym84wdiH+fQsSgCuF+EkU/yO9KKv/+R87ro0X5S/PKXcub71eVjs5Fil8hDqjgyZWQf1NDEmcQCTsy3ZP00SQwGXSEQ3Xt0PcYiu4jmjC6tHrrJsP/l2urgmYd75qc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4b4eda-ccdf-453b-bbc3-08d59dafcce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:06.7990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit 05f2bb0313a2855e491dadfc8319b7da261d7074 ]

This fixes the computation of the HPTE index to use when the HPT
resizing code encounters a bolted HPTE which is stored in its
secondary HPTE group.  The code inverts the HPTE group number, which
is correct, but doesn't then mask it with new_hash_mask.  As a result,
new_pteg will be effectively negative, resulting in new_hptep
pointing before the new HPT, which will corrupt memory.

In addition, this removes two BUG_ON statements.  The condition that
the BUG_ONs were testing -- that we have computed the hash value
incorrectly -- has never been observed in testing, and if it did
occur, would only affect the guest, not the host.  Given that
BUG_ON should only be used in conditions where the kernel (i.e.
the host kernel, in this case) can't possibly continue execution,
it is not appropriate here.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_=
64_mmu_hv.c
index b73dbc9e797d..dc0f2ade589e 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1337,12 +1337,8 @@ static unsigned long resize_hpt_rehash_hpte(struct k=
vm_resize_hpt *resize,
 	}
=20
 	new_pteg =3D hash & new_hash_mask;
-	if (vpte & HPTE_V_SECONDARY) {
-		BUG_ON(~pteg !=3D (hash & old_hash_mask));
-		new_pteg =3D ~new_pteg;
-	} else {
-		BUG_ON(pteg !=3D (hash & old_hash_mask));
-	}
+	if (vpte & HPTE_V_SECONDARY)
+		new_pteg =3D ~hash & new_hash_mask;
=20
 	new_idx =3D new_pteg * HPTES_PER_GROUP + (idx % HPTES_PER_GROUP);
 	new_hptep =3D (__be64 *)(new->virt + (new_idx << 4));
--=20
2.15.1
