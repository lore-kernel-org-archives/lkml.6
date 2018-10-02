Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C14C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52E22089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3ZgyxSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52E22089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeJBNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:23:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35800 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:23:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so784192wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 23:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5Sc0Ld7IAOd9EdTHcjw9mjNsbzRwG5qvHg3mvtZ8GM=;
        b=d3ZgyxSFscEMejZDC/2eZsW4wkHFitbXq1tuZDb7k89l/66o8on+HUSCYFL3FEPbbg
         4/2QZ4QF9e5MfFlzaqfKZruTh/dD1dd3y3sXlW9L3wi9vty8hFzUecOm+VOW5FppGuHs
         OC/cvgRHiMbqRXsL9K97OWH3COygwyiheEhR1I9jhVb4g6TkamF6g8wXsgOF2ytG1ohM
         /5LZs8npQFP4lRO3W6D4Wlh3IzPcrhJZ/v1l/wbTDByXxyynY59uhJ0sZkIwV6Xia7Od
         kmLD4I8l0vGihBvMq/zRCyCZWTk8+UDsawFMp0H51VYqdQBKBJ7XaaGUBhh+aR/tWl1f
         +DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5Sc0Ld7IAOd9EdTHcjw9mjNsbzRwG5qvHg3mvtZ8GM=;
        b=YdaLXTFcfI4NFPAojdsan9SDj8IZZPForWWJGA1Fv+2rknFKXOtPkTOV9HqO0JluJD
         mbdb7+0SUA9mwZd/8sbsM0/ui7nZ39JfntyyaLMAHMUHI2qa1WRqISefzg4t/GuZhfCu
         wmF2Ql5mYiHGznt2c1tq5PYd4drH7oAAXd0r17UtDnZaKBRM+d1HQ/BPMZ5seUZZmpic
         WNFC7vKRyRgFu3VzmS6HGRXNxqfBPfnMVknW3i/LE1eUQ+WcN7JGNMAn73MLKrTF5lci
         XmszSNAPblmR/CHDSfcxbuIORbdxdHEc7QRTAFdcxuOWI695721KoyJRDLcpYhgIEKP4
         TaYA==
X-Gm-Message-State: ABuFfohCVcQEjfMLcA5HhsZ/dq6avgblYjn6wWB4rDyBgjcClQnABkTp
        4/W+CEg7r3IdDAOTo51w5sw=
X-Google-Smtp-Source: ACcGV632ZaZGfCMvhq6dki5JOH42egltbJfCcOwg6sfFlIeSbuoAuHKS1bC/vtuJHBzDVRvK6o/PEg==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr937609wrd.253.1538462506613;
        Mon, 01 Oct 2018 23:41:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c13-v6sm5324603wrm.50.2018.10.01.23.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 23:41:45 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/scheduler: Simplify spsc_queue_count check in drm_sched_entity_select_rq
Date:   Mon,  1 Oct 2018 23:41:24 -0700
Message-Id: <20181002064124.25881-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang generates a warning when it sees a logical not followed by a
conditional operator like ==, >, or <.

drivers/gpu/drm/scheduler/sched_entity.c:470:6: warning: logical not is
only applied to the left hand side of this comparison
[-Wlogical-not-parentheses]
        if (!spsc_queue_count(&entity->job_queue) == 0 ||
            ^                                     ~~
drivers/gpu/drm/scheduler/sched_entity.c:470:6: note: add parentheses
after the '!' to evaluate the comparison first
        if (!spsc_queue_count(&entity->job_queue) == 0 ||
            ^
             (                                        )
drivers/gpu/drm/scheduler/sched_entity.c:470:6: note: add parentheses
around left hand side expression to silence this warning
        if (!spsc_queue_count(&entity->job_queue) == 0 ||
            ^
            (                                    )
1 warning generated.

It assumes the author might have made a mistake in their logic:

if (!a == b) -> if (!(a == b))

Sometimes that is the case; other times, it's just a super convoluted
way of saying 'if (a)' when b = 0:

if (!1 == 0) -> if (0 == 0) -> if (true)

Alternatively:

if (!1 == 0) -> if (!!1) -> if (1)

Simplify this comparison so that Clang doesn't complain.

Fixes: 35e160e781a0 ("drm/scheduler: change entities rq even earlier")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4e5e95c0cab5..3e22a54a99c2 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -467,8 +467,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 	struct dma_fence *fence;
 	struct drm_sched_rq *rq;
 
-	if (!spsc_queue_count(&entity->job_queue) == 0 ||
-	    entity->num_rq_list <= 1)
+	if (spsc_queue_count(&entity->job_queue) || entity->num_rq_list <= 1)
 		return;
 
 	fence = READ_ONCE(entity->last_scheduled);
-- 
2.19.0

