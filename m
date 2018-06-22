Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14905C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26B0244D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ygpn1VbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26B0244D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeFVPdp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:33:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40274 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933662AbeFVPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:33:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id g18-v6so7116636wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gDPPlwSEeOwEtrwWYvynnZrLzWSjN81VTSLK/tr0RqI=;
        b=Ygpn1VbGPDyZWcEzew/UQ7JXplhPThhdsekNNSgnWNjS0MAuFZQO3f45F9k/rTEC/Y
         Cj/fTwdewObS1BJt5Ni947+13b5M9KOF7h078GINvdIVyFTj1FZU9n5Ia3Kr7zoui6is
         ysfRvksG5rxqiHKwMi+XxJ82ffgtIu6voF+Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gDPPlwSEeOwEtrwWYvynnZrLzWSjN81VTSLK/tr0RqI=;
        b=J7UvYY5dkPvU4TQY24QKY5voOD0yi8I5V8FMZNNku2bh+PchG+YxNN0J1hnVsi4ntH
         gTgav2xRM17YaBtXjtJ+nGTHNQ4F9daGBDE7dufI5mYT++jhCNcW0/oDbRSx8kw6VXbC
         69jJjnbmVuiw++ZWownL9jWiOpnvug5WPKdupofXX/xs/9EioBicrwPfZ8NvJ3M5EF+A
         7r9NubenFsk7AmtmTA0ip/xSs/Qo2XH3O6G4GjuS6r8hmII+VR5NvLFdOwBzXGA/0Bak
         GOixU7/B0NBonqjFu9lXmNZg3X7ke1FZyxvT0Cmgwk92KUcT2mej1PUMPaLBAspeIkKn
         kVsw==
X-Gm-Message-State: APt69E3daWr4K5VUnAkVepZ+Xio/aLV4ZruUm1GMhPSc3034X0LHN/Ow
        gSBP8TgXp2l+JY4sYXEeQOetEQ==
X-Google-Smtp-Source: AAOMgpdpIZXLGeVRTIaSZLTRaFvaw4VlI5qOyh6Mc7LFRncYcEE9zFhUSUJkcYXvf6YWCDguCY+aZg==
X-Received: by 2002:adf:8023:: with SMTP id 32-v6mr2075817wrk.243.1529681622589;
        Fri, 22 Jun 2018 08:33:42 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v10-v6sm11554941wrn.97.2018.06.22.08.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:33:41 -0700 (PDT)
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Vinod Koul <vinod.koul@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
 <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
 <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
 <6782b1c0-ea94-b07c-2fae-3fe3223bb22a@linaro.org>
 <20180622143829.rd2ys6ci7q3aupst@gondor.apana.org.au>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <015f1c8d-553c-3d54-c7c6-34bbb4fcd1a0@linaro.org>
Date:   Fri, 22 Jun 2018 18:33:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180622143829.rd2ys6ci7q3aupst@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/22/2018 05:38 PM, Herbert Xu wrote:
> On Fri, Jun 22, 2018 at 11:27:59AM +0300, Stanimir Varbanov wrote:
>> Hi Herbert,
>>
>> On 06/21/2018 02:53 PM, Herbert Xu wrote:
>>> On Thu, Jun 21, 2018 at 02:27:10PM +0300, Stanimir Varbanov wrote:
>>>>
>>>> OK, I just wanted to say that it is _not_ PRNG and the register names
>>>> gives us wrong impression.
>>>
>>> So does it generate one bit of output for each bit of hardware-
>>> generated entropy like /dev/random? Or does it use a hardware-
>>> generated seed to power a PRNG?
>>
>> I believe it is the second one. Isn't the second one SP 800-90A?
> 
> In that case it should switch over to algif_rng.

OK, what about the rest drivers in drivers/char/hw_random? Are they all
true RNG?

-- 
regards,
Stan
