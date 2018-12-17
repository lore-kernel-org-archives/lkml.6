Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8DB2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbeLQMDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726831AbeLQMDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:03:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5CBBAE88;
        Mon, 17 Dec 2018 12:03:17 +0000 (UTC)
Date:   Mon, 17 Dec 2018 13:03:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] livepatch: fix non-static warnings
Message-ID: <20181217120317.yhbvdavcau3wykzd@pathway.suse.cz>
References: <1544965657-26804-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544965657-26804-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-12-16 14:07:37, Nicholas Mc Guire wrote:
> Sparse reported warnings about non-static symbols. For the variables
> a simple static attribute is fine - for those symbols referenced by
> livepatch via klp_func the symbol-names must be unmodified in the
> symbol table - to resolve this the __noclone attribute is used
> for the shared statically declared functions.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Link: https://lkml.org/lkml/2018/12/13/827

This is misleading. The "Link:" tag should point to the mail
where the commited version of the patch was being discussed.
It can be added by the maintainer.

Also please do not use links to https://lkml.org.
Messages disappear from time to time. It is much better
to use the redirector:

      https://lkml.kernel.org/r/<message_id>

Best Regards,
Petr


PS: I was about to add Reviewed-by tag. But Miroslav (sitting
next to me) found out that __noclone was not the best solution.

I suggest to always wait few days between re-sending a new
version. This subsystem has many active reviewers ;-)
