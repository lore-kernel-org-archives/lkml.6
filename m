Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521480897-2-10855885562325614983
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
    t=1521480897; b=eNxP+htji/muEI6SvPmGWvxn0QRNx7Z57/2Hb1aPAHRFp7q
    BJX47FqhzESzYTvsxxkqKgB4V6/i8XDV1yiHwiR8yWGSO4VzeOn/ypL1oDA0s2pc
    v6/iTipe53XnlnyY6K02aSfURJnuYqMfqeO4NX04VvkG0yjT9M2xcW7qZ36oMdoE
    d8oGhZ0n4fxiJzyO7rs9nXMCKh7sCfIl5PnMlRbrQ59DAZLmLC2qlaTr8S/02k7d
    vRN5ROZ37ZFmuzSIwRt62MnLQy9xXuY5dpt5cIujHkCflWeHVjUqEUfuVrQgOfSq
    xRZGkV89OBeuzLc+LSfrus3Rl+Hoxx2OpDN03mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480897; bh=ZDqpHh
    NqzoGc0YBtBWU9sePbIpBCxVsaItKtt2GIf88=; b=nrkQmRT+xtAoeORsmfWOSR
    e38dlXWPdgYgrQZsY5K798VibIQNQJht7yiEHQS62SNlmv9titC2TrfbMtuiIuS1
    sQsm2NhjeapxnNKWdGC3iMrZo2dRoujKZIqr5D5buSO++/en5ycKF5g/8N1nkkgz
    jpvfz05uNCFebzTmqBGiLR63ZbACb/99lr4wjYXEsQZVIj0gK1YbfSyB9G72Xf+U
    fh9TJJbqOoKYkTygdBk3ewBWnPY2kVFf3pxcspF1bzjZALJwoHr03jC//Qxjyp4V
    Lg5jA6TsOpvBoS2xNuxtCScSVbK/lysz5gCBIpCrssIzKdvpalHAW5KMVCZPcW3Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nKw+QNIY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpegrlhhlrdhorhhgpdhthhgvrdhorhhgpdhlughsrdhssgenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjedtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nKw+QNIY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpegrlhhlrdhorhhgpdhthhgvrdhorhhgpdhlughsrdhssgenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjedtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965952AbeCSRd5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:33:57 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966075AbeCSQGu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 017/167] s390: move _text symbol to address
 higher than zero
Thread-Topic: [PATCH AUTOSEL for 4.4 017/167] s390: move _text symbol to
 address higher than zero
Thread-Index: AQHTv5wiP+RsQMQQP0WtF0XHOB58Ig==
Date: Mon, 19 Mar 2018 16:05:43 +0000
Message-ID: <20180319160513.16384-17-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:tRflMYQU39/shYCvd7e0gELUnZNsNp2pkVeFIw9Igj6AtyrrRyXzaM34VDHjuLVx2AmK2XTyA6wGmbeY6usDQfFiUTYv7Hl2WmtKIf5jZEflV0mPUuazqXYCbNASv7Nq0NlKxxMjhc8TwMRKCKPBT8u82Mku9SoXiYKYRnbfoApWjnCHnTiYg7Z6RW/9N10pJ/g8AsxXW7bf/BdLpsU53LZYzfqeH8+kt0FJxp7gZtyky4PKZRZZFBGFZOXWPj63;20:q+nKfNXrQgmxOf+kq7UAEKL7IbTN1niTowG7pv9QznfuIoyVaFbu4Ex9Dp6/9cpueC53pH2y9SdAXPfnpS/4sX6nTQXWsUEy8k07bSWlf/0vXkjL2ecuIaGpTEP+yoN9ezGfQyErP+lVDxUHwXB5g+23LTuyLBcPU0aF4ncICMg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9e49515-2222-4b22-d862-08d58db36b91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109389D772287CDB6E2BF6B2FBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: j3oeIhp1Nhy/3+SeAXYHZOzVVRG7nJllsUAXMHhR06NY5Db+CGfMgFzqlq5KGytxfML+yriVb0upQ+/zGGbYL4QgyyV/wgjO9P4iGbrsqKbx+OQ/pHqaOYFL1FH0wOVdvR4boAZdiF9GUQE/YI/UfBIrmnbSHBjMgizuAO4cLyxvsjSFsH6R1QPuaPE0MrTAI9Iv3361rRu9KQvSACBLbim5Ydv94iGz3rsveG6EsObgZ0i7TZqJ9VIBrS75c02rRDJvQz2/l+dpgHDwOaDnVuJ53eQPjmbIH03slhCkn6e4//sdK8lhLT5TRplhO1u+TMKYhrr48ihX9dArZZ7zkg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e49515-2222-4b22-d862-08d58db36b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:43.1291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit d04a4c76f71dd5335f8e499b59617382d84e2b8d ]

The perf tool assumes that kernel symbols are never present at address
zero. In fact it assumes if functions that map symbols to addresses
return zero, that the symbol was not found.

Given that s390's _text symbol historically is located at address zero
this yields at least a couple of false errors and warnings in one of
perf's test cases about not present symbols ("perf test 1").

To fix this simply move the _text symbol to address 0x200, just behind
the initial psw and channel program located at the beginning of the
kernel image. This is now hard coded within the linker script.

I tried a nicer solution which moves the initial psw and channel
program into an own section. However that would move the symbols
within the "real" head.text section to different addresses, since the
".org" statements within head.S are relative to the head.text
section. If there is a new section in front, everything else will be
moved. Alternatively I could have adjusted all ".org" statements. But
this current solution seems to be the easiest one, since nobody really
cares where the _text symbol is actually located.

Reported-by: Zvonko Kosic <zkosic@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/kernel/vmlinux.lds.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.=
S
index 445657fe658c..6c553f6e791a 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -21,8 +21,14 @@ SECTIONS
 {
 	. =3D 0x00000000;
 	.text : {
-	_text =3D .;		/* Text and read-only data */
+		/* Text and read-only data */
 		HEAD_TEXT
+		/*
+		 * E.g. perf doesn't like symbols starting at address zero,
+		 * therefore skip the initial PSW and channel program located
+		 * at address zero and let _text start at 0x200.
+		 */
+	_text =3D 0x200;
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
--=20
2.14.1
