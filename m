Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122686-2-6468153346597094673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122686; b=njLrG/Ig3EO7cvI9h9g4a523Vfn5j9QndHGzjfBuO0Qc/0f
    kvyU1UZvPE4VKuIB+VeeqHoTTupzZXxZB/kmmViU7GRxwDaUtSfZe25WC+3pupAL
    osdTXOcUIofg09/CIFzobswVS7dnR/lyZ0xAElVXBPZv3HwjXenmy8psxh0+VqA8
    yl6xDKCl3cL+B346cNyTBXrd4P3atLsdh6ots6AoPyy+NaXd8ZYVP5Ep+Een8yzK
    auWp5B+4VF8a1VXqv2oSdTlx7YQcJIWJHwSVp8VV3Ao6BksZz4hcPm8+1QJTNrDw
    G2EKyNNOgWe3bNo1Kq2CE7YxerEwYXdLG6HFVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122686; bh=JftNn+
    RL0a59YzzJe8p67S1O0DGRzPPQgEHugpW/afE=; b=YQsMPKkojyyp6KkwS78/JV
    t9xEz568+uGs42nlGAvOkPlyWiNNpTy27RxRHFAbo2mnnO4qzA3ZQhWotCUrXaA3
    VnxZzte3BSBKZQEKYKHZXgp7hfWOr+8FmY2UvdTkryV+WhAIFs8i8eL2BwEigkvU
    fSvtxEEHZWULgOLigdHL5E3bb9pJFlV7DTneyhSj9YmPolUVketgBVUcYlWkaqhr
    PxXpadvdV/1b096DkAPh64MIccooqYo+dwF3JcuqEe4DA/Py0J/VMB1pDTediF6l
    wB7PnKxsUsH1GcEF51SroOtwY4btRHRRQpDtr1GABw4QRnrQSavYzRIf17hzMgRQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X6/iqGM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X6/iqGM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCDARm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:17:42 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14153
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932925AbeCCW3O (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 49/84] perf annotate: Fix objdump comment
 parsing for Intel mov dissassembly
Thread-Topic: [PATCH AUTOSEL for 4.14 49/84] perf annotate: Fix objdump
 comment parsing for Intel mov dissassembly
Thread-Index: AQHTsz6sFKWCjh9OoEi5t8UoD+RlpQ==
Date: Sat, 3 Mar 2018 22:26:28 +0000
Message-ID: <20180303222518.26271-49-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:+98qokKSUkoB1Z0yqEXYccXosJNt9DaUQ+WqUhvVjKG9hfD2ZWLXxxTePeuceDwJEoUkA2FfA//c51f7UkCtswCgtzH1rOzfga2GFjNcv2vItX0b0FHy9VJQE3IhDAsojzzz7crQrf/AnfCQXWOG9f34O/+kRx6eAJYFv2zlsJdlwuSdjQTsi5yOkzSM9/HLJ5p88uu5J3p4PFQZeOVTr8WSSi/O30llGVaTT+dXilp4VHcBiHYbACQQoFPyV7k+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 891d2c26-f0b3-45d1-34cb-08d581562fa5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106502E79B86D9C9C04BA6A0FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(6306002)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(966005)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZIFQfMEjAA4hfOV1G8jpESVRIz48VWbOCAe9yt998vbAJGF8+h8RXQqb5ErkfaYT92TTLmBE7WCl96VOo5qjKh8u4D8v2fJTsTf6m76klv+CLdNpFT1gdcPoX5TYInaqjregSFE9VVpKv+u8POX5VGIeOJKNexuqTm/eaShiQ0E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891d2c26-f0b3-45d1-34cb-08d581562fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:28.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

[ Upstream commit 35a8a148d8c1ee9e5ae18f9565a880490f816f89 ]

The command 'perf annotate' parses the output of objdump and also
investigates the comments produced by objdump. For example the
output of objdump produces (on x86):

23eee:  4c 8b 3d 13 01 21 00 mov 0x210113(%rip),%r15
                                # 234008 <stderr@@GLIBC_2.2.5+0x9a8>

and the function mov__parse() is called to investigate the complete
line. Mov__parse() breaks this line into several parts and finally
calls function comment__symbol() to parse the data after the comment
character '#'. Comment__symbol() expects a hexadecimal address followed
by a symbol in '<' and '>' brackets.

However the 2nd parameter given to function comment__symbol()
always points to the comment character '#'. The address parsing
always returns 0 because the character '#' is not a digit and
strtoull() fails without being noticed.

Fix this by advancing the second parameter to function comment__symbol()
by one byte before invocation and add an error check after strtoull()
has been called.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 6de783b6f50f ("perf annotate: Resolve symbols using objdump comment"=
)
Link: http://lkml.kernel.org/r/20171128075632.72182-1-tmricht@linux.vnet.ib=
m.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/annotate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 41d415707264..dac76ac117c1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -323,6 +323,8 @@ static int comment__symbol(char *raw, char *comment, u6=
4 *addrp, char **namep)
 		return 0;
=20
 	*addrp =3D strtoull(comment, &endptr, 16);
+	if (endptr =3D=3D comment)
+		return 0;
 	name =3D strchr(endptr, '<');
 	if (name =3D=3D NULL)
 		return -1;
@@ -436,8 +438,8 @@ static int mov__parse(struct arch *arch, struct ins_ope=
rands *ops, struct map *m
 		return 0;
=20
 	comment =3D ltrim(comment);
-	comment__symbol(ops->source.raw, comment, &ops->source.addr, &ops->source=
.name);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target=
.name);
+	comment__symbol(ops->source.raw, comment + 1, &ops->source.addr, &ops->so=
urce.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->ta=
rget.name);
=20
 	return 0;
=20
@@ -481,7 +483,7 @@ static int dec__parse(struct arch *arch __maybe_unused,=
 struct ins_operands *ops
 		return 0;
=20
 	comment =3D ltrim(comment);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target=
.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->ta=
rget.name);
=20
 	return 0;
 }
--=20
2.14.1
