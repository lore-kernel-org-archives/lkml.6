Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD34C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F963214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfBLPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:13:59 -0500
Received: from relay.sw.ru ([185.231.240.75]:45062 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:13:59 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gtZkx-0001Yf-DX; Tue, 12 Feb 2019 18:13:55 +0300
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0/4] mm: Generalize putback functions
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, ktkhai@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Feb 2019 18:13:53 +0300
Message-ID: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions putback_inactive_pages() and move_active_pages_to_lru()
are almost similar, so this patchset merges them in only function.

---

Kirill Tkhai (4):
      mm: Move recent_rotated pages calculation to shrink_inactive_list()
      mm: Move nr_deactivate accounting to shrink_active_list()
      mm: Remove pages_to_free argument of move_active_pages_to_lru()
      mm: Generalize putback scan functions


 include/linux/vmstat.h |    2 -
 mm/vmscan.c            |  150 ++++++++++++++++++------------------------------
 2 files changed, 57 insertions(+), 95 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
