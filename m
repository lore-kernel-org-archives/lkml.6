Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8929DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525D22173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tUhk0f2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAJHyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:54:45 -0500
Received: from mail-eopbgr710046.outbound.protection.outlook.com ([40.107.71.46]:18653
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfAJHyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ogtu2k4YpJiOhnV5Ky3VddFsXcLWMx6llEq06QESUw=;
 b=tUhk0f2wISNzdor5ngQr71ub2FbCrPJzk62W3mrWPflcR4vhfSJaUOMjYk8Uzd4B2RKMhCZ6wKzKX2V9jxz/A2dzQ68xpYNsKW+PIYuSgDQO2QmPvi9w6wsCQ4usolUi3Rus27svxHV03ZmmkHzszONYNCMG/jMwmk8gwkEgtYM=
Received: from BYAPR12MB3237.namprd12.prod.outlook.com (20.179.93.25) by
 BYAPR12MB2664.namprd12.prod.outlook.com (20.176.255.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 07:54:40 +0000
Received: from BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5]) by BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 07:54:40 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     --cc=Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 1/3] x86/mce/amd: apply MC4_MISC thresholding to all models of
 family 15
Thread-Topic: [PATCH 1/3] x86/mce/amd: apply MC4_MISC thresholding to all
 models of family 15
Thread-Index: AQHUqLm9VyZ2s0LQ8UGK0duiB3IR+Q==
Date:   Thu, 10 Jan 2019 07:54:40 +0000
Message-ID: <1547106849-3476-2-git-send-email-shirish.s@amd.com>
References: <1547106849-3476-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1547106849-3476-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::18) To BYAPR12MB3237.namprd12.prod.outlook.com
 (2603:10b6:a03:136::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2664;20:skYV+ic/lhyDYQNqH5yijBt8Q2lpDsXg/AM9ePCWFWiEgL3uisN6n+7dDPaMdCkWHQhcfFxKw+x6QPNCKyNJdiz+gq/Yy/AG3QQrG3RosoJV5qS+X19KVlrYMPkfRKEEdhWxBK0mwKWKHxgAzW97zqHmH0PAuXjkUiIqZ0reH86BTjs/yMesYILIHAbmKZczsctCi652CJsyFdAE8wKLFHlwqNulvdmJvs9+QjrUft2teCi83j4V3zKU7HVJJ24Y
x-ms-office365-filtering-correlation-id: e0927a46-b03d-4e89-9b5b-08d676d0e000
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2664;
x-ms-traffictypediagnostic: BYAPR12MB2664:
x-microsoft-antispam-prvs: <BYAPR12MB266463CF1C13AA7CE4B70C54F2840@BYAPR12MB2664.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(54534003)(102836004)(6512007)(186003)(386003)(97736004)(66066001)(72206003)(6506007)(68736007)(86362001)(575784001)(26005)(6116002)(81166006)(478600001)(316002)(52116002)(81156014)(486006)(54906003)(25786009)(76176011)(2906002)(3846002)(99286004)(53936002)(105586002)(6916009)(2616005)(256004)(4326008)(71190400001)(71200400001)(36756003)(446003)(7736002)(6436002)(305945005)(14454004)(5660300001)(106356001)(11346002)(6486002)(8936002)(8676002)(476003)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2664;H:BYAPR12MB3237.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qJKOkuDjJYxDdldAz54gmLRNXdRShdb1nHBbPyWjW2Ic/lkeEkhMmP+TYJY3qtp/8d5kO4hQ0g9UZQrnMW5A6BaM+rSGvh6zZMcIomcYlC7UNCVolTt01/t6lF//3ZSRAH/WfXmp7XX4MLZ0lgLoTzL/tumb6ruqEgnvUNOueKpW5hvRyZPvAXnOR+RmTFF/knkTnZtvBt/UKjA/bZ0bpGhrZyy3PX23BBPX9wZXim/YxkaG9Yu2MFrDO+TB08okwXFyc1cjo6j5GmHoCz387/0SnuT1fkSKABX+fTYmDXXuq3CR3shBDnrdrdhUQfR8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0927a46-b03d-4e89-9b5b-08d676d0e000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 07:54:40.7133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its evident from various forums and logs that MC4_MISC thresholding is not
supported for the family 15 processors, hence skip the x86_model check
while applying quirk.

Changelog[v2]:
 - reword commit message to adhere to coding standards
 - remove check of model range

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 672c722..d0c5416 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1612,11 +1612,10 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo=
_x86 *c)
 			mce_flags.overflow_recov =3D 1;
=20
 		/*
-		 * Turn off MC4_MISC thresholding banks on those models since
+		 * Turn off MC4_MISC thresholding banks on all models since
 		 * they're not supported there.
 		 */
-		if (c->x86 =3D=3D 0x15 &&
-		    (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x1f)) {
+		if (c->x86 =3D=3D 0x15) {
 			int i;
 			u64 hwcr;
 			bool need_toggle;
--=20
2.7.4

