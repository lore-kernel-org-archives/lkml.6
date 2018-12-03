Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FFAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75029206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75029206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeLCNzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:55:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:52886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbeLCNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:55:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58253AC1F;
        Mon,  3 Dec 2018 13:53:53 +0000 (UTC)
Date:   Mon, 3 Dec 2018 14:53:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203135351.GU31738@dhcp22.suse.cz>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203131006.GA10054@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 14:10:06, Pavel Machek wrote:
> On Mon 2018-12-03 13:38:57, Michal Hocko wrote:
> > On Mon 03-12-18 13:31:49, Oleg Nesterov wrote:
> > > On 12/03, Michal Hocko wrote:
> > > >
> > > > Now, I wouldn't mind to revert this because the code is really old and
> > > > we haven't seen many bug reports about failing suspend yet. But what is
> > > > the actual plan to make this work properly?
> > > 
> > > I don't see a simple solution...
> > > 
> > > But we need to fix exec/de_thread anyway, then we can probably reconsider
> > > this patch.
> > 
> > My concern is that de_thread fix might be too disruptive for stable
> > kernels while we might want to have a simple enough fix for the the
> > suspend issue in the meantime. That was actually the primary reason I've
> > acked the hack even though I didn't like it.
> 
> Do we care about failing sleep in stable? Does someone hit the issue there?
> 
> This sounds like issue only Android is hitting, and they run very
> heavily patched kernels, far away from mainline or stable.

But the underlying issue is the same and independent on their patches
AFAIU. And is this really a common problem to care about in stable? I
dunno to be honest but it sounds annoying for sure. Failing suspend is
something that doesn't make your day when you are in hurry and want
find out only later when your laptop heats up your bag ;)

-- 
Michal Hocko
SUSE Labs
