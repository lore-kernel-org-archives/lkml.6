Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133642064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoR1h9Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133642064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeKBAwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeKBAwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:52:06 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35C92064C;
        Thu,  1 Nov 2018 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541087315;
        bh=h4xaiEWt6BFAVI9PuW3EVFwg6sX7popsivcWIN0gzFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoR1h9BjFPEt0FwzGb+gEtOCywNL1qpnIDocZ+4/yAfxELbbbfi/2LmiAkj9Tn7UT
         +9XS2m5ckLSnREkV/CoYluyq9e33CDQX1A/no0Wj32JDq13DUf05kCA3dekOj0Xuh2
         n+hxAoK/Ikxs6UqL/OhA2LXKvHn9Wq7c247BcjBU=
Date:   Thu, 1 Nov 2018 11:48:34 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH AUTOSEL 4.14 22/73] regulator: fixed: Default enable high
 on DT regulators
Message-ID: <20181101154834.GA194472@sasha-vm>
References: <20181031230948.29203-1-sashal@kernel.org>
 <20181031230948.29203-22-sashal@kernel.org>
 <20181101120630.GD6425@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181101120630.GD6425@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 12:06:30PM +0000, Mark Brown wrote:
>On Wed, Oct 31, 2018 at 07:08:57PM -0400, Sasha Levin wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> [ Upstream commit 28be5f15df2ee6882b0a122693159c96a28203c7 ]
>>
>> commit efdfeb079cc3
>> ("regulator: fixed: Convert to use GPIO descriptor only")
>> switched to use gpiod_get() to look up the regulator from the
>> gpiolib core whether that is device tree or boardfile.
>
>This patch is only introduced in v4.19...

Ah, the word "commit" in the fixes tag confused my script, I'll fix
that. Thanks!

--
Thanks,
Sasha
