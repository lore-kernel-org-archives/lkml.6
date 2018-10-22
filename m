Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A73C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73A020665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECw+Ec2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73A020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeJWEew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbeJWEew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:34:52 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B5520651;
        Mon, 22 Oct 2018 20:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540239295;
        bh=KHvSXA7XsFMua0zmskXORZwqCSjiZ1LhVD3iJMuO06c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ECw+Ec2NIeHupeWQe46bW4N9gdLjiNipdP+eBUKWpEOQc2GMPTkC7PZ7ekZwmFn5Q
         BlmdIY9P7YRiK8QpD1izWhQbjqL5S0GxCVgXohMTXeATn+G5BUYWfFwiuralEbUK6X
         HUi6WPZWcjD9K0C3faRMHmCJNoUGA7/sQ/ImbAFU=
Message-ID: <1540239293.4393.6.camel@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event parser
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>, linux-kernel@vger.kernel.org
Date:   Mon, 22 Oct 2018 15:14:53 -0500
In-Reply-To: <154013446976.25576.14780785912268176178.stgit@devbox>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, 2018-10-22 at 00:07 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> I found another bug in synthetic event. This is a small fix, but
> confusingly, there is also a bug in a test case.
> 
> Steve, since the testcase bugfix ([2/2]) breaks the test result
> unless corresponding fix ([1/2]), I would like to ask you to send
> these fixes from your tree.
> Shuah, could you give this your ack?
> 

Yes, I think the silent failing mode is confusing to users, and so
these changes make more sense.

Acked-by: Tom Zanussi <zanussi@linux.intel.com>
Tested-by: Tom Zanussi <zanussi@linux.intel.com>

Thanks,

Tom


> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       tracing: Return -ENOENT if there is no target synthetic event
>       selftests/ftrace: Fix synthetic event test to delete event
> correctly
> 
> 
>  kernel/trace/trace_events_hist.c                   |    4 +++-
>  .../trigger-synthetic-event-createremove.tc        |   12 ++++++--
> ----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
