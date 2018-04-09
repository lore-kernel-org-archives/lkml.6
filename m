Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244129-2-12394464405383073954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244128; b=orS4ASTgTfqigq+7PCFpSwomAS/ItfGZeWT0MJA1REPlqzQqV+
    7pzqCDJJQ+ZOdSVFX/+cUte+8Hz+SOPySLNwnXyJKv6veM78JHhwDFjOzFqmX2Vi
    2AZy7XnWRgabhGYMhXr7o47KabBOxWDkV/mYg1+IFeuROaZdTXi8wvdwP6DVTIV/
    xvG4BE5D5r9MB8cHhmhMER0KlsQT2iEHPk+/RXk7vReW2sTN/pxdAiCMVY51QMKB
    m4nBFcdQY29Ze8DtzSQMi1thV5qDUN92rkjuLFZ4aaJHtelfAYhrT1dc/qChkdrB
    kFJcAWKqQYk+Ky38FDzldv/Dt8+eRqcKfk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244128; bh=zCSWzUfBLY
    0Su5NZfad5+Hcsa+K7dAOY//kz84S/KMw=; b=A5+IKF2fj6N5Mb/ZsQXMSqoy1E
    ucopOgzrPtV1QOdul6USa7SpBln1eonmMTC++t/xa/1GkcnOzymIr9xBEspo+Lns
    fW/ow+/TNttAO8j/YBJ4MbJ6TtqiiuKdzgmSDMcj3EnmSQ3XHbU8P/9phqivBEpR
    Rak10emSx62RCLIS30+H3GpUA3GQLdnYeSqqmpoo3k4WDToRME/HJvcRgkWWurCS
    EBy8Qhc3b0lpjQWeAT6N7dikQywhQtBdCp8H8nmLBru53G5ioGirQSRdaPkYSd3R
    MprqnrzV5326NAL9JcPzY9bYwC9jRyfNg0MJ8YMcKyafa7Kxuy68WVheqF/g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JM7diVif x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JM7diVif x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHLsyEmI+fGQe0ldnNBIcY7uJBI9vMNsNL+XNf+SUvVoypHw9on40v5Ts5GS82g/uPP9pYBsKkaWDfOnICzySH9q29h5pEo0w29FPlIuGSjk9D3iDZJR
    XxGiOx1OU0fBG/mukLojEOPzXjK1yvOZWStVsnLVgDYf34+SHirdVBT2coewievPLmLICc0otH6oZwONMsQAmGSvVcMywW4G77NJKynF8M6PWiRaXpCN84zd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=EHaNKQqtAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=T-8oWK_BF47edkJ3rzYA:9 a=wPNLvfGTeEIA:10
    a=KIA0-nbnOXq3vJi0w304:22 a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeDIDVw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:21:52 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754709AbeDIAWz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around config2
 misreporting associativity
Thread-Topic: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around
 config2 misreporting associativity
Thread-Index: AQHTz5iLqRoxliRgSEKMEGprDVcqeA==
Date: Mon, 9 Apr 2018 00:20:20 +0000
Message-ID: <20180409001936.162706-43-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:BwfyZNkcCtnWMe/nPcTOql+kJwsYn7m3bOWnQPqWBUdzkVkHh4OeNtTrJASrhrnDsdmzxX3ioRVHJjOqa6JGQjhipSajYXmYlJsGs1j/m1TFd/D4UWiK1tJZFXTWIy0ghf9Df1hlm6pxK0xaAYBLqZWJprYhlbSaMDUtMvjxoYzRLH/llRGm9KahZ6pIgJMcQ7zq2lt3kjQOnUjqfaGxu+1nmlnQhVJRjXKZRRh0DoVsuRvXC1ysNog0wR8UXodW;20:QwuMX4cEtbojIoNmS+y+y/+F+Ab3dosmTyJxzMxCX31Cqld+ITUlv44VnVH6BL6qEy1AvH/IbuaFcwYaOfaYq+p95BLyAC2EtDCSyZZa8RwpJOAnOwlMO99cUhl8usW/PWIxziHigoOiYyR5krwi9KfNFQ7NDVLk1cW3VLAX71U=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27b9b9f3-5a75-4d03-ca34-08d59db00873
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101408A88CB503333584B2E6FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(575784001)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(6306002)(107886003)(66066001)(86612001)(966005)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rxPKo7YplgJl9iVNt2DJCQlQsjLpb0Nt93gVZMWygjiXUXENgiBBRpI7IaijKG6J+Se1V6rdctPBPlT3LilqDiJFOkf0dfLJDswy7eFqyBgY60lrQ1ibxCOYyDYOEuaPay3hgL2zs6uenn9TlPo+toAHz60iOwGb5ZYqJ6c5oxAqMQL/Jvk5Nh85QmsQj/xzu2MLLxN3iwgFsqmvCbQHIr0RyDjofGJdp0GCKvVCNEe1lMb64Jh17x2I8VaMcohPbOIJafoBxMn2GTbkIHk/sRZNR/PPTDuG6p8rLvfUEN1O/XSayv1C9fDIDnChCv4rU78PxSGiZGa8/QB8xgitIUZ6kvnNtz8I0VmZovGfji+LwCr8mhpywhJ+s+kFijhbgUPaTlIKO7PXGOFRm/F2VvskwRaqMAYN1zTzyaSAtjc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b9b9f3-5a75-4d03-ca34-08d59db00873
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:20.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maarten ter Huurne <maarten@treewalker.org>

[ Upstream commit 1f7412e0e2f327fe7dc5a0c2fc36d7b319d05d47 ]

According to config2, the associativity would be 5-ways, but the
documentation states 4-ways, which also matches the documented
L2 cache size of 256 kB.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18488/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/sc-mips.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 548acb7f8557..394673991bab 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -16,6 +16,7 @@
 #include <asm/mmu_context.h>
 #include <asm/r4kcache.h>
 #include <asm/mips-cps.h>
+#include <asm/bootinfo.h>
=20
 /*
  * MIPS32/MIPS64 L2 cache handling
@@ -220,6 +221,14 @@ static inline int __init mips_sc_probe(void)
 	else
 		return 0;
=20
+	/*
+	 * According to config2 it would be 5-ways, but that is contradicted
+	 * by all documentation.
+	 */
+	if (current_cpu_type() =3D=3D CPU_JZRISC &&
+				mips_machtype =3D=3D MACH_INGENIC_JZ4770)
+		c->scache.ways =3D 4;
+
 	c->scache.waysize =3D c->scache.sets * c->scache.linesz;
 	c->scache.waybit =3D __ffs(c->scache.waysize);
=20
--=20
2.15.1
