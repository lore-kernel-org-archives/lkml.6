Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241881-2-13237652330854145362
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
    1523241880; b=PMJwa01zOcBaSSR4RvdhximLHMNTnFJRSvFElTfc3vIAUz1LIx
    cuLyBcvidyqJ8HCMKDa9sX5ldQTFfujmLp0QhkLhisqINEl/cL7p+GrwOwKndMx5
    7hSIwXwxY8YsyT8Uilbn+QB+dlLs+0tlcuR2P4y9injM37bo7w/y93a9tI0JOKub
    CatSGvh36KTKujNzvDqGh8m4kqBCCK/9e+Ufd6VJkbBpaQCymvPyDjAuz9IhTHf9
    isMNFi7Jg0XVz4RqaOseCamBHmvp0qPxwX27rkbnw+hmssJ1YvtrHnxqb8iZ/QR5
    I3jeVTq7ajwFRXqPEK4Fn11AomuC58zgHIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241880; bh=6t624br08x
    8uU0nOLrPQmOWuWdRdlRC9ZlMjT1ZEev0=; b=Kkd4aH/Mp5EvcvslUyung5EuSU
    EImCWEaeVPIYWyZv01XC8gbtvzNnXDsW/zPbTjNNoTb6F9FfO0bA2l+8csBs8VsD
    hVOyGEjOIwe3Ppubu8baYm+TIAg0Wbfqe1rPXjDukeS7ijuMy3FRzNb/p3Q8101F
    HaVgnwuyKn5QCv9znfaYJger47gFIDiDXA1xt0hfmo3Zhu/zFqIielRmiXj4wa8B
    1jms5A/OSucYsS8Zxb/nrafxDsL30VXpDUVydxMaWDorELNKs0fIP7F5AcPYu5t0
    plAe0QaYD+WlSXU6bQKU7Pgd9PMqzvAmJzeKuFWcE5DNxsTbPTO4TFq7Wp1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OvmaEtwU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OvmaEtwU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJiVDVTsQp0SU8Vc7vHWqP1ZVUxCExRfRitydrqtr7EHf6DcjoNm8gUj7EPSOohfB/EeU0TPdtXGwMmDHbDavc61Cu2P/MfbwO2KoH8+dBl7ECYzn1Ty
    mjTJ7v9B8jj/Lkkdua7dCsUSEzxt10V/KvyR/xnUZ6Zkbhuuhd/DRjmiLoazc6u8GzdCEnOSFT9vDnjtm2APbzz2Pkh3/uZfJJJhJXAIJNzRld1xeTNHOfDS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=i0EeH86SAAAA:8 a=57SyGIRnAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=Hk1IqXJRDU7dKb4ppkAA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbeDIA0s (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:48 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755428AbeDIA0p (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Taeung Song <treeze.taeung@gmail.com>,
        Wang Nan <wangnan0@huawei.com>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 014/293] perf annotate: Fix symbolic link of
 build-id cache
Thread-Topic: [PATCH AUTOSEL for 4.9 014/293] perf annotate: Fix symbolic link
 of build-id cache
Thread-Index: AQHTz5jpbdO9KJvFPUCRHGIbjiRcfA==
Date: Mon, 9 Apr 2018 00:22:59 +0000
Message-ID: <20180409002239.163177-14-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:YAbpZnq6e9DkntyTSNlrJ9fUhG0byOaRBykdGVc3ubm+OIoCn+wOZuxI7BKGoy1yptbDdFw8sBe+fEHh3m0XAVVxIFd3/Zy+GxjJTo/+q/Bfai39LnZ8J27QZimo+ruz8/B4srrJv5OKiglPGjR1DrmoTVmndGz/kpyuCmyU2rvUTNhX+asYH1fdiAdakStHVDB9zG/YCDupZke1D8Axqvypo3jtStZaiNhgsyYa6u6WkZPM8FD9AahOSDiVYDVi;20:jYgmgNQ2ntm/j4zlO8r3JcQqJVDPUem6DNr8V4+y4N4ACVExAtj8vI8utFpvK8uClwR4j1Dmhpgpc1pUBDSC6MzDKHvnPaWG6WvL87oLFX7InnAy+lLzURefX6tpL/VuEsV+p5/sOSiNRp9i14kmh6myJFXhr873me8H9A23CGg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 169bdf46-cc57-416f-3989-08d59db08ece
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101589F298AA6738A923446AFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(7416002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: J/EIebK8r9zrkkGdi2QqLYr1j5RBz2qA0XOpT56lnD+oa5h/H1WINFIkCrHvYsUyn0OfbuCSHqVC210nEFAtoUow4Wpe97CAJbFQZ8fOPk9ybP9vtDoEn08s4x8aLqpPidTthE/JNfxyUHjDmYObv29ckzgECEcNiNFBtv4mlQq127IRWyuQHh3iWQa45zUWKu5uylJYM+e5xL8CgNH5JIqrHDUFroASHZf8LK45yIKiR63Tyo/uKQ8XLtx8k/XByti+zorTSUyRJpjd+bl+6fWPsfLj8MQ8XazF64h8kra/QAmrmOIvKXBqe1r1HplFqFDwAwvGx8qww8LRVn9Jm6lH19di/VTcEzVvCqPWfA6uMrdtUm3rEUYgejFLIGw52wwYu+qmvyMmsrzKswc6jmVYHK11tdp7AesEe5VBn5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169bdf46-cc57-416f-3989-08d59db08ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:59.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 3619ef76b37d4803bc9daee9d03d82c8526db378 ]

The commit 6ebd2547dd24 ("perf annotate: Fix a bug following symbolic
link of a build-id file") changed to use dirname to follow the symlink.
But it only considers new-style build-id cache names so old names fail
on readlink() and force to use system path which might not available.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Fixes: 6ebd2547dd24 ("perf annotate: Fix a bug following symbolic link of a=
 build-id file")
Link: http://lkml.kernel.org/r/20170608073109.30699-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/annotate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a38227eb5450..ffe9153480a8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1251,6 +1251,7 @@ static int dso__disassemble_filename(struct dso *dso,=
 char *filename, size_t fil
 	char linkname[PATH_MAX];
 	char *build_id_filename;
 	char *build_id_path =3D NULL;
+	char *pos;
=20
 	if (dso->symtab_type =3D=3D DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
@@ -1270,7 +1271,14 @@ static int dso__disassemble_filename(struct dso *dso=
, char *filename, size_t fil
 	if (!build_id_path)
 		return -1;
=20
-	dirname(build_id_path);
+	/*
+	 * old style build-id cache has name of XX/XXXXXXX.. while
+	 * new style has XX/XXXXXXX../{elf,kallsyms,vdso}.
+	 * extract the build-id part of dirname in the new style only.
+	 */
+	pos =3D strrchr(build_id_path, '/');
+	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
+		dirname(build_id_path);
=20
 	if (dso__is_kcore(dso) ||
 	    readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
--=20
2.15.1
