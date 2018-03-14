Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeCNISr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:18:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42852 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeCNISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:18:43 -0400
X-Google-Smtp-Source: AG47ELvxcGXHX1Wey3Pm7GFMEBBnPIfSrnODCsTw7wm+lVCkpLoPbd6OsRDp61WDM4h39HizgpQRcA==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCHv3 0/2] zsmalloc/zram: drop zram's max_zpage_size
Date: Wed, 14 Mar 2018 17:18:31 +0900
Message-Id: <20180314081833.1096-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	ZRAM's max_zpage_size is a bad thing. It forces zsmalloc to
store normal objects as huge ones, which results in bigger zsmalloc
memory usage. Drop it and use actual zsmalloc huge-class value when
decide if the object is huge or not.

v3:
- add pool param to zs_huge_class_size() [Minchan]

Sergey Senozhatsky (2):
  zsmalloc: introduce zs_huge_class_size() function
  zram: drop max_zpage_size and use zs_huge_class_size()

 drivers/block/zram/zram_drv.c |  9 ++++++++-
 drivers/block/zram/zram_drv.h | 16 ----------------
 include/linux/zsmalloc.h      |  2 ++
 mm/zsmalloc.c                 | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 17 deletions(-)

-- 
2.16.2
