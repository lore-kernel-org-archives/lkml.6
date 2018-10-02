Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B6AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DF420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Btbir0HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DF420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJBQiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:38:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37682 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJBQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:38:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so1460153wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7TGMIP6D8qonLFU4s8mZ+OFcMF75sJhMqhDZ38/NaSE=;
        b=Btbir0HXNzmwH2w6MWoiuvPIKNys8rVLQpz9FOZ096BwrgNEbkFOTsxzNjDtqyFPIb
         s7S8jWSJqhlRrQKwI+hca+VBQfOwd7S3tezxUHIMs3jy8/P/CAwKo3fKAXfi53B88EWJ
         a9/kxUaojG462ppxtt8Q8P6b83I9klbnn33Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7TGMIP6D8qonLFU4s8mZ+OFcMF75sJhMqhDZ38/NaSE=;
        b=cd47kUxshbdNVzH+ZnDRtrgvSoG9x8APZhXPX5B/BKs1UMdEJ4ds8CJNcOqdGPrPp1
         QQkzoGY/GC6lX6hYZObsDmbKDYFm/N4oVzReSRF7o4j3u6CLaEyjkmUFjDexyKYNjuvs
         UEDa0xK44QgzF/731y8IYYV7yoCqUBaiBDGQblFQJaiKN1W3Ox0OxB/C/E0LjqAUt1M7
         D0nZSZa6SH1tF9CGxE2rnTWIj7oq3OQcEgSrhamUKr5Gx51IJwBACP7yNFtFs5IyRFHs
         QlueJgCLPDNR6gvRhF6GRUmodR1/0oh6/OFtOY9kSsNfxvf2cXLkQ8DUEyOLl8TzAErc
         rplA==
X-Gm-Message-State: ABuFfoiHvWn16Z+fuVUjOycfFAVjAK83bZCw89cg1wtB/WnkhvZAYCbO
        6BTOIpjyJmbb9UGjmc8hID53UA==
X-Google-Smtp-Source: ACcGV60EDkFrHmVrs9ZZfXdi/Bk5UiKxflMvQDCjafc5CuFTq/1ZDEzbYydOJcp/+2xTqJv8Au+dwg==
X-Received: by 2002:adf:b30f:: with SMTP id j15-v6mr10432224wrd.207.1538474182836;
        Tue, 02 Oct 2018 02:56:22 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id o3-v6sm2581477wrw.93.2018.10.02.02.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 02:56:22 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the char-misc tree
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20181002191236.0aa50539@canb.auug.org.au>
 <CAMRc=Mf64AMBiMwBTCYeG18txVqbdvkQA35ZyZuRtwOCe70RpA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dabf8577-418c-65bf-03b5-89f0236bc53e@linaro.org>
Date:   Tue, 2 Oct 2018 10:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mf64AMBiMwBTCYeG18txVqbdvkQA35ZyZuRtwOCe70RpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/18 10:49, Bartosz Golaszewski wrote:
> this looks like a false positive - this routine is used in
> ./drivers/nvmem/core.c at line 943 in this revision.
> 
Note that the caller is under
  #if IS_ENABLED(CONFIG_OF)
so this warning!


--srini

> Best regards,
