Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474709-2-11206232739157592263
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
    t=1521474709; b=S5qdOL2eHZTDMifv+wCX2zFSve4BInCY8xcOKTv7NHfCbz5
    OxBSDrI0nzT3ZyxIj3o5tCYlFykt7DbLXLK7i1KBz+Gr9T78XS+M41aQiI69+rP4
    4kXUwfcDZxy1yBEJx9gG93d2Ct7IJRYkZ0rky3xbLQ7kgkA7jjd9pBC7cDVsGD2h
    921hPRyILtE4uWsc0ranN5OR0a69rztQM864mvXixjF1640seOu0YwGb1Efq2g3C
    r6s3qiDgmj6ftKcIvtPCuMGvr0dPj1ZhS0hyjg8/fuUA2TtlKYzY068O1g3xBrdU
    f1dAL7KEef8vegmR9FIetYHZFkoiUVr9h1Co+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474709; bh=swwkRq
    HIkL+W04xqRX8Pp7HNFudoJKv3jKiVRaqPj2U=; b=S9WUrdIY+/7xegmjpnqbY2
    aLk2UfqZT+ayPN/xRu3AO1Bt49s/3WAOG3kTDCAQ6hHwYgiSR1QcQqkZW2JtGwsl
    Nktr/0Letw4eupY7fBshCRywpN6GtiOX8Auga7dXxnPltD0y0vH9vHkTSfcuPGq9
    7uJRysiMVskJ3rwX5enGTJ0dt8uiSGeGTGo+oe1Y69uIts1rzO6B8Jal00tJaDvy
    KUIKJani1r6ZTTrZpap6Un/Xi3c8b8GrZPYj5qhqvg1dmNu1qx6KhZ39FD5Mufj3
    NVvhtAV12Pm8wMI1JhJKTmgfEtHLzcCH4b6bx8eCORONCMvqZxld7HZwHXFH29aQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q8YxkrnJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieejvdenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q8YxkrnJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieejvdenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeCSPvd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:51:33 -0400
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:63552
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934129AbeCSPuk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King <rmk@flint.arm.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 121/124] signal/arm: Document conflicts with
 SI_USER and SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.15 121/124] signal/arm: Document conflicts
 with SI_USER and SIGFPE
Thread-Index: AQHTv5nWRZ9GVwkWOECfLe8vrUOZow==
Date: Mon, 19 Mar 2018 15:49:18 +0000
Message-ID: <20180319154645.11350-121-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:yTCEDT+uDlVs85rduKyc9nIX7nrzNSiJumvI/tAImv75xg7PDGYpF4L19+z2EIWHS26dWW8bINtTDMSu4ZRZ2TPK817ZKIjq60LBTeQ313ZflTca1sTrXUqO6GbDQa5LUejFav1a9mlc3WuVyXGktnGuTcy/hDFpk6n/etq/IzYXlj13kOiXVyqFNZAh64dZIZI6Hl6ErMyqBdKSUiNzKtYGD9c8fvSo8NoDAhXnF7bEhbtFItHD/sw89knDwdaY;20:pYtLANcuM9XSmvtjgKa0D86lhoX2AzpRRrV2sAMxgVoCeqbZO0N/Ff0rp1+XYZjD78+9fYeccm48h+EaNnCeBAIjn7p4k56TnV2fAXbXXyBQ3rUB0FxnahUfMJVsQ8HeF4bT5Ytyn+ojx4Dyln33e/B8sjJQfzbWhN4PligUJbM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5444294a-d800-46dc-dcb4-08d58db128fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063B7B82414FDD9EFCBB298FBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(258649278758335)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(10290500003)(68736007)(966005)(110136005)(478600001)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(2950100002)(107886003)(76176011)(26005)(6436002)(86612001)(54906003)(6486002)(4326008)(186003)(3660700001)(25786009)(53936002)(81166006)(2906002)(2501003)(81156014)(5250100002)(86362001)(2900100001)(5660300001)(8936002)(6116002)(8676002)(1076002)(6306002)(3846002)(3280700002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(22452003)(105586002)(102836004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: AOhUJJxC84IvlntW5jv+j/D9Z+D/imRUAmolsZIXVNQftT/O6hL5/Q5884UTSNGz+YMnbwUbJts638i304GVCrs4jFCdWshWLZylw+beLsZW32Gs5YItZq+KssqE0h5nc6GRZ8awLFTYQ8aMqC3AsFu1Y1ARwAFoERPILaMbGFiHJK0Z7sVgfteqGKw3/gXJzoFXgwjTQx0rlbNXeCfHrwcr7B7ajrQU+53RosQl9/Dd1V0ha4vqUCVyuzbalDjtijloGQh7p4HXTUUWJFQinc1oR9pfeBmuY1W5CN4PNBjSvg8jRvZZmQoblkt1yIKHqQrFhqXrkrQRVW14cFH3bw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5444294a-d800-46dc-dcb4-08d58db128fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:18.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 7771c66457004977b616bab785209f49d164f527 ]

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code =3D=3D 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
that uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME, siginfo_layout will now return SIL_FAULT and the
appropriate fields will be reliably copied.

Possible ABI fixes includee:
- Send the signal without siginfo
- Don't generate a signal
- Possibly assign and use an appropriate si_code
- Don't handle cases which can't happen

Cc: Russell King <rmk@flint.arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Ref: 451436b7bbb2 ("[ARM] Add support code for ARM hardware vector floating=
 point")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.=
git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/include/uapi/asm/siginfo.h | 13 +++++++++++++
 arch/arm/vfp/vfpmodule.c            |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/uapi/asm/siginfo.h

diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/as=
m/siginfo.h
new file mode 100644
index 000000000000..d0513880be21
--- /dev/null
+++ b/arch/arm/include/uapi/asm/siginfo.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#include <asm-generic/siginfo.h>
+
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+#endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index a71a48e71fff..03c6a3c72f9c 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -257,7 +257,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 in=
st, u32 fpscr, struct pt_
=20
 	if (exceptions =3D=3D VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(0, regs);
+		vfp_raise_sigfpe(FPE_FIXME, regs);
 		return;
 	}
=20
--=20
2.14.1
