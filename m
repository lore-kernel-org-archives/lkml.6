Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D457C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD452184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548270584;
	bh=zW7Ta9POVlZh+PSwhGR6T68BJo9n692c2oGfp6HGbEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wKhPMTCT5pXr0HBze2V+Quk8s0+bU35hA7e8S19pAxon+aQefUymloECUulC1MubJ
	 tjTltwS27LGnwkVIN93p+GJFkEkHk7P6HG/BA2KO3/9T3KCtNnsLQ+Xh5ZyZo0FGp0
	 C2u1IR+fPESqRAgqpIPKVvjYIskgS8wkv9x0rj8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfAWTJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAWTJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:09:41 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21D72184B;
        Wed, 23 Jan 2019 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548270581;
        bh=zW7Ta9POVlZh+PSwhGR6T68BJo9n692c2oGfp6HGbEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZHxNfyqlcAab0OiEVJ57a0ewrbJmRtb1Ui2HfPZ2rf/y/0CCjRPdVI8LyjblW6aI
         yjh1WpiP0SSCpavhdIXmumzUn5o5DUV+vEmCW0BxRo1jMYJgaf6nyNgtTYmLm+MAOb
         GfdjnR4bG3rpk+UwsMtPt3HYirXgpLrDgixPVGAs=
Date:   Wed, 23 Jan 2019 14:09:39 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, ruizhao@microsoft.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@microsoft.com, will.deacon@arm.com, okaya@kernel.org
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Message-ID: <20190123190939.GQ202535@sasha-vm>
References: <20190118162324.17123-1-sashal@kernel.org>
 <20190121123547.GF29166@zn.tnic>
 <20190123185007.GP202535@sasha-vm>
 <20190123190353.GE3227@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190123190353.GE3227@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 08:03:54PM +0100, Borislav Petkov wrote:
>On Wed, Jan 23, 2019 at 01:50:07PM -0500, Sasha Levin wrote:
>> A variant of a Broadcom's SST100 board.
>
>Is that some platform which people will use and run linux on and thus
>would make sense to have an EDAC driver for or is this something
>devel-only toy thing?

It will have (a lot of) use in prod, and is not just a toy :)

>Searching a bit doesn't tell me a whole lot except some enablement for
>some stingray SOC reference board...

Right, they hardware we're working on is nothing more than reference
boards at this point.

--
Thanks,
Sasha
