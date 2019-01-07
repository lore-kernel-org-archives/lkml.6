Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37209C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0063420859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cV2oLGDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfAGKh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:37:27 -0500
Received: from mail-eopbgr820042.outbound.protection.outlook.com ([40.107.82.42]:13506
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726601AbfAGKhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pzuNh+iwBFYmpNg9y63ZGBkNRjUdqu+eZIArYPBeu4=;
 b=cV2oLGDFTStFeHg9JOR0f2kRni3qsyjZEmoSODSWH4+fi1UxAZizTcM5UnAB+XVTtLCEwhjkfF/GFVmKtf1yrjrpv+Yjtl/XwsQMEp3ojHUxQ5zUQNNQJLJTjGZVIdPyy2AgmN/ZYl/oJjsNxpruKRY21x2S9jbWnUAlRTNHDHI=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3391.namprd12.prod.outlook.com (20.178.242.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 10:37:18 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a%3]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 10:37:18 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank 4"
 to more models
Thread-Topic: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank
 4" to more models
Thread-Index: AQHUpnT248JJI+5Ktk6P4uPYiZ1p9w==
Date:   Mon, 7 Jan 2019 10:37:17 +0000
Message-ID: <1546857399-2926-2-git-send-email-shirish.s@amd.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3391;20:xccfeGXE1QEQaxR6O+W6mCgp0w25YlEATR1twpbXSrpG5t2EmHK0x98KD3S1Gf9hiVi5zefNVOT4ea11YaZiKkRYvYU1ulNlkf86+jh+8qSDxwglMyIdiKe9VAb/JjrQhfeXqYPvnQbcNEncoDL6L/dkp2UvcjOjZfNa/+3gGb3b87ahvfmizlaDk8HUH6KqKGUR0Mq9bTwSEnBIsUefCjJ1RiUsOqon2QiWxO/SZexRIIDIkDx2cAKyQbuymF27
x-ms-office365-filtering-correlation-id: 1da9c452-b037-4735-6987-08d6748c1891
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3391;
x-ms-traffictypediagnostic: MN2PR12MB3391:
x-microsoft-antispam-prvs: <MN2PR12MB33913F99867A65665F31F0FEF2890@MN2PR12MB3391.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB3391;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB3391;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(2906002)(81156014)(8936002)(36756003)(26005)(14454004)(316002)(3846002)(99286004)(54906003)(72206003)(68736007)(486006)(476003)(478600001)(66066001)(86362001)(109986005)(6436002)(6116002)(5660300001)(6512007)(4326008)(2616005)(53936002)(105586002)(59246006)(106356001)(71190400001)(71200400001)(6486002)(76176011)(52116002)(6506007)(102836004)(386003)(256004)(14444005)(97736004)(7736002)(305945005)(8676002)(81166006)(25786009)(1671002)(186003)(11346002)(446003)(15650500001)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3391;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L209YuWmk/clSdLKjIJ/Vv6xmWjr3Ewtb13s97nrb61MWEzZaRnAOk5GgkU78a+mGJEx+nexWV7/4JcgwazWVk37V8HS+tSZoi7M/K4pEFkZGvPqQ63I1VhIpjauI6tSJmtd5WZb5WtG82UOtsaTOH6JXvtifTrHuuK5tZ7GTWrdGNcg7aF9kNUKc6jBuEEAWComKd3jh14v2h8SAiujEznO/vuYaOVFCctufW3MvzmHGjfoRIDzyFQj3RYwWMkasOpEPHXszzVbYs3Zxfco915y7hUQdwgB6F2V+weUf1kBBj8WzCdS2m/XwOeQpcmD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da9c452-b037-4735-6987-08d6748c1891
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 10:37:17.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
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

