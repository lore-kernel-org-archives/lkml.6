Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A3FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A64207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R4cERhs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A64207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeJZEAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:00:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43263 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725725AbeJZEAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=b2L9OcuxWTyVCWjuH3Ty/bmDJ0GDfD86zGsQuGMSifY=;
        b=R4cERhs2tWh3Ixdchvg0jrfd05N7aTXOLsqG7MUtZOPSlf2Zgd69qEjld5Qbk4uCY6NUS5RwwSYOplpepFhF2u17+McERYnpCFBu068d+VEScDlduZL3tadGf4NnRUIf1Fen90lbaUOh0PtLdYWqyEDmEO7V6dzN+MMM5m1xxbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gFlGv-0004qQ-0U; Thu, 25 Oct 2018 21:26:21 +0200
Date:   Thu, 25 Oct 2018 21:26:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, ebiederm@xmission.com,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
Message-ID: <20181025192621.GB16785@lunn.ch>
References: <20181025190110.7564-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025190110.7564-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:01:08PM -0700, Florian Fainelli wrote:
> Some software such as perf makes unconditional use of the special
> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
> enabled in the kernel.
> 
> Facilitate the debugging of such situations by printing a debug message
> to the kernel log showing the task name and the faulting address.

Hi Florian

Nice. I wish we had this a couple of months ago.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks
    Andrew
