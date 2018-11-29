Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5162AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFB321019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5MmcUkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFB321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeK3B7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbeK3B7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:59:49 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDBD2081C;
        Thu, 29 Nov 2018 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543503251;
        bh=SOnfUg8Afozf0gJNbA3EygZAhxj/J434lkZ2jrg0fHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p5MmcUkMfbSLhA3VLSkj/nOdyZfncf5vhJGihbPQzbXrSHas+PH3y6UEGfNKoByrW
         3MRucbLkgnmBKL0C+QdSwKEPO01u6/9g5YarGZ3vCwIObChI/bjuypkwYp6FCajtpV
         rjjhAdQ0A9oUQVTtCphpc/FiQBm/1q5r/Wszq+FM=
Date:   Thu, 29 Nov 2018 23:54:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v7 00/16] tracing: Hist trigger snapshot and onchange
 additions
Message-Id: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
In-Reply-To: <20181129225225.00ab1709c79f63c8e08b49c7@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
        <20181126230928.17883eecfaefd6a29cbbd1c3@kernel.org>
        <1543267288.2529.25.camel@kernel.org>
        <20181129225225.00ab1709c79f63c8e08b49c7@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 22:52:25 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> > For that system, I'm using Gnome terminal 3.24.2 and GNU bash, version
> > 4.4.12(1)-release (x86_64-pc-linux-gnu) (Ubuntu 17.10).
> > 
> > If I change 'echo' to '/bin/echo' in e.g. prlog() it works fine, so it
> > must be the inbuilt bash echo that's not doing the right thing.  I
> > thought it might be the xpg_echo option, but 'shopt -s xpg_echo'
> > doesn't have any effect.
> > 
> > I also tried on a Fedora 28 system (GNOME terminal 3.28.2, GNU bash,
> > version 4.4.23(1)-release (x86_64-redhat-linux-gnu), and it worked
> > fine.
> > 
> > Also, tried a Ubuntu 18.04.1 system (GNOME Terminal 3.28.1, GNU bash,
> > version 4.4.19(1)-release (x86_64-pc-linux-gnu) and in that case the
> > colors worked fine, but still got the '-e -n' and newlines in the
> > output:
> > 
> > -e -n [28] (instance)  event trigger - test histogram modifiers
> > -e 	[PASS]
> > -e -n [29] (instance)  event trigger - test histogram trigger
> > -e 	[PASS]
> > 
> > Again, substituting '/bin/echo' in prlog() fixed things in this case
> > too.   I guess the builtin bash 'echo' can't be relied on..
> 
> OK, then we should use /bin/echo for avoiding this issue.


Ah, I found that usually ubuntu system use "dash" instead of
"bash" for the alias of "sh", and its builtin echo command doesn't
accept "-e". So if the first option is "-e", it treats all arguments
are output string, including -e.

Anyway, still using /bin/echo is the best solution.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
