Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E60BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3505C2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBKIxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:53:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:44834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbfBKIxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:53:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4F69AF99;
        Mon, 11 Feb 2019 08:53:45 +0000 (UTC)
Date:   Mon, 11 Feb 2019 09:53:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] livepatch: Enforce reliable stack trace as config
 dependency
Message-ID: <20190211085345.xiyoto3u2joeajwt@pathway.suse.cz>
References: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2019-02-09 14:47:28, Kamalesh Babulal wrote:
> While the consistency model was introduced, architectures without the
> reliable stack trace implementation could use the immediate flag for
> livepatching but with its own limitations.
> 
> After removal of the immediate flag by commit d0807da78e11
> ("livepatch: Remove immediate feature"), reliable stack trace became
> enforcing dependency for livepatch support on any architecture. In
> the current code, we ensure that the dependency is met when
> enabling the patch during the module load.
> 
> This dependency check can be improved by moving it to the Kconfig,
> which disables the support for livepatching in the kernel for unmet
> dependencies. This patch moves both HAVE_RELIABLE_STACKTRACE and
> STACKTRACE under config LIVEPATCH, it also removes the
> klp_have_reliable_stack() function.
> 
> Loading a livepatching module on an architecture where reliable
> stack trace is yet to be implemented, the user should see:
> 
> insmod: ERROR: could not insert module ./livepatch-sample.ko: Invalid module format
> 
> ...
> [  286.453463] livepatch_sample: module is marked as livepatch module, but livepatch support is disabled
> 
> [pmladek@suse.com: Suggested to explicitly add CONFIG_STACKTRACE under
>  config LIVEPATCH]
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
