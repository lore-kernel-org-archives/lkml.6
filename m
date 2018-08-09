Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEB12238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcLS46j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEB12238D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHIUhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45943 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeHIUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so4738503lfj.12;
        Thu, 09 Aug 2018 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DHqpP56i45ZioyVBt/LDOO1BKVOPtqsaYC3D/EWK/AY=;
        b=hcLS46j3iobw8s5vlnvlLMCW6vU3uMzpakS+1I/3ZUHUcnRwilIWT8Z3RZZodLYbVg
         J35ZXeM8ACMJ6okp3zzNtbEGMX1fX+Bl7uLPdx7OSKwL/wfpgTQ3yG9nF56EJ5CtluOb
         jyPIJNeT67Y4OscMAXCmuLQjpOMwF4GF6T2w9qg9JKPzUyJXroK/sUzcVTfEnU+943VF
         490o68jPzruNQM8Nmh+YK1j7IsvX9Wj+IpYfa39YNc5qQWm8M9ttt9hSC5bOyAlq/7er
         ZJ0cFcTrYQS3oREZykYTHPcQfQ/nXib6Owwg4yhz0+5xVFj83FeQjQQWzGBi1Y/CD+Ec
         g+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DHqpP56i45ZioyVBt/LDOO1BKVOPtqsaYC3D/EWK/AY=;
        b=dmHu2LpY9uHyK0nv+0QAd/4sEnxufKcDvODliMOZU6DM1q/j0WorrHYiY9k8nOimb0
         khGlzwQeb3mUgZ7m8RJqBJLqg8jSk9gz54qRqUVL50xoHz8A20zVo4ySDF1+KXQAogaz
         rfn8rLjNnfvzOiHY1Eg3TUB376RG2VzpDp6AvuvfvNvKwPrwrO6vsMX6KGk0QZ+zx4mo
         DmgnQzTc7wU6IjsKhcL4VFSmAKOvRhvO3NeB+vTy0jteO3Vae2lo9f3Djr0iEZqUgOw9
         rL/dTZyoW7cK7aNQ0xu9iQhqAJizLYRfMqg6oSH0e/mag/XWa87ymJwoxCKxYzRFknun
         e+1A==
X-Gm-Message-State: AOUpUlFh8nKUroh2I5/DOINTwoJ7qQfJOCMov17DwzPsXVGua0Y3dQPs
        rtMYezj/PG1dpSyR063fUsA524xPYmo=
X-Google-Smtp-Source: AA+uWPxzKCYv02638wZL8OIx/rdOxMSeXwTIytVlTZlPQinq194+44LEAX0ip1E5uSLhgQFnEcs2vw==
X-Received: by 2002:a19:ebd7:: with SMTP id f84-v6mr2201582lfk.18.1533838295085;
        Thu, 09 Aug 2018 11:11:35 -0700 (PDT)
Received: from localhost.localdomain ([213.87.133.10])
        by smtp.gmail.com with ESMTPSA id n7-v6sm1432211lfe.87.2018.08.09.11.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:34 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        tfiga@chromium.org, laurent.pinchart@ideasonboard.com,
        matwey@sai.msu.ru, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: [PATCH v4 0/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Thu,  9 Aug 2018 21:11:01 +0300
Message-Id: <20180809181103.15437-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>

DMA cocherency slows the transfer down on systems without hardware coherent
DMA. In order to demontrate this we introduce performance measurement
facilities in patch 1 and fix the performance issue in patch 2 in order to
obtain 4 times speedup.

Changes since v3:
 * fix scripts/checkpatch.pl errors
 * use __string to store name in trace events

Changes since v2:
 * use dma_sync_single_for_cpu() to achive better performance
 * remeasured performance

Changes since v1:
 * trace_pwc_handler_exit() call moved to proper place
 * detailed description added for commit 1
 * additional output added to trace to track separate frames


Matwey V. Kornilov (2):
  media: usb: pwc: Introduce TRACE_EVENTs for pwc_isoc_handler()
  media: usb: pwc: Don't use coherent DMA buffers for ISO transfer

 drivers/media/usb/pwc/pwc-if.c | 63 ++++++++++++++++++++++++++++++++--------
 include/trace/events/pwc.h     | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 12 deletions(-)
 create mode 100644 include/trace/events/pwc.h

-- 
2.16.4

