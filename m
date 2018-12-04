Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E532081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E532081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLDP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:27:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:34070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeLDP1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:27:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9ED2AD38;
        Tue,  4 Dec 2018 15:27:44 +0000 (UTC)
Date:   Tue, 4 Dec 2018 16:27:43 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 07/11] livepatch: Add atomic replace
In-Reply-To: <20181129094431.7801-8-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1812041532220.2327@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-8-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -5.3. Disabling
> +5.3. Replacing
> +--------------
> +
> +All enabled patches might get replaced by a cumulative patch that
> +has the .replace flag set.
> +
> +Once the new patch is enabled and the 'transition" finishes then
> +all the functions (struct klp_func) associated with the replaced
> +patches are removed from the corresponding struct klp_ops. Also
> +the ftrace handler is unregistered and the struct klp_ops is
> +freed when the related function is not modified by the new patch
> +and func_stack list becomes empty.
> +
> +See Documentation/livepatch/cumulative-patches.txt for more details.

which is added later in the series.

The rest looks good, so

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
