Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9121526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1nFkVuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD9121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJQQRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeJQQRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:17:03 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD5821523;
        Wed, 17 Oct 2018 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539764549;
        bh=D4rPEJNdvNEJukIZKApS1VRmdu3BG1LUlwfZWNrnK3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1nFkVuZ+24VUmqfuI/8lNrQoufXYRS4CNCxFjXNnXTls0gFdE5rzhv1gHmL+W6IQ
         voq/4SJrxiFinMif3jnyo88um/I6tUwZtpz9muX5D4kgKgk4C0jdbE8BmM5B66jQTM
         XEfYTfujKXNawaqvubrc/6ETz1wVAVvhqEebeB6w=
Date:   Wed, 17 Oct 2018 17:22:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: perf's handling of unfindable user symbols...
Message-Id: <20181017172226.7274498db2bbe3431c3f4057@kernel.org>
In-Reply-To: <20181016184506.GB3254@redhat.com>
References: <20181014.004238.292485794143606801.davem@davemloft.net>
        <20181015222546.GA2159@redhat.com>
        <20181015.160246.58484704665215987.davem@davemloft.net>
        <20181016184506.GB3254@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 15:45:06 -0300
Arnaldo Carvalho de Melo <acme@redhat.com> wrote:

> 
> So, I thought something had changed and in the past we would somehow
> find that address in the kallsyms, but I couldn't find anything to back
> that up, the patch introducing this is over a decade old, lots of things
> changed, so I was just thinking I was missing something.
> 
> I tried a gtod busy loop to generate vdso activity and added a 'perf
> probe' at that branch, on x86_64 to see if it ever gets hit:
> 
> Made thread__find_map() noinline, as 'perf probe' in lines of inline
> functions seems to not be working, only at function start. (Masami?)

Thank you for reporting it. Hmm, what happened when you did it?
I checked some points, but seems no problem.
(Would you see no line number? or defined event didn't work?)

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
