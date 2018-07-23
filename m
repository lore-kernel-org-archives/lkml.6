Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8CB20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WiHeBxZM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WiHeBxZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8CB20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbeGWW0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:26:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54252 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388128AbeGWW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:26:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 87C0B6055D; Mon, 23 Jul 2018 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381022;
        bh=zbmcGenh7u4IUfo6j15YwY5GONflaYMxLonmvytXGQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiHeBxZMDhxOsB5yFAQ/CRdNkg5AB10ov5mvM4SdJA1mtemz306iBL2BW6wLmwvyM
         5ps6OCMewyXyEDDAWD25loixihj9LXp0kM0/GwDUP0eqUzst5+31SPN25CjOsfLya+
         ffeeNWh8CJrhex2e0NM2DJCzReYAduQ/uRSYQN+A=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7945F60285;
        Mon, 23 Jul 2018 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381022;
        bh=zbmcGenh7u4IUfo6j15YwY5GONflaYMxLonmvytXGQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiHeBxZMDhxOsB5yFAQ/CRdNkg5AB10ov5mvM4SdJA1mtemz306iBL2BW6wLmwvyM
         5ps6OCMewyXyEDDAWD25loixihj9LXp0kM0/GwDUP0eqUzst5+31SPN25CjOsfLya+
         ffeeNWh8CJrhex2e0NM2DJCzReYAduQ/uRSYQN+A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7945F60285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Mon, 23 Jul 2018 16:23:39 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: switch to NO_BOOTMEM
Message-ID: <20180723212339.GA12771@codeaurora.org>
References: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jul 16, 2018 at 10:43:18AM +0300, Mike Rapoport wrote:
> This patch adds registration of the system memory with memblock, eliminates
> bootmem initialization and converts early memory reservations from bootmem
> to memblock.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Sorry for the delay, and thanks for this patch.

I think the first memblock_reserve should use ARCH_PFN_OFFSET instead of
PHYS_OFFSET.

If you can amend that I'd be happy to take it through my tree or it can go
through any other.


Thanks,
Richard Kuo


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
