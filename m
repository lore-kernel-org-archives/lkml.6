Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeCFHGu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:06:50 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38405 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeCFHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:06:49 -0500
X-Google-Smtp-Source: AG47ELuu5vf2I1DQfEHqPqQm3cumwg/rWywhNsJIejgXkw2Tcc5hhyduoFJRzs5iYZpI1yQc7W89Hg==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCHv2 0/2] zsmalloc/zram: drop zram's max_zpage_size
Date: Tue,  6 Mar 2018 16:06:37 +0900
Message-Id: <20180306070639.7389-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	ZRAM's max_zpage_size is a bad thing. It forces zsmalloc to
store normal objects as huge ones, which results in bigger zsmalloc
memory usage. Drop it and use actual zsmalloc huge-class value when
decide if the object is huge or not.

Sergey Senozhatsky (2):
  zsmalloc: introduce zs_huge_class_size() function
  zram: drop max_zpage_size and use zs_huge_class_size()

 drivers/block/zram/zram_drv.c |  9 ++++++++-
 drivers/block/zram/zram_drv.h | 16 ----------------
 include/linux/zsmalloc.h      |  2 ++
 mm/zsmalloc.c                 | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 17 deletions(-)

-- 
2.16.2
