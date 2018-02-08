Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeBHVde (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:33:34 -0500
Received: from mout.web.de ([212.227.15.3]:33019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752205AbeBHVdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:33:33 -0500
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, Oded Gabbay <oded.gabbay@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] drm/amdkfd: Delete an error message for a failed memory
 allocation in kfd_topology_init()
Message-ID: <94b486c9-92ce-dae8-3d5e-db1943fc0119@users.sourceforge.net>
Date: Thu, 8 Feb 2018 22:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Uf7LDAH5bPtdWOJi82TF3e+pr53gsO5mg6SEJzBYx6CK3bzhKry
 Z5BI+SrwgTTAjGYAmXI0G9fk2bEBzFtcBWxBofpEMY8jdnQqZGXUCLAxrudwbnqR7vuPSZo
 bDTRmrgem/VKFZRJ3Gsf6chsfMftd79fjwB5GHqe1UOdbbIo5Xvg0SZAlrKuyRheYBCXB3d
 zlBsT8DdtH2fJZF7Ed2bQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mRWBEQgq1Y0=:J4fe1VyT6rPp0nMU8vqZFp
 ki8BE05Vkl844Fo/6mnxts0MbN2SRrV/2FXNAInWrkIgw7buOwXA/kUpT1UMGCZWHn2ZoYuQ7
 yw1xgGw976bmlFQq+lzriW9+0rpyw9vbLmACbbbVV44gSmeD5VEQJmDUXF0ir6cAtNoz1fb8l
 Rsj8J7TN2x1NAf86rQ4ZorvOyU8ZOEW+kimzlTDR8vNOLE7615a9r94PaC5uTkBZWyMfu7SdB
 RXViMOEixhgGcej2bXtQM9kliNDJ88nbvJ3VWMOy677Xfd5GdS4DODQ/NFlG/ULAhdwhKSNwN
 7Apqd5C4WNpM14cUEkJPjXlyiCXi6ZbgrZs6IuYb4Mkeb6bBxZAbublw5NMTG90dnjqWvjMlw
 OJagOP38DWKGnTKqEKKklQ0fo/Wxc+xv/jLeU84K5w1wTUeo1IhD0zpvj9YaiRJpQhTaJublQ
 XiCedaylfGrW4a7zWS/yUYGofnZ1NvIukF9lzxKjcQdvCGzSOB2sChYexjZ/tR5aGecBRt/gn
 C6VU0PReUK3KWNZWwohuL442FTpoaOvKwlPv0T8zRqJ4o2koaW5vLO7aG5chwxaoEgKDdVLGq
 QapISL2B9XU0V7jyGfTvjJ8DKgAGZozDoiIun6j1Xh4YVAzytcBI3mZBvVLzPKgyCqipW6J7P
 IzbOBORVBYMGUCfroUyVR6v2ZPBAnoz0mWUS7Ml5oNEfQf9v2kVQMouPNzg/Ml12JV08sA5OX
 /aYgWCq424Xf33UJsujt2XNqaztXKPmyOP0/IVQQ7v6+EkroQEDVuqswVFGnXWY2cP53I/VHt
 oJoWlWYzf78GIRQYa6JfGC7IhnevfBDdgmg9LLzSny2Dwru8Uw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 22:23:57 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 19ce59028d6b..610e3d4ac575 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1019,7 +1019,6 @@ int kfd_topology_init(void)
 		crat_image = kmalloc(image_size, GFP_KERNEL);
 		if (!crat_image) {
 			ret = -ENOMEM;
-			pr_err("No memory for allocating CRAT image\n");
 			goto err;
 		}
 		ret = kfd_topology_get_crat_acpi(crat_image, &image_size);
-- 
2.16.1
