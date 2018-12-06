Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CA2C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B280420850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeLFIqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:46:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:47494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:46:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31C99AF06;
        Thu,  6 Dec 2018 08:46:52 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:46:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 04/11] livepatch: Refuse to unload only livepatches
 available during a forced transition
Message-ID: <20181206084651.fvj5v4pdi4q2pigb@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-5-pmladek@suse.com>
 <alpine.LSU.2.21.1812031614530.22317@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1812031614530.22317@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-12-03 16:29:32, Miroslav Benes wrote:
> You probably forgot to replace the subject with Josh's proposal.
> 
> > module_put() is currently never called in klp_complete_transition() when
> > klp_force is set. As a result, we might keep the reference count even when
> > klp_enable_patch() fails and klp_cancel_transition() is called.
> 
> Correct.
> 
> > This might make an assumption that a module might get blocked in some
> > strange init state. Fortunately, it is not the case. The reference count
> > is ignored when mod->init fails and erroneous modules are always removed.
> 
> I do not understand the paragraph and its connection to the problem (and I don't
> remember if I understood it previously or not and forgot to mention it).

It was one example of the confusion. I wonder if the following text
is more clear:

One might wonder if the reference could block the module in
MODULE_STATE_COMING or MODULE_STATE_GOING infinitely.
Fortunately, it is not the case. The reference count is
ignored when mod->init fails and erroneous modules are
always removed.

Or I could remove the paragraph as you suggested below.


Best Regards,
Petr
