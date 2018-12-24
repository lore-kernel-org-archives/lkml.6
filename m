Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA6CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA632171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SP3vIij/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLXI6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:58:43 -0500
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:60431
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeLXI6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIUpxU2HBaQXpeXOFZxts6MzXV/FmFMpU0ML3Drlsk=;
 b=SP3vIij/xNPMCI9s6kCB0gMYn4cIu8NuEsAukZr2Gy6YwZkMxfgGrtynmaogdZuvfmxKcwezSQl/4HjH+tR2N2NBMTauNh/Q+VKulp7IKaKyXxR71EDN7SJSVi1d6Aax2kJ4jzmHcF/4eb3klqepGINH27DlxgjhXHinH66x8vE=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0609.eurprd08.prod.outlook.com (10.163.188.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 08:58:37 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:58:37 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 0/7] D71 pipeline/component descovery and initialization
Thread-Topic: [PATCH 0/7] D71 pipeline/component descovery and initialization
Thread-Index: AQHUm2bbaeQu1HmWPUyJpWOT9JETXg==
Date:   Mon, 24 Dec 2018 08:58:36 +0000
Message-ID: <20181224085716.2325-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:4::24) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0609;6:oPFxY9q7Sv/ylgrRFbAqHdDOd2RkV5wMx91odk+hXt6Ti+17hf5+avAupo5kxHqMVx1FtP109U1k26kV5H1Bl2Xe4UB0WAAGt8e65R5uKVGK3+TINXLvfCtuYC9jxIZxfxJEuZXOi3wSDC952veoMeag5VSbj3w3RTzbcx4n9jnXUKpXroEZaNBJuLH75HhcCLUnSqF0T/yFYishEarwdOTtjgk8hvuLpr9fHjKcMIY6j6GEI77WFYCbyq3hQAH+9A+nFket0K06vb3xyVk9VdB6dnd71IVbpMofMMGanQLPldKraeLEOIOox+fIT3+oZD6DsEWjpDR+2PI9473ajUc66XCUmT+QsHjisVC9Z8PQelElGuqmOPlMobVKfEyhIJgnsFhMXYcECxI1MazPopP/KUxXKXI/ENciOc2pRPq8eGABPRgonfJqFUyjXnYYMHpFiFFUWuXBvvsUyauisw==;5:zIFxocLl2CtuoxeHnrK7Su1l1i6UFusklal/C+eush3RCmUpQILCtwOC9LxF08GYJVSwFa1uFgGMeeRyVLLt/rzreIUUEPQSA/pxN9s5LuFDHsrY9Ea+uETaFgXWN9nQuQWu92+D1ZiJulHeIIrj8zLLtVzedflQ80j0mNjmFC4=;7:9ioNu7FoMIvK7XpVB3Euf4Ch4O6WEvRNANgH5M7J8uiWSW1ZCLHSXbzgphh2Dl6OJki0YwPHkVlhLLIMgp4iFRzVuRfow9j6SASBExj5UYBXSGGOE2LrTu9b+mOtjePIiyOVdTzby1RtEMkxLKHzzg==
x-ms-office365-filtering-correlation-id: 64f4a90a-ee90-4f3c-18d9-08d6697dfd9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0609;
x-ms-traffictypediagnostic: AM3PR08MB0609:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0609F3B40810DCF9F61C0FC1B3BB0@AM3PR08MB0609.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0609;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0609;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(66066001)(386003)(102836004)(305945005)(53936002)(3846002)(6116002)(6506007)(1076003)(5660300001)(478600001)(7736002)(186003)(97736004)(103116003)(6512007)(68736007)(14454004)(71190400001)(55236004)(71200400001)(6636002)(99286004)(476003)(2616005)(36756003)(486006)(4326008)(2906002)(6862004)(316002)(256004)(8936002)(25786009)(54906003)(37006003)(26005)(52116002)(8676002)(81166006)(106356001)(86362001)(105586002)(6436002)(6486002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0609;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bLtBtcAsW2OEeu/aIc2TkVTl6uJac/L40tavdod+z1PfM7BA52h/zYCZWEuKSVsKeNMRaOPTDNmwO1PvoCcmWYoGvMX9KP6uNRWfTNiUev3KgLpR7UJCXpb2cN2E1lfoiyEuvSXlYH1TCD2ZnHgdOzqDt0aw5g/esrPpl9n4ydN5aiXRduxXmLTsu85wbsmNsGLyr6Xj8eU2XgX62c10lhC5hnvcZr0YYudu6n/3rlPo46zBpa98Df/t0P2Wi/HatboI03Z71t7h1YrjMZ1XvebZdS5GA1dVWKiSUnkfnUr2MwOKgg3EyPPWhHoQqhgg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f4a90a-ee90-4f3c-18d9-08d6697dfd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:58:37.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd patchset for komeda-driver.

These patches focus on CHIP(D71) Layer for pipeline/component descovery and
initialization. All basic and essential display component: layer, compiz,
improc, timing-ctrlr and irq handling have been added, other component
support: scaler, wb_layer, merger, splitter will be added in the future.

James (Qian) Wang (7):
  drm/komeda: Add d71_enum_resources and d71_cleanup
  drm/komeda: Add d71 layer
  arm/komeda: Add d71 compiz component
  drm/komeda: Add D71 improc and timing_ctrlr
  drm/komeda: Add komeda_assemble_pipelines
  drm/komeda: Add irq handling
  drm/komeda: Add debugfs node "register" for register dump

 .../drm/arm/display/include/malidp_utils.h    |  29 +
 drivers/gpu/drm/arm/display/komeda/Makefile   |   3 +-
 .../arm/display/komeda/d71/d71_component.c    | 682 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 367 +++++++++-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  50 ++
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 530 ++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  18 +
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  58 ++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  48 ++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  35 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   5 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  97 ++-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  48 +-
 13 files changed, 1949 insertions(+), 21 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h

--=20
2.17.1

