Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CABC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9735520869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxKKDNP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9735520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJPTxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:53:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeJPTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:53:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so10773417pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNbqeaNJI2aFKWjX8aT5pj9VmoM05ntVBJxMWecL+GA=;
        b=PxKKDNP3MAuYQnG9Ot/OD3DR8v1NLmtuLNmK8xzxfJSJmx+wZla9/2MKq3LUn0A9kP
         LNntd5IOzFdddgcTk8ikaErkyRoB+pjA//wbM7aHe+pEUCHfbxYMt+M522S8pdo3EdjO
         RQnjhJeVSJbUn4Iv0LtnixY+SJFwx7vUH741Pr2oZj1NB4OX7mF92Jo8TXzwEqJEAGKQ
         UYFrVGTw//yW09D12gO5cPkrmrV445fDvZEMQLbrYeImohc6JfG6Xqm0oKeQEO2kzR81
         rmODSb5DZtl0cQ8+dvPYiRFyFWGghR6k/g+mTUVHKcHB7ZumUS8S7WdoGz7vYM7AGtU+
         VaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNbqeaNJI2aFKWjX8aT5pj9VmoM05ntVBJxMWecL+GA=;
        b=gMTliK477Q1P88py95bgrQI7IfFAkw/aIfvhKKdItPqpDbee6Q5QOR+M3y3te2dYkF
         1yTEQZ9Y4R7J/pdTTjTZzYMpn2NYHdYxfT3qW+wuh16THktm/RFdHv58GRKtg5NDZbIZ
         ae6V8HfAOp3WNXkb0wjKKURBL+3W+eMIrs6Jw/TPbakIoN5Gq+70pEs37EHS6wkW042T
         QSsMwVBULT4sx4pMi7AQn2N80kPCAXxUCPcihjwQ8NR/QGhJNPzKVSM4HImBudjTy7Tp
         LPFhw4hfGM+l9iMoefSmKG+usm6E+GnIFqMKaLEbNiG+ep97Eibv9NDL/HJpiLWxSUrm
         jdfw==
X-Gm-Message-State: ABuFfoh8+sKnzxN/1YnAXBxeZFMtkM/PUfJ5ykcLJgDEbDCnXUzJylFO
        fZpUBwmEeYfIRIbGTpJeveg=
X-Google-Smtp-Source: ACcGV62kayfCVpoPrKwGzfwNap4wSJ5LImWypMm0lGjtFscuKJC/QiWMksJHo5hE7PbEC2tDRKSSLA==
X-Received: by 2002:a63:1e15:: with SMTP id e21-v6mr20002291pge.430.1539691416488;
        Tue, 16 Oct 2018 05:03:36 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id u21-v6sm23028375pfa.176.2018.10.16.05.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 05:03:35 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 0/3] staging: gasket: add DMA direction flags a.o.
Date:   Tue, 16 Oct 2018 05:03:06 -0700
Message-Id: <20181016120309.9082-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add flags to page mapping ioctls that specify DMA directions other than
bi-directional, avoiding unnecessary cache maintenance for read-only or
write-only buffers.

Remove some spammy / unhelpful / inaccurately formatted debug logs.

Nick Ewalt (1):
  staging: gasket: page_table: add mapping flags

Todd Poynor (2):
  staging: gasket: remove debug logs for callback invocation
  staging: gasket: remove debug logs in page table mapping calls

 drivers/staging/gasket/gasket.h            |  33 ++++++
 drivers/staging/gasket/gasket_core.c       |   7 +-
 drivers/staging/gasket/gasket_ioctl.c      |  62 +++++++++---
 drivers/staging/gasket/gasket_page_table.c | 111 +++++++++++----------
 drivers/staging/gasket/gasket_page_table.h |   4 +-
 5 files changed, 142 insertions(+), 75 deletions(-)

-- 
2.19.1.331.ge82ca0e54c-goog

