Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62425C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFFE208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFFE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeLESdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLESdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:33:06 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F367620645;
        Wed,  5 Dec 2018 18:33:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUbyp-0007ib-PE; Wed, 05 Dec 2018 13:33:03 -0500
Message-Id: <20181205174852.435233070@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 12:48:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        keescook@chromium.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/2] tracing: arm64: Make ftrace_replace_code() schedulable for arm64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a little more involved, and I would like to push this through my
tree. Can I get a reviewed-by/ack for the second (arm64) patch?

Anders, can you also test this to make sure that it fixes the issue you
see?

Thanks!

-- Steve


Steven Rostedt (VMware) (2):
      ftrace: Allow ftrace_replace_code() to be schedulable
      arm64: ftrace: Set FTRACE_SCHEDULABLE before ftrace_modify_all_code()

----
 arch/arm64/kernel/ftrace.c |  1 +
 include/linux/ftrace.h     |  1 +
 kernel/trace/ftrace.c      | 19 ++++++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)
