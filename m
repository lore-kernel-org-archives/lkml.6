Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477419-2-11808535218842605314
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477418; b=v8QijJ2m9zODwgT6+NyXFzE3yGEBKJbSnAlzy6Oyas4YTh5
    cS/XrQZelEM66O46WF/4jdiZ5ylBI4sTB0EoNm+iMUjKOXrm5/SMPREv/g2ix80P
    PuSWMmwKk0skEObkhqgjYYtIOemTlLWGY3XtG1R6WG+HcnlNCW0LpiQnteK8G4uN
    R3WlQn4e1HjXGV5XtyamJV0WLI94xIMsnLsRIWGi7DbntCV1K4zBwvk+6rSZQQ4j
    SBFbCvRo3OjFpyLXH5piNosrCc4vUTOQ38A1+N/xhI4YFtC0C66l5h38MAIsxDIT
    iSN9R1BOlTBeO0MlgSgPllZF8Jh8g09mTU4+sYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477418; bh=fBWJza
    QrjBjpqbqG1WvBib7k1e7BM9SutxxxHR8+Gpc=; b=UUkFBVy2LdVnRbNb8eMvQk
    aH7HCZF+vaf7y2UwK2Xz/wk6Lu8iX7d2JEcneQfc0B9eCop+qbz1xumqLWE+3z4O
    Mwnpkw6/iHqe+EUEepmJ5jcufpL+JWRK7BmBY0QFgMmsGpmSJCZVGOTcCoanlydk
    Ga2HYSJT5imJk+Z66vTmWCREeRCwT4r0mcRVQSk54lr48fOCBX4a7tyECDiq5d3S
    ZbSe1XgqVDqZ0z/LXloth6lbPJ0YhMZS/Rq8c2EHE0zj3UAfw/Gz7M1sgiLM98PF
    4KZc8cKT0XRgstS24NahUF+/XzMAicS4dVW2rvdIfUI9xWMhcPyeBcBkCq9h0eBg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZWN1sAPf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleejhedunecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZWN1sAPf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleejhedunecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966232AbeCSQgy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:36:54 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:10304
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935274AbeCSQNT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 058/102] arm64: futex: Fix undefined
 behaviour with FUTEX_OP_OPARG_SHIFT usage
Thread-Topic: [PATCH AUTOSEL for 3.18 058/102] arm64: futex: Fix undefined
 behaviour with FUTEX_OP_OPARG_SHIFT usage
Thread-Index: AQHTv50byQW6BoIPYECI9wh38nJq2w==
Date: Mon, 19 Mar 2018 16:12:41 +0000
Message-ID: <20180319161117.17833-58-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:hPm0UXfFBgaVq2yyH/HDeD5uFK96eTowbJds5uQAt8to3vZVbqn0ypjmcDmu4c1QNJebK4S1uw4o0/9vYr1v7u09wiS458VB+vFJ61EgvRYstRgdq+6qX8r0PJ56MmBcH5jZR5HM2BZfSu5ToD5rgQhm+J3hq7JZ35SLFlm5/13AEHr2z+2B85fdI4MTIqOeoicT9RQtNFp/kAh2EFfKb+j/dGVEMUrhZWdqlAcss7NRoVtif3jC5gRXVOw2Kqrk;20:8RafqhQizFGqeyzWtwAlCrPKen/Z9BFdMYoeE2wYSMDTsBYHeFff1nTi9Vmmg2lTH12Uo8W6/Y5M7N0eWj/qrgvS/OSIN2Ptwf0Sb0kweWia2MFOyu+kE0pRqKIXdFxSXZoZVPlL8Sh+MOryoiRYAZABKpWykzuSxBls422F260=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4ab8d98-be24-4ef9-8d11-08d58db45254
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10327A607D2FC1628F6BF700FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Yk69zFw1oH7DGZRiK9lz5ABOm58w59cPCDfi1Ez7KT3SaFRgtIB6UsgvYOsdoFR/SDLkMlLDczfUQhUvPyaXCDFtipjoK481DMWnHqEyfssLwhK5Hf/N27EBhEuM6XsD4evb2sH01JW3OZJdNCqLZoOR6tVqtIuLuuTFTACs3+RnZoTh/D/8S1RE2Bwdev1Ff1jJnBaVn6BdO6pVgG6lSTsNOmTGuA6tSkWPYBykuVSCHK7JlWCqeGTsmv5OWIOQ1kZWU25n77AWxJTBksYLq6UWYQJiEE2hbvWiavC8Flq7hdU+FIFj3t8BAlx7W/t5AM5fLJvoN5G1syGhque/CA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ab8d98-be24-4ef9-8d11-08d58db45254
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:41.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 5f16a046f8e144c294ef98cd29d9458b5f8273e5 ]

FUTEX_OP_OPARG_SHIFT instructs the futex code to treat the 12-bit oparg
field as a shift value, potentially leading to a left shift value that
is negative or with an absolute value that is significantly larger then
the size of the type. UBSAN chokes with:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
UBSAN: Undefined behaviour in ./arch/arm64/include/asm/futex.h:60:13
shift exponent -1 is negative
CPU: 1 PID: 1449 Comm: syz-executor0 Not tainted 4.11.0-rc4-00005-g977eb52-=
dirty #11
Hardware name: linux,dummy-virt (DT)
Call trace:
[<ffff200008094778>] dump_backtrace+0x0/0x538 arch/arm64/kernel/traps.c:73
[<ffff200008094cd0>] show_stack+0x20/0x30 arch/arm64/kernel/traps.c:228
[<ffff200008c194a8>] __dump_stack lib/dump_stack.c:16 [inline]
[<ffff200008c194a8>] dump_stack+0x120/0x188 lib/dump_stack.c:52
[<ffff200008cc24b8>] ubsan_epilogue+0x18/0x98 lib/ubsan.c:164
[<ffff200008cc3098>] __ubsan_handle_shift_out_of_bounds+0x250/0x294 lib/ubs=
an.c:421
[<ffff20000832002c>] futex_atomic_op_inuser arch/arm64/include/asm/futex.h:=
60 [inline]
[<ffff20000832002c>] futex_wake_op kernel/futex.c:1489 [inline]
[<ffff20000832002c>] do_futex+0x137c/0x1740 kernel/futex.c:3231
[<ffff200008320504>] SYSC_futex kernel/futex.c:3281 [inline]
[<ffff200008320504>] SyS_futex+0x114/0x268 kernel/futex.c:3249
[<ffff200008084770>] el0_svc_naked+0x24/0x28
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
syz-executor1 uses obsolete (PF_INET,SOCK_PACKET)
sock: process `syz-executor0' is using obsolete setsockopt SO_BSDCOMPAT

This patch attempts to fix some of this by:

  * Making encoded_op an unsigned type, so we can shift it left even if
    the top bit is set.

  * Casting to signed prior to shifting right when extracting oparg
    and cmparg

  * Consider only the bottom 5 bits of oparg when using it as a left-shift
    value.

Whilst I think this catches all of the issues, I'd much prefer to remove
this stuff, as I think it's unused and the bugs are copy-pasted between
a bunch of architectures.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/include/asm/futex.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.=
h
index 5f750dc96e0f..49d057eb93d6 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -44,16 +44,16 @@
 	: "memory")
=20
 static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 {
 	int op =3D (encoded_op >> 28) & 7;
 	int cmp =3D (encoded_op >> 24) & 15;
-	int oparg =3D (encoded_op << 8) >> 20;
-	int cmparg =3D (encoded_op << 20) >> 20;
+	int oparg =3D (int)(encoded_op << 8) >> 20;
+	int cmparg =3D (int)(encoded_op << 20) >> 20;
 	int oldval =3D 0, ret, tmp;
=20
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg =3D 1 << oparg;
+		oparg =3D 1U << (oparg & 0x1f);
=20
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
--=20
2.14.1
