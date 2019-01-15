Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880420645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfAOQpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:45:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:47462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387697AbfAOQpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E23BAC97;
        Tue, 15 Jan 2019 16:45:10 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
        pmladek@suse.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 0/2] Periodic fake signal
Date:   Tue, 15 Jan 2019 17:45:05 +0100
Message-Id: <20190115164507.14676-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I somehow forgot about this patch set. The discussion about v1 was
inconclusive, so I'm sending it again with changes according to the
feedback I got. I still think it is useful, so please consider.

Changes since v1:
- timeout changed to 15 seconds (Josh)
- make it wait for 15 seconds, no more, no less (Josh)
- the message in klp_send_signals() is printed only once per transition
  (Josh)
- the counter is zeroed in klp_start_transition(), so that even
  klp_reverse_transition() starts correctly (Petr)

Miroslav Benes (2):
  livepatch: Send a fake signal periodically
  livepatch: Remove signal sysfs attribute

 .../ABI/testing/sysfs-kernel-livepatch        | 12 ---
 Documentation/livepatch/livepatch.txt         | 15 ++-
 kernel/livepatch/core.c                       | 32 -------
 kernel/livepatch/transition.c                 | 93 +++++++++++--------
 kernel/livepatch/transition.h                 |  1 -
 5 files changed, 59 insertions(+), 94 deletions(-)

-- 
2.20.1

