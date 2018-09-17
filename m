Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32428ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C9C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ygc7PENA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C9C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeIQI21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:27 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729476AbeIQI2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE8oiVzd6YlyFXhQQvVhuGZqEXRxyh6yqgsYVox8MOU=;
 b=Ygc7PENAf4RMrT9p0DEA84AfO53vHk2X9y4r3zRkvxt5TarH20CPBEfLSLO7F+ysDMXme6QQ3bCsqOF4AFPUCc1ktJ5KKTty4YI8DcGRrW8QTA5OBw02SD0PAj+Vzos+l1gX4RB7zv/Cr1v5C7vu7ox8Rchn5HDuw44n4FxMl34=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 119/136] module: exclude SHN_UNDEF symbols from
 kallsyms api
Thread-Topic: [PATCH AUTOSEL 4.18 119/136] module: exclude SHN_UNDEF symbols
 from kallsyms api
Thread-Index: AQHUTjK5LMEpavb0uEKnjFg2lY/tNQ==
Date:   Mon, 17 Sep 2018 03:01:26 +0000
Message-ID: <20180917030006.245495-119-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:ridCznVHzpXkxtv15TpG/N0i/0DAs19VQWPMin2AtqBNJWNAfi5XJyVYjALnJuG5dmCtLSSW7SpzGPb+hCck1/iIvcDkrWQ50w9tRFuSvnjjrVaJbVhjMHFzRO72wcCnD0fMGY+Iy3jhvkBC5lW45nSLrla2Rl6N7xlVQfFw1qOR+dQmuQw24E6CeJwGse11h0nrttaEyaQlxf0C/KuLN1T7liZO8CEeiu+FvQ0ksJSewxoOLJ674pl6iQ1oTwiDmDW++TYeFzeUifueNQNbsSm15M/bnEPfD0ToxMH3vDuqiPLjXPx/vG6SI2xTvj7YcAWJ/dHLkrjjkZZ/cKUMrxpyy7Ry/fAP4DtF5oZ7va9N5RyKkzybccFkYyrhvX/SqIVuJFz2VyGO4LUbn7ynE+61xaU1YAsvrAB+abx7l9xYIoyWkWzZXgZAIiRitVtB7OH5mUuFEHCPjSqzsnXsog==;5:jDkedYv5+PF61aqDFOyMFFZfgFwGIX9C24xCpBmzjtphd5ZbVD5lpZMy1DfaduIxS1R80tr7ltq81E7gHejloKSXK5ElnRxt6+7mFnc+34XCmcN1ejSoF6p/fu3VZuSEXG/c9vxYBU/yMOzj6/XUi3FqUxmJd1FG4QtKmixAOGU=;7:b5Xaw99WXA/S5JdcQGjx5vsQ5jkey7Kdu5s2+KdzVfUMtg/LkWdsGdzPnk3F7Nbe+vEDz1WX1uNftLITM7JCnxjKtUt0X8ueTPDpVl3t3OVwir+P8q0OSVAtzroKHdRCpaynT66Wnd36+oN+n8uXJKb5vRdDlL76CNk3kPFWDPjhW4Y1kAXnopXdZB2vYJXr+eZuDo0hpvlOw1iTWy3Me5YdFkzmLNi2Cu3gLXY1E91iiV+CpCax1h64U1KVpHzU
x-ms-office365-filtering-correlation-id: afabf026-15ab-48bd-2607-08d61c4a0c9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB016889BF79FE2A4BBC009749FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Jxchlsf5nS31dYesMVJq8NIW8zVTNiCOE8uCz1xc27Zzw5B3i5m+lgtApGt5QHIYgylRPTxf4r9oE53upiVjK+4YS4Um7f83tJYCsdRpm8vuNDyMW0zFUiT9RnL9RviOcoBnYvXfgJ+xDRJGe4lvHc2rAsvAUbEg8bn2U+pJhU9jSYyoKJP66uHDd8yR2b2wQjNibsolCUF+s1ppYnbxoo3ZamoDSckH1PbiZUnmf8Ph/c3gAWp4Sjh70NqQ8YB4GUpd+T9zeOnVMuFZ1iJq6qk4ZQUD07jkOTG+4FeIUqCEI+joMnuQliC4vhHoLDUOvE9nCkuVwyhcFmV9XfHX9ngbiB0Qa3cXyp9qaU3oDSw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afabf026-15ab-48bd-2607-08d61c4a0c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:26.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
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
index f475f30eed8c..4a6b9c6d5f2c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4067,7 +4067,7 @@ static unsigned long mod_find_symname(struct module *=
mod, const char *name)
=20
 	for (i =3D 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) =3D=3D 0 &&
-		    kallsyms->symtab[i].st_info !=3D 'U')
+		    kallsyms->symtab[i].st_shndx !=3D SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -4113,6 +4113,10 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *,=
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
