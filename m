Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F122DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDDF20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UutYxaP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDDF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeGTEf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:35:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeGTEf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:35:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id b17-v6so24524pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aDOFQqhaUBlxGtNUq0oX0Of02aFtPN3imLAHPdQR2P4=;
        b=UutYxaP/wwO4wJOBZDFwRunwruQ0XXe54hvi118gghGkOnk9tzlyui4PUxdn+EoY5n
         gIdYKG9BLs4/W7BZzdfOv//kk0lQgMuQ2BmIWv8/dP91Sn+tQeLVxTWjBsMxnlPM94+C
         wrojs+LhiE4BBbuSs8XcTCZowlj1UuAbXzI6UrtQhPuGuSKeX0/k9TncPr6fzXH+Jrqd
         BvV45B3nYrlE9Lvv1hQxN5hVHu/3/uqKNEFrnNAG5nPo7weTJotZQqLOdii45V/lmoz8
         glQtUHo+qOEFMp4t8fc+mRAJy26SbSMebpSuxbTg/2JVpwdkgzYhnLi2EIbJ9+BfNxE7
         Vdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aDOFQqhaUBlxGtNUq0oX0Of02aFtPN3imLAHPdQR2P4=;
        b=Xsqz36JW+s1Kh4OAgNJQdnHzL5qKBBycSLQ3v3cxDJcACKfJmRmLgHWRMan1j0Vnfg
         w+N4LhcSnwDE4i9Q+Auy/+cYou6nbhh2u6MRaso7O8deDI9jSS1VLv6WNCRbpxLvskm6
         GRe4vLAvqBMOyFfdYZLjvfNsWmztn9M7/dbA9a06u5c36cfAEsp2yTtW+LOKAyu0WMLZ
         ztGFVU2wUZffSs9c6o8L99FPIo4YPm+YCBBiQ8B06belPNEcGe5jHVokhm26dbsVKxEs
         Nl8xR1GenvkzarBW4E3mYTNHVD3d5eXqV1+hee8go+WeRiSZdghmF4pCQIdGIHENqpVs
         mvsA==
X-Gm-Message-State: AOUpUlEI0fuLQLfsdqyaTir66GMBWERsgXpGHKACCeOKQQt7uk7THQTY
        PsGLHSkwn9tOiwWp8e5jvRY=
X-Google-Smtp-Source: AAOMgpeQjcEsPYgDqNG71r1ZLwxzOueoN5BZqiykG5Cgh/xI5AluW+O567JIzoGdz1iaCdn9InQFEw==
X-Received: by 2002:a62:4f5b:: with SMTP id d88-v6mr432057pfb.225.1532058588174;
        Thu, 19 Jul 2018 20:49:48 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:47 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/20 v4] staging: gasket: sundry fixes and fixups
Date:   Thu, 19 Jul 2018 20:49:00 -0700
Message-Id: <20180720034920.77320-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Various fixes mainly from the chromium review of the gasket and apex
drivers.  More to come.

Todd Poynor (20):
  staging: gasket: allow compile for ARM64 in Kconfig
  staging: gasket: gasket_enable_dev remove unnecessary variable
  staging: gasket: remove code for no physical device
  staging: gasket: fix class create bug handling
  staging: gasket: remove unnecessary code in coherent allocator
  staging: gasket: don't treat no device reset callback as an error
  staging: gasket: gasket_mmap return error instead of valid BAR index
  staging: gasket: apex_clock_gating simplify logic, reduce indentation
  staging: gasket: gasket page table functions use bool return type
  staging: gasket: remove else clause after return in if clause
  staging: gasket: fix comment syntax in apex.h
  staging: gasket: remove unnecessary parens in page table code
  staging: gasket: gasket_mmap use PAGE_MASK
  staging: gasket: remove extra parens in gasket_write_mappable_regions
  staging: gasket: fix multi-line comment syntax in gasket_core.h
  staging: gasket: always allow root open for write
  staging: gasket: top ioctl handler add __user annotations
  staging: gasket: apex ioctl add __user annotations
  staging: gasket: common ioctl dispatcher add __user annotations
  staging: gasket: common ioctls add __user annotations

Patches changed from v3 in v4:
  staging: gasket: remove X86 Kconfig restriction
     Rename: staging: gasket: allow compile for ARM64 in Kconfig
     Restore existing "depends on" for X86_64, add ARM64.  Only compile for
     64-bit architectures known to work with this driver.
  staging: gasket: always allow root open for write
     Fold in patch to convert apex_ioctl_check_permissions to return bool
     Convert gasket_ioctl_check_permissions to use bool types.
  staging: gasket: apex_ioctl_check_permissions use bool return type
     Folded into above patch.
  staging: gasket: annotate ioctl arg with __user
     Split up into new patches:
        staging: gasket: top ioctl handler add __user annotations
	staging: gasket: apex ioctl add __user annotations
	staging: gasket: common ioctl dispatcher add __user annotations
	staging: gasket: common ioctls add __user annotations
     Convert various uses of void * to actual type.
     Minor formatting and naming changes.
     Drop Reviewed-By: Dmitry Torokhov due to changes since review.

Patches unchanged from v3 in v4:
  staging: gasket: gasket_enable_dev remove unnecessary variable
  staging: gasket: remove code for no physical device
  staging: gasket: fix class create bug handling
  staging: gasket: remove unnecessary code in coherent allocator
  staging: gasket: don't treat no device reset callback as an error
  staging: gasket: gasket_mmap return error instead of valid BAR index
  staging: gasket: apex_clock_gating simplify logic, reduce indentation
  staging: gasket: gasket page table functions use bool return type
  staging: gasket: remove else clause after return in if clause
  staging: gasket: fix comment syntax in apex.h
  staging: gasket: remove unnecessary parens in page table code
  staging: gasket: gasket_mmap use PAGE_MASK
  staging: gasket: remove extra parens in gasket_write_mappable_regions
  staging: gasket: fix multi-line comment syntax in gasket_core.h

Patches removed from v3 in v4 (already merged to staging-next):
  staging: gasket: fix typo in apex_enter_reset
  staging: gasket: fix typo in gasket_core.h comments
  staging: gasket: whitespace fix in gasket_page_table_init
  staging: gasket: remove driver registration on class creation failure
  staging: gasket: hold mutex on gasket driver unregistration
  staging: gasket: Return EBUSY on mapping create when already in use
  staging: gasket: Remove stale pointers on error allocating attr array
  staging: gasket: convert gasket_mmap_has_permissions to bool return
  staging: gasket: fix gasket_wait_with_reschedule timeout return code
  staging: gasket: gasket_wait_with_reschedule use msleep
  staging: gasket: gasket_wait_with_reschedule simplify logic
  staging: gasket: gasket_wait_with_reschedule use 32 bits of retry
  staging: gasket: bail out of reset sequence on device callback error
  staging: gasket: drop gasket_cdev_get_info, use container_of

 drivers/staging/gasket/Kconfig             |   2 +-
 drivers/staging/gasket/apex.h              |   7 +-
 drivers/staging/gasket/apex_driver.c       |  73 +++++------
 drivers/staging/gasket/gasket_core.c       |  44 +++----
 drivers/staging/gasket/gasket_core.h       |  10 +-
 drivers/staging/gasket/gasket_ioctl.c      | 144 +++++++++++----------
 drivers/staging/gasket/gasket_ioctl.h      |   4 +-
 drivers/staging/gasket/gasket_page_table.c |  64 +++++----
 drivers/staging/gasket/gasket_page_table.h |   8 +-
 9 files changed, 174 insertions(+), 182 deletions(-)

-- 
2.18.0.233.g985f88cf7e-goog

