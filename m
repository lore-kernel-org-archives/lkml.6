Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F8ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABDB2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdLoqJS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABDB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeKAXoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:44:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47002 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeKAXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:44:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id o2-v6so14343704lfl.13;
        Thu, 01 Nov 2018 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVZgndSiBUt7yiMtAB8gRlYd3Gzye7qmzGWarjsNr1A=;
        b=UdLoqJS+BCWVcW21FiLZSJUASaGqJab4eUrTzDbk/XVO8JuOeZxQc1cc8nTyZXhPSK
         j855dbc58MDqK7FH7RN10fvLFKOjxv0ZUlhoPo7N1QizunpOEeyDBAjaUdK4sZbd1l26
         XOz5v1wmKeP//g8CxKVZmYBlafWCYnlqNArRVSxSQ5Lz9trsdDktRkb3egEsyKfYk8aX
         1an7qGl2hHOnOXAUrDnLPB+b9Nwtyd1F1TkXHZFYbPfuMgtmGh9jbR08jwqhueIvww3y
         TMCAl4kByC8r2w3kKd0o296fTdKlMDs3tWmoyBPRZDanUBY/6ijsD/iVMZGynAHl9s8f
         oRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVZgndSiBUt7yiMtAB8gRlYd3Gzye7qmzGWarjsNr1A=;
        b=hVTtcB6bKALc1STGT7lX82mh2OYzJfLF33bmZ0qhDyKccKQEQf6jkA2SYH/qnFovxA
         YyOpA+DuBu5o5vUBsF8rNtFsmn1SnySB1Rockjb091hBYMz8ZVGfhmQQ3Q6fHGXJOQY5
         5bjLY9PFByhP296/gVkZCczaIKfBuOocglWcNDZ5v65LKxuLl2fjp7JUzILU3+Ns7CsF
         EB2rbe4tho2KiP9J9MuOHsZaxPEghCfbqCLVp/3Z7XBubeLK2KIRig5pxHSE8/gVcTr2
         ALYlwnJ1EPz3FWh6JzGxSUKV+8O4eeBogavFT5b3aR+IUoZ6kNKGhzu+xFttwLzovYPe
         2cQw==
X-Gm-Message-State: AGRZ1gKWQTAMPrSa82wh7W5t14X2EvsDQ8AKQe6FkNlE2VuWo5AcaY4f
        VIFTMP/5rEjCT7FhK9Lxuv4=
X-Google-Smtp-Source: AJdET5dHdne3TTTvQvde2ySEvdXhXGhGN+HRnsy2toDTRLgh443tSthA7fpoxjaVdKLgkQqhlH1n4A==
X-Received: by 2002:a19:cec8:: with SMTP id e191mr4536066lfg.13.1541083247197;
        Thu, 01 Nov 2018 07:40:47 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a9sm404870lfa.19.2018.11.01.07.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:40:46 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 0/5] Implement devm_of_clk_add_provider
Date:   Thu,  1 Nov 2018 15:40:39 +0100
Message-Id: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Tull reported that there might be a great ammount of drivers with
imbalance on clk_add_provider. This is an issue for Device tree overlays
(and also a bug) https://lkml.org/lkml/2018/10/18/1103

This patchset implement a devm_ function of of_clk_add_provider, and
fixes 3 drivers.

Drivers like clk-gpio will be easily fixed with coccinelle if this set
is accepted. (I volunteer, I want to learn how to use it, just seen the
great presentations from Julia).

Ricardo Ribalda Delgado (5):
  clk: Refactor of_clk_add_provider and of_clk_add_hw_provider
  clk: Create devm_of_clk_add_provider
  clk: fixed-factor: Use devm_of_clk_add_provider
  clk: fixed-rate: Use devm_of_clk_add_provider
  clk: gpio: Use devm_of_clk_add_provider

 Documentation/driver-model/devres.txt |  1 +
 drivers/clk/clk-fixed-factor.c        | 14 ++++--
 drivers/clk/clk-fixed-rate.c          | 16 +++---
 drivers/clk/clk-gpio.c                |  2 +-
 drivers/clk/clk.c                     | 72 +++++++++++++++------------
 include/linux/clk-provider.h          | 11 ++++
 6 files changed, 73 insertions(+), 43 deletions(-)

-- 
2.19.1

