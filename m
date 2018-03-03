Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121214-5-12291710004099408835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121214; b=KoViHjbw5qlyo4Rvu3sKXUMNqtYnvw+UedGfe+As2t5LfCL
    BHAcRa6tNju/tB0IFMTLVp+cC5/4GDYl8eyglxAoUP9xZx0vx0Jlngechjt8vdwJ
    iZeIfBtIlkkESDuuWPpQ8lfQ5jNZAGHJxcPPnaGa7WHqloYyocLLp+17FQuzVjyI
    HmR6CJ/3TcDDLqCurP6xrMiDPeDvMLxRLqagmLuxZg2ViacihBqdCcqxotpPizyB
    myucVXe0yKeOYslXy1SZfnbK4HbmS6RfqqQ0fDGdTg9BZfRnbPXCywwTwI0609cs
    y5NauoWuC3tQseW305ON/dF3ABBZWck9kLsBdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121214; bh=5ZELDg
    Dnr69tBUjfzU+80KwPUIIAIadFnOpVaQP96Vw=; b=SmGCYMx0ffJ5UI0WBXaJoV
    BzqwhtBy4wArWQZb8KrELbrCjEDS7ErSilDnkaxHyZ3YGAEHwKtVfn6cuUeWcROf
    CHMGEkwAxPvrQFaUEe4k8RLiWPqOWynW3YD5So1AQNKo4yYBIPKGfs/hlyU87eR/
    MrGQocKU7B/lqKPF+b9DwWg8+nvsKquuCn21GeDFg3bFSUftoSMQy0Pv3w/xCdbc
    OVNUiwj8d6SKKPhyGM2nh72EV+4oBPMmp56nCkyqJL/PCuLIvUUF0hLOy4rkay2H
    gL5UoDZ1jD3nvkH22KYW5CGMn7iaLxx70enZLIiZasupdfyadJLCI/p2ZBa5JzTw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NBm8YL/i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NBm8YL/i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeCCXxa (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:53:30 -0500
Received: from mail-by2nam01on0092.outbound.protection.outlook.com ([104.47.34.92]:32992
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933891AbeCCWc6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Taeung Song <treeze.taeung@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 070/219] perf annotate: Fix a bug following
 symbolic link of a build-id file
Thread-Topic: [PATCH AUTOSEL for 4.9 070/219] perf annotate: Fix a bug
 following symbolic link of a build-id file
Thread-Index: AQHTsz74EiO3k2vYxkmoeWwhIR9j5w==
Date: Sat, 3 Mar 2018 22:28:36 +0000
Message-ID: <20180303222716.26640-70-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;6:+g6DtS1diWYjsEgnARWukALIe9Zls4kFcw97HUAKgacOqH89TJM0BWjREuSrogb+/9oiCLvyUIifHOHPcls6LVe3Y7F75IdIDWqrqCfiGudV+vGmFQxpaRhcZYJYHsf3lP+/cgua48NmLx+0RB3fv8+cEbaojsbToKPmWo1o7l8qpBuSLiiw+4A7KuEIosI/xaVh/zdM6XOFbmpmz0a2WJlofouAOah8GsolUNuXQthn+oa9Vg5/ryvOQsipxcvMC4ETe/GcTStC6bx1OItqOODYnn3Iypo8M6wFhTb5PVglmHkNY/oaWyLy6RzjEMFRWl//A2xXwjXEXPtnurRGT7mdypVOUSpf+IOh4W1cbcCRCDv/qTJMDh7ckIp5mppo;5:eM6vgF+RfuT+HIIGhnmVkrMfQ2LYsmtf71twcu++1nOvDCkyHu5GhSInpe+0Tb9KMc1k34YPb0NyIxKQuAJe62M4sg/DCxlKqhS+rOaVMwyeqTrGEKVn+bj+yslsGdmy7LTYxb46zfvbV/4wxd8EivTp2HsOI31qXsgsonKuCK8=;24:x3jpKLbRNP4fVE1lAwAbSE2A0rdrz7SbAF3brjHcJU9Eg08zasA1uEE0UyKi46gogqW/7FhYUnVkty8trN+G4AsVHOozdppWZQ8v/YsPwRc=;7:5Iw4sK/yQ6QjMOoj+ez6UAarXxz3cuVkb8mrcYCVDg/cZ559OI7vRd28wPc+q2jItgxYote72YWONYolYYit0oy5+UfKLxPAza/ijdKXPK3glH+qnGYDeNJiec7b1QDfMdAtk2TnjBCSb/OMFcnzdTJq3v7ZNUKECL+7fLzzzKjpM+v2+sSpWPQ0wjsCBecHbOlOkxOb/3A+fadXOQcsmb6sLE209Pgo3rwsidPA+y3eWOOd670ppvHZ+3zUaZPX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 826872c5-510f-4ee7-0de1-08d58156b4b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097D3DD42CF3D195A3ADA2EFBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(39060400002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(325944009)(14454004)(966005)(478600001)(186003)(110136005)(26005)(316002)(2906002)(6306002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: pEsNrDCsGRy9Xj0qY9ONTNbl6OObBYyDsV9QR+8U0+K5Le34D+LO/qAeOUSLEbQ90Dl2fuHxw7FjZnXllaITlgRpIqeID8fXP30QwV/72w7sHOqy70g8epKZ66YnXPBhVLYpqJRaIW5uSXPjf7QsPM6j8wzpuCBhA7KWPfFZOcQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826872c5-510f-4ee7-0de1-08d58156b4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:36.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Taeung Song <treeze.taeung@gmail.com>

[ Upstream commit 6ebd2547dd24daf95a21b2bc59931de8502afcc3 ]

It is wrong way to read link name from a build-id file.  Because a
build-id file is not anymore a symbolic link but build-id directory of
it is symbolic link, so fix it.

For example, if build-id file name gotten from
dso__build_id_filename() is as below,

  /root/.debug/.build-id/4f/75c7d197c951659d1c1b8b5fd49bcdf8f3f8b1/elf

To correctly read link name of build-id, use the build-id dir path that
is a symbolic link, instead of the above build-id file name like below.

  /root/.debug/.build-id/4f/75c7d197c951659d1c1b8b5fd49bcdf8f3f8b1

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1490598638-13947-2-git-send-email-treeze.tae=
ung@gmail.com
Fixes: 01412261d994 ("perf buildid-cache: Use path/to/bin/buildid/elf inste=
ad of path/to/bin/buildid")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/annotate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 430d039d0079..a38227eb5450 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1250,6 +1250,7 @@ static int dso__disassemble_filename(struct dso *dso,=
 char *filename, size_t fil
 {
 	char linkname[PATH_MAX];
 	char *build_id_filename;
+	char *build_id_path =3D NULL;
=20
 	if (dso->symtab_type =3D=3D DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
@@ -1265,8 +1266,14 @@ static int dso__disassemble_filename(struct dso *dso=
, char *filename, size_t fil
 		goto fallback;
 	}
=20
+	build_id_path =3D strdup(filename);
+	if (!build_id_path)
+		return -1;
+
+	dirname(build_id_path);
+
 	if (dso__is_kcore(dso) ||
-	    readlink(filename, linkname, sizeof(linkname)) < 0 ||
+	    readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
 	    strstr(linkname, DSO__NAME_KALLSYMS) ||
 	    access(filename, R_OK)) {
 fallback:
@@ -1278,6 +1285,7 @@ fallback:
 		__symbol__join_symfs(filename, filename_size, dso->long_name);
 	}
=20
+	free(build_id_path);
 	return 0;
 }
=20
--=20
2.14.1
