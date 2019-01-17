Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D55C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAC120854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfAQDkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:40:25 -0500
Received: from namei.org ([65.99.196.166]:56592 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbfAQDkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:40:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0H3eMuJ028638;
        Thu, 17 Jan 2019 03:40:22 GMT
Date:   Thu, 17 Jan 2019 14:40:22 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Security subsystem fixes for v5.0-rc3
Message-ID: <alpine.LRH.2.21.1901171437560.28339@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these fixes for the security subsystem.

The first (by Casey actually) fixes a regression introduced with the LSM 
stacking changes.


The following changes since commit 7939f8beecf1cfb10d255be65bfbd3793fae82a1:

  Merge tag 'trace-v5.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2019-01-16 05:28:26 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.0-rc2

for you to fetch changes up to a5795fd38ee8194451ba3f281f075301a3696ce2:

  LSM: Check for NULL cred-security on free (2019-01-16 15:41:11 -0800)

----------------------------------------------------------------
James Morris (1):
      LSM: Check for NULL cred-security on free

Kees Cook (1):
      Yama: Check for pid death before checking ancestry

Tycho Andersen (1):
      seccomp: fix UAF in user-trap code

 kernel/seccomp.c         | 4 ++++
 security/security.c      | 7 +++++++
 security/yama/yama_lsm.c | 4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)


