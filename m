Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3DDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F61620B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F61620B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeGKMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:45:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeGKMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:45:32 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MIw2b-1ff9Ix0nPt-002WRX; Wed, 11 Jul 2018 14:41:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Yong Zhao <yong.zhao@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Andres Rodriguez <andres.rodriguez@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] amdgpu: kfd: use modern ktime accessors
Date:   Wed, 11 Jul 2018 14:41:00 +0200
Message-Id: <20180711124112.893478-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:zbQhCN9B1r/NhK/GO0NdtF/eLH0TON7Y5Qi3JC+J0rM0M6+0v5A
 y48ylpwLlpYL51CwKfNLGHIYkg7fpK3gwfQwSrlZjrxMkZAkvNXP0KT5zoHXi0kGYcr2YKZ
 01NeJniDgG6RrgCfZKX8aVqW9IPbrfT88qeZvbqQMpXhJ4xOobTp5lg+ctjRJW7h712ZBhE
 316S/Hq95lCHxZMmGMB2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/bqLd/lg6rY=:q1BpeWJ09+lQZLZe7CTk6v
 /91F3tTlmDx7lNdnQ5sWjkJts7RpLajrPYOiMpSPIB17rMpbPGRu5a+j7lAuJzVf+EJDS/V2g
 0Ef8k59WMmCljsmPBR/YT34d7f2dsZnXQ43BXNEblrg9WkJfC7wI6r1TZIi5VHqM7Poi6KOaC
 T0dwX1FzAwscKgG/w9nVVeQjm1G1FWwuPHmEkV9xrWQQpYZp8ZzaxKmcauJIIYfB5oPZN7Gyj
 2MpXjAlaOsnKqS+Y0mMUjxK9hgla68akOunCj8gBZKF9MzCSGv9gSVgW8XW71Hr0Akoas34uU
 eW4dF7QhrVRCoGndId0pp7NxiJ7XpztOxUKEIexkZq3vDeOLQ2sAjHWUjJr5IgVISZ9fdQCK7
 JJ3nKzKxldRvbrW3U1/G0gh9W8Z43HxaKgeJ0pC0T/PidTqzGMLoKWpBlL2ChfV1zR+GPldf9
 z7i3e0gtx7KX1h75s3poHiLC8oYHMVtoGaP2Ti8nhM2v3fZQWiOSv5Lc1ItZkRhqxWKkOEuoO
 NQbLN1VNdeetZo6aisil9KlHfMS04IvsktWKBIZ+7VGyw61P18/9zVNsETCktNHanab5AYK8D
 uF2yp0V5gz+ILIexcYzbjS3fJsEqno1SXpCs2hBnIjngSIFt30OI2kdDTJX+cLihZZzJ/kVqe
 2zvxUCTI1X21VX7jorA1EC2ShUqNyd5cdsYZlsDg5dQGzl1zyJR/IVyDwpm2uhG42w+U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getrawmonotonic64() and get_monotonic_boottime64() are deprecated
because of the nonstandard naming.

The replacement functions ktime_get_raw_ns() and ktime_get_boot_ns()
also simplify the callers.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>.
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Patch was originall sent on Jun 18 but not applied yet, resending
With Felix' Reviewed-by tag
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f64c5551cdba..7e717716b90e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -754,7 +754,6 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 {
 	struct kfd_ioctl_get_clock_counters_args *args = data;
 	struct kfd_dev *dev;
-	struct timespec64 time;
 
 	dev = kfd_device_by_id(args->gpu_id);
 	if (dev)
@@ -766,11 +765,8 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 		args->gpu_clock_counter = 0;
 
 	/* No access to rdtsc. Using raw monotonic time */
-	getrawmonotonic64(&time);
-	args->cpu_clock_counter = (uint64_t)timespec64_to_ns(&time);
-
-	get_monotonic_boottime64(&time);
-	args->system_clock_counter = (uint64_t)timespec64_to_ns(&time);
+	args->cpu_clock_counter = ktime_get_raw_ns();
+	args->system_clock_counter = ktime_get_boot_ns();
 
 	/* Since the counter is in nano-seconds we use 1GHz frequency */
 	args->system_clock_freq = 1000000000;
-- 
2.9.0

