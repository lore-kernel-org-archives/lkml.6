Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C08C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0737120857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxipq8Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0737120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeG2VIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45485 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2VIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so3554524pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cluzv5xzwX0QZZeOSadTMX6VO+DnDP8/Fhzx+s1NtPU=;
        b=kxipq8SqMjZzjO5Txq8THYzBhpVS1f6SDKyizPl8HJE7ufQ/+f2A53EkGpoLtjeTJS
         tgs+tAEHSvxn9LWN4OPxhiA/3p/Zp9y+NQ0oEu/pNDOpxnc0EM59gAwHMuc/J5wWGKSd
         1tDXqfFgJFuk/aHmkUTBEqNIYN8c0X86C/dcXM+/6n9FDkLhU2vdnshHe0JT0f2NnlBl
         3IteDRVsBg8MIO1xeazc7uOvsUppwq1cC56Dzptk8GUp9zuFnmKaXe3PGf5b9606Rlcv
         AJdN6so79qcccwO6++g5GBpCjnJPPufn9Rp8ofaIfHvLtxKqdA1g/tHXyW8YRgZgzrN9
         Rixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cluzv5xzwX0QZZeOSadTMX6VO+DnDP8/Fhzx+s1NtPU=;
        b=Yk7btsqMJso2+YzAQbyJEJwJ8nImnDbeVNtvWDMLjwQZdg1w2P02FMlcBF4SMSvBPy
         //FY0tM980WHRn2qRwTm2A0vVUhPLKhFknqiB1wlaeE+L8eOCpKE+JelITM5boGZVlEs
         iQP89O0ZBDF0QF3WU+RFx2vtbP9u+rL3h7hSI2/hkjqPB8KG2GDJS1oVoX2jvZgCk6se
         mQE1dM1CxQ6btLg0JddRla+05mC51pqj16KQ2SjO0cpVxVfjA2jVXyDRCsaS1LS39FW1
         aPWYrxIWP/ocb1KaJVcmq5EjXxABgj65iRmzaR9WeVkVcgoqm8LMKVlBIBlTK8ey0zBR
         rIgA==
X-Gm-Message-State: AOUpUlHGJCFTqy4xipAfWlniJlzkSgnixBGKaKgxEE9npLdyg5y4Bg+d
        7kDRJ0Y0cE/yGPVm/xz9Wds=
X-Google-Smtp-Source: AAOMgpdqOTmgNQLwMBdZ4vnnTivIxmBPuQFNrdv/gfr9dL+YiXAkonv3DAf3McydAQYCO9nXGz1meg==
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr14146458pgh.216.1532893018241;
        Sun, 29 Jul 2018 12:36:58 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:36:57 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/13] staging: gasket: fixes and cleanups
Date:   Sun, 29 Jul 2018 12:36:33 -0700
Message-Id: <20180729193646.201721-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Fixes for device reference counting and root access based on user
namespace for containers, plus cleanups of comments, forward
declarations for static functions (more forthcoming) and multi-line
continuation style (more to come).

Todd Poynor (13):
  staging: gasket: core: hold reference to pci_dev while used
  staging: gasket: sysfs: hold reference to device while in use
  staging: gasket: page table: hold references to device and pci_dev
  staging: gasket: core: allow root access based on user namespace
  staging: gasket: apex: simplify comments for static functions
  staging: gasket: core: simplify comments for static functions
  staging: gasket: ioctl: simplify comments for static functions
  staging: gasket: page table: simplify comments for static functions
  staging: gasket: interrupt: simplify comments for static functions
  staging: gasket: sysfs: simplify comments for static functions
  staging: gasket: TODO: remove entry for static function kernel docs
  staging: gasket: apex: remove static function forward declarations
  staging: gasket: apex: fix function param line continuation style

 drivers/staging/gasket/TODO                |   1 -
 drivers/staging/gasket/apex_driver.c       | 559 +++++++++------------
 drivers/staging/gasket/gasket_core.c       | 165 ++----
 drivers/staging/gasket/gasket_interrupt.c  |  18 +-
 drivers/staging/gasket/gasket_ioctl.c      |  51 +-
 drivers/staging/gasket/gasket_page_table.c | 329 ++----------
 drivers/staging/gasket/gasket_sysfs.c      |  39 +-
 7 files changed, 350 insertions(+), 812 deletions(-)

-- 
2.18.0.345.g5c9ce644c3-goog

