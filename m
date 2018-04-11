Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDKCfr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:35:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752298AbeDKCfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:35:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, jasowang@redhat.com,
        mst@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 0/2] vhost: fix vhost_vq_access_ok() log check
Date: Wed, 11 Apr 2018 10:35:39 +0800
Message-Id: <20180411023541.15776-1-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
 * Rebased onto net/master and resolved conflict [DaveM]

v2:
 * Rewrote the conditional to make the vq access check clearer [Linus]
 * Added Patch 2 to make the return type consistent and harder to misuse [Linus]

The first patch fixes the vhost virtqueue access check which was recently
broken.  The second patch replaces the int return type with bool to prevent
future bugs.

Stefan Hajnoczi (2):
  vhost: fix vhost_vq_access_ok() log check
  vhost: return bool from *_access_ok() functions

 drivers/vhost/vhost.h |  4 +--
 drivers/vhost/vhost.c | 70 ++++++++++++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

-- 
2.14.3
