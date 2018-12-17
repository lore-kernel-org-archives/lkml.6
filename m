Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBAAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5063C206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUypuhIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeLQSCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:02:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33098 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732555AbeLQSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:02:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so11564643eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T7l7BVRnzlqjIwGlI7Zf/tC6iOuBumbWEUoTBhudCHQ=;
        b=WUypuhIY0jt/y5dmIHmJ4MArNRYA+VHChTR2IWFgVHbrfiqcdpEEOas29qtTCn6WMJ
         bP5bs3IYDjLfoVV1S5JvBKD36/U6V8wv4E72i5mnn+7rLhYXRwS7qfVJvSzxUtdF8Szd
         WvyuzeKjesMmHrNetYz+C52vsEayIeF56qxhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T7l7BVRnzlqjIwGlI7Zf/tC6iOuBumbWEUoTBhudCHQ=;
        b=UGdxDeI2muhbFb9AufUaZioea2dxAERGWugBKOso5rS0eFNXNiL9uPCkNrokrlMX1O
         cXT6U5zJNV34R9kaZed3WE+xGKENr7EGAmAJfzOdhIYsHvWK4sT+Pa5iIM3p5sZjIYw2
         ueWbYTeBMsSck8jsTKpdcbYsP9Hgz2EZq0kR/hODg5XBTwo3fud3fhtm2CoG7ay/MbPq
         hvRbabMm1hZETlSqQwF0x1FN7xd7IAck7tF8fKP+iislzwYeuzM7MzyZk26fwo6MxTwA
         EwY5ldgT6NKGJsKffsJrD2NbJitpfCFpHuTLNnyn7aloOe84lpebWuRElQT7GE0yCabq
         JUEw==
X-Gm-Message-State: AA+aEWZDjtk/2e60TWzs6RvHAnR7Td/8M4NfeH8S2si1o8R8SKdb3Utv
        rKuA8FH3MI3/UnLeEZ0/R6HDOw==
X-Google-Smtp-Source: AFSGD/UTczZ4AM3ixQnXoZnDNKTK+MHuvghflG04oif2Gs1WRcy7LFt7ib9QfDOYfPYE424S2A4jeQ==
X-Received: by 2002:aa7:d817:: with SMTP id v23mr13715516edq.255.1545069737823;
        Mon, 17 Dec 2018 10:02:17 -0800 (PST)
Received: from mba13.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id j8sm3947678ede.55.2018.12.17.10.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:02:16 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, Qian Cai <cai@gmx.us>
Subject: [GIT PULL 0/2] Final EFI fixes for v4.20
Date:   Mon, 17 Dec 2018 19:02:12 +0100
Message-Id: <20181217180214.9436-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 7b671e6a4917594a4e9ffd64111b8ac2e0323837:

  efi: efi_guid_t must be 64-bit aligned (2018-12-17 10:42:26 +0100)

Note that applying Qian's patch will result in a conflict with the EFI
changes queued for the next window - the solution is to simply drop the
kmemleak_ignore() call since it is not required for page based
allocations.

----------------------------------------------------------------
Final EFI fixes for v4.20:
- prevent false positives from kmemleak for persistent memory reservations
- use the correct alignment for EFI GUIDs, preventing potential crashes in
  firmware calls on 32-bit ARM

----------------------------------------------------------------
Heinrich Schuchardt (1):
      efi: efi_guid_t must be 64-bit aligned

Qian Cai (1):
      efi: let kmemleak ignore false positives

 drivers/firmware/efi/efi.c | 3 +++
 include/linux/efi.h        | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
