Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757046AbeDZXno (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:43:44 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37494 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756405AbeDZXnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:43:43 -0400
X-Google-Smtp-Source: AB8JxZoX1CC96A0bUPB+fy/IBCnhAlAiudnVSMufuD8jRnS67AZj1qpqfXDLJVHsaJH+0/AG1aAovQ==
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, igor.stoppa@huawei.com
Subject: [PATCH 0/2] mm: tweaks for improving use of vmap_area
Date: Fri, 27 Apr 2018 03:42:41 +0400
Message-Id: <20180426234243.22267-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches were written in preparation for the creation of
protectable memory, however their use is not limited to pmalloc and can
improve the use of virtally contigous memory.

The first provides a faster path from struct page to the vm_struct that
tracks it.

The second patch renames a single linked list field inside of vmap_area.
The list is currently used only for disposing of the data structure, once
it is not in use anymore.
Which means that it cold be used for other purposes while it'not queued
for destruction.

The patches can also be obtained from here:

https://github.com/Igor-security/linux/tree/preparations-for-mm


Igor Stoppa (2):
  struct page: add field for vm_struct
  vmalloc: rename llist field in vmap_area

 include/linux/mm_types.h | 1 +
 include/linux/vmalloc.h  | 2 +-
 mm/vmalloc.c             | 8 +++++---
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.14.1
