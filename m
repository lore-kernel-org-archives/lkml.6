Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF30C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AA3218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOAW61hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfBBJuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:50:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45092 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfBBJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:50:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so7441256edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ykzwzO+EY8iCyHwSPvHVZfnW3rj6RldFs9Jehl1QMk=;
        b=AOAW61hVxDEEeWxy+H2+6VdNHJj+xXw4R+9EADNrWiYrLSnYzg8Hld8i2CAWzDnIgJ
         dmrb09Fv0A6BHrWu8bg04b2lxHxluxIu+Mpf6BxsVT+aMFGLlFOFwGd+SoHEK6Cekzwd
         c8KJDO49wJIGVMAHyP1wP1V7aTfkmuFWmZiF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ykzwzO+EY8iCyHwSPvHVZfnW3rj6RldFs9Jehl1QMk=;
        b=rKlVjR2Hv+BdOGA6GItFAOJjoWPOGXJd2zqkBCgpBNoyWL3sPZNFWW1xaCfDKCsk/e
         jOY2v44pArHPn+gqwp/IrD2J9AYObMyR0vhpuZdba7mWat07UJCFmCQjEr5HQ4wh7qDn
         3Zncvv/F0AYZLxoGjVh8gvskJzga5iYB1DHQee1dYjk1oGx02zUhN6tKFSWR3GcmcINH
         SA+qUBGMlVrq4ZFGeJNLPylrW/dv22zkfU8Vx5bCe9uynXfOwENxn+ynHDHloEd2p0yw
         W3r5Lata3c8HlVfOYGcwqN+vogj5eV0cOVM9TpcNJ8+hezrfw2HdZ8Z7hetuWBLRFhKc
         rKBw==
X-Gm-Message-State: AJcUukdbC8J8C5VXLQQ+fdlHBaoZthD5PUCba3dZYj1sf7QR/NZ2UBxN
        yH3jLMRudwYPsThWPQYYueJO/g==
X-Google-Smtp-Source: ALg8bN7WeUWi/qP+IMzK6DEa7hdl3pr++GSuIR640DkygoSsmPSYY+UxuZGYx7iwmgnJt2j8Vy+l4g==
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr42140118edw.114.1549101019695;
        Sat, 02 Feb 2019 01:50:19 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id a4sm59231eje.66.2019.02.02.01.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:50:18 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [GIT PULL 0/1] EFI fix for v5.0
Date:   Sat,  2 Feb 2019 10:50:16 +0100
Message-Id: <20190202095017.13799-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 10faccaef2b72b28961b1917719cf6a39c63f0cb:

  efi/arm64: add a terminator for ptdump marker (2019-02-02 10:44:40 +0100)

----------------------------------------------------------------
A single EFI fix for v5.0:
- Fix an out of bounds memory access in the EFI page table dumping routine.

----------------------------------------------------------------
Qian Cai (1):
      efi/arm64: add a terminator for ptdump marker

 drivers/firmware/efi/arm-runtime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
