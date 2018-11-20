Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CEC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513A7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLS7ocLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513A7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeKTTS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeKTTS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:18:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB15E213A2;
        Tue, 20 Nov 2018 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542703829;
        bh=bhHPbMROc/iLH3bLvUGT0cmwtMu0Y7ip30Gfu37AEGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLS7ocLTuGPVJK/xUAftbMe8W1mX7sOwpTt259zeiCtiEaa8Z012juZcEtlZqAhCK
         dpQ70UGOJywTXp2CfraY3b7BqwDRS435nET7ggNqf9zizUtI9iE+XStHhTBc4XDsBT
         LXoStpofkKItBS//oKJKE7OzPAuYTRcKOgF7foDc=
Date:   Tue, 20 Nov 2018 09:49:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 16/90] cpupower: Fix coredump on VMWare
Message-ID: <20181120084930.GB19763@kroah.com>
References: <20181119162620.585061184@linuxfoundation.org>
 <20181119162623.516060898@linuxfoundation.org>
 <c2d0d4ab-a9e5-cc7b-55d9-f99754beff55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d0d4ab-a9e5-cc7b-55d9-f99754beff55@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:11:54PM -0500, Prarit Bhargava wrote:
> 
> 
> On 11/19/2018 11:28 AM, Greg Kroah-Hartman wrote:
> > 3.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Prarit Bhargava <prarit@redhat.com>
> > 
> > [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]
> 
> Greg, as previously mentioned to Sasha, this patch also needs 8c22e2f69592
> ("cpupower: Fix AMD Family 0x17 msr_pstate size").  I did not see a message
> indicating that 8c22e2f69592 was also being backported to 3.18-stable.  My
> apologies if I missed it.

I've just dropped this from the 3.18 queue as it seems to have been
skipped for 4.9 and 4.4 as well.

thanks,

greg k-h
