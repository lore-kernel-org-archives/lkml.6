Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63209C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C46B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547170280;
	bh=MzN244KRXno61F4Z0wl9U4CiE9hw7fCydiIba+x3HTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZfyicmAV60aUHNXPnfFlq0Twr5qTlKGiwIxsSalfBK8f2Q8QH952sU0NxAWgeXvgu
	 fq/f/NgafsuZLEwUqi4nfxIXYr1ncI4JKBUBkqgXLLor2eJf/p6St5NOEJcbtnIiL0
	 chVy6lQuH37thiDDKUHQVsxYhyGv/Bqe7RN2FVgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAKBbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:31:19 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:37509 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfAKBbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:31:18 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 11 Jan 2019 10:31:16 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 11 Jan 2019 10:31:16 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 11 Jan 2019 10:31:16 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCHv2 0/6] perf session: Add reader object
Message-ID: <20190111013115.GA557@sejong>
References: <20190110101301.6196-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110101301.6196-1-jolsa@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On Thu, Jan 10, 2019 at 11:12:55AM +0100, Jiri Olsa wrote:
> hi,
> this patchset adds reader object to interface event
> processing for any data. It's defined as:
> 
>   struct reader {
>         int fd;
>         u64 data_size;
>         u64 data_offset;
>   };
> 
> Now we can simply define reader object for arbitrary file
> data portion and pass it to reader__process_events function
> to process its data.
> 
> It's preparation for multiple file storage under perf.data
> directory.

I'm looking forward to seeing it soon! :)

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> Available also in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/reader
> 
> Changes in v2:
>   - rebased on latest perf/core
>   - added dependency patch (1/6) that was omitted in the original post
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (6):
>       perf session: Rearrange perf_session__process_events function
>       perf session: Get rid of file_size variable
>       perf session: Add reader object
>       perf session: Add data_size to reader object
>       perf session: Add data_offset to reader object
>       perf session: Add reader__process_events function
> 
>  tools/perf/util/session.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
>  1 file changed, 50 insertions(+), 35 deletions(-)
