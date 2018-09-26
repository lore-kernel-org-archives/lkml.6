Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE08C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2987214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAqOhUwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2987214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeIZRI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:08:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34555 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:08:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3-v6so717775wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95u3iMNFx3mOvuTdGst5f8Nuu/fSzvMzL2bvIXTVBCY=;
        b=KAqOhUwiy4sKr4JwuxMVw7INDWXis01UI0E4aLntMSxsHGsUeAVSlE5K2y0gCtBRpc
         XQCnq7Rxe+KX+Be6N2PUFOrId4PkxFfKLHxDVSMxKKLgCk+usEti+UhTTM+pckxklVLX
         nmXts9YsKiYA79toVpc8dC09KIaDyllatJT8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95u3iMNFx3mOvuTdGst5f8Nuu/fSzvMzL2bvIXTVBCY=;
        b=p1cx4ssZ9Dp9qOGlMc/fZx0eNMdMCX8wkWhhQggIzk1M//Vt00BUExAYpfHNBhdjkj
         /IZm4X2dMPavMax6D5wVzECHp9SuDvHJkDqvGZrL8+A2lCJmosOhpXTpwPJJOkUiYFG0
         sGMOjhY/o4jSBo8ooUHbLRQH0RwYyVu9Ifoxb3e0/xVcniCXI09jqUQAupHL5tXYIqbX
         kgxiHD1DXJpCpP5/2regeXyOoKdKuIhxXVfA8svdOV17qXL5d0CCSbeRr2uCeSjNR5KG
         VmRAYW72vg6YZ423Vo+M+k2s8EhzADY7nuL7ZmZSP0TNWSbPsSl0tH1g43gHWYv9SA3O
         sN1g==
X-Gm-Message-State: ABuFfogMbZyBgF/33UVnuiqX4qbBUOAhZuK3lwKc1F5xRyMZtH2HUf1j
        ChGfF6Gu/mrGDcbNujqnP0KO0Q==
X-Google-Smtp-Source: ACcGV62YCR7QXwFORQhzM/nB3GmOF7SF+scoRB6hQCcowtA2N67drpmPjR6KeBEnv9wpe2iftmxtZQ==
X-Received: by 2002:a1c:706:: with SMTP id 6-v6mr3678613wmh.83.1537959362913;
        Wed, 26 Sep 2018 03:56:02 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id k63-v6sm8496544wmd.46.2018.09.26.03.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 03:56:02 -0700 (PDT)
Subject: Re: [PATCH v4 11/14] ASoC: wcd9335: add mbhc support
To:     Banajit Goswami <bgoswami@codeaurora.org>, lee.jones@linaro.org,
        robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-12-srinivas.kandagatla@linaro.org>
 <8582abce-b1c8-24fc-7db2-b7101a6e1362@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ec360aa8-d32d-b391-ce50-abddf2705e3e@linaro.org>
Date:   Wed, 26 Sep 2018 11:56:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8582abce-b1c8-24fc-7db2-b7101a6e1362@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/18 10:31, Banajit Goswami wrote:
>> +static irqreturn_t wcd9335_mbhc_sw_irq(int irq, void *data)
> Are we supporting only headset and headphone detection for now ? 
> Extension cable and electrical detection will be supported later ?
> And how about cases for slow insertion scenarios ?
> 
I can not test extension cable and Other features like electrical 
detection will be added in future if we need it!

--srini
>> +{
>> +    struct wcd9335_codec *wcd = data;
