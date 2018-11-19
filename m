Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44755C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA7520851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lT+g3L9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA7520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeKTBYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:24:10 -0500
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:18272
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729376AbeKTBYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt8oPdvEFxAkjHK8LvvHQ3B5/5cQDMn/XMgxW3ANaCI=;
 b=lT+g3L9mDrQ4QQ1jV9IxzOi4q5thC0Ei4jkgLsWncIlNjvlbjF58aSuWSd1ZxLixzNA/cQWnhj5rk4lmGxUik9EO3ssKKzXdsoni1eIwrIA+i7lwGnZg9UOb/vP20JHM7+d5QktvmfMGc9UQ/LnfJWW2bOTqKP7VkdHkMu79E0I=
Received: from BY1PR12MB0406.namprd12.prod.outlook.com (10.162.146.27) by
 BY1PR12MB0453.namprd12.prod.outlook.com (10.162.147.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Mon, 19 Nov 2018 15:00:15 +0000
Received: from BY1PR12MB0406.namprd12.prod.outlook.com
 ([fe80::94cb:cedf:281:79f2]) by BY1PR12MB0406.namprd12.prod.outlook.com
 ([fe80::94cb:cedf:281:79f2%6]) with mapi id 15.20.1339.026; Mon, 19 Nov 2018
 15:00:10 +0000
From:   "Zuo, Jerry" <Jerry.Zuo@amd.com>
To:     Lyude Paul <lyude@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Li, Roman" <Roman.Li@amd.com>, "S, Shirish" <Shirish.S@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders
Thread-Topic: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders
Thread-Index: AQHUfgOWyt5HmDUVPUGZom7lCHrra6VXLz5g
Date:   Mon, 19 Nov 2018 15:00:10 +0000
Message-ID: <BY1PR12MB0406C1EC0BCD2F6A295CCE3AE5D80@BY1PR12MB0406.namprd12.prod.outlook.com>
References: <20181116232443.1709-1-lyude@redhat.com>
 <20181116232443.1709-2-lyude@redhat.com>
In-Reply-To: <20181116232443.1709-2-lyude@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerry.Zuo@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR12MB0453;20:Lj79GYyySyUmeTWSflsZRwrl3dvC5yV6nuZMT/LeZAC30d/Gl2x9D3OzvIZ1RWD4MHYhubwm3XnRqHtg0Pgbq/S5dMJwA5nakOgjnmiCseZP1yxVMQaxho11O6sLhlyM6uHLpVTDP4W/d3gZlL1u1nPsPNIxILZxwRJZ7DU/PU8DF77EHyaoAFUlrbY6eh0Oh+Z10tFdoUZ0hssu4wZk4iK5XvrK80U1yradq4mRjPTVCFO4Xk0hOpgS1dDbHybF
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(13464003)(2501003)(74316002)(9686003)(305945005)(72206003)(7736002)(6506007)(8936002)(229853002)(11346002)(81166006)(81156014)(8676002)(446003)(5660300001)(97736004)(186003)(26005)(2906002)(478600001)(68736007)(6116002)(3846002)(102836004)(86362001)(4326008)(71200400001)(110136005)(71190400001)(7696005)(25786009)(6436002)(55016002)(33656002)(53546011)(106356001)(551934003)(76176011)(99286004)(486006)(5024004)(66066001)(2900100001)(105586002)(256004)(6246003)(476003)(14444005)(316002)(54906003)(14454004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0453;H:BY1PR12MB0406.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1b266621-f9c4-4dd0-dfd3-08d64e2fb391
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0453;
x-ms-traffictypediagnostic: BY1PR12MB0453:
x-microsoft-antispam-prvs: <BY1PR12MB0453D972C95E6C79C5809D33E5D80@BY1PR12MB0453.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR12MB0453;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0453;
x-forefront-prvs: 08617F610C
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8uBQLFAz5EGj372vjtz8qm7gUpsbhl8hFQdqThN3QKYp0m3afZ/6Qocwonzx3xptt1a1WF12bld2xax4E/Dnl0foQ32SGuJhiY7iDRESbSW/+r0U8r3zcZgULG66/HsdklOuSTXrR0hoWqB+5HwUs9m5lUi8Tn7rks1wb2I1wFI0m8TEI075AEuo0LUK1R2caR+LSuUebk26NnlL6v00fB4g5kFBSJsjiZOdD8WtV8klynxQbFHYrVCiexazPogF82/Ub3g189uiw0iwb2T2vVe02FHXNlp6tlECeQnN65IpZlVW2PmrQVOm4HqbLs4NXutqlJT+uXpzvpTEnXfoEbZKSN/pJqfKOOl3f0HXIUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b266621-f9c4-4dd0-dfd3-08d64e2fb391
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 15:00:10.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>

The change fixed MST + SST daisy chain and S3 scenarios. The issue shows hu=
ge delay in MST + SST daisy chain, and soft hang in S3 resume.

The aux sequence is changed by failed iteration search in drm_connector_for=
_each_possible_encoder().=20
The failure of searching for the best encoder for the connector due to the =
miss of attached encoder in the process of adding MST connector.=A0The iter=
ation search takes time to push drm_dp_send_enum_path_resources() aux trans=
action after the mode probe, and causes conflict to drm_dp_mst_i2c_xfer(), =
leading to the aux transaction timeout.

-----Original Message-----
From: Lyude Paul <lyude@redhat.com>=20
Sent: November 16, 2018 6:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zuo, Jerry <Jerry.Zuo@amd.com>; Wentland, Harry <Harry.Wentland@amd.com=
>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(=
ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Li, Roman=
 <Roman.Li@amd.com>; S, Shirish <Shirish.S@amd.com>; Daniel Vetter <daniel.=
vetter@ffwll.ch>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel=
.org
Subject: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders

Drive-by fix, this is bound to cause problems somewhere.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d02c32a1039c..0cca1809fdcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -342,6 +342,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr =
*mgr,
 		master->connector_id);
=20
 	aconnector->mst_encoder =3D dm_dp_create_fake_mst_encoder(master);
+	drm_connector_attach_encoder(&aconnector->base,
+				     &aconnector->mst_encoder->base);
=20
 	/*
 	 * TODO: understand why this one is needed
--=20
2.19.1

