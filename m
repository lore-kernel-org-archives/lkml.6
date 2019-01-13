Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E918C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 01:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2305420870
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 01:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXrDy2zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfAMB3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 20:29:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfAMB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 20:29:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so7913691pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 17:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHGDyuTxc9/abX5ce55OaQWjD+QodmhVpe4Eesdnt50=;
        b=IXrDy2zIE+pZHaDqwvvnJ5YlHbb4ASN8uBJ34EsAuWwACAr/k2vMROvclDvHV+cO/t
         c8c8ypS1ugw2pW/yG1hcoOyxKwfnSvpqB8URQ49v332zxBmSmvfPgWLLDw7LrEa4BeAI
         iF1JEXx00VWtJdOTdcsQNEXKah9wSxZtFvRlEG8FAftfAtEDc2a+E16Fcy7lDLvko9+s
         H7pWoLEBqGXhpjDrrQXLski4ZrB8E2zUQnad73zqezcootFhRcqv+9u7uJgM8Sx26xib
         7Vsl5SX6AXXX42DRE1yUrJti8pOc0itNefRLdY+RnRUJ7RvAPRVgigjm7FDkL/tpWkVY
         Z76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHGDyuTxc9/abX5ce55OaQWjD+QodmhVpe4Eesdnt50=;
        b=SAJnNIJZaYDfkuMx3JMKddWw8labZJcvY/wSbozrAcNkSWH3/7jVSgtTo+dGhyAgf6
         wwf/g1Mdr/esrBh281fikRP8P6738BiMQ22R6sDUqA4BWL9Ng4QQqiSPpqajRoQg6RWf
         O+rhRHgPJyz/L1dwKgAZGq+ew4Dv8V8VhNIhj3MN1U0vC7H2axRDSakKQtko9sJ7NAkz
         kiwGubeQ9rSLcLA0XPlN+1EtpvjUs/+bxcTZGd4xDw1+S5UTwAsFdZbGOO7n24wqRV4p
         AgZELhJ58M0AjIBBFM9+6FHa/+kDUPsXxirj8eSptEUJrC+F0RODfAbKGfDPuK7po15N
         VMuw==
X-Gm-Message-State: AJcUukdduA1hDA6M8BUe9DvcuYqH9+Q+5fohuIH9l7m3sxrwEdIw8e4+
        r+m7hmiyVAiQOn6Y0RVj+YmQJlqJ
X-Google-Smtp-Source: ALg8bN4vtjoLzJpBv2vIt2C9xIWC5sD4ihxZ9V9LqCnqzF8A/IyDMnV+84mB/7vqILZWMUcAMdx4kA==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr10610093pgk.21.1547342953425;
        Sat, 12 Jan 2019 17:29:13 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c7sm165360529pfh.18.2019.01.12.17.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 17:29:12 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/1] PHY_MODE_SATA build fix
Date:   Sat, 12 Jan 2019 17:29:08 -0800
Message-Id: <20190113012909.11986-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

Say, I just ran into this build breakage on today's linux.git, and after
checking the email threads, I do realize that PHY_MODE_SATA is about to be
added as part of [1]. However, I also noticed that it was not identified
as a build fix, nor did anyone notice the potential naming conflict. So
here is a patch for that.

Please feel free to merge, reword, discard, etc, as you see fit. :)

[1] https://lkml.kernel.org/r/20190108163124.6409-3-miquel.raynal@bootlin.com

John Hubbard (1):
  phy: fix build breakage: add PHY_MODE_SATA

 drivers/phy/marvell/phy-berlin-sata.c | 5 +++--
 include/linux/phy/phy.h               | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1

