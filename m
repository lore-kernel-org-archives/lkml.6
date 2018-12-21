Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D8B2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="lu9Ok7O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbeLUEgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:36:42 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:46602 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727976AbeLUEgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 23:36:42 -0500
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBL4aBVT030638;
        Thu, 20 Dec 2018 22:36:11 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by mx0b-00010702.pphosted.com with ESMTP id 2pg2dwkk45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Dec 2018 22:36:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuIYshxeuKbtx/IXZ7irBT0iejZ8K4Ve0hutrrDOXEU=;
 b=lu9Ok7O+lNyWfozlPkHM67ZApPJiHYToia9lZQE4xnKxDU8WEyRM5MLMvx5DRNbqJZrxyGVYK0ivLTPa62Hu03Nrc9Vv4U8VsN6gIbHCbCH+G/sKtSdzaeYtwbEc5czkQQFkgxUa7MKK4Gu+xGDlKkWklH4IZTmuvu5h30VRp/Y=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB0996.namprd04.prod.outlook.com (10.174.234.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 21 Dec 2018 04:36:08 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::4410:86de:3066:e9f6]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::4410:86de:3066:e9f6%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 04:36:08 +0000
From:   Julia Cartwright <julia@ni.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.9.146-rt125
Thread-Topic: [ANNOUNCE] 4.9.146-rt125
Thread-Index: AQHUmOaxVDtSFsIKIU+YfPnj03cuAQ==
Date:   Fri, 21 Dec 2018 04:36:08 +0000
Message-ID: <20181221043607.GC15714@jcartwri.amer.corp.natinst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0002.namprd04.prod.outlook.com
 (2603:10b6:803:21::12) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.116]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR04MB0996;6:CMgFh9GnzT4tp4DA2lqnFB/ouF3DE1jYAFVNcniIpUqm/nKkgMjjPUhTDCSHfSOmNiVrqfPnXH9pyrrcwu+PoLsfS81HYRuvtFfif8P8GrE8dz4R9QYa8xUSEeauyYwo5/gLlE68bh31fqxtPvu7W8JURs/e0xFMkgxxvp89Q7SFmiCOUSuxHE1nSsPH9+rGd/bMI1kiuj/17689pZPCFB1akdB2Em//3TNjniZAXr38BzX4J3HpIKqjO+2sEWzZ6D9ZsLyJGtyDO5lIp+ncBuJms/KlXt9tf1ttVU9RUghhp5fu4mpZ9+WxijifOqjGcUusNlGpk4Lw5dgB+pVVAcVD2M6uZ2tqvLzz+z/KGC7aBctc3oXCXteyncoLpikxJ/XyozG4ZE2fKgR1+pqyML+lMvE94Z7HLeC2V9wOpVgYPPpdd07Dr9GdiQ/5GAEBxmBpRtLZk0HFmJIbSvw7EA==;5:ainXNRMGPtqnWLXIcYIrfHXDCkIc/PB+sU9nr0sWpeYAHLoRxH06qSzGGxCW1gL8+kQ1kcBYebFc28YnWRTohInYdS1Ildd0+pIdD9gziPUvlM06wWucrqgnojc7895LXSORAIdsz0111ShCe3iqtAFJFlhsVqAu/LPSaJW/UbU=;7:GBYfLA6HLIUpwxTDNGWGvzQZ6AYfE/hbICFi6/xL5e9SgCNXeXcGk55+BDXHnXys+11SZJAE6NiCiubWIz8Q6lbyLJ8u5KGq+UcvhSjUodkH0UclaPKycu5PPqTuQhezSeG4+xTWfQ2CI5qgAcB9iw==
x-ms-office365-filtering-correlation-id: 481e87fa-9145-45e5-c869-08d666fdd3ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0996;
x-ms-traffictypediagnostic: BN6PR04MB0996:
x-microsoft-antispam-prvs: <BN6PR04MB099681B48F48C7CAB3B7D8C4F4B80@BN6PR04MB0996.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR04MB0996;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0996;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(7736002)(5660300001)(305945005)(71190400001)(71200400001)(6486002)(6436002)(97736004)(66066001)(6116002)(3846002)(2906002)(2501003)(1076003)(486006)(33656002)(106356001)(68736007)(81156014)(81166006)(8936002)(8676002)(33896004)(478600001)(6506007)(386003)(316002)(476003)(25786009)(256004)(14444005)(26005)(966005)(186003)(105586002)(6306002)(9686003)(6512007)(102836004)(52116002)(99286004)(53936002)(110136005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0996;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bLOaagmC0+q7VqNKwxaNhpMnifaJOf8xaf6cWMn62cvuf6JKyfTNv0zakxzPp7FGjoLrsVHtXQ96hjIXS+3N/CeIM1ezf3MIH1HSQedRkCU+N6NjhOh0FxvXpc1gMpvnk0sQB1P6KjE3AfE3jE0caXPDp656XZzmODS4Zz173a7PkHRD4TPtb55RX1CGVzGqRXtBUOhK0Y6ygXE8+lKZv9rQOueCfb8jz7C8efJBJAXtjNBkOq8anhPiFVJmGAN6maE+omlk8Y8xxi4Y+Nf1t8eBJA5/rT9GaGNXyoajNh9yhnvF7Y6ZfYwboQh1hh4O
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8705DE394E612B46B86AB7A366E0EE0B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e87fa-9145-45e5-c869-08d666fdd3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 04:36:08.5519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0996
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-21_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=675 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.9.146-rt125 stable release.

Apologies for an update to the 4.9-rt tree being way overdue.

This release is just an update to the new stable 4.9.146 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 5b5e350d8c82f5dcbad136aeede6b73d41cd1e8a

Or to build 4.9.146-rt125 directly, the following patches should be applied=
:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.146.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.146-rt12=
5.patch.xz

Enjoy, and happy holidays,
    Julia

