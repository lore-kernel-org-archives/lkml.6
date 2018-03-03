Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123868-2-5140522193809555540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123867; b=wxSbQPYSbjSUT4eicx36iXYOc1tL3YJzBVm3WU4H/j4CmMU
    ifaz1ZF7eP+8D1B19RXtzRa9ct+4hpAAXunZVJyA5GADYMDCRzQqJ1SlcjcWpqwz
    htCbuRr4O3KTn09hW8xr59peA0XHoDS/mOV/mkBClAUUSB7EDfOZcgV1tuZlkc4f
    pab91ZXHEQltvoRy31nsciQIICmLc+GvyXBv9+Bp7HpptHAsw4WBq7c0zqCSVBzh
    ZX5UYNFxrFq9swYMz2ZoftIFG6Jr8unxKo1qpvazac5gZ7YPauRjbgihId3RDDyC
    DLoE5DXiQb7PsWi0liKahsCbXw9x+pf2MgPr4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123867; bh=EZMkSc
    i2LGIxD1bnkpvhL3JdzqMUbAK8lPsIVWDMpK0=; b=djxPJjYoOh9TOAY0+4kzQQ
    yctRPLry6tC7zU7vCH/cOCUC/hCklSMJaN+T/9qNX+yFcqJTw4rMRY61jQ7LWODw
    xMiU3ul06RpTFtiYCv9yLT//z0CRUJxT4yGzFhdyYGnd0a5pULZogFojrzg/X7Px
    9CHbsOskfBNHvDGPceu3Dhnz03kXBjOiuLE91isWpMqoMqXJub0DB51PBm0xxYNP
    EOPYQaetsb1sMuPzGqcxH/RiclAs67nNpu1z3RGwMk3qIpmdsZnU4n6AOB0b+wL4
    aHd3fuQnHlaoBKBD/wTLRNVv8ZZi3pwV5RdZ5dvn1O0N8QTiCEzXEKtWURKlm1hg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X25ZWDwP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X25ZWDwP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932817AbeCCW05 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:57 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:17369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932667AbeCCW0z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Monk Liu <Monk.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 065/102] drm/amdgpu:fix virtual dce bug
Thread-Topic: [PATCH AUTOSEL for 4.15 065/102] drm/amdgpu:fix virtual dce bug
Thread-Index: AQHTsz5vtWvCAR03rkG6UKLIqWqAGw==
Date: Sat, 3 Mar 2018 22:24:47 +0000
Message-ID: <20180303222318.26006-65-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:Ia+9npcla3jzvGY//f6IPMYC1m853p0A1NjVBD8CWPr+7MiGeCrxlRZ2OmSYkoBHnIayhK0eMtL+WiUT8CTLboA3FIKxB1Hed5F9dD8E2k1PVlqfhRGPPzjR/qsPMxARhgTHnIgeQd4/mMH8yamGtD/IxwG/5hpCmDZOow+PmO+EdmB7fKpOq0p6loKzZwxF5GNj83hrMDH3fep3jrznALhpgWpJrgkvHPVxoyHxL3hjaqc4v+PCSJQ/stC1RuNs
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc7ec855-ebc8-41b5-b913-08d58155dc2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06FF49ED980388B0480F72FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(8666007)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: epMOv4AuK09JuoPH1b5a1zu9wggE8LwxXa/yPNzICj+dtGuzdhRH9ym9kgdVXu3GFD3eBB0mPlDzZLDGiH3x9Sz7V//RUEpLmOgp4ZKFmMM38eOBIWZBM3gEHZh6I5RobR/GJTzweO0j2MV87SDCVhjpMxc/YE2TQRXS5ScONwk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7ec855-ebc8-41b5-b913-08d58155dc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:47.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Monk Liu <Monk.Liu@amd.com>

[ Upstream commit 129d65c18ecfb249aceb540c31fdaf79bd5a11ff ]

this fix the issue that access memory after freed
after driver unloaded.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd=
/amdgpu/dce_virtual.c
index a8829af120c1..39460eb1e71a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -437,6 +437,8 @@ static int dce_virtual_sw_fini(void *handle)
 	drm_kms_helper_poll_fini(adev->ddev);
=20
 	drm_mode_config_cleanup(adev->ddev);
+	/* clear crtcs pointer to avoid dce irq finish routine access freed data =
*/
+	memset(adev->mode_info.crtcs, 0, sizeof(adev->mode_info.crtcs[0]) * AMDGP=
U_MAX_CRTCS);
 	adev->mode_info.mode_config_initialized =3D false;
 	return 0;
 }
@@ -723,7 +725,7 @@ static void dce_virtual_set_crtc_vblank_interrupt_state=
(struct amdgpu_device *ad
 							int crtc,
 							enum amdgpu_interrupt_state state)
 {
-	if (crtc >=3D adev->mode_info.num_crtc) {
+	if (crtc >=3D adev->mode_info.num_crtc || !adev->mode_info.crtcs[crtc]) {
 		DRM_DEBUG("invalid crtc %d\n", crtc);
 		return;
 	}
--=20
2.14.1
