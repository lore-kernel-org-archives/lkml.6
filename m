Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E552DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95CC21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BhCelGYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfADJh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:37:26 -0500
Received: from mail-eopbgr710067.outbound.protection.outlook.com ([40.107.71.67]:60000
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727551AbfADJh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pzuNh+iwBFYmpNg9y63ZGBkNRjUdqu+eZIArYPBeu4=;
 b=BhCelGYDgaxMqFeeewRhxeeFwvKYHIkQIhWpYtugpF84+X5HxdjB1cyD8vnrVl518+N2QwuJsMbvUsqPsLNtlKWus47Gy4uIb7V0jz0UKUzzhB0hmgfT/AefBycDE12nSMu2p7Ie+NTWYzEjuH/4V94UBiwig6Bqay36+eob6qA=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3296.namprd12.prod.outlook.com (20.179.83.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Fri, 4 Jan 2019 09:37:18 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 09:37:18 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
CC:     "S, Shirish" <Shirish.S@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank 4"
 to more models
Thread-Topic: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank
 4" to more models
Thread-Index: AQHUpBEV9bvGRHbRhkWGjQZ6rd+J4w==
Date:   Fri, 4 Jan 2019 09:37:18 +0000
Message-ID: <1546594609-22403-2-git-send-email-shirish.s@amd.com>
References: <1546594609-22403-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1546594609-22403-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::29) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3296;20:YxkBoi3NE0M+C45QTcAOdYyA59AOTIBj5QjRX1TWK0qMEYYF2qlInLR+kpWwHLs5TGclceZBiEY9bYLZfjnnbI8w/0XSNSPdSet3tDHHWFm7kTD9ERkWrgZ4ERRAWM/zMKRXHLzd0xwbg+G5AZq6uf70SqG/YnEB72FzUJI0sKsPFG/4bUYCcn7ZyWW0GU1P0z3aUqzByaQoX7tyPbrH9mIz6CbfVoPoDgY6Wm4yS8wjoZjbn3LM24zoOVJO2zbD
x-ms-office365-filtering-correlation-id: 55c400cc-8bbc-40c8-3b8d-08d6722837d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3296;
x-ms-traffictypediagnostic: MN2PR12MB3296:
x-microsoft-antispam-prvs: <MN2PR12MB32961BC67E7EC063C0E58D05F28E0@MN2PR12MB3296.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB3296;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB3296;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(2616005)(59246006)(105586002)(11346002)(186003)(52116002)(476003)(256004)(4326008)(26005)(14444005)(14454004)(76176011)(102836004)(97736004)(6506007)(386003)(66066001)(446003)(8936002)(15650500001)(81166006)(25786009)(81156014)(7736002)(478600001)(36756003)(72206003)(99286004)(486006)(305945005)(8676002)(5660300001)(71200400001)(71190400001)(68736007)(2906002)(3846002)(6116002)(6512007)(53936002)(1671002)(6436002)(86362001)(109986005)(6486002)(54906003)(106356001)(316002)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3296;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9eN6kzIU/tmVF6cdHmVI52kA7eIMWHMUnwEXdVMeBv4Ub9dybbPYfooCTPm477DmAi5STbCnqpnka4PrqBmHKqqtQDZP1tnBDvSx4UwgqJ05kRomPbrDxsaGA32o4afIPokRVXeWI0ET5z8J1aAdBUxOC/r4bhVw7dfVFLrI9M4kjkQTlf066DUb9FC6/1rbEsIFeWjGCBEqduco7pi7WTPsLeF2ScwqmfiUfu/N0nYn97923V3GjaFMvpoLKRjmpZ7QzYO6eZb3U0luoUPasFz3pzgrMuVjqtid6aInnpVK1WUkDi5WDceSuBXv8jNk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c400cc-8bbc-40c8-3b8d-08d6722837d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 09:37:18.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3296
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch added this quirk only for the first generation of family
15 processors, over time its noticed that its required for later
generations too.

"575203b4747c x86, MCE, AMD: Disable error thresholding bank 4 on some
models"

This patch extends the quirk to make it applicable till 7th Generation,
so as to address the below warning at boot:

"[Firmware Bug]: cpu 0, invalid threshold interrupt offset ..."

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 672c722..051b536 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1616,7 +1616,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x=
86 *c)
 		 * they're not supported there.
 		 */
 		if (c->x86 =3D=3D 0x15 &&
-		    (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x1f)) {
+		    (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x7f)) {
 			int i;
 			u64 hwcr;
 			bool need_toggle;
--=20
2.7.4

