Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241912-2-15729429037465862209
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
    1523241912; b=T7AQbT7KCKdHYWz8S9fV7W4sayYLAfXl5jtEoqpDZlputPdupO
    s3HaRLaxnjAxLF56QMOwx+/SgFSEmttSvcg0CoxqRpnulMvPZ1P4flKA0lB3M3x8
    tG3Ke6W7jeL+IIug/PWLOE1Jn7zpRXCSY6qcdtlgB8T5+7kPJf9sVN8pG+09fL3r
    g5ztoLo8jpTMnq5+MwgFnzH1QLG0UsNwuDIOboFe7PjxL/M+o0NRShu/w1Vctedc
    cPOgLydwZDr5CuDj7fg7f042v/9EHGOs0LZ27o3ENIW7IbDOy0cKOa69hQ6fr0gD
    TSsuvE+sfv33TlsSvtLAaCMgKifFCFvkC7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241912; bh=oC6cDmq05p
    gQTTWZL+itGtoHYTjaXK+KsS7ePpOOycw=; b=ogh6y1Mv6JhULUGVl+os2BDQJB
    XQD4rGxNUvG/1v/bwoNkJT2AZLgKZiLjJsyj6AzGvVNYCSnsSdFclu6Kf6MeB9Qt
    LwfAfUEPrR/xLE7TJBuFn7DfD9GVCjcLba3H3mZS8kzGeY+aRtntNMbf9SzobLiH
    agGUtuOCZSIjOHeqllSNn/RrdNxzV6VFbX238TZRrm9ziGpTPJaHTWxJBakKvYrr
    XNoYWXvXkpcp+P36O9RyEHFIwFxKfJrOEulti4mSLR6xbb3to2FtXOXxdbaxezcb
    NutqVmjCjmUfwok20CXDhNxrKYnnoaTMy+RGhoWzeNcu0AbVPfmDW7NPSlSA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lXjw9qHm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lXjw9qHm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLmiN7dUiAwdKLUSDnhePkZDxEONZRHsJO7yzLJkwz+GgUHcKBJuSgi+RvbdZgUtsJEvcMIgB+O40336av8F8+1vErIhgeMyCJNOk67dShnLC4NTLnlw
    J2xGaX5l39WiwUHEXtXlzCl2/1Q+yXt6j1D8Mf/k2hysQB6g+gSDW7SvkLG2S8e092/YCYTYUmpMBXGwK6qApLDiDzowK4cAL9MQe0+478mtwq7lDu3mcgwx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=i0EeH86SAAAA:8 a=57SyGIRnAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=TZeuQikzWl3-NoflrHoA:9 a=Zi6-US_SWx-mtsx8:21 a=mnnB2Esgnu3DsEuZ:21
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755436AbeDIA0r (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:47 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754647AbeDIA0o (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:44 -0400
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
Subject: [PATCH AUTOSEL for 4.9 016/293] perf tests: Decompress kernel module
 before objdump
Thread-Topic: [PATCH AUTOSEL for 4.9 016/293] perf tests: Decompress kernel
 module before objdump
Thread-Index: AQHTz5jrALn3ow7XIk+jZZngG7wkkg==
Date: Mon, 9 Apr 2018 00:23:01 +0000
Message-ID: <20180409002239.163177-16-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:e6vmq+50B+CsXG5O9yFN/jS+PkTjdpph1YvepJ5FV7FORN81oxFSiEGYkX9ujYSrSiq1d8DSl2cbVYR6tVZ4OAAQEx9LbDnr56OHBXgfoDIK2bj27jQ+07uTBo9pW/T+3xmINo8GLxJZHmr2GnvNUHnJsQGDazuZoHKwx4CA4awzT2iWAJl2DqToHDYnR/QTU2wX0PHJaXX8+sRZwpIis2vtjFQ2Bw+jwtRQwreM1S4AmFz69M9kt0DERFuFJ0+U;20:rtBpQr2ckQwVoTBQQ4D5TXX61NjAClugqLkYTAHMdJAr0WONlfNrDUa408CM25iweMCEodCHMihErdYMH6nPdfxB0Yc6n7E5SMlhKEslbSn0E2I8+CM2+hFDq1UdiT0ESRGfBvxbpCvzZVQr54IYT/SsEIPb6Xyq5kyMwS+AF4s=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 225234af-ad5d-40a3-42ea-08d59db08fba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885B90AF8039F0B2A6CF5CAFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(6306002)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(59450400001)(66066001)(39060400002)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(966005)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Uu0WxjcYr5QHQ+mJY2FG7oXOfiLbATOhsLnbIlEDMkN8kboLkZVoisFYlRyJviuQuJAcE3Iv82C+ufWwXuL3HQOub8Khq1zn0zMo6Xykz70lwf8JYKG04CIjoIe+39g+0eiH/Oe6nRBlCjFxy60PYEmqY/ehNQnuYRS1s+Nn+wTXmEFi/EgDTExnF4iJpCzqa79UWBWu8rdow4zB6NFu/e9dXH6zg4SsQevLh3+0zc5m9awJhe/rrMsOL9QZksIdZvBp+8vNIdmwus2Cv5ObxMO58H+LvHTHJ2ZxrxI7hV9sPcmUC6SCEKU7Xv+huYN0lva+Jl33a4nvojKYIQdQlqnajBKs7CGLetJhp0lFOFE1QEYDIfuXTh+7iUjU16rhGwoLg4lZG42uciat4iREx5TjzzeeffK2WVrIXnRJdx0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225234af-ad5d-40a3-42ea-08d59db08fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:01.3310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index ff5bc6363a79..150334064071 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -224,6 +224,8 @@ static int read_object_code(u64 addr, size_t len, u8 cp=
umode,
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
=20
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -284,9 +286,25 @@ static int read_object_code(u64 addr, size_t len, u8 c=
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
