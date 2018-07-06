Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4551223B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ZScH+vCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4551223B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934737AbeGFTcs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:32:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44473 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934654AbeGFTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so9175904pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=398C5SJUHRbHDItC3HsfQCy0QGnauQYu+M7fUUYd7jY=;
        b=ZScH+vCqaY7FBAJnUnVneHnQZ5pu7RZ6Vg2QuGh4dj4nCkqJGX4S8zlc1OHmW6aoiK
         uzJYWXJ+ywbDUvfV6aJBhWmzrdIpDVVz4V3S3/picU+aGDueGlghuQADAEJYXHD/SZXg
         Omue5byX2hBaPsYuOv+P2yQRTUf6gKLUH8EJGiOKfjh8bCAXCWR7hmtcHACQx8vvpAry
         OSq2JmI+QmaD+eZ/URv713BGHoBJ0XKKN6zV5bNv0vQcBAlZFKtMtG9wXa0kprrWdBN9
         CZLUrM1AGMX6+SMO1KU1leT6DMTsjD9te6HmCyHF/gM/UvXt6xStmeCJcekAmTYolDtd
         EDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=398C5SJUHRbHDItC3HsfQCy0QGnauQYu+M7fUUYd7jY=;
        b=UDl5ikG0R5hIP/6Wl8nj7ZZh9q/3Y9VYH/cuuuVfKfW5gL6bnEL7+IJ0cvBuRqFkXo
         OM6Q0h6/lq9Pbf5RuQ96fHF1aJEsqkhqAXHSnjXmHFs66CljS2ZsH/922dYSJ2O7vJ/h
         E7S8pnX2+/0YvBTZsvwattNdxAQEZnlFlZnb24XJLiS56ShzH7i+0HKeR5Rc06Slr9U2
         pGs7Af3LiGGzg500JLuKabPQq5oEjRaEqhdcT3Vg705Oui8ULq7fcjP/yGtuyKsq8a3V
         GP5AQS56QaOV2haLiFe6KVWSqxJmyR5JJ+X/m/BVFZG0pmx3RotC/+q6l2wZ9kIrofNz
         5Xng==
X-Gm-Message-State: APt69E1HerRhPrKNqXsZPw+KLWQe/gB9YruDzT7bO43CiWSflWfbc84A
        ZfD8++NXqiY/MgZtRvTAAB/Kwnilhnw=
X-Google-Smtp-Source: AAOMgpdEJMidiqM48vpH2x1CJycsfYGKme9GRTe5STPCYbTUjdNyHwKSJi83aBZ1QzG3kBvm7NR/AQ==
X-Received: by 2002:a63:8548:: with SMTP id u69-v6mr1166447pgd.346.1530905564935;
        Fri, 06 Jul 2018 12:32:44 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:44 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 0/7] /proc/kcore improvements
Date:   Fri,  6 Jul 2018 12:32:31 -0700
Message-Id: <cover.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series makes a few improvements to /proc/kcore. Patches 1 and 2 are
prep patches. Patch 3 is a fix/cleanup. Patch 4 is another prep patch.
Patches 5 and 6 are optimizations to ->read(). Patch 7 adds vmcoreinfo
to /proc/kcore. This series is based on v4.18-rc3. Please consider it
for v4.19.

Thanks!

Omar Sandoval (7):
  proc/kcore: don't grab lock for kclist_add()
  proc/kcore: replace kclist_lock rwlock with rwsem
  proc/kcore: fix memory hotplug vs multiple opens race
  proc/kcore: hold lock during read
  proc/kcore: clean up ELF header generation
  proc/kcore: optimize multiple page reads
  proc/kcore: add vmcoreinfo note to /proc/kcore

 fs/proc/Kconfig            |   1 +
 fs/proc/kcore.c            | 524 +++++++++++++++++--------------------
 include/linux/crash_core.h |   2 +
 kernel/crash_core.c        |   4 +-
 4 files changed, 241 insertions(+), 290 deletions(-)

-- 
2.18.0

