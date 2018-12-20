Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369EAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AA8217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbeLTOqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:46:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732874AbeLTOq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:46:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6ECF9C0495A9;
        Thu, 20 Dec 2018 14:46:29 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0951A19C7B;
        Thu, 20 Dec 2018 14:46:27 +0000 (UTC)
Date:   Thu, 20 Dec 2018 08:46:26 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, jeyu@kernel.org, pmladek@suse.com,
        linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joao Moreira <jmoreira@suse.de>
Subject: Re: [PATCH] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
Message-ID: <20181220144626.2uwuzsmdowbrmxxq@treble>
References: <20181219141744.32392-1-mbenes@suse.cz>
 <20181219165428.5udrppedpdvf2u7k@treble>
 <nycvar.YFH.7.76.1812191756450.17216@cbobk.fhfr.pm>
 <20181219172127.o753af7pkrsttcgl@treble>
 <nycvar.YFH.7.76.1812191909490.17216@cbobk.fhfr.pm>
 <alpine.LSU.2.21.1812200919210.28185@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1812200919210.28185@pobox.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 20 Dec 2018 14:46:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:33:05AM +0100, Miroslav Benes wrote:
> > > Though, upstream, almost everybody seems to use kpatch-build, for which
> > > this patch doesn't help.  And people will continue to do so until we
> > > have decent source-based tooling.  Will the klp-convert patches be
> > > revived soon?
> >
> > Let me add Joao, who's working on that.
> > 
> > Joao, I think you had something basically ready for upstream exposure, 
> > right?
> 
> I think that when Joao posted it a long time ago, the conclusion was that 
> it would be better to wait for the source-based tooling and have the 
> complete solution. I may misremember though.
> 
> If Josh thinks that it would be acceptable to have klp-convert merged even 
> without the tooling, I'm all for it.
> 
> We're about to start using it at SUSE and staying close to upstream would 
> definitely be better.

A complete toolchain should definitely be the end goal.

But as a usable first step, only *some* of the tooling is required,
since some of the steps can be done manually, right?

So starting out, for something usable, I believe the following would be
the bare minimum:

  * -flive-patching

  * The analysis tool which analyzes the -fdump-ipa-clones files

  * klp-convert

  * Documentation describing the end-to-end patch creation process,
    including the manual steps and how to use the above tools

Did I miss anything?

Then over time we can fill in the gaps (manual steps) with automation.

-- 
Josh
