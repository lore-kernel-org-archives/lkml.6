Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937A82077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjVHTpGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937A82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeIDPVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:21:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35769 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeIDPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:21:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so3496019wre.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zkMO8909Y7CKf1/cb2xAgunw+WwWdIJnVMvH6LDQeCE=;
        b=rjVHTpGFs0M0HsHJT8tlSqh5OhAkonNwenzKuNpI6mnF34DtDn8ReTQuFzCo52bO5q
         8B5K99eufNgdStCsy/tr6zZIpBQwPzDQklG3KpGgR9oRbDH6VzfyLwyWIZlNyH2iOKNB
         McOna8yc1i96VBxmhAAOvmjvK3A7qlD5EX24ZwPNF91F6li2q+fV9tH2E0kryW2e2K8g
         aztGL32zv8ZjIwim5tkaaxdqYm6PC9ZkuO3UBzqL5OGqvPUhzBBOOjRsQ1hL57lIt1gw
         JH5YBkHW97enxRoopt+CkQIjm67jlpTRZJwxJip4MPdIOvfqCfUZEvFNpS6bcxghyNbj
         JeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zkMO8909Y7CKf1/cb2xAgunw+WwWdIJnVMvH6LDQeCE=;
        b=G/bqppZj8yIFsGUdS7iTcETKhDHPb7ifwtrSutCHn4/54GrnxvYa9MaIEQ+Uc+pqXl
         poQ9LMjs/KOuL6NiY99l96zMp5SPhwA+pS04sazXElAXd6sz94SV8mFKM9N2zr5mV0Rm
         O17W0xGReJVvZ5uXGlzhqU3juxp9ltoX6n4tiuDTbemvyEFiYUR8y7jHbjfmRfJuKlU2
         aHrAk7HrV05j9QTMOkQzTYVVx+KtuNa1Gc1VioUSU3mDPopw6vGhLGhZrIkQ370Bwkz1
         j+1HQsFMv1qW0o3KVIE1Nhz8oSd5gAqDdKkBAqtsqLr3XYZl1D5oEEp0vAfID2FbA30T
         Jgew==
X-Gm-Message-State: APzg51BNosuQWTHF1QgqbY0PF77FbWzmihTHSkHVZcB6DzVx9bgnfZd3
        m9con8G2xKhpz9Xcu+KOquRzAC7F
X-Google-Smtp-Source: ANB0VdbD2qro3b6iITvEuf3e/Ej7NZqOqdiZjX6TiDyUPhV0SFzj+vMjy9U001fS8bGCEAHKSU1MXA==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr22534782wra.90.1536058620821;
        Tue, 04 Sep 2018 03:57:00 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 184-v6sm27539085wmv.6.2018.09.04.03.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:57:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 0/1] staging:rtl8192u: Fix naming clash of exported symbol
Date:   Tue,  4 Sep 2018 11:56:22 +0100
Message-Id: <20180904105623.15797-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure of the procedure having made a mess of the build, (by reusing the name
of an exported symbol). I hope that given the obscurity of rtl1892u this doesn't
cause people issues. Obviously given the fact that I renamed an exported symbol
I should have checked the name. Newbie mistake, I can only apologise for the
oversight, sorry.

John Whitmore (1):
  staging:rtl8192u: Rename dot11d_init to fix name clash

 drivers/staging/rtl8192u/ieee80211/dot11d.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.18.0

