Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EDEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C4F20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C4F20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeGLImq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeGLImq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:42:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F195AD37;
        Thu, 12 Jul 2018 08:34:12 +0000 (UTC)
Date:   Thu, 12 Jul 2018 10:34:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove reliable stacktrace check in
 klp_try_switch_task()
Message-ID: <20180712083411.ofebltgc4jjkvkyb@pathway.suse.cz>
References: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-07-12 13:35:06, Kamalesh Babulal wrote:
> Support for immediate flag was removed by commit d0807da78e11
> ("livepatch: Remove immediate feature").  We bail out during
> patch registration for architectures, those don't support
> reliable stack trace. Remove the check in klp_try_switch_task(),
> as its not required.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Good catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
