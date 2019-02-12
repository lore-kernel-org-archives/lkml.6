Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CCCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB42222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4/K6xFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfBLV4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:56:33 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34661 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfBLV4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:56:31 -0500
Received: by mail-pg1-f170.google.com with SMTP id i130so115363pgd.1;
        Tue, 12 Feb 2019 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5aFTfyB15+fHOIMfNyXpCi95rrmv/hT020hwj7Md1rQ=;
        b=s4/K6xFtQWglZP1KRfRv6RC5npvmdzcOLQ0/LwsB8to76qi/fFGxl3uY38KHhNCwBq
         7lqEH/s/Y81rsTAD0Qoy1gEwUp2HByj8Wq8iNENYNBCLoy9zNBGchvCIrO+1XWT+FzzR
         BP4btfpRl+Vtc8KR5lDFPXMGgSE6VrFVJ9sPTTwoql0+QvVDR/nj8MfNXIjGSLq0Sxh3
         aT+HK/s1YKJXhaYpKIVgy86Mijh0kvHx/qhBwHToAqjKKmFRQuvXlOpZ+vMa933UyjJf
         AOUUI0N3/tNh22pBLo0DeRE0MBW/xBouoeoz3OF7lpVqN1m+1VJO6IZI1Oye6tU3dBOk
         7Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=5aFTfyB15+fHOIMfNyXpCi95rrmv/hT020hwj7Md1rQ=;
        b=mYbxlZUC5h/EHLbPs2nPwbYHfhfXcHSKpz9V2wMuljGJmsDvzlE1+GFqJLn4aeVAhy
         mQ3wuMxYfNROFcNriI/PBFjyEW/gsSU/M2wdB/8hfHM34DoWuSGxs6KVqpqRkIkkKlji
         dXqIrJxG8lUwPjKRFL6ohJcpbkpyXXiKc4VMKW5KdnG8CgGdHhrdhB6lhYlse8p9Qa3j
         2O/z5rb/QMxjYyERhNCWDR5nsUCusNu/I6W6/Nhgrgf0VyYdDB0VXRk4rCcLmf2UvNFK
         ds1SStjfnAXdGiMFdkSf7RYm0Dsh9lRk3lkwKTOLFLVxnaUOrME0ljzQhuGg56H5NWGe
         cZbw==
X-Gm-Message-State: AHQUAubCl72Nzeq1eznV3mP4f18RaD9RO5oye58Du0oxzlnSsAkY4R9d
        D+qNcruCDqVA6KUo0fM+5wTaf0T0
X-Google-Smtp-Source: AHgI3IZsv7o4OiwjG/aNVbApFy1Ozn0J1rOZvzk91URi9mccJq6DcEPmu+5+ZNT4Mnb7Nh4qOpfPPg==
X-Received: by 2002:a62:5687:: with SMTP id h7mr6101869pfj.198.1550008591036;
        Tue, 12 Feb 2019 13:56:31 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n186sm21350795pfn.137.2019.02.12.13.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:56:30 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for hwmon-for-v5.0-rc7
Date:   Tue, 12 Feb 2019 13:56:29 -0800
Message-Id: <1550008589-18228-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux hwmon-for-v5.0-rc7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.0-rc7

Thanks,
Guenter
------

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.0-rc7

for you to fetch changes up to 2a2ec4aa0577ec0b7df2d1bde5c84ed39a8637cb:

  hwmon: (nct6775) Fix fan6 detection for NCT6793D (2019-01-27 18:55:49 -0800)

----------------------------------------------------------------
hwmon fix for v5.0-rc7

Fix fan detection for NCT6793D.

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (nct6775) Fix fan6 detection for NCT6793D

 drivers/hwmon/nct6775.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
