Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478367-2-6753216019392466774
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
    t=1521478366; b=iX4AHb3dW5vVClx8LOzCL0n4mfgQ9yK2WWgHwI5a/ZK+jeM
    b/nZaivkEeAtLuihyM1ww9235l9BkMg5jEI3x+lt3UBiWlRbkV0IN4r4MSPNikb0
    mTzAhmfMIqim//L5nWPUIQ8b5iX5AEsCWXDw9VMrvBZJKHaGRnACnK1ax8/XADnb
    XNx5FEkAK/7KAZIebXJQyeAQKz7SHZGBiKTP9D8azhg0/gpibJ2JOfIlh5RgSWGA
    EsDzb8v1L6kL4VBtm8eK/aLAECTOldfZiHNdF+MLabv03+14OXC1sA/CJ5xNwWsU
    69C2SpX0r6/oKsTTjt/A05c6dsS5u3AtfU3/xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478366; bh=VlZYh/
    WnWbbTWnd3/wB1e92a/RZtUMp3ElhAtgc54Fs=; b=UtUU4Wzrzxnuh9GYPQk5Yu
    h9wlOQNiNU/4etBF8w/rDQWeVFGuF7j6pM7zVA+ycq5lzrQmJ24NkVVUcSK1hX7L
    tV9ELDqaZCQw7LxbR4faZSVusmK1nD134a64KEywwxlgMgcqQwD08xrye/BcBAVE
    Q6wMYAPSdpMpbQPst9DIQRIKkbjiU93jmPCeqfXN3y0gLay9ISjn1f7f5oAgLntB
    rrQbHobDSw/nUAH1+mXxJIwa2Lx7k7swmbhajLSQRTmCJ58yPq+gM+f88Di4zlRA
    BCCjGYZvhuN6JnzBgc9HoAQ6QPDfgo7mcWV1qU2ypTyNHFuW0kU3DSL5gyUwEY7w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NqhvDl/y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtddvnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NqhvDl/y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtddvnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935155AbeCSQwW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:52:22 -0400
Received: from mail-sn1nam01on0121.outbound.protection.outlook.com ([104.47.32.121]:24704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935118AbeCSQLq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 165/167] signal/metag: Document a conflict
 with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.4 165/167] signal/metag: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5yRGwMBM5GOT0Gqb3vKVRFNKg==
Date: Mon, 19 Mar 2018 16:08:50 +0000
Message-ID: <20180319160513.16384-165-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:BJ6f3i83sxjR6tHiQPHofNCvcdyi8psj4dIVWH21wChp8lQhdIGtiOjYpu8VIMnTbowS8emLwKoq37OsoZ+bJ+kC8ugirR8BAwIlLASNXIQosfbAzk7l0lc2cMuqzOFRxnkbbl1eZFKYXFrU7spJajoLshiDaXp5xkbPss3SvFbWpLSKf66pYKQ6oGKo/sxR3NIS+EuEpl+b+khaaPKkh/CJW1AqVNVDHUFU8tU4XcDYGm/qVDHnWiFYqHRBgQPv;20:wUXXDGkGLMfuA69NBDFXRRcENn+3nKV7hrpL7Wq7kC+HfYxK9SNiOFc02011pARVBD69lXGxlIf1QoyCjNE+SIz0He1VnTEuu+G1q7xrmZQUNngUnheBrXuRTt0wstEHc/bkZhfWFSloEuUn26A60f3iLp1pZooK9+cwbbGURwg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c680abd1-fa06-44cf-3766-08d58db4124c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098424DFDD5B59BEA43DD5F1FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(575784001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rmP2PioexVTEwZvv/YqMgQpxaPPNGUHhL+TsvNz4UjcY5mUyxxfq25/kzEaudp1iaGoL5tQWAOpSnSycIMVkh6AqYZLV72POJstrgL5joPzsTdEQw3uyBx/jvLJ9LtGDv74rQkeW+7H8vIwEC7MUGBUDKwOx3jrIhNjV+y32x801nqT9zoKd9yA6glBC3RyRmSVoLRYqySYMUr9b6TE+yb7dUFOYiyU3p//mGsQL3NVLlk3+RhbC4x+QlQWTPj2jRK4XHHER4Dn3YTzJbwpoD5YUiII3NoCn3WnabCtW5mJaG2kiXR6VXe7bnJ5RqSNoXzbz8+hJdjIxx2EprzULUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c680abd1-fa06-44cf-3766-08d58db4124c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:50.6420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit b80328be53c215346b153769267b38f531d89b4f ]

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code =3D=3D 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
hat uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
appropriate fields will reliably be copied.

Possible ABI fixes includee:
  - Send the signal without siginfo
  - Don't generate a signal
  - Possibly assign and use an appropriate si_code
  - Don't handle cases which can't happen

Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-metag@vger.kernel.org
Ref: ac919f0883e5 ("metag: Traps")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/metag/include/uapi/asm/siginfo.h | 7 +++++++
 arch/metag/kernel/traps.c             | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/metag/include/uapi/asm/siginfo.h b/arch/metag/include/uap=
i/asm/siginfo.h
index b2e0c8b62aef..baac51cf30d9 100644
--- a/arch/metag/include/uapi/asm/siginfo.h
+++ b/arch/metag/include/uapi/asm/siginfo.h
@@ -5,4 +5,11 @@
=20
 #include <asm-generic/siginfo.h>
=20
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME      0       /* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
 #endif
diff --git a/arch/metag/kernel/traps.c b/arch/metag/kernel/traps.c
index 17b2e2e38d5a..6c4413c6a195 100644
--- a/arch/metag/kernel/traps.c
+++ b/arch/metag/kernel/traps.c
@@ -732,7 +732,7 @@ TBIRES fpe_handler(TBIRES State, int SigNum, int Trigge=
rs, int Inst, PTBI pTBI)
 	else if (error_state & TXSTAT_FPE_INEXACT_BIT)
 		info.si_code =3D FPE_FLTRES;
 	else
-		info.si_code =3D 0;
+		info.si_code =3D FPE_FIXME;
 	info.si_errno =3D 0;
 	info.si_addr =3D (__force void __user *)regs->ctx.CurrPC;
 	force_sig_info(SIGFPE, &info, current);
--=20
2.14.1
