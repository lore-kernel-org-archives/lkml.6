Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F2BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9953820989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cYJ3T9uV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cYJ3T9uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9953820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeK0Ub6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:31:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeK0Ub6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:31:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD0C060BFA; Tue, 27 Nov 2018 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543311279;
        bh=TJtma5UiwK2M4mgc34I/F/Q5xaapkpIstkPgCpjpgHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYJ3T9uVI1tEPv5P5mJysMhsRTqTwZvLEnagDjm32wE9qGxHjGsx4g8hkWc93bLLJ
         RKwjklVrVgHbf8lTBATD167eJ0EAQW2VX/832eOL2mgiu9qIPAUhEaBIcwhZy3NvA7
         IkLzzH5Jh9Y9oVaTg29DUV+6aoQYlDXwMOcwTEG4=
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D220B60BE8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543311279;
        bh=TJtma5UiwK2M4mgc34I/F/Q5xaapkpIstkPgCpjpgHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYJ3T9uVI1tEPv5P5mJysMhsRTqTwZvLEnagDjm32wE9qGxHjGsx4g8hkWc93bLLJ
         RKwjklVrVgHbf8lTBATD167eJ0EAQW2VX/832eOL2mgiu9qIPAUhEaBIcwhZy3NvA7
         IkLzzH5Jh9Y9oVaTg29DUV+6aoQYlDXwMOcwTEG4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D220B60BE8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Received: by mail-ed1-f45.google.com with SMTP id j6so18375797edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:34:38 -0800 (PST)
X-Gm-Message-State: AGRZ1gIyHCDs8TkNcnhuX9qgOE4hkfN5sHj+LRHMk3fy5n/Mv8BVe8OG
        5HoFUN3hfVXdd1vDpAGJDk4LSVkIMF+ShHjAkv0=
X-Google-Smtp-Source: AJdET5fD7+YFnPrH0DFZU2xtKV7OjmpGs7EtCu0+xOBUXE0OIu7+kmU3c2GA/8ta9ngjWdnGhME8y0+crydMIM62NMI=
X-Received: by 2002:a17:906:92d1:: with SMTP id d17-v6mr22731711ejx.96.1543311277506;
 Tue, 27 Nov 2018 01:34:37 -0800 (PST)
MIME-Version: 1.0
References: <1540882473-1103-1-git-send-email-pkondeti@codeaurora.org>
In-Reply-To: <1540882473-1103-1-git-send-email-pkondeti@codeaurora.org>
From:   Pavan Kondeti <pkondeti@codeaurora.org>
Date:   Tue, 27 Nov 2018 15:04:25 +0530
X-Gmail-Original-Message-ID: <CAEU1=PkZQGEZueS=cLOT9kbGeMBptKRL=A56BrBgG85R9PrHDA@mail.gmail.com>
Message-ID: <CAEU1=PkZQGEZueS=cLOT9kbGeMBptKRL=A56BrBgG85R9PrHDA@mail.gmail.com>
Subject: Re: [PATCH] sched, trace: Fix prev_state output in sched_switch tracepoint
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter/Thomas,

On Tue, Oct 30, 2018 at 12:25 PM Pavankumar Kondeti
<pkondeti@codeaurora.org> wrote:
>
> commit 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
> tried to fix the problem introduced by a previous commit efb40f588b43
> ("sched/tracing: Fix trace_sched_switch task-state printing"). However
> the prev_state output in sched_switch is still broken.
>
> task_state_index() uses fls() which considers the LSB as 1. Left
> shifting 1 by this value gives an incorrect mapping to the task state.
> Fix this by decrementing the value returned by __get_task_state()
> before shifting.
>
> Fixes: 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  include/trace/events/sched.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Can you please review this patch?

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
