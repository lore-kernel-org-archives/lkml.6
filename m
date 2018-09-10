Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA64AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F28920833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgOMCvJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F28920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeIJNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:46:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38946 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIJNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:46:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so20566092wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CPxOIUGhEj9rJaqY/EHPHSI+pPP+5egIMA38qsMH3+8=;
        b=WgOMCvJP0aBXl467hnny/mzd+5NwXpYFzEUwjews5WEIKSY1/syyxXF25HIGgULPn+
         /QW0yuekbWeYXT2460xheMVnHnDszRmLEDk+ZwjLEKSxNbZhSABnwaydryiJ3ne44N8u
         kyxRpMMX2Sdqy5EdZk4NngNm1k26aRcFXPlQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPxOIUGhEj9rJaqY/EHPHSI+pPP+5egIMA38qsMH3+8=;
        b=lOM1qXyxbE9Kez6vBYoNt6dfERtX49wO++qCzC8gsdx6MGL8bf+KMqY658puaqGuaH
         HWLzFrdzkcEI65NpMpqZ5pDU7Tz2Uef8vZajyGNiVWG+zhCF7MP2cuCfuhsAllXnsUfa
         7hxbUUcvH77BoxNGULf8g3km4AfsLCmeoBcOabi5FVMJS5RwivjOrw/Yy2S1oaYJkmbl
         qeGdnSTXqAVWLn5fKWd3KB68nJhJeCLQnGvEA/lmMfax2Zk/vC88qtQLbTcPaqdk9IgQ
         /21zi2TfhU62Mll0RxkACy4GZDIXYFGlMRhhdnv/dK+3bNKC30nE7Q71BuE4UhLIiP8t
         Ln3g==
X-Gm-Message-State: APzg51BxhRkY/GmTvU/WZ8Nu+aPxSFaH9iPE1cg2veVZ6AZB0O+4GB2U
        RMBPTf5aZsExWPLFm3CrU9yveA==
X-Google-Smtp-Source: ANB0VdafNtS6bn8zpBGy4+22UbFlXFm9afg3lnfan+aWNnfrFDCy9OPItsc/ojIutsT3hL1045515w==
X-Received: by 2002:a1c:ed4:: with SMTP id 203-v6mr12447417wmo.96.1536569631643;
        Mon, 10 Sep 2018 01:53:51 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x15-v6sm13986746wrt.53.2018.09.10.01.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 01:53:50 -0700 (PDT)
Subject: Re: [PATCH v2 11/16] nvmem: add support for cell info
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-12-brgl@bgdev.pl>
 <21ec4e6f-aa39-66cf-af32-d9e8e85f4961@linaro.org>
 <20180910093632.3a9337a9@bbrezillon>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4c569813-aba0-8e9d-dfc8-653b6c2e365b@linaro.org>
Date:   Mon, 10 Sep 2018 09:53:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180910093632.3a9337a9@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 08:36, Boris Brezillon wrote:
>>> --- /dev/null
>>> +++ b/include/linux/nvmem-machine.h
>> This should go in nvmem-consumer.h, I don't think we should add header
>> files for each usecase. These are nvmem consumers so lets put them in
>> correct header file.
> Actually no, it should go in nvmem-provider.h. Consumer should not be
> allowed to define cells, only reference existing ones.The usecase can be provider and consumer.
In arm machine use case it is a consumer and it other use cases this can 
be a provider.

I agree with you, It makes more sense to be in nvmem-provider.h

thanks,
srini
> 
> Regards,
> 
> Boris
