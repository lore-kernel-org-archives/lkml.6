Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D54C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC0B20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw9ZpEJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfAXV4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:56:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39508 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfAXV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:56:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so3266058pgl.6;
        Thu, 24 Jan 2019 13:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T+fv3v7JZhFM4KScnOfIU+Wzz4uiNEPlJBmf2fLB6L4=;
        b=Pw9ZpEJG/QcIyvMwCM9CN8hkB44HI8KijmZAs597f9WG0POOttIZqCtUydmWg8Iiy3
         y5RaUc4SQhIaDSnKLU5s3iNOn22Tl3Dz94kOW5W2lYJ1IIN59vruAdKzdjATXnbbfs+p
         ZaZBlF4+euOKtbmYrVJICVB3o15Tg1dqH5QuIsP07J+jgCTs9agoEELN6KIUOHxN9VSA
         vIb3fhfXYHWmit/BsQhceEdYm9xqtpIQHGxkpS9u/jJezbVhi7CjgI4T1kib4P4IKtNV
         qYwsuwueeRwrGdXVdQO21bCv91vYzW5BXmzrKppF+q7X1cYC4nFTAGYS3g2fXH0ta8QP
         xMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T+fv3v7JZhFM4KScnOfIU+Wzz4uiNEPlJBmf2fLB6L4=;
        b=GWPmiwjpLSxRaTPdzXz+f6sa0dzxFP97v1ZG+wmJrpAsQMTeyb6ZaSrxKkI1jePZRn
         PXZvVmMr5HsFl8f5uGOBw/VWslGtwKPIHVb2Zu8x0e/w8RnRergHGdYqBbyL9Ryq8nL+
         1bOlWAT4Jwc70uJFDQi+0pYmqqZi5YypdRI7GhBJZaxo87n/PLwOZZvNHjJyKIl519m4
         fE6QoARNZWch7cPVQTaLDvwZQhqL4/0LkkCcfVR5A+TTUR8k3ya3TVtQJAk9KrOr0bNK
         4g+BWyo7tgU26BcM21fnW715w6OW0FvFA+H5r7RNJtVkgHlUyLYE+kVFfKt60C/L2SJF
         kyfg==
X-Gm-Message-State: AJcUukfjAyh6aCDen5rSSveJV9kodrS/o1E1iPW1AVdippMiRcjy2BEG
        syt5mF7/MU2xzRf6D7HPcHDzKyx3
X-Google-Smtp-Source: ALg8bN4Thxcgnnc3xa3IoUlFJcO6YHJhAy0Fp2EzYUs8ggBeNomBBKubB6wkId46dMzyTF4G1QcpZQ==
X-Received: by 2002:a63:3602:: with SMTP id d2mr7428913pga.404.1548366965394;
        Thu, 24 Jan 2019 13:56:05 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id g26sm29122593pfh.61.2019.01.24.13.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 13:56:04 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 0/2] Korean translation of memory-barriers.txt update
Date:   Fri, 25 Jan 2019 06:55:46 +0900
Message-Id: <20190124215548.4991-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.10.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates the Korean translation of memory-barriers.txt to follow
latest changes.  It has been reviewed by my one Korean colleague.

SeongJae Park (2):
  sched/Documentation/kokr: Update Korean translation to update
    wake_up() & co. memory-barrier guarantees
  locking/memory-barriers/kokr: Update Korean translation to replace
    smp_cond_acquire() with smp_cond_load_acquire()

 .../translations/ko_KR/memory-barriers.txt         | 49 ++++++++++++----------
 1 file changed, 28 insertions(+), 21 deletions(-)

-- 
2.10.0

