Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeBGJ3c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:29:32 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43206 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbeBGJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:29:30 -0500
X-Google-Smtp-Source: AH8x227V92dlni/I4nJsgrJ6ro5uWl0j28SqmUxKvDxdFfNNMOb/09WLn1EDSOKaKAhyXSJV7k/v0w==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 0/2] zsmalloc/zram: drop zram's max_zpage_size
Date: Wed,  7 Feb 2018 18:29:17 +0900
Message-Id: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	ZRAM's max_zpage_size is a bad thing. It forces zsmalloc to
store normal objects as huge ones, which results in bigger zsmalloc
memory usage. Drop it and use actual zsmalloc huge-class value when
decide if the object is huge or not.

Sergey Senozhatsky (2):
  zsmalloc: introduce zs_huge_object() function
  zram: drop max_zpage_size and use zs_huge_object()

 drivers/block/zram/zram_drv.c |  6 +++---
 drivers/block/zram/zram_drv.h | 16 ----------------
 include/linux/zsmalloc.h      |  2 ++
 mm/zsmalloc.c                 | 17 +++++++++++++++++
 4 files changed, 22 insertions(+), 19 deletions(-)

-- 
2.16.1
