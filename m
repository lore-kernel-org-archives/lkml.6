Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476244-2-8742795593305581284
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
    t=1521476243; b=sD3fydiaPLKGBRhMlbytD8zaMaj/WwwuGbAGgoNEV1FOcZ8
    QSlNTMfkcRxtWKv1GRdCOtt7TI2ikXMAKoFcPu0Yd6jBsDUAnr0ZX1t1r8EnxMmx
    zRI2LIjZlbckSOcxOzooKXX1kX0/057P52OOm6/cqyprkQ2xdXBSDH7PvFTZdtT1
    7QV1jJMg9aDMhHkktaHU/afphNUXWXdFOU+pa8c7PSu972GIS9b7fnOm/ARFRtl6
    eQLY31Sc7dIvhOxvz1VAHujWxWE3nevZXZxv9rV3MAof2k6WSihVoZZJpUbh/Pv6
    p661pTF7f8st+sX6DuaAQb4sRk+RWNLFW80szsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476243; bh=VlZYh/
    WnWbbTWnd3/wB1e92a/RZtUMp3ElhAtgc54Fs=; b=EhBghK1A5bDqCuncuqX8a/
    1d8/GOJzu3MCnmzTlCF/cHQx3p6Dhr3LgI+LKpzqkWdiybBiZ1T0qJ+ZZ/WM1Eh3
    QlN0UR47DkDR34aHfTbyNqU/AWHZDwl6eimRpzuoQ4lEQd7bXLMgd6be7KF0FLB2
    Zz1+BKghD7qh5937VpnLTbj8u+/yOCdovZvHC0Iz0HKyueT4T18EEc4Au9m09Lm8
    Ac+6bHYcqUorfZoS3IY1NpB2HKZ86SVPQGrEgVw2FNrWtRHg1/WWZF2z9qxiU4Jz
    yPKkkD5JdmGi+oSFHot7+cNGiZBh5+QSAzqzg5YDMIwrIKIqqOgJnOjOsdNmgOBg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hBIiVHU5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtdehnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hBIiVHU5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehtdehnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966521AbeCSQRU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:17:20 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:29327
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967031AbeCSQPA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:15:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 100/102] signal/metag: Document a conflict
 with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 3.18 100/102] signal/metag: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5097fEJGzFiLEWdQ24FEM0TRA==
Date: Mon, 19 Mar 2018 16:13:39 +0000
Message-ID: <20180319161117.17833-100-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:JLQ2meziEIEJW5tymJCAsgMf5T2iCVokITjudOKNpu75UUWy1So5qKq9XwlfIRyXRMbT/yduAu4DHeYXx6WjcWjIkKTlmuOg+VAiTAW087JksP/3U6x6eakIK65da/nwPXdjGA0EBnk+5CgvhnlSxkkorjnVO8eX64bf6/TfLwZp7s5S6sSRz5WzuOY6edn0rfMMfDKrPUzDJsVVZidRyo66w975SMexBCL+2xkjFmFE0mNhPY6t67qfAB2LyEoX;20:OUY1vjqjfuvHmYPAzCyo+mM0P2HvJ17aw9ivq8dU9eTK0XEKAbugWCCZrMKdASttn/OjVZJA+uTQKktyyyesJLqpusbnQPPpDrN7mPAJ6zg71flY5D5+BRfJYiFPQcOkWyk/36msfD0DAToBRuEvyNwUJjzPh5IT5oJI8JS862o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01bf25b3-6eb2-4b18-e9c4-08d58db48ba4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869D9FC08DAA9AF6CB71280FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(575784001)(86362001)(66066001)(6512007)(81156014)(81166006)(68736007)(102836004)(8676002)(72206003)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(59450400001)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gr/LD6QBr7rmLuYm7QsBJ1s1opyhPLrGCiDxC1QJXozqn17zuL9V+xdEPGZ4bjUyk9eaW9o4Y4ZWxqFohAlNXWxxjVVCzmHoe5W4/NcpLDP/0bHKcLZE5N89C2gCptVKYRuCiQlhVO/eDWbhxarbXDwHbfAOUkTTO/2ZuVqPzSx1XtDgryPAY/49jzROT1uweHnMt/fFn4GVMLBxf/EYYkb/T6sUyOmxvayyuDmi8i9ncEtTnUHayYOYYPlWMBU1dCB3kkdoJ0ri7JN/gNO1KM4fYfOSyXkZkBvIEC/LeJafSz2GxzFDkyPaIE8SrC6KBvhsXH/P3/Vcu65ay2KqqA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bf25b3-6eb2-4b18-e9c4-08d58db48ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:39.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
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
