Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E51C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E33204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E33204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeIJUqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:46:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:40965 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbeIJUqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:46:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 08:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="88753322"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 10 Sep 2018 08:51:13 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Sep 2018 18:51:13 +0300
Date:   Mon, 10 Sep 2018 18:51:13 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Message-ID: <20180910155112.GT5565@intel.com>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
 <20180910140710.GR5565@intel.com>
 <20180910144720.GA28349@zn.tnic>
 <20180910150910.GS5565@intel.com>
 <20180910152538.GA4386@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910152538.GA4386@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 05:25:38PM +0200, Borislav Petkov wrote:
> On Mon, Sep 10, 2018 at 06:09:10PM +0300, Ville Syrjälä wrote:
> > But it is a patch, and if it happens to get accepted as is so be
> > it. If not, it's a good place where to start the conversation on
> > how to fix the bug in another way.
> 
> Uh, more of that "logic".
> 
> It is a patch but not really, if it is applied, good, if not, also good.
> WTF dude?
> 
> > You guys seem to have a notion that anything which says '[PATCH]'
> > is somehow final. In my book any patch is up for debate. Nothing
> > special about this one in that regard.
> 
> Well, let's see: imagine you're a maintainer. You get gazillion patches
> a day. And you think, oh well, I need to review and possibly apply this.
> And then move on to the next one. Because everyone is asking, when is
> she/he going to apply my damn patches...

Sounds to me like the maintainer should figure out how to delegate some
of the load a bit. Or just go on vacation and ignore all mails. I hear
stress isn't good for you.

> 
> But nooo, *some* of the patches are special - they're a conversation
> starter *only*! But also if applied, that's fine too.

That's what all patches are. No should be applying unreviewed patches
blindly.

Also often a revert is a perfect way to handle regressions. It gets
the angry users off your back ASAP allowing you to fix the bug
properly without having to rush it. I only wish all regression I've
caused would have been caught early enough for a revert to apply
cleanly. 

Even if the revert isn't applied the fact that the mail has the 
offending code right there makes the disussion easier. No need to
git fetch; git show <copy paste sha>; copy paste some code snippets
into the mail, etc.).

> 
> What a bunch of bull!

Calm down. No one is out to revert all your patches.

> 
> What's wrong with sending a mail tagged with "[REGRESSION]" - this looks
> like the tag people have adopted - and explain what the problem is, what
> you've bisected it to and what your observations are? Like everyone else
> reporting bugs/regressions/...

Maybe you can propose a new git-regression tool then? And document that
you want bugs reported using it? Ideally I'd say it should do almost
exactly what git revert does except s/revert/regression/. Though I
suppose it could include the original diff instead of the reverse.

Now, how about we stop this pointless "logic" discussion and
focus on the techinal stuff from now on?

-- 
Ville Syrjälä
Intel
