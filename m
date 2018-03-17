Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeCQLLE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 07:11:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:33361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbeCQLLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 07:11:03 -0400
Date: Sat, 17 Mar 2018 12:10:50 +0100
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fix for 4.16-rc6
Message-ID: <20180317111050.GA30481@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K0:bvVTxvt3EBHgWoiHUbcg9qQb0VvEWOb8irixa+dPlLoO2xd8EiC
 EDnohsY/yNFC8czl2AHyNELtynrlWYPwmAf2rvkxF96H9h0zxvE79xAMp4qQwznrRxdqMa0
 960hx7dYdqFZKWzlFpl3XBndSqIo93LCq0YbiHeM3HdS83FlRQ1wEuZBiec48PXhTZlviNz
 uV/flQL0TGPzYUE5N2NKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SmUdDgMO6SE=:KJ53KDqhrQ2CoSAI0+IW0A
 vykl9mS8cXOyWve7iBzxXq8sObYNrsIHh4Gb8wxJwEYE9+YlqNvz4DfCV6vFuwpEfJbFW4AYx
 1sWKlA31NcBKxe+51Wd1nN6ZLy4m4dMrLMNU6/7DBy9LY7pDd6KjyW/qrDUGx91rKRTCMWPbK
 SGtajc/FbydvIw69cfI8y+luo7JBOc5FoaNdPWqqkan+DOPK+YxXGAYMK9V50Oq6Tb91fI4Fn
 9ea6kxzsoVJoa0TBCfNE8EnUFRvIYom7f7LubuFX6Tx/N+YGemNgPeUtVB9sjs/rOWIeJf6mJ
 6VbsYWoLvpDjTSOoimFBFOjbN5PYRz2zCs/TXnxwt2NWekpTaDAOlgijE5+gf4AEIfHcxLXWS
 rfTfz6itkS43cAwd/x2irISMnq6FNGzQfNNTRUsid+GzRldLHT7mkyp2wG4v90vYDMjJhmzDt
 rJIKXL8nNiSeZWZBlPs0Ud2z9Hb3J5rCGBK8mTKTZMaN9GpqU+zzsn2K4Mv6A0NHbLJIU4lK+
 x01t0OhwzRG8VUSPcfXuN4TOVLd05ZyPBd3CXu9jA9dw+IwJTI8KRDaoRR5hNBotH3Oig7PpL
 GKkB2nV/OCFCy8ZL0HHrOQKemeQ8KpL8z39saLPsf+kZyhFzm4e0xKcBS9iYIZSKWWaeKIZII
 XB8B2Y7XQ9hCHbIeZuOmLSr9EvbiXi31kkmdPFqZLuljzt/gJVl12MC7irWAM61mTIQY61Sge
 DtwDRjZSEsrqObH5ZBSMFKAThXHZxmr9knr2tfVspspFJ5KAsNaPUbaATjSHvgypJ3g+FvGQt
 tHpLmw9ffaBgsNdEntr6S6Ahc6Pxg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one patch for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.16-2

flush_cache_range() may be called without context, which then triggers a BUG().
This patch by Dave Anglin adds code to correctly handle this case.

Thanks,
Helge

----------------------------------------------------------------
John David Anglin (1):
      parisc: Handle case where flush_cache_range is called with no context

 arch/parisc/kernel/cache.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)
