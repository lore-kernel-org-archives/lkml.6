Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67E421B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gi8fbFku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405961AbfBOKzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:55:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389068AbfBOKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:55:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id j13-v6so7996217ljc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQexxBXvtq+uJCgNNk8ipWv4gTMwLbVaDe+ME7sYFhI=;
        b=Gi8fbFku0UGf9t4F1Lr+QO2hzfH644XoOdsuSQveD6eWeodaSuuT4hVKoiu4y3VkMZ
         b+LYgjwsS5qwk/+DDBzCsKn5ZVKaSym0RBTjavFou/6orakR//3sF6YleTpXmUr5nrKK
         IPzEclzgfVuyXl5SPA99qpzEzxdzVcgkCVCkQTi1b+XhgMEWzS8FXMBQysRGrtPEcgZ/
         OqKqcn+sdifY2m3P1X85PsK+KIvMLW35r3eDKCKLl3q7TNcLt2bZpuBM2FgVvOQUQMz/
         /O7yq2jrXaTKuow4TOFxB/Jbjw3Lyn3gx4flJvz1MvZB1NO7okm7GSao7NOjZE0kVIlK
         qIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQexxBXvtq+uJCgNNk8ipWv4gTMwLbVaDe+ME7sYFhI=;
        b=s7kSG/PJ6rG9ikFv3GlPPznJZoJyeIx8jR9FvdJsfOcWqnxdXDLbHhj8Yt5iIhKliK
         SsPcfrkrcvXU1Wrbe9pA/UhxjK4J2FCpYJyF7qGR6owlPoNVCq1/MLCoc06Ck5vclYV1
         mFt9C2T/Qdxqtr/KVJvUccqqxbTCGDlLgX118IJpAxn5YmL9GzETVw+mztbxttyh8+Pa
         n36ylpPH29EJ6uECSkRufDoCVepL+42SP5JT4pA6fxk0twZHl2+mP9zN2nWxR0B6nagG
         1YMSUFXCRfyJE0iHAJV+sod0w5mrkHz4XKABYFw8MK9/jCEWENXq0JlBp9fRA0uFG6nO
         m3TQ==
X-Gm-Message-State: AHQUAuYQ9dQELPBFrrPshzZfLVRIrU51sl3VULqwS+b6ks8uR+VvPWN0
        bs/x3YB3UYHBafRZLBB9MytQFQ==
X-Google-Smtp-Source: AHgI3IaKpTB3TzUEACUPMbdupacSJ1+e6kTejpNLZOQD9H7shELlNdtqS1U/6hg85qt4Hv0cBWc8QQ==
X-Received: by 2002:a2e:680e:: with SMTP id c14mr429947lja.51.1550228139808;
        Fri, 15 Feb 2019 02:55:39 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id u24sm1233825lfu.68.2019.02.15.02.55.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Feb 2019 02:55:39 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Take lock before applying system load
Date:   Fri, 15 Feb 2019 11:55:33 +0100
Message-Id: <20190215105533.10264-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the regulator lock before applying system load.

Fixes the following lockdep splat:

[    5.583581] WARNING: CPU: 1 PID: 16 at drivers/regulator/core.c:925 drms_uA_update+0x114/0x360
[    5.588467] Modules linked in:
[    5.596833] CPU: 1 PID: 16 Comm: kworker/1:0 Not tainted 5.0.0-rc6-next-20190213-00002-g0fce66ab480f #18
[    5.599933] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.609544] Workqueue: events qcom_channel_state_worker
[    5.616209] pstate: 60000005 (nZCv daif -PAN -UAO)
[    5.621152] pc : drms_uA_update+0x114/0x360
[    5.626006] lr : drms_uA_update+0x110/0x360
[    5.630084] sp : ffff0000124b3490
[    5.634242] x29: ffff0000124b3490 x28: ffff800005326e00
[    5.637735] x27: ffff0000124b35f8 x26: 000000000032bc48
[    5.643117] x25: ffff800004c7e800 x24: ffff800004c6d500
[    5.648411] x23: ffff800004c38a80 x22: 00000000000000d1
[    5.653706] x21: 00000000001ab3f0 x20: ffff800004c7e800
[    5.659001] x19: ffff0000114c3000 x18: ffffffffffffffff
[    5.664297] x17: 0000000000000000 x16: 0000000000000000
[    5.669592] x15: ffff0000114c3808 x14: 0720072007200720
[    5.674888] x13: 00000000199c9b28 x12: ffff80002bcccc40
[    5.680183] x11: ffff000012286000 x10: ffff0000114c3808
[    5.685477] x9 : 0720072007200720 x8 : ffff000010e9e808
[    5.690772] x7 : ffff0000106da568 x6 : 0000000000000000
[    5.696067] x5 : 0000000000000000 x4 : 0000000000000000
[    5.701362] x3 : 0000000000000004 x2 : 0000000000000000
[    5.706658] x1 : 0000000000000000 x0 : 0000000000000000
[    5.711952] Call trace:
[    5.717223]  drms_uA_update+0x114/0x360
[    5.719405]  regulator_register+0xb30/0x1140
[    5.723230]  devm_regulator_register+0x4c/0xa8
[    5.727745]  rpm_reg_probe+0xfc/0x1b0
[    5.731992]  platform_drv_probe+0x50/0xa0
[    5.735727]  really_probe+0x20c/0x2b8
[    5.739718]  driver_probe_device+0x58/0x100
[    5.743368]  __device_attach_driver+0x90/0xd0
[    5.747363]  bus_for_each_drv+0x64/0xc8
[    5.751870]  __device_attach+0xd8/0x138
[    5.755516]  device_initial_probe+0x10/0x18
[    5.759341]  bus_probe_device+0x98/0xa0
[    5.763502]  device_add+0x3d0/0x640
[    5.767319]  of_device_add+0x48/0x58
[    5.770793]  of_platform_device_create_pdata+0xb0/0x128
[    5.774629]  of_platform_bus_create+0x174/0x370
[    5.779569]  of_platform_populate+0x78/0xe0
[    5.784082]  qcom_smd_rpm_probe+0x80/0xa0
[    5.788245]  rpmsg_dev_probe+0x114/0x1a0
[    5.792411]  really_probe+0x20c/0x2b8
[    5.796401]  driver_probe_device+0x58/0x100
[    5.799964]  __device_attach_driver+0x90/0xd0
[    5.803960]  bus_for_each_drv+0x64/0xc8
[    5.808468]  __device_attach+0xd8/0x138
[    5.812115]  device_initial_probe+0x10/0x18
[    5.815936]  bus_probe_device+0x98/0xa0
[    5.820099]  device_add+0x3d0/0x640
[    5.823916]  device_register+0x1c/0x28
[    5.827391]  rpmsg_register_device+0x4c/0x90
[    5.831216]  qcom_channel_state_worker+0x170/0x298
[    5.835651]  process_one_work+0x294/0x6e8
[    5.840241]  worker_thread+0x40/0x450
[    5.844318]  kthread+0x11c/0x120
[    5.847961]  ret_from_fork+0x10/0x18
[    5.851260] irq event stamp: 9090
[    5.854820] hardirqs last  enabled at (9089): [<ffff000010160798>] console_unlock+0x3e0/0x5b0
[    5.858086] hardirqs last disabled at (9090): [<ffff0000100817cc>] do_debug_exception+0x104/0x140
[    5.866596] softirqs last  enabled at (9086): [<ffff000010082024>] __do_softirq+0x474/0x574
[    5.875446] softirqs last disabled at (9079): [<ffff0000100f2254>] irq_exit+0x13c/0x148
[    5.883598] ---[ end trace 6984ef7f081afa21 ]---

Fixes: fa94e48e13a1 ("regulator: core: Apply system load even if no consumer loads")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Hello Mark,

I'm not that familiar with regulator core,
please verify that I'm using the correct
locking function here.


 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 224f62d27ad7..7ed134afb316 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1347,7 +1347,9 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		 * We'll only apply the initial system load if an
 		 * initial mode wasn't specified.
 		 */
+		regulator_lock(rdev);
 		drms_uA_update(rdev);
+		regulator_unlock(rdev);
 	}
 
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
-- 
2.20.1

