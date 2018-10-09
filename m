Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A6ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A3120835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A3120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJJBki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:40:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJJBki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:40:38 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jteq7IuEM6ko; Tue,  9 Oct 2018 20:22:22 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CEDF1EC02B2;
        Tue,  9 Oct 2018 20:22:22 +0200 (CEST)
Date:   Tue, 9 Oct 2018 20:22:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     geert@linux-m68k.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs/ocfs2/dlmglue: lockdep_keys defined but not used
Message-ID: <20181009182217.GA18663@zn.tnic>
References: <20180704095318.19218-1-anders.roxell@linaro.org>
 <CAMuHMdWCyH-E9VA7ihsoXEq4dvLrPjYd01TYot6qja-psVRcog@mail.gmail.com>
 <CADYN=9KH134zWogYt=FMMTgsYm6GEqBUY6=C453yj_NY=oq1hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYN=9KH134zWogYt=FMMTgsYm6GEqBUY6=C453yj_NY=oq1hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:07:03PM +0200, Anders Roxell wrote:
> On Thu, 23 Aug 2018 at 23:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Anders,
> >
> > On Wed, Jul 4, 2018 at 11:54 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > > When CONFIG_DEBUG_LOCK_ALLOC isn't enabled lockdep_keys isn't used and
> > > we get a warning:
> > > fs/ocfs2/dlmglue.c:99:30: warning: ‘lockdep_keys’ defined but not used
> > >     [-Wunused-variable]
> > >  static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
> > >                               ^~~~~~~~~~~~
> > > Adding __maybe_unused to the declaration hids the warning.
> >
> > Thanks for your patcj!
> >
> > > Fixes: 1cd75cdb8fbb ("ocfs2: make several functions and variables static (and some const)")
> >
> > Fixes: 480bd56485b77c36 ("ocfs2: make several functions and variables
> > static (and some const)")
> 
> Thanks, thats correct.
> 
> >
> > Presumably the branch got rebased?
> 
> probably.
> 
> Mark, Joel, do you want me to send a new patch where I correct the sha
> in the "Fixes" part of the changelog or can you fix that?

FWIW, I'm still seeing this in randconfig builds here.

Adding akpm in case no one picks this up.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
