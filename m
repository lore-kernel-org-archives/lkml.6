Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D853C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E451621534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xiz276Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E451621534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeHTMRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:17:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38372 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:17:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so13050048wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=nQBzKJck+kngX2NaivWZl5yC416WsrdkJcbbu2ezTGI=;
        b=Xiz276IxWUCLJzTKfFqBxVMBVwEI/C62Zemr4+Q7jRFkF6+VcWyWhTI8ATn/YyjX5u
         wXiiERmwPXP92Om3qjvtuaKqWV2EJjotBfLIwHad6A9S63kEckBctC7E9NbzN6CXZvGt
         hroFSM1KwQDpUS5McQntDqa0JJ+pBB+E5vARM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=nQBzKJck+kngX2NaivWZl5yC416WsrdkJcbbu2ezTGI=;
        b=G48eqbWNXktJd6imkre6cQUVe4RovFecN80J3QVyCIcudP5AFYSE5uZNTBvRcavuum
         eh5WrV+VjHjGUa8FW2xerlB1JGt7086e463g4wbrwtvFJv8x+PztWLHdQ6cobyi74vTZ
         u+O68QuWlp6bN9UrzroAXW0WjVQfbdlyRIaN1K5N5I6s98f+N8ULgl7G65ESKQtgpqor
         tdFIzSdc5sM/hcEgOwfk9Fy7MSzxMQo/vu6zF06kGK/5r/CkSPgN7gDsasZPejWjKfv5
         rHmOarLfbeLnYaFftFkrjL2Ddp9mKrOjYqtQ0zqjgP4+kT9YrTI3kuKCIvZah3avSOXN
         lvAA==
X-Gm-Message-State: AOUpUlFPR7HvfO/7dfdQt8N7bPK3YxwpVFeLVtCz3aKIuoBnKb74yiwA
        90zJjjVHhlaMfht85PFpG/bPxzBzisg=
X-Google-Smtp-Source: AA+uWPylYrNnTvgP3/oYJW9mBKRN98/NGiW0nicoDPIHEuN2Vbv7HMz1eD5bjs33Tr6MvJaDeRWVrg==
X-Received: by 2002:a1c:4143:: with SMTP id o64-v6mr26655667wma.123.1534755732155;
        Mon, 20 Aug 2018 02:02:12 -0700 (PDT)
Received: from dell ([2.27.167.102])
        by smtp.gmail.com with ESMTPSA id d33-v6sm12882648wma.16.2018.08.20.02.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 02:02:11 -0700 (PDT)
Date:   Mon, 20 Aug 2018 10:02:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v4.19
Message-ID: <20180820090209.GU10054@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Enjoy!

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-4.19

for you to fetch changes up to 633786736ed53a53b8d0a630cc3ff57381027081:

  backlight: pwm_bl: Fix uninitialized variable (2018-07-25 09:09:59 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Remove unused/obsolete code/comments

 - New Functionality
   - Allow less granular brightness specification for high-res PWMs; pwm_bl
   - Align brightness {inc,dec}rements with that perceived by the human-eye; pwm_bl

 - Fix-ups
   - Prepare for the introduction of -Wimplicit-fall-through; adp8860_bl

 - Bug Fixes
   - Fix uninitialised variable; pwm_bl

----------------------------------------------------------------
Daniel Thompson (1):
      backlight: pwm_bl: Fix uninitialized variable

Daniel Vetter (1):
      backlight: Remove obsolete comment for ->state

Enric Balletbo i Serra (4):
      backlight: pwm_bl: Linear interpolation between brightness-levels
      dt-bindings: pwm-backlight: Add a num-interpolation-steps property
      backlight: pwm_bl: Compute brightness of LED linearly to human eye
      dt-bindings: pwm-backlight: Move brightness-levels to optional

Gustavo A. R. Silva (1):
      backlight: adp8860: Mark expected switch fall-through

 .../bindings/leds/backlight/pwm-backlight.txt      |  34 ++-
 drivers/video/backlight/adp8860_bl.c               |   1 +
 drivers/video/backlight/pwm_bl.c                   | 232 +++++++++++++++++++--
 include/linux/backlight.h                          |   1 -
 4 files changed, 247 insertions(+), 21 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
