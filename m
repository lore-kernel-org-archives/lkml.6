Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755156AbeD3Q6B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:58:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20729 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755093AbeD3Q56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:57:58 -0400
X-IronPort-AV: E=Sophos;i="5.49,346,1520870400";
   d="scan'208";a="173714668"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-abi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH 0/2] AIO add per-command iopriority
Date: Mon, 30 Apr 2018 09:57:38 -0700
Message-Id: <20180430165740.2842-1-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

This patchset interprets the aio_reqprio field of an iocb as a 
per-command value iff the RWF_IOPRIO flag is set on the iocb. 
This feature is implemented for a block device, but could also be
leveraged by any consumers of the iocb.

See the following link for performance implications on a SATA HDD:
https://lkml.org/lkml/2016/12/6/495

Adam Manzanares (2):
  fs: add RWF_IOPRIO
  fs: Add aio priority support for block_dev

 fs/aio.c                | 9 +++++++++
 fs/block_dev.c          | 1 +
 include/linux/fs.h      | 4 ++++
 include/uapi/linux/fs.h | 5 ++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.15.1
