Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4861BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37C620877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37C620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJEDg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:36:27 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58459 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJEDg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:36:26 -0400
X-Originating-IP: 134.134.139.83
Received: from localhost (unknown [134.134.139.83])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 73B59E0002;
        Thu,  4 Oct 2018 20:41:21 +0000 (UTC)
Date:   Thu, 4 Oct 2018 13:41:18 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Felix Fietkau <nbd@nbd.name>, kconfig-sat@googlegroups.com
Subject: Re: [kconfig-sat] [ANN] init-kconfig - easy way to embrace Linux's
 kconfig
Message-ID: <20181004204117.GA10640@localhost>
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
 <20181004200859.GA10237@localhost>
 <20181004203950.GN5238@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004203950.GN5238@garbanzo.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:39:50PM -0700, Luis Chamberlain wrote:
> On Thu, Oct 04, 2018 at 01:09:00PM -0700, Josh Triplett wrote:
> > On Thu, Oct 04, 2018 at 01:02:49PM -0700, Luis Chamberlain wrote:
> > > Every now and then a project is born, and they decide to use Linux's
> > > kconfig to enable configuration of their project. As it stands we *know*
> > > kconfig is now used in at least over 12 different projects [0]. I myself
> > > added kconfig to one as well years ago. Even research reveals that
> > > kconfig has become one of the leading industrial variability modeling
> > > languages [1] [2].
> > > 
> > > What is often difficult to do though is to start off using kconfig and
> > > integrating it into a project. Or updating / syncing to the latest
> > > kconfig from upstream Linux.
> > > 
> > > I had yet another need to use kconfig for another small project so
> > > decided to make a clean template others can use and help keep it in sync.
> > > This is a passive fork which aims to keep in sync with the Linux
> > > kernel's latest kconfig to make it easier to keep up to date and to
> > > enable new projects to use and embrace kconfig on their own.  The goal
> > > is *not* to fork kconfig and evolve it separately, but rather keep in
> > > sync with the evolution of kconfig on Linux to make it easier for
> > > projects to use kconfig and also update their own kconfig when needed.
> > 
> > Is there a *fundamental* reason that we couldn't have this *be* Linux
> > kconfig, whether pulled in by submodule or regular merges, and avoid
> > having any divergence at all?
> 
> The structure of kconfig in Linux would have to be changed to make
> adoption and sync easier. If that is a goal we wish to embrace, I'm
> all for it.

I would *love* to see Kconfig in Linux evolved to be more easily reused.
