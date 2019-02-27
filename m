Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48718C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA1A20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551288690;
	bh=jkAWnsURL+XBscR8A5w7OTqOswdq2XkWaa1Lpb2kgrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KhqQxqxbSU4vEyQ3L73BYDmJGo5MnnmEmbvLC9H+hB5jXMF2f2OEkLhbbbhhKUg0D
	 pkLbmVsbLIQv0UzMfYTbV9rLVqmXIlPGVDVaevz0qmpoQYsbvpuBrGpB5/nhj2CEIV
	 s6TbrKUZUwui2jJbIbLtTP+0JyTB8qAuqyKq2Ltc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfB0Rb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0Rb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:31:28 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4A120C01;
        Wed, 27 Feb 2019 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551288688;
        bh=jkAWnsURL+XBscR8A5w7OTqOswdq2XkWaa1Lpb2kgrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4VpBO5+Kysu28d1quNWivYz4nvtpXgLwlQkh4FY6MEFpiLB6QuAHlGyszD+snvC7
         lDOPWuOxI9ExQp9NIy/R5A5ua9LISqFjKiyBHBegbA7p8V+aQ7SFsK/INM9rmovE8J
         xRjJVV4ZsRP0SpH+2/rzzT2+FyDlPHzmWL5C7qsw=
Date:   Wed, 27 Feb 2019 12:31:26 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH AUTOSEL 4.20 06/77] ASoC: soc-core: defer card probe
 until all component is added to list
Message-ID: <20190227173126.GH10616@sasha-vm>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-6-sashal@kernel.org>
 <20190215115712.GB7897@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215115712.GB7897@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:57:12AM +0000, Mark Brown wrote:
>On Thu, Feb 14, 2019 at 09:07:44PM -0500, Sasha Levin wrote:
>> From: Ajit Pandey <ajitp@codeaurora.org>
>>
>> [ Upstream commit 8780cf1142a59568a3aa77959cbd76b2edb6fd81 ]
>>
>> DAI component probe is not called if it is not present
>> in component list during sound card registration.
>> Check if component is available in component list for
>> platform and cpu dai before soundcard registration.
>
>This is a really bad idea without also looking at surrounding commits -
>taken randomly by itself it's more likely to introduce regressions than
>help.

I've dropped it, thank you.

--
Thanks,
Sasha
