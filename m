Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FF9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18A52084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuvkNCqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbeLONFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:05:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLONFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:05:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so8293051wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 05:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=+wxhPpMquTsnb6wLKurDgCBiuQgUSE3pLROW2Xknt2A=;
        b=GuvkNCqO5s2D2rediFRUtBP3Kx7UHB5rJKB2XURKA4z2nu4jV23D0w5rsQ062sXuUE
         Ot0fdM/LymPAZFbRVJMI+epP+fKfnRjvAPL1qmfNsDaAbmj+h2RXeYKmb/m5vrQhYtqS
         0qSUSwj2TumRBKT11S104e5cH9Mzqc3kqDpRTUar2TS4VIamAmu2UYw18nZTNLHIMpOL
         qU7IWmRdYAIGEV6LWt6XeZHfMJxm0KALetECSvkd1qzJDJP/klYzoitEVx2ca3s6p7xC
         PZIrB0m1+JgJwooyXiBUee0MoSiYwcw3aEA/10ZMeuNLiYu6zC24gdbV4DkMArCPbeoj
         luUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+wxhPpMquTsnb6wLKurDgCBiuQgUSE3pLROW2Xknt2A=;
        b=mNfh2bNH5Am27jOWVPuNab9PBG3ZpCht3Wq+9LJQ5wj6yxPFkpftfHhTdsKxKwvtII
         G7SIOU3lWHHk+DZUikFa2FOAbaHJUoAlLMDteinpZLOyYAn6hsXxXrbAYrM0qcWjp9Wx
         b6TuLXPkFMz0O1e2cUvevgYsiuKmyVIR1lTEzF1BYmxtn7aSE9vOHSdnDTSET3hD80Ao
         Nz5IH9WQYJn1s5PtFk8H/R0gp9VjgGpIPzV/pclexY11LegMFXQFkoK2Da00tzdVxkX1
         mj0oXRvs1yBdL3eadaLNjMSOHZT+ABV8YW1bb33XR8oQxT0M80qoT1w0AWFSm8SaZU8s
         XIHQ==
X-Gm-Message-State: AA+aEWYauZXVuf2mriQgex0AnQ1336Qf2URYS3LlwkMyzj1CWDPm6NjR
        I9uuTXm21lWnM/MKMK3VksqbXveAAyY=
X-Google-Smtp-Source: AFSGD/W/zU6s32t/upTfU/b9R2T54LqyWabdg6jUcMixw8Avp0vrXI10qiTDOFPn/0Hu5uBU3vvM0Q==
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr6027203wmf.56.1544879098216;
        Sat, 15 Dec 2018 05:04:58 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id s1sm9589159wro.9.2018.12.15.05.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Dec 2018 05:04:57 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v2 0/3] fat: Added functions to determine the FAT variant (12/16/32bit)
Date:   Sat, 15 Dec 2018 08:04:29 -0500
Message-Id: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Along the FAT FS code, the FAT variant (whether this is FAT12, FAT16 or FAT32) is
determined by checking the fat_bits field of struct msdos_sb_info. 
This is somewhat error prone as it forces the usage of magics (12, 16, 32)
multiple times in the code.

This series replaces the places in which the variant is checked with three
inline functions - IS_FAT12, IS_FAT16 and IS_FAT16.

The introduction of these simple inline functions makes a clearer API for determining the variant,
rather than searching the code for some field in a struct, and therefore
increases the code's maintainability and readability.

In addition, minor cleanups around code that checks for the FAT variant,
and fixed comments from v1.

Carmeli Tamir (3):
  Removed fat_first_ent
  Moved and inlined MAX_FAT
  IS_FAT functions

 fs/fat/cache.c                |  2 +-
 fs/fat/dir.c                  |  4 ++--
 fs/fat/fat.h                  | 30 +++++++++++++++++++++++++++++-
 fs/fat/fatent.c               | 16 +++++++---------
 fs/fat/inode.c                | 24 ++++++++++++++----------
 fs/fat/misc.c                 |  2 +-
 include/uapi/linux/msdos_fs.h |  5 -----
 7 files changed, 54 insertions(+), 29 deletions(-)

-- 
2.7.4

