Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A069C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2FF2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkECMAUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2FF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeK2BOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeK2BOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:14:43 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0FD20832;
        Wed, 28 Nov 2018 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543414375;
        bh=u0EkBOJo/hy0d83iGgQ7mm0jy4Gow67j9tR2RqjSbYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkECMAUBOSVDS7kQhu7HvBtX2y2X3PMdK8yHZh4m/6BheEm3Ims8bNwYBJGEdRaNJ
         2M6YIYzx+m/v7EOeKpLxSDPRfhYHIahxeNbCNB99S/IeJRv2nTyXSP3ZVKE2QXDjle
         bDd7Yz6vAnWaaKkETPug7atJ08967kD16ULEVYh8=
Date:   Wed, 28 Nov 2018 09:12:52 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 10/21] ARM: make lookup_processor_type()
 non-__init
Message-ID: <20181128141252.GB131942@sasha-vm>
References: <20181122195452.13520-1-sashal@kernel.org>
 <20181122195452.13520-10-sashal@kernel.org>
 <20181123000254.GM30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181123000254.GM30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:02:54AM +0000, Russell King - ARM Linux wrote:
>Hi Sasha,
>
>We need to keep track of which Spectre patches have been backported
>and which haven't.  David Long has been doing the backport work,
>which doesn't include all the patches in my present spectre branch.
>You've picked up the last five, meaning there's a bunch in the middle
>of the entire series which haven't yet been considered - for example,
>the Spectre variant 1.1 patches.

I'll drop all the ones you pointed out from my branches. Sometimes it's
difficult to tell if a certain patch is part of the spectre fix.

>The entire series of 32-bit ARM Spectre patches can be listed in
>mainline via:
>
>$ git log v4.16..383fb3ee8024
>
>where almost all of those need to be applied to stable kernels, with
>possible manual back-porting where they don't apply.

Is it something that will be backported at some point?

--
Thanks,
Sasha
