Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5741B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405136AbfAPQRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:17:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:38632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbfAPQRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:17:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC9B9AE3C;
        Wed, 16 Jan 2019 16:17:32 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/4] livepatch: Followup changes for the atomic replace patchset
Date:   Wed, 16 Jan 2019 17:17:16 +0100
Message-Id: <20190116161720.796-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements ideas that were mentioned and postponed during
the review of the atomic replace patchset. I hope that I did not miss
anything.

Well, I did not add __used attribute to avoid non-static warnings
in modules for the selftest. The work on the sample modules somehow
stalled.

BTW: Does it make sense to maintain the sample modules any longer?
We could point people to the modules used by the selftest instead.


The patches apply on top of livepatching.git, branch
origin/for-5.1/atomic-replace.


Petr Mladek (4):
  livepatch: Introduce klp_for_each_patch macro
  livepatch: Handle failing allocation of shadow variables in the
    selftest
  livepatch: Module coming and going callbacks can proceed all listed
    patches
  livepatch: Remove the redundant enabled flag in struct klp_patch

 include/linux/livepatch.h            |  2 --
 kernel/livepatch/core.c              | 57 ++++++++++++++++--------------------
 kernel/livepatch/core.h              |  6 ++++
 kernel/livepatch/transition.c        |  9 +++---
 kernel/livepatch/transition.h        |  1 +
 lib/livepatch/test_klp_shadow_vars.c |  8 ++---
 6 files changed, 40 insertions(+), 43 deletions(-)

-- 
2.13.7

