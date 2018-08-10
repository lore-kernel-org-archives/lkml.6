Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA4C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED688223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO+mdt46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED688223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeHJFtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJFtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so3823941pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UujBK89CgoJitElXDXZXZc97LYy/H1CsZfAuhgxu3cU=;
        b=SO+mdt46bDgSBmGpUhxO12UCrX1FY9oBXhkHwnwh6tQCzOKhttswVS8jcF3Ij5xfdj
         AWTbGVXeT/0OlXXj3YgZp03AxhrMkA0thqmZxE/TTQ2zDWbsJUxvTAhN7tgASNJihujp
         JMgJWUBak4NUPQvNUgoDiakEdA+3RGLmHJZm9w/tuwXGAD7SIpsrb6Pd2vUpOwNF0nt9
         Ru1DxWKooHjarjYoHCnm/WJx+hbwOi1kWdGQMpKQ2irE4ULfaJhQD4FLmATRxlGKLMT/
         O2FFEuK3z4/LHLsRsM3vFAOf0ZqZQai4bzQqFBkZdqsN6eT+T/CNtJvziFqV3z1mY9IO
         PaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UujBK89CgoJitElXDXZXZc97LYy/H1CsZfAuhgxu3cU=;
        b=sBAarP9mWhvQ+CmFuCa6i33woqOpHwa1Yl5i8CqQS/rXsnJ//AcV9FCQSFjCXYBgVJ
         xOkwF8ckbEKUgl01xCkYsaSQv6OvsQAGFn3nCjvLwmQYbtBf3+uVrryH56CU/mhmgQGn
         THKaBHXGUaI3Pp2LYjB8YcnUcp88DYoUKfvutLHTgmmQXd7RdQ3owr6JhmCXK6FPJ+Zj
         ctQpdTzYSPsRxuVeyJUgO9gUYbkgeY9s7fbHnD0vIE43qR68NvoqIVyQsvgO25r9USSu
         BctC61Ecm0LTdH4zsGb6r0pxHPjcqgarSdvy+CYw7FcvOqpLsdZf1K2+k6dX8/aoMYmw
         +PsQ==
X-Gm-Message-State: AOUpUlEJPYCj1slnV8AVIRKjTYgdC99/41VfPhmGoHrw+DL1JmiXcfey
        j/SILfbLDwVekjfnyVD8Zk0=
X-Google-Smtp-Source: AA+uWPz9e8+I/7FD8CmlvdPvXDAiNUHqOmA+Yumr8dgFk3Eq1VGGzd3XrrZVzGqOCfGjmNa5SU2ASg==
X-Received: by 2002:a63:4d06:: with SMTP id a6-v6mr4523690pgb.408.1533871282960;
        Thu, 09 Aug 2018 20:21:22 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:21 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/16] staging: gasket: return of the son of cleanups
Date:   Thu,  9 Aug 2018 20:20:55 -0700
Message-Id: <20180810032111.197743-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove extraneous memory barriers, refactor PCI-specific code in prep
for platform devices in the near future, general cleanups, and make de
facto maintainership official.

Todd Poynor (16):
  MAINTAINERS: Switch a maintainer for drivers/staging/gasket
  staging: gasket: core: remove debug log that could crash
  staging: gasket: core: fix line continuation indent in
    gasket_alloc_dev
  staging: gasket: core: remove kobj_name param from gasket_alloc_dev
  staging: gasket: core: remove ftrace-style debug logs
  staging: gasket: remove gasket_exit()
  staging: gasket: page table: remove unnecessary NULL check
  staging: gasket: page table: use dma_mapping_error for error detection
  staging: gasket: core: switch to relaxed memory-mapped I/O
  staging: gasket: page table: remove extraneous memory barriers
  staging: gasket: core: factor out generic device add code from PCI
    code
  staging: gasket: core: factor out generic device remove code from PCI
  staging: gasket: core: rename lookup_internal_desc to be PCI-specific
  staging: gasket: interrupt: refactor PCI MSIX-specific handler code
  staging: gasket: interrupt: simplify interrupt init parameters
  staging: gasket: interrupt: remove unimplemented interrupt types

 MAINTAINERS                                |   2 +-
 drivers/staging/gasket/gasket_core.c       | 138 +++++++++++----------
 drivers/staging/gasket/gasket_core.h       |  19 +--
 drivers/staging/gasket/gasket_interrupt.c  | 105 ++++++----------
 drivers/staging/gasket/gasket_interrupt.h  |  24 +---
 drivers/staging/gasket/gasket_page_table.c |  24 ++--
 6 files changed, 124 insertions(+), 188 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

