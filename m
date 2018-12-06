Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8AEC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A96D214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="c1Ngltii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A96D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeLFGqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:46:21 -0500
Received: from mail-eopbgr780080.outbound.protection.outlook.com ([40.107.78.80]:13872
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbeLFGqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NIrZHLUoWkRWsVXDYAn+iuS+M24zN3QsAqGeIM7oto=;
 b=c1NgltiipbU7DNDiFaHqBUmQrDR3XoKNl2TGLcxcRyAl9Wyg6M7h+UIa7OaRECT4B8MP2YAweDgOrOQSgns4PwPAmwgdrqdJxcjpdDljvx5lBlM4ODutT4K4d+p8nrHVki1hZO6ULnMGbc9uqmvECpuJ7Ng6N3E1e3gdpBHhDLs=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB4387.namprd07.prod.outlook.com (52.135.247.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 06:46:18 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 06:46:18 +0000
From:   "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH v10 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Thread-Topic: [PATCH v10 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
Thread-Index: AQHUjS9j53Wh4rXCYkycm+tMeR4Iow==
Date:   Thu, 6 Dec 2018 06:46:18 +0000
Message-ID: <20181206064545.536-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::33)
 To BN7PR07MB5298.namprd07.prod.outlook.com (2603:10b6:408:2d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4387;6:U82FLIFpyzTWeTAs54XIMoaHy1oPHEIYErEc/RwzFFRWWpwjME118eO3yQ/PH4+kqp2KPYmJv/DglSflmz+hbWxJdzvn1f8aOqCr0wokYZCZoF9gUTX++JkeqfstLf7nFMYCgKBhwnv3k5F+dxhfWt/kJNQn/dG2Yc+8s3r59wLDHS89yed36jh7qdoUXA6DGC51pJNLUEAcOyVh152Ljn0YpLrS+lXoIoCykiFlO+Pv7ji6uGx/6VuWdG9tUVE6p34no7RIuFYIiWYpHYzfYZ/9+xEwi9q5WAt9jltP9U7I8DRZClWoAw14p49puTJ8/Cd/af72ohy5/w6AgEzwHyLO/buz5mq/RUBUkFemcqHjghD90hOUFTdIraZBuxxK5i0hPvihI9d5kBHT2dhk8bRot6MDj86xSogWTF4z8DkKUUqbJTa2ZjdRoJ7D5Pfq9tbZAfB6KYlS8LpYT4LN4Q==;5:H+vo7aqEUydVDN+qYTnsp4OkrEa1yycZoUFgms46wizA/BrGGN1xRKE1ayyVz5KuqzyGsnT9S7GGXUTwSkstLumYtWzWIlz2LxKpOiH34Ah7ovVvOYmJZ3mTk05Dclcd1vK+s6dXvfKt1TtmZRH5MdQRyvH+snNmXpIPuRYfAP4=;7:6PzVv7VFoOxeWnxJy7jnj74vgtj+SQ5oTioj4QjIo1pn+SWymYejvdY/p/MSieiPITOqZuUWyhN0JGaMZP404qJVzCxX0Of93INe1PY/AwLJveWQkhhOI4RZhJBAUGGgnv+82FCBcq3DILZvnvUaXQ==
x-ms-office365-filtering-correlation-id: 6d54d765-c725-41a6-43bc-08d65b468648
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4387;
x-ms-traffictypediagnostic: BN7PR07MB4387:
x-microsoft-antispam-prvs: <BN7PR07MB438746A4DAE5C7173131887F83A90@BN7PR07MB4387.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB4387;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4387;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(4326008)(25786009)(256004)(39060400002)(14444005)(478600001)(966005)(72206003)(54906003)(6486002)(1076002)(110136005)(97736004)(14454004)(36756003)(66066001)(486006)(476003)(86362001)(2616005)(3846002)(2201001)(6436002)(6116002)(316002)(68736007)(99286004)(2501003)(81166006)(81156014)(8676002)(6506007)(386003)(102836004)(26005)(186003)(5660300001)(52116002)(105586002)(71200400001)(6306002)(71190400001)(8936002)(305945005)(106356001)(6512007)(53936002)(78486014)(2906002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4387;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4G0PISFtDvGtRpx46tdzA3I3WCfK/uIjC/MRg7djyc8Vo+9Ria4pdI76aujx8s5fw5dFwLfWa/+H7zYEW9MAzrAxmyu9QRCvhr0fbZiuNY7AjlSLObzXV+lMG0Lb4b3B/Xr80mbnCOwWIh4i0CRULVGnuNHux+OcQq4TRSjyz2mJ4ZZsxBcjGAr+3oNcBgqQw6wN5OsPrguvBiG1Rfpi8BJ5KtL1PXVOztpg+Jvh0bUvQRlpovejaiPRNRqrOmQznyRZ9W1LlTjT/REBOOBQtz6NQXYRzXHUqY51oziCaj6HRTyS3Et69bkaiB0jekAiOOFlgF89/L9FU65jCSGNayAdlmxq68pIfhfxsLf00RI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d54d765-c725-41a6-43bc-08d65b468648
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 06:46:18.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v10:
	Updated Documentation patch with comments [6].

[6] https://lkml.org/lkml/2018/12/5/649

v9:
	Updated with comments [5].

[5] https://lkml.org/lkml/2018/11/22/517

v8:
	Updated with comments [4].

[4] https://lkml.org/lkml/2018/10/25/215

v7:
	Incorporated review comments [3].
	Modified driver as loadable module.
	Updated Documentation with Event description.
	Removed per-channel(no SMC calls) sampling implementation(
	Since DMC and L3C channels are interleave, we have decided to
	sample channel zero and prorate it to account for a Device).

[3] https://patchwork.kernel.org/patch/10479203/

v6:
	Rebased to 4.18-rc1
	Updated with comments from John Garry[3]

[3] https://lkml.org/lkml/2018/5/17/408

v5:
	Incorporated review comments from Mark Rutland[2]
v4:
	Incorporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html
[2] https://lkml.org/lkml/2018/4/26/376

v3:
	Fixed warning reported by kbuild robot

v2:
	Rebased to 4.12-rc1
	Removed Arch VULCAN dependency.
	Update SMC call parameters as per latest firmware.

v1:
	Initial patch

Ganapatrao Kulkarni (2):
  perf, uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt |  93 +++
 drivers/perf/Kconfig                 |   9 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 861 +++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 5 files changed, 965 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

--=20
2.18.0

