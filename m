Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97329C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D27217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545243051;
	bh=pAU7jZ1nIHkXmUXKMzZ/VndXtm86GouK5KYwOyCyFR4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ubXMo62D1FJKW8tzp4+gmdYNbLoPuJACXJGIaI0WKkkvbkE9lce98v+Bpb7utXglT
	 8rST360zJlLJXyE8wOcRHa9pEFREgW6YuT129Sqt8NgGownMYE+u83T6RnafEFTkcK
	 8mJQrWHoe15rxewqOpOB9axWMdlUjQ8zfr5bViJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeLSSKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:10:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:60240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728205AbeLSSKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:10:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23C81B624;
        Wed, 19 Dec 2018 18:10:48 +0000 (UTC)
Date:   Wed, 19 Dec 2018 19:10:47 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Miroslav Benes <mbenes@suse.cz>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, jeyu@kernel.org, pmladek@suse.com,
        linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joao Moreira <jmoreira@suse.de>
Subject: Re: [PATCH] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
In-Reply-To: <20181219172127.o753af7pkrsttcgl@treble>
Message-ID: <nycvar.YFH.7.76.1812191909490.17216@cbobk.fhfr.pm>
References: <20181219141744.32392-1-mbenes@suse.cz> <20181219165428.5udrppedpdvf2u7k@treble> <nycvar.YFH.7.76.1812191756450.17216@cbobk.fhfr.pm> <20181219172127.o753af7pkrsttcgl@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018, Josh Poimboeuf wrote:

> > > This option only makes sense for source-based patch generation, so isn't 
> > > it a bit premature to make this change without proper source-based patch 
> > > tooling?
> > 
> > The reality is though that before the full-fledged patch tooling exists, 
> > people are actually already writing livepatches by hand, so this option is 
> > useful for them.
> 
> Fair enough.
> 
> Though, upstream, almost everybody seems to use kpatch-build, for which
> this patch doesn't help.  And people will continue to do so until we
> have decent source-based tooling.  Will the klp-convert patches be
> revived soon?

Let me add Joao, who's working on that.

Joao, I think you had something basically ready for upstream exposure, 
right?

Thanks,

-- 
Jiri Kosina
SUSE Labs

