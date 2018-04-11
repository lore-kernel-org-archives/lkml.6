Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359011-1523421750-2-8270817727555703459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523421750; b=ZMbtv6E2juYFZqVB/zJx+MqsT3bQJA1bWJRAVy+OvWYCa+09CM
    1PIs7J1b4vZ/KnJCEZOV2SrDa0DDAmFJn4jYPaz6DysYQmLXKlmTVRHHpAOK134s
    GNDccY7BW3mLGcyhS6AM9gN4+cjEDs7F+lGnPr8o3l22EXtO/qI+asSZKlADSFxP
    kpeC0fh5AennguG+5gGoKR1tm4Y1fiHWWn9LiNLpMcmvfgmkc5Xf+I3rnaj4+oKa
    MU2sFXq0Pwpv5doUbtpmu74wdSZ84n4RgIlTgXizLizIfBzGxwDGmlxRg6TxVqEx
    ZJaFR8LtOWN1VC2Grzxit8CSzHPdWqDnpTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523421750; bh=t41SIZ77TenOTSivCUBNZRO4XROInq
    e3IoobaTZ9I+Q=; b=jA5Fjpu2u9nSYnRHmvAhpUbLMfLx0lIE3VJwYVSRDoF1FV
    4RxkKCiPqg4cfAPbSF8R+knW0Bnb0ObKWal7P6WgQ3nfIdVk29pntp1Do3R0AIZL
    l5/Y5gtVpCMsQMNNsZy5/4Jlp44KAOJLZOvnBqRHtw8ZDAPPoa8XKIssHg6k0n3U
    KJqWuEoRi9k9rfUJFJ7CM8LqvAN8GUF08DMH41dnr37PY8/oXUxqxDP9ET4NrVfU
    ybRx3BITLb4jZqCBYR6a85MmbWnxAcbe0W9taKCuuek1GMEVaeN7T/IKwIgyeeIw
    sWOds0kvVhe44S2fAWmjurkaoLK/bnCtxGgtsKjA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qBK3GWwW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JlmjKkvU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qBK3GWwW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JlmjKkvU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJMCo03yY4oWWCuNM9/eoc5ChAhbafl8SnNZpF8A0Nvhe1Hg61XcmiNENAGpKiFkXEeOY6LjOYNXnH+92H4CzVqYLLF+FlZDyCyI1xA03+SfTgKFtOQa
    eHJxyokZ/vBcnoX9YcLhmfmdmwVJF3uwJzgHoxygTr9OE8LEhZ//+tHZCoDgTP5QJ/ca+4qeG32tb9dCWnYyJJic3vMkCxCP/D9G1mYSET3O3+ZHUp/ozXyq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=unD1LOn5OY8A:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=i3X5FwGiAAAA:8 a=VwQbUJbxAAAA:8
    a=xzggyvzsH1h99LZFOeMA:9 a=mmqRlSCDY2ywfjPLJ4af:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbeDKEm2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 00:42:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42157 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeDKEm2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 00:42:28 -0400
X-Google-Smtp-Source: AIpwx4/KY4WH3UMMujzrh+pZlwIWnhLlnRrE4AQs3VEuK57wTjgbmf57irf+dUo6AvbgWh3iDG3srg==
From: ianwmorrison@gmail.com
To: rodrigo.vivi@intel.com, anusha.srivatsa@intel.com,
        michal.wajdeczko@intel.com, gregkh@linuxfoundation.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        ianwmorrison@gmail.com
Subject: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
Date: Wed, 11 Apr 2018 14:42:13 +1000
Message-Id: <20180411044213.383-1-ianwmorrison@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ian W MORRISON <ianwmorrison@gmail.com>

As the Geminilake firmware is now merged to linux-firmware.git
use MODUE_FIRMWARE to load the firmware.

This removes the error message in the dmesg log: 

    i915 0000:00:02.0: Direct firmware load for 
        i915/glk_dmc_ver1_04.bin failed with error -2
    i915 0000:00:02.0: Failed to load DMC firmware 
        i915/glk_dmc_ver1_04.bin. Disabling runtime power management.
    i915 0000:00:02.0: DMC firmware homepage:
        https://01.org/linuxgraphics/downloads/firmware

and now shows that the firmware has correctly loaded:

    [drm] Finished loading DMC firmware i915/glk_dmc_ver1_04.bin (v1.4)

Cc: stable@vger.kernel.org
Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/gpu/drm/i915/intel_csr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/intel_csr.c b/drivers/gpu/drm/i915/intel_csr.c
index 41e6c75a7f3c..f9550ea46c26 100644
--- a/drivers/gpu/drm/i915/intel_csr.c
+++ b/drivers/gpu/drm/i915/intel_csr.c
@@ -35,6 +35,7 @@
  */
 
 #define I915_CSR_GLK "i915/glk_dmc_ver1_04.bin"
+MODULE_FIRMWARE(I915_CSR_GLK);
 #define GLK_CSR_VERSION_REQUIRED	CSR_VERSION(1, 4)
 
 #define I915_CSR_CNL "i915/cnl_dmc_ver1_07.bin"
-- 
2.11.0
