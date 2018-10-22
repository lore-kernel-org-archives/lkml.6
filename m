Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B7C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7065020665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0S8c+00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7065020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeJWEaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeJWEaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:30:04 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE5220663;
        Mon, 22 Oct 2018 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540239009;
        bh=mtcFsECjjHykK7AIsoNxKTL6bwfHRKFMzS8CprVr+bc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q0S8c+00nBem7ESmxgDywc5RMAn6RtbOw8jT0KFFWtQbsm9LaEAI65p8xVRREN1Pj
         ywNH1KjEeunY0Ceu+kwAT+qUGZoV1ZQQJ7vmPCu6cFenXA3PXzb7upNtdIA1tHPcF3
         vsKcCYWDfi92ttrhGq9KKJ5kGUSQYU+hWIaZlvxA=
Message-ID: <1540239006.4393.2.camel@kernel.org>
Subject: Re: [PATCH v2 0/3] tracing: Fix synthetic event parser
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 22 Oct 2018 15:10:06 -0500
In-Reply-To: <153986829702.18251.1286066460999338772.stgit@devbox>
References: <153986829702.18251.1286066460999338772.stgit@devbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Sorry for the late reply on this - was out on vacation last week.

On Thu, 2018-10-18 at 22:11 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> Here are 2 fixes for synthetic event parser and its testcase.
> One bug is that the synthetic_events can not accept "unsigned"
> modifier for the field type, and another one is not allowing
> the last independent semicolon.
> 
> I found that there is no testcase for checking it too. So the
> last patch in this series adding a testcase for synthetic
> event parser.
> 

These patches look good to me, so for the lot:

Acked-by: Tom Zanussi <zanussi@linux.intel.com>
Tested-by: Tom Zanussi <zanussi@linux.intel.com>

Thanks,

Tom


> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       tracing: Fix synthetic event to accept unsigned modifier
>       tracing: Fix synthetic event to allow semicolon at end
>       selftests: ftrace: Add synthetic event syntax testcase
> 
> 
>  kernel/trace/trace_events_hist.c                   |   32 ++++++--
>  .../inter-event/trigger-synthetic-event-syntax.tc  |   80
> ++++++++++++++++++++
>  2 files changed, 105 insertions(+), 7 deletions(-)
>  create mode 100644
> tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> synthetic-event-syntax.tc
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
