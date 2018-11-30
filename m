Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E7920868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="evOp1YEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E7920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLAFxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:53:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40991 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:53:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so3220740pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IuJG8dqyGAPZbgMnZ9OXctTPnx97qwSN4XjbKObGexY=;
        b=evOp1YEz9bNcj27Qjdr7AK2/3VXM3M83NXM6p3a4hNTQrYk3uphVDJ5vQYWJAbW58I
         qvjC1ST4z8lDBprY84VxlxCvjXZBBkLm9qUlQqnAn9t0KQD5hjqseF9Z5DGl3H56DrN3
         xNC4tTxEdrisNYXG32aA/kxrqbwteJrJ0piqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IuJG8dqyGAPZbgMnZ9OXctTPnx97qwSN4XjbKObGexY=;
        b=OQBxbj3qpSQqeUGFvGJY1IMEhTPRnHPBoiX7iKHqW1oetaSlsAsCLuxMjFV8ZM6VGw
         pbdRScNTgZUMurYmNt4uzhLdyska6W94EcjBqgntWNzlQjb7eku5VAH8gKHUDEhCYRyk
         QTzDdyUr7xpYDoCtJeHiMnaczh0QlAs3kkBHlFcwxULL3HueYvBKvJVXOpnD8l5d4g/F
         owLrNQwO33VS7grw973Lt8E854MTKkTqnpVzbfDKq6pJ70tAN8aNTn0GfPQNEXpFv3T4
         qCLlIUTaqB7i6CHJokx/jeJJ9IrGc1V0euUdTarsr9lzVHdXt/zMsw48MUPAO1G0A6TX
         QONQ==
X-Gm-Message-State: AA+aEWYr1X2tfNcuFyQf3uw5uxN3nGYJHN+UPONCTu23+4g4CADHaI8R
        WX+9BDERay/EEgv9u452lN5DgILYolU=
X-Google-Smtp-Source: AFSGD/VEia0xMGQNzik1oNGvDUgxjWWTTJkn0J9iDHXdyMh2a/5WSA7BYxtU6F+Eu32f9OB/3eedpw==
X-Received: by 2002:a62:f907:: with SMTP id o7mr6560772pfh.244.1543603389173;
        Fri, 30 Nov 2018 10:43:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 10:43:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] coresight: next v4.20-rc4 
Date:   Fri, 30 Nov 2018 11:43:01 -0700
Message-Id: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

Please consider the following patches for inclusion in 4.21 cycle.  The set
applies cleanly on your char-misc-next branch (b5570ca7c475).

Regards,
Mathieu

Colin Ian King (1):
  coresight: fix spelling mistake "deffered" -> "deferred"

Leo Yan (1):
  coresight: tmc: Fix bad register address for CLAIM

Mathieu Poirier (4):
  coresight: etb10: Add support for CLAIM tag
  coresight: etf: Release CLAIM tag after disabling the HW
  coresight: etm3x: Deal with CLAIM tag before and after accessing HW
  coresight: etm3x: Release CLAIM tag when operated from perf

 drivers/hwtracing/coresight/coresight-etb10.c   | 23 +++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c   | 12 ++++++------
 drivers/hwtracing/coresight/coresight-stm.c     |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +-
 4 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.7.4

