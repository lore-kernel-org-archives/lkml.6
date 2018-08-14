Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A30C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1F721734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZyRiUpLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1F721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeHNStJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:49:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52348 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeHNStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:49:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so12750088wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h5r8TFRT0Bp2IcXHZlee0tyxzoWUuB1iJn+r8y1tBjg=;
        b=ZyRiUpLt+i4/dY1utlW4SXSeUGiY3GUliQvsF4kAzR5GiVaOd99RGU+PXxztPPAJWf
         VMLouCUvs7z1R2YLvzy73UJdLuPf4GDXl2rWuagO1l/rqsImRYjLSnxyheZv+fzXx2T2
         GB9VEarXreted53KcDqr/Rab/ypSMm6CHzg0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h5r8TFRT0Bp2IcXHZlee0tyxzoWUuB1iJn+r8y1tBjg=;
        b=uKcvhizPe2vGqMCjdtzzFDnknjUKP4+WoGjxshgPRNPxkhs23XGVu+KaXSWoFAAB9M
         bfQtQ1yRQ5p9N86OcxQt2F3HXf9SIx7xlaqBBtFQkvN7C81UQoi5mg4i4v59pMkS4Uoy
         PW7ftrrIKWMw4eUPgzF+lZLjem2w3n9HHst1yaEoTmWG6zyGm2k5wvvLBxmOweoqdHpD
         tIlQobVmIG5WSlqb3lA4EX7eiDGioGffElcbHZYCZ1+02GctJza3eH5aTkWBCgtd2gUY
         vv/f0fyw1ALxGypK1ZRg2XL5FaO1cvZz0fYXK8V/C7bmqlAofYhgvAGJBBJEE77H1/QC
         Hvxw==
X-Gm-Message-State: AOUpUlHkVNaWW0UdtdX5KJDKkhBy74y1CTMeatQ/U2lo5lkb+b2TnRxT
        agjHKt21tV2I5b2bJyx0qwhN/pe464Q=
X-Google-Smtp-Source: AA+uWPxZelVRMHI6LYEtmM1KcybGdDgLJBNLBzWnHbuP3plfjtWqjGiwmgpScSTWuY/rhmEfvyK4oQ==
X-Received: by 2002:a1c:90ce:: with SMTP id s197-v6mr10495194wmd.11.1534262483088;
        Tue, 14 Aug 2018 09:01:23 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id u7-v6sm26014281wmd.46.2018.08.14.09.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 09:01:22 -0700 (PDT)
Subject: Re: [PATCH] [v2] media: camss: add missing includes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, hansverk@cisco.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180814091636.1960071-1-arnd@arndb.de>
 <565437f4-e01a-4558-ccc1-4f312e26cf35@linaro.org>
 <CAK8P3a2swXMsOnOv_Oow6TCShna4LLfm=uuNmvKk+O2GTZMr+A@mail.gmail.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <d7fe134e-ad9b-06cf-d6bd-cba875b6bc24@linaro.org>
Date:   Tue, 14 Aug 2018 19:01:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2swXMsOnOv_Oow6TCShna4LLfm=uuNmvKk+O2GTZMr+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 14.08.2018 15:58, Arnd Bergmann wrote:
> On Tue, Aug 14, 2018 at 2:45 PM Todor Tomov <todor.tomov@linaro.org> wrote:
>>
>> Hi Arnd,
>>
>> On 14.08.2018 12:13, Arnd Bergmann wrote:
>>> Multiple files in this driver fail to build because of missing
>>> header inclusions:
>>>
>>> drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c: In function 'csiphy_hw_version_read':
>>> drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c:31:18: error: implicit declaration of function 'readl_relaxed'; did you mean 'xchg_relaxed'? [-Werror=implicit-function-declaration]
>>> drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c: In function 'csiphy_hw_version_read':
>>> drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c:52:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>>
>> Thank you for noticing this and preparing a patch.
>> I build for arm64 and x86_64 with compile test enabled and I don't see these errors. Do you have a guess what is different that I don't have them?
> 
> I try lots of randconfig builds, and only one of them hit this, so
> it's surely some
> header that may or may not include io.h and slab.h depending on the
> configuration,
> or based on some other changes in linux-next.
> 
> Since the solution seemed obvious, I did not investigate further.
> 
> If you want to try reproducing the problem, see the arm64 config file
> at https://pastebin.com/raw/bNTPvYfZ

Thank you, I was able to reproduce it.

I have sent another patch which changes kcalloc to devm_kcalloc so the
hunk including slab.h is not needed anymore. For the rest of the patch
you can have my:
Acked-by: Todor Tomov <todor.tomov@linaro.org>


-- 
Best regards,
Todor Tomov
