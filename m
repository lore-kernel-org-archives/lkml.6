Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933066AbeBVPkE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:40:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932902AbeBVPkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:40:02 -0500
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/1] vfio-ccw: be less trusting
Date: Thu, 22 Feb 2018 16:39:58 +0100
Message-Id: <20180222153959.31272-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently prototyping hsch()/csch() support for vfio-ccw, and
stumbled over this: We currently expect any I/O to be in command-mode,
but don't take care to actively reject transport-mode. This is not an
issue with QEMU (which rejects transport-mode ORBs before even the css
backend gets to it), but better play safe.

Should we want to support transport-mode in the future, we'll probably
need to introduce a capability for it that needs to be enabled by user
space.

[I also still have the doc patch from some time ago queued. Let's see
if we'll collect more patches.]

Cornelia Huck (1):
  vfio-ccw: fence off transport mode

 drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.13.6
