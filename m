Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE6FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444A821905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ubdL8s+J";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Rm4pOu+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeLWJpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:45:13 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43154 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbeLWJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:45:12 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBN9eEQZ005409;
        Sun, 23 Dec 2018 01:44:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Cr2mVpNor7B/ELQg+VUSDGYpDpGN8yqS9z/Z6P2sBeM=;
 b=ubdL8s+JkPRdN/SvpxoLfXlEoaaGKgXl2FdO1bGjZ6MZFm0yyQ5BvvpPilR6Q6mIO6ft
 5up+Y6mTCSDlnQTitsMxZKQfdyZR7c9bVhHAAvyEIuanKq+ghYIXZWnYoNTtphy1ihel
 KwS0ElErKGeSvYAyoxNjS86t/mCHVjcZOv2GLrRIC3PaUEJAnLuEZ+8SI7XQgCOxiZxC
 vGgPsZQ/1MyXmqgaaBgLS9oJd2BNq3TZy9Jit4jfBXxsOScTaPVI/1Pt8KpbQSBtPOzG
 Ghe7hRhqPi4jKOFvko1apWRdo5zENkLrOVGxECkfaoQiJfa97ZstDo6fYMbOoq6jaofI BQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2phkgrm9ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Dec 2018 01:44:50 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 23 Dec
 2018 01:44:49 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 23 Dec 2018 01:44:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr2mVpNor7B/ELQg+VUSDGYpDpGN8yqS9z/Z6P2sBeM=;
 b=Rm4pOu+UFZHhTo9xLK0FIYM+6Q8MjFu73FT+u2wxROHtzAtsV2ku03FbGMy8ue9GKL0A7AO7DhR5LHZz5W5NnXoOHI74AFAlaPU+jCt1tEeKeL/kbQ7ysvaYov7sArQeEjYbgsPCD00Ou2C1gQbIpXBaUGnh9aegKz9k8qD2U0k=
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2904.namprd18.prod.outlook.com (20.179.58.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Sun, 23 Dec 2018 09:44:48 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65%3]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:44:48 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     Yuri Norov <ynorov@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] bitmap_parselist: move part of logic to helpers
Thread-Topic: [PATCH 2/4] bitmap_parselist: move part of logic to helpers
Thread-Index: AQHUmqQkvTCxGC0lXEaiGTdHsX65Yg==
Date:   Sun, 23 Dec 2018 09:44:47 +0000
Message-ID: <20181223094422.4849-3-ynorov@marvell.com>
References: <20181223094422.4849-1-ynorov@marvell.com>
In-Reply-To: <20181223094422.4849-1-ynorov@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR18MB2904;20:NnsiGzaF9u3+7Fbo/dL9DPmmWkCB4cw0lhSdhBj7fRHSuqyJg3X1nfmCH42XUChcGMEz6dcwxnLQCNhu0tpnAUwg+30lt6SbeIsXz9Wv6SFaTVT07IJ2CzqQHlkZU+KU4L7dVWQkQ1TPL628l/OPWQr8aw0wGxjCAyhcR+ys9ZI=
x-ms-office365-filtering-correlation-id: 72e27ae1-ebd6-4b41-bb60-08d668bb46d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2904;
x-ms-traffictypediagnostic: BYAPR18MB2904:
x-microsoft-antispam-prvs: <BYAPR18MB29040A87FB850F3AA57BD6ADCBBA0@BYAPR18MB2904.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR18MB2904;BCL:0;PCL:0;RULEID:;SRVR:BYAPR18MB2904;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39850400004)(376002)(136003)(396003)(199004)(189003)(71200400001)(53936002)(99286004)(71190400001)(5660300001)(86362001)(478600001)(97736004)(476003)(2616005)(1076003)(316002)(68736007)(11346002)(2906002)(446003)(36756003)(256004)(14454004)(66066001)(110136005)(305945005)(102836004)(8936002)(7736002)(386003)(6506007)(6486002)(186003)(105586002)(26005)(25786009)(6512007)(54906003)(8676002)(52116002)(106356001)(3846002)(6116002)(76176011)(81166006)(81156014)(486006)(6436002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2904;H:BYAPR18MB2888.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sPiPTO97poeZ6D4b8Mcvv+u0LJdnvJpWjruoUvyCXTj1L311uTfvD1VAS/BxUcNQZiaQePAvZFblRhvmoY8v4x7GLTp8AcPOX/igRojr8PdkrRJtki8Q6i2zpSvdQYmrls+u16o+2Lbh4qRBR65a037kWHvfU7oF6LTvA6dnQVSn+rU9DRVBb+z9oG/5m7fL1SAQkHciDEYw5JUQ0Dp3rmBieTby4QV+dzTXc+Q/c01uaMjLXNwAaWgvX4bop2ycLSvLDFVi7c01uKneNGRe8FTttxsJt7eq+RzTZh7u3IDS5mWIS0pyTnrKX8+Ni8dt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e27ae1-ebd6-4b41-bb60-08d668bb46d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:44:47.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2904
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-23_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812230086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move region checking and setting functionality of __bitmap_parselist()
to helpers.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 64 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ad43ba397c58..a60fd9723677 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -477,6 +477,42 @@ int bitmap_print_to_pagebuf(bool list, char *buf, cons=
t unsigned long *maskp,
 }
 EXPORT_SYMBOL(bitmap_print_to_pagebuf);
=20
+/*
+ * Region 9-38:4/10 describes the following bitmap structure:
+ * 0	   9  12    18			38
+ * .........****......****......****......
+ *	    ^  ^     ^			 ^
+ *      start  off   grlen	       end
+ */
+struct region {
+	unsigned int start;
+	unsigned int off;
+	unsigned int grlen;
+	unsigned int end;
+};
+
+static int bitmap_set_region(const struct region *r,
+				unsigned long *bitmap, int nbits)
+{
+	unsigned int start;
+
+	if (r->end >=3D nbits)
+		return -ERANGE;
+
+	for (start =3D r->start; start <=3D r->end; start +=3D r->grlen)
+		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
+
+	return 0;
+}
+
+static int bitmap_check_region(const struct region *r)
+{
+	if (r->start > r->end || r->grlen =3D=3D 0 || r->off > r->grlen)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * __bitmap_parselist - convert list format ASCII string to bitmap
  * @buf: read nul-terminated user string from this buffer
@@ -507,10 +543,11 @@ static int __bitmap_parselist(const char *buf, unsign=
ed int buflen,
 		int nmaskbits)
 {
 	unsigned int a, b, old_a, old_b;
-	unsigned int group_size, used_size, off;
+	unsigned int group_size, used_size;
 	int c, old_c, totaldigits, ndigits;
 	const char __user __force *ubuf =3D (const char __user __force *)buf;
-	int at_start, in_range, in_partial_range;
+	int at_start, in_range, in_partial_range, ret;
+	struct region r;
=20
 	totaldigits =3D c =3D 0;
 	old_a =3D old_b =3D 0;
@@ -599,15 +636,20 @@ static int __bitmap_parselist(const char *buf, unsign=
ed int buflen,
 		/* if no digit is after '-', it's wrong*/
 		if (at_start && in_range)
 			return -EINVAL;
-		if (!(a <=3D b) || group_size =3D=3D 0 || !(used_size <=3D group_size))
-			return -EINVAL;
-		if (b >=3D nmaskbits)
-			return -ERANGE;
-		while (a <=3D b) {
-			off =3D min(b - a + 1, used_size);
-			bitmap_set(maskp, a, off);
-			a +=3D group_size;
-		}
+
+		r.start =3D a;
+		r.off =3D used_size;
+		r.grlen =3D group_size;
+		r.end =3D b;
+
+		ret =3D bitmap_check_region(&r);
+		if (ret)
+			return ret;
+
+		ret =3D bitmap_set_region(&r, maskp, nmaskbits);
+		if (ret)
+			return ret;
+
 	} while (buflen && c =3D=3D ',');
 	return 0;
 }
--=20
2.17.1

