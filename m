Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241964-2-14212354409908982709
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241963; b=Cz0lhPZgT2Jf8rdyVn/Xp4H+i0wQi/RJK4EVReEIGik3JNnYNU
    pcXO30fOIsNDQgUp9vvbxgXp94XrlrBB2RHjBiU+vysOIaSu//F/K6F5BC+k5BqS
    n20i5zxXuDbLrddikvPviMZJS/otUpBHY2uDuqYG/6Ujmkdnl7gaqMl6reOLSnWC
    WXqRdJfhVynlBaUDViYVjO84ppc8KEvsdqewD5QwmfTjDWlNZtfQWKEMWjL+x7MA
    mRukgN5Ip40Wt0uC5N5JQMtHkKFjpTlfO7qNEptnM5ojfvRGdjRSNassrkrYVlje
    s5QGRTClowJU4sZs1neIm0seqGFVyo4FX1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241963; bh=OGsH4OJyel
    /0Qcgq1ndKzEqqd4pOIB7VKN3SKtIR6+Y=; b=R1HHf/sUBSpp7kjjZ3kQJb9Y6A
    JoqhxOuv+Xo3yQW6c4fgSnsXQ3PpYPxuR1pbG63itRr/Lm/TNgF6aDDFJ3JHT1fR
    CO6y6x8YLKRSeieLXThpSa4+PaBqYHaZXX3wDVzq30i61rQdfUN0RLJydjB5kkqI
    6oheIgRnIxMWunpSX1nM+Mxd/YPYha1mr4jWTQQ6rIO66ORYK7VO/xoMV7KLKeNs
    S/FIFQsjUpVPgi/QbM0h3HRdw2cA4k8x8aMJGUtmkzH2mydC18DIbeCR8tBAZc/x
    jAOTIfXEPLLwQbKLzHnhx4Ff0w/lm5SHTegv76I13B5H0ylJHtsL4EVtV5zg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e+2cawtL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e+2cawtL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNJznAQJsGmhJuPvPS1DG3J/QpzMx3vyFhQHqU3BFicrLCerMLcYqDyq0sSsCHcFo+xP+vxdGPTEroTUoRXU0dAk4MBlSm7vPXcxdgvcw8zz4IVaA/R+
    iVqlTuRla8isZNfocZT5RZBC06+i5LT6eJ6dgfs5ccZ+W5+HRYse0kEsY9LSwYeoyNCPLeSSIWMrryeLoHWZngTywKTOws3oBNgEuS45b1PV9FeGI4FabPQA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=i0EeH86SAAAA:8 a=57SyGIRnAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=IQ9en63qOk8Nk2YP1w8A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755889AbeDICqA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:46:00 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755414AbeDIA0m (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 015/293] perf tools: Decompress kernel module
 when reading DSO data
Thread-Topic: [PATCH AUTOSEL for 4.9 015/293] perf tools: Decompress kernel
 module when reading DSO data
Thread-Index: AQHTz5jqrDr4YpTazEmk1BBVUFbDGw==
Date: Mon, 9 Apr 2018 00:23:00 +0000
Message-ID: <20180409002239.163177-15-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:SON1Xv1UdNkuTbm2ZamhXrNSTi5wGPH4tGrqKgqDwe/2Ow/tLr+Vyq4VNE58rktVY1RcFpm3K68TpjgpzmkmLIgnjtC6Y9zj+Y8/PlfaYC2QEAZPYNwBrRHbahWSaH5C89Mr77FjKUNOb8DkHQKEqBTP7z7w/8mr3Apzzq76KxfMi9APguIwO5I2SQJ3tTZUTctXpkGL/cpp+illjV1ov/FmSmW99epCMcQu48sOLrrFtOfhUUYTN66DFLUkUAMy;20:3wef03saLhzwfciODIIodphtNZ5V6KJGMAlZ20gPVrXWMG1J4bkBuRacO1DH+JcpOycGNGZN03ngFBZKp4YXq2KPz+60SAa+VD4TKZ8uxG6AVbBo29zaDRkbegcf6c/GKQTRVVdf9/Hc98WBIHiRNetEfefOtZJGBjRny8UAxkM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1293857a-6d24-4516-32bb-08d59db08f69
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885FC80D3A1B19074EF93B9FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(6306002)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(66066001)(39060400002)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(966005)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /6ZwMVFU5KiO9AcpyE+3z9h9vfQx5iDwIqZEpKwDWRhNIQHOf0h3ekd8DBQOR6NPkOnHMKYsQ+Oh5+6SqL6rwfz1BOgo/lJB0shbyPOqtRnA9CKxGmrdrNJYIQ5nLm8ZGAKCG8WDywusI+/BN6op9/MANxxLfkNCmhBZ5UyZ+Z56PyyK0YgYQcxKFVjHe2JRL+i4pprEvTqn9/GmFlDK9jZyip/aIOoO9Rlussliyl7aPr2weSLpFoU5SFWy+e6DujPRMifwLrliyTHptdrjJfT59bqIU8snUbuHMFSCl2bQwcOzstfkWKiR9/C5DvOLKd6vfTVkFRaIHB8GzCnCI7nT665la8GgyIXUkDfSW9mo91hJcXFJCE3cIQiBj71V+qHte4+EzzFXtH4ajJSSx+thmpkkL2OO/t0SZeNQkDQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1293857a-6d24-4516-32bb-08d59db08f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:00.3154
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

[ Upstream commit 1d6b3c9ba756a5134fd7ad1959acac776d17404b ]

Currently perf decompresses kernel modules when loading the symbol table
but it missed to do it when reading raw data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170608073109.30699-6-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/dso.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d2c6cdd9d42b..4bc58822416c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -366,7 +366,23 @@ static int __open_dso(struct dso *dso, struct machine =
*machine)
 	if (!is_regular_file(name))
 		return -EINVAL;
=20
+	if (dso__needs_decompress(dso)) {
+		char newpath[KMOD_DECOMP_LEN];
+		size_t len =3D sizeof(newpath);
+
+		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
+			free(name);
+			return -dso->load_errno;
+		}
+
+		strcpy(name, newpath);
+	}
+
 	fd =3D do_open(name);
+
+	if (dso__needs_decompress(dso))
+		unlink(name);
+
 	free(name);
 	return fd;
 }
--=20
2.15.1
