Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BEDC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C713D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C713D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeIJT6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:58:51 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40991 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeIJT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:58:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so40719462oiw.8;
        Mon, 10 Sep 2018 08:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xxRNCX3AaKi4QWh7oBGizaPAWtftQeBgmxx2yRMWe/c=;
        b=uC/zUsKedaK/wF7V7qt5biDBmNyTdTgiQRSMTd5azteEcE/Dljc+SIYngfp0ju1dZJ
         0qA9azoeyXQUqeBTNINYSlHBzqhibFM+ohXek7hExlPAKpKh6m89oeZniLcs29yw1T7j
         0BxkL+JMUxBFD1Q1DIs2Yrncdzay5Jlfh40wgvTOSSX+iTkOP8EvY0plOoPGJGdkO9Ds
         9wJvq3tojhlgwCs7gtRg72EU/6GcFGGCbviLS/HwVRgzMCyvK7iP1rlNajHHh5nVr4/C
         l44kqhayi8C1jBq+H6IavZaXcRztb8fHli0CyCuPYVvW5CUSIfqW+T199VL+MdtDdLvQ
         JjmQ==
X-Gm-Message-State: APzg51AbouanDumw6gjV/1OkwrENnG1oMlDpDTKdqOFBrNqqZ2yC+XeW
        msfepqTl02edxamOOE88dEJ3k4w=
X-Google-Smtp-Source: ANB0VdZJSGLyNOG4/UTY+CyhxFLre+/ugpNx8f4SCHxGCxF9nP3W/uDYuQ/ixgrrOH8/opVfyE8iEQ==
X-Received: by 2002:aca:3110:: with SMTP id x16-v6mr23782576oix.126.1536591858924;
        Mon, 10 Sep 2018 08:04:18 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm49465631oiy.2.2018.09.10.08.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:04:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 9/9] microblaze: enable building all dtbs
Date:   Mon, 10 Sep 2018 10:04:03 -0500
Message-Id: <20180910150403.19476-10-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910150403.19476-1-robh@kernel.org>
References: <20180910150403.19476-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for microblaze. As microblaze only has one dts
file, always enable it.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/microblaze/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index fe9af267f598..c7324e74f9ef 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
+dtb-y := system.dtb
+
 ifneq ($(DTB),)
 obj-y += linked_dtb.o
 
-- 
2.17.1

