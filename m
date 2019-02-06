Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73814206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478750;
	bh=vbH4AwZlRuUyA5PbdaaE7WSWqBjlRx7Qid917Qq5lYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sHyjaFYMPAjwvi2e41u7U9sZHTIzeOQzC4f/RBVpC2O/TjlKYwYvyyYubDy51vbbN
	 q0sdeXa7n+eMz4Od4F/4h20zh14q2ALGtZJn5O+7apsDrPOPLZf0sZCVzGDAoXZn5X
	 exlc38pcN15Hb/eOXPsb17DD5uie8fG+Lnwv1Xc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBFSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:45:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBFSps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:45:48 -0500
Received: from localhost (unknown [82.113.183.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7467420663;
        Wed,  6 Feb 2019 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478748;
        bh=vbH4AwZlRuUyA5PbdaaE7WSWqBjlRx7Qid917Qq5lYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJJ0d87TuH/5s/Z7r+2ODZcbHw+9fQNWFx3IqBSFOdIRR2HH19ozFp4slaVQ0r8Kl
         X37tKh8TmFgMa/2NBMnmWSApoQ+9GqyVuG48Sueyoh6MGEcQn8RVDNDaWRPtcWNb9C
         Pt24tafRsWAFbmPOA13qjHUXfbrT0nQdZzxKxz5g=
Date:   Wed, 6 Feb 2019 19:45:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, mhocko@kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/memory-hotplug: Add sysfs hot-remove trigger
Message-ID: <20190206184544.GA12326@kroah.com>
References: <29ed519902512319bcc62e071d52b712fa97e306.1549469965.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ed519902512319bcc62e071d52b712fa97e306.1549469965.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:03:53PM +0000, Robin Murphy wrote:
> ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
> but being able to exercise the (arguably trickier) hot-remove path would
> be even more useful. Extend the feature to allow removal of offline
> sections to be triggered manually to aid development.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This is inspired by a previous proposal[1], but in coming up with a
> more robust interface I ended up rewriting the whole thing from
> scratch. The lack of documentation is semi-deliberate, since I don't
> like the idea of anyone actually relying on this interface as ABI, but
> as a handy tool it felt useful enough to be worth sharing :)
> 
> Robin.
> 
> [1] https://lore.kernel.org/lkml/22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com/
> 
>  drivers/base/memory.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)

You have to add new Documentation/ABI entries for each new sysfs file
you add :(
