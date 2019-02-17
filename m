Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30532C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4D8218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550430595;
	bh=+adiWGkPiL+K3hYCfEJ+APffztc5Nov+nbmucKAbpN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TJiGbUDiS2kxsjV7qZnPSOE4i9kTt/u2S44iEz73lUvKYtciP+msjh9GFe4XPO/VO
	 sQVg5iDVMUZQv4GFbI0gsd1IiNaaLBu4C04TqpzxlUepTVgOtSRPdqKnD7x/rGP7Vf
	 nRNL9HRFCnIcat6zEy3HVbU2wzMCcmrq4iVxVXG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfBQTJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfBQTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:09:53 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAC821872;
        Sun, 17 Feb 2019 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550430592;
        bh=+adiWGkPiL+K3hYCfEJ+APffztc5Nov+nbmucKAbpN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hoRhj4Ry3nr8pf1qSQB67g3PNiUd/OgQxrS8YJ+iSHyy+HQLS8B7aIVoG9JaWp52
         8t6kwjFZtIXbNRpB5HXsUgjjk8zY4KcFEnYmehjgjLBDbI8Umw+/UsoCrNPt8JxM5L
         lCUSFVQNa78hSnrXUHC3z18ZKKVGCNq3Bu0mykSs=
Date:   Sun, 17 Feb 2019 14:09:50 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     David Long <dave.long@linaro.org>
Cc:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.9 00/16] V4.9 backport of more 32-bit arm spectre
 patches
Message-ID: <20190217190950.GK10616@sasha-vm>
References: <20190214144930.27539-1-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 09:49:14AM -0500, David Long wrote:
>From: "David A. Long" <dave.long@linaro.org>
>
>V4.9 backport of spectre patches from Russell M. King's spectre branch.
>Patches have been kvm-unit-test'ed on an arndale, run through kernelci, and
>handed off to ARM for functional testing.
>
>Julien Thierry (9):
>  ARM: 8789/1: signal: copy registers using __copy_to_user()
>  ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
>  ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
>  ARM: 8793/1: signal: replace __put_user_error with __put_user
>  ARM: 8794/1: uaccess: Prevent speculative use of the current
>    addr_limit
>  ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
>  ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
>  ARM: 8797/1: spectre-v1.1: harden __copy_to_user
>  ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc
>
>Russell King (7):
>  ARM: make lookup_processor_type() non-__init
>  ARM: split out processor lookup
>  ARM: clean up per-processor check_bugs method call
>  ARM: add PROC_VTABLE and PROC_TABLE macros
>  ARM: spectre-v2: per-CPU vtables to work around big.Little systems
>  ARM: ensure that processor vtables is not lost after boot
>  ARM: fix the cockup in the previous patch

Queued for 4.9, thank you.

--
Thanks,
Sasha
