Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123310-2-10851036093483076476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123310; b=nC5P0WYaoXFojaCBV9X/OXW4f3efMjBM/Dyp3l5tkTK1A5F
    r4Lq2VfvT/01oViSTYKDrBzTmHvp00Vp/Qf1B+6uXiO1dx94X8aGRglOULWVM+Lv
    r+pj30NxhE1ZKJVikD6d01UKLjKROGR9MkpdACZnS4HgfN+RiAVz3GRVW4I72mgn
    VE4MzD1QR1dQXdK81WhBo6W9qS7c3SDYQppiBwqHGZ2pIgbT7p4teXhcXO/4pQvf
    UQanVmHSI+mCM+UNYZJbuuLOK5VzqeePOOf+cX+n01BmwwQmANGrTcaV7y2JHQNt
    2VBpCOzhns6S8YzMxdYYjkmNzHjKRutiUvFic0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123310; bh=PGXzb6
    Goz+nqi2UvHnuPWH678/3qbNwjvjK6iimQbb4=; b=WapLOIHddxFj/YP3p7MNb9
    jtEMCTjVq9N3rq9Cc3Qj3eVU+ebSnIag64p1ClEqsfWgdlpZbmPtSvfNqnpU94cv
    mGKPZsiukxOTc9WffD23QyJ3RvyB7n8ZUFFLMr1XxV2c0dLvFmrNtOkXnclBuYGu
    BEV/7yZatSF7hcpjKoUm/5IhspASIZG4X9uWymOzILQNO2tauVIizHxvQU/fZ8tu
    wJT6ReMpBJJhPEu7ezUYo+KvywZV5C6zlYSXd3TPV0gqD+oInk+60EYpGwxNjluR
    QIXwwRyqneR19bN/aifOj5kiGZgUX4VlkkhHOW/6WLM6RVX+pzELLWjvvi+GYjkA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=caJSd4j0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=caJSd4j0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933169AbeCDA14 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:27:56 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933101AbeCCW2J (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 10/84] drm/amdgpu: fix
 get_max_engine_clock_in_mhz
Thread-Topic: [PATCH AUTOSEL for 4.14 10/84] drm/amdgpu: fix
 get_max_engine_clock_in_mhz
Thread-Index: AQHTsz6egSx53TaCcU+J/TRzOyBcHQ==
Date: Sat, 3 Mar 2018 22:26:05 +0000
Message-ID: <20180303222518.26271-10-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:3fKa44IKOjTkuMK/4hvAX/Pf3Qk/BjbjK1PxtDMQEu/P/FrUP8dzF4zYyR7yKSnltT7u1w5jCSQenOjPAxjjRMZG/jbS6zKhV5E7xMtM4Qhhgam9NYp5OH+S8jIc+YsxHAxkEKDKi+T9B+H0mVhPOzicCvlDnsBNVnHvolGYCgm642orfgNgVW72fvf615alQQgyCxRWG2zqHax1x7KxS763B3BRma2cpJyKsdCUuroRWsmeEvYxs/ndtDa4z36E
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 908435f5-b036-4f00-6721-08d5815609b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067A2804E4A078139C472EEFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(8666007)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(39060400002)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rnxoRJv33hVzw0lncyPVUfK5k5/EMm0zjVwAGvlSvPW1qJmAln3eBwEZFmakBLlXtj0K3PgQzSPQw9Jr+KvwxWjiiZuKbhE30YHD0h57Xr57aS4Edy+IWPIIejzwXcSuJUPU8LdJ+8ehS6HbWSEBNEPNOaG3uoj8lXJYzgCmXpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908435f5-b036-4f00-6721-08d5815609b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:05.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit a9efcc19161e20623c285fac967a32842972cebe ]

Use proper powerplay function. This fixes OpenCL initialization
problems.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 5432af39a674..f7fa7675215c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -265,6 +265,9 @@ uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kg=
d)
 {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
=20
-	/* The sclk is in quantas of 10kHz */
-	return adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.sclk / 100;
+	/* the sclk is in quantas of 10kHz */
+	if (amdgpu_sriov_vf(adev))
+		return adev->clock.default_sclk / 100;
+
+	return amdgpu_dpm_get_sclk(adev, false) / 100;
 }
--=20
2.14.1
