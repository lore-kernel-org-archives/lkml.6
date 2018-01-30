Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeA3SLl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:11:41 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44670 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeA3SLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:11:39 -0500
X-Google-Smtp-Source: AH8x226Om5oHTbPr1/UoaVAqfpr+03ENSBoU0hL+tWNskK5Etl42mfWzHHfp5ofL3gRI4Wb6gmWN2A==
Date: Tue, 30 Jan 2018 10:11:35 -0800
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v4.16-rc1
Message-ID: <20180130181135.GG1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Workqueue changes for v4.16-rc1.  Two patches for the following.

* Workqueue has an early init trick where workqueues can be created
  and work items queued on them before the workqueue subsystem is
  online.  This helps simplifying early init and operation of low
  level subsystems which use workqueues for managerial things which
  aren't depended upon early during boot.

  Out of laziness, the early init didn't cover workqueues with
  WQ_MEM_RECLAIM, which is inconsistent and confusing because adding
  the flag simply makes the system fail to boot.  Cover WQ_MEM_RECLAIM
  too.

  This was originally brought up for RCU but RCU didn't actually need
  this.  I still think it's a good idea to cover it.

Thanks.

The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:

  Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-4.16

for you to fetch changes up to 40c17f75dfa9ec163478efd3f7443fd6af9992c9:

  workqueue: allow WQ_MEM_RECLAIM on early init workqueues (2018-01-08 05:38:37 -0800)

----------------------------------------------------------------
Tejun Heo (2):
      workqueue: separate out init_rescuer()
      workqueue: allow WQ_MEM_RECLAIM on early init workqueues

 kernel/workqueue.c | 64 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-- 
tejun
