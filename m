Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124568-2-4161895011438025128
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
    t=1520124568; b=HNMEDPUcE18IfgPE8T/MryR1MH8/DEFxhfxNaEQJwZvSIvB
    XMeY7Eb/RGSRB+H/4Bc3r7kT4MQkt0tsbHA+O+IGy0jD2HJo8E4OUwy07jQOOMcG
    5sPmtCShSJx1Y7Awrzgz8r1RSYR8UNjxRWOn/ZKgQxZJ0q6zyYHjoc1XLFyzDxX8
    1OOLaxEKMlbYvyAlDKz+r9gK+DX/tNdNxYrIBxi6ql8Z5XnvD9KIUXIm239REuBT
    Y/BFTjIjLoKd5Wz9jxSenm4yQDWZULP5ymER9QGDNF18Y+93mWL8NRYmhixaTBVP
    RewDaaEv3o5aWUGJy30x1j/f2R8zDiOt+zJ6AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124568; bh=PGXzb6
    Goz+nqi2UvHnuPWH678/3qbNwjvjK6iimQbb4=; b=P3ZO9AGvT3GsLaisXSnAU6
    iN7wXYEz8ZLM4zwx3k3pjnq64K1hnee7jTVWvgFmx76e12XmvTjnrDOMo8VP5Du6
    1ONpCTdX7eGwbYMtTBrb1i6KQXIhaXNJOLExOeARrS3TIBqAnyeCiR8e/vY/nSxc
    /0ZFYB0etWS7Vw0n50gMq2JvDfxQbt7rpTs7lwbISSWxqSTUfgWjv5bOJhUwITkC
    lyoARnwjrr07toL4L+shm4xROp+eiiu2uzUQ9FopkP3moVMci9nUerm1u6AqeVHA
    tL6BIx4Z1XYyVJzYoMO7CfHio1uURY+k13WSJpbNK+7Wfwa693iZzic7o70zum5w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V0Rwo252 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V0Rwo252 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932378AbeCDAtO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:49:14 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45037
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932288AbeCCWYo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 014/102] drm/amdgpu: fix
 get_max_engine_clock_in_mhz
Thread-Topic: [PATCH AUTOSEL for 4.15 014/102] drm/amdgpu: fix
 get_max_engine_clock_in_mhz
Thread-Index: AQHTsz5eB9kBFgqnoEau5LPeux2Hzg==
Date: Sat, 3 Mar 2018 22:24:17 +0000
Message-ID: <20180303222318.26006-14-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:6Bghd5ImTGSulsLa+qC2qA7Awc18FFmy2xCsOUsPUjviZbiJD+hgNJmRBbZKxk3pp642KBd6Z4MVwHNuI3Dyw8t/atF3aCF7BIkrVLUINL17PiJYdF1CcP7GX64FwejjSTdIezK/5pDzFTDHZp/GWUk4JkDT14DyNzo/goBhjUNTHAnb4XucES0x2ytPHBKzePsGc1Q71axhOvoLjp/b6cPhvMEyQywiOjIiHmc3V7v+sl7xzoDuOOH8EPA+2rAF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9290b09-b2c1-4818-7b47-08d581558ee8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0890A7809822D6E793393300FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(8666007)(6486002)(3846002)(39060400002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8+KFmg40uTcwYL4bIEigI16Zw+4KxZaOfh+GR9yZhVIpHm5TDjaWjHLf0g3lStYvtgZ0mJlerxx1Jrp/LPCPku0a9MXl+JhqabPjGeHuG4lqo3tR5au/brvksClpRRZPrWnL1T2RWdDVxd4Bl9uvl4ehAahPa1H13XyCWvjyfrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9290b09-b2c1-4818-7b47-08d581558ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:17.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
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
