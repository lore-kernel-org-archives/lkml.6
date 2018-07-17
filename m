Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B6DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjmACTas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E8F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeGQCjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:39:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34033 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeGQCjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:39:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id k19-v6so1849616pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h5IRMPUaWAzVSBNiOUtTXkE/LepgPEybRZUmRX0BGUQ=;
        b=BjmACTasKq7hr5Arxh86+tDl623Osq8q+lgf8YDqrECNrDvtqNPdbgMdzVKXsieLij
         QulBNKHVmZHUAi0XgH4yZceZt9K8nrp5P/flBq09cb6X3lykStijciIVHzfPdf0/9nPQ
         c21wrtzC1Tx1kz72v2bwJph+H7626FIZqYrqqTEPx7wPB6g86a8lcJmG465qSsOsoFXV
         A2ZwZwrbESD/g70Xx5lqDSzGN3A21Zn7Wa5dDvPYwCg9OHBS/kbCoWOtmOY1/Mtm+xIS
         6G+rwtHV9d7KcG6VwjyOdNAhk+20zFM3ihdG2sPxprD41CJg/EqbyYusIwuMcDepBy3U
         ua7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h5IRMPUaWAzVSBNiOUtTXkE/LepgPEybRZUmRX0BGUQ=;
        b=du2doyBgyT1E408c1LPwEKEGjoamb5txeGbicHYmFKbNnUmyCnEqRt1Ep4PFyVWEHI
         dIT2+osYkG8gmJSwqGjTdt8E3mff7mvNVN2FpFE6Ry3nUsWtKoObyz5Xobvle4T/Y0LU
         Fy4czTU2I4AGmmjraeccSJ/X1kEVW3Bg+3t7WUn0xt1RTsVEwuT38x07Q+PbubRqFxgK
         8s0xx0ZurCt/nLPCjsrGC9iO0zG7PGmtwn4WLWpoxjTuqLsp4cHlbBrK+EAjPCEHm2lp
         +PjxCdTZogIjquu6XWcygUjTRmvPBoFVNGsu4G9XQA3375Y5JFtKdrir5uXeVjUX4O/m
         O1mw==
X-Gm-Message-State: AOUpUlGWkj9eq+oDOWYFA8Kr+Im5KgRqjDkHAJ+lz/akLoPx0sAu0/U1
        SO9Q2OIq3V5wiBD+YPs8FrU=
X-Google-Smtp-Source: AAOMgpdsHF7xKL6la133IT4Gd4lXTmxAN9wBQ9poXW2HqzhwAcmjj0IDo4MX5bokhiuYgciEbs4exA==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr20338284pfo.151.1531793376848;
        Mon, 16 Jul 2018 19:09:36 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:35 -0700 (PDT)
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
Subject: [PATCH 00/32 v2] staging: gasket: sundry fixes and fixups
Date:   Mon, 16 Jul 2018 19:08:54 -0700
Message-Id: <20180717020926.176408-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Various fixes mainly from the chromium review of the gasket and apex
drivers.  More to come.

Various (32):
  staging: gasket: remove X86 Kconfig restriction
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
  staging: gasket: gasket_wait_with_reschedule return when condition hit
  staging: gasket: gasket_wait_with_reschedule use 32 bits of retry
    count
  staging: gasket: bail out of reset sequence on device callback error
  staging: gasket: drop gasket_cdev_get_info, use container_of
  staging: gasket: always allow root open for write
  staging: gasket: annotate ioctl arg with __user
  staging: gasket: gasket_enable_dev remove unnecessary variable
  staging: gasket: remove code for no physical device
  staging: gasket: fix class create bug handling
  staging: gasket: remove unnecessary code in coherent allocator
  staging: gasket: don't treat no device reset callback as an error
  staging: gasket: gasket_mmap return error instead of valid BAR index
  staging: gasket: apex_clock_gating simplify logic, reduce indentation
  staging: gasket: apex_ioctl_check_permissions use bool return type
  staging: gasket: gasket page table functions use bool return type
  staging: gasket: remove else clause after return in if clause
  staging: gasket: fix comment syntax in apex.h
  staging: gasket: remove unnecessary parens in page table code
  staging: gasket: gasket_mmap use PAGE_MASK
  staging: gasket: remove extra parens in gasket_write_mappable_regions
  staging: gasket: fix multi-line comment syntax in gasket_core.h

 drivers/staging/gasket/Kconfig             |   2 +-
 drivers/staging/gasket/apex.h              |   7 +-
 drivers/staging/gasket/apex_driver.c       |  79 ++++++++--------
 drivers/staging/gasket/gasket_core.c       | 105 +++++++++------------
 drivers/staging/gasket/gasket_core.h       |  11 ++-
 drivers/staging/gasket/gasket_ioctl.c      |  91 +++++++++---------
 drivers/staging/gasket/gasket_ioctl.h      |   4 +-
 drivers/staging/gasket/gasket_page_table.c |  67 +++++++------
 drivers/staging/gasket/gasket_page_table.h |   8 +-
 drivers/staging/gasket/gasket_sysfs.c      |   4 +-
 10 files changed, 177 insertions(+), 201 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

Patches changed from version 1:
  staging: gasket: typo and whitespace cleanups
     Split into new separate patches:
        staging: gasket: whitespace fix in gasket_page_table_init
        staging: gasket: fix typo in gasket_core.h comments
        staging: gasket: fix typo in apex_enter_reset
  staging: gasket: device registration error and unregister fixups
     Split into new separate patches:
        staging: gasket: remove driver registration on class creation failure
	staging: gasket: hold mutex on gasket driver unregistration
  staging: gasket: sysfs mapping creation fixups
     Split into new separate patches:
        staging: gasket: Return EBUSY on mapping create when already in use
        staging: gasket: Remove stale pointers on error allocating attr array
  staging: gasket: gasket_wait_with_reschedule fixups
     Split into new separate patches:
        staging: gasket: fix gasket_wait_with_reschedule timeout return code
	staging: gasket: gasket_wait_with_reschedule use msleep
	staging: gasket: gasket_wait_with_reschedule return when condition hit
  staging: gasket: gasket_open use container_of()
      Replaced by new patch:
        staging: gasket: drop gasket_cdev_get_info, use container_of
  staging: gasket: always allow root open for write
     Add Reviewed-by from Dmitry Torokhov.
  staging: gasket: gasket_enable_dev fixups
     Split into new separate patches:
        staging: gasket: gasket_enable_dev remove unnecessary variable
	staging: gasket: remove code for no physical device
  staging: gasket: fix class create bug handling
     Add Reviewed-by from Dmitry Torokhov.
  staging: gasket: gasket core error handling fixups
     Split into new separate patches:
        staging: gasket: don't treat no device reset callback as an error
	staging: gasket: gasket_mmap return error instead of valid BAR index
  staging: gasket: various cleanups
     Split into new separate patches:
        staging: gasket: apex_clock_gating simplify logic, reduce indentation
	staging: gasket: apex_ioctl_check_permissions use bool return type
	staging: gasket: gasket page table functions use bool return type
	staging: gasket: remove else clause after return in if clause
	staging: gasket: fix comment syntax in apex.h
	staging: gasket: remove unnecessary parens in page table code
	staging: gasket: gasket_mmap use PAGE_MASK
	staging: gasket: remove extra parens in gasket_write_mappable_regions
	staging: gasket: fix multi-line comment syntax in gasket_core.h

Patches dropped from version 1:
  MAINTAINERS: Add maintainer for drivers/staging/gasket
     Need to arrange a positive handoff from existing maintainer, not
     available now.
  staging: gasket: fix deadlock in pci driver unregister path
     Wrapped PCI calls broken, needs a rewrite.
  staging: gasket: don't release coherent mappings
     Not necessary.

Patches unchanged from version 1:
  staging: gasket: remove X86 Kconfig restriction
  staging: gasket: convert gasket_mmap_has_permissions to bool return
  staging: gasket: bail out of reset sequence on device callback error
  staging: gasket: always allow root open for write
  staging: gasket: annotate ioctl arg with __user   
  staging: gasket: remove unnecessary code in coherent allocator
