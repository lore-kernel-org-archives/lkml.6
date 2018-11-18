Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D2EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E12080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E12080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sr71.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeKSJEG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:04:06 -0500
Received: from www.sr71.net ([198.145.64.142]:42799 "EHLO blackbird.sr71.net"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbeKSJEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:04:06 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2018 04:04:05 EST
Received: from [10.6.227.155] (50-206-94-218-static.hfc.comcastbusiness.net [50.206.94.218])
        (Authenticated sender: dave)
        by blackbird.sr71.net (Postfix) with ESMTPSA id BA066FA863;
        Sun, 18 Nov 2018 14:35:21 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: STIBP by default.. Revert?
From:   Dave Hansen <dave@sr71.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
Date:   Sun, 18 Nov 2018 14:35:20 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <30141361-EFDC-4547-82D7-7AAAC556B9F5@sr71.net>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com> <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm> <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com> <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 18, 2018, at 2:17 PM, Jiri Kosina <jikos@kernel.org> wrote:
> 
> It's probably not just browsers, but anything running JITed sandboxed 
> code. So the most straightforward way might be the prctl() aproach, where 
> userspace would claim "I do care about this, please fix it up for me". So 
> prctl() + perhaps SECCOMP.

Yeah, the prctl() shifts the pain to the right place: folks explicitly opting in.  Always-on seemed way too draconian to me.
