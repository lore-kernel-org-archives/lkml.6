Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED53C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B5420661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B5420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966935AbeFSQg3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:36:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966582AbeFSQg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:36:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE22D1596;
        Tue, 19 Jun 2018 09:36:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7963C3F246;
        Tue, 19 Jun 2018 09:36:27 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:36:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: An example of a much more impactful way of doing file
 system-specific fuzzing
Message-ID: <20180619163624.4sol67vmh7wrfgyo@lakrids.cambridge.arm.com>
References: <20180618051522.GC28120@thunk.org>
 <CACT4Y+aq6vXoQpFgg6-_rEttnM4i3j7ng5LkP9gbqX98im=afw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aq6vXoQpFgg6-_rEttnM4i3j7ng5LkP9gbqX98im=afw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I hope the below doesn't sound like a criticism; I am a *huge* fan of
syzkaller.

On Tue, Jun 19, 2018 at 06:18:07PM +0200, 'Dmitry Vyukov' via syzkaller wrote:
> On Mon, Jun 18, 2018 at 7:15 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 3. You say "not actionable reports without reproducers", but you can
> find hundreds of fixed bugs without reproducers at [1] and [2]. Fix
> ratio for bugs without reproducers is 66% which is not significantly
> lower than 76% for bugs with reproducers. A person without expertise
> in a particular subsystem (me) can't know if a bug is actionable by an
> expert in the subsystem (you) without first reporting this bug.

I think it might be possible to make this a bit easier, without any
manual effort per-bug.

For comparison, when the LKP kernel test robot reports a bug, it
provides a script to reproduce the issue in a VM, such that the
developer need only provide a kernel. The script launches the VM with
the right options, providing a filesystem if necessary, etc.

This is a little more actionale, since the developer need not expend any
effort trying to reproduce the correct envinronment, which can be
especially tricky for bugs that don't have a C reproducer.

Would it be possible for syzbot to do something similar?

Thanks,
Mark.
 
> [1] https://syzkaller.appspot.com/?fixed=upstream
> [2] https://github.com/google/syzkaller/blob/master/docs/linux/found_bugs.md
