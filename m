Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F290EECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E052086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E052086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeJRDrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeJRDrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:47:21 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D649A2086E;
        Wed, 17 Oct 2018 19:50:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gCrpW-0007Ov-M7; Wed, 17 Oct 2018 15:50:06 -0400
Message-Id: <20181017194939.044060850@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 17 Oct 2018 15:49:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: Two fixes for 4.19
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus (aka Greg),

This fixes two bugs:

 - Fix size mismatch of tracepoint array

 - Have preemptirq test module use same clock source of the selftest

Please pull the latest trace-v4.19-rc8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19-rc8

Tag SHA1: 3a6f9f3dd0418408f594c295e3b8ff6d3528460f
Head SHA1: 12ad0cb2123aed30241a14792ef5bef9efcccbcd


Mathieu Desnoyers (1):
      tracepoint: Fix tracepoint array element size mismatch

Steven Rostedt (VMware) (1):
      tracing: Use trace_clock_local() for looping in preemptirq_delay_test.c

----
 include/linux/module.h               |  3 ++-
 include/linux/tracepoint-defs.h      |  6 ++++++
 include/linux/tracepoint.h           | 36 +++++++++++++++++++++++-------------
 kernel/trace/preemptirq_delay_test.c | 10 +++++-----
 kernel/tracepoint.c                  | 24 ++++++++----------------
 5 files changed, 44 insertions(+), 35 deletions(-)
