Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92733C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F8120852
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F8120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGLRLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:11:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53564 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbeGLRLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:11:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FBD91682;
        Thu, 12 Jul 2018 10:00:43 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21CAD3F589;
        Thu, 12 Jul 2018 10:00:43 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 850B11AE30FD; Thu, 12 Jul 2018 18:01:25 +0100 (BST)
Date:   Thu, 12 Jul 2018 18:01:25 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        keescook@chromium.org, boqun.feng@gmail.com, mingo@kernel.org,
        peterz@infradead.org
Subject: Re: [PATCHv2] refcount: always allow checked forms
Message-ID: <20180712170124.GD26935@arm.com>
References: <20180711093607.1644-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711093607.1644-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:36:07AM +0100, Mark Rutland wrote:
> In many cases, it would be useful to be able to use the full
> sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
> this would help to avoid duplicate warnings where callers try to
> sanity-check refcount manipulation.
> 
> This patch refactors things such that the full refcount helpers were
> always built, as refcount_${op}_checked(), such that they can be used
> regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
> wants a checked refcount to opt-in, avoiding the need to duplicate the
> logic for warnings.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  include/linux/refcount.h | 27 +++++++++++++++++-------
>  lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
>  2 files changed, 45 insertions(+), 35 deletions(-)

Looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
