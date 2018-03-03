Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122718-2-13183503249457724740
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
    t=1520122717; b=XmLYZzFt5ujMWvH7w6WMpGSZSMIbaBDt8r3P+ORvCWnP/xI
    cu9sFB6y6QVFgazxxQxiVPkBLPC7MaGHLd7RoprQMRLArnCOE23dsjsNR1edMNFO
    B1A6rLgcUoIrmsrE0SPSSXVl/kQVVTWXjsvvLksVTMXqzMN9i7DCtrM68W5ni0Qo
    m45SUsjUiUzGzw2QewMEL3JVsAVabUYXimCJF05kROdWSiyp93dDjLVUn81gjS6h
    kULZT9/ozH8TXi1biEQBAYp5ni284lRrfmIvGLE1uZga/au8OrqSoU9AnpSsoBDC
    Tp/RKmvlLdXutATgT1U68C0d87Cd+fDvTK5Fb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122717; bh=B4Iamc
    6yrPiBclueMkx7uHcMDwnzsGnYD3fWg6a1NBY=; b=MUwSCe8C9IwUP6JyogJPHa
    31JVpSBqj15xLxo2Kx6vLg4tKfs8OUdneeHMGvVzY2yfVILry4GWcReX2usgGGzk
    HjpXxX60Kg4hUUMquUuvTXjEvEjCfJP02v1+cTmz/2mXd0s0zMvgfeeRQgpMBvMb
    vskswnVMOYONPuNXrZyjuGvmtEgQpTDU8JPWHdZPu2aNVZ039CK2wLjWsvCcu4+F
    gaVad7F5LFRyV0N7obeBK+ofWhp+71PiZd12uzkmyuu5SwtV8KDoeHTPze/fS+3+
    2lf5gZpl2sZPgjrskraL2qM+n3JvUXiPdx7m/XfUo4529ZllRIjDLd9oL9w5CMEg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hp69DNTo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hp69DNTo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeCDASA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:18:00 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14153
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932405AbeCCW3N (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 48/84] perf annotate: Fix unnecessary memory
 allocation for s390x
Thread-Topic: [PATCH AUTOSEL for 4.14 48/84] perf annotate: Fix unnecessary
 memory allocation for s390x
Thread-Index: AQHTsz6rLLj3YR+NGUCC4OERLUa0jw==
Date: Sat, 3 Mar 2018 22:26:27 +0000
Message-ID: <20180303222518.26271-48-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:Nv1FGToEBsoLXthhvgTHmA+5LInPJKpHe9xlyyusHAZkft2XGSU/H64f54dnqNORXjbzmGDU00zzZZLdJtRXPBllAfmkzMxJWyUHgPtMd8/dBcoieRQWIfMvqmRj+6J+A+PdL2N+iemr5K8Pwr4AR0d+kG88uDZY7xWtY3/YzopryL/5MiChCJ4n5RoLRVdZraZAXPpwVZG0GA7EZhkhSKFZFTu2vZXgeB6+omWdXhUWYzwgAwj/iYAVP9w0WKNL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1921eb9-ed2e-485a-7476-08d581562f43
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10655BA8CAFC6DB7991F6126FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(6306002)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(966005)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: l+Nd9LV4NwBeqqoGPutLLuzL3NCtVSnpj/c1l0lKB/vvfsW4p1lmNOvSxLMMUlVZTLMkyUZFn2QjTwgiGJRGpQYvcPtBsmbpfJT1CeyDrqUl6qlPO81WWODnnMLC7YPO1Z0fqn3lwl0g3TfyFrJqtmjkcyKlspJcRPBLCVvV8Vc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1921eb9-ed2e-485a-7476-08d581562f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:27.6817
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

[ Upstream commit 36c263607d36c6a3788c09301d9f5fe35404048a ]

This patch fixes a bug introduced with commit d9f8dfa9baf9 ("perf
annotate s390: Implement jump types for perf annotate").

'perf annotate' displays annotated assembler output by reading output of
command objdump and parsing the disassembled lines. For each shown
mnemonic this function sequence is executed:

  disasm_line__new()
  |
  +--> disasm_line__init_ins()
       |
       +--> ins__find()
            |
            +--> arch->associate_instruction_ops()

The s390x specific function assigned to function pointer
associate_instruction_ops refers to function s390__associate_ins_ops().

This function checks for supported mnemonics and assigns a NULL pointer
to unsupported mnemonics.  However even the NULL pointer is added to the
architecture dependend instruction array.

This leads to an extremely large architecture instruction array
(due to array resize logic in function arch__grow_instructions()).

Depending on the objdump output being parsed the array can end up
with several ten-thousand elements.

This patch checks if a mnemonic is supported and only adds supported
ones into the architecture instruction array. The array does not contain
elements with NULL pointers anymore.

Before the patch (With some debug printf output):

[root@s35lp76 perf]# time ./perf annotate --stdio > /tmp/xxxbb

real	8m49.679s
user	7m13.008s
sys	0m1.649s
[root@s35lp76 perf]# fgrep '__ins__find sorted:1 nr_instructions:'
			/tmp/xxxbb | tail -1
__ins__find sorted:1 nr_instructions:87433 ins:0x341583c0
[root@s35lp76 perf]#

The number of different s390x branch/jump/call/return instructions
entered into the array is 87433.

After the patch (With some printf debug output:)

[root@s35lp76 perf]# time ./perf annotate --stdio > /tmp/xxxaa

real	1m24.553s
user	0m0.587s
sys	0m1.530s
[root@s35lp76 perf]# fgrep '__ins__find sorted:1 nr_instructions:'
			/tmp/xxxaa | tail -1
__ins__find sorted:1 nr_instructions:56 ins:0x3f406570
[root@s35lp76 perf]#

The number of different s390x branch/jump/call/return instructions
entered into the array is 56 which is sensible.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20171124094637.55558-1-tmricht@linux.vnet.ib=
m.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch=
/s390/annotate/instructions.c
index c9a81673e8aa..89f0b6c00e3f 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -16,7 +16,8 @@ static struct ins_ops *s390__associate_ins_ops(struct arc=
h *arch, const char *na
 	if (!strcmp(name, "br"))
 		ops =3D &ret_ops;
=20
-	arch__associate_ins_ops(arch, name, ops);
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
 	return ops;
 }
=20
--=20
2.14.1
