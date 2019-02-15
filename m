Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1611C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1F521924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prQ1yCk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbfBOQz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:55:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53359 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBOQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:55:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so10642474wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhUHOulu2jkoHSRC5+jIXz1MFZIsZ+R9ftGVAOUR26s=;
        b=prQ1yCk+oI43aJlfbRQvh8QYKk98aywQXjf0y/P0AktFhBoR1QPwHD4uZ/ehZflPfr
         r66xuLr9rRDKZWc8Q7hz5RQN75lCMOobUxc8Wk7OD21J/cKzsIukrgi0qYTAfrFkk5mA
         ofdc0m1vQp0k9F4/PTrs5T+ajbNoReDad9jRXXKOn3xzXwhpl350BrSKFMWtAtmVNNyL
         zNPxuB16d6cSYlxjfaltIpHaoIqvperXfL6R0zQ1xujH/oHdHJrtpX/rbi2iwryEWtXA
         M5kbFXth0FuXVwD7GsYAoHyY1pYY1xuce3geALvkxKP1bBII4bZzVtfbjrQnaqX5sHyA
         IQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhUHOulu2jkoHSRC5+jIXz1MFZIsZ+R9ftGVAOUR26s=;
        b=NTsYpQfZybmzo2LCbwJVirEkHUESyvAkJiuY7y7j/cm9VE8diwpB/IFDJRbxMOeYtP
         /wvqNIDz6ts4wydHna5eQzOMubG3xlfYysP+cVKIwoM7tRmWAmbOAej2TVUU1vowUFoU
         9xcjxoVslJvvrTl8CAxUPf2A8EDMQ+iVZv6lbNss7TCJHxw26npQZCaPOw/4/LWqxLqR
         QFN6MviAwSLYr3/0U1fXJOME9pjcxTuLBJWDqJwgllKcqy4fyJq0QNxFv3Qu3Tq0KZFw
         US270S84Ly9swCPGsvwPmOQuEfCPM6BLlVUogWarzyhUQ3oLFbhXgSouO69KI0XwBzCA
         jT2Q==
X-Gm-Message-State: AHQUAuZAKpF8RKnX5dPe+EDHUxB7Z3KLv1fU64YIzfiyYkBxuOVve+xb
        6M1nyRavEACNYN/tf89ge3mhCw==
X-Google-Smtp-Source: AHgI3Ib1k4Y0auct5XOAQuyJNrLaG7Oeim8yw5R/3Plp70nYObcG9xskfyHZQcHTHsyw3l8qM4qB8A==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr7140838wma.147.1550249754814;
        Fri, 15 Feb 2019 08:55:54 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id e6sm8035877wrt.14.2019.02.15.08.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:55:53 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [GIT PULL 0/1] EFI updates for v5.1
Date:   Fri, 15 Feb 2019 17:55:50 +0100
Message-Id: <20190215165551.12220-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 69c1f396f25b805aeff08f06d2e992c315ee5b1e:

  efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation (2019-02-04 08:27:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to 0477e8bf4b038bb4211f41868f62ce2005f7efdf:

  efi: fix build error redeclaration of enumerator (2019-02-15 13:38:52 +0100)

----------------------------------------------------------------
Another EFI update for v5.1:
- Fix a enum namespace clash that may occur in -next if EFI and IMA are both
  enabled (Anders)

----------------------------------------------------------------
Anders Roxell (1):
      efi: fix build error redeclaration of enumerator

 arch/x86/platform/efi/quirks.c          |  4 +--
 drivers/firmware/efi/runtime-wrappers.c | 48 ++++++++++++++++-----------------
 include/linux/efi.h                     | 26 +++++++++---------
 3 files changed, 39 insertions(+), 39 deletions(-)
