Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35FAC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DABA2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DABA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeJEFBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725758AbeJEFBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:01:22 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD93D20877;
        Thu,  4 Oct 2018 22:05:56 +0000 (UTC)
Date:   Thu, 4 Oct 2018 18:05:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Felix Fietkau <nbd@nbd.name>, kconfig-sat@googlegroups.com
Subject: Re: [kconfig-sat] [ANN] init-kconfig - easy way to embrace Linux's
 kconfig
Message-ID: <20181004180555.0421b300@gandalf.local.home>
In-Reply-To: <20181004205319.GO5238@garbanzo.do-not-panic.com>
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
        <20181004200859.GA10237@localhost>
        <20181004203950.GN5238@garbanzo.do-not-panic.com>
        <20181004204117.GA10640@localhost>
        <20181004205319.GO5238@garbanzo.do-not-panic.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 13:53:19 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Thu, Oct 04, 2018 at 01:41:18PM -0700, Josh Triplett wrote:
> > I would *love* to see Kconfig in Linux evolved to be more easily reused.  
> 
> This *can* happen. Let me itemize a few things off of my head I think
> would need to be done as its at least fresh in my head now:
> 
> All we need from scripts/Kbuild.include is filechk and kecho (what I
> have in my scripts/Kbuild.include). This could be moved to
> scripts/Kbuild.basic, and so would make sync'ing easier.
> 
> The scripts/kconfig/Makefile would need a respective modifications to
> make it work independently, see my scripts/kconfig/Makefile. Perhaps
> the biggest pain was resolving the target for
> scripts/kconfig/.mconf-cfg. If somehow we end up with a file which could
> work for both environments we're set.
> 
> Other than this we'd need a simple script, say scripts/copy-kconfig.sh
> which would copy over only those files I took from scripts/kconfig.
> 
> There's a few things to consider for a split copy / demo:
> 
>   * versioning *is not* part of kconfig
>   * object building *is not* part of kconfig
> 
> But the problem I faced was that to demo kconfig I had to use *something*
> for versioning and object building. The object building is simple, and
> the versioning scheme was just copied from Linux.
> 
> What I ended up with the smallest demo I could come up with.
> 

Are you attending Linux Plumbers in Vancouver? Because I think this
would be a very interesting BoF there.

-- Steve
