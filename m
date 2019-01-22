Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0972AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE9B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ofPlPt6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfAVLK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:10:26 -0500
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:53283
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbfAVLKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLa2kohU4EE8fPT6SFjCajbOCqCjYkjYInARzBInR0g=;
 b=ofPlPt6rWWxNfjD2X1s/PzXNY/OXYEEbgJRzi+mqb94qOxykWi1+2WYdfGTQVK+uBVxFVIWzrfT89zGQY9R66aq5lEz6yzDOgtpApZfPuWgRKvF95VXoKSQLIXanASpzvF+XIq5hSeJYL0USHveikxeW9EYrjW4xkpWg5fALUXA=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB2088.eurprd08.prod.outlook.com (10.168.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 11:10:21 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:10:20 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 00/11] Implement komeda DRM-Crtc
Thread-Topic: [PATCH v2 00/11] Implement komeda DRM-Crtc
Thread-Index: AQHUskMQVCjOT9C4pk2JE61YZZDiyw==
Date:   Tue, 22 Jan 2019 11:10:20 +0000
Message-ID: <20190122110932.5138-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0034.ausprd01.prod.outlook.com (2603:10c6:1:1::22)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB2088;6:SnfFG9P3Hv0gOAcDFG5PLoRZBr6Ghnxh+AiW1KuS/JzPSArZmTU+P2V7yHlWq7wWyQUgLkkTyr+AoK4jM3IbZImBLQEORWPTw0jqhdh5eCwdMity1BMCAqOEHa2KAzZJiQb2jWMDH5sbuvayR2iCeuRxccT8S/SvzgaVhw/KoQW+N3QGGGflkwu7TGOaTU0nYFNEdDrY42BeRHAs199sZg8jsZxOZh/tm8P+51OlBDvffSleFgsoxv8n6bAcTxk8feuQSMgm3oaIqs96GphdWdRuJpVV+2Do2ms7OP7BtTaFzGlie+zAzqnaCw6Ijg70DiD15vFN/UDS5COlJVqtbr3MD1Ae74WMPmGa31trBTxTtP0yV61rB+ZQ8MtQ+4O91/GVDyzhWgJW1eXZ2pEUIz7FcZHoOTZGoQrZf6thn2Kvq4UOsyNxF08gqrOXNOawaCnHzIjMSN7w961UNx5KxA==;5:1T7LhrKhk5CpEnPNoBa67dxblRQ5ytDH7S/bSUp42Zkamnw5Y24svP79EUoweTUvvOm+OJv036nJEwpS5rxvqHeOXfYbW32KA+omahgUgWdniEces+rRgIosP9/SI0ASQ6ZQdem2tOlm5UkUITA5oUz6yAw24Ko4MBy9UUy1OvwuDX9fNqB8D9JtWE0rRcd/YOCnbRQB9C64VHgywBg3Ig==;7:4EK5I+B+3LuSYolGKUnEu0GpeqSUT9bzLVt8iwzK5ixHwdHql0uM7WTkniAsKztBoFXZVTu4eWNsoF8CvQ21l6rRHwqowMpliWfugMIQO1vR90SQT0x5SsoFnG9qaddglvhen6P8DtZwpP23iRo4pw==
x-ms-office365-filtering-correlation-id: 4c0a9687-2c23-4bf7-581f-08d6805a31f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2088;
x-ms-traffictypediagnostic: DB6PR0801MB2088:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB2088B03171E637EA15352D6DB3980@DB6PR0801MB2088.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(7736002)(2501003)(52116002)(256004)(478600001)(55236004)(102836004)(6506007)(14454004)(4326008)(386003)(53936002)(186003)(8676002)(6636002)(103116003)(6512007)(26005)(6486002)(50226002)(6436002)(8936002)(6116002)(3846002)(81166006)(81156014)(316002)(106356001)(99286004)(71200400001)(97736004)(110136005)(54906003)(1076003)(2906002)(105586002)(25786009)(36756003)(71190400001)(476003)(68736007)(2616005)(86362001)(486006)(66066001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2088;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wJQZV8tp2uNelKXGOGwUYT6SrFldj97h95pbRIVA0e/PKpBWEjK4TypvbTwv0VdSYD0XjoaHfqYyFzqWm16Bg9jLeIsxJUBixpl2QnD8ptz8wHr3nvAmAupMd7XgVU+2AwUD3j3s0jJszdBVDHjbmC9x6m799xV4ZnWOc6cIoEry6mBgqsvAoDmBQoI3QrzdUbTHPcCJoQQKJXDXdRb4v+xFIM6LWEk7Dq5tCwE8EsTNxqwAoDm8ownRFzjMRX4QHB2PXN0K3bUoJ+c4c1rvNIfB+k8FA3/K7z36KjaaO09Vp/cIs2OqaIOG0RI/aKkeHUsSiYcnIq8ISlXUviftq4jT8DBR8KsuB+s8k/2EeG8DvOWDc5AKgGOrOND2/tH3KsXeeUQw3MppOMQvMiECYMUmHNKdm8tzzJaB5lRBqhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0a9687-2c23-4bf7-581f-08d6805a31f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:10:11.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th patchset for komeda-driver, with this patchset the driver
can bring up and enable the D71 support with basic features.

This patchset implemented komeda_crtc/crtc_helper functions for
DRM-crtc.

v2: Rebase

james qian wang (Arm Technology China) (11):
  drm/komeda: Add komeda_build_display_data_flow
  drm/komeda: Add komeda_release_unclaimed_resources
  drm/komeda: Add komeda_crtc_atomic_flush
  drm/komeda: Add komeda_crtc_mode_valid/fixup
  drm/komeda: Add komeda_crtc_prepare/unprepare
  drm/komeda: Add komeda_crtc_atomic_enable/disable
  drm/komeda: Add komeda_crtc_vblank_enable/disable
  drm/komeda: Add komeda_crtc_funcs
  drm/komeda: Add komeda_kms_check
  drm/komeda: Add sysfs attribute: core_id and config_id
  drm/komeda: Expose bus_width to Komeda-CORE

 .../drm/arm/display/include/malidp_product.h  |  12 +
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  54 +++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 385 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  50 +++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  34 ++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |   7 +
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  36 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   3 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  14 +
 .../display/komeda/komeda_pipeline_state.c    | 203 ++++++++-
 10 files changed, 790 insertions(+), 8 deletions(-)

--=20
2.17.1

