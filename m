Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478237-2-726467715632669272
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
    t=1521478236; b=V+VN/jtEyvQMKbfNjWasaDN59uD/puMUE2LCfK4DTiQr3o2
    nYFmHVVgRJYAGCtx546G4AQ02Ast0Mt2jangoSEuqJT01R1LBUXbKrn9z5ilStfr
    AB0VDWDG9aRwk7FDLJO8ky0rbxhzwXgkWHhawqyuB/irtgqjZHMqXJdoYfLGUOva
    +VLqdx7Wud+R5GtL5v88Xt6NIPVzj5Jv8DfWcJFL91QjiEdfERUzOLYkI5egGog7
    mzJIqFQ9NOZcKhl5HcYIyzIzMqNIL4/hLjBnpm7Vr0KpiKowS039aDNUFlZMfsEn
    wfm4LAs/BGW/5pE3NTvFuZftoMiLHYhaFLo+MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478236; bh=ntgsfc
    5Q2hfyUqQm61kmlUpabYTuhEgDs93DW3OjsXg=; b=PfFrRdu+C+yr8ATpMc5UGC
    F8acZLv/r00dtEt4tlmlhm5uk+q79APrfD3QOwuAHsKjItw79WQwlc1CDXrtYFBP
    NVQuUm3jm1r6QLCkZcdVS6rWXXqCB75wTFnkvCpOKvgFhpQqdB6FRI508diP3JhH
    BTn3nZ7Ie3mD4Q0eRWT2kzVKlb6aTcvqZmsED0kE/2txRmbwr8abCv5bnuCC+Z1/
    hWfGiJ1tVuHc1UUGIju6LFuIxse/lbQYs6Fg01MRbkFjZBo4+iiAr6NFWbBP2Sjh
    gxyeNnmvRaA6LuiPzKAKlSie4i1KLE3OxlzETNNjSLIzFAb3j/DNDv4JUUA9LWfg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HxVsypvv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheprghllhdrohhrghdpthhhvgdrohhrghdplhgushdrshgsnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejvdenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HxVsypvv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheprghllhdrohhrghdpthhhvgdrohhrghdplhgushdrshgsnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejvdenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965301AbeCSQtN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:49:13 -0400
Received: from mail-dm3nam03on0111.outbound.protection.outlook.com ([104.47.41.111]:6417
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934025AbeCSQLy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 010/102] s390: move _text symbol to address
 higher than zero
Thread-Topic: [PATCH AUTOSEL for 3.18 010/102] s390: move _text symbol to
 address higher than zero
Thread-Index: AQHTv5z16BGqHdDV0EeXKvSk9jrsIQ==
Date: Mon, 19 Mar 2018 16:11:37 +0000
Message-ID: <20180319161117.17833-10-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:2VnDK0WR+oT7dIEapsaPSBHlbs7xBzBchPrdweF5Svo+7WkqavvgtQzEYOHx523vnyn2/brrl6bmtFyXraedDYLpoTWVMsBHxP0PCuEVInnYeCR0qeltwQpF8sxZimqYatcE5RSt6gmm09bsD0xldPdlkHauw/2/T20NGPiChPserqeUv+aDrETyH41yAVxWLShXUI+3SXZ0fwGnKNM5RD3xQUnfu0gr8g5Sg0gs2ZGRphQ0M94KDV9Vnr+3QbSc;20:RA0bbv0Q/0tdpuOztUIppR4CWVQYpxUFgd2w3Vlr6UaZZ1Xdyx8K0fiXNkndvTRK/omlb51gOYJsqpDQqOEac4Yh5hFzTbYAp8WyB+u1L6Z5oRi6/INFZoTDvH6HvENwChf+Zl1hz6mb5sho+UEOaUj4cpjlGu0Q9beMdqNzwr8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d05b8e1-7e88-4df7-f569-08d58db41822
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08059D96EC0E2F7E748DC835FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2Oj5F/fVsFZPzX4TswYhey3cPpDEDdRnc2QP1o/QIZYe+zw1P+7Nu+MFWgZP+kM2eCk5f3hqdVG7Ln/d9DuT/3Dx4kxz0VD/z9cJ7UZ5V4iKv4FH1sQzJJvWZAW0ii730YMwzlSz0QBwzoMwFD2WAh4S1nCFsGzOwQGzrOXW/mo+RPPAxCjZJYGgpzyuEgln4G+iAxB/qUb2mZn4Cc4Zf6jEJX6Yphs/LunJuMJcQwpENTIbnlKmY5eSGRw3Fgx91AonDb6zQ9bYrIlg7Tjmw/t119dbtNqtqBVxEXW/J7QU0+I8BEG1o2ApMpmu0lUO/6VZLUcfJGdNv2oMnaT3JA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d05b8e1-7e88-4df7-f569-08d58db41822
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:37.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 35b13ed0af5f..3e9baf333b68 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -28,8 +28,14 @@ SECTIONS
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
