Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE421C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DD7208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gRtCD+iV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfAJXsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:48:22 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:7713
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729256AbfAJXsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f2YOdqjg+xfTuMME7pdLRdpkRZ/AQ+qt7WiivDsG1I=;
 b=gRtCD+iVnlMQ+JJagvQ3nzuzxF3cPiCdtKkGJFNyh8IjVw8c1W9U/VSiv21RhzCEksodJh7fP/s192PVHPV1skErj1vP2cKtxV0rhik3u9ohNN+ihxkKrNLJL1qe/yG0L7LmqWQfxVCEDg8qUnsoR9f/vlHf+DLAp+bUNZl62M8=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB3276.eurprd05.prod.outlook.com (10.170.243.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 23:48:13 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1495.011; Thu, 10 Jan 2019
 23:48:13 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Joe Perches <joe@perches.com>
CC:     Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] coding-style: Clarify the expectations around bool
Thread-Topic: [PATCH v4] coding-style: Clarify the expectations around bool
Thread-Index: AQHUqT7yMz195OkzB0O1DFW0sNTtuA==
Date:   Thu, 10 Jan 2019 23:48:13 +0000
Message-ID: <20190110234805.GN6890@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0018.namprd14.prod.outlook.com
 (2603:10b6:301:4b::28) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB3276;6:/5u0WiW707yibvMGBtjXks3Sj5VAIVYvlPjrd4QboWmkDfRsWXQO/PBu37Oqk8IVfr9HYak5rLNHLGupIsRx8SxkIz3QQzol5anTyRICF8ehBjRt7fM89guSJ7RaGIv2qxYBrmX3ahNBelZjoAFElQ79ctkRtgdyAmlpUnHDeN3m9xCTDBa4tc46oKW0z1nPuBFQg9H5xdYYDHZSKeFoxkqsk3HOyDCu3aEj9KLwsZiYXHsJH9VZA0UFxrsKxvPiKciMvbbhmh7R3eDqCQOT8LpSMxdg7heV0DZxqGGFJweXsX8FxjIhuJAXHHEnlm+3kVDkQY/IlUfhXClxPBOJFc30w9nFScpDfqYNE6OFoQTro5Vcma0o+prYwUL7+aO944vdg67qwkZveKMVY0aKXHu0DFKs91thEFU5sXRD7w7Px8wQP61T6LpSBCBxlTweSqmQtGOHl48IB5PMZ2pj4A==;5:USE/38xcT9PLCX4uMwxo3mDRWblKWDtitjSNZ0jF+jSR2F81lOSWpQJrMkOq06GDc6KPiUhBUkgnUEaM86xX8OMM5MwfOghkjvWsL/jXhcyDxj0w2i8K0utSI2IbHReQbarN2/QpvoDPN/Q2ot5xb6yqFOR1U392+xwmYLeWhpFReypwslRZzDr2hxd38j7dYVXROV75XqhK1oqn7urKxg==;7:sBeQrQLgCssoYfT7KORU9+moDTbxYvEuEKmsl9qnyRAe8s/FF8NVfTnkV1cEtYnOHy8s9NdmmT59/4fVZehSu89rN7YDDoRUBsFAhjABnFujpTHQf1wTLm3NvbaZoFQF7PcB0+ccpyfGssOhubLPXg==
x-ms-office365-filtering-correlation-id: 4d01be5b-9e50-42d7-3ef0-08d677561548
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3276;
x-ms-traffictypediagnostic: HE1PR05MB3276:
x-microsoft-antispam-prvs: <HE1PR05MB3276783D8410905051930741CF840@HE1PR05MB3276.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR05MB3276;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3276;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(486006)(33896004)(66066001)(5660300001)(102836004)(1076003)(86362001)(33656002)(575784001)(6506007)(386003)(186003)(26005)(106356001)(6916009)(14454004)(7416002)(6486002)(6436002)(68736007)(476003)(97736004)(36756003)(966005)(305945005)(52116002)(2906002)(54906003)(6116002)(316002)(256004)(14444005)(81156014)(81166006)(8936002)(105586002)(8676002)(71190400001)(3846002)(6306002)(53936002)(25786009)(71200400001)(99286004)(478600001)(6512007)(9686003)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3276;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8cScJSf/vgfwgk47qW+SzU27+YqEHXvvSt5JEXiok2AX2M6QOuYOlKSLlid56MB/l8LtnsXmvvYYJaSayoKIW5TBraiOWoZHRknW63mInCv9UDCs8pS0eiyridVWXoMNkHSwCJwsqQNDNg5jg6ePSxrDFf+FZsWPiIWfKlRZRBekWsqS68uj0B14JZuMVti4mHUR/pkiePP+9sgBUunRqJM2TaJrMkw4Kx5j+dJlUccJKUsFYQ8R5XPKyBjdYZq2nb2cl/H6Pv7Sdnd0kN4o/diOsNVUcxzCrqEXbNUBEXE1cwqyILISq4rzLuMqcq9raHxMgxYNMEBWtLM5csIVz0i5Qa86GNJbkznGgIfY6ttjRVqe4rRIOn0gKVsEq/8vTyb35ctcmYV55CmP1lKAhcw9+2GfuV6X+gHztAwFZKU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFAB79ECBA212A46A98832A0F7E82B6D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d01be5b-9e50-42d7-3ef0-08d677561548
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 23:48:12.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been some confusion since checkpatch started warning about bool
use in structures, and people have been avoiding using it.

Many people feel there is still a legitimate place for bool in structures,
so provide some guidance on bool usage derived from the entire thread that
spawned the checkpatch warning.

Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3=
x6E4UJfA@mail.gmail.com
Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Joe Perches <joe@perches.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/process/coding-style.rst | 38 +++++++++++++++++++++++---
 scripts/checkpatch.pl                  | 13 ---------
 2 files changed, 34 insertions(+), 17 deletions(-)

v4:
- Describe true/false as definitions [Joe]
- Use clearer language for the _Bool explanation [Bart]
- Delete the checkpatch tests [Joe]

diff --git a/Documentation/process/coding-style.rst b/Documentation/process=
/coding-style.rst
index b78dd680c03809..db3e030d0df908 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -921,7 +921,37 @@ result.  Typical examples would be functions that retu=
rn pointers; they use
 NULL or the ERR_PTR mechanism to report failure.
=20
=20
-17) Don't re-invent the kernel macros
+17) Using bool
+--------------
+
+The Linux kernel bool type is an alias for the C99 _Bool type. bool values=
 can
+only evaluate to 0 or 1, and implicit or explicit conversion to bool
+automatically converts the value to true or false. When using bool types t=
he
+!! construction is not needed, which eliminates a class of bugs.
+
+When working with bool values the true and false definitions should be use=
d
+instead of 0 and 1.
+
+bool function return types and stack variables are always fine to use when=
ever
+appropriate. Use of bool is encouraged to improve readability and is often=
 a
+better option than 'int' for storing boolean values.
+
+Do not use bool if cache line layout or size of the value matters, its siz=
e
+and alignment varies based on the compiled architecture. Structures that a=
re
+optimized for alignment and size should not use bool.
+
+If a structure has many true/false values, consider consolidating them int=
o a
+bitfield with 1 bit members, or using an appropriate fixed width type, suc=
h as
+u8.
+
+Similarly for function arguments, many true/false values can be consolidat=
ed
+into a single bitwise 'flags' argument and 'flags' can often a more readab=
le
+alternative if the call-sites have naked true/false constants.
+
+Otherwise limited use of bool in structures and arguments can improve
+readability.
+
+18) Don't re-invent the kernel macros
 -------------------------------------
=20
 The header file include/linux/kernel.h contains a number of macros that
@@ -944,7 +974,7 @@ need them.  Feel free to peruse that header file to see=
 what else is already
 defined that you shouldn't reproduce in your code.
=20
=20
-18) Editor modelines and other cruft
+19) Editor modelines and other cruft
 ------------------------------------
=20
 Some editors can interpret configuration information embedded in source fi=
les,
@@ -978,7 +1008,7 @@ own custom mode, or may have some other magic method f=
or making indentation
 work correctly.
=20
=20
-19) Inline assembly
+20) Inline assembly
 -------------------
=20
 In architecture-specific code, you may need to use inline assembly to inte=
rface
@@ -1010,7 +1040,7 @@ the next instruction in the assembly output:
 	     : /* outputs */ : /* inputs */ : /* clobbers */);
=20
=20
-20) Conditional Compilation
+21) Conditional Compilation
 ---------------------------
=20
 Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9d720441..d62abd032885a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6368,19 +6368,6 @@ sub process {
 			}
 		}
=20
-# check for bool bitfields
-		if ($sline =3D~ /^.\s+bool\s*$Ident\s*:\s*\d+\s*;/) {
-			WARN("BOOL_BITFIELD",
-			     "Avoid using bool as bitfield.  Prefer bool bitfields as unsigned =
int or u<8|16|32>\n" . $herecurr);
-		}
-
-# check for bool use in .h files
-		if ($realfile =3D~ /\.h$/ &&
-		    $sline =3D~ /^.\s+bool\s*$Ident\s*(?::\s*d+\s*)?;/) {
-			CHK("BOOL_MEMBER",
-			    "Avoid using bool structure members because of possible alignment i=
ssues - see: https://lkml.org/lkml/2017/11/21/384\n" . $herecurr);
-		}
-
 # check for semaphores initialized locked
 		if ($line =3D~ /^.\s*sema_init.+,\W?0\W?\)/) {
 			WARN("CONSIDER_COMPLETION",
--=20
2.20.1

