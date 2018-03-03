Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123922-2-11092394171368984200
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
    t=1520123921; b=YCmLtDfn9nEWy+/Ajaw0SQ4868TLEvGYA1qszYwl8ul4Emv
    OxU0/Erl8AlH0OhKlH5JRlCGHj1GfAg9FunmJ34o9sowsgMI0/uJpAI7H6wfXc1F
    DA0KWURm+zqc9XnsMFyjcdZUCPPsqElS5c3YnhhpP1NkKPSFgSm7FsTPi+YzO49p
    BnnVxu1KjxrPX4NwrTrJ+z3Ks1wSZor0C696yYNQpn9DXqmlzsKSwYMC+64+wG3B
    2QeUvqkEw3k8agk3rDF6BE4IURClA68bH1H+GAril8ewanlbSoY5mI5GWN1NtCWH
    72fyUQev+tapIEHKpZ7sioTgm12psHLhV9cQ+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123921; bh=uY0K1m
    QjTRFuYmutyyUnyfIUN9wo7sjre1he6PMHNXA=; b=Su/HpW6TKunLlDTjBAbW5m
    jA+YTVEpoV7L4n6hWVNP7TUYU6rtY00yHUFTGyuumlCRgH+/fE5C7ZCcxjGzX5yq
    C17MNpX/1YwTqq68Usu+P3yNSeeC12zCnFmrbNkh5SOm/6lwYY9t2+SIfOozF9Rt
    B1oiuYKNX+tn/sAfNVhKLN5s5xpJ8Lc6hA1RxY9OeSE3OV9uZlMkUTnz/McLSW/a
    sKhBuvYP4yZkH7Jizq/awQffmNi0HelFjIUe7nxefPGlVt3rwKJxDqWZ7+jZdrtH
    syLV79E/ndaIugKZcMCfYX1BVZyVrLryx5i7L3+FtrnSBv5QBmloXV2yBsGC4KJw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R8+8h6jj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R8+8h6jj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbeCCW0x (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:53 -0500
Received: from mail-by2nam01on0093.outbound.protection.outlook.com ([104.47.34.93]:27784
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932667AbeCCW0u (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 062/102] perf annotate: Fix unnecessary
 memory allocation for s390x
Thread-Topic: [PATCH AUTOSEL for 4.15 062/102] perf annotate: Fix unnecessary
 memory allocation for s390x
Thread-Index: AQHTsz5uPdGTL+0MZEi55Z0ZCWvHfQ==
Date: Sat, 3 Mar 2018 22:24:45 +0000
Message-ID: <20180303222318.26006-62-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:WDzcOa2HBPRIWi99RQwgd+G+BRO1J3Yu1x2KkLHvNocsm+y5nB9gt2mcjtnQtWLwOZollgMjRACZxG9aecMYECOreqZ2YzZ5knXhX1Of8Mg0hLgG8T5hraTmfpgOc6kkKbIj8d1VBvA9GoT1H9qmKQERGeY1gDYCO0uD2VNgjDu5dvs8NKidadb42gXR+G21+iyuACXoBGI2ZlhhZSNEM+1/nVt1fOZjZNM87bAeMoDjBMKYWvGsGOrmH6p4SGnW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ea81a1d-ad38-4840-3db0-08d58155dacd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06D6A143D5E44536B1B3E2FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(966005)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(6306002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bbEehyQWoUZk2k6VkAm4/dXn8CYKtYFOvJ7KyUQkogCq5x50W3LruQ/XL4J/xDnfoDRH70+qFwK7XQChGUf1WfWDWxvWb/cEZhvWKstoTBCkX4Wlmw9hVTxx2SZxPUtPmn2QTzeFij0ZGzw5MXhgKLqG45YWxYCdl5g7Rw7KPtM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea81a1d-ad38-4840-3db0-08d58155dacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:45.4003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index e0e466c650df..8c72b44444cb 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -18,7 +18,8 @@ static struct ins_ops *s390__associate_ins_ops(struct arc=
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
