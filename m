Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E88218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FkgNYYla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbeLXJPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:15:31 -0500
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:17184
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbeLXJPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7Ay5PtR4FEqPg6WIBPSDoHF4mOucC9dpS15AX1jgpo=;
 b=FkgNYYla5C2yHE+m1CgHQEYlGw49HZNy3Sd3f8mXVyRNLvQIzvIC405dSM7xE/BeMyMUV0SXi+i9nARowlGBJ5kQq8snWP9dVmJ12q2hkfJIH4mcZgbX8oGXZKu5tyC1tLRwPFTPhoENX+LLhFZvAb+ETKP8xRHAV2oSwDuoJw0=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0642.eurprd08.prod.outlook.com (10.163.188.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Mon, 24 Dec 2018 09:15:26 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:15:26 +0000
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
Subject: [PATCH 0/5] Implement komeda DRM-Plane
Thread-Topic: [PATCH 0/5] Implement komeda DRM-Plane
Thread-Index: AQHUm2k1MmNoXX7k+kuxoOsYqPacVw==
Date:   Mon, 24 Dec 2018 09:15:26 +0000
Message-ID: <20181224091450.2643-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:1:15::27) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0642;6:cKC1tLAJzmnxwVs8ammQqbzkQ6RMc1w9+xJYfngfQkBKiBGFkZnUePaJ8XBrV5Ftghu207rTiMPhX3seyfMnwqAbl8hXCbqhRi1sYX36bEAdyCL3c8c8cohMYo8eelJR1654QCnfVpwLLeplFbzTXzhGq7dBqDs5VRd1PcFseqqF1eLy8StMG5JdunDaV3OIq6Lc1UHzeiCAe31wSWdJL3NIfudWOtItX2/y2cX7JdEnceC7Cfod3vB0wq4RwMq51k6mE692tInvG3SNE8LOe8dmJ6qVhU9RMjLq4UUwjpEvnc+LF8MkGTtERTjeS8NlY5TjUJYQHuH1/R5TIPmdbDEMeDNVQGbASnU6z7Wu5PUamfQPLnC0Shc0FMUDLhwkz9OjGUlF2XrfjR1l1i4hArcfkTzMDxukxy1yBOg4rzkhzIR5Nl6IwomhSPOiyZsTLMiX3PS2xw7S2PfuWylAEg==;5:BlFvJKnEr31cg6SSQhH+mWqmIFn0BiR2foxTk5pVLMvuVpzNYNPo6YyYsB/KEi7W2VyNn8cvOV4m4n7k4rNNlRgzWCTIpcZHEwHRKUiNeOqHSwq3ojX4Lzk6evMlbK1FHbNkVX+6wUrnliPU8BZrb2hqhW9JwN1wy51gdbrjur8=;7:sErohpwQV+geqUUfyLwr3mXJzN62J1Z6ca/hJvvsnfTz1IttR44EvKFvuf/4KBfblgVn4t93PzvBXvRtFpMkqz1kxBQ4mA3qs+qgUkHB3Nbv9Oj2enlE51Yueq5MtyRD0TmGj3uMtKQ5AUV6VyC7DQ==
x-ms-office365-filtering-correlation-id: 81573811-4c8a-42af-4c59-08d669805743
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0642;
x-ms-traffictypediagnostic: AM3PR08MB0642:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB06421996A3D417DDE09D95F5B3BB0@AM3PR08MB0642.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0642;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0642;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(346002)(39850400004)(199004)(189003)(486006)(6486002)(103116003)(305945005)(316002)(5660300001)(6862004)(6436002)(476003)(54906003)(37006003)(2616005)(8676002)(2906002)(81166006)(8936002)(81156014)(3846002)(6116002)(68736007)(7736002)(4326008)(25786009)(6512007)(53936002)(99286004)(14454004)(478600001)(6636002)(106356001)(105586002)(102836004)(36756003)(186003)(26005)(97736004)(256004)(55236004)(6506007)(386003)(66066001)(86362001)(71190400001)(71200400001)(1076003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0642;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AtjlyS/Iq+4W0V5ighCeqeqiIzZqNlh5smEoy8mE8qWLD2sxOFKFyfBSBe0YFJsLbGLStlXm6Hzt/lozi+f0NqKIgrp0CM2zkQHaqxZG364zeQmzbvJ/i98kke8NTt/Juw8rgUvYbKVlWfxfnviScum12b/ubG7PB2MrJ2wiy3IF8vXYgSj0eO6Jg9RqeaEfqJRCHhid8LMvbBfLkoZAukbXxhP3rdgT7N9B/egw44v+zsuaSlEZQ0YgcfFqzcdiYmtjXwE9ceuz5Ku4qBWoEdVFul+Yvd3RU2W53bSWJSDyEduay4Owqn3RvkADQ8qK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81573811-4c8a-42af-4c59-08d669805743
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:15:26.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd patchset for the komeda driver.

This patchset implemented plane/plane_helper functions for DRM-Plane.
per the komeda driver design, A DRM-plane maps to komeda layer input
pipeline, so the plane->atomic_check will build a layer input pipeline
according to the plane_state. and with this build function the plane_state
will be covert to komeda private component states to represent the real
HW configuration.

Beside that also added some basic functions for operating the komeda
private object.

James (Qian) Wang (5):
  drm: Add drm_atomic_get_old/new_private_obj_state
  drm/komeda: Add komeda_pipeline/component_get_state_and_set_user
  drm/arm/komeda: Initialize komeda component as drm private object
  drm/komeda: Add komeda_build_layer_data_flow
  drm/komeda: Add komeda_plane/plane_helper_funcs

 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |   2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  31 ++
 .../display/komeda/komeda_pipeline_state.c    | 408 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 129 ++++++
 .../arm/display/komeda/komeda_private_obj.c   | 200 ++++++++-
 drivers/gpu/drm/drm_atomic.c                  |  45 +-
 include/drm/drm_atomic.h                      |   6 +
 8 files changed, 819 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_stat=
e.c

--=20
2.17.1

