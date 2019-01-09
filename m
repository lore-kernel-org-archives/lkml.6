Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60597C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB392075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfAIIFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:05:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfAIIFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:05:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBA34C056824;
        Wed,  9 Jan 2019 08:05:37 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3530B19940;
        Wed,  9 Jan 2019 08:05:32 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next V2 0/3] basic in order support for vhost_net
Date:   Wed,  9 Jan 2019 16:05:27 +0800
Message-Id: <20190109080530.18572-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 08:05:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This series implement basic in order feature support for
vhost_net. This feature requires both driver and device to use
descriptors in order which can simplify the implementation and
optimizaton for both side. The series also implement a simple
optimization that avoid read available ring. Test shows 10%
performance improvement at most.

More optimizations could be done on top.

Changes from V1:
- no code changes
- add result of SMAP off

Jason Wang (3):
  virtio: introduce in order feature bit
  vhost_net: support in order feature
  vhost: don't touch avail ring if in_order is negotiated

 drivers/vhost/net.c                |  6 ++++--
 drivers/vhost/vhost.c              | 19 ++++++++++++-------
 include/uapi/linux/virtio_config.h |  6 ++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.17.1

