Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2302C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0682083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0682083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967308AbeFSVrR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:47:17 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38258 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964888AbeFSVrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:47:13 -0400
Received: by mail-yb0-f195.google.com with SMTP id q62-v6so480721ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D1b452cPMWfxhYWP98VQHWGo0nNdgHczEIl56yxt5ko=;
        b=ijNze42rHFpb9/tmEvlx7RItvVz09ITx28HmGQMnE9yAtFV5d+4bz0aLq4I/4ERdF0
         CCUrvibhWKXd6qPXnclaC136Xxr48ooD7Tf1bFoINDDWU+tQWioIcUxUAyfVRpOR32Sc
         qiR2R6zXakNnTUTi1YUr19uBTTlbx73SMBDyZl+uU7JVqxLuUoR0yI6jbAnhfj0rMXCv
         PrAtHyraYs60eRIk3j8AZNS4Vvj6o0XXorWGoARZ0LljEL9QWl3y3MU74phG3HW7rbJI
         IVpjydtLynDtxGWLuBQw17OjakqFkI26SmSa4taCDBZFOSQIWymHxzRwhDJNFPxANBMl
         JVnA==
X-Gm-Message-State: APt69E3m9IABpvFTLlZKf2LzJCstvoPwVd6+68YimUKmmEUilxbOShU3
        OYiiXNZOo0pG4DVbjWO5ZcHQB1U=
X-Google-Smtp-Source: ADUXVKJjpMTOv1cNfNTe/7iimKIE2M7xv6w6DgOnL6B6I+k7RnOOEgrOkyazqPwfbGIz3VdAhf3Qrg==
X-Received: by 2002:a25:98c1:: with SMTP id m1-v6mr8921871ybo.265.1529444832972;
        Tue, 19 Jun 2018 14:47:12 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 0/5] MIPS: Clean-up DT bus probing
Date:   Tue, 19 Jun 2018 15:47:05 -0600
Message-Id: <20180619214710.22066-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of clean-ups of DT bus probing calls. Generally, the 
DT core code takes care of the default case and arches/platforms only 
need to do their own call if they have non-default matching 
requirements.

Rob

Rob Herring (5):
  MIPS: octeon: use of_platform_populate to probe devices
  MIPS: netlogic: remove unnecessary of_platform_bus_probe call
  MIPS: bmips: remove unnecessary call to register "simple-bus"
  MIPS: generic: remove unnecessary of_platform_populate call
  MIPS: lantiq: remove unnecessary of_platform_default_populate call

 arch/mips/bmips/setup.c                   |  7 -------
 arch/mips/cavium-octeon/octeon-platform.c |  2 +-
 arch/mips/generic/init.c                  | 13 -------------
 arch/mips/lantiq/prom.c                   |  8 --------
 arch/mips/netlogic/xlp/dt.c               | 14 --------------
 5 files changed, 1 insertion(+), 43 deletions(-)

-- 
2.17.1

