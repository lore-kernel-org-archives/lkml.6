Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474783-2-3503419296981888600
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
    t=1521474782; b=gyynmVJvUjTviauXwKKT7o1y0oJmbPwD58kjZcJmR0UJX1n
    hdpyQcXaUTpg8reXZRh+OVX+Su45f3MQSR6QakXKfzH9z25pt8M62Poy2rSgFSvn
    nFbrZV9cgQe9u1yN1hxM6Z6152hcIOlvwlVdMb61gvwRqLhyD8bbqZr+7i3Gdvr7
    gIKNrfKSBwdh0we5eT3ZSHChPbA2mZMPMhGOXALxqIXtX/7lJ80eECmcB0WLU+el
    hBRRAjLKe17Ra79uO/j3bY22N0a7T82MVYGY7IeG1q0Ih6EtT6GueSiCpKuWRBKQ
    A65BtowPN8alxImkecj51kSZ+TWuQlXLzssCY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474782; bh=PqBE/H
    njCjKCVygLsXfEFcZD+CorfOrg/iYfHDv+SlY=; b=IBUcfIcqj+DURBq4H2w7HC
    Lb4BQMSNhROVeqPsL/k9PM34FM4dQk84S2PedOTsrWfeijoJPLmtOFUXf2m6fcCj
    KCdQZKCBmXsD1MxCXgo1nm/fP8kWYHiZcD7Ijm5O6J4YAV9VfXXis1Ji83q8bAh7
    aV6F71y0GVyyc3MIZmS5eVNejB4gRKefl9nRqZEwAan/Dp/uE7HMhCwWzVpFVeeU
    jei+ZtTeW5alrsuQoEKAW7WpZeMcpcBMl9o7xoWo2IyCn5jTF42KJ/YdZPFKc/Lq
    19ewCJQ5VIMqugYPi7PuDIleG9/YD8JJIjsK/BJCBKg4L+wXLGUrJC3YyNhyHDHg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KaicXZt0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtdegnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KaicXZt0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtdegnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeCSPwN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:52:13 -0400
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:57771
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934082AbeCSPuS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 119/124] signal/metag: Document a conflict
 with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.15 119/124] signal/metag: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5nVZHtOs4DFeku6AvjGr4uvOQ==
Date: Mon, 19 Mar 2018 15:49:15 +0000
Message-ID: <20180319154645.11350-119-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:lDKkUVrl6k264MfuVNTRW3sLQK47xzUBaH87mJnWJzIUAembVmSqzi1iwJEC9fItX3durpOV/RkbtoBxEtYN7wvy1/RZvPS/VsXVRMF3SAdvDOLSJc3bGaIgZMEr0Q1jEYplNQY4TjuG/nvd8n+ciMs+9bnBvI1pN+zGEC8SEUacK4lGwPaiA9H+nOJ3ygJ9pyy5FpYthwvdk06sruYqrrrVe6fxEJMEpKZE1IIu6JNf4V/p6SQ2p3S0FEd22XWD;20:psHfSS3wkJtzMr/r8k9fiPHGB8Zkgnkg8ap6gd6woqAAHAGCpqPYSPLRpBvlqZgw32cvFjMsqEUpDj6kdfD7FBfbHa3ADW4GBKuGCaCgqPjyxFfO4rjZX0Iv1k4ZYv6m4fdCadOqHrLLYDIfjTY0XLW4rHdqMWp9UarwrZNHKXE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fe5d7b6-e3a3-43a1-8707-08d58db11679
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109CDC722EDFD29D54D8F7CFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XzyrFJo5Q7EBjIg7AWlefZV23Exz7PT24qhBECFhnHXfg8CThDipABLRc9yTcV/rBxNAsnLnxkxqUYLRPw29qFY6sWIlSw4G+sOizkYhfGriauF8sbF7xE4+yDShknxaeInagTwE8WNpkZfN99tFzOOZ31RPe6doNUexEt9N3JZGDnw0OrlTFpb2Z3hCQbgP7Sq5Ywr4a/rNyAPcUnhu4/CuqJNLCrVJAYH0LuNpFuuaqoS3VmWQuqReNchSMC+t73NGOTzUailNTNn7UHdyW+Wl15RmxE2YtZNuvixlceGpNTDNp1W/wZof9v4m2EXgaeBjpV1ekOLasSC5tNYPaA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe5d7b6-e3a3-43a1-8707-08d58db11679
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:15.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index b54ef7186ca3..9a3f6cde9487 100644
--- a/arch/metag/include/uapi/asm/siginfo.h
+++ b/arch/metag/include/uapi/asm/siginfo.h
@@ -6,4 +6,11 @@
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
index 444851e510d5..3b62b1b0c0b5 100644
--- a/arch/metag/kernel/traps.c
+++ b/arch/metag/kernel/traps.c
@@ -735,7 +735,7 @@ TBIRES fpe_handler(TBIRES State, int SigNum, int Trigge=
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
