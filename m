Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27167C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5BC2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="P+jVnZHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfBGT4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:05 -0500
Received: from mail-eopbgr820105.outbound.protection.outlook.com ([40.107.82.105]:22514
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbfBGT4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lo8rk4Rphnz5bOpzChzAJ3Lw5J3FFPMqjeVW27C9Lco=;
 b=P+jVnZHBd8uMl84t4Uoq4qLCX/+7ZkLy4JLY5/ZiQy7Epa/lZiNH12s32IrHJSrhLW1K+BPXmxbqpVcj1Cw0+fqpDlpVioF1M3wDA/56gjRgb1g2XfUm/EwmcUQQJJ9NonP7szYk/6tzuXcgZDPqXOkslTW1drjPIaRhysiZ1cE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1328.namprd22.prod.outlook.com (10.174.162.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Thu, 7 Feb 2019 19:56:02 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 19:56:02 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v3] mips: cm: reprime error cause
Thread-Topic: [PATCH v3] mips: cm: reprime error cause
Thread-Index: AQHUvhGWfyMhi/6vwUOYbSMa0BG7HaXUwigA
Date:   Thu, 7 Feb 2019 19:56:02 +0000
Message-ID: <MWHPR2201MB1277C5B1E00B0C95ADA6A696C1680@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190206114617.24426-1-vladimir.kondratiev@linux.intel.com>
In-Reply-To: <20190206114617.24426-1-vladimir.kondratiev@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1328;6:1c/YJEubsOYPAxeoPfjwNhmK1u7hXc9y/F6LIEFqk5HCXlG+czPYW7iBtGHg/CiNgHrtxEMd2Rc5KSt41300y3pL/vfcCwNaDV5fOp3CujsB/2jVxjOIww4e/216jaSW+xetyHqeuRLDB7nkwk+0LvXsq3E3BhsHzuBMWbUPYKi0m5rJgPsc0a2G7Qprd1rB9gBw8iisdrwJLUFDYnna30pdwoF+8km89xeaBv4wKiZS6O3w+9vfz4Id2n6N5iEEQU6bRyAau8Ec6NMhaypAGZtgRlXE65XMwLgAWQR9LnbgVscRDPIPdmDOS+Cm2G7znJlQA5aJFeUfogQBn8cq0b1F7O+mXwb9QJBct6Im1cuSYZQApzOyKJfekMjBKN+ud9uvOzGFFeol7BSQEmdA12IthMr1WmGvnaL+iQmdMi90TMTKDJT4+T2ELqjahqnZhg0/LThxMWe+uPXuoCjz5w==;5:7Lf+mzDlPJdH8QMUieK8ODdNuYAXODi0b39cEMyt2/JS/LZ2SZ39jEDqV87D+pe8N4Uj042uf7uiqzzhjhxifVTBPqHhqa2QJCBCKJCxvKpd/YTcOGQx2SgyfthjF1gCVu/XvH9F1hMrwrUpPCMcuUiLe8GuSWfDw/6uZpTUVBtbOdkiJOg1PA6zxvlcaQNcsBVSv15oJjXH7pNoLVckVA==;7:yuMzo0NVliHaucEnMg3Zpi4+Exi2cISeo7ZyPsA2kleYDtoIVQ9CcEmxQ32jwoznn0k0HKSs5hN0xT5BLhVP8jrchrXGLXtphY8KuZTVs5Xtw6y1uqAfDDBa6pyuWJerpdrzBaYE+16/KhsVvEQCVA==
x-ms-office365-filtering-correlation-id: 2b26bedf-deb4-402c-1e5e-08d68d364972
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1328;
x-ms-traffictypediagnostic: MWHPR2201MB1328:
x-microsoft-antispam-prvs: <MWHPR2201MB13288A5984ADEBA4B74762FFC1680@MWHPR2201MB1328.namprd22.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39840400004)(376002)(366004)(189003)(199004)(486006)(9686003)(53936002)(7696005)(25786009)(386003)(4744005)(11346002)(52116002)(6916009)(476003)(74316002)(55016002)(6506007)(446003)(186003)(81166006)(33656002)(6246003)(76176011)(26005)(102836004)(316002)(71200400001)(478600001)(42882007)(66066001)(71190400001)(8936002)(6436002)(4326008)(97736004)(68736007)(305945005)(99286004)(8676002)(2906002)(256004)(6116002)(229853002)(105586002)(3846002)(106356001)(81156014)(7736002)(44832011)(14454004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1328;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jq8eIu1PGLffqhMgYP/hgXV0vBNwCcG4UM/mWOuUA2doOHAVCYkoEdy+zye2aBbU8vRmCwbCowLjoFlFEpor6ymFok9aEtX20pOo1mjOl2ZeLpRl4LP+tMG5c8BrPd2ATvJ/D5dWfp9bdL/MhyiPJwYWZBpyDESA+fiGZv0cO1fbOLhG+AhKhIp3THFkyAnTcNrFz3Vmhh06z0vEjK3UnjWdJJxOpU3HqiOc4GD4OjRTEkA7O84CCd03a17OG4bjyYQ89DAy+sHqOp9+duSJdF/JiSFaB1l3jH9S78MvMmK7n3UpNZ7TeWO8QerLRZkoDiquSV4QXcVZichDwItYeZKGHbj5XL+AURNAYW7XzBBFG5Ujfqu6zHdDhdlAfgCjbXklTCw6gK812ftxCFs/2kuQ0rWECXJZ8ouGlD85lfI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b26bedf-deb4-402c-1e5e-08d68d364972
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 19:56:01.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Vladimir Kondratiev wrote:
> Accordingly to the documentation
> ---cut---
> The GCR_ERROR_CAUSE.ERR_TYPE field and the GCR_ERROR_MULT.ERR_TYPE
> fields can be cleared by either a reset or by writing the current
> value of GCR_ERROR_CAUSE.ERR_TYPE to the
> GCR_ERROR_CAUSE.ERR_TYPE register.
> ---cut---
> Do exactly this. Original value of cm_error may be safely written back;
> it clears error cause and keeps other bits untouched.
>=20
> Fixes: 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache errors=
")
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
