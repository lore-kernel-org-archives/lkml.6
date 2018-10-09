Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828FC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B209A214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B209A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJJF71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:59:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJF70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:59:26 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DD917C6C;
        Tue,  9 Oct 2018 22:40:17 +0000 (UTC)
Date:   Tue, 9 Oct 2018 15:40:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>, geert@linux-m68k.org,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/ocfs2/dlmglue: lockdep_keys defined but not used
Message-Id: <20181009154016.5f5d044111e14bc38a7313c8@linux-foundation.org>
In-Reply-To: <20181009182217.GA18663@zn.tnic>
References: <20180704095318.19218-1-anders.roxell@linaro.org>
        <CAMuHMdWCyH-E9VA7ihsoXEq4dvLrPjYd01TYot6qja-psVRcog@mail.gmail.com>
        <CADYN=9KH134zWogYt=FMMTgsYm6GEqBUY6=C453yj_NY=oq1hg@mail.gmail.com>
        <20181009182217.GA18663@zn.tnic>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 20:22:17 +0200 Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Aug 24, 2018 at 03:07:03PM +0200, Anders Roxell wrote:
> > On Thu, 23 Aug 2018 at 23:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Anders,
> > >
> > > On Wed, Jul 4, 2018 at 11:54 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > > > When CONFIG_DEBUG_LOCK_ALLOC isn't enabled lockdep_keys isn't used and
> > > > we get a warning:
> > > > fs/ocfs2/dlmglue.c:99:30: warning: ‘lockdep_keys’ defined but not used
> > > >     [-Wunused-variable]
> > > >  static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
> > > >                               ^~~~~~~~~~~~
> > > > Adding __maybe_unused to the declaration hids the warning.
> > >
> > > Thanks for your patcj!
> > >
> > > > Fixes: 1cd75cdb8fbb ("ocfs2: make several functions and variables static (and some const)")
> > >
> > > Fixes: 480bd56485b77c36 ("ocfs2: make several functions and variables
> > > static (and some const)")
> > 
> > Thanks, thats correct.
> > 
> > >
> > > Presumably the branch got rebased?
> > 
> > probably.
> > 
> > Mark, Joel, do you want me to send a new patch where I correct the sha
> > in the "Fixes" part of the changelog or can you fix that?
> 
> FWIW, I'm still seeing this in randconfig builds here.
> 
> Adding akpm in case no one picks this up.
> 

https://ozlabs.org/~akpm/mmots/broken-out/ocfs2-fix-a-gcc-compiled-warning.patch
is queued for 4.20-rc1.  I'll see if we can squeeze it into 4.19.

