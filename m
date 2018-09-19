Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C026C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BD2206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Hm1llpIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BD2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbeITCUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:20:06 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42390 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:20:05 -0400
Received: by mail-yb1-f196.google.com with SMTP id p74-v6so2396617ybc.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKB08lIJM62TjYoXl+fj9q55SEJkhZHMNyRpQLYb2H0=;
        b=Hm1llpIskzym3vuxbvfJH8fhKoejUt+bQ/kZ1873HDkJR7tZfwa+YCPaSLIPqi1+SW
         LTqw84ljiKh1XoEf/DghfZyR6vf8Lwoq3B0hb+KXZxMnpn7wAzgb3P9bqplfnBaLpk4Y
         9yUmaEkqYmjDIiW4mF6Mv2aocah27N4TTaFpGLo/v92xCuq2zCf1YNlfii9Ggz8/Dvcs
         2qQmoetIE1w7MwTjMhvw/I+r9z9YLc1xgV9Ij9Hynrz+6C0tSvgSsoGcWaJk4isQLVaR
         8UbKZ7cwZIpEKuwCWFrEsRhuRpeA0UnJ+r5PojBndQFPeNuJ2rIWV+IJ5xz4jFe3H7no
         Zhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKB08lIJM62TjYoXl+fj9q55SEJkhZHMNyRpQLYb2H0=;
        b=GTe1D90oX01K/YG0dKW6odX+fPGNbaJz++2dQDVcmcrTbfBSHEpsS5AGBwWBXnzYE9
         nbcoVrGpy/uPJ39l3iiIcey26H+WZrfWGRcKQv3kUhBtB0KkuLp4nBdmcIlmFHXv6PCh
         MMbZgNjeCYz+45ts93GLsbXX+uRtAxXw1S1+TVRKAJtNkBPPmU2VHb0Mw6WbwMKYmK9Q
         lkmKZQY96kyO+VWtYh2L/LNKw9RH1aECOmLhB9CBcPQFn24/RmYEo/mM1H4+28BhE4j5
         /h1qo4ku2W4MZhz7UkLefpxe46BmJgcgLrWoD43MSDE4hz3P4OaAJiHRVodhpLirHm+O
         /0Kw==
X-Gm-Message-State: APzg51BU5k5usDd53/3962v3FpQcmZBPF94jHMuCbEasRK6/+LI4RLwF
        e/NJrT2+93HB2T6MtTy85KFgiQ==
X-Google-Smtp-Source: ANB0VdYAsQJdqFAD7t4KwGcRNZh1zUCSLJ/t2s+Qo1PK9ABK5UV8gxokmCnmt8A8PosiUDL5/iwJjQ==
X-Received: by 2002:a25:9847:: with SMTP id k7-v6mr7635589ybo.255.1537389627973;
        Wed, 19 Sep 2018 13:40:27 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id j66-v6sm2602989ywc.61.2018.09.19.13.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:40:27 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 1/2] MAINTAINERS: Move udl drm driver to drm-misc tree
Date:   Wed, 19 Sep 2018 16:39:57 -0400
Message-Id: <20180919204026.3217-1-sean@poorly.run>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Move udl maintenance into drm-misc tree. I've also signed up to be a
reviewer, but have kept it at "Odd Fixes" level of support.

Cc: Dave Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d9068ed4ee5..ba1dbb8735b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4720,8 +4720,11 @@ F:	drivers/gpu/drm/tdfx/
 
 DRM DRIVER FOR USB DISPLAYLINK VIDEO ADAPTERS
 M:	Dave Airlie <airlied@redhat.com>
+R:	Sean Paul <sean@poorly.run>
+L:	dri-devel@lists.freedesktop.org
 S:	Odd Fixes
 F:	drivers/gpu/drm/udl/
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVER FOR VMWARE VIRTUAL GPU
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
-- 
Sean Paul, Software Engineer, Google / Chromium OS

