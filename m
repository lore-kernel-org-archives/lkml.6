Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29421C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963D32145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="s4hNGubZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963D32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIXPTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:19:31 -0400
Received: from mail-eopbgr40117.outbound.protection.outlook.com ([40.107.4.117]:13266
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbeIXPTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwf9Dhv6x2Lz5nmxtR5gAyJLj6+v1veIRNTfbh+qhYw=;
 b=s4hNGubZMsPQMYu+5c572PKZhtg2fY+BFEoETP9mMQ/7qdK0spnS544vKOLEgu+Pbr/BlhFUX0MkgF+uP9grT9vZxjBOIkJNyPcvNeK/AM6DDyu9acOjJjx+K4JABv1N3aWt2N8ZJ7H8M7vByawsIeEbDXnXY68bZiWXf38MasA=
Received: from AM0PR07MB3972.eurprd07.prod.outlook.com (52.134.82.156) by
 AM0PR07MB4531.eurprd07.prod.outlook.com (52.135.151.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.10; Mon, 24 Sep 2018 09:18:21 +0000
Received: from AM0PR07MB3972.eurprd07.prod.outlook.com
 ([fe80::d99e:e77:675a:17f6]) by AM0PR07MB3972.eurprd07.prod.outlook.com
 ([fe80::d99e:e77:675a:17f6%4]) with mapi id 15.20.1122.009; Mon, 24 Sep 2018
 09:18:21 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] objtool: Link with -lz
Thread-Topic: [PATCH] objtool: Link with -lz
Thread-Index: AQHUU+eJ9RUUDJUE40mGaAzW03CjUQ==
Date:   Mon, 24 Sep 2018 09:18:21 +0000
Message-ID: <20180924091740.4914-1-alexander.sverdlin@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.181]
x-mailer: git-send-email 2.18.0
x-clientproxiedby: VI1PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:803:64::35) To AM0PR07MB3972.eurprd07.prod.outlook.com
 (2603:10a6:208:46::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR07MB4531;6:DIHlfDWNnMEToN6+bSJhDQelQW+86H3/bvXsZs9Rnp0nZSeHEI0BsoF1aObFsDju1t3jGzCcEoS0VTkbKB+6uMZ6eId2yUU847anx1rrMnjA4fjyz11Tn6vuvyZ85noFAsV/LfMNOmXgyjHIpTmV3SPbWe7x8CrUulJf4dmI3ADAQqaKQOaMAD//4/ggPof+AjElxwSZBFaUuyL/UzZJFIMTtke1WhWs7w1Th7cOWieNNRk4LUz6SQbEg8vrZLn2g/BBAoL3ONopoa3EFafFzNEaDIdZiE3TV09IxD6bLBBCF8DowpT0kZoI530A8rqx6e2Al3pBDMeXX7wpsehf2dYfSnutsNTNox5v+zO0v/dQeq+aDOkURGOM9Nn2HBtXoG23+S1ekniuUqtZtpuPDrPXcsroerVM/v1n4+HkMssoSFwVvVv5ql53FpFUvOOgwzHI1rsOhQloMPXK7ToFPA==;5:rCh4RajXMI0T3Umf46yisxxZGSnFLWCjPJMqjtzzuw5+10nloBv9c9RsI9IFHcu2K5Lj+6TTnHNLHx0uC3zcuXkhOXlpsAgBE3TSb7OJfcW82Exzjt8tOXqNqBk2ayhmLqhgErWdjCYW4N+w/iK/JKrqiItgP3Y1n9jv18mLknQ=;7:PzwCHAwXG0YJe3hTn5ZvFsum4PsqRFnpXG1HH0XTsvItQE3FmeavPkr+mJEuANY/SCXV3KqkXsxlzlfVK+2YbMTEzIPRf5vseHW1m3/1gVkLAOO4SPhbDbt8eJ2kNTxvUAlVTNdqoLbp4SujM4MBns/SVTnzXNFD0azWXPZmiNwfXtFGM3rCZ3wZEtanqLGFxTSH/dST0LnrZ9XuFQdduoL8nDUiUdrvXq5sgwnizEuc7QFxEa6xIIA9ZO0EiPFr
x-ms-office365-filtering-correlation-id: 36545ab7-2e6d-47d5-af8b-08d621feab40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:AM0PR07MB4531;
x-ms-traffictypediagnostic: AM0PR07MB4531:
x-microsoft-antispam-prvs: <AM0PR07MB453176A0B0F5E0E1BD5B61A288170@AM0PR07MB4531.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(195916259791689)(109105607167333)(82608151540597);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(806099)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:AM0PR07MB4531;BCL:0;PCL:0;RULEID:;SRVR:AM0PR07MB4531;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(189003)(478600001)(2616005)(66066001)(476003)(5660300001)(2906002)(2501003)(68736007)(6506007)(14454004)(316002)(6116002)(36756003)(486006)(2351001)(2900100001)(6486002)(81166006)(106356001)(105586002)(1857600001)(97736004)(4326008)(305945005)(6512007)(8676002)(50226002)(1076002)(6916009)(186003)(256004)(3846002)(14444005)(5640700003)(102836004)(6346003)(8936002)(6436002)(53936002)(86362001)(26005)(7736002)(54906003)(99286004)(81156014)(25786009)(52116002)(5250100002)(386003)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB4531;H:AM0PR07MB3972.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-microsoft-antispam-message-info: 36ynoDU9/4EJU12JdOE3tyG51LoYpfijarFgdHppPWcZyNFy+6LmamwPJGMl4PQa8AIfStEbdetn5KrLQh0XTAaPhHtmg1ajySWgAzTGaY2P3JH7fNgwdxR2XkPJz0PRidwpAGrfJN8WB+oqrLiBiRXELdDM802WeXRTEJ4BP+q354cCMUqlgc+EKzAgaNHYjEfcVf03wpLpzNs40KMxx8+PoYyTVD0G898HKK1hJXNFdtMz8ccumqlquNebyTwRlRu+USCeIDncjFydJBeXurlELdcxnYEZ3gBwlNrfCLG3K94OHiivREgHJ9O/pUj0682byIFnfwlDXqsbDmzEkLyp2gbUvwbxyFZFM1qyXIouKsssmaWSHEokWqW48WkLzXLC80WLf7ceoJyyBjfeIA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36545ab7-2e6d-47d5-af8b-08d621feab40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 09:18:21.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4531
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the following when statically linking host tools:
gcc .../tools/objtool/objtool-in.o  -lelf .../tools/objtool/libsubcmd.a  -s=
tatic -o .../tools/objtool/objtool
.../bin/ld: .../sys-root/lib/libelf.a(elf_compress.o): in function `__libel=
f_compress':
.../libelf/elf_compress.c:113: undefined reference to `deflateInit_'

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index c9d038f..d1847e3 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -32,7 +32,7 @@ INCLUDES :=3D -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS :=3D $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-=
packed
 CFLAGS   +=3D -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
-LDFLAGS  +=3D -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+LDFLAGS  +=3D -lelf -lz $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
=20
 # Allow old libelf to be used:
 elfshdr :=3D $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -=
x c -E - | grep elf_getshdr)
--=20
2.4.6

