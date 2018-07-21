Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE21CECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A7720856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KutdL7W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A7720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbeGUO2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeGUO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so5632249pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GXdc6u+IzEX5Ndq/51FAOicJSpdB7RyBtOx5MkBkKcU=;
        b=KutdL7W2nJeNV7ZAMxge8QMMke20pCR+O2ynLL6xQCrpuD5nFGPsNTtIa7KUggZGN6
         +subMMbdMCL6YIv2Nf4963GhLdc7Yhg9c7XPK6oO9wh2QjTAz4AfCAZv/ebF/Vp3er92
         g4hkbkDcPjGdBtIyxuVzr8+v3ggAb2ljthQv0GxDNACDUDvne1twLb4AcpAEgtD4sJ8P
         qd2C4VgC/EAx3PExIEqthYs93zGLR3WYXwgSDTvybUdBKzocWqdPw9cP/Ff2lj1WAMWb
         w+RkhKi6MdSMrPoYnVMGOlWO5Bz+1BGCeUBCzBT/iFXjcCy+WgN+ncn/YiSOaNOI4ql1
         askw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GXdc6u+IzEX5Ndq/51FAOicJSpdB7RyBtOx5MkBkKcU=;
        b=miYkJ3upP/9tJDIZ957Gou2GwMcTbW5jMzv0I7EjIEivKSGGHqMpQizKYM8I2GRz+p
         FtgLHgCVe28A/7tnuiqvIC16ZTNl6EZQsdVfPTBCYnrEKeLsy9oQE67O/IwBl8JgjjVD
         Kp1EelY94aPUn6j8gfyTP7M1dmCgFNczki4AXJ5e3Ob7paLL516xlcIAO5DgM0w3nX2m
         TWeF6tUM7szcjVVp/YVYaghQ9BrqAe1PI9gc/jWGTLPd7bGkf+NA+xT7NZZR0fpTRfvX
         v2LZfn6TzQBqm9oNgwBNV8QFpdPnMfw3wEIkG1M1C7yw3eEqj5E1Zx016ZwggjwynK1q
         37bQ==
X-Gm-Message-State: AOUpUlH2aGpRHP8zHZpl8oOxFvbeNaONZOrwOlGjJJ3j0SjXYJS8SAEi
        t6srnBsOqFRnZXYJWvvQxAI=
X-Google-Smtp-Source: AAOMgpdMhwS+5HfFdqJIfkEp+X6QxV9ZOxfo/DfksNfR6Y4JxkyP476C/evR37I/gIW+0i5sqpriyQ==
X-Received: by 2002:a63:c44a:: with SMTP id m10-v6mr5707769pgg.416.1532180119804;
        Sat, 21 Jul 2018 06:35:19 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:19 -0700 (PDT)
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
Subject: [PATCH 00/14] staging: gasket: more assorted cleanups
Date:   Sat, 21 Jul 2018 06:34:53 -0700
Message-Id: <20180721133507.95599-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

More fixups arising from the chromium review of the gasket and apex
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

