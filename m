Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeDXPwv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:52:51 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:20928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDXPws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:52:48 -0400
From: "Panariti, David" <David.Panariti@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
Thread-Topic: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
Thread-Index: AQHT2+GBbg9vSzZK6E2CBnt82gNLC6QQD8FQ
Date: Tue, 24 Apr 2018 15:52:45 +0000
Message-ID: <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Panariti@amd.com;
x-originating-ip: [65.223.155.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2424;7:mwIIzr13FcUL6snEjXCzpRzyouB6VUL1EEqoMfOBhzFSyzvF4Uqd5yzRsSiavXU2jNXPREJzMPWnvopNt2a0twUcjEMlYX2XhBmGJYP+UJjdFwN8mhW+vxlIJa6FfmvcdBR38+AYVb39eQ3W2uuh8Fb7a3aFAYC60bmYpaUB/UFbRl0GX7PtW3JjPBGhbkloLwbDshdugKrWraXfitLpCywbg1l6k444SonjY3Kz+/2FxMcpGWtxZUxXje7AFate;20:Pk/vD2bdtM1uNal8QAEYKE4ICmJb19YlTxR+GgwWI+QKwaGaYW9rWUBHOa0MHqh1LeicWLsRvLdBtSruGgbjkvNqvAMYYAwTNoc7r2z2A/o7TLeZn+BBYe73WZ4cxDnua/kGb3k6eJA+I2EoMPGR3Vm4yd2kmGRdIDzD5bdWMX1I2pQQO9Qy9dO9aMbNWhk8sI9A4L4OaKfpybLCJ+J1T+cgl8SuolMgCjaub3tLXLDx4Fz/Fzyhvyb0dtD3Rr2T
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(39380400002)(376002)(366004)(189003)(199004)(13464003)(25786009)(3280700002)(3660700001)(33656002)(74316002)(305945005)(7736002)(5660300001)(5250100002)(97736004)(72206003)(2900100001)(2501003)(2906002)(478600001)(229853002)(53936002)(106356001)(105586002)(55016002)(9686003)(81156014)(3846002)(8676002)(81166006)(6116002)(6246003)(14454004)(8936002)(2201001)(4326008)(86362001)(66066001)(110136005)(476003)(99286004)(11346002)(53546011)(26005)(486006)(59450400001)(68736007)(7696005)(6506007)(316002)(76176011)(6436002)(102836004)(54906003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2424;H:DM5PR12MB2440.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2424;
x-ms-traffictypediagnostic: DM5PR12MB2424:
x-microsoft-antispam-prvs: <DM5PR12MB24249190AB84950D0658569595880@DM5PR12MB2424.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2424;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2424;
x-forefront-prvs: 0652EA5565
x-microsoft-antispam-message-info: 0AN0/YXi0TwqO3l2R+Rz0xdjirFeAg/mOlu65w0DLjTIwZs3jCohFwylucC14bnO47psEzBuFAsu51Ub0OA3AZ89kWGlW9KWRahby8NLrVfqDVQuHAJFzltxt21XTvEkve6xLA3ixJ/SNkXaXC7pzLkHL388QmV5sCvG0QzECnowzKQV0JAZZE6TJRjYNbKA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5b27c2c0-904c-41f9-2b2a-08d5a9fb6c43
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b27c2c0-904c-41f9-2b2a-08d5a9fb6c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 15:52:45.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OFqs7K015770

Hi,

It looks like there can be an infinite loop if neither of the if()'s become true.
Is that an impossible condition?

-----Original Message-----
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com> 
Sent: Tuesday, April 24, 2018 11:31 AM
To: linux-kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Panariti, David <David.Panariti@amd.com>; oleg@redhat.com; akpm@linux-foundation.org; ebiederm@xmission.com; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.

If the ring is hanging for some reason allow to recover the waiting by sending fatal signal.

Originally-by: David Panariti <David.Panariti@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index eb80edf..37a36af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
 
 	if (other) {
 		signed long r;
-		r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
-		if (r < 0) {
-			DRM_ERROR("Error (%ld) waiting for fence!\n", r);
-			return r;
+
+		while (true) {
+			if ((r = dma_fence_wait_timeout(other, true,
+					MAX_SCHEDULE_TIMEOUT)) >= 0)
+				return 0;
+
+			if (fatal_signal_pending(current)) {
+				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
+				return r;
+			}
 		}
 	}
 
--
2.7.4
