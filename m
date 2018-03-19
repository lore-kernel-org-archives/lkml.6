Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496592-2-13335858848906605339
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
    t=1521496591; b=gvnvvq3dfEF3hWcnq/jvctJTQe6cNzQ166lk8047Wq9ciej
    Z/8yJP2/lecIEXJKRaAXhkyhhXGUSsXtzbhhrHDFKYZFeQ2cM1I3O8bvA+BOrh+H
    i1J16NNFS9hVfrfmaXLycTw8vv7O/rM25aycg1dIW7h5zz2uga1Ii3p+kOmzbLmN
    IdFcYg3vXk3qLWy1Op3bzZ0tlC1RPJ8VWI2z/14ZKTTqfwjCss5ysqdRLNvX2c4x
    QihHGNyF5b10Itxydio3saL/wz0q4hfIPe+dAJ6mS2/v1/G8FH35FYw1c6ba985g
    7bQhG0EaXYm/ouZjAm2cRnPN4B5M6A29YkCj1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496591; bh=NVIGv5
    mmXsOfVrw7hD6JUTB4zIjRB/twT7NaoOJhcKs=; b=GJwJcuj/oreYxbu8xWQTsk
    Ty7jjj5pC1N7n+jZoSODSbqjOIxKndHAIIxshZathkuvEWN10xQJuk2URWbdkZ+c
    xvUMB4/9Z40ADHLhYhOT1kdorMVAy2tZXEsevU7ncNgrmIGKDlRwCspzDDNkPlfo
    CDuEQRUtxiZ/5t3vDlAPVRw+2Ll/zGCfwmu6xuIuc1K2usX9hafX8saFe7JM1bfJ
    Wh+O5fhDtu8pmNIg447viFKdhpPVkoUZ1hOr9zjCyNVPzKhvlQv7Qux/TbkFz7r5
    NWEZLissQlZBksUH715xeKBu5xvbbk7QpillGlvqxyHW2t2S8XJDfPM9bFeeCOjw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bMEQ8VPr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdegtdelnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bMEQ8VPr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdegtdelnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972036AbeCSV4I (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:56:08 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:22624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934264AbeCSP4z (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Richard Biener <rguenther@suse.de>,
        Jakub Jelinek <jakub@gcc.gnu.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 88/97] crypto: aes-generic - build with -Os
 on gcc-7+
Thread-Topic: [PATCH AUTOSEL for 4.14 88/97] crypto: aes-generic - build with
 -Os on gcc-7+
Thread-Index: AQHTv5rW5wqS8worIUGxKFwE10/18A==
Date: Mon, 19 Mar 2018 15:56:27 +0000
Message-ID: <20180319155411.12348-88-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:BH3DrWBQlO9Uv76BKgUFp65lym5VHgEKLYal6n/Mz2nhckFmQ1gzNcwwfirUBR6qoAM+vx6pdDTopa2fGBT4HmLAj6M+H2Y5J9tFIqNUlMw35D1sdBULKy6GJOOJk00Vov4YiwI05hsmq/UxNiMBETgx0lzjoI6Q4ZR7gzskFYtK+GfpxvcBe7KCBtj0rejUMLKBgRljn13mmH1OXUU/+7e/7sPOia+t2Je1gV67JNVnYQR0NC9n8010psp8j2aC;20:pp/wmA0foSeLPaIXbkRl5aBrhG57RIShOhVtH/Jg8ya+u0b9U2C9nsdhbh8hxRtsC6MOQRheOV2Cjoajqm766lqS+sZ/1hSq0+YOVekbsB5m3IQj5xk5v/59nonkF0xZlezkfjj8//eqH2Xm8RZy21K0fAy1JqbcZ2ZvZcTD28c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25e0909d-7922-4599-9ec6-08d58db205d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1064FEAD7CE315F18EBF7E09FBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(22074186197030)(89211679590171)(183786458502308);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(966005)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(6306002)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MvkFMFH9ztT1spnrWeu6fJNKrtHtIjbLQkWQA+9kmgdwTjv1RA/1VvCFIrK6jm0blIUuvWV6pagHN9B0Oghy4MLUdEbZLhKLRWM8plxh7gGSNzCqjYuSLHg4tUjxRD1xwATP0T49AajS7H/qPLPYLKdLkCY/ELx/qU9bKsUn09ptJMMtU/RLhoScww56iERTlA/izU/UhjyI9gjWoLWZxbW+bk3InrDYphOP9vCs8rxMeefrbpxp6+ex8BcquhCC6rrhqyORvhAEpz2WXMHq2M5Cvxwp8LHVSa7aUA0ev1JA45AECtijSS1lcrDwDUDTZTeNt5BNUn/A0Zu++Em6Ww==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e0909d-7922-4599-9ec6-08d58db205d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:27.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 148b974deea927f5dbb6c468af2707b488bfa2de ]

While testing other changes, I discovered that gcc-7.2.1 produces badly
optimized code for aes_encrypt/aes_decrypt. This is especially true when
CONFIG_UBSAN_SANITIZE_ALL is enabled, where it leads to extremely
large stack usage that in turn might cause kernel stack overflows:

crypto/aes_generic.c: In function 'aes_encrypt':
crypto/aes_generic.c:1371:1: warning: the frame size of 4880 bytes is large=
r than 2048 bytes [-Wframe-larger-than=3D]
crypto/aes_generic.c: In function 'aes_decrypt':
crypto/aes_generic.c:1441:1: warning: the frame size of 4864 bytes is large=
r than 2048 bytes [-Wframe-larger-than=3D]

I verified that this problem exists on all architectures that are
supported by gcc-7.2, though arm64 in particular is less affected than
the others. I also found that gcc-7.1 and gcc-8 do not show the extreme
stack usage but still produce worse code than earlier versions for this
file, apparently because of optimization passes that generally provide
a substantial improvement in object code quality but understandably fail
to find any shortcuts in the AES algorithm.

Possible workarounds include

a) disabling -ftree-pre and -ftree-sra optimizations, this was an earlier
   patch I tried, which reliably fixed the stack usage, but caused a
   serious performance regression in some versions, as later testing
   found.

b) disabling UBSAN on this file or all ciphers, as suggested by Ard
   Biesheuvel. This would lead to massively better crypto performance in
   UBSAN-enabled kernels and avoid the stack usage, but there is a concern
   over whether we should exclude arbitrary files from UBSAN at all.

c) Forcing the optimization level in a different way. Similar to a),
   but rather than deselecting specific optimization stages,
   this now uses "gcc -Os" for this file, regardless of the
   CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE/SIZE option. This is a reliable
   workaround for the stack consumption on all architecture, and I've
   retested the performance results now on x86, cycles/byte (lower is
   better) for cbc(aes-generic) with 256 bit keys:

			-O2     -Os
	gcc-6.3.1	14.9	15.1
	gcc-7.0.1	14.7	15.3
	gcc-7.1.1	15.3	14.7
	gcc-7.2.1	16.8	15.9
	gcc-8.0.0	15.5	15.6

This implements the option c) by enabling forcing -Os on all compiler
versions starting with gcc-7.1. As a workaround for PR83356, it would
only be needed for gcc-7.2+ with UBSAN enabled, but since it also shows
better performance on gcc-7.1 without UBSAN, it seems appropriate to
use the faster version here as well.

Side note: during testing, I also played with the AES code in libressl,
which had a similar performance regression from gcc-6 to gcc-7.2,
but was three times slower overall. It might be interesting to
investigate that further and possibly port the Linux implementation
into that.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D83356
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D83651
Cc: Richard Biener <rguenther@suse.de>
Cc: Jakub Jelinek <jakub@gcc.gnu.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 crypto/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/Makefile b/crypto/Makefile
index da190be60ce2..adaf2c63baeb 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_CRYPTO_TWOFISH_COMMON) +=3D twofish_common.o
 obj-$(CONFIG_CRYPTO_SERPENT) +=3D serpent_generic.o
 CFLAGS_serpent_generic.o :=3D $(call cc-option,-fsched-pressure)  # https:=
//gcc.gnu.org/bugzilla/show_bug.cgi?id=3D79149
 obj-$(CONFIG_CRYPTO_AES) +=3D aes_generic.o
+CFLAGS_aes_generic.o :=3D $(call cc-ifversion, -ge, 0701, -Os) # https://g=
cc.gnu.org/bugzilla/show_bug.cgi?id=3D83356
 obj-$(CONFIG_CRYPTO_AES_TI) +=3D aes_ti.o
 obj-$(CONFIG_CRYPTO_CAMELLIA) +=3D camellia_generic.o
 obj-$(CONFIG_CRYPTO_CAST_COMMON) +=3D cast_common.o
--=20
2.14.1
