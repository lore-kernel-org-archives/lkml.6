Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17545C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDA020685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KJDlN5iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfAJHyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:54:37 -0500
Received: from mail-eopbgr710078.outbound.protection.outlook.com ([40.107.71.78]:16832
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfAJHyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6kGTdR0+LJ+4uZizq3bFcQA+66ykRZCkH4+D2iC06M=;
 b=KJDlN5iPKG31j83vAzmzRpMFZCBWarppm4pY3Dxaup59rdKvJA0SevXJzv/4k3G2jSicoT/n6hN5r0t60lU17DudghlwEMoTP2C/JNQlwipSJgGjMhLONXngZdXI0kUnUscpln9pWUqgXYfgLEX3ZiVBmqnp7e0QJZSFKsvphIQ=
Received: from BYAPR12MB3237.namprd12.prod.outlook.com (20.179.93.25) by
 BYAPR12MB2664.namprd12.prod.outlook.com (20.176.255.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 07:54:34 +0000
Received: from BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5]) by BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 07:54:33 +0000
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
Subject: [PATCH 0/3] x86/mce/amd: apply missing quirks to family 15 models
 (v2)
Thread-Topic: [PATCH 0/3] x86/mce/amd: apply missing quirks to family 15
 models (v2)
Thread-Index: AQHUqLm5gU321iY/xUSK4SSPvJlWyw==
Date:   Thu, 10 Jan 2019 07:54:33 +0000
Message-ID: <1547106849-3476-1-git-send-email-shirish.s@amd.com>
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
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2664;20:F/wnLVewETD1UyoTXmJuUXcJxBiuvyFoGGCa2AcWyUJRA7GfkpvYT5enqdmkuiT/C6qpyjihj45wRPJNhhVWwFdjf//+Tq2addC3dqRn9WQ7H4S25VcdhKyQas8DaerbMkk2pzCBXM2sevWQBgImIoqcY6LJKDU9h3oB04wa9vkKOiCVtqK+sMBv7nsPPw9f21r6BRCK6OJ2a0nitBHCz6mALvr0EwvlPTTNDWT9Vf9SrykYKPNCV1Ik5uL1ijjs
x-ms-office365-filtering-correlation-id: 3cee0561-0160-4056-950f-08d676d0dbc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2664;
x-ms-traffictypediagnostic: BYAPR12MB2664:
x-microsoft-antispam-prvs: <BYAPR12MB2664FD2739CCC0FDB4780981F2840@BYAPR12MB2664.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(102836004)(6512007)(186003)(386003)(97736004)(66066001)(72206003)(6506007)(68736007)(86362001)(26005)(6116002)(81166006)(478600001)(316002)(52116002)(81156014)(486006)(54906003)(25786009)(2906002)(3846002)(99286004)(53936002)(105586002)(6916009)(2616005)(256004)(4326008)(71190400001)(71200400001)(36756003)(7736002)(6436002)(305945005)(14454004)(5660300001)(106356001)(6486002)(8936002)(8676002)(476003)(4744005)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2664;H:BYAPR12MB3237.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fH/6yAt9sh+YA8Cc6yfCjypZdG4DRydG7tEOz5vp4E4rEeLhC7nklKAqdpjhKLNrFpokxG5dpsiH68BueawN9Q4Pa+n+zdhi2WBsEGXRCQUEuy3u0gTk47pWgZfDd7SWyYEg1ceKfMEnCWqT7zsGFL1QbKXzuy9xLvp/PkvL63OIqDh4cSW1f9mQrHyO9EBZx4wD6rsUzr0O2hLYfL9ASSLW0jHtzY84xzXkWv6lRZREnVPTKTbdExu9Qkzwry+l5FkuZ3x+KSrT9JnTqIrskIibXcg6T9JbUz8mE9q4bE+0rIrn90QxSqnp0JAWPQrV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cee0561-0160-4056-950f-08d676d0dbc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 07:54:33.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below patch series applies to family 15 CPU's of AMD platform, to address a
consistent warning of:

 "[Firmware Bug]: cpu 0, invalid threshold interrupt offset ..."

at every boot and every resume, which is misguiding as the reason is not a
Firmware Bug but "MC4_MISC thresholding quirk" not being apporpriately appl=
ied.

Shirish S (3):
  x86/mce/amd: apply MC4_MISC thresholding to all models of family 15
  x86/mce/amd: carve out MC4_MISC thresholding quirk
  x86/mce/amd: apply MC4_MISC thresholding quirk in resume path

 arch/x86/include/asm/mce.h     |  1 +
 arch/x86/kernel/cpu/mce/amd.c  |  6 ++++
 arch/x86/kernel/cpu/mce/core.c | 65 +++++++++++++++++++++++---------------=
----
 3 files changed, 42 insertions(+), 30 deletions(-)

--=20
2.7.4

