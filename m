Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E26C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E210B20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551288892;
	bh=nvmuCLJswQXlZnjAqmpR8mbmaCMYOguRQ1lfrkZbgAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Iljy1NFJ0PR1M6xxDELqXl96j/5L/meV3hIiimO0ihPNSjquf0+ZfzjOYIJRHRLtB
	 3Nthg+ZCGgYt57eGH+iPLAGYmAyeukBG6ASQQr4BP2Wvqfcu5+Aq+YZZ2dT0C9ORqw
	 gEtoKC+FqeTVVEvPx6cSNFN+NestZiS1xECPW7ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfB0Reu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfB0Reu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:34:50 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449CF20C01;
        Wed, 27 Feb 2019 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551288889;
        bh=nvmuCLJswQXlZnjAqmpR8mbmaCMYOguRQ1lfrkZbgAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwqLba/aihIEZiRrruDF2t05wGkk2mNc7sVu7LRi9vp1EgdNKT0eKlCreoLt2IzpE
         Y6lM3mao2BojFYtVIr4HSY4yl7yYB9mHIH13/D/fvdQFJGMUeZuHOWGT0TCGYSlguA
         DWUjVmcKSj72ZQA3JTc9fDOYlZtd7YgQzH5aqeZw=
Date:   Wed, 27 Feb 2019 12:34:48 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [PATCH AUTOSEL 4.20 16/77] ASoC: soc-core: fix init platform
 memory handling
Message-ID: <20190227173447.GJ10616@sasha-vm>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-16-sashal@kernel.org>
 <20190215115818.GD7897@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215115818.GD7897@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:58:18AM +0000, Mark Brown wrote:
>On Thu, Feb 14, 2019 at 09:07:54PM -0500, Sasha Levin wrote:
>> From: Curtis Malainey <cujomalainey@chromium.org>
>>
>> [ Upstream commit 09ac6a817bd687e7f5dac00470262efdd72f9319 ]
>>
>> snd_soc_init_platform initializes pointers to snd_soc_dai_link which is
>> statically allocated and it does this by devm_kzalloc. In the event of
>> an EPROBE_DEFER the memory will be freed and the pointers are left
>
>This is also part of the same set of issues.

Dropped as well.

--
Thanks,
Sasha
