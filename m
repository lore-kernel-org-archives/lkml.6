Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237988-2-11913668495781073482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237987; b=vgn1FSMXLKn2ODSBd4eENjkf6ZMb8oebfp3pQwSVrtx8xYS0v7
    6INTF7EZMOos4iw01NJOPjvGa7gHsIw4JV4ZioVjs/rnfqyX1AF5t2J3plBdFtOi
    GKvTNeyeBMz3mVSq6Ew/x0sXATJPKEUdLIySlzgiXZuYN+iqfN5j76rcfdG2Y4nG
    OYlymn3IWPjpWNYhVFEQ0YHLvMkR66r7U5eUEjotCJaP+5Fl6QmbBUiG9N6jZ6P5
    PI+aiHUzcqb9U2w20Jici8cBEfGsRnGaFJjqa/Udxp88QT4MzOBrLxS7w9My5j/N
    UxYLgQ8QrB18PEa0lZtUXRvH+F7zMPrkl3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237987; bh=qqbxrSETP8
    YIby5h0ymKPdieu7u9J3DBbnIjxqZN8Bs=; b=bS92/OryEhlMjYtT+q2mRdD5Cy
    Jx1epKQ+ci+H3+QkY1hm+dxPf8V3YVmWZJoInIbTd8dR8JeON8hLttM/KX/gJtb3
    lzaiLS4reeQ8gLxgmPwW2JP0qbtQz9+bKuxZz8x7yUNxMhAKCN+FS7eA9woybDFu
    XThw8jMB60Mn71VmuRNNkPZqldwPYbg0D3v3vHObitoxDa1+3f4EUfTJLaNo/Ps7
    DLQ73MvfdwpZRMrBVR+BOw6xvQovaXp3nb9mp2d7vQ7hBp9qNUtdCiGQ273Qwh7L
    m80Xsw7jwN4NDBY99TzKS63wEAFA9dxic5vlAa//4M+dj0oVl4YHYm9lbgug==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UhkOEwkK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UhkOEwkK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLRtzp529Nb64Q9nuXvnIDm0n5p00l7cHdWqQL7np+qeLxqd84dEAokQ9dXSoGpGomeVQ5sMqfsEUGd0rsbq5mIorrCaicZwSyiRCWKGQw4HYCD6GPQt
    dJP2PYeYEubbPBRvsMHHmw8AClu4IOq+mMW2BSOHsplKuf/Al1J6rE4KF5wPTqg3bCYr9k6NCG6ZPQVmFdtB58Bh3XlX50li3rQwNO/qvuYer8Cllxb1nrTb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=i0EeH86SAAAA:8 a=57SyGIRnAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=TZeuQikzWl3-NoflrHoA:9 a=Zi6-US_SWx-mtsx8:21 a=mnnB2Esgnu3DsEuZ:21
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756556AbeDIBjo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:39:44 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932543AbeDIAfA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:00 -0400
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
Subject: [PATCH AUTOSEL for 4.4 009/162] perf tests: Decompress kernel module
 before objdump
Thread-Topic: [PATCH AUTOSEL for 4.4 009/162] perf tests: Decompress kernel
 module before objdump
Thread-Index: AQHTz5mXDeYPvoJLsU+QfB//bxQqIw==
Date: Mon, 9 Apr 2018 00:27:49 +0000
Message-ID: <20180409002738.163941-9-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:KcyyJU4o7ll2qXK0bD1Dhssx6pG18Rul5pXvXNre4/YI1Il79cA5LLwmQmEx2VhdcVWysoIfs7iSNKMiyXvREWHTqUQMrB9k0/KBvlVxme0N3/WR7mSd7YTOXShl7fMolocS33KJQiaaymhME8nLi3q2WoeLHpOqZHORzxh5cSLqHFaCXpHRMnkwM5tUXQPQdI0i3CsA6ADqA1ZRzs5vT3O1h2/wr+smkjksbWpVbwRJbg96knyeqIbCVf0gxwcU;20:ZbgOm89pX9F8oU0lOMwC2g9h6ywIPkyU/0QUlUH9U1Juf8lCIhxWuoJjnQAcJg3n8QbEr/9gkWXiPkOF3W9ynMsXOh+Dubnm9qQ0wwj7kN2B3HeqZ63SnvEF1bU4X82IFTi+s9G42DzcGS3bQYV7UQ459lLgeTuFUazEcXjS/eM=
X-MS-Office365-Filtering-Correlation-Id: eee156ba-4cc6-4be8-47b1-08d59db1b781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013249F9D9A492061FC8D33FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(966005)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(39060400002)(316002)(110136005)(575784001)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6306002)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gxyZGIoDGNYb6vavpSb+2nR986ddZ9oriTw9dWqMU8tXMa2AqjJz+MQtpwM2C80WqzINcjy2RaltJBQqxSdMFmwkmj/7aHm7I8jtgQ1SvHBbWylTcVuGG+0SO9Hlv7hSs7d6X+ZNRCyyoZzsTx9Q12cQPh3Y06KdEjHBoT05cQWPGH0rezos3rcXIUNPTXDKXkqh0K0YM+mvKi4oZQQDoq1eHz3vq5F+yuT6LQRuOE+P6IBLIHDUjBADFhM3oKL+HpDdU3PsjY+xf8hwS/PFcnC1FgeRDbBBEYALFhWxrm3fNDHs1bayAjQOMAK1pdPcQoyIhCZTQpnQBK3oks3NPu0goDVg4Qje4mM0ZGc3bEYhpHWOj2gVIdS1I38NoSkQHkBkWEJlAhTPeY4jdA+4MmKXfsYLkumTd4KFOepK85E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee156ba-4cc6-4be8-47b1-08d59db1b781
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:49.6297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index a767a6400c5c..6ea4fcfaab36 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -182,6 +182,8 @@ static int read_object_code(u64 addr, size_t len, u8 cp=
umode,
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
=20
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -242,9 +244,25 @@ static int read_object_code(u64 addr, size_t len, u8 c=
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
