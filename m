Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48974ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E0520693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mxMFSEaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E0520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeIQIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:36:20 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729071AbeIQIdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taNTFR6sohNHQXKtyAJ/VPL8o+LKWPZH98qRUQZAttw=;
 b=mxMFSEaFWrY/Uwa5vtaogr9AU4sJZMaqbneSa6rEFQ8Be42zBv1hyp0Mraed7ZGFmfhhO+W3bPLIyWZI2FUgXq30H0AZx+yN+x596rWLZpuLx9waoBAIQxHESJD3lvc3ORdOf4XiS3w48ZNvxHGk2XzayA0JKF6wnElHUCUWR0Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 41/43] module: exclude SHN_UNDEF symbols from
 kallsyms api
Thread-Topic: [PATCH AUTOSEL 4.4 41/43] module: exclude SHN_UNDEF symbols from
 kallsyms api
Thread-Index: AQHUTjNB1ed1Icw8jEW2SIGQkNARZQ==
Date:   Mon, 17 Sep 2018 03:05:14 +0000
Message-ID: <20180917030445.484-41-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:MLUWXnmnzZx5t8n0l/GH99dxRYKHKQ8dIPO0nNswpmzpIVELVw11i0v0eTUMPefp1xGJ11WrjJt35K2lKi9WOFQOF4+1Ia+rbwM0wAQl77LZl7aUig38B3TP9m+ZLrh+Q6SI6QLQI424IUtLu9Xg5irBeT13TsLF17EZqwoO+qFR5kZhEvmbne2FHOPVVIT1ffoQcBZfArgQllq6Lh3fU01UkIGCJxZ+Y7dOp//H8vaBC1uLQqC9LQwrf9FNN1Rpoga7lsvnuL7kkdE6HLr2ICVgujCvjA16sQ8VOGnJNJtp5NUfLHQTrwXvH41rkWYkh5VyqFuLAVqm+8SjESBTblTg1sAYf02CH0hpNJmA4or1o5z9BbnTY/awt4x/hneX8PmCrKyMHcu1yxgmrMeT+6tg6Nx2meCUksojkGIUbNAJ2vCax8G8T6qpHe0bdE0h+24ots4Af02Aotq8P6HqXQ==;5:ckSbSFOwszENzaP8VZA2Bhv/xkfv9eyiyhf7BICtGVg6cz3sAqLfOITxir3YZVlPdQ36eLmpHl0OA1V6gOUh4qYj5yk1pgCGcuh0P5YHJ4d863TDJ/PnRjWZm/tC8M+1xdPqEn5SVLQx7WID/TufGxtyW5LedlNtwCtfaZkXYBc=;7:VxnSHdBlFHRLo4+8Tclc0Zl6WrhHeSwi+T0Q5ET2cqPf7osmmIzVazN6wJEpqmleOKqZH1R8AaJI2bx0Vb2yE49Lp7aP3xWEMnQuq6R/KAIMdghjcmjWzuPCxcz5tZi2mFRnWAkWr9wjeUmiYqPuxohNcZhH7BhwhARq8FrONyCUuXMjY3fPnwulNgDZ/NRnJJGmHUMOoDnWcimqILUq4p96LiOB0iT6dV1AzYZAbjKu4cWiUYLAs/NJI3sxm1Hl
x-ms-office365-filtering-correlation-id: 5cf14b7e-817a-4e9b-810a-08d61c4abe76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08398812E2819ADC03575B9EFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vxBx2v+ReCaLbhL72JTxVzhOHvFdjvDWCEn4CQiAlf73jJrG8EdSalg2I4BlGzmR6mSuBHNwIKHrV4E0opHnz5cGd4eyoWDfaLqf8q88IJtRbu7pfPkh18boE52j/sweLV3bbFgu6mWLQP7qvU7Gv1JkTJkhMMy0mYj9DS5LJlJnokz8LKJogZqL/akbWqvLsygapPd3Mf+zjKNt9y5o3ozNk5oKAIR/sCWLjzb4cntZyrzW4509RuxseLXMaesuWi75hor3vUvRrflBb0foi2FUP/MnwZP7qbI34SAt5FjnsqN5Dcz7E1GahUSySeapMpDQEgagOCgUyhfEAiHPXzN9+WsXC1V9CmfT2+joHjY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf14b7e-817a-4e9b-810a-08d61c4abe76
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:14.4453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Yu <jeyu@kernel.org>

[ Upstream commit 9f2d1e68cf4d641def734adaccfc3823d3575e6c ]

Livepatch modules are special in that we preserve their entire symbol
tables in order to be able to apply relocations after module load. The
unwanted side effect of this is that undefined (SHN_UNDEF) symbols of
livepatch modules are accessible via the kallsyms api and this can
confuse symbol resolution in livepatch (klp_find_object_symbol()) and
cause subtle bugs in livepatch.

Have the module kallsyms api skip over SHN_UNDEF symbols. These symbols
are usually not available for normal modules anyway as we cut down their
symbol tables to just the core (non-undefined) symbols, so this should
really just affect livepatch modules. Note that this patch doesn't
affect the display of undefined symbols in /proc/kallsyms.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/module.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index aa81f41f2b19..bcc78f4c15e9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3860,7 +3860,7 @@ static unsigned long mod_find_symname(struct module *=
mod, const char *name)
=20
 	for (i =3D 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) =3D=3D 0 &&
-		    kallsyms->symtab[i].st_info !=3D 'U')
+		    kallsyms->symtab[i].st_shndx !=3D SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -3906,6 +3906,10 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
 const char *,
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
 		for (i =3D 0; i < kallsyms->num_symtab; i++) {
+
+			if (kallsyms->symtab[i].st_shndx =3D=3D SHN_UNDEF)
+				continue;
+
 			ret =3D fn(data, symname(kallsyms, i),
 				 mod, kallsyms->symtab[i].st_value);
 			if (ret !=3D 0)
--=20
2.17.1
