Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7265EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CE921476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjYGfAb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CE921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJRQwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:52:42 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36095 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeJRQwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:52:41 -0400
Received: by mail-pl1-f182.google.com with SMTP id y11-v6so14015749plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UoDp5ziy2YWPuhFFinrp1ys3HavPewk+G/9nhItihJc=;
        b=jjYGfAb55aQik4JFruYVKGfYyJG/s9lRHsScYM+teMMyLvY4nQLn5zlq76y/dIEz3D
         MREzjuXrEZDVYraNW2rEz+AdMsWDZAYcJeYS/fGqKQsOo7UoYbdeW8Op/paqdrZhjTq9
         cFcbtYYToKt/CrzwaZRonFOlIqnxV45DH396g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UoDp5ziy2YWPuhFFinrp1ys3HavPewk+G/9nhItihJc=;
        b=WFltow1JLZ0UoQNMusChpCJtE7ADRykhg09lc50tUEF7b3TtG07BtowQgKQyYIXgry
         KOVSvxooJolnORarsd0n/aJj7oO5LlNwCawGdYFOU5prVxRPkbgL6RZRxCjBaYeZRAC6
         q+HB0oXOeR/IiS/M2LIJ4KLijKjQEMg0DrJ1p5HrlNNjIEgFlKgmD4Wyb/NC43NQzWJn
         AZI1LfwVOiRoePPW3ILs3HOpRSzS/pMzPOxxKdD60EulvvfUEAwv9XJWv/9figPuyhJt
         TYl7f0dj8/z2JPBEfVbuTrni9G+utVcxM/r+Ff5ZPWRAWpq2wOU9Sd2+mh3Uf+Zv8wpc
         X8SQ==
X-Gm-Message-State: ABuFfoi9l8lijg89uIkZh2i7eN2ewUZ75SclwGMNr3hpgoZThq86GLyj
        hdaw/DsPM0hHZpr3VXArsypZ3Q==
X-Google-Smtp-Source: ACcGV63fcwFj6oq+Y2UrUhKbulOajrJuhZPRd/le8B3VhxTU0nZY2NvfzeRw+K1p6ECqOI3nGdKC+A==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6-v6mr28318794plt.19.1539852763205;
        Thu, 18 Oct 2018 01:52:43 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x186-v6sm18467528pfb.125.2018.10.18.01.52.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 01:52:42 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 0/5] Fix some issues for RTC alarm function
Date:   Thu, 18 Oct 2018 16:52:25 +0800
Message-Id: <cover.1539851865.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes some issues when setting one RTC alarm.

Baolin Wang (5):
  rtc: sc27xx: Set wakeup capability before registering rtc device
  rtc: sc27xx: Clear SPG value update interrupt status
  rtc: sc27xx: Remove interrupts disable and clear in probe()
  rtc: sc27xx: Add check to see if need to enable the alarm interrupt
  rtc: sc27xx: Always read normal alarm when registering RTC device

 drivers/rtc/rtc-sc27xx.c |   60 ++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 20 deletions(-)

-- 
1.7.9.5

