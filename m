Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B78C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BEB21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dOYW/EQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfBZQU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:20:56 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:51841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727456AbfBZQU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/4YW+A7nOxAmQL2HIg4E0wBf2i9LSpSMQ5uuWMs/DI=;
 b=dOYW/EQk4vL3/UlGSP+818YuE094EdgMAZdGyZm5BYR37U2nvYq4kZL1GIWToLTzf0unwEORR17wJ3h263xvJYMp4kCKRs6jx6mL17idks8YkEPkas4p0RFsBL7PxmRVwrycbIZ0QslqU2+kZ2UiBYYR03VGoeWj6MlQT9vJ3A8=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:50 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:50 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH v3 00/10] Add support for Arm Framebuffer Compression(AFBC) in
 mali display driver
Thread-Topic: [PATCH v3 00/10] Add support for Arm Framebuffer
 Compression(AFBC) in mali display driver
Thread-Index: AQHUze88LfPYdRNihkux1CVC+q65/w==
Date:   Tue, 26 Feb 2019 16:20:50 +0000
Message-ID: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c37e5851-e6d2-4cb3-3a7a-08d69c065f22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:bAS2KGbOaXhiL+ZeZ0imU6ildwY9gkToXT9+hCkLi+Va5A5Hn+cyJ7tepBeVtJ1uWR4po0aJAvC/8+2x5/9JYbgAdRdWu8N7dSldcVHQPhc54xzTp42Webo1JiJfGsQlJEiXlsSnmVnuR7h3p48MIlCw5A8JItZNwE8jGjYhqj0=
x-microsoft-antispam-prvs: <AM0PR08MB3682FED3710B1F9C27B6F0A2E47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(256004)(6486002)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6306002)(6512007)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(966005)(81156014)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +97NK/X1FmSEI2qEnSZULuYxM3CkRH8QFu/+/hQRNSp135/Qg0Z01cMSr3NUCDyxLQwi0ijYmnZReGx50x69meVfVV+pc0d6DH13rYJJY7DihmIlPpy2nXeWZwp+j+kEfmFha4AFlvG5rVNxYtuoF4lPqK2Ji/uYtsarhAmSLK5PHhbISCdqN9hI2SQhjWwCa//9g8aUpp6oFlyx4dzBJZSTOM2hJsHuL1iUqWwvISS+VZ/HK2Z6bq4XeIsEVb4I3jxGdPhoTuW8MxlbHjgBPCQbak8LBkmAOGFLFSvH+sbw6agug5Hh2D/kQ4pOSs0EJCPm1nIa4F3ifZRribIZLsUeQHj5uRIcePthDFfJ5QM4djUjJbxyx9TPgkrqWkuJMDghkwIUsk4YegKhKC5Y9XyKuRAyOuql4u16rKTg/aQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37e5851-e6d2-4cb3-3a7a-08d69c065f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:49.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add support for AFBC in mali display driver with
the help of format modifiers. AFBC modifiers add some constraints to
framebuffer size, alignment, pitch, formats, etc

In the initial patchset ie
https://lists.freedesktop.org/archives/dri-devel/2018-June/180124.html

I had illustrated how to add support for one format (ie BGR888) with
one valid combination of AFBC modifiers ie
AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE

Changes from v1:-
Enabled the support for all AFBC modifiers
(which are supported on DP500, DP550 and DP650) with all the pixel formats.
Also, we have introduced some new pixel formats which are supported with
AFBC modifiers only as well some other pixel formats which are supported wi=
th
 LINEAR only.

Changes from v2 (ie https://patchwork.freedesktop.org/patch/265212/):-
- Addressed the review comments on the previous patchset.
- Rebased on top of the drm-misc-next


Ayan Kumar Halder (9):
  drm: Added a new format DRM_FORMAT_XVYU2101010
  drm/arm/malidp: Set the AFBC register bits if the framebuffer has AFBC
    modifier
  drm/arm/malidp:- Added support for new YUV formats for DP500, DP550
    and DP650
  drm/arm/malidp:- Define a common list of AFBC format modifiers
    supported for DP500, DP550 and DP650
  drm/arm/malidp: Specified the rotation memory requirements for AFBC
    YUV formats
  drm/arm/malidp:- Writeback framebuffer does not support any modifiers
  drm/arm/malidp:- Use the newly introduced malidp_format_get_bpp()
    instead of relying on cpp for calculating framebuffer size
  drm/arm/malidp:- Disregard the pitch alignment constraint for AFBC
    framebuffer.
  drm/arm/malidp: Added support for AFBC modifiers for all layers except
    DE_SMART

Brian Starkey (1):
  drm/fourcc: Add AFBC yuv fourccs for Mali

 drivers/gpu/drm/arm/malidp_drv.c    |  48 +++----
 drivers/gpu/drm/arm/malidp_drv.h    |   6 +
 drivers/gpu/drm/arm/malidp_hw.c     | 249 +++++++++++++++++++++++++++++---=
-
 drivers/gpu/drm/arm/malidp_hw.h     |  31 ++++-
 drivers/gpu/drm/arm/malidp_mw.c     |   7 +-
 drivers/gpu/drm/arm/malidp_planes.c | 271 ++++++++++++++++++++++++++++++++=
+---
 drivers/gpu/drm/arm/malidp_regs.h   |  20 +++
 drivers/gpu/drm/drm_fourcc.c        |  17 +++
 include/uapi/drm/drm_fourcc.h       |  23 ++-
 9 files changed, 586 insertions(+), 86 deletions(-)

--=20
2.7.4

