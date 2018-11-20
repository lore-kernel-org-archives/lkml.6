Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21BB208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21BB208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbeKTM4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:56:30 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:48574 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726629AbeKTM4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:56:30 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 20 Nov 2018 11:29:43 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 20 Nov 2018 11:29:43 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 20 Nov 2018 11:29:43 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>, kernel-team@lge.com
Subject: Re: [PATCH 00/12] perf top: Rework processing code
Message-ID: <20181120022943.GF20153@sejong>
References: <20181119122016.22423-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On Mon, Nov 19, 2018 at 01:20:04PM +0100, Jiri Olsa wrote:
> hi,
> David reported issues with perf top loosing side band events
> so we moved mmap reading and hists processing into separated
> threads.
> 
> This patchset also adds dropping sample logic when the processing
> falls behind the reader thread. This way we get incomplete but
> current data in perf top.
> 
> Also available in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes

Beside the simple comment in 05/12 (and the related fix), it looks
good to me.  And I think we can do similar for hists->lock as well.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
