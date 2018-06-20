Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D2EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9B520872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cqlat7bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9B520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeFTJxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:53:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34804 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754136AbeFTJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:53:04 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so2624246wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7bEzNpwVNfd5dxLT/16ZzbWj/oeCvxJANWTSMJIWLbY=;
        b=Cqlat7bCZuCJkbfKpYh3CdiFQanu9a7ujDehQG4QaH5MDYugfH9zzpxGSjZ2OeL2gn
         2PkMUzvXkUl6I/Uawl8Ek5jUgfHy/aFcj8z9KWh/YEVSoODhl+82y7ycWtN+NriiaGIg
         e+0XhIwo7zW/BRsCKjUbT4EbUxw4UhhJ1Xs0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7bEzNpwVNfd5dxLT/16ZzbWj/oeCvxJANWTSMJIWLbY=;
        b=oHlXvtOZctvEwCyuq9kiVlDu/+KRAQFbn4IOMSGUG/j+/T22YXMaGArXqh6IDy7LIW
         aExhATKs/jJSu482Pl7xxONftBtLc0q6hBbMQd0p8K/SoaV4udTgS9ThFjmjTQu/DhdA
         RZ8qZteOSwO2qQc4uAs4SLV2trFrPoh/cMBT0FfacNFNxGU9EaVnm/ukmQuKxmNEAKHw
         9flD57XpfN1gYymKd6R4YiHltcXEPQLgVNm+LC7+JDQfhFjKwdac6smBcVINS+Uxle2S
         7wTs1ZwgyDiHeMHHvQ6UgT0I/cITi67jXpKEa5kWgj0mCqiVz8K78Yz4nUyDBHiFZHeU
         G+eQ==
X-Gm-Message-State: APt69E3IeQNTgqnpdnkgK0e39JMxddgQW0xGkwjmEFcaLBIwgOZ47s0b
        ohEJHu/XdiLF2quJYoUWREZozxDrlxU=
X-Google-Smtp-Source: ADUXVKKbpSgIOKfgzjOLR9SzsahvfPaRO0pOCAnkAreDUbQ3BT1K1lFDFCnEc9b4Kr3AArOFfjiUMg==
X-Received: by 2002:adf:ab10:: with SMTP id q16-v6mr16729216wrc.239.1529488382668;
        Wed, 20 Jun 2018 02:53:02 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id t14-v6sm2483588wrm.79.2018.06.20.02.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 02:53:02 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
To:     Vinod <vkoul@kernel.org>, Rohit Kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
 <20180619162230.GF13316@vkoul-mobl>
 <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
 <20180620093106.GI13316@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <53db13d7-b4bd-0e06-4110-ce75fd0bdd3c@linaro.org>
Date:   Wed, 20 Jun 2018 10:53:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180620093106.GI13316@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/06/18 10:31, Vinod wrote:
>> Here clock will be enabled twice but disable will be called only once when
>> count = 0.
>>
>> This will make the clock always enabled. So, I think we should keep either
>> mutex lock or atomic variable to synchronize this.
> we are using DPCM here right?

We should probably model this clk as DAPM widget so we do not need to 
handle this in machine code.

--srini
