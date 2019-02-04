Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BEBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45832176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfBDN5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:57:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:35680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729969AbfBDN5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:57:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86A91ADC8;
        Mon,  4 Feb 2019 13:57:00 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/4] livepatch: Followup changes for the atomic replace patchset
Date:   Mon,  4 Feb 2019 14:56:49 +0100
Message-Id: <20190204135653.31406-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements ideas that were mentioned and postponed during
the review of the atomic replace patchset.

The patches apply on top of livepatching.git, branch
origin/for-5.1/atomic-replace.


Changes against v1:

  + Added Joe's patch that fixed ptr_id() error code [Joe]
  + Did proper error handling in the shadow variable sefttest [All]
  + Removed the controversial patch that was removing patch->enabled flag [All].
  + Fixed few typo's [Joe]
  + Added available Acks.


Joe Lawrence (1):
  livepatch: return -ENOMEM on ptr_id() allocation failure

Petr Mladek (3):
  livepatch: Introduce klp_for_each_patch macro
  livepatch: Proper error handling in the shadow variables selftest
  livepatch: Module coming and going callbacks can proceed with all
    listed patches

 kernel/livepatch/core.c              | 34 ++++++++++------------------------
 kernel/livepatch/core.h              |  6 ++++++
 kernel/livepatch/transition.c        |  2 +-
 lib/livepatch/test_klp_shadow_vars.c | 24 +++++++++++++++++++++++-
 4 files changed, 40 insertions(+), 26 deletions(-)

-- 
2.13.7

