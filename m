Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E162C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EE921905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RUc/9SBh";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="m6zXRlyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeLWJqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:46:07 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37460 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbeLWJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:46:06 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBN9dvgO011809;
        Sun, 23 Dec 2018 01:44:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=A/JsJ7L4Px09ox9r/IaoHF5TEOiT6xdkEnOwOum3F70=;
 b=RUc/9SBh/SkYE0Mcy/Gih3flxtNiliR/DIV4ViPOUh+5ASKzcqfaHsaDg594KipMgoZB
 qOHDPOy6ieRynZEiIVt19NJEY3Bx1qZJ348FJGnNIS24NNWJcXXy44A1pU1Yz4SKCaP5
 ajuda65plU3AyjfO5Elg6plB1G3GsRnSLI8tfAM1oF6+BMSgwchrZA894HkdWEWkjaWj
 Rvs0/djVKDG3dAFFEsFUv02n7pCC51vu9mxW2sPXcX1N+X9j4SdbxrKMjk6h/nyNxvMu
 UELq7qdLQtkUyA6P+mIHoYA3o0FqbDziWrjnR+hFBHXO94YtRVZsNy4I3nvgMpUdya7G fQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2phnnqbeu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Dec 2018 01:44:36 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 23 Dec
 2018 01:44:34 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 23 Dec 2018 01:44:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/JsJ7L4Px09ox9r/IaoHF5TEOiT6xdkEnOwOum3F70=;
 b=m6zXRlyEy0jndKA72Aq6hwqUEvnqs5mgdVH02cjIU285y9B+gToYeEySoYZj8tjsYlTj03PrBhXuRQMD2HHhwJls1Xtuo4uP6YywyzT7cwLcq37RGo+nz1w+64yI+DIWDgN4U7ssPtfO9kMb1hL4zx72w3KzNuewedAGo8RxDgs=
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2904.namprd18.prod.outlook.com (20.179.58.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Sun, 23 Dec 2018 09:44:32 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65%3]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:44:32 +0000
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
Subject: [PATCH 0/4] rework bitmap_parselist
Thread-Topic: [PATCH 0/4] rework bitmap_parselist
Thread-Index: AQHUmqQb91KsTBRMrkWohnj9NNkPiw==
Date:   Sun, 23 Dec 2018 09:44:32 +0000
Message-ID: <20181223094422.4849-1-ynorov@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::24) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR18MB2904;20:AHqv1blLDJtCjzXouZ56vuLO1juogkv9gx519ro6WorKm+oyYlEb9ct6uZdf5Z1eHM6zgCXU05vIecn7jRK4pGVtmaj6KKX7/77Dlt/qhdYGkvBdxFbNRoqW1mtxU12WZLoPMoQ+OP7yQY1RGFaVCfVPVgQUXi/o1lU9z2opasA=
x-ms-office365-filtering-correlation-id: 49b464c5-e616-451b-05a3-08d668bb3d70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2904;
x-ms-traffictypediagnostic: BYAPR18MB2904:
x-microsoft-antispam-prvs: <BYAPR18MB29043A82AAA0D74E1012F9BDCBBA0@BYAPR18MB2904.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR18MB2904;BCL:0;PCL:0;RULEID:;SRVR:BYAPR18MB2904;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39850400004)(376002)(136003)(396003)(199004)(189003)(71200400001)(53936002)(99286004)(71190400001)(5660300001)(86362001)(478600001)(97736004)(476003)(2616005)(1076003)(316002)(68736007)(2906002)(36756003)(256004)(14454004)(66066001)(110136005)(305945005)(966005)(102836004)(8936002)(7736002)(386003)(6506007)(6486002)(186003)(105586002)(26005)(25786009)(6512007)(54906003)(6306002)(8676002)(52116002)(106356001)(3846002)(6116002)(81166006)(81156014)(486006)(6436002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2904;H:BYAPR18MB2888.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JDd1PyXAPaux9oCkBOLj49zGgWpf+DdX3TMJfT6lZxSoTQ02S71N2PbO8GInEGuw2wg3rugG+06QF4TSyoJB4ug2FOEdONXUwUwpKDNwe7CY1B720IQSUVmDncXULwz/gYR3IIVhRMzBDcwgUPqYMLFQzel4ThgA4Di/VcOAdn6Snip/X1yz7364Ts1uH52rW4O3aiVpjK2DWDNOrgNTYXhxkffwWVc2GaNoPTSr11L6YtyHNT+sQmIq8k4sfeRP0qQoO8e57wQ4HrQ8RDYyzIbHsIi+J2LLfWXNLkWgYpuX8J6psWUNWDVa26MRr7ts
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b464c5-e616-451b-05a3-08d668bb3d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:44:32.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2904
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-23_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812230086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parselist evolved from a pretty simple idea for long and now lacks
for refactoring. It is not structured, has nested loops and a set of
opaque-named variables. All this leads to extremely hard understanding
of the code. Once during the optimization of it I missed a scenario which
leads to kernel hangup. Tetsuo Handa spotted this and found it simpler to
rewrite the code instead fixing it. (Though, that attempt had some flaws.)
https://lkml.org/lkml/2018/4/1/93

Things are more complicated than they may be because bitmap_parselist()
is part of user interface, and its behavior should not change.

In this patchset __bitmap_parselist() is split to a set of smaller
functions doing only one thing.

Yury Norov (4):
  bitmap_parselist: don't calculate length of the input string
  bitmap_parselist: move part of logic to helpers
  bitmap_parselist: rework input string parser
  test_bitmap: add testcases for bitmap_parselist

 lib/bitmap.c      | 294 ++++++++++++++++++++++++++++++----------------
 lib/test_bitmap.c |  18 ++-
 2 files changed, 208 insertions(+), 104 deletions(-)

--=20
2.17.1

