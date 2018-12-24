Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3823C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571182173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Nvq6A4um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbeLXJZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:25:19 -0500
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:61852
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbeLXJZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18RLZLONojZvXtqefoqcSCvkUOe2wOJHSvm8w4FwF4E=;
 b=Nvq6A4umBs4DJNhGtn7yTaxWHbwbWsPzYYR07NzHfm4tSvKCBKjk/xl2C+4KNGvYA6JPoHKjVLp9L2/cTGLtiWLIHHUCfOIWw5THAB4auEWLWauO3iO/JI9YrifmfO0xeqv/96fM1oc7d66kD9qvS1uhWRnZ2gJ5YG5yPmxsOvI=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:25:14 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:25:14 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 00/11] Implement komeda DRM-Crtc
Thread-Topic: [PATCH 00/11] Implement komeda DRM-Crtc
Thread-Index: AQHUm2qTHxMK5J7n40aEj99DSbX1mg==
Date:   Mon, 24 Dec 2018 09:25:14 +0000
Message-ID: <20181224092435.2792-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYXPR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::32) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:pSZI5l8F1eFsMiZWv7p1/+3YowG+SXDgOQsJEgZl7QHaV03IafWFMfTCypswEw++irHdwXeeojSjK6J7VRM4lXKR4bL+RPT5xp76WPKsc8x9RvF2fjSH3Htqm6WJWMpnlFELVhSd5tYzdTUV3iBQOu+OVnsuuifnxMTHF8mzcH8F468t5Z6ESu0aCqIu6yaLNgTtHiVNRn5XIvtPDJm2qUVQdXLvQRO+1wP03ihyYIUU4UFzCseTflGiyOeP3jPjjQZVnuaZeOTXE2Z3/FjgZSkoGJ6ZmqE1o+ta+e2AVy3vJHCNF2U3jiHkgyNBYNoW827uLqmLsP1HrDmdACI45d8nnRlFDPih7Ve33zkNsGmgWbAo3jk00HxfOVYzClUAmtat2Qe9FMrDFjUzuXD1cHgItygWSUYWObUyljL+xB/zLpCuIwYOhycPeF4Arn5ZN0X69jFZvUCyXMSnIY606A==;5:dW57AnJ0Wq+aHOW8tmmrtaONFnsZjp4F3W4TLXtMlB1cJrA178TTa57KYTisrgPy/V8qO46YyqiW3wVDRm9AJKW6e7YMm9ajBQY1rtd1YQ6LhgFh3kTOKetZm/9zDZtYkLtpzgu7oqEIH72aaW3+NAd/ZLlZ8MAMHJl+LNpxFEU=;7:637o6VBt3LrMYuVS3jp02ILslzL8KaYLRQFyQyq1y/n64M0uI9S3X760nmzO/5HfjJ7sI+xi+kElqwa6ijV1hnN7CqVB55YC+FAsv1s3XnYII0dDkknchY1yprAks+EdM50AgdZR/xiedvSj0zWZ4Q==
x-ms-office365-filtering-correlation-id: 1d7d72d2-5841-45d9-bd0a-08d66981b5a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB02626F3CA5D365B89E345E1CB3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(2906002)(52116002)(6116002)(1076003)(6436002)(86362001)(6512007)(5660300001)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vih8laro5Xl+6yUUBGBlKuEijhbm9T/d6Gr6gDAP+EtmTmMyuXyLk6PC57ECRLkNfne86oGcmCf6hxQa/XXAJM4z5AuefjYoz5fU5wXw3wJXoAPUX8PrR4ItIXa3nFlr5TS+d+BMV3xnfoHLp79X4NxRQPkRScdM1+vzJP2tCrYxSgmvjhzJ3nui7lRGw4Y167Fv9kYNoMKKtub7uIe9PSyxN31GFRvnrenBgT5iiFDvoQxWq59fggSgVlFQDBAv4akF4J8URDYLy1kPU0P97pp9oR2LvCBelCzZCCdpa6sLK2ekziBV/XSiBS1OcCxW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7d72d2-5841-45d9-bd0a-08d66981b5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:25:14.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th patchset for komeda-driver, with this patchset the driver
can bring up and enable the D71 support with basic features.

This patchset implemented komeda_crtc/crtc_helper functions for
DRM-crtc.

James (Qian) Wang (11):
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
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  35 ++
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |   9 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  36 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   3 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  15 +
 .../display/komeda/komeda_pipeline_state.c    | 199 +++++++++
 10 files changed, 790 insertions(+), 8 deletions(-)

--=20
2.17.1

