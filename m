Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C97B2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kr/UJNQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393346AbfBOMfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:35:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37821 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfBOMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:35:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so10165958wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atZFuYFI6PCjEKbz744irCb4Q52i0WgYmzqti6jr2VI=;
        b=Kr/UJNQyn/IICTOW2Ft17pyKdLyKTmKmP23y+Yves59ZfRQDV56DzKA7iigfMhQGzn
         si2JpEF8z6Gs0jiMlRVTYIBQ7QkGpHgJtYTr32w/qB5iR3MTJNr/dL6FXuzfSVPlqJLR
         /aQTzyJu4thTM7cfn0biRcY318S9K5jS+x2cUeELVZh0l16xtbEzTXvh62ZUK4oAjT74
         aRRzLdyRLyOxqXYDO02XwRo2Jwp10xiu8g+MFJvMWYMXm3c4zvgpACC5JOW3N1bSwcuy
         XIBk+8ETYUK/k0Uqh1KFioAdF7n9w2OdPtHk98HOhq928uKJR2HzebplFb46umOa4d+h
         NOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atZFuYFI6PCjEKbz744irCb4Q52i0WgYmzqti6jr2VI=;
        b=MYNdk2kngrc8Nlgj7ZTGFwRMJ/bMXwV3uwZc+S9qboeM8InP/dd/ORrJMfCEHwY7il
         MGGqEUq7ZN6XAtmFg376SnIpqenDnQsaCsVzTV6pYW/4EPEP0zsGeR3dDvXAmu2bPplb
         I37sqDxDWusYxMg5fh2Px1CJcZi4HVGokUSsdmecyNPwhQzlIvc3D2zPad7j/523hPp8
         9htVqoS5W6dIdmJg4BCxOPgfSY3RR98GW67PFZdm1+iZXjhe/iEIWHKn8QHJRmkrmuTS
         D/L3QRjXhXOPMlvoxe2wFjss8YFTJerK5bujH/fSqu1qzyrCtRWOX3Ty9PmyDGVqYdwu
         7ObQ==
X-Gm-Message-State: AHQUAuY8NQBBFzNYJZz/Vae/Mgk8JXZRYzJwb1Pp3v9LCC/ICe0BTEoh
        eKKfxzOBFYCTxLXFbNMuJaQ35w==
X-Google-Smtp-Source: AHgI3Ibq2BlsgKDdZGmgtfiPRND2zBxziiTCERtMTvwfPz1Ly0BR0p70PVOWc5Cwyctj28VeKQEEQg==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr6409297wrm.37.1550234109263;
        Fri, 15 Feb 2019 04:35:09 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y13sm636673wrw.31.2019.02.15.04.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 04:35:08 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL 0/2] EFI fixes for v5.0-rc
Date:   Fri, 15 Feb 2019 13:33:31 +0100
Message-Id: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1f947a7a011fcceb14cb912f5481a53b18f1879a:

  Merge branch 'akpm' (patches from Andrew) (2019-02-12 17:15:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 98f19a800ac41cffa72a17b019eaf8160a01c22b:

  efi/arm: Revert "Defer persistent reservations until after paging_init()" (2019-02-15 09:58:04 +0100)

----------------------------------------------------------------
Yet another fix for the EFI memreserve code used by the GICv3 driver on
arm64.

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: account for GICv3 LPI tables in static memblock reserve table
      efi/arm: Revert "Defer persistent reservations until after paging_init()"

 arch/arm64/include/asm/memory.h         | 11 +++++++++++
 arch/arm64/kernel/setup.c               |  1 -
 drivers/firmware/efi/efi.c              |  4 ----
 drivers/firmware/efi/libstub/arm-stub.c |  3 ---
 include/linux/efi.h                     |  7 -------
 include/linux/memblock.h                |  3 ---
 mm/memblock.c                           | 10 ++++++++--
 7 files changed, 19 insertions(+), 20 deletions(-)
