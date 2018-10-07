Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB9C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6082620882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwNNRU3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6082620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJHEso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:44 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34605 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJHEso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:44 -0400
Received: by mail-wm1-f49.google.com with SMTP id z25-v6so7438439wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvtkiB3KkfXiXnAe89RKT7y4GbANQFbdGskn/jxxQ84=;
        b=HwNNRU3LUEVbiUDhWSmv0n8z3fej9cC9edBm7KBs87y+DrL5EibIhq1Rn5BZcO4mxC
         Mv4qP/z/9x87Kb05ZsmpJZT+/G8zGYP//+DWiG+03BxGbhu0/z3aIyTp6vbYupK78r0m
         O1sEsiy7+erMrP73rsuNhFZjbV1VUZ3EIB+pHAVficr8JKMRetFKQ4orLcY2V57UQHmq
         DkJEi5W6GQUV3TqP6CitCclBeA7sFUMn7s702QoLHN8E+lGSf9LBai7Vs193iKhxuLem
         Qq7Wc+Pj531CGbflhgEcQedGj34UWT+jQXyNXGHjQ6/Fu67N9oaPCwsgnVqBHCKKnk66
         CGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvtkiB3KkfXiXnAe89RKT7y4GbANQFbdGskn/jxxQ84=;
        b=WeKmJUU/Z/q9pZYjIDDEnbKw4HcnlA/6hCmOD+UUc1v3QVIaww8Q+MmTOo/JVejW0c
         2HgtidtXGxwYbMaIKGVf+brMagZXKOpjlH6RO+a++TDHFnvAqc4LvFi6VnDQZbk4lbNZ
         4b86HRmMvTH8EUKRatirc4KFS65yUKl9KoZhnajSGhdl5jE2wlRfqoeX2yqO4uyg4hwY
         5KOM4EBIKAnX1Gpj6yjBaNo7zm6qcpd9ic5TRmG8bAlG8PrD9NNCnYg3wSZQ0MmN1lYz
         3tejDWOfgfsoBXmtubYZMtJRJTfuxxaRo0tTgQtHPZzcxStjXGDxw3V+6eOXYB18cuL5
         3HTA==
X-Gm-Message-State: ABuFfoj2dJilFIoubch7PpiXKUt67FD50OcMs8YNg90/WpooX3NfvubM
        SehaLl/MohmpWbuMbO+PvZgnn54/
X-Google-Smtp-Source: ACcGV62zt/dMNaCqpOV0Ot2AgnnILOL0NnxtZOdamSZBWDDMSyj7miu0lYBv1vxMgoE8iL5v8n9MWQ==
X-Received: by 2002:a1c:8fc5:: with SMTP id r188-v6mr91235wmd.136.1538948407011;
        Sun, 07 Oct 2018 14:40:07 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/11] staging:rtl8192u: Coding Style changes
Date:   Sun,  7 Oct 2018 22:40:14 +0100
Message-Id: <20181007214025.25469-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a number of simple coding style changes in the file
ieee80211_module.c

John Whitmore (11):
  staging:rtl8192u: Add missing SPDX-License-Identifier - Style
  staging:rtl8192u: Removed commented out include - Style
  staging:rtl8192u: Clear error with line ending ( - Style
  staging:rtl8192u: Remove extra blank lines - Style
  staging:rtl8192u: Add spaces around + operator - Style
  staging:rtl8192u: Rewrite test for null - Style
  staging:rtl8192u: Correct code indentation - Style
  staging:rtl8192u: Add missing blank lines - Style
  staging:rtl8192u: Remove unnecessary line continuation - Style
  staging:rtl8192u: Correct code alignment - Style
  staging:rtl8192u: Correct comparison with NULL - Style

 .../rtl8192u/ieee80211/ieee80211_module.c     | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

-- 
2.19.0

