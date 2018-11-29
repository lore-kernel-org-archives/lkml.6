Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB02C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274E720868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274E720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbeK3D7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:59:35 -0500
Received: from foss.arm.com ([217.140.101.70]:39354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeK3D7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:59:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F07A78;
        Thu, 29 Nov 2018 08:53:34 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0B423F59C;
        Thu, 29 Nov 2018 08:53:32 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:53:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: ftrace: Fix to enable syscall events on arm64
Message-ID: <20181129165329.GC22027@arrakis.emea.arm.com>
References: <20181128195921.GA32668@arm.com>
 <154346997347.21404.9819884326251206341.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154346997347.21404.9819884326251206341.stgit@devbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:39:33PM +0900, Masami Hiramatsu wrote:
> Since commit 4378a7d4be30 ("arm64: implement syscall wrappers")
> introduced "__arm64_" prefix to all syscall wrapper symbols in
> sys_call_table, syscall tracer can not find corresponding
> metadata from syscall name. In the result, we have no syscall
> ftrace events on arm64 kernel, and some bpf testcases are failed
> on arm64.
> 
> To fix this issue, this introduces custom
> arch_syscall_match_sym_name() which skips first 8 bytes when
> comparing the syscall and symbol names.
> 
> Fixes: 4378a7d4be30 ("arm64: implement syscall wrappers")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: stable@vger.kernel.org

Queued for 4.20. Thanks.

-- 
Catalin
