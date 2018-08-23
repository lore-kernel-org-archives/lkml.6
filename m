Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D21C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA13208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hNgJiM14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA13208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeHWIAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:00:55 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:37752 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeHWIAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:00:55 -0400
Received: by mail-pl0-f51.google.com with SMTP id c6-v6so1823166pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XdYtr6eLvwK/1kG57Yrs+I/W2nzB5QJMcn2suQPEt4Q=;
        b=hNgJiM14FGM5H82bGBJNDmaaXhLLD9OqnfSREeFphH3yr3rWgfSTUarS7YTqtmUiBt
         TYy313lSI7jvtnZ5JmoIkJUII7NuYR/2xI60322NpiD6+sZC1t6jiwJZtQb3o/5VnoMm
         3kQi35AgOE93BMaoN89yu7HFJfGLFuHSMgJ8aOLyZWFd4zcne4FmKMSwD7R3Nhcw+HQA
         JtBbkNUJAigtGhdSkVK5llbrq8fO+PH222dlbwQ3l7EUdBDjW6EUOBtu7Z2arEe3+N8E
         6SfRENv5F5j/BSgP8ynAoxUwe9YX/6hNUwpIPcun+l64MdRVGwLoob8CkN9HN2qQvwbB
         +mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XdYtr6eLvwK/1kG57Yrs+I/W2nzB5QJMcn2suQPEt4Q=;
        b=cMC4e2G7KBgqY/AEz6bqkc7SqlN2ScCZ+TVge7pF/TUL+GGUc7Fcja/rfPKIeadzCJ
         OTuXcwAEA7I2JTCeD8C9O4Qm7EL08n4vxhEHrvfufpw/oOfkb4Kv3xe5goRde7/f7Gq2
         AwPGHh2pcbOwa0Bbo+lvCNNBgGpqFVA7g6b19eq50BjRX5D0OJ/zN/EQ4FKKo/WrmeJl
         uQU1fxlNyw1v8JpiPPhTPSD7eCp+TE5SMVtDfGnlzofGgKDzFb54+1IQsl21cHoDebc4
         xTgdkgEbXVDwBHk3K4Rt6XtyjKn5SzjvM3UyYzy0e6ZkT12rTRV4kVSoQ8wJXfkMzSvx
         QwXA==
X-Gm-Message-State: AOUpUlF8RKL8pe2+ihejb0pajQYYLsjOGWWGuMKOp8Gs2UJIBpmxcSlo
        xy/MeN76R3rZ6DPz7dzPBsD1f6h3ffibdQ==
X-Google-Smtp-Source: AA+uWPwNyyXkwkeUs6uitv62P9MBZNU8kVVcO7hzBl2fD9SIBPf4ZFLCeCTsh4be8rcSDzyVpk7xFA==
X-Received: by 2002:a17:902:a502:: with SMTP id s2-v6mr17780607plq.311.1534998791322;
        Wed, 22 Aug 2018 21:33:11 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 70-v6sm4859947pfz.27.2018.08.22.21.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 21:33:09 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] ARM: SoC/platform updates
Date:   Wed, 22 Aug 2018 21:32:53 -0700
Message-Id: <20180823043257.18582-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another medium-sized batch of ARM updates this release cycle. Not a
large number of new platforms in this release, but there are a few --
from Renesas and TI in particular.

790 patches this time around, 173 authors. 26531 lines added and 13363
removed -- very close to the size of last release.

A bit more detail in each pull request, but this is overall a "business
as usual" release this time around.

Please merge!


Thanks,

-Olof

