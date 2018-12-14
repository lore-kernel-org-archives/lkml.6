Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57B820672
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57B820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeLNJhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:37:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:46150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbeLNJhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:37:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3247AC24;
        Fri, 14 Dec 2018 09:37:34 +0000 (UTC)
Date:   Fri, 14 Dec 2018 10:37:34 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
In-Reply-To: <20181213223533.oucddzzhrnx7b7ov@treble>
Message-ID: <alpine.LSU.2.21.1812141037210.450@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-4-pmladek@suse.com> <alpine.LSU.2.21.1812031542540.22317@pobox.suse.cz> <20181213223533.oucddzzhrnx7b7ov@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018, Josh Poimboeuf wrote:

> On Mon, Dec 03, 2018 at 03:59:57PM +0100, Miroslav Benes wrote:
> > On Thu, 29 Nov 2018, Petr Mladek wrote:
> > 
> > > -static int klp_init_patch(struct klp_patch *patch)
> > > +/* Init operations that must succeed before klp_free_patch() can be called. */
> > > +static int klp_init_patch_before_free(struct klp_patch *patch)
> > 
> > There is no klp_free_patch() now, so the comment is not correct. Also I 
> > don't know if the function name is ideal, but I don't have a better one.
> 
> Yeah, I found the name of this function to be confusing.  It sounds like
> you're initializing the patch before freeing it, which seems like an
> obvious thing to do :-)
> 
> How about klp_init_patch_early()?

That would work for me.

Miroslav
