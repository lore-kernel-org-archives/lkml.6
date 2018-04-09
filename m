Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233599-2-17569549866913269020
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
    1523233598; b=thdaZArif6gpz0X2CwVpQeFxUdSEHFQZ4VrZ/ssvN17S9cNag6
    5Fld4KZsLLNIljeI1ungz2Cc2Pc13hL9dejui39h5BPQZvosvpJekj7pDB+ebZAu
    dREtwvNLctZiqtzwx/u0Jo1scIw6QhCoA0LLdJCeKO51AYeh7Pipt0AsDmkvhSS5
    /dr6qHG3DAiBUNfwIC/+PZiXkMOZe3Nk1XlMnAT9XbXERwXux6dGaFkkw29KEJAD
    SMfd2E02QvsVHS/Q7jo1zNkJ88PK6QNIru2hm4IzDOaeinZyHt85PpSb6V7u+ze/
    AHgzYBX0PQjDNpMAW0Z6q14itk7h53eptAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233598; bh=PBzGKsoLwz
    yiBVNnZQt9QI9sopp7h9MQ19AIa9fWJO8=; b=hKcKms+k66SIGMBli5ETgRjrtP
    3ScDIm5PMTgkZTm3Pimo6ypfSjTTMYq1EbxWpqhodDh+AqJzIC8hLKaoW8Xbj/8h
    3kBpI8j6Po8QyHENYyfPk/AQC1b3NGtRTlCcnl/uzXjBug33LiTgPjVt6YKWAOuo
    B/yPATDkBObSPNEAp+0ZEXLDguijhkGaB9kOJehsQ5WWNZEVYoJlary3bu/ihIOV
    HzCxzPguQV0sJIqYo3QgyitkRcLfxiNW0W6wQFgnAj2Y/MW+lhQhBIqF9CVmtD1T
    ofjkfz1NZUsKW5NtqJplSqKM/YoRD9GXsYxX/oPlYZvTSBdJfZiynqT75QaA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RK6suKuQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RK6suKuQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBAYDry4OqOBr8ayPRLWkeslukDe6KQLyLpwP3OMk/E7UPVP0RC6nJhe1h/5R7xqKPa8+VEeIqsXOaF+0YFCpia3pWhD5IM3hRlW8RhhnllEBQ1O6g0a
    zxYc3tg/wMPfky3zEFtNT043TeVhBAWoEg4zInzLsNASHXQd2/eb3IofYtzZFZKQlpq9TQBcU+Tkxj1PepHbcrawoSoOnnurLmFc3CJ6xfEghMKSx9blGBgM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=voM4FWlXAAAA:8 a=yMhMjlubAAAA:8 a=djgKTt-8hIgr5ABG4PEA:9
    a=wPNLvfGTeEIA:10 a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbeDIA0b (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:31 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:42256
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755330AbeDIA02 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 147/161] KVM: PPC: Book3S HV: Fix handling of
 secondary HPTEG in HPT resizing code
Thread-Topic: [PATCH AUTOSEL for 4.14 147/161] KVM: PPC: Book3S HV: Fix
 handling of secondary HPTEG in HPT resizing code
Thread-Index: AQHTz5jCCfT3c+KkdUGQTzB4+308CA==
Date: Mon, 9 Apr 2018 00:21:53 +0000
Message-ID: <20180409001936.162706-147-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:DJfeZMGQdsLxYhYkODNEuD19ZVV0vBePMCrbm+xAo2JV4ORsWax7r4Zhljjhn7K8s3nMvgKRedG4Zl4KdtAyvL7Rd5anelm7D/L1Yrc9CGDe3iR/uMkuZGSH7nUzqEFd8XR1MsWxSJOWYnFZWlLqq2eKKN5mY2Xlf/nZKmLun2tqhEYbYMGkOfUDCySeRRyeFDsVIFLKZ0er7+rX+Zufv+FSUR6F2Q/lxqlUN8uRhFjp/7hjdfffZxxMGz0rx2ue;20:fqHv77Y4KbJ4tL0cpRUSFzc9DFCIunLYW6Sr7yL0EL7OY4a0d/Qj5DDL2+9gfCYDWBm2PCOU6TaIaV5yJcBW2fYYwVDbyWsTZMSnK6RYAFBv8jHZ2cgCjuToWhdv6GqJojpgJD+APG+rG6qy+PGC1TQjaAAmtCH55gJKBmHZtgA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85132aa2-ac34-468f-f569-08d59db08348
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072596E8318BE5F433385D6EFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Kxb1iBOSBGiY/EMqADZ4YkOnvOPX0I6sDUXU2o22zzsM1UtFwPK8Sc6TUZBlFfSvAKcikf4pPWuD5jAqKiZH+oG16WtqHDrbcyz83z9mg1rnn9hIs3scA7EqhLHYdtiZKvj33+67s6cNIMMR01SvUhenqaQ6gphNvImL74KOGdMPQ+IMuJK6QEEMUynSrThqOtl7kOv+Ws30GEDx1X6j/et+nCKGyF6majyLZh30XpEC6IfzrB07ahKjxFGFFZFb9m+mr5L7sEWi5FnDw3VDjc1DgI1n1RxKtRDGmY5fyn6qm5xC2dx2L+VaasliOXSTejwmioq5Fm/7UEq9A2URqsuRaWyECjeeQnM4C196xRRNLI/SJD7Xb/CMIRGv7JXqmY5+rEhU0zI/ZbeiQa2fBoX3iiomuAR7I56a3DtW8+w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85132aa2-ac34-468f-f569-08d59db08348
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:53.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 2645d484e945..df9b53f40b1e 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1348,12 +1348,8 @@ static unsigned long resize_hpt_rehash_hpte(struct k=
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
