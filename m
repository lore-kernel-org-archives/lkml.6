Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235820-2-5667615650232285161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235819; b=KWlVc/EpiGGV/YebzG8BfhOzIMq8kL3eqkLbF906m5/x5EhYER
    YVngzdv5BIeBSkYn2cxIqpd4PR6DZWIaX3CmbcCx/fY+I9KQGeUTvga6oVpQpacv
    md/poHz/7UFwd2g0ouXz/btLf8iFlavSrdgW8pEGyzerj4puC6MWM25aBhccgc87
    da55CXeDpA7Z3Wf1dZ88YF9za5U6S2QS3bvgOl63H0fqOWsjRzulIB9tEIDjfPxR
    OaJnKiZnQr2SWlbVZfRxmYa2U/oamnrTTTmkr7H+nyG/7/mKSVGVkYzYsWhM0sMi
    oHIQNJQCuDrqMxKvIvR6+UsvV3bqAePLQ3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235819; bh=+d9AzCcjxR
    wST212DYRcSauS0cJa/Sc1MIjq/y7UDZY=; b=HEezv01xJZKMcNnpvBO/lz4AZj
    ftQxKZaKmLlqcZACrlj3tApyrIYY3yY0hTqPJwzGGWkj7zQyMLZrnXcCVP6cKjrA
    pXRm6HkEk/4h/pDPqC/AHo1WfuHiK2yriTPidRf6FYTIplJPZj+kC5U7vmGey6r8
    zFZD09n3/LMRlZJ3Es7bpxrCbo3IDsg6lnPnlGR8m4jgexBJKckxYdXmiWk5Llc/
    PnnficV+7PfGXuZo6pbIDOskz+CWHOU4lMbJ727eyaajhtOFybWC7l0+47cm7pUS
    /IymogMAgsTLYVaZlU+u5gQ9DB7Z4QLpXlQiSBGD5PPTpawhwwnYLNCvjIJA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cg4y9JRC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cg4y9JRC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZuc3477Af21Nt7Cv7ATYIA/OQIrNA51qn55tCDhFL1Id8C1O1NTGsj31Z5oWhQDnNPe/uHVyqk+sf+uxR5MZ///Op9YnOSFag7z8PLb/xL5BBGPM/p
    bJyvWa/MM/zGNxTlpd1LQWqY248uMBeX7M+hqwzCBWAouvtrMMG3fKPOcFAEQz1ysMo32T4EZBNunvwF/80qpikEH2dxjgTO+HltoBYAxrbqFQe2y1T2rWgB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=i0EeH86SAAAA:8 a=57SyGIRnAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=TZeuQikzWl3-NoflrHoA:9 a=Zi6-US_SWx-mtsx8:21 a=mnnB2Esgnu3DsEuZ:21
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756731AbeDIBDf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:03:35 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933152AbeDIAjf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 007/101] perf tests: Decompress kernel module
 before objdump
Thread-Topic: [PATCH AUTOSEL for 3.18 007/101] perf tests: Decompress kernel
 module before objdump
Thread-Index: AQHTz5qgMbTAr0z6D0ClvYueqQdzRw==
Date: Mon, 9 Apr 2018 00:35:15 +0000
Message-ID: <20180409003505.164715-7-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:V8ixcdldFP1iwY1kXPCirAdFejueMst5FulWwklgbAOQEPIch6VhzShi8CKQUz9Jh1beU5aqSjztkDle7rps5Y7S8mBXExvQtQMjzOVt0pvOpFp2gcIKbBt5twDDk30tHZhKy+3wUNWgNa6sZL9AHdvoQL9j9VnoPzxSNysryjcgMDoFRJrybyIXKX4VB9oNNS7mlgboIIH07E4L9pEuKolSAQrN+y5MKG8dHOf8wz6mr2gH6LsI9DfoMyV9KkCG;20:8VHx6w0pHlIx+Ij0+q0DEl7wNm2fwu2YP7FZpFwwwFTyvuSdVAoKU75lAhwNKO+DEGcBSZNsHASvSpEIXfQyTOiTnp0zoNo1CRvS4gmhXJDeE+gZNcBc7wh1+ZeIu1tQT0xiDlIO12Nj6k9zd4oGSUv6Kx8cFI7pu2IoAhmYZIk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ea4f945-899d-49cd-0372-08d59db25a16
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047C86D6F3665B35753FEF0FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(966005)(86612001)(25786009)(3846002)(39060400002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6306002)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZH9mn6/inFHaSrdSoLI2fA9rWMPA1vYexWjBv0+gF4ApLd/mH47H8VWcS/b4nSmAmfKTmJ4pAxFeqnSRoRcguSc+9fLdHuOS0R6Ay6RuaRRYV0jrszNOWmvV4vA8Q+7tybEtnAixN8FJyZ3kVG8KxOpV6j0POo78+X3EMm/au8DO+mCvqi+3dCx3ieJ3u4qNbNut9kqdnOcw2a+LuVgzTV6R2+pluG0NTG0/bf/I16hBwXNL+OchbCP8S7lBcpEP8f9Yib9cZM7gTVnapNJ1Lv/upRb7AT8UNovKuS317SKBpY5Z0duqdeNfDWDmMOgZwUpinPMV3Hsd84c6DCVDo1RCqZzebZA3QGlzB2ETOoqdSS5rj6dE+4ej+ikNpScuWn1f1LQlex/vdMmF9rgb1I4E/7tCJFYy33F0D2FD664=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea4f945-899d-49cd-0372-08d59db25a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:15.4861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 ]

If a kernel modules is compressed, it should be decompressed before
running objdump to parse binary data correctly.  This fixes a failure of
object code reading test for me.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170608073109.30699-8-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/code-reading.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-readin=
g.c
index 67f2d6323558..28dfd1f7f776 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -141,6 +141,8 @@ static int read_object_code(u64 addr, size_t len, u8 cp=
umode,
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
=20
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -202,9 +204,25 @@ static int read_object_code(u64 addr, size_t len, u8 c=
pumode,
 		state->done[state->done_cnt++] =3D al.map->start;
 	}
=20
+	objdump_name =3D al.map->dso->long_name;
+	if (dso__needs_decompress(al.map->dso)) {
+		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
+						 decomp_name,
+						 sizeof(decomp_name)) < 0) {
+			pr_debug("decompression failed\n");
+			return -1;
+		}
+
+		objdump_name =3D decomp_name;
+	}
+
 	/* Read the object code using objdump */
 	objdump_addr =3D map__rip_2objdump(al.map, al.addr);
-	ret =3D read_via_objdump(al.map->dso->long_name, objdump_addr, buf2, len)=
;
+	ret =3D read_via_objdump(objdump_name, objdump_addr, buf2, len);
+
+	if (dso__needs_decompress(al.map->dso))
+		unlink(objdump_name);
+
 	if (ret > 0) {
 		/*
 		 * The kernel maps are inaccurate - assume objdump is right in
--=20
2.15.1
