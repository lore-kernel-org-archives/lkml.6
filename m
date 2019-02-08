Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3ACC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FCD20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="hBT/z/76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfBHSfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:35:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:35:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so1951115pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9WvWdlKBYFiXlexhPu3lOfNDGodM1BFnWy67D6pFdM=;
        b=hBT/z/76g050Kr8dYcROw4e6L/EK8eYWe17enjOE2gsEg4rLaUyHVdtyIbATzVx0ap
         DejCp7Xxdf6wuK/Vss5Hb4PlriYX1qg27Zjtrf60fn6LAJyek/AsZHOm79553Pctve+x
         ykg+Ga4rSWhetCNqx78ifMrgAwnn7h0hByf0YneRuquOuCsIHKDvee8afkIhOYJY8mf2
         d5/OE/X+syZYx/fok+rPRAsCYieVdUbqjKAz+Z4admuLyLXRDmLWisTuk1DsmsnKGOPE
         CokREvLCQX2ADvmMqC/KhB08H26sxZKa9kbw+7FgGKD3hevoAy94NQ9CuGZyEheHjJ3+
         mNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9WvWdlKBYFiXlexhPu3lOfNDGodM1BFnWy67D6pFdM=;
        b=Ji86hhVHwQgufUPgsxbbZrjQdtmVuOKoyduAJkiWyzv8bbjjX+vurh1/K3se8sauLm
         QJB6KNqo1OYbbZHfg3rcLkJSa6HGakCQ2IvT4JYXgjDlqqI05fOCr6eLP8+hyjmLE6zq
         Qmv7fs5XfzEa8Ea+yqu7lX4fMsAZi+83Z1B56NGxwCP6jRizG0M3uOB2azuvHn7F4KQd
         yB2NEAPknDv/u4Jn7n+k5GnS2/7ic9Epo7oR4sC5gdr1b3yvHSleBmfIHEjv0RTh16uO
         NHctXi3JgM4qDZGIN+08Yjtd1uFrsuDNG9R6Ct5pIAQyPMsfosqltdMbZ2RWFIB+229P
         QRGw==
X-Gm-Message-State: AHQUAuZfake4TUIaJgmqv6J2FoUOj1Y0LLT3lvVEUTc3WES/HA+ZXiJR
        N5M5cT64Fdv3YavGi/8I6/Keag==
X-Google-Smtp-Source: AHgI3IafmCDzPwiMylBgZkudCKf3CNDyxcmxN3uo8w959y+MKDZJzG86tmNRtXnXyYB9bStRNIFU9Q==
X-Received: by 2002:a63:7f46:: with SMTP id p6mr21716993pgn.54.1549650937276;
        Fri, 08 Feb 2019 10:35:37 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id 14sm2306472pgq.22.2019.02.08.10.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:35:36 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 0/7] binder: eliminate use of vmalloc space for binder buffers
Date:   Fri,  8 Feb 2019 10:35:13 -0800
Message-Id: <20190208183520.30886-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
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
v3: fix build-break when CONFIG_ANDROID_BINDER_IPC_SELFTEST enabled

 drivers/android/Kconfig                 |   2 +-
 drivers/android/binder.c                | 460 ++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 drivers/android/binder_alloc.c          | 299 +++++++++++++++++++++++++++++++++++++--------------
 drivers/android/binder_alloc.h          |  47 ++++----
 drivers/android/binder_alloc_selftest.c |   4 +-
 drivers/android/binder_trace.h          |   2 +-
 6 files changed, 536 insertions(+), 278 deletions(-)
