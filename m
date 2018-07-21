Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7726CECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFAB20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Ew6Qe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFAB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeGUNuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38754 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeGUNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so9021995pgq.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dy99giDRqMrbNrW2XJxOt9w1WLgqfiOyAQX2mpDnwHM=;
        b=f/Ew6Qe0rJLyiaF5FICQC3sWmC1EijeDvGgb8i+rywB5JJzDbQnHbH+ygsJHrglBkF
         dC3vy7JzLh51/Ke2M6w+MTtRL20eSId9ns9cVvoSj5i+3dWc5ckqckr3xWmR/avMob9j
         ltHnJ0nnr2b/d6fIhMFEzSQa9zoPEl2MXg0ZdNpl2eb/dRdmdKS1rJN8C3XrvJsr84dZ
         bM7BRoHqSmU351azb5lAVCj04Tqyy8vRA0sBUxPz9FGQ2QjU5bgyff2UAxtPo/HQfB80
         pd78zB65PXUwArCTJ9JXf3Hi/l/1RrRMlOQoMaw4RMtvzgQfN2y0BnmxSNG4AfdU+k0T
         W/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dy99giDRqMrbNrW2XJxOt9w1WLgqfiOyAQX2mpDnwHM=;
        b=cx7vbIzvrPsP/Fs4Bw0UiGOYp7TpWfKp0agbbOjB4IlNR8s34UIjtVOP9ZOZUIuf1+
         9twlG+9gB6QN+VL6WTy+hH5UNtd59A71Ij58eObZr+jDFigBkwCms/8WDVv5/jld/5KP
         2au8iYKYtEJK7sAo1vOK/GIS9z8KjIovUlhMDKdRWHqhYdnV0mCwbYxRH/Rm0ijvfCMl
         18jHYU+HTQqusD4pjuc8qA7ANohLw0m7WPdcOk8cH6U3raH5nqg1+U0zco+De6LAK3Rg
         0S9mzTRhd3j+vUd3v3wcgBPxNtcXUaXpVUxGiFvYxEJhTiOc4eZHguGZ+bgXfAxYUPY8
         rWYw==
X-Gm-Message-State: AOUpUlGlZFMbjHTvvRRgTlJQu3m+ktxwkw9nDd/rLKIofXIYPa3fTBQV
        vAPAYfBXK8mKL2aWSQVQQG8=
X-Google-Smtp-Source: AAOMgpcdt9b32jvEXztoaKoUVe98wDs0pkKdQTrFrc0KlaB8Porn4NGSY/GntBIW+G/nSBBU/coIBQ==
X-Received: by 2002:a65:48cd:: with SMTP id o13-v6mr5365578pgs.99.1532177852982;
        Sat, 21 Jul 2018 05:57:32 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:31 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/14] staging: gasket: assorted cleanups
Date:   Sat, 21 Jul 2018 05:56:39 -0700
Message-Id: <20180721125713.88501-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Various fixups arising from the chromium review of the gasket and apex
drivers.

Todd Poynor (14):
  staging: gasket: fix check_and_invoke_callback log param
  staging: gasket: remove duplicate call to retrieve device callback
  staging: gasket: gasket_handle_ioctl fix ioctl exit trace param
  staging: gasket: avoid copy to user on error in coherent alloc config
  staging: gasket: print mmap starting address as unsigned long
  staging: gasket: remove unnecessary NULL checks on calls from VFS
  staging: gasket: gasket_get_device drop check for NULL pci_dev
  staging: gasket: apex return error on sysfs show of missing attribute
  staging: gasket: core: convert various logs to debug level
  staging: gasket: interrupts: convert various logs to debug level
  staging: gasket: ioctl common: convert various logs to debug level
  staging: gasket: page table: convert various logs to debug level
  staging: gasket: page table: remove unnecessary logs
  staging: gasket: apex: convert various logs to debug level

 drivers/staging/gasket/apex_driver.c       | 14 ++---
 drivers/staging/gasket/gasket_core.c       | 63 +++++++++-------------
 drivers/staging/gasket/gasket_interrupt.c  | 24 ++++-----
 drivers/staging/gasket/gasket_ioctl.c      | 19 ++++---
 drivers/staging/gasket/gasket_page_table.c | 35 ++++--------
 5 files changed, 65 insertions(+), 90 deletions(-)

-- 
2.18.0.233.g985f88cf7e-goog

