Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2852AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7CE206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9IMtv7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7CE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeI2MRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34681 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeI2MRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so214930pgs.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xaTIHnBx9nGQAitv4LjbDYDAae72H66pyrlVCxGapGA=;
        b=S9IMtv7hnjaeY8h//I9X4VSLRH8y6+x4asMn1p7S52NEy8CvhPp1lH1+PsCi8N8y/j
         wj8eV93GA4KXjogrwMq+ajoGLi6utuVahRsoNsrgyJP1ip2W3KBrWhDTuXB0FXhkRGBt
         IlbgDUZBD3G4jlgt34GAs+NsQp9RDuyHY8Ewk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xaTIHnBx9nGQAitv4LjbDYDAae72H66pyrlVCxGapGA=;
        b=SKODnGtyzWf7UoYh7KJk0flO9JPIonRlEDBEhVYcU5fwXMs0joeHdXKa0jeW6Ez7wA
         J+1gq6pVnZT0+gpOSKL40eD6zcfK/HvuIiNr+Pzqb5ZC7mOJjhX8VqVYCHsmUBbYbmLh
         r+tO3T8KUkwwhsTp4uuU6NjC3O64E8ct+EB3L39q70I83R80NeMAhxRTjfhMs2EIB6WA
         BSTiR5Jm/ydCbUY7rXF4pDod8trFT+/yekLuX4i7K0EtrZpeaYVg9N2ChGO3yMHAUVIn
         bG4Bs1lLIB7ApPYNeF9TGmqo+SkMHy9LdEwHJkC+24A1fk/r4MGPE8aP7bfNg6dRnXiq
         371g==
X-Gm-Message-State: ABuFfojRZBmaOvuzBjQvVSgICGETiYvR7Sb9Ej4guQdeWnrfC45K1pjf
        6zGcYhLFKv0uQsQVgePDNtn0Sg==
X-Google-Smtp-Source: ACcGV60Xh+6b3YeOTLISPP+rJvGbFpF3BveZmc9vlGPQQJ7QNKYvCb+sMW9l3B7LPOU777wfnY3MPQ==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr1733705pfl.67.1538200198553;
        Fri, 28 Sep 2018 22:49:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.49.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:49:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Add some fixes and new feature for SPRD DMA 
Date:   Sat, 29 Sep 2018 13:48:58 +0800
Message-Id: <cover.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes the direction usage from struct dma_slave_config,
and add one new field to save the direction. It also fixes some issues
for link-list transfer. Moreover this patchset adds new 2-stage transfer
support for our DMA.

Baolin Wang (1):
  dmaengine: sprd: Remove direction usage from struct dma_slave_config

Eric Long (6):
  dmaengine: sprd: Get transfer residue depending on the transfer
    direction
  dmaengine: sprd: Fix the last link-list configuration
  dmaengine: sprd: Set cur_desc as NULL when free or terminate one dma
    channel
  dmaengine: sprd: Support DMA link-list cyclic callback
  dmaengine: sprd: Support DMA 2-stage transfer mode
  dmaengine: sprd: Add me as one of the module authors

 drivers/dma/sprd-dma.c       |  152 +++++++++++++++++++++++++++++++++++++-----
 include/linux/dma/sprd-dma.h |   62 ++++++++++++++++-
 2 files changed, 194 insertions(+), 20 deletions(-)

-- 
1.7.9.5

