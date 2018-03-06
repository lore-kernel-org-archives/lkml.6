Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeCFTFG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:05:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753535AbeCFTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:05:04 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCHv2 0/2] A couple of i_dir_seq fixes for fs/dcache.c
Date: Tue,  6 Mar 2018 19:05:04 +0000
Message-Id: <1520363106-4687-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

This is a resend of the patches I previously posted here:

v1: http://lkml.kernel.org/r/1518526731-26546-1-git-send-email-will.deacon@arm.com
v2: https://lkml.org/lkml/2018/2/19/360

Since this fixes a livelock that we're seeing in practice, I'd really like
to get these merged if possible.

Thanks,

Will

--->8

Will Deacon (2):
  fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
  fs: dcache: Use READ_ONCE when accessing i_dir_seq

 fs/dcache.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.1.4
