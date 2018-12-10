Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9341FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B03320880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544444915;
	bh=8tk9pHwzn95AcdTJyc3CiZuqq1yMWGGIW/gk40epphQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3qpdPQQbl5usqWpQ60VdHiCu5UMk+/JRytvPl876K4wwlw60GmMAQ8sguC8c+WNN
	 3NW/Cw38Va4OPa7awL7mn3p32ifKGgPJCeed+yKO5KAHClDJpK6phhuui/YoCJpiGd
	 K8j4k9apgAxkuxW6/QCDhY/stuUzmb0mVlF8O5wQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B03320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeLJM2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbeLJM2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:28:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F4020870;
        Mon, 10 Dec 2018 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544444913;
        bh=8tk9pHwzn95AcdTJyc3CiZuqq1yMWGGIW/gk40epphQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1boYTwU1i/yVZZa8UyAKHfSPn2itCgCExSpsz+3KJ5xxQRAJtL4LY3qKdjMRcA3A
         Y9IuT2BWnpvZTJ+tMs5fQBEDNI3wpzl6pZBo7wrtBCpB0hqRr6KZdRZLRqOtYvDQGc
         Vc7AWIIdCwJN58/CUvO6tl5wrDjrXvVUTNqUeXDA=
Date:   Mon, 10 Dec 2018 13:28:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt changes for v4.21
Message-ID: <20181210122831.GB22995@kroah.com>
References: <20181210102303.GC2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210102303.GC2469@lahna.fi.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:23:03PM +0200, Mika Westerberg wrote:
> Hi Greg,
> 
> This includes automatic enabling of IOMMU based DMA protection from
> possibly malicious devices connected through Thunderbolt ports. In
> addition we make sure PCIe ATS (Address Translation Service) is not
> enabled for such devices to prevent them from passing IOMMU protection.

Oh, nice work with the "untrusted" PCI device thing, that's been a long
time in coming.

Now pulled and pushed out, thanks.

greg k-h
