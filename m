Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C993C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9EA20672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9EA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeLEK72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:59:28 -0500
Received: from mail-eopbgr700061.outbound.protection.outlook.com ([40.107.70.61]:27520
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEK71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTl6tgxzekX80gKuwt9I71Div5SitUavBJVYdo5pdgg=;
 b=cnXACp1SnJ8zcpOiiRODAxs6DTbd7FxQom6vqgKuE4+cW3btJLaoP76LqThC74jpqXHkOhp3PXIRZYU6QK8e12gYPgZV1rGSj6QKCmK1YvE6kB0lODuCuTCU3oXH8EfBG0hGH6Y3nn5ZjroGHT5HA6sN5D/SrPCilLZntgT7yw4=
Received: from BYAPR07MB5304.namprd07.prod.outlook.com (20.177.124.221) by
 BYAPR07MB4821.namprd07.prod.outlook.com (20.176.250.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 10:59:24 +0000
Received: from BYAPR07MB5304.namprd07.prod.outlook.com
 ([fe80::91b2:46af:5f4c:5bf]) by BYAPR07MB5304.namprd07.prod.outlook.com
 ([fe80::91b2:46af:5f4c:5bf%3]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 10:59:24 +0000
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
Subject: [PATCH v9 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Thread-Topic: [PATCH v9 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
Thread-Index: AQHUjImVYkVomjYCKUWurvCjgkqqHg==
Date:   Wed, 5 Dec 2018 10:59:24 +0000
Message-ID: <20181205105853.15154-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::19) To BYAPR07MB5304.namprd07.prod.outlook.com
 (2603:10b6:a03:65::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4821;6:p4I0bYlgGUxMBD33z0SZaMT8Y+OcbuF17ckZz2uXZI+E1Sf3GDN+w+pl7gvp8iqQXYkX78ZfY/xNiMRCOiBXpFsxWKOfw9RJbC62ORvLsA/hxd/2/kqbS+qFLzqqBXUP7YwaVvP6jNalXm1N9MFR7oAagBFy3SG0q7kr1Su0izJM1dwVnqawZL+0CqMYBEXycBw1feoX2JOiDyIQk2x9KsJj5O41XUF8wH0Tos+8NWrYEZWTIM6bv7Hbe8jJ7J2p6mAYtpkkMxZAt5FaoutAr0z4K/kzgIgWIqztUU9OaHPuBDv91ougzauTWuVpNQAXDnXSb16jLuFFzNytlH86FmmMzxVyZM432WMoE2RHvvn2wLKQt+lVgAK5DKcjvffQUN/tiYujFYp147yDS/N6bJdA2T2VX01ODtQ9zK8JhvNaCN++bvHpdN4TYSis9EnFmi2FPmNVYW+naGk0Y/K3Bw==;5:WBtGphd1ydA6V+6+5frzPI7GA2QcfNBXH3ilfjKEjS2vr0E6J+fwgDfV3AxxpAmxPUJT3tARwgduJ0Oj5V/IN5l+fgqK5C/pvw8vwtwqCT6HSjhpFOFm04rbQA511S5oeyF2M78bmZIyVyQw6N3QiADUHJf2HG/Caz6pdQg24+o=;7:PdEYEoqlw+38pGVrvpa/TaPRVSQotbNkKS8RY6hbBPddf+0llbRp6RdZCQm6baEDTRDMUL1aV0XNfJWBMpsmLXL5EHrBnpy4LQ8TKxzE6kJd2zvIGy0sJoXjdjFjg6IpLKP6yMHJ2yx4Xp9ZMTa0ug==
x-ms-office365-filtering-correlation-id: e7faf66e-c72d-4b62-c481-08d65aa0b775
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4821;
x-ms-traffictypediagnostic: BYAPR07MB4821:
x-microsoft-antispam-prvs: <BYAPR07MB4821962CB0C61794D66308C283A80@BYAPR07MB4821.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4821;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4821;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(14454004)(8676002)(99286004)(486006)(3846002)(6116002)(966005)(2501003)(6436002)(72206003)(8936002)(81166006)(81156014)(476003)(78486014)(52116002)(2906002)(14444005)(256004)(71190400001)(6506007)(186003)(386003)(102836004)(26005)(71200400001)(54906003)(110136005)(316002)(1076002)(2616005)(66066001)(4326008)(305945005)(7736002)(25786009)(6306002)(68736007)(6512007)(478600001)(53936002)(36756003)(6486002)(105586002)(106356001)(97736004)(86362001)(39060400002)(2201001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4821;H:BYAPR07MB5304.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aYv8skCkGeZed8F8hCActxz9/n3Bu940onEcrFjOv2Om9ZW5kL3+NWzVQ4jIVrA0lAgufG1dJE1SKGctMbfFYgW54tA8qUXat9h2IWvSPtprhpiJ06LfuwjhIwILEgO1k89csmJxvizmXzF1BHOIdc4Ex+XYoYnNXGjTi3ZRynvP0F7EEYxYMsOx45b5PVh7xynuYRX3pd5TIVjUKK5D9IQtpOuo1UJlBqrWV2f0kj+C311MHn+LYni4EPt1ipmgR7vezghV8NnHuBAcnjNeqCVd4u1bYniL7xNyf8Lejf+ZSsu9sxBspuBxnmaQCv/bVHdgCVNg6c0v/xUsGVIJ2BdKVEP0Xcwwb2RTNGMftBk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7faf66e-c72d-4b62-c481-08d65aa0b775
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:59:24.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@marvell.com>

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

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

