Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479597-2-17380136669727274891
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
    t=1521479596; b=KsIYEJ0CD+vHTO/gZ7QemDVg7rl7he6l0RznDsgHrpFGbx0
    7m4RejFTdSPLwm2EgSIwQdQz/cf0mkyTw1WkDFWMUX5f/xj2UZp3NnJocXecs58S
    Q005IIky6wK3qhOzCYABm2gqXBaFTLSDESpN1lc1Aw/3c9/mFKoLCPLPrJSrsE9J
    oiGPP7YwbzyM5VfU8VUiZAGzzRdWQlAscvAN25O+P2nUwn6Vbc14bDz3OtdAC+WO
    H9dGo7DMQO62D5PURqqqitN4tJWJUpaMxipEkyRC+Ldpmbb+OJeJvFPbBN7uJ4AY
    Pf/9XrLnbdqOSGXOLWJTBvJe4R7j16N0zIxDUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479596; bh=1c1l6e
    XizQTP02ywSToVa8OyRH4RDxa9MrGwNsOmReE=; b=wclrtIM3zL3tUphB4j8g/q
    Zm1UecPR5riQyyTCaPpxsXCNrzr5f3mLt7A9UycJBn7j6irx22oF7SGSn8+C/ofZ
    VIOxxjBdfhKd4EYa3P4XixDshfiPyTnFOB1VH8+4o20fiEGOP638OS2FWPGMmxNV
    cfsUrFXoedCnvLUK9jnJ/3KWeM3j4QExjzh6eIpYi+EuHxIwy68WgBhQNcVtLa1T
    545b3JkmRMcCp6P7CORbTJEN3dK3OwWF1zodZt3R8w+z67TNRh6pamxojQxhRSuz
    TqrHFyjH9ytimfqapp+Cn+uKXclvKZiYD9RpwjDAmh5eC4E+Q+ihdUiHgwcPL+Mw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0a6/Wk5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheejnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0a6/Wk5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheejnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965304AbeCSQKS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:18 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966404AbeCSQJ5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ivan Mikhaylov <ivan@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 100/167] powerpc/[booke|4xx]: Don't clobber
 TCR[WP] when setting TCR[DIE]
Thread-Topic: [PATCH AUTOSEL for 4.4 100/167] powerpc/[booke|4xx]: Don't
 clobber TCR[WP] when setting TCR[DIE]
Thread-Index: AQHTv5xfyD+8HFOazE278h1Wj8TB6A==
Date: Mon, 19 Mar 2018 16:07:27 +0000
Message-ID: <20180319160513.16384-100-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:dDkLWjnG8+efljpw3AxyDeTP1uBGN8e8cUnhmjpn62HOJaqGUIeTynz7YjcH+Dc4NIL1frIgc1kyUmZfJiIhz2bVVyX+pfyPxupP9LW96Mw4iyA0v7qUOsvekaPd0OMKJZBCuZYZUWsyY/k6QS5Tr0Zeqc7564lKvZZJCgOoUfeFfspQyvQ111S+u8DyIFJuMPDwQJXUyxZy3U3OBRP5IrnlgvDMAXECNw5crenxVF2xAbH7B8CEWdK0xYkPIiRV;20:bYI6VI3YnNR2S60vQbDiF9RyIq9XHGdnmBj0f8c1AK+ugbd3dhcsUJoJHh1V0pNLlZ/417h6rGqtCIfrTqwuH2nIHdaQnLmZrNOClj0pnNeNkXo8WCQfySWgBJ5h7ScPFb9LKQ/x+JvaLxfTy6Q+Gv3KWlEXjU36enOiLLjYXb8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 234e6485-c903-49c0-22fc-08d58db3d97d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10957D7BE8847F39CCFADAF5FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eUEFnTL5NUL2gOSANvYpZQfP0Kp8OYkG9X8axVm9/8PUo8qGFVRc/iTZImTtz7eQgUTcfjyYpNsESlCxviLGZNWhgHvGrS55QI3AAI8andgiPxFZDdm62JWx5mA7P4mwXBeHXY0v85jtr5BraH1z0Rf/V8u7Td9G0m/x7iK7i9Cnz/gfbqNVoFpgfoVEvwEF0a17SZ2tWzHLqtZQoPWnoaB+G/eGNiBmq4VmyrwWSEHixnTnyjHyd2vwJuixDOhRsVf6FP016XzmxqZ17+C2jrVsOetf0yO7+TJ/xSH1Q5rMG7Xyegcli7a7sAIkT5nqEWs9BUL+CKzTSWd+lGLDJA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e6485-c903-49c0-22fc-08d58db3d97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:27.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ivan Mikhaylov <ivan@de.ibm.com>

[ Upstream commit 6e2f03e292ef46eed2b31b0a344a91d514f9cd81 ]

Prevent a kernel panic caused by unintentionally clearing TCR watchdog
bits. At this point in the kernel boot, the watchdog may have already
been enabled by u-boot. The original code's attempt to write to the TCR
register results in an inadvertent clearing of the watchdog
configuration bits, causing the 476 to reset.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/time.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 1be1092c7204..9baba9576e99 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -686,12 +686,20 @@ static int __init get_freq(char *name, int cells, uns=
igned long *val)
 static void start_cpu_decrementer(void)
 {
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	unsigned int tcr;
+
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
=20
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
-#endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
+	tcr =3D mfspr(SPRN_TCR);
+	/*
+	 * The watchdog may have already been enabled by u-boot. So leave
+	 * TRC[WP] (Watchdog Period) alone.
+	 */
+	tcr &=3D TCR_WP_MASK;	/* Clear all bits except for TCR[WP] */
+	tcr |=3D TCR_DIE;		/* Enable decrementer */
+	mtspr(SPRN_TCR, tcr);
+#endif
 }
=20
 void __init generic_calibrate_decr(void)
--=20
2.14.1
