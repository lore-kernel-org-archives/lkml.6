Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeEVDon (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:44:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751763AbeEVDok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:44:40 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net V2 0/4] Fix several issues of virtio-net mergeable XDP
Date: Tue, 22 May 2018 11:44:27 +0800
Message-Id: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Please review the patches that tries to fix sevreal issues of
virtio-net mergeable XDP.

Changes from V1:
- check against 1 before decreasing instead of resetting to 1
- typoe fixes

Jason Wang (4):
  virtio-net: correctly redirect linearized packet
  virtio-net: correctly transmit XDP buff after linearizing
  virtio-net: correctly check num_buf during err path
  virtio-net: fix leaking page for gso packet during mergeable XDP

 drivers/net/virtio_net.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
2.7.4
