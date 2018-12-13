Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C07C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E020E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E020E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeLMWfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:35:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLMWfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:35:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 073F77CDE4;
        Thu, 13 Dec 2018 22:35:41 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2709A66075;
        Thu, 13 Dec 2018 22:35:35 +0000 (UTC)
Date:   Thu, 13 Dec 2018 16:35:33 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
Message-ID: <20181213223533.oucddzzhrnx7b7ov@treble>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-4-pmladek@suse.com>
 <alpine.LSU.2.21.1812031542540.22317@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1812031542540.22317@pobox.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Dec 2018 22:35:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:59:57PM +0100, Miroslav Benes wrote:
> On Thu, 29 Nov 2018, Petr Mladek wrote:
> 
> > -static int klp_init_patch(struct klp_patch *patch)
> > +/* Init operations that must succeed before klp_free_patch() can be called. */
> > +static int klp_init_patch_before_free(struct klp_patch *patch)
> 
> There is no klp_free_patch() now, so the comment is not correct. Also I 
> don't know if the function name is ideal, but I don't have a better one.

Yeah, I found the name of this function to be confusing.  It sounds like
you're initializing the patch before freeing it, which seems like an
obvious thing to do :-)

How about klp_init_patch_early()?

-- 
Josh
