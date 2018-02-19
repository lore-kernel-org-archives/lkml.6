Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeBSOzt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:55:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60254 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753008AbeBSOzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:55:47 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-fsdevel@vger.kernel.org
Cc: peterz@infradead.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/2] A couple of i_dir_seq fixes for fs/dcache.c
Date: Mon, 19 Feb 2018 14:55:53 +0000
Message-Id: <1519052155-6361-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the patch I previously posted here:

  http://lkml.kernel.org/r/1518526731-26546-1-git-send-email-will.deacon@arm.com

Changes since v1:

  * Added READ_ONCE to i_dir_seq access
  * Added tags

Cheers,

Will

--->8

Will Deacon (2):
  fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
  fs: dcache: Use READ_ONCE when accessing i_dir_seq

 fs/dcache.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.1.4
