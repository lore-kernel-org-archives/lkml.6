Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDIWZP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 18:25:15 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43902 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeDIWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 18:25:12 -0400
X-Google-Smtp-Source: AIpwx4+A2L6ywLEsgzL2wqjsi+BxoMSs+fHQ1pt3GrV9vyHb2BtPxZpl1U8Vvgbr3sRkw7T6fh+Guw==
Date: Mon, 9 Apr 2018 15:25:09 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [GIT PULL] rpmsg updates for v4.17
Message-ID: <20180409222509.GC17344@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rpmsg-v4.17

for you to fetch changes up to 0d72038c303c616a63415a07366f916b5edc3830:

  rpmsg: smd: Use announce_create to process any receive work (2018-03-27 21:54:37 -0700)

----------------------------------------------------------------
rpmsg updates for v4.17

This transitions the rpmsg_trysend() code paths of SMD and GLINK to use
non-sleeping locks, it reverts the overly optimistic handling of
discovered SMD channels and fixes an issue in SMD where incoming
messages races with the probing of a client driver.

----------------------------------------------------------------
Arvind Yadav (2):
      rpmsg: glink: use put_device() if device_register fail
      rpmsg: smd: use put_device() if device_register fail

Bjorn Andersson (6):
      rpmsg: smd: Use spinlock in tx path
      rpmsg: glink: Use spinlock in tx path
      Revert "rpmsg: smd: Create device for all channels"
      rpmsg: smd: Fix container_of macros
      rpmsg: Only invoke announce_create for rpdev with endpoints
      rpmsg: smd: Use announce_create to process any receive work

 drivers/rpmsg/qcom_glink_native.c | 18 ++++++++------
 drivers/rpmsg/qcom_glink_smem.c   |  3 ++-
 drivers/rpmsg/qcom_smd.c          | 51 +++++++++++++++++++++++++++++----------
 drivers/rpmsg/rpmsg_core.c        |  2 +-
 4 files changed, 52 insertions(+), 22 deletions(-)
