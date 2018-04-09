Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239914-2-7627967204926497644
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
    1523239913; b=pEGJilHJ9wGQLTdp/B37LhAat7DRx/Oqlk2EkYBMVbe+t5F25Y
    brt2KZmikamVpFSEhOFhTQbp/Ue6Hqpy9UlqJ9HR5U1fXBA27eJ/Vzan0dz55LTc
    1Y0fA8hpk8ojPGGFRzD7KPM8raLGkG7UL3Uj0vAr0neN5vdaEb1Cl0xjNs/kTSER
    yW61HbeZD1nNiWUO0q/JY5b6qYJ6GQ8wk4ICGBlLlmFhbdReg2csjz64kzV+crEa
    gKLPbKH2EtLJiB7qrluoOxSlCnYGYdN5EXLIWYr3QH/8ta79s+VW5GCEEALtMyJM
    O2RDEKap0x0NjjsKL/wxhf2vmLW7XeWnj95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239913; bh=msLDu5jzGB
    yBOCLdLaSiQW60vG+Sn6Re4F4yrgjOh4Q=; b=q/K20W/60U5q1BXyJMOayLzHPa
    Qaljn1Aq1/5lgKILGIF3bcj4p7C1WD6v8lywrvR+iYcTi0JDcSnb+Quhj96V2gD6
    NQd/vg1087D/pMf6ikPs6iHKC5JGsLuHmBn21XGZJKTCmnIUCSkneCBgKsrEvLiq
    VsfC3HdKzD5S2V/hdiKX2l+nz39hOwSgzuMv+H1w7lvr+CzdYUV2rvuGcPioAE3E
    UIz/lJ3kWyecHJEaDfcJY9xpeDGVMJX5ggXETUjglUA6cfcSjgWgtcY3S2tJq5V7
    uRAs2JEfUGqbnWqOCxSjmVY3M7+wAKkJqF7GI4tpzRDtAQ7d3e/fwx68/lsQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eIvmGYqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eIvmGYqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIYup+6E1gIA4timeiX+6bIo5rBwgB//qYFClxcjb/jqeEyrlc4lQa5rjAEqkGCxacVXqR9teToU/Pu5tBk2reeecP8sNjSsYmnOvkjRttT6O+KuFkny
    JsSlpxpo/MlT6Nm9Zcl7WCD6eZlq3NPAzHnPEpQ2ttHqDO6E1uFXQRc0avFSYT5FX7KYZ6Mq36V8GISzKwpQzjHjhbUd3A4PMQTfmtiok1j8d3m/SdP9GFg5
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=WZllTL94Ap4xuc5PdewA:9 a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756297AbeDICLe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:11:34 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756196AbeDIAbN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 159/293] MIPS: module: Ensure we always clean
 up r_mips_hi16_list
Thread-Topic: [PATCH AUTOSEL for 4.9 159/293] MIPS: module: Ensure we always
 clean up r_mips_hi16_list
Thread-Index: AQHTz5kwY8h7ZolO/UyoRSYhafVnFA==
Date: Mon, 9 Apr 2018 00:24:57 +0000
Message-ID: <20180409002239.163177-159-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:5xsU/X2zTHPzrKHlTCq+Nx3s6JuQ3A2VS8RmDp4krXNrOTWMdjYTL/y1dZBJDcaY4aYQIgd7CXyBT4Ha0aZS+5F7IVc7ZQzC4azlgHisnHPHqLxXPdF+NkbTjitLbnVzTdGz9WyPXWqDgB8KDzBWigyKux8VCzQXrDkpITToxCvsVm46FX6R1C2gNIN/sMXDeyHj60v997CXVaMgqol0NUac/dUP80oB31wRjdHIT8c6cn28PFOmy/5A+89hZZPx;20:XBjl/SDMzQWNcm+FEdo62TNiVLdfN88XDUx25V80K9RCljwA436rNV24Xrhj5uI/xPPbM5rjB9UsjyVG5cbmMEal8n++uEXb7i1/nE2S/slBeaRpScLaqe4Xb2UK2MSbKfhdCTNpsMs6k/nL0L458ducwyiy5W4ZH+zMjMM2BnQ=
X-MS-Office365-Filtering-Correlation-Id: 4556d5e2-a6bf-4b2f-33e7-08d59db1315c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091735FA6C508328FD91169DFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(15760500003)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LkxMkKII3j3HmnK9EciDqTAf/Shzw5kC9UJ50iZWFSf9m7bwyZTlFhF8Dmf7tmGfv3SDs7ean6bJEY5sEv8BE0vsGhWHlB2M1M0lwClBm2MCYGbKjRGOsHv53UvEEKphj8Qnn2n6eMvfXj+U0Lu5yndiwIqbh5OqbNyPLjYYJWX84iF8W/P8nyATlTk6O4SXmxHeoYpU+qEvHesohF9AuVo2tD0El9Mjlkx5pbFHakY3UMfkKAAgVgBFShILF3vGDEYl1M1c3AcXfChCX6E0IEKIaTouDI7R3XYfsXWg9j/DIQH3oRZL1bSSzYJoZKztU7PjbKNPbHTG+4iFERPIIkhnJC2fztEHO/P7llXQavAYkV/Y0Dgkdf1jrp4Dl2i4Jvu67zSG99N3fvh3ijbX35H0krEJVprK9vOYkqzbCe0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4556d5e2-a6bf-4b2f-33e7-08d59db1315c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:57.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 351b0940d473146923711bc943fc881354a4c1f3 ]

If we hit an error whilst processing a reloc then we would return early
from apply_relocate & potentially not free entries in r_mips_hi16_list,
thereby leaking memory. Fix this by ensuring that we always run the code
to free r_mipps_hi16_list when errors occur.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 861667dc82f5 ("MIPS: Fix race condition in module relocation code.")
Fixes: 04211a574641 ("MIPS: Bail on unsupported module relocs")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15831/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/module.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 94627a3a6a0d..ddcfb59593b6 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -251,7 +251,7 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strta=
b,
 	u32 *location;
 	unsigned int i, type;
 	Elf_Addr v;
-	int res;
+	int err =3D 0;
=20
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
@@ -270,7 +270,8 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strta=
b,
 				continue;
 			pr_warn("%s: Unknown symbol %s\n",
 				me->name, strtab + sym->st_name);
-			return -ENOENT;
+			err =3D -ENOENT;
+			goto out;
 		}
=20
 		type =3D ELF_MIPS_R_TYPE(rel[i]);
@@ -283,29 +284,32 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *str=
tab,
 		if (!handler) {
 			pr_err("%s: Unknown relocation type %u\n",
 			       me->name, type);
-			return -EINVAL;
+			err =3D -EINVAL;
+			goto out;
 		}
=20
 		v =3D sym->st_value;
-		res =3D handler(me, location, v);
-		if (res)
-			return res;
+		err =3D handler(me, location, v);
+		if (err)
+			goto out;
 	}
=20
+out:
 	/*
-	 * Normally the hi16 list should be deallocated at this point.	A
+	 * Normally the hi16 list should be deallocated at this point. A
 	 * malformed binary however could contain a series of R_MIPS_HI16
-	 * relocations not followed by a R_MIPS_LO16 relocation.  In that
-	 * case, free up the list and return an error.
+	 * relocations not followed by a R_MIPS_LO16 relocation, or if we hit
+	 * an error processing a reloc we might have gotten here before
+	 * reaching the R_MIPS_LO16. In either case, free up the list and
+	 * return an error.
 	 */
 	if (me->arch.r_mips_hi16_list) {
 		free_relocation_chain(me->arch.r_mips_hi16_list);
 		me->arch.r_mips_hi16_list =3D NULL;
-
-		return -ENOEXEC;
+		err =3D err ?: -ENOEXEC;
 	}
=20
-	return 0;
+	return err;
 }
=20
 /* Given an address, look for it in the module exception tables. */
--=20
2.15.1
