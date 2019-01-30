Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24052087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="n59zopJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfA3XJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:09:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42069 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3XJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:09:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so523848pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgPj5JLMKLEw4/JFNr8xubY/6A1uXZAj6mpGh5mZQG8=;
        b=n59zopJ8QUYKz71rRaVQp6eODJdyuBFzzZYh1xJUbA150GJ1chHrUHfPQJ5yKaG6Nx
         abpvyyUvsESAKx6F83VAL5P9xNHbeLlP4T8UTUip+54sfAetMey1nQtiaEvBH/9bQjXb
         9ALc6S5aQdHujkk6wCXAjFDd0pivVl1J9yh54ZmXtrpTdTOXAx7k2rB2cL8gpMgh8zz6
         T6wzfInl2e1KchaJ1htC1AUYt5ZLOMJdr9JKWqY/9bGtpYTUyaOM6uaJxOkaVj/mKAgb
         wIY+eP+gQxAug59lS4ClgsP3tM5Gh9oaWsITS761QW8lpNCEBsyinwrxNr13fBDGVUTe
         p70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgPj5JLMKLEw4/JFNr8xubY/6A1uXZAj6mpGh5mZQG8=;
        b=MQzlXg+GsAZqph7zWyWfngcQtYL2k7D2U8frFAbqGIAYnKIKYDGjZCIs0rb0LWF9tN
         gUAX2wlUHju27a5jtHr8UOlU6DSISek1TWwtxpWKogXcQvJxIVp25WzKuLYcxojgZHIy
         tCt5vuPWW5hqG0KcdYI1McndoBroHsAwqH1/beCYFY9+SSZc2zwmKvJvv0QO8Pk7BW0Z
         aYnueuiyKb2Bb4iTPytBYvBY/YrtHpMXEFaQPAH0O4X4tr0A6KFzcNAA7cbiOOLRqx6C
         D1gV2QBf3qcw1kYgD5B8u4DspfDtsey72xvq363pfs+jnYPQVW/DSteds83ehCFNsPuA
         Y2QA==
X-Gm-Message-State: AJcUukfRChorfS/z7Q5YwDminwrvwk0eM0bG0zbSpSMdNxV0GnO9eqev
        UVBwtUEilLoKoWjgaumHk5L80w==
X-Google-Smtp-Source: ALg8bN45qa+ppLtCf+flcXMPoGHZvmh4WamXbPPxhaho8v+UGEGvQYNFbm7ufkQYSFlNrrrjS2INVQ==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr29604211pgg.398.1548888430917;
        Wed, 30 Jan 2019 14:47:10 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id w136sm4219190pfd.169.2019.01.30.14.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:47:10 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 0/7] binder: eliminate use of vmalloc space for binder buffers
Date:   Wed, 30 Jan 2019 14:46:48 -0800
Message-Id: <20190130224655.255149-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binder buffers have always been mapped into kernel space
via map_kernel_range_noflush() to allow the binder driver
to modify the buffer before posting to userspace for
processing.

In recent Android releases, the number of long-running
binder processes has increased to the point that for
32-bit systems, there is a risk of running out of
vmalloc space.

This patch set removes the persistent mapping of the
binder buffers into kernel space. Instead, the binder
driver creates temporary mappings with kmap() or
kmap_atomic() to copy to or from the buffer only when
necessary.

Todd Kjos (7):
	binder: create userspace-to-binder-buffer copy function
	binder: add functions to copy to/from binder buffers
	binder: add function to copy binder object from buffer
	binder: avoid kernel vm_area for buffer fixups
	binder: remove kernel vm_area for buffer space
	binder: remove user_buffer_offset
	binder: use userspace pointer as base of buffer space

v2: remove casts as suggested by Dan Carpenter

 drivers/android/Kconfig        |   2 +-
 drivers/android/binder.c       | 460 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 drivers/android/binder_alloc.c | 299 +++++++++++++++++++++++++++++++++++++++++++++-----------------
 drivers/android/binder_alloc.h |  47 +++++-----
 drivers/android/binder_trace.h |   2 +-
 5 files changed, 534 insertions(+), 276 deletions(-)

