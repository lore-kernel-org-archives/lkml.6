Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02653C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACAA218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550688319;
	bh=Z14sohowVdS8S3WpA0mCm6ds57WuCh4Ok8xGuQg5pMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=cXms9lU1r/1xzRt4muzU5n+bzMhIrCQWhC58Q69XqFvJoyFHu03lckuiLeallhTJR
	 31aR2ODtGJGG3T1kjlYqSsZfEnAsQ2lcwK7RKyUyO01yhe/G5LBs1AIqtwljV800HC
	 NIwb1gI1nb1jJbW8/b708gA4eCVZdUaemWySlREY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfBTSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfBTSpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:45:17 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4303D21848;
        Wed, 20 Feb 2019 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550688317;
        bh=Z14sohowVdS8S3WpA0mCm6ds57WuCh4Ok8xGuQg5pMs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JKxdpfeKsl2Ax/Ncb1Y1J9rD+EryYerspU/L975ddRMsFMdzCipAZtEWMmJYIdVDp
         f2jQllJOukbSVP+r4v4Gyjn4B5fXcdxCtJ1QU7/NtVkgFfKJ3il81uMoc7MbQpepEL
         BQ04n0U2d81Y51pH+RUkh0c0z4yR0YNo/R553ffs=
Message-ID: <1550688315.2027.20.camel@kernel.org>
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 20 Feb 2019 12:45:15 -0600
In-Reply-To: <20190220133316.587f3941@gandalf.local.home>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
         <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
         <20190220121748.7aa83459@gandalf.local.home>
         <1550684302.2027.6.camel@kernel.org>
         <20190220125625.77802cac@gandalf.local.home>
         <1550686231.2027.14.camel@kernel.org>
         <20190220133316.587f3941@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-20 at 13:33 -0500, Steven Rostedt wrote:
> On Wed, 20 Feb 2019 12:10:31 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > 
> > As far as I understand it (there's no other case of an xfail test
> > in
> > the testsuite, so nothing similar to compare it to), the test
> > output is
> >  correct - here we get the expected fail, XFAIL, and not a FAIL as
> > any
> > test, xfail or normal, that failed would produce:
> 
> Yeah, I've been staring at the code, and commit:
> 
> 915de2adb584a ftracetest: Add POSIX.3 standard and XFAIL result codes
> 
> 
> > 
> > tools/testing/selftests/ftrace# ./ftracetest test.d/trigger/
> > === Ftrace unit tests ===
> > [1] event trigger - test inter-event histogram trigger expected
> > fail actions
> > [XFAIL]
> > [2] event trigger - test extended error support
> > [PASS]
> > 
> > And here the summary shows none failed, while we did have one
> > expected
> > xfail, but that's what was expected, and not a failure:
> > 
> > # of passed:  31
> > # of failed:  0
> > # of unresolved:  0
> > # of untested:  0
> > # of unsupported:  0
> > # of xfailed:  1
> 
> Yeah, but it's marked as RED, which is why I thought it was a
> failure.
> 
> > # of undefined(test bug):  0
> > 
> > If that's not correct, I'll fix it but at this point I'm not sure
> > what
> > the output should be if not that.
> 
> OK, so this has nothing to do with your patch set. I've tested
> everything else, and I'm ready to finally push my tree to linux-next.
> 
> I'm thinking that we should get rid of xfail, as it's really
> confusing,
> and I don't understand its purpose. But that shouldn't stop pushing
> your patches.
> 

OK, I'm fine with removing it, if it's too confusing.  IIRC Masami
suggested it to highlight that not all actions and handlers can be used
together, so I guess I'll hold off on a patch removing it until he can
chime in...

Thanks,

Tom 
 
> Thanks,
> 
> -- Steve
