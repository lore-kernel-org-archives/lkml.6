Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481128-2-8200607442922001495
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
    t=1521481127; b=osqxF/USDnFDq1IjvVJgRHKebzfKOX5tiHix0H31mdi/VHj
    +pCNFB/ZUpKDnlRPZEkebOritl8D0rpq0n6MGjBX014WVenfrpSj6dp8YwKLOWEZ
    gX701hBQStDfyzHxjpnP4mD1xqPMof68gh7DxLzxSbaoLXG6TqA7DCPzsTEYouKS
    dP1l8OhOgNnLxIHR1d4jRwJ8CkQJK5mbDHw2UtTRav3L/I1sJbTEnnusJ1gb94HG
    7Q1xlg014PGv6nascod4fP0cYg7LhUlraghvmua0uXrJ212slXf7j2K0gtvreZxf
    KaXWLW4430jhfpz0ro4hUj5ARMoH+ArTtUb/V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481127; bh=VlZYh/
    WnWbbTWnd3/wB1e92a/RZtUMp3ElhAtgc54Fs=; b=d2j25sE2wWl8qcXS4HZkfE
    CKzo2qdSGF9upYALsNPBzzkABf8mdkjYZiK0qqs7QDVUIKYFhk/WZu+klUUMcubD
    icF4hVBN844BSFY0B1eqQzAQOFeXi6PQyTeqNw0WxdYIYVlOxZ8oE9SjFeY/VC6D
    YxXm8yzncZC9qtS4ekq3pksueBHWKJXDzVn7iVtR/JJx0HWy3O8prRjmE+v79u1J
    g6f0avlDzQu4xTHKCslCNvHp7EYCVRIfbw5rdCpsyRXQTnkdwm/fgzwr9dK7XIHM
    SvTOPdJAThivsh6A4mA3t0B4n8Foh3lBLcc97rJjjklr0mAENjnQMVRKxvQaO/Hg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TCZgqAkN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtfeenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TCZgqAkN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekhedtfeenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965969AbeCSRiR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:38:17 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:13968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965966AbeCSQGm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 278/281] signal/metag: Document a conflict
 with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.9 278/281] signal/metag: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5vP8sN9bzDuzkeKYtOkrUsIYQ==
Date: Mon, 19 Mar 2018 16:03:25 +0000
Message-ID: <20180319155742.13731-278-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:9Kn9/rWKnqY2st9L2nXmgGjt2NHtCpsj3+Hf+xVA7PK5HZKj4Ty9CQKx3BCHWaPV6Xrw5RikKby32TxMR6Ryse8E4ffZPE/n3KwxB4GPgLVRmvBPAJdjDKbY7RjZObSPxkjEnYgkmTlOQx/DkowsPMacRvD7F2CQKoU3Ls4fGkfol6zzbpNLnx2oC71z7CSFBH1dhtroLcVv7Y0+12GS75SiBE8SpR0DTqdxPXsO+SwBVHnilW2GaSLAJHOnCeVL;20:tGqaf3YhVLTrqw5BRb2Oq/JqdCFDiIxPXUI0Jd/7peKamHwCCEqrWJw1/q7ciVuoTV9m0gLbELnNfqXQvs/jCvIPfivnoDvHhTmmI1+XUw0xOqZHWH5TU6HCvTGp2aMd5w3PXyDH+60Eoa4c24S8m5zdL+kHryZlfAvpikzNIiE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ed0c59a-97f2-436e-c63f-08d58db36495
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728C6149468F77EF10285A7FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(575784001)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5DNZyPkkxUKLgdkcW4YRcAN5RTn2TKUfrgz1V2fBr+ZBGoGN0uCTH7qcFTkqBNa4D3feMYyCcJtrsEmrmdIXsuQNT5LXTfy434177S8ABxCB2vdVyzuyH+46TUEGS4eAxMLafu60+eIsy6+SlOhUmgHU0p0h9j1LLZrAi3wRj+Sq/G87W7IWU1jpBahGXHbe2fa0zmV9udtdujBbVXv/BUcLmPkEGAkosL97davlo4Zuiln3pWUC+zr2/rUn3y+TXFH9rj0kZTQ2GONCmHEEZ+OdFm9twLinPmsTJHvvJIHzEaQnNSIJxXz7urA1iL4S+nuOU5bWrt+4D1zX9iRBeA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed0c59a-97f2-436e-c63f-08d58db36495
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:25.0323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
