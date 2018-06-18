Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B58C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F20D20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRX9a+/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F20D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeFRHsu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:48:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43372 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932289AbeFRHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:48:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so7738247pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PZDfEvPvxLQPfHC9WzHv9fCd1hnH3KyG6jUg2YtVdWg=;
        b=cRX9a+/HZDr7hmWC1Eysko/8RzvZzjuGmuoup7tCeEm96xMJoww4f5j9D1o0bj4wWQ
         TPL46fW7x5Dj5K2USXxo45l1NJv095/cVgZB4b4TVPemr+GKCqVDrFAzO2XH+X+wH7eo
         gOSvsNuFSaM0iE0poF7xtCCJpxIu1k5oss1skAIT/tF2VPeqIIvkOKcJHv7jyScvM8gH
         ujAMhanH8/xBKcBTt1hN/ULyEd67pP5lZqIPbPk8D+IAQo8A5np0r8yz6OhbPXNPILUk
         H/HTrMECTkHdX8HEVoopxypOBJZYPhHACIG1yR1W+v8pHcm3vvWU6+1nTU9odoj8mcJC
         B2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PZDfEvPvxLQPfHC9WzHv9fCd1hnH3KyG6jUg2YtVdWg=;
        b=kAt088iKnWWl/3hXMdS5jgv7E3SuduzudWh738swaNRqiSATiatkbprXuW/4zjAN+H
         wpebNkDJx3ATzSht7sZI4MeC1LNOrdrSNUJ0MVIaydjp67hclBq52dl5um3OIaMD/Kw6
         4HER9OhUy0JZMs8gUKRNFxyYijOt50eQuCrOFohFcAh8f2E+Kq8vBNAWIScMlHI34aXh
         jhSJuW5fGUqH2lN5h3uze8WagCseT4K6/yZB7+Boo7WoY/5A257hRirq0lUxkpNwE6fq
         8/xaMyCBmtkP3C9ED0IybhzLA4XFcz5wrjgMGAL1ZVHubERN0yvv++S05kDbTEYmIJCL
         Vmww==
X-Gm-Message-State: APt69E3tN0LNRrg0gQmmihGEfGVaWJZQ9KEMTu3WikNQd4hgDAXDU/Oh
        zhhqp1rlQRwyD073i9pFOek=
X-Google-Smtp-Source: ADUXVKKyhnUZ4PeZq0a2k/+SmrNw1WSAV2r5lC2bxulfnKSfr+7hVob2k846pAlsYh1pEyQoG7HR4A==
X-Received: by 2002:a63:6f89:: with SMTP id k131-v6mr10153366pgc.345.1529308128671;
        Mon, 18 Jun 2018 00:48:48 -0700 (PDT)
Received: from rajan.sibshivalik.com ([219.65.63.222])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm20224002pfo.55.2018.06.18.00.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 00:48:48 -0700 (PDT)
From:   rajan.vaja@gmail.com
X-Google-Original-From: rajan.vaja@softnautics.com
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie
Cc:     intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@gmail.com>
Subject: [PATCH] drm/i915/gvt: Use ARRAY_SIZE macro
Date:   Mon, 18 Jun 2018 13:18:26 +0530
Message-Id: <1529308106-30716-1-git-send-email-rajan.vaja@softnautics.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@gmail.com>

Use ARRAY_SIZE instead of dividing sizeof array with sizeof
an element. This fixes below warning reported by Coccinelle:
drivers/gpu/drm//i915/gvt/vgpu.c:122:30-31: WARNING: Use ARRAY_SIZE

Signed-off-by: Rajan Vaja <rajan.vaja@gmail.com>
---
 drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 2e0a02a..e4c3368 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -119,7 +119,7 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 	 */
 	low_avail = gvt_aperture_sz(gvt) - HOST_LOW_GM_SIZE;
 	high_avail = gvt_hidden_sz(gvt) - HOST_HIGH_GM_SIZE;
-	num_types = sizeof(vgpu_types) / sizeof(vgpu_types[0]);
+	num_types = ARRAY_SIZE(vgpu_types);
 
 	gvt->types = kzalloc(num_types * sizeof(struct intel_vgpu_type),
 			     GFP_KERNEL);
-- 
2.7.4

