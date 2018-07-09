Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A29920849
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOuoJNKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A29920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeGIXRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:17:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbeGIXRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U36xIEmqEskdaGqich4i8esi/GwOTI5jrjetBNxdjy4=; b=GOuoJNKMFrR1wfpj/oIlrICbX
        ZGal3ipXlJjuTkr8NDqjswIvTAlIUSRdG20uybN+kNxrEemjEkgDxpEHxUOUUkYdKq2T4KyHrfi36
        wSsHgRWRRhYKD/1FtrOZGNoChhwqBwmMg0hnNP0W0AZEMVz29sCKxEMKRNjqLySbYKFaTLxerzFEK
        5RSc1QclMh1Chx4CrHYNVOOLr7o5tuD7k8e/u9tMYyJVgcMiInknN5+i0j6+7wxFxXtF6Rh4Y1Aq5
        BlWKDM6HdGoAcWVw9mJSxqxssF7fXesVa3jEmTynO/sHZ1VF+TkN8nZiz7qHpU+cDKfPdFdQTigId
        jwHHuiTEg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcfP4-0004Ja-7N; Mon, 09 Jul 2018 23:17:10 +0000
Date:   Mon, 9 Jul 2018 16:17:09 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mario.Limonciello@dell.com
Cc:     srinivas.pandruvada@linux.intel.com, andy.shevchenko@gmail.com,
        alex.hung@canonical.com, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Message-ID: <20180709231709.GA25221@fury>
References: <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
 <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
 <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
 <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
 <20180706235907.GE3041@fury>
 <ccb18d853b254f680895c45862274ec8bdd70ab0.camel@linux.intel.com>
 <1dfb07bd3461414e8db492e643d7de88@ausx13mpc120.AMER.DELL.COM>
 <20180709210646.GA30247@fury>
 <b79253ee160b4d08a48ac0a805939296@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79253ee160b4d08a48ac0a805939296@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:08:56PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Monday, July 9, 2018 4:07 PM
> > To: Limonciello, Mario
> > Cc: srinivas.pandruvada@linux.intel.com; andy.shevchenko@gmail.com;
> > alex.hung@canonical.com; andy@infradead.org; platform-driver-
> > x86@vger.kernel.org; linux-kernel@vger.kernel.org; rjw@rjwysocki.net
> > Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device Specific
> > Methods
> > 
> > On Mon, Jul 09, 2018 at 04:38:16AM +0000, Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com]
> > > > Sent: Saturday, July 7, 2018 8:44 AM
> > > > To: Darren Hart; Andy Shevchenko
> > > > Cc: Limonciello, Mario; Alex Hung; Andy Shevchenko; Platform Driver; Linux
> > Kernel
> > > > Mailing List; Rafael J. Wysocki
> > > > Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device Specific
> > > > Methods
> > > >
> > > > On Fri, 2018-07-06 at 16:59 -0700, Darren Hart wrote:
> > > > > On Mon, Jul 02, 2018 at 05:06:14PM +0300, Andy Shevchenko wrote:
> > > > > > On Mon, Jul 2, 2018 at 4:51 PM,  <Mario.Limonciello@dell.com>
> > > > > > wrote:
> > ...
> > > > Mario can add more.
> > > > But I think Dell has released a BIOS fix, so that power button can
> > > > still work using non _DSM way. So I think we can wait for normal
> > > > release cycle.
> > >
> > > Yeah, I added some comments on a separate reply already indicating this.
> > >
> > > The affected system we know about has reverted the new interface.
> > >
> > > This all stems from an expectation that the _DSM has been there for "many"
> > > releases on the Windows side.  Long enough that even all the corporate
> > downgrade
> > > scenarios to older Windows versions and the drivers with them all worked
> > properly.
> > >
> > > If this doesn't end up being a candidate for backporting to stable we'll probably
> > > end up asking our various OS partners to backport it as a SAUCE type patch in
> > distro
> > > kernels to eventually be able to turn this back on.
> > 
> > Thanks Mario. We'll skip the RC. We can discuss -stable as a separate
> > issue.  This patch fixes a demonstrable bug, the biggest obstacle here
> > is the size. At 240 lines with context, it more than doubles the maximum
> > patch size for stable.
> > 
> > My recommendation is that we treat the stable backport of this as a
> > special case, e.g. Andy and I don't tag it, but you or Srinivas propose
> > it and specifically make the case for why an exception should be made to
> > Greg.
> > 
> > How self contained and isolated this change is will be an important part
> > of the argument. On the one hand, it's all one file, on the other hand,
> > this is a fairly generic driver in use in more and more platforms, with
> > the potential for widespread impact if this introduces a new bug.
> > 
> 
> In that case, how about we let it bake for a while and maybe by the time
> 4.19 comes out is when we do the proposal of a stable backport?

Works for me.
-- 
Darren Hart
VMware Open Source Technology Center
