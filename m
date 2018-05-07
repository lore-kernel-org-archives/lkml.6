Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeEGMsT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:48:19 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45485 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeEGMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:47:36 -0400
X-Google-Smtp-Source: AB8JxZoS6QnevsZ5Jv7mCqrLVc38UM3tDscPXXw0S/9VMlk/7Z3Lu4ocSngRl9IkpK1qUsK1X/neTQ==
Date: Mon, 7 May 2018 14:47:31 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm-soc <arm@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee driver fixes for v4.17
Message-ID: <20180507124731.GA21011@jax.urgonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these tee driver fixes. Of particular interest is a fix for a
use-after-free issue. There's also a fix making sure that memory references
are kept within the used shm object.

Thanks,
Jens

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-drv-fixes-for-4.17

for you to fetch changes up to ab9d3db5b320a052452b9cd035599ee3c84bbee9:

  tee: check shm references are consistent in offset/size (2018-05-07 11:51:03 +0200)

----------------------------------------------------------------
Small fixes for tee subsystem

* Fixes for use-after-free via temporarily dropped reference
* Checks that passed shm references are consistent in offset/size
  with regards to the shm object

----------------------------------------------------------------
Etienne Carriere (1):
      tee: check shm references are consistent in offset/size

Jann Horn (1):
      tee: shm: fix use-after-free via temporarily dropped reference

 drivers/tee/tee_core.c | 11 +++++++++++
 drivers/tee/tee_shm.c  |  5 +++--
 2 files changed, 14 insertions(+), 2 deletions(-)
