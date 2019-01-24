Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FFDC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5806521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfAXAVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:21:46 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:36051 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfAXAVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:21:45 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 896545C0FB6; Thu, 24 Jan 2019 01:21:25 +0100 (CET)
Date:   Thu, 24 Jan 2019 01:21:25 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] livepatch: non static warnings fix
Message-ID: <20190124002125.GB16834@osadl.at>
References: <1548226584-20579-1-git-send-email-hofrat@osadl.org>
 <alpine.LSU.2.21.1901231518320.31908@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1901231518320.31908@pobox.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 03:30:57PM +0100, Miroslav Benes wrote:
> Hi,
> 
> On Wed, 23 Jan 2019, Nicholas Mc Guire wrote:
> 
> > Sparse reported warnings about non-static symbols. For the variables
> > a simple static attribute is fine - for the functions referenced by
> > livepatch via klp_func the symbol-names must be unmodified in the
> > symbol table and the patchable code has to be emitted. The resolution
> > is to attach __used attribute to the shared statically declared functions.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Link: https://lkml.org/lkml/2018/12/13/827
> 
> could you reorder the tags and change Link: tag to 
> https://lkml.kernel.org/r/<message_id> as asked for when we reviewed v2?
>

sorry overlooked that - yes will fix that up and resend

thx!
hofrat

 
> With that
> 
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> 
> M
