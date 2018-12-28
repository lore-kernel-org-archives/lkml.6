Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F23C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2555521908
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545973331;
	bh=sXXNzPhVm7JGPRqraXe87DZOq1K/HBYpwWwJnm84YNg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zl2K2fNEI6gT9ohEUGkcSPuDhsDvEpuSK3ZTqXW4iorrIlFF7veLxQqjF8UVl2EIy
	 fizsIy+JKlbJNn8q2hkM4eKrvSedrkY9KK652biU5G6aFcBytof5iWiwLKPjulT72r
	 bP7wvtuTBWcfjSaGbvZ18nI7uKYjs6DI5L304Fok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeL1FCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 00:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeL1FCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 00:02:09 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC1220879;
        Fri, 28 Dec 2018 05:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545973329;
        bh=sXXNzPhVm7JGPRqraXe87DZOq1K/HBYpwWwJnm84YNg=;
        h=From:To:Cc:Subject:Date:From;
        b=iFbIfeE6ufIwvKIIlVTnSQriXXEkjSTNqkqsM3wZ+OceRVGY788Xc5txUdjClKvLg
         76Kj1A/v9QfYW8fM3c3f4MImXjBATsx8biTfmJHLKnsUOnvzztLrbx4DXFkPk8MF9w
         Ejl9Qo71jZzCuV+TP1Wh+yjV94k06KSCEyJibD6Q=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] locking/lockdep: A few cleanups
Date:   Fri, 28 Dec 2018 06:01:59 +0100
Message-Id: <1545973321-24422-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few simplification and code cleanup.

Frederic Weisbecker (2):
  locking/lockdep: Simplify mark_held_locks()
  locking/lockdep: Provide enum lock_usage_bit mask names

 kernel/locking/lockdep.c           | 54 +++++++++++++-------------------------
 kernel/locking/lockdep_internals.h |  4 +++
 2 files changed, 22 insertions(+), 36 deletions(-)

-- 
2.7.4

