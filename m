Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeFAOn5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:43:57 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34613 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeFAOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:43:53 -0400
X-Google-Smtp-Source: ADUXVKI4m5byMi+6keVX4iCyUqPRiaD1hkBfiHGHRQ/7XyaW+r6RvG9PIV2oBOpO72pxjtxE1I+hVQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL v3 00/10] lightnvm updates for 4.18
Date: Fri,  1 Jun 2018 16:41:04 +0200
Message-Id: <20180601144114.17490-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Please pick up the following patches.

Changes since v2:

 Rebased write error recovery patch on top of latest
 for-4.18/block

 Added (missed the first round)
  lightnvm: pblk: only try to recover lines with written smeta
  lightnvm: pblk: kick writer on new flush points
  lightnvm: pblk: take bitmap alloc. out of critical section

Changes since v1:

 Removed
  lightnvm: pblk: sync RB and RL states during GC
  lightnvm: error handling when whole line is bad
  lightnvm: pblk: handle case when mw_cunits equals to 0

 Added
  lightnvm: pblk: remove unnecessary bio_get/put

Thanks!

Hans Holmberg (5):
  lightnvm: pblk: rework write error recovery path
  lightnvm: pblk: garbage collect lines with failed writes
  lightnvm: pblk: fix smeta write error path
  lightnvm: pblk: only try to recover lines with written smeta
  lightnvm: pblk: kick writer on new flush points

Igor Konopko (2):
  lightnvm: proper error handling for pblk_bio_add_pages
  lightnvm: fix partial read error path

Javier González (2):
  lightnvm: pblk: remove unnecessary bio_get/put
  lightnvm: pblk: take bitmap alloc. out of critical section

Marcin Dziegielewski (1):
  lightnvm: pblk: add possibility to set write buffer size manually

 drivers/lightnvm/pblk-cache.c    |  10 +-
 drivers/lightnvm/pblk-core.c     | 157 +++++++++++++++-------
 drivers/lightnvm/pblk-gc.c       | 102 ++++++++------
 drivers/lightnvm/pblk-init.c     |  62 ++++++---
 drivers/lightnvm/pblk-rb.c       |  43 +-----
 drivers/lightnvm/pblk-read.c     |  69 +++++-----
 drivers/lightnvm/pblk-recovery.c | 121 +++--------------
 drivers/lightnvm/pblk-rl.c       |  29 +++-
 drivers/lightnvm/pblk-sysfs.c    |  15 ++-
 drivers/lightnvm/pblk-write.c    | 281 +++++++++++++++++++++++++--------------
 drivers/lightnvm/pblk.h          |  37 ++++--
 11 files changed, 524 insertions(+), 402 deletions(-)

-- 
2.11.0
