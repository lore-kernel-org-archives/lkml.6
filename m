Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeDTX7P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbeDTX7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:59:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC4C21742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 0/3] fs: minor fs thaw fixes and adjustments
Date: Fri, 20 Apr 2018 16:59:01 -0700
Message-Id: <20180420235904.27496-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a few minor fs thaw fixes and adjustments I ran accross
as I started to refresh my development for to use freeze_fs on
suspend/hibernation [0]. These are just prep commits for the real
work, I'm still reviewing feedback and adjusting the code for
that.

I've tested the patches with generic/085 on xfs and found no regressions.

Luis R. Rodriguez (3):
  fs: move documentation for thaw_super() where appropriate
  fs: make thaw_super_locked() really just a helper
  fs: fix corner case race on freeze_bdev() when sb disappears

 fs/block_dev.c |  4 +++-
 fs/super.c     | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.16.3
