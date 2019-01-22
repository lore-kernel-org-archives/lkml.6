Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FDB20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="J5lZqQD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfAVLFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:05:33 -0500
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:51264
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727898AbfAVLFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCpuUvgf42dV+/ijNwf0CvG+6l8keKTFzD71lRF7B58=;
 b=J5lZqQD6o9lNt8WCZDdZLlcdK2dH92WCCLIzOW6OrjilnPAypYtQSwZH1cbtxgoWBKeQ1hwkQGOnf6s3TvNOWEaW4qg37bmzP1zvFDW2dBCswOR01/8EXSgjmxuj10fncChVpovXORhe8ANM8ONYSx/bmgAeA52wVsBSoRqoBL0=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1671.eurprd08.prod.outlook.com (10.169.226.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:05:30 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:05:30 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
Subject: [PATCH v2 0/5] Implement komeda DRM-Plane
Thread-Topic: [PATCH v2 0/5] Implement komeda DRM-Plane
Thread-Index: AQHUskJiBTYdFTZK6Ey++zxhzhHqzQ==
Date:   Tue, 22 Jan 2019 11:05:28 +0000
Message-ID: <20190122110431.5025-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1671;6:fUuS8TPcorSWYXVQuZKdnLaOnI5wuWgYLBDetmsRXRHudF+nPrtWRM1EJ5o0ESkPzAq/qlwws6YDipZcpEonLfmNYW9+TDQYWT9LKpmNCPrerDuDP/11vtlkux6yPffotXf9j6x8fQmUCNIz06x2J9wBDqJQqQb+fiSrXa5DExYQ6nRkWfkg2YYFa9sTMPJ/cfXlgrSaIw9B14H4R6xNvmeLbLzoSUZLUmKwtIdP/OvaVm9Ognhxu2Wt1okCpDO95lG4S9MULPF7m0xBUKJtz7Cd3Um+WefsODQx7H8nAp9AFA6hHuXcwQng0zWLnKJbTPbIRk/IXxHZjj6MvL4mQfZu//g9drF0eumZCJloGxm/RJYq5VouNJ4zk2wJB9IiemCKjSsMyz7tdrf8OeCMe5O+KzRTbFyAOXCKenfeD81CwqihFtjWp1bEy57xFKaUJbj7OTZIM+kk+67+1uvjIw==;5:CGMLLe+yPp/e2KlbOV4ORc9E7htvkGn+c9g4wIsgo1z3lCIoPNdO1TH3eCOOk24vC29W0z8XEQ+W7seqqihEQYFfgKGx1+xxWkeaM5jL2bc6cYOZxz6NjZdDGu3B01oYjONlxy1bxUIYyqZsDURdo+50z1henW7HziR5q2bK6hRaqBNDk/WcOHbNO6lnS7roT8eg122pqh6zsqwgmyhWdQ==;7:hwMDUe8JxhNa0r6pap2OngvI+83OIjIe7bkAalMs5YFpGfXZh6PC42BMhA9V8zRR5TjoDT+58vq73sX0dJ9/Hexh2kN2Qpr5v38G+P6fnOWccyLsaIUCbhcSFTCWb6vzvPBNHFhpAgHwALDCaxXXRA==
x-ms-office365-filtering-correlation-id: f6b701a8-00a6-4b1e-7f19-08d68059841d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1671;
x-ms-traffictypediagnostic: DB6PR0801MB1671:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB167124A5FC6E38522F1A9A02B3980@DB6PR0801MB1671.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(2201001)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1671;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z56aHcqgevs6WOaZDd37T4Yq0IzzpfiGYFyQY2rdWjRoa2/oFXBtiGUjqAFtpvURvOVCERV5jhvhDJGGv5oYocZn7EvcjDnu8ml+HgIKW/pX/pOdQc6ZClHgl9nmqnKA+A6QWKRJrzjqrC04ULEfXzauX18RGaTp98mqVryBI0pf1VLAK6gZ/tvtPe3zDG50Sp1XxPGn94dmmh6wPA70rOyI9hsIucreX26gMyEUaDpdZF+ktIUIS99AUkV5L9BpnlmOPVBVQl0lXK/x4MmN63wa0gmpcYUJqGzbz8HRCItdcGfqpc3At+WpOCKZ2PGP7rN6c21HMNNMdh54/ZeCvwjs77flqdr8Fn8kiupMxa+Cp0eWRpTqMPCABFRqVqYZckYnAfdvI/gfLJjvT5Uu1txEnydKpLzi8CaGLqkooC8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b701a8-00a6-4b1e-7f19-08d68059841d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:05:18.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1671
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

v2:
- Rebase
- Introduce struct komeda_data_flow_cfg
- Update code after applied commit:
  b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")

james qian wang (Arm Technology China) (5):
  drm: Add drm_atomic_get_old/new_private_obj_state
  drm/komeda: Add komeda_pipeline/component_get_state_and_set_user
  drm/komeda: Initialize komeda component as drm private object
  drm/komeda: Add komeda_build_layer_data_flow
  drm/komeda: Add komeda_plane/plane_helper_funcs

 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |   3 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   2 +-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  24 ++
 .../display/komeda/komeda_pipeline_state.c    | 406 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c | 128 ++++++
 .../arm/display/komeda/komeda_private_obj.c   | 220 +++++++++-
 drivers/gpu/drm/drm_atomic.c                  |  45 +-
 include/drm/drm_atomic.h                      |   6 +
 9 files changed, 817 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_stat=
e.c

--=20
2.17.1

