Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DE520675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfBVREP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:04:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7335 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfBVREP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:04:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D16D4369CC;
        Fri, 22 Feb 2019 17:04:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B06B1001E9C;
        Fri, 22 Feb 2019 17:04:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 22 Feb 2019 18:04:14 +0100 (CET)
Date:   Fri, 22 Feb 2019 18:04:12 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Message-ID: <20190222170412.GB5596@redhat.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
 <20190220220020.GA16335@castle.DHCP.thefacebook.com>
 <20190221162923.GA26064@redhat.com>
 <20190221224352.GA24252@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221224352.GA24252@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 22 Feb 2019 17:04:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21, Roman Gushchin wrote:
>
> > > Generally speaking, any process hanging in D-state
> > > for a long time isn't the nicest object from the userspace's point of view.
> >
> > Roman, this is unfair comparison ;)
>
> Why not?

OK, you are trolling me, let me troll you back...

So, generally speaking, the very idea of freezer looks wrong, any process
hanging in do_freezer_trap() for a long time isn't the nicest object from
the userspace's point of view.

> > And, apart from reading/writing the registers, what can ptrace do with a frozen
> > tracee? This doesn't look like a "must have" feature to me.
>
> I think the minimal requirement is that the tracing application should not hang
> and wait for tracee to be unfrozen.
> So, imagine you're trying to debug an application in production with gdb,
> and occasionally gdb just hangs because some cluster management stuff froze
> the tracee's cgroup. Not the best user experience.

Firstly, gdb will likely hang anyway. Say, single-step will hang and ^C won't work.

Secondly, just imagine you're trying to debug an application in production with gdb,
and occasionally gdb just hangs because some cluster management stuff froze the
gdb's cgroup. Not the best user experience.



Roman, may be it was not clear, but I never said that ptrace/kill makes no sense.
But yes, we probably disagree about how much this is important. I won't really
argue, but so far I am not sure I understand how this can be implemented.

> > At least, may I ask you again to make (if possible) a separate patch which adds
> > the ability to kill/ptrace?
>
> I'll try, but not sure if it can make the code easier for review.
> It looks like this ability defines the implementation.

OK, I won't insist, I understand that this is not simple.

Oleg.

