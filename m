Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246621-2-17401164328967342427
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
    1523246617; b=oOpCxXaJ37hD+cvAyH+rU+IgSw/ymtjOdxxG1azl0n/4oDUjYx
    vLqf/Kdo9wTXF9Q0cJGhvzedoPhkFgjyIu1uLxJI9gl8UWYZVWw/eWK1E/FJz7EO
    nBNU1crVFl/y5QGrxvhngtEOxRgMKsCEIp9TMgDCYyQhNVqVL5gt1iROoHc8jXfp
    JYPEGGNgsAgqtWASEqeCO/jPVi8udIsyYQ4rR9ok2/2l70pBMZZ/HAQkSUg+s6D3
    UsNAfTHchvIgrHoPV7s4bGo4cePsamTDExGdFlmJqDei2DJl/C8jzMrHPOWejPgD
    2pc+ePuq5VMGV2e4T75sR4BYBFkF261SPZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246617; bh=zCSWzUfBLY
    0Su5NZfad5+Hcsa+K7dAOY//kz84S/KMw=; b=VRLBisHAjXRVYEtS1j0Af7Y/ae
    k76Iqs01aPdZsxVhH+CJ1Y7wX6YplPs1wVXObbphrIvdBfgezXYiW/lnODPlmhg9
    ArcV3tWOwq0qKxJWf9uywHFKiAh12EfP8nZ79uy+CRvek65FwXublCVHyN7yNNua
    SizJkrzBLP0ohZ9nlW9egd1HCygwjXhsdw6doEzdD6zjBJ643NGtus21exkTVvf3
    AigfvG+STrTChldNdcbkeWj5hSguSAlZrdyrdffJoSoEAJvDe2zQe0qxRdkYYBAl
    uUz7fLXo0cwjex/YAfuY9fjk7ruquoSiTc7Kka0fI8Afwo/nBhGWt3oPoFpA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QoJmI/4q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QoJmI/4q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9Qix6xz0g/RWXukYhVKVk0G70qVlJrjibHgrKymOp3b2L25JFGCdQ1hEfJ3yh7NCDbjb52BJe2plyQM0S1tgGhFLws5O4Bf5+ARnAMNCRdYQAXE1VW
    DFB33piSxF7GjcA1WQhaODROJRw029MSS9T7npfCoW053AIkgVqux3+DAULaf5rVWXq2PYOBPMEQ66O1EAanANXKMxSmSm9OVg5wi455/0tB/erj2mRld9ga
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=EHaNKQqtAAAA:8 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8
    a=yMhMjlubAAAA:8 a=T-8oWK_BF47edkJ3rzYA:9 a=wPNLvfGTeEIA:10
    a=KIA0-nbnOXq3vJi0w304:22 a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeDIEDV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:03:21 -0400
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:5451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753328AbeDIAR6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 049/189] MIPS: JZ4770: Work around config2
 misreporting associativity
Thread-Topic: [PATCH AUTOSEL for 4.15 049/189] MIPS: JZ4770: Work around
 config2 misreporting associativity
Thread-Index: AQHTz5giXagKVaxq40mr6bifczxMig==
Date: Mon, 9 Apr 2018 00:17:24 +0000
Message-ID: <20180409001637.162453-49-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:z+f+9+qGDRgQNjyAH7sEMBhvrwb9OP0Xa+7Lxs5CnSc/19lTJUwUX5O7S75MI9XsKfTBJvrga5T3I/lIccCjgdLfQbIZSUbKShp2CTc8TxIRdi09NOqTsuqboZIBAQjUBIwm7X0/Wch/QB9XegnkbY7xwtg6m6DhwhgHliLXT/jDfAZr1tDHB2BgZOiUt8dRFsfHnXSE6FzXI1QiZZNqriQGH2wkrU8H/fiDbHnZo/OUZGOIi3AcNKm6J7+J+1Bs;20:/4H6aENg+Uo/3jtIqWm1qjqZAIpYpItfLMgmyS/xgC8NJkwIwp3tlyu2Ln2SVVkjZxA3MeeonmJlApndw3PPCi0L5Z8148Kcp6anEBTJF7zFE3ULpFZCcpfkGtnL/iyzxT+LXw4CeHFz5iksZegKPVVKra+1hlddSbWQWp/ole8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a536cbe3-5353-4971-7d2b-08d59daf54d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10489C1FC6BAAFE14DBDE698FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dPonDHnFdlqxKHpwFT8N/cv/tlO4pez2eFheoHWpfpiD1Bc+qPivkLB/yJJHyHoJMp0h1KBzgnCZ9JQAdmvG7jlD09s+f+HW6ZQN6/fKqrZQh/+8YogU2hi3jd8niwKFkh06N3G5eno6lzNODqgGtHmRqze0DTkm9CGe3Zs/A5gkXvNZuo2vgXrjywwmsvEVSo2vO3zoniAljstklnBi7hzh9WQOqfPo42/MO1mGePhL0wBKnjEbTr2W63F0Go3VkgeGMSsHrT2DigjVN2gTA6Ba+sIZ3ivM9xDrJwiPIfZuu5ft3YPueWFDxZz/vxwncmfvm+e4c9aztJ8chJ+Ah/qTdOLx14VxbOeiYOpzUmaKN+J+HHpOu6pH0Be4et4AqNs/cYkgxa7KKp9PHqY70FR30eyED+XvHp0pGwExS20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a536cbe3-5353-4971-7d2b-08d59daf54d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:24.8850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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
