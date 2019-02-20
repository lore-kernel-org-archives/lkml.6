Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F3721841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfBTSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:33:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfBTSdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:33:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981942146E;
        Wed, 20 Feb 2019 18:33:17 +0000 (UTC)
Date:   Wed, 20 Feb 2019 13:33:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Message-ID: <20190220133316.587f3941@gandalf.local.home>
In-Reply-To: <1550686231.2027.14.camel@kernel.org>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
        <20190220121748.7aa83459@gandalf.local.home>
        <1550684302.2027.6.camel@kernel.org>
        <20190220125625.77802cac@gandalf.local.home>
        <1550686231.2027.14.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 12:10:31 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> 
> As far as I understand it (there's no other case of an xfail test in
> the testsuite, so nothing similar to compare it to), the test output is
>  correct - here we get the expected fail, XFAIL, and not a FAIL as any
> test, xfail or normal, that failed would produce:

Yeah, I've been staring at the code, and commit:

915de2adb584a ftracetest: Add POSIX.3 standard and XFAIL result codes


> 
> tools/testing/selftests/ftrace# ./ftracetest test.d/trigger/
> === Ftrace unit tests ===
> [1] event trigger - test inter-event histogram trigger expected fail actions
> [XFAIL]
> [2] event trigger - test extended error support
> [PASS]
> 
> And here the summary shows none failed, while we did have one expected
> xfail, but that's what was expected, and not a failure:
> 
> # of passed:  31
> # of failed:  0
> # of unresolved:  0
> # of untested:  0
> # of unsupported:  0
> # of xfailed:  1

Yeah, but it's marked as RED, which is why I thought it was a failure.

> # of undefined(test bug):  0
> 
> If that's not correct, I'll fix it but at this point I'm not sure what
> the output should be if not that.

OK, so this has nothing to do with your patch set. I've tested
everything else, and I'm ready to finally push my tree to linux-next.

I'm thinking that we should get rid of xfail, as it's really confusing,
and I don't understand its purpose. But that shouldn't stop pushing
your patches.

Thanks,

-- Steve
