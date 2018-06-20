Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB59C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCAE20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpGYv2qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCAE20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbeFTK2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbeFTK2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:28:49 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B606E20836;
        Wed, 20 Jun 2018 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529490529;
        bh=1gE5s7L3cf9HHMbJy/7sAtPUlFyOrjvE8WVhx6E7uTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpGYv2qM1gYPm4WGkXXdMT3XiJMxVjhlc+9ZUl5deZwTDLD07e9SqKy1d9D4Gvtn2
         joXqUFh2Dcs+NK4DcRgcVvHpTnJJmzC2cVMuoie70n2vcCdAFIg3XQOYu7wl9Hp72X
         R9w8cM+vyKoUZ/FWP7M/Inx23ffEdWiGcMBcwqr8=
Date:   Wed, 20 Jun 2018 15:58:41 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rohit Kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180620102841.GJ13316@vkoul-mobl>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
 <20180619162230.GF13316@vkoul-mobl>
 <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
 <20180620093106.GI13316@vkoul-mobl>
 <53db13d7-b4bd-0e06-4110-ce75fd0bdd3c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53db13d7-b4bd-0e06-4110-ce75fd0bdd3c@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-18, 10:53, Srinivas Kandagatla wrote:
> On 20/06/18 10:31, Vinod wrote:
> > > Here clock will be enabled twice but disable will be called only once when
> > > count = 0.
> > > 
> > > This will make the clock always enabled. So, I think we should keep either
> > > mutex lock or atomic variable to synchronize this.
> > we are using DPCM here right?
> 
> We should probably model this clk as DAPM widget so we do not need to handle
> this in machine code.

Sure that would be even better, but my point was that we need not worry
about .startup racing in case of DPCM as it holds a card mutex before it
calls PCM ops.. so it is already serialized..

-- 
~Vinod
