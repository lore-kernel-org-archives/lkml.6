Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C04DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1182175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549314453;
	bh=u8RsgOM7NbrUSc37vQuTMvp7TEcwCLFfrRBmCYOyjDg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iI6rN6rknoVUia67H64NxTFSvIUU9O0QRiw8QVJjVF7lJR6A8l2yBFr7yyBtcAEe4
	 hwFxUCj7Z9bEcPzTfxX+ZTqYmGoofXC9987mE+nL1BzKvD7Ks3p0WEzN57hjMc5jMF
	 4vTPezCaEy6+pyXXCWHmZWPRDyRvpPlCs6CdhpnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfBDVHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:32912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfBDVHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:07:31 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD4820815;
        Mon,  4 Feb 2019 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549314451;
        bh=u8RsgOM7NbrUSc37vQuTMvp7TEcwCLFfrRBmCYOyjDg=;
        h=From:To:Cc:Subject:Date:From;
        b=E3H8P7eAuWqwwnm7IFAhx/uaaiUMttcAVVrSRs+Brh/IOYNZPCl2YG+StnzwOUTk2
         T+2e2suExVaop4MMbJya8bT9Fd79QXkn87V48mf1V0S+rOcqha1NqlL8F0fI3GMd7I
         +0jYRFkm2pwY2kjbTM+k1B9EYsoe6TVP3ZiM/KFA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 0/2] A couple hist trigger patches
Date:   Mon,  4 Feb 2019 15:07:22 -0600
Message-Id: <cover.1549309756.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

Here are a couple miscellaneous hist trigger patches which can be
applied independently of the onchange/snapshot patches.

The first is just an additional use of str_has_prefix() that was
apparently missed in the original str_has_prefix() conversion, with an
update suggested by Joe Perches.

The second fixes a bug I noticed when testing the onchange/snapshot
fixes.

I pulled these out into this separate patchset because they should be
applied regardless of what happens with the onchange/snapshot patchset.

Thanks,

Tom


The following changes since commit 67748dbeaf2b1240c0b87588df4bb0fb9471a751:

  sh: ftrace: Fix missing parenthesis in WARN_ON() (2019-01-08 10:19:02 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-fixes-v1

Tom Zanussi (2):
  tracing: Use str_has_prefix() in synth_event_create()
  tracing: Use strncpy instead of memcpy for string keys in hist
    triggers

 kernel/trace/trace_events_hist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.14.1

