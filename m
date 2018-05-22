Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeEVKIH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:08:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751039AbeEVKIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:08:00 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/2] kasan: fix memory notifier handling
Date: Tue, 22 May 2018 12:07:54 +0200
Message-Id: <20180522100756.18478-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If onlining of pages fails (is canceled), we don't properly free up memory.
Also, the memory hotplug notifier is not registered early enough, still
failing on certain setups where memory is detected, added and onlined
early.

v1 -> v2:
- s/MEM_CANCEL_OFFLINE/MEM_CANCEL_ONLINE

David Hildenbrand (2):
  kasan: free allocated shadow memory on MEM_CANCEL_ONLINE
  kasan: fix memory hotplug during boot

 mm/kasan/kasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.0
