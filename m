Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvHTXx4iVyKadYpX8TM6OY5rZRUI04oE7LwYdH3lfNieHZ0RvJMHnzhV5yeMmwFNvlpWQia
ARC-Seal: i=1; a=rsa-sha256; t=1520295440; cv=none;
        d=google.com; s=arc-20160816;
        b=kAXS0gozFdlkvRSEu+BOwxexPPBzUXBprdrS5BRscgtHru6FigljNBecIhdkN9Jn4E
         8Z52m6VYcl8vMo1lTiBfE17ppaXzUZ7KHXqoh6+huOCbJMVPnvGujHrNPMLasfr466Bg
         u3rWHIv8ta02c9iTYRgMCNPnqp68rVf8kiLjrDGAba7w8qjak7F0qsiyhZJJssobJGqi
         j8VoaapDsVfgbFBXs9obYax1iv1MjKP/c/Wz2ePxwOHtcjp2C/778u5bPmdYfUw1b5p0
         GDCSsjoFMhjhgpm+QF8WpJ+N0GrPbCa70ETU6OMWr6ZRyi4OsKfttW85iMx/5dg7ppUG
         VZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=sC/bcA3/qxD4CfHZZe6tivS0M7VfVZk7npQzRNTmM8I=;
        b=eHrOBr3T0g8Tligqr3TFJb2nLNGvFBxR2e3OPo3O3j6+C49H/09ZoSBWv0E2J+QjVj
         7u6BiRaUkyrWvIP6AIkBsEYhFiR4P/sHCzsGOOEtrtX8a++i7G9aMSkX33IWHj8xuXQP
         FSwZFjB4hkKCLLYGwd1yV6w7jsmU2VY9fqUJK/q+OAtWLE3mcrVJwHNe6CmUGMgdT8Wp
         Wth0cG75Tvym6VmSUZWMJIcSDolpp37p03xGrNGC1gJ/FPxwaekq9wHYWmdTVmq45Rl2
         wcS4gwgV/iwsGzMbXQmj63CZuCiFgcFhR08t9mra9H3eONtytsnhpyPCmNMmDFKXNB5v
         DvgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=NjKr/8NT;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=NjKr/8NT;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeCFART (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 5 Mar 2018 19:17:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeCFARS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Mar 2018 19:17:18 -0500
Date: Mon, 5 Mar 2018 16:17:13 -0800
From: Darren Hart <dvhart@infradead.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: mingo@redhat.com, shuah@kernel.org, tbird20d@gmail.com,
        tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests: futex Makefile add top level TAP header
 echo to RUN_TESTS
Message-ID: <20180306001713.GE25693@fury>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
 <bec2e6c01cbf3b2f6dc49e022a2a7543fc7f3182.1519423341.git.shuahkh@osg.samsung.com>
 <20180224214244.GA31352@fury>
 <d8c446cb-fa30-ec1f-944a-c7763a3e80b7@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c446cb-fa30-ec1f-944a-c7763a3e80b7@osg.samsung.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231540843660776?=
X-GMAIL-MSGID: =?utf-8?q?1594145311451941534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 10:25:44AM -0700, Shuah Khan wrote:
> On 02/24/2018 02:42 PM, Darren Hart wrote:
> > On Fri, Feb 23, 2018 at 03:11:40PM -0700, Shuah Khan wrote:
> >> Add top level TAP header echo, testname and separator line to make
> >> the output consistent with the common run_tests target.
> > 
> > No objection to the changes, but I'll echo Ingo's request for a more
> > detailed justification for why these changes are warranted. We've seen
> > this a few times with recent changes to kselftests, I think too much
> > might be being assumed regarding the individual test author's tracking
> > of the core of the kselftests ongoing work.
> > 
> 
> Ingo/Darren,
> 
> Sorry for not giving a better justification. I should have kept audience
> in mind that test authors might not be up on the framework changes.
> 
> Nested TAP header example:
> 
> TAP version 13
> selftests: step_after_suspend_test
> ========================================
> TAP version 13                                           (#Nested header)
> Bail out! open("/sys/power/state") failed (is this test running as root?)
> Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
> 1..0
> not ok 1..1 selftests:  step_after_suspend_test [FAIL]
> selftests: breakpoint_test
> ========================================
> TAP version 13                                            (#Nested header)
> Pass 110 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
> 
> <snip>
> 
> 1..110
> ok 1..2 selftests: breakpoint_test [PASS]
> 
> 
> Some tests print TAP headers. This is helpful when test is run by itself.
> However, when "make kselftest" or "make -C" is used then common run_tests
> does its TAP header and nested headers get printed.
> 
> Nested headers are a problem for TAP13 parsers. Hence, I decided to go
> with a simpler approach to suppress TAP headers using env. variable
> that gets checked in the framework and suppresses the header.
> 
> selftests: kselftest framework: add handling for TAP header level
> 
> This minimizes the churn to actual tests and framework handles the
> TAP details.
> 
> futex test overrides the generic run_tests, so it needed changes to
> add a top level TAP header. Otherwise, you will see nested TAP header
> for each of the individual futxex tests as shown in the example below.
> 
> 
> TAP version 13
> # futex_requeue_pi: Test requeue functionality
> #       Arguments: broadcast=0 locked=0 owner=0 timeout=0ns
> not ok 1 # error futex-requeue-pi
> Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 1
> 1..1
> 
> I can capture the nested TAP headers being a problem for parsers in
> the changelog. I will have to send v2 anyway, "make -C" still has
> the nested headers for fuxtex tests.
> 
> My goal is to not have the individual test authors be concerned about
> the TAP13 details and handle it in the framework. I am making changes
> to framework and test Makefiles for the TAP13 and other common formatting
> type features as opposed to individual test code. Test Makefiles that use
> lib.mk don't need changes either, futex needs changes mainly because of
> overrides.
> 
> Hope this help. I will do a better job of explaining in the future.

Thank you Shuah, this helps. I think this is also a good motivator to look at
the overrides we are using for the futex tests, and see if we can eliminate
them. As you point out, the fewer overrides we have, the less churn we
experience when the framework changes.

Most of the overrides as I recall were just used to minimize the number of
changes we had to make to what I had already written in the original tests. That
advantage seems to be losing out to impact from changes to the framework.

-- 
Darren Hart
VMware Open Source Technology Center
