Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1051C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F7020672
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb+6XRnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeLPUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:04:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43556 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeLPUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:04:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so10199078wrs.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=/T4Cqh4t22HrEuXlXbEBulicNCiJGVVW2nfwgVvE+hM=;
        b=Hb+6XRnV171plqYEgQcIK4zTuH0AcFGnuYJjGfHMny8hKDMiCA3aTeOf3PyrFzlBM6
         MJOg4BQURTqus5Gi6AjWTly7fQzIO//Hr9jIbiSZj7Zo2bnFbNRZPvYn2rBAt7nE6ZGr
         5N406LMTALResZoWB9D5tVDaY0gr7i/8FQ11t4H3WiGQBnl3e+9M9TgFynVRMf78FnMs
         I59lsPfbVc9zydJVo+0tZUDphcCc26r/UqLqLhjiOtmhXQhbcclXKRw+G9mkGKxmpJRo
         WXMTKxLSO5WzTWwsYnirzpT3/fVCjRRrDy5R5wQ+EeG/Y3sLWKeiQqrEiix5l421SQ1h
         MZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/T4Cqh4t22HrEuXlXbEBulicNCiJGVVW2nfwgVvE+hM=;
        b=QXKhCzXaE0qsU84b8mhkMgne6Kb3ZvJpLK3xOkE4pvwnKUqJ7kkOq4MbtAvwjszlIz
         eR8tZc/fzx+rU71q9ghFY+b3TwGTchPi8m3dVzjSvTCVoGlGrQO2dTiSdbOi3uAL5m3Z
         t3fmQqNWzvhZayQv1bx7eeUdeXiWb95St48LLQTEZC8/F2WBlc/WYDjr7o6qbBIusOji
         7fnw7J7ZQgQS8o+RvvdDpBgs/0OWeL2W2DySQgh/Vt58LKR3u+j5V6R3YbDJoUofRcew
         vY4kYkirk0JSCgr3KrGA/JRBAaXwCq4phxsIOtMJ5uAekRHgG9doCWsMeDGIPoaGSPjO
         wmbg==
X-Gm-Message-State: AA+aEWbE8noSEIz4IErY24nOULFv3apkVt5bBrSf1h6/YdzL8Z4HKEbk
        8ASi/gSPGi/+11OrXSd9Jys=
X-Google-Smtp-Source: AFSGD/XYm4M0iWynBT1HGiBiYj7mYACqvEk30/pCXqzMPHyJMgMfxMsaYksy+dCDwDiJTgZ1KkccnQ==
X-Received: by 2002:adf:d1d2:: with SMTP id m18mr8871263wri.138.1544990660693;
        Sun, 16 Dec 2018 12:04:20 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id v5sm10535150wrn.71.2018.12.16.12.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 12:04:19 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v3 0/3] fat: Added functions to determine the FAT variant (12/16/32bit)
Date:   Sun, 16 Dec 2018 15:03:57 -0500
Message-Id: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
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
and fixed comments from v1 and v2.

Carmeli Tamir (3):
  Removed fat_first_ent
  Moved and inlined MAX_FAT
  IS_FAT functions

 fs/fat/cache.c                |  2 +-
 fs/fat/dir.c                  |  4 ++--
 fs/fat/fat.h                  | 30 +++++++++++++++++++++++++++++-
 fs/fat/fatent.c               | 16 +++++++---------
 fs/fat/inode.c                | 26 +++++++++++++++-----------
 fs/fat/misc.c                 |  2 +-
 include/uapi/linux/msdos_fs.h |  5 -----
 7 files changed, 55 insertions(+), 30 deletions(-)

-- 
2.7.4

