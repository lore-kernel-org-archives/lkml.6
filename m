Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC16208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bh2Eu9TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC16208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeFUPJw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:09:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34847 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932808AbeFUPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:09:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so6866724wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q5bP6U6pvxDda8fTrAC+SHwb5ZJxZ0Ofoclufdvz0Zw=;
        b=bh2Eu9TA1X0rsTRiMfJwSymWl4fAkjtxBiFc6z6qsMrIcw2xTOmKmEx/VRaRxhRlcu
         nHpjHFhzsSfzLIIJkwAP8Ni0QPf8b5UUOEiX22aSsk/3RuDVZJkdDH7LLMi+X//VdQok
         V1Y++RRg1DDmcMzNCha2DeVxu5h0jiu6NgJ/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q5bP6U6pvxDda8fTrAC+SHwb5ZJxZ0Ofoclufdvz0Zw=;
        b=fDzsMCWeAjKRjXRjJAd/+eMoZK63EwkkDdHF/o4KiyR+Lu+ZkK4F14Gv5WW4EIV+b5
         p20bCXzyxEmAcpUdgYbVY4MnCdbjBD3cc/xF0FM8MCaKqox8d7DeiQ/TypbIHprAHGEo
         VwTwimFsocpJqDyetGVqNiWP5lti3pqEgTB1xZ0TyiyhYhT+I037twoXrMt+6PGYTfgR
         CFGmk3hWzTO3ULuwoHllo10N+ASNPdnG6UgwHMfBd3MiTznFLT228Kb3IFXB39WMActD
         2nTUg5l9ra/Ze7Xv+PRYOu8bBiwNLs0aNHQARVgZPM8gGJAnngRsaVp8sBkJg8F8aiU+
         gxUw==
X-Gm-Message-State: APt69E1S6mtHZbtoIII6RgF5gDy5Toyc7ZWZHmVYx2xH07ra1RahkYT9
        YjZveBVpGiPdQqWm3Iu8iE/JxYOGlbc=
X-Google-Smtp-Source: ADUXVKJqeIDRoZ4Aa90/00UvikYTMTSwuk2iWXU0vpoPYTEHF/3uolzf107M3X5n9sX00gG4SY0E+g==
X-Received: by 2002:a1c:4743:: with SMTP id u64-v6mr5390029wma.49.1529593788841;
        Thu, 21 Jun 2018 08:09:48 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id y18-v6sm5773319wrl.53.2018.06.21.08.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 08:09:48 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
To:     Vinod <vkoul@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
 <20180621123503.GD27187@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
Date:   Thu, 21 Jun 2018 16:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180621123503.GD27187@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/06/18 13:35, Vinod wrote:
> And this one is generic DT parsing and seems quite similar to one in apq8096.c
> Can we move these into a lib and use them instead of duplicating.
I totally agree with Vinod, We should probably come up with a library 
functions something like common.c so that we do not duplicate code.
This code is going be exactly same for most of the SoCs using qdsp.

thanks,
srini

