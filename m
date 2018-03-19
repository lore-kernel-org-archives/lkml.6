Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479716-2-14939508257119985168
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
    t=1521479715; b=lZYPt1nQMnvzPPhMoSMOBhhuGZZSr+l5lI5Zq/t3X3OLFHm
    sYeGHeurKfENkGfUxEjopbM9zw955cukNrIqBUXVI/BUcEygmSV6MC9RQHYvRQzV
    f5giDqi6AcRg/TX/51RWQiEJRKlgKrvkbS3jYUs3fj/W+krrEu9b+uXQ2vtWYt5y
    VXc42pxAdRFaeREqBMAVXSulAa62y5U0zq5GD+Z7RkF2CnCaq2CYvP+JwB5P+9iY
    ISk9OeYayVoE51sdcREwVo04oD3UTNop2hTYvKeuWOB/I6smMBPLcpAiNamQrrc2
    S3w66Ob+wIoitiBpk9+zMoCxVw48jbGZeRrOlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479715; bh=KP4AuA
    5ayVyW6WZ7m+OcJWJwc1gBJvA9I68+utMc+X4=; b=hKQhVWCLxZM6NYlvIoQ89g
    emI2rVGhbgflHFbSu+M7JZxuwUi4tHwPa4TM/Wukz/uf6I55Y+cMJuPFaw2rKr6w
    5zEIHIS3IbgPelsb3oqRVFHjbTPGdL2slGCeXAQcXHO3rsg4SLjP33LL01MxpMUM
    jiaw8k0n2CA0+dxwl8HH1Q8n68OjcOCi4P9R8/IVr1G2oZhf5AqsUkun8HOgbvAg
    Nhz0Hg+s46vPHys6b3YkICHUDUKP7JAJ+B3YUhm6kiwaHlfGOUB9aYd+qkx3XHQL
    5FHo8N+SuvwqaZDxwqs8owl0cJq6erKHOnHq3uJHcmkhjYGNiBM4WjKllE+gtJeQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G+c5fQoJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleejfeeknecuvehluhhsthgvrhfuihiivgepheeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G+c5fQoJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleejfeeknecuvehluhhsthgvrhfuihiivgepheeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967924AbeCSRPN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:15:13 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966550AbeCSQKC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 102/167] arm64: futex: Fix undefined behaviour
 with FUTEX_OP_OPARG_SHIFT usage
Thread-Topic: [PATCH AUTOSEL for 4.4 102/167] arm64: futex: Fix undefined
 behaviour with FUTEX_OP_OPARG_SHIFT usage
Thread-Index: AQHTv5xhCbJ5RYWUFkCvPOJYN+eEpQ==
Date: Mon, 19 Mar 2018 16:07:29 +0000
Message-ID: <20180319160513.16384-102-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:cMa6w6x60n0SEJt3J1TDEjQBgbPr4ZGeTv89I1VvL51p8OJ6o07i7IX9INAQ2eIdeJyUFeWHQljgfjzA0flxQQsqWApZA1YkF94c5UavNo654Tl7MjC8iH7QDwETg2j+EIjfFgIZUl2kV73SZCKee2Qwb0/mVBcToeF6fiqtAGAFOgIVug7CfobByS1hHb1is2Z/wUytoR9qViK1LLiQhRW+tR4/oOdausLKCpBqPjbkwu6rRGMk5ZvqHrcH1nga;20:Q7f2B+tc5qXbFYNKr3q+Vb1O77hur8mw0v/RWr8Y242+krK6n+aOVyawbJFU4qYsxfEMwb3UniHwin7k5JfC2/EJ+iMaPZPRtwOSwo50oYjW7XKOUXNbmr+8NisUkiX5HhiM6oKCaOtPjsQbunhITSShiBmT82Q8FGU652rTnkQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b257ca6b-6e2b-4427-8c50-08d58db3da08
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10951930C5AED37CD7068242FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: h3nsgaTAgAtlOaVAamdvRCKwjyg1qGT6PwJI/bS0F8+D9xSuFPbMchq9xporlZAlKMRnZyxp2OyRsXRm8kx8VDotXfg7pnAObvFJfG+CLqnENJMyztPWpe6UDQvqNms29ACDjdwd+FSdRzcl+wA3cttbyVD6sZJ9CA4Ntx78MBsJcwtndjcdABou0Y8+Lx8//WtG+DnoE3oJOw7Kx/lmAAyi/ZMIz1s2yK1cm1qcw0+phL9jL+8vnu03H+a/T8OrNaJuuHzCTQ2PHpkkHJww7xzgBh+Z9PAFyF7TJYEBdv8FlE21G0dIhIu0P/NJZ5g77yv+hsl7qkmJnYgI9c+CbQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b257ca6b-6e2b-4427-8c50-08d58db3da08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:29.6806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index 5f3ab8c1db55..f50753573989 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -53,16 +53,16 @@
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
