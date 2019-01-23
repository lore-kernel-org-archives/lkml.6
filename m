Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D7CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55B420870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bv6Q7Ro3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfAWKLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:11:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34742 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfAWKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:11:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so10573959wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dBPGyksu/p6C69hqJ+z25/t9MgYsNomdetYysvi9FiE=;
        b=bv6Q7Ro3eGnBUc8z4uR3ddO34jLVAz0HlxwbWZqwZe8m2+dlDi2NuHmHbNW8AMtsYj
         GvOnVKyUuVmK78ssSddjjTOFzxWBSmg/LGsRaCEaKNx0QqORX3+BjEZ/PvBY0OVNK0On
         ExGsAoF3CkC0OAMtx+Vr1hNbueEp6zYhOyPBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dBPGyksu/p6C69hqJ+z25/t9MgYsNomdetYysvi9FiE=;
        b=g2yFpzxWwR+I0mKySw5Y21uJnErXQO54fqNsHvsRpDIjvZG21jPJSC9+BMvq5OzUEZ
         ThwQDljGeMdCBm9cuI4U0QqbSXEfraAWy4T5m4VttB7qMCkIoUeXjTd76yCtjgJiG9bN
         Tvwg7tErppKskr0xMd+npXXNxoYfpc6uxCJVFoclm9QSsTEoxzzPcaRu758Z8uhLxTMX
         Bod49DbQl8OVPO42+eUqNsTgdJyPgBtYDlC05XjDfPTRO1bA6Zni/10arLbrRSSjk+b4
         DcYUgsGmTk83qv97PvhiGQj+NvwNShNo62lV3s/KrWz73+b2DPUXc/kC7Ka3TkM9GTfP
         LkUQ==
X-Gm-Message-State: AJcUukdgzsv9aKzcZWOCg5lz3IWBWoSSZtBG87rI+m7RfWh6ns1rYhIk
        sTkjqLnXS0HGE7RwcjKp20FOxHj9zGU=
X-Google-Smtp-Source: ALg8bN6nGTo4qjyh9WK1NoR+HavC8GCw9cZ9jQbiAOSQVSTA7cb+nIkI6qvHm6FDrSXvy2ObGrRXBQ==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr2163949wmf.78.1548238293108;
        Wed, 23 Jan 2019 02:11:33 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 126sm45233616wmd.1.2019.01.23.02.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:11:32 -0800 (PST)
Subject: Re: [PATCH v5 4/8] ASoC: wcd9335: add basic controls
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-5-srinivas.kandagatla@linaro.org>
 <20190122185253.GG7579@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6a3664d2-9b10-d6e6-9df5-ed50364812f4@linaro.org>
Date:   Wed, 23 Jan 2019 10:11:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122185253.GG7579@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 22/01/2019 18:52, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 03:06:12PM +0000, Srinivas Kandagatla wrote:
> 
>> +static const char * const wcd9335_ear_pa_gain_text[] = {
>> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
>> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
>> +};
> 
> Gains should be controlled with Volume controls, not enums.  Provide
> information on the levels via TLV.
I agree, I will fix this as well in next version!
> 
>> +static const char * const rx_hph_mode_mux_text[] = {
>> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
>> +};
> 
> Is there a strong reason not to use more human readable strings here?
> 
No, I can rename them to below if it helps reader.

"Class-H Hi-Fi", "Class-H Low Power",   "Class-AB", "Class-H Hi-Fi Low 
Power".

Thanks,
srini
