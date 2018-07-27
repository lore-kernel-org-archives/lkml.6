Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF545C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B3220673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXbojf4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B3220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeG0E1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34618 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeG0E1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so1692225plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B06caSY6eZuqn5Y3Axx4VzBac4YEufOZejntHWM8dpY=;
        b=DXbojf4hd4kvqY21TPWhrfWNNdBEula7QroDQhbdb5fPlm1h/NiNT/1rXTDLh/kaKO
         zcmSAjmx+zm7S455CypNCeWi71+k8K04mKqRrausu67/S62tE96qT6AnNrc9bjB4I+26
         M/YuVVWi1v9Tv1SwPLH3XEHI3U7MnM0bPY85RKw7a35LnGutrPa+ZZZp48jcCrDVwY9K
         /90f6Fe65/R7+RZsRJlsDH5I9onffDt8ED1p80iGb8rcTfYpOeMErsbMswZSYHMMI29u
         VNgGT0fCKMiv8jxoDVgpH9gRIEL2mjMTNvaGJXS37DHoFkdpj1+qhiekt263Va1ngcxI
         7s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B06caSY6eZuqn5Y3Axx4VzBac4YEufOZejntHWM8dpY=;
        b=c+4E2HioZfNp4y/fWoUG6L4i3tlyXfO56Bc3gCPff6ODE+UnM4J2vErOv88xgn4wL3
         x2owuHGyRwKZRhLMz6nNJQqQ7l6wZbg3aWQ++HS0aLzjQb/aZfM7dLJpUrT886usGA+B
         /6PjWwt2s3aNK5EqdFA5CUSUQebyNwue2eaWZcgG/2oIQDSqXXDNN5Pupib4eZASii9h
         5FxlOtY3q3U+LeXBuhIQPa4eCJFBEsJyGKQYbY3L69xnTvlJ8U/aHZTnE+gzlnkk20w4
         ZKBrxuqdbSxOZA84MheZ2OjvolHA0flTmMCtjzB24LA+KBU57777TZGFaDoZBm5AITVC
         9BHg==
X-Gm-Message-State: AOUpUlFU3aMS66uCSUI5allxwxjSmJmZpt7E5WRAgGmGJd4pEUcJQ2Aq
        iSdW04rmx4Ga3Zg8DvATBfM=
X-Google-Smtp-Source: AAOMgpdsT7vV+cNa8/tzzc8gykkwMzISMgLQ6sxCW0RdtPzCUXHdWE+Yba808PYBU/Datdk4wum6Jw==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38-v6mr4337331plg.107.1532660882870;
        Thu, 26 Jul 2018 20:08:02 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/10] staging: gasket: logging cleanups
Date:   Thu, 26 Jul 2018 20:07:27 -0700
Message-Id: <20180727030737.231268-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Kill off gasket logging functions, convert to standard.

Fixup a few formatting/style problems in the process.

Todd Poynor (10):
  staging: gasket: save struct device for a gasket device
  staging: gasket: core: convert to standard logging
  staging: gasket: interrupt: convert to standard logging
  staging: gasket: ioctl: convert to standard logging
  staging: gasket: page table: convert to standard logging
  staging: gasket: sysfs: convert to standard logging
  staging: gasket: apex: convert to standard logging
  staging: gasket: remove gasket logging header
  staging: gasket: TODO: remove entry for convert to standard logging
  staging: gasket: don't print device addresses as kernel pointers

 drivers/staging/gasket/TODO                |   1 -
 drivers/staging/gasket/apex_driver.c       |  61 ++---
 drivers/staging/gasket/gasket_core.c       | 300 ++++++++++-----------
 drivers/staging/gasket/gasket_core.h       |   3 +
 drivers/staging/gasket/gasket_interrupt.c  |  67 +++--
 drivers/staging/gasket/gasket_ioctl.c      |  23 +-
 drivers/staging/gasket/gasket_logging.h    |  64 -----
 drivers/staging/gasket/gasket_page_table.c | 131 ++++-----
 drivers/staging/gasket/gasket_sysfs.c      |  73 +++--
 9 files changed, 296 insertions(+), 427 deletions(-)
 delete mode 100644 drivers/staging/gasket/gasket_logging.h

-- 
2.18.0.345.g5c9ce644c3-goog

