Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65306C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2728E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="f0Oa5y0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfBGTx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:53:27 -0500
Received: from mail-eopbgr750139.outbound.protection.outlook.com ([40.107.75.139]:3008
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfBGTx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZXqdVwLVUkRJRTpihcZIdeW2xjzMwks53WfUuYq34g=;
 b=f0Oa5y0Y0HCjXPE2gLSS6Ua3m2XMfR23Ml/S1idVFMCpQZ9fNf8yMHZU0YlOIAaYxkPII1OMc43G0RUKiVX3RQ4JpyU9guW/HrjJ0wIvXSveaDls2ofdCprWwZEVodrvk92TJPAKgt1ssPOyVLerLB+sv5RMdgu+se5kMDbZdhU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1647.namprd22.prod.outlook.com (10.174.167.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 19:53:23 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 19:53:23 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yifeng Li <tomli@tomli.me>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>, Yifeng Li <tomli@tomli.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] mips: loongson64: remove unreachable(),  fix
 loongson_poweroff().
Thread-Topic: [PATCH] mips: loongson64: remove unreachable(),  fix
 loongson_poweroff().
Thread-Index: AQHUvx7IJgGw8UBs2EK+UyHUqW9lRg==
Date:   Thu, 7 Feb 2019 19:53:23 +0000
Message-ID: <MWHPR2201MB127722785DD946B644451072C1680@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190206070721.19185-1-tomli@tomli.me>
In-Reply-To: <20190206070721.19185-1-tomli@tomli.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1647;6:LACvT0URbEpB9l7VgpzJ08LvzUCHxVs5PJ+u0V7/LB/3D02SiKXMyb63nd2glQFWqAjIyAvO27fBk0lZ2VMEbeehPs08+qtypDadrOU5qjxcHKngDTkmyPsiJ8igwKDPe+Tbk8mlTx7ytDwzAeKQ619mymQ5X/7gpWc2V2EWa3V27s8F0UyWzThyFbi71cGhIhE2On5vPJ0H6vM4Ifty+H68dr51Msrs+YuVO6I9NPmuIaIi3hjwkfp2EQU8TrqP8vJvLJ0e51f6LvMSqbmSsf/SJlDZBcDki++G70vMH0mdXO8wFYGxDohlowv+dWgFjzsg2eXlTolKRkGrK9T3MnowQ/IWBUFZtnrSjIOj/5OgtdIXY6p1d9R3+C9yzgIanzcGLVUpEmzxGib692zeGxugxXyMN8LawShgZZk2E/UFLHDgFonUarONPMHkpuNQnqJ1wH9Ho1reSEFS+391Pw==;5:pbxrr2H3FN0GOnwTNeJ3NyXWBTIUhLJ8q7+fLp/OVfk3a37gzTYCf97Aa3RXMT3eWHaz06pg+f+K1xyIrhKHP6VCOiTVEzZnb/f9Vw/7gN+u6w1c/0kh8EV+N4FHmYMP/mZIj0cIrGIjWljlXBB9wFpbbn/3PsHhjUYgixmSNd22Tfmf26jeWG0sEV5sv9ty6gi6/Xo9JrCpbKourKnrhg==;7:6PEY9SyqW3IwvS9sCo78wWB+gXvw9CaS+GYK+66bkcP1hIi/fzFrRujb8MWQSfIfexQY9XKVGNbfezRGkcxOj5mQWqmWANc6o7Ai/C4qTdVs6E9IGu+RkHZNnbH6wVZf8rhmOwgzOFDppkFyZ/3mQw==
x-ms-office365-filtering-correlation-id: 724e1624-cfdd-4c69-edc1-08d68d35ead5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1647;
x-ms-traffictypediagnostic: MWHPR2201MB1647:
x-microsoft-antispam-prvs: <MWHPR2201MB164720AB8794692BD086BFBAC1680@MWHPR2201MB1647.namprd22.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(346002)(366004)(376002)(199004)(189003)(305945005)(26005)(7736002)(229853002)(52116002)(186003)(4326008)(76176011)(71190400001)(486006)(7696005)(6916009)(71200400001)(33656002)(25786009)(97736004)(42882007)(6246003)(256004)(53936002)(316002)(74316002)(99286004)(54906003)(68736007)(11346002)(476003)(446003)(966005)(3846002)(6116002)(6306002)(14454004)(55016002)(9686003)(81166006)(81156014)(386003)(105586002)(6506007)(102836004)(8936002)(478600001)(2906002)(8676002)(6436002)(44832011)(66066001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1647;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WMUylLFyHmubv9zeRh+4xxjOGk++n6IJOujtQtp/4KPS5TT+vRDSEw81FquP9fa83fHjvCKxambWdg+xuOlzNAAVTgCEnfYZsC9jdc+8afdCShm0MZcMz8WfaC4cEO8Un5Y4pme3y1BOPGDJQzqPLYS4Jr8YfDK+Uu+iND58nUiDb3+Fv0sbTPu6mFqgBRoESlLcUqn8xK/aoYgmq6O8TNLux+3tfqAxWJOlN73N9zt+riuWOcEvCJlO9IVM/y+5Ftk8aO8MvB54odwhaPna6GXM3IZLa1fojdUWZVW9nDl7IyvfNdRwHPm1XPcOABWwFV3x1CD3nq0DX/GrnRNx4cfYABeeKc84leGjGoaOCZyZXmsCrsey76xHs7GoKFnkOzRcjL23dXCNuq99mt2Bvick4sUpEoRnVROkFCVYdto=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724e1624-cfdd-4c69-edc1-08d68d35ead5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 19:53:23.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yifeng Li wrote:
> On my Yeeloong 8089, I noticed the machine fails to shutdown
> properly, and often, the function mach_prepare_reboot() is
> unexpectedly executed, thus the machine reboots instead. A
> wait loop is needed to ensure the system is in a well-defined
> state before going down.
>=20
> In commit 997e93d4df16 ("MIPS: Hang more efficiently on
> halt/powerdown/restart"), a general superset of the wait loop for all
> platforms is already provided, so we don't need to implement our own.
>=20
> This commit simply removes the unreachable() compiler marco after
> mach_prepare_reboot(), thus allowing the execution of machine_hang().
> My test shows that the machine is now able to shutdown successfully.
>=20
> Please note that there are two different bugs preventing the machine
> from shutting down, another work-in-progress commit is needed to
> fix a lockup in cpufreq / i8259 driver, please read Reference, this
> commit does not fix that bug.
>=20
> Reference: https://lkml.org/lkml/2019/2/5/908
> Signed-off-by: Yifeng Li <tomli@tomli.me>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
