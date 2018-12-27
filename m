Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF120C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E802148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjRhhD+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbeL0XNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:13:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45753 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbeL0XNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:13:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so17359355ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 15:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASgGtD7SWEZIjyQo5W7ibNOu2QSQC4mll5Rw7jPoD2k=;
        b=rjRhhD+4pf0y6m5FJYke2Yy171DkpjI2fLbFd2LTACqOAQET1yuTOII51seZAUKWyK
         BvZvu6bsG7n7SY3/PiJR1yL9DKg7dh4mM/vzgcKd8KzEfV1mlLvSdd00jKHC5Cz/3eHJ
         vfq9xxuHDSXXp9xv5Y4dCSKxBbDB5CEL28UZNN2jjaoTIUvq/35Dczl7M02eKUvrx5Jz
         EOfurJFxjzvK6TJkB8b9fur4EHEwCDLAzFAOlFV17sNk8oqWuIM7/5nPLRpybeEiEKMb
         cCOwZwUsfGPvDVNZGwTAaCfpqVUEzRhPsTFs5IPyJrRDpJK1nu3j8EqIwdiqzkaKB+hV
         qUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASgGtD7SWEZIjyQo5W7ibNOu2QSQC4mll5Rw7jPoD2k=;
        b=MWXHwheUWuicTbqQNrQ1LXQ9fHS1Q5cFMSSFLPUDAj3RbFhhL4cHULHuQ5Y8aucOTd
         8X/EtbjvxkNn4kTpDFjehRS9xZ1JeVbjxTFV2PLG2MAqDbF65kWuGWZyjl/U4+xH02KO
         vddnQ+P9q/bteTCoJq1j7j0qrS/tu/cxAoezkNwBid7z+USNZLPbVEc/plnn2WvDMj2S
         5Exaqyygbi2/mjrStoGBiHnFm0VlZyQ7zXec99kCR2YXh609pse+8HvOBso6Xyud8IAT
         vGDOPFTpKh34A9lOUowwoR6ESC6CQngJ3aBhiGpXaMotYhG2MW3TfkMrkkmaHbyQNggJ
         OMzQ==
X-Gm-Message-State: AA+aEWYACzNi4I9ZzcAB55baun15HdvYwGH4v8ACAI0JSLU3qNnd83FG
        5q5SQBpczwALavJ6AMMUuQo=
X-Google-Smtp-Source: ALg8bN6bI+H3eTI0HsyqOwyA7FbLhY0Zt4Nj5Oa9I3f5vxzUOwkf3EuZQiBPJfNbTAR16T22xEBntg==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr14268481ljj.165.1545952400966;
        Thu, 27 Dec 2018 15:13:20 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id r4sm7834626lfe.60.2018.12.27.15.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:13:19 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [PATCH v1 0/2] Fix SDL 1.2 on emulated fbdev devices (broken in kernels >=4.19)
Date:   Fri, 28 Dec 2018 04:13:06 +0500
Message-Id: <20181227231308.16904-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Originally this issue was brought up on linux.org.ru forum by user
saahriktu, he is on Cc. He discovered that commit db05c48197759
("drm: fb-helper: Reject all pixel format changing requests") breaks
support of SDL1 programs, like various old games and emulators of old
game consoles. First patch contains fix for that commit.

I tried to reproduce the same issue in a VM under qemu, and found yet
another part of kernel code which prevents SDL1 apps from running
normally. Second patch in this series fixes this problem.

Also, it seems that at least in some cases both problems could be
circumvented by adding appropriate modes into /etc/fb.modes. But without
examining the kernel code it is not clear which values are correct. I am
not sure that such circumvention covers all possible cases, and it is
definitely far from any user-frienliness.

First patch in this series fixes a clear regression. Second patch is
optional, please read commit message carefully before applying it.

Changes in v1:
- Added "Cc: stable" to the patch which fixes known regression.
- Added more information and detailed reproduction steps in commit
  messages.

Changes in v0:
- RFC patch series introduced.

Ivan Mironov (2):
  drm/fb-helper: Bring back workaround for bugs of SDL 1.2
  drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

 drivers/gpu/drm/drm_fb_helper.c | 153 +++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 54 deletions(-)

-- 
2.20.1

