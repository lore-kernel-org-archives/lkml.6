Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D3C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01E120864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHQTo2t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01E120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438308AbeKWGQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:16:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbeKWGQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:16:50 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544B120824;
        Thu, 22 Nov 2018 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542915363;
        bh=1JD+sEnYW23vXjTvbJFW86h5udtsiQulN65W21o2ORo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHQTo2t3ULcj9Q2xIpvQgBFl/v29lMXkDQ6I/YGgezHRJkEOgYTKHrnB6ZJFy14FB
         S8p3nUE2+PvveN7AukiqGvD5tt2ELpSC0rU/B2pf+6TMv4cB1d5NEZYyMNzxCasUCj
         k1A5WYIsxuJ8EpyMYkE+Bw4kGg9V4luEj8QKC1KE=
Date:   Thu, 22 Nov 2018 14:35:59 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.18 31/39] clk: sunxi-ng: sun50i: h6: Add 2x
 fixed post-divider to MMC module clocks
Message-ID: <20181122193559.GC9725@sasha-vm>
References: <20181113055053.78352-1-sashal@kernel.org>
 <20181113055053.78352-31-sashal@kernel.org>
 <19C4C784-F94E-49D0-883C-12C49EF2676A@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19C4C784-F94E-49D0-883C-12C49EF2676A@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 08:27:50PM +0800, Icenowy Zheng wrote:
>
>
>于 2018年11月13日 GMT+08:00 下午1:50:45, Sasha Levin <sashal@kernel.org> 写到:
>>From: Icenowy Zheng <icenowy@aosc.io>
>>
>>[ Upstream commit c2ff8383cc33c2d9c169e4daf1e37a434c3bb420 ]
>>
>>On the H6, the MMC module clocks are fixed in the new timing mode,
>>i.e. they do not have a bit to select the mode. These clocks have
>>a 2x divider somewhere between the clock and the MMC module.
>>
>>To be consistent with other SoCs supporting the new timing mode,
>>we model the 2x divider as a fixed post-divider on the MMC module
>>clocks.
>>
>>This patch adds the post-dividers to the MMC clocks, following the
>>approach on A64.
>>
>>Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6
>>CCU")
>>Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please don't select this, it needs some fixes in MMC driver.

Dropped it for now. If you'd like to let us know when these fixes are
upstream we could grab this patch and those fixes for -stable.

--
Thanks,
Sasha
