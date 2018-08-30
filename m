Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D68C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9137C20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0pJU757n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9137C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeH3Wmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeH3Wmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:42:45 -0400
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6D420658;
        Thu, 30 Aug 2018 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535654355;
        bh=rItQ1g1LYxPfc5U/7NeIh2zXL+cME4vjTHrombwRmAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0pJU757nhRJxJCEb9DNWhQ495noNpQ2HT2/nWitnazswkps5CzgZlLbllOamSnnRv
         3QObI3wAZ6JsXlMTlyfe7RMIXh36wBFJJ+C5tFn+/M22PiWB3RE1wpCG0K1krWD4Hg
         QA1QjfNZYd/fQ6fR1P8HRHI55Vw4iZj95akYVXxo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8107E141C3F; Thu, 30 Aug 2018 15:39:05 -0300 (-03)
Date:   Thu, 30 Aug 2018 15:39:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCHv4 0/5] perf/hw_breakpoint: Fix breakpoint modify
Message-ID: <20180830183905.GG6097@kernel.org>
References: <20180827091228.2878-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827091228.2878-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 27, 2018 at 11:12:23AM +0200, Jiri Olsa escreveu:
> hi,
> Milind reported that modify_user_hw_breakpoint wouldn't
> allow the breakpoint changing if the new attr had 'disabled'
> set to true.
> 
> I found a case where it actualy prevents ptrace user interface
> to change the breakpoint. It's described in patch 1 as perf test,
> patch 2 is the breakpoint code fix.
> 
> I ran strace tests, nothing (new) broken there..

Thanks, tested and applied.

- Arnaldo
