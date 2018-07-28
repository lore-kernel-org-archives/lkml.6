Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E5C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C474320878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6CijKcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C474320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeG1VBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 17:01:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42268 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbeG1VBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 17:01:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so5067249pgp.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vH/JZSp/UfZvLbKKO03VZYYeLHxRCFnX6zIqywk0vSI=;
        b=F6CijKcLNi5RAM03j6NNol7rRarcHP/FIPpaEYaSA0TEOaUhdLXA9OzJe3gEWDUD+v
         oIVwJ4hFORUUms6Cg45ygrY0abuv8be3pLdxtubUEBzA0d3xp2T/Am8wvGhaSWd9zTAw
         JZHvva5/t495GsJ/klhZHQl/9ckGYo+DSR7JXjqyeI4t54Wu77HU6aIEAdGynrnAZ5Qz
         opon7iliZrE9wFB8vfB9YKRzeMS46SP3Sy4Iy8BcIFjwtE3gszymBUwSwy/eUbfAHXJo
         tNl2W3ngmlo9+1F95doqusXWlnkYijMDrwwYOzIaMi5Dm42uoSGvt4dwmtV2Pbp8rO6N
         ukWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vH/JZSp/UfZvLbKKO03VZYYeLHxRCFnX6zIqywk0vSI=;
        b=HiSC1n3K6QqSNF67QYWsFLFPKVrr7nPdzfuYs6MnxT0+w07LfaFvG4AqxgjOyANUD5
         QjkVeWs6ps+QzHqYOErGUKQlYB4oWIAeG3h1iez+uMJXhg6Q3kvS1Qdu0pimAN/MYhhE
         gKA+227J2GMVt1HnSvioVaX/0Wf3nSAaYMlFuGWFkWSchoFwNzYyOmK0G5I8rvzK4ZcL
         4Yt6yHyWpYPolFH/RCD3drv+hKuDZdxODDiWu6NdAabt/O6cVt7cbxZAC8K8n9PR4rYe
         UJyQeQLbT9ZeSFTwVCEb+FunIHTkzSLtaX3yzB42MzlLMuA35ycA9TFJxbmWHS4Az8JA
         N5pw==
X-Gm-Message-State: AOUpUlGtjlksQCThpLrkmevJ+nH2fGbBgJJ6mRKW9cz+5Z1MD7aE+Jgx
        ft4IkDW9DWeGZKc5EFlpChg=
X-Google-Smtp-Source: AAOMgpftFgY/pzp/cGX7zHbDjduOpPXS1N9Jh7IEQEufp6MS1kSEObv79HG1funaN4KHLFgf6FzpSQ==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr7848109pfg.42.1532806459891;
        Sat, 28 Jul 2018 12:34:19 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e16-v6sm9607483pfn.46.2018.07.28.12.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 12:34:19 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 0/1 v2] staging: gasket: fixes and cleanups
Date:   Sat, 28 Jul 2018 12:33:23 -0700
Message-Id: <20180728193324.142821-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The fun continues with gasket+apex: remove dead code and unnecessary
stuff, fixup apex PCI class for devices that advertise class 0
(undefined), and make sure the struct device doesn't go away on us.
Most of these from review comments of previous patch series.

Changed patches in v2:
  staging: gasket: core: hold reference on device kobj while in use
    Renamed: staging: gasket: core: hold reference on device while in use
    Use device get/put functions.

Removed patches in v2 already merged from v1:
  staging: gasket: sysfs: remove check for refcount already zero
  staging: gasket: apex: fixup undefined PCI class
  staging: gasket: sysfs: remove unnecessary NULL check on device ptr
  staging: gasket: page table: remove code for "no dma_ops"

Todd Poynor (1):
  staging: gasket: core: hold reference on device while in use

 drivers/staging/gasket/gasket_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.18.0.345.g5c9ce644c3-goog

