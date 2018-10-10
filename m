Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAADC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85AD2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c2mA2h3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85AD2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJKDf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:35:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50529 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeJKDf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:35:59 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so3945413ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LYnfnEdq7MztyZ2Xo25HZQqUPDN2oagMjtxa+0w7MtQ=;
        b=c2mA2h3bW7H75F2OPyyiRxdLLpJJ1A3Rc5znxQZ58xSHYqxo2eKV8AC29HRmpBZ4Sg
         lHUTJvactl5Ed7ncGqS1RZ1gPw3i5ivzutEg0GL247XaxFz7ClnV2PE77DV4k7L6bM9E
         F0mIF6GNfpopEPyJybRfdC1GBev+AT1INcimctRUEIP86jZaZ18nL8Jq+KsZ5BaQzyjT
         rrvwP2hMr+IoTgLmS/4MVOqq1ehZTM1040aJ1XPzZESsasHgwRyQF53KM/DigJu4L4Wy
         fhhBQAuzteCX74zAZ1LkJ7t2Bf32u+Zu6SZ2OdzkV4a4maLXBcHnq3hOjjneGV2sO/3L
         B4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LYnfnEdq7MztyZ2Xo25HZQqUPDN2oagMjtxa+0w7MtQ=;
        b=qm+UroC3tq8JzzpoTJoSSuNF3XqCGBy38hX0EyLZLEsWh67XFlss6MG1AGtRWi9WaF
         iyW2ayMADSG2MMFFWcPM3FXJmJLrd/yxgNga6b5R3/kX9EoPUxFRbHFnBHlBPGK4eAI0
         xSJfqSejtcORbOkt/vLnuwls6JNRKQEATC/gNS4IJ7Mo6puOmqG3AIyTadpHVF7sobu2
         wFaytaqOcwvFppqwLwk+xxI2IOtF9UNqzcBuKng8BAi1w3FWgC1XrjMDoPfKx2iDs7k1
         NJGZLEZ9+az4EGsr/gznC7hSZFKirfLJAieKL5Q7vbhfRXPW/52ETZCGJV7+jQL3GPr5
         RpgA==
X-Gm-Message-State: ABuFfohbQAyp0i3l43gG8kxAN3AhXpKtjGxs6idMkUkwpBfH2uavUgsM
        HZh/SytB6iQ+qtiOE2mlO5WTdbeHrMA=
X-Google-Smtp-Source: ACcGV60H7bXHGlRsdRAchUy+92UBJf/AuNWG8TbvCHil2eaYzWglkoih2ZvhofHk4csW3gcpSxuZHQ==
X-Received: by 2002:a24:1dd8:: with SMTP id 207-v6mr2065436itj.126.1539202333600;
        Wed, 10 Oct 2018 13:12:13 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b71-v6sm6431141itb.33.2018.10.10.13.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:12:12 -0700 (PDT)
Subject: Re: [PATCH] ata: remove redundant 'default n' from Kconfig
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0@eucas1p2.samsung.com>
 <20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0~b9-NKlREZ1372313723eucas1p2t@eucas1p2.samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54c0922e-7c64-8870-f8da-65531aaefbf0@kernel.dk>
Date:   Wed, 10 Oct 2018 14:12:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0~b9-NKlREZ1372313723eucas1p2t@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 8:45 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...

Applied, thanks.

-- 
Jens Axboe

