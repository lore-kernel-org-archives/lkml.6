Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBE12154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HPcqaIsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBE12154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeI0Ed1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:33:27 -0400
Received: from mail-cys01nam02on0129.outbound.protection.outlook.com ([104.47.37.129]:20132
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725722AbeI0Ed0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmqJss7aJnVrTLWvV95asIEmSgxwMrbkkLEGp9r3SmA=;
 b=HPcqaIsCoXM6LWC5I5+JuLfLmT420wXsmRCesaB56A206lTqWTuI5I1Y/r0iX5Wrd3J7dH2xAqjsjy+gCzvv46q969uK/dLVvQsNdxAb5OzHeYmb9TXTpehI99yqUVmwQv/ByHj2dMt/rx7o3WSWcVqdaQycMj1u/84GiBc60C0=
Received: from DM6PR08MB4939.namprd08.prod.outlook.com (20.176.115.212) by
 DM6PR08MB5131.namprd08.prod.outlook.com (20.176.117.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Wed, 26 Sep 2018 22:18:18 +0000
Received: from DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d]) by DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d%3]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 22:18:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] MIPS: Add Kconfig variable for CPUs with unaligned
 load/store instructions
Thread-Topic: [PATCH v2 1/1] MIPS: Add Kconfig variable for CPUs with
 unaligned load/store instructions
Thread-Index: AQHUVYpngQ0PxG59TkGD0SQ1nYRUM6UDIo6A
Date:   Wed, 26 Sep 2018 22:18:17 +0000
Message-ID: <20180926221815.jfh7uv52oyry2gmq@pburton-laptop>
References: <20180926111615.6780-1-yasha.che3@gmail.com>
 <20180926111615.6780-2-yasha.che3@gmail.com>
In-Reply-To: <20180926111615.6780-2-yasha.che3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:404:13f::12) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB5131;6:uLXPvHoPtEX84yTxDm/QQY1A5iI7SaZqg+L1Rn9riLwVLlIKLDBlQgAVvvmG4P5C1iWjxPJWfRyCdh3l2ktB9JQLBYTtnV4ydwEVKWK2Vxt/sOaPns3g1jr/Q10uXUyPO8dxGifMgpZ0iIZkEeaUD/jjTzwXCyBuCUNhB/lBnhHqD9c+pxMWVCN3c140WP7LLVt9AHjlKoTYDUq+K6RD6qPpzW6t+gv85uyAbHiBhMocJUDggII/m7W/5pKWsFCUFzJREarp2zcaCqFyeD8cc9UzYtHJvWE0dL3kHUxI5iVDLzJKGGJkdEZlaL5GgsLHUzmq4pdIIzgtrANUOIOXrEoieJJRXhgvLcwgT6UvAF5WaC82MtQafuv43xKlwmuSEHrC7GeJhBkJo9NqZzQlnhR35+Dq2YjAY2WISdBSedzBBOiUzRB+0IYtXrv9SnBnnkgwl0P2NPQ6Yj+wgqP+CQ==;5:OekM90OTGHXe/V6pZDkKD9LrBNV/IA4V2hW0WFvLFyXz5Q/F4PDqYODsudEZG7t3dass1YOeAFWfdmCCGXietWTq3rEKzYYr9G7pCNAvHirCB9qcuPNx38C5K/J/qWZV/vjdWHYdSSB3krUXWZavvIJNq3B2+bKy6stqyYeJZfA=;7:DVokGbMynt+MpYmj1FrDXqm5mTDQiuUV3EZkXZf2WIA0K7BEHIyACc3smEi2ux89haYQYP2MV7+vQHdxlPMAnzA8c7xP5tgtLJ0fzkvAoPt5EEv00RFW8ZapuVGA+4f2Qst+SpycvCJEZk2Ej+QSQkf/R1rWityckhPBzJWeG9t+DVZK/Cug34N5bz3Zk95oTtvj/GIc5+cflF/7fVzJwLd/MNo+2f5V6ScSzQVUbX9GO7WfylBRsINJjst7APPl
x-ms-office365-filtering-correlation-id: 0ecec1ac-9d60-4e64-2fb7-08d623fdf5a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB5131;
x-ms-traffictypediagnostic: DM6PR08MB5131:
x-microsoft-antispam-prvs: <DM6PR08MB513150D96CDAB4D9E08DEE16C1150@DM6PR08MB5131.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:DM6PR08MB5131;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB5131;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(346002)(39840400004)(396003)(366004)(189003)(199004)(68736007)(81156014)(186003)(9686003)(6512007)(58126008)(26005)(54906003)(106356001)(42882007)(6246003)(6436002)(2906002)(97736004)(7736002)(8936002)(102836004)(105586002)(305945005)(99286004)(33716001)(6486002)(5250100002)(25786009)(81166006)(53936002)(316002)(71200400001)(14454004)(8676002)(71190400001)(5660300001)(44832011)(2900100001)(508600001)(486006)(6506007)(386003)(256004)(33896004)(34290500001)(66066001)(229853002)(6116002)(11346002)(476003)(39060400002)(3846002)(6916009)(1076002)(52116002)(446003)(76176011)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5131;H:DM6PR08MB4939.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6WlLwYG065UqNPfya9++3kb4I+awcyU5BSyFzT7fd7ecoS6+FFF9q2IoHoD+Bsup1wf/PhV/y2XeLbZZA5oPEXd3U99TVoLQ20nsw9aUargbPF9hQhlEjaeuKMipmbbxnZG1e0E+OdskHgvYmRh9Yns8Dwr6E/tyTwVnQW0AtB6LvfcorgTFjdfe+HmFTnfThXdp1OR2whVQY1zPw0geMg1s2GViSf+oMt1XDb6oU9mgdNoDAAYKo4hvuHIrMeTowTcoiDP9DkveygEcQSHPoq7UVk85zYLfCnxG2iS3s60Ga4aWtVIvHi9QCUEmA3KjMzT2m6DMNg8HiB7VVIkIcYY4sqrFZc66ULEAnD75Jvk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F362807278280D4EA29D2CDE0DFE2002@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecec1ac-9d60-4e64-2fb7-08d623fdf5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 22:18:17.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yasha,

On Wed, Sep 26, 2018 at 02:16:15PM +0300, Yasha Cherikovsky wrote:
> MIPSR6 CPUs do not support unaligned load/store instructions
> (LWL, LWR, SWL, SWR and LDL, LDR, SDL, SDR for 64bit).
>=20
> Currently the MIPS tree has some special cases to avoid these
> instructions, and the code is testing for !CONFIG_CPU_MIPSR6.
>=20
> This patch declares a new Kconfig variable:
> CONFIG_CPU_HAS_LOAD_STORE_LR.
> This variable indicates that the CPU supports these instructions.
>=20
> Then, the patch does the following:
> - Carefully selects this option on all CPUs except MIPSR6.
> - Switches all the special cases to test for the new variable,
>   and inverts the logic:
>     '#ifndef CONFIG_CPU_MIPSR6' turns into
>     '#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR'
>     and vice-versa.
>=20
> Also, when this variable is NOT selected (e.g. MIPSR6),
> CONFIG_GENERIC_CSUM will default to 'y', to compile generic
> C checksum code (instead of special assembly code that uses the
> unsupported instructions).
>=20
> This commit should not affect any existing CPU, and is required
> for future Lexra CPU support, that misses these instructions too.
>=20
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/mips/Kconfig            | 35 +++++++++++++++++++++++++--
>  arch/mips/kernel/unaligned.c | 47 ++++++++++++++++++------------------
>  arch/mips/lib/memcpy.S       | 10 ++++----
>  arch/mips/lib/memset.S       | 12 ++++-----
>  4 files changed, 67 insertions(+), 37 deletions(-)

Thanks - applied to mips-next for 4.20.

Paul
