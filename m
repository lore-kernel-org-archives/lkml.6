Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E6218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548431063;
	bh=lqLG/D8YZyMJSmpHWNmHltz8gj+w8IP6XtjO5J0rIZ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ddAg+w+nC+5qbMcBu4D0t9hOPU//wI+PrbtWmXrv1hzad+fM9Ac1ZZIKTWqwceShF
	 T8U9b5PyYm1XaW43zbV3lzkBYZDVghTFLamsLCTUs8grgeWWwgiZv2U663lj50jG4Y
	 wxJ4f9eKDBtsu4dGToV2xwZORgwejJeaGqcRxrIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfAYPoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:44:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:53410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbfAYPoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:44:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6FDAAC4B;
        Fri, 25 Jan 2019 15:44:19 +0000 (UTC)
Date:   Fri, 25 Jan 2019 16:44:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] livepatch: non static warnings fix
In-Reply-To: <1548294496-22719-1-git-send-email-hofrat@osadl.org>
Message-ID: <nycvar.YFH.7.76.1901251644040.6626@cbobk.fhfr.pm>
References: <1548294496-22719-1-git-send-email-hofrat@osadl.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Nicholas Mc Guire wrote:

> Sparse reported warnings about non-static symbols. For the variables
> a simple static attribute is fine - for the functions referenced by
> livepatch via klp_func the symbol-names must be unmodified in the
> symbol table and the patchable code has to be emitted. The resolution
> is to attach __used attribute to the shared statically declared functions.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Link: https://lore.kernel.org/lkml/1544965657-26804-1-git-send-email-hofrat@osadl.org/

I've reordered the tags :) and applied. Thanks,

-- 
Jiri Kosina
SUSE Labs

