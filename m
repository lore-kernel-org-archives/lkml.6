Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEACC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730AF218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BLX+dC4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfAVJXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:23:36 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:40162
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfAVJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/YLEg+7DcNNutG8yZHRSRZR07T1OyvC5fespbRaO4I=;
 b=BLX+dC4Gd6BUR+8NBqmE6EWGEqz1QIEkA65WFEu9M4jwNn8vhkIlzgC5T1+2QjEp1qPaX/FrvQFPDD+gAFQC/JvmTUayixY6djv0eU//Sfl0QCaFCf00WAwSR2nrfrYzIzvx1q30c5gWVd4NlCZFOLXisXBM1qE+YyLbT0PU2gc=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1957.eurprd08.prod.outlook.com (10.168.85.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Tue, 22 Jan 2019 09:23:30 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:23:30 +0000
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
Subject: [PATCH v2 0/7] D71 pipeline/component descovery and initialization
Thread-Topic: [PATCH v2 0/7] D71 pipeline/component descovery and
 initialization
Thread-Index: AQHUsjQj5O3NcUFKQUeM/Jt+waa6kQ==
Date:   Tue, 22 Jan 2019 09:23:30 +0000
Message-ID: <20190122092243.21226-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:10:e::27) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1957;6:sq04BK3r9rijdk7Y6THcINR809TEMM++UHa+Jtibsdgx9+0rBa+RrSWqLDQTHnixFnAJCeNes9iqU5cLT77KVS+rKU8zx3q7y0jXekN95pew6ND+8Yx0x4Xw5v54EX2xluZ+neF0DcCsOFwPSxNzv/5XsdxbxuT7ergB12+11KJUSRY5SGhX7TMiRRv5Agwm/swUS6455c4MTao7LAaT/mH0Z5A2PgeU55CfgwP9qDbdXtATqzeY1DPC1ba+HS79omMMmP4TLCU6GsgmM44IaBpCcP8DoCTJBiZ/ZLqVqiSZs1M/v2nB6NiA1wpz1p1MObxcO/Qevvxx63hm0Y9WnaVIXcjK0UPQ4jVkYhCoSYfzCtlARLx+SClsJP4As2GRFxAckjyBcPEIQeMJHl6DYEDttdH5ri5Fssgzy7HbiKQGmcNoilw+MG431/qg1AKEyo1EuKEy/Dbv9TJcPrseuA==;5:YAvTLsOaTTXmyER36B9J8kjC2zp82xM6ZZqIjoNg19tQxtF1IXGuKwKhHG/MHIg8MVyjITTPHHMP/NtQRARkDgISgrzYnFnmg3HiRb/Mj3YXv+IVQxqUYsw+JW/Ns65w8UJzMRTery7BtD5PF6HAUYJ502ULQVyl0R3lWzxk+dL6vR4KblJSlCUp0MNwPm3jH0XfEBLMM3Hqdu3XIkNZqw==;7:KN8dNRjUoqNqsL4yVRPLZor7T8qvLedrAhwNGqz8xF0y6YlqL2P5GWcO3GBpiqCWUmMAYlSIeQUuZR7hM9jXZ1dBlDMRc/pa9jytRYZi6mK0VyAiUW4NaA9HODoLTqbK73ld0A3wTfJn+HECar27rA==
x-ms-office365-filtering-correlation-id: a72769ac-af97-413c-f643-08d6804b4565
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1957;
x-ms-traffictypediagnostic: DB6PR0801MB1957:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1957530B575CFDC0DF95E2E0B3980@DB6PR0801MB1957.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(1076003)(3846002)(97736004)(2501003)(36756003)(8936002)(86362001)(50226002)(6116002)(386003)(6506007)(316002)(8676002)(7736002)(6636002)(110136005)(54906003)(81156014)(81166006)(305945005)(66066001)(478600001)(71200400001)(71190400001)(256004)(53936002)(25786009)(105586002)(6436002)(2906002)(55236004)(106356001)(52116002)(476003)(102836004)(2616005)(186003)(14454004)(486006)(26005)(99286004)(6486002)(4326008)(103116003)(6512007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1957;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U63cvE0CndD6fiPEPDMG4lIFFRcEMgv3ITAViXDKeBWCnQJI48U2uIPJjOkXgcaDtgo5mwMmyiIsFGAHK0JKqYc0iJlRwkcpEdcUSh+vIbcgewl+SVEoaaPtio2WlGW19nop29hFKCfn5yiOJNCnmHjSbrH31a/j+zr1nDPaPAVDPQMpS9IdOdcYi0iJN96c4jtBbar/sGZ2HT9oeEGc7VRTWN444SN5QVE8YKk20IoLs5eIhh6bprRsmjzXo5GtZU/jWoZQV9pmPImfQjTrXuTKhsAh1Ce1QE9ythVi5Ifh+1lmFhvIFtmenGmIMpcAzsjXTBVETgvAcy9E+h49gLMsCM6JRtiSrJfEu2+t5PUj4sd+ceJR+oR+2UTwvLxrCmD1dzvHUHM6OiN1zmZuke4EzymP11W3RVYINin3OgE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72769ac-af97-413c-f643-08d6804b4565
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:23:21.3622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd patchset for komeda-driver.

These patches focus on CHIP(D71) Layer for pipeline/component descovery and
initialization. All basic and essential display component: layer, compiz,
improc, timing-ctrlr and irq handling have been added, other component
support: scaler, wb_layer, merger, splitter will be added in the future.

v2:
- Rebase.
- Use DRM_DEBUG as default msg printer
- Return the specific errno not -1.

james qian wang (Arm Technology China) (7):
  drm/komeda: Add d71_enum_resources and d71_cleanup
  drm/komeda: Add d71 layer
  drm/komeda: Add d71 compiz component
  drm/komeda: Add D71 improc and timing_ctrlr
  drm/komeda: Add komeda_assemble_pipelines
  drm/komeda: Add irq handling
  drm/komeda: Add debugfs node "register" for register dump

 .../drm/arm/display/include/malidp_utils.h    |  29 +
 drivers/gpu/drm/arm/display/komeda/Makefile   |   3 +-
 .../arm/display/komeda/d71/d71_component.c    | 682 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 375 +++++++++-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  50 ++
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 530 ++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  18 +
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  64 ++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  51 ++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  37 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   5 +
 .../drm/arm/display/komeda/komeda_pipeline.c  | 111 ++-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  48 +-
 13 files changed, 1973 insertions(+), 30 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h

--=20
2.17.1

