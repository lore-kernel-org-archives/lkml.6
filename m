Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5321581
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2R3XLlkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D5321581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeHYFMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 01:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeHYFMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 01:12:21 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C38205C9;
        Sat, 25 Aug 2018 01:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535160916;
        bh=aNUY2WOU50LHVpzvovtEbywPIRHqYHEhmZDcm0mTv0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2R3XLlkAYsywccHq8cEjqnRNbiGYrZaubSqh4LwwNzxQls+mYoUb2Utrmi40DHkvy
         0s2bbcAqn+b/iM1QIfKX7mmwZvP5Ud8h2Dyc6XJ5KXI82O6HdBLP/ZRwZCeoKf4PNj
         LZ7jiEUwLMyr0B2md3UZ3sbPFkX//SGzK7eRb2M8=
Date:   Sat, 25 Aug 2018 10:35:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/32] selftests/ftrace: Add --console hidden option
Message-Id: <20180825103513.5b86d42a7ee2d20435522fbb@kernel.org>
In-Reply-To: <20180824163737.0f47535a@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443703653.23257.12015337438174061938.stgit@devbox>
        <20180824163737.0f47535a@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 16:37:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:30:36 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add --console hidden option for debug test cases.
> > This option allows to put "sh" or something else
> > when the test case hits a bug.
> 
> Can you add more information to why and how this would be used.

For example, if you find a testcase which doesn't
pass, you can insert sh for interactive debug as below

  #!/bin/sh
  # description: sample test case

  good-command
  suspicious-wrong-command
  sh # <- add this for interactive debug


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
