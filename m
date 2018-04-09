Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245420-2-16789072041302936147
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
    1523245420; b=eiUublmLCYoLU9BNrxNMGsqzWtoyWJcbEGmsuQPDr+NKdNIInQ
    XIuT99m5uLorRfP6I1YS2Nf7tF1d9yRU52qFVJLEXOM/BlFnfkyoWTQBBXoOLLj7
    V+QxlTcpOoaw5C9y+zG7kKvHt4MHzVNtn5/oU2zaCjXWI+WhJA1a2QVcJN3eLirq
    JkCZV6gifdcozy7bhF6apHGpfREz3khw5LCogPztdscre5gaeFBxndTdp+E0zygJ
    biltCFM4QhJG42v1DphPtViWEGgP4niUFhDpY7GqMlU2iOdkh8NYneMRYoPQBrbs
    4wMjg5+gxWdhmQa2k+/Nn5HnvWuGo+5C2x5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245420; bh=Ig1KXT1k0u
    uXxwdKYrj/gtJ28He9/1KBdqQJPaOYAfc=; b=aePaou7OUzitnadgtRb18NKdX9
    AGfRThbZpVQy/udmVLLeL8vbTCGmjfcCpSGyHH9VugO2htHcjuBxfJFM/OfTCUSB
    1XlCYbaPX6/DWnfjwTk4yu6tawKffVPgrmEqn96fl3HQKFkQxPpGLc3hO4R4qrOn
    IvrMkTJnLE7wnIk2ZrROHCy1vwgok5NHXbdqCUa1+t7gxTpS1wkd0r87D1fM4O34
    uq/7ZcvslEcxdP4g7dp/l0OTKUpHdMXFnivz8fN/Qm7bztb7e0JvMim9iPtN9X8y
    5ESaWZ7L5OnY2ui6YW+ewdZnnN07546/AyDxJOds5Z5CZ3cO3jB5a928JyYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q0DUuNL5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q0DUuNL5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFILkCKYFC7fQnZ1ZyHs3qJCpm+V9rP+D5TjGLmZq/+SNKf+8ogR+tVcdNixh6pbeTANxYg6j/Y/FjPUQ+4MYoazEgRgXnwkDaGJuwI1rp3wFucBJvyE
    kOX/OEfua3VNTtzH72bDLf3QKcV6Vdkfs9gWRrE7Cihrn5Ub9V+aHZaybylf6Mg46A0RLdAIzn8qRQo9tfWBnMNQFF6AdIROcBHzbSiJGaZzr0o8XicEx+aK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=NfJ-nOMBdCiM8OP8BF8A:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDIDnX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:43:23 -0400
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com ([104.47.32.138]:56136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754241AbeDIAUd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 147/189] MIPS: generic: Fix machine
 compatible matching
Thread-Topic: [PATCH AUTOSEL for 4.15 147/189] MIPS: generic: Fix machine
 compatible matching
Thread-Index: AQHTz5hTfq8CkF0NfU+cDzDQiScnlw==
Date: Mon, 9 Apr 2018 00:18:46 +0000
Message-ID: <20180409001637.162453-147-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:Jq4qP3/j93Rxwd7azGRWiQ5l3WxAE77GwBy+v6smIoHZXXILhICnURg0OtNo/O5QgrCFy9ONzKAP7bjnee5Mj79C20qck6EtW8t/Y1vB+LCcQ8818He8rfxRhmK/WwSizE8Pl2gbn6epvMZhg3QHgSA8x0mpPhncYs8A4WON3+l7cj9Wqr3SLOC4vYWwB5/ZjMMdCcxrZsF48z+RZjbA47ktzXq/FiNEU57ff9xUocc3CsbrWTPT2Np//GDP8WIo;20:jd2WAh9bdahphJkGn8KPr6+AokbPk0fuwJB7iAqsjV5Jn/lmASIuYCdrmW/yyYSJi2Aag5G7wKNii8YB7d5IaKscMIOC9IJjlm1sBJ0JK/Y8QjzqOloip7PpAwojP7nXp3a9Wuh8DxqwxllZdqfcVK4Mxz64IkYmML55fPCsKiA=
X-MS-Office365-Filtering-Correlation-Id: dbe701f9-630a-4317-8bc5-08d59dafaffc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920C0CBAD5190E8E0F90F83FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: M9pra/hXKfG2QONbwE0qc1H18PnjXi9Fv1cmaIAoq787REkvT3+ALNHCNDf8KPV2806Xv7xlKAkFio/DgK9D2i+/rhz8IJKsA4+4mqnEwqj6iWj9PkpIiQ67ZVESDLieQL2hBsh4fy3ZH6h+VqbHHSPJuq7pq/DN6lKba7GroSwVfKA+B/qSAEfzz/kcE16OFADaUbI2M6bWXIe+fCRgO8G4vcwfJnvlHtq1xvA+WyOxQb3kXVovkddlejt/ZH7aoQgm+YLLKSHnA8qLf6VgtZU7Ywb9MoMQhDN1oJduPKTE8+Tz9BQYsRDVmsnOaOC9Dx8+OZnniHMm5nMxo3v8WpKRG/IKC+roUmqtt8QMxzWc/GlNE8Mmqa06d4VQfMAXORv31OVrxCRXcHnsBjjSX4pcLWeVi6ynuq8yjUUoVf8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe701f9-630a-4317-8bc5-08d59dafaffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:46.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 9a9ab3078e2744a1a55163cfaec73a5798aae33e ]

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board suppo=
rt")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18580/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/machine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machin=
e.h
index e0d9b373d415..f83879dadd1e 100644
--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct mips_machine *mac=
h, const void *fdt)
 	if (!mach->matches)
 		return NULL;
=20
-	for (match =3D mach->matches; match->compatible; match++) {
+	for (match =3D mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) =3D=3D 0)
 			return match;
 	}
--=20
2.15.1
