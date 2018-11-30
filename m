Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A143C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092372145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTHcuZ3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092372145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeLACZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbeLACZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:25:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C1F20867;
        Fri, 30 Nov 2018 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543590957;
        bh=hqH1tkXzMWBFEy0/QYWkB5kpZ5/7Cvf6AxwV895Ca+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTHcuZ3szhomK3EdVi7RQeiLdCZOu4snxJkfK4Zzzy7cllmiZOqHzg9k5dCUosEP6
         pNscCzavk/pEq49pJ2Qku3fzg5lid7ybG4JuQhvf2gyyXdwMI6WyrivHUAPPuXLyDQ
         oocAhQXT7I8hS4ZGuE6v+lRBdERH6R/4Wl75SoQg=
Date:   Fri, 30 Nov 2018 16:15:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 14/83] ARM: make lookup_processor_type() non-__init
Message-ID: <20181130151554.GA29005@kroah.com>
References: <20181129140138.002176596@linuxfoundation.org>
 <20181129140138.869602566@linuxfoundation.org>
 <20181129142817.GW30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129142817.GW30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:28:18PM +0000, Russell King - ARM Linux wrote:
> Hi,
> 
> As I've already fed back to Sascha about this, this patch on its own
> does not fix anything, and is not a stable kernel candidate without
> a patch that makes use of it (iow, the spectre fixes.)  It is a
> preparatory patch for mainline commit 383fb3ee8024.
> 
> Every commit in:
> 
> $ git rev-list v4.16..383fb3ee8024
> 
> are the ARM spectre fixes, which are being back-ported by David Long.
> 
> Please do not cherry-pick commits from within this series for _any_
> stable kernel, but please wait for David to send you the back-ported
> patches.

Ugh, ok, that's a bunch here.

Sasha, let me go dig all of these out now.

Russell, thanks for letting me know.

greg k-h
