Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C38C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDC420643
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iT+YfaH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeLaRUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:20:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39772 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeLaRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:20:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so13392360pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nb2eVXWKZAJmf0jz58cAXJqYCHFAQuo+JzLOod8kYm4=;
        b=iT+YfaH+k8PoUjmfSscp9pHfMA4ph63dkhC1/ufWA81TAAN/3wx8789Zp2KR+mNlVh
         5GkprpHSRWWtmXKRcGF/X67IrVA4+39T+zAJmeIcdWEk0qeGpK874hECGgt9POjhiSxl
         8SD40lXtAy+ZccEYwD4eqxyvwxGvol0ITjvWzEWriME8qb7Dv8yWQWBlI85aw1znssdB
         MU6hyrwycQdokZCaXSJEVHUUc2EvZkfTOXryM0Gm32lp/gHLVYUQTxCa5MKkuySP7Y3l
         Y66YUgE6S9teg8BKrmghcXNCYyFiiC/ar+rB9z/7GzqAIcA4EQWJCuZdGSBBkPMexN5e
         tNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nb2eVXWKZAJmf0jz58cAXJqYCHFAQuo+JzLOod8kYm4=;
        b=qEU1dKEuqx3/TH196LEfOqWyhU/x6yEzoz0E8Y00fcwl7UYNir3nu+BDO7j1z6lgH7
         e7JKqgdGX3OSQkdDrYbbeENMv2QcvhSAU0kDc9SSzeSHuNjgl51tUY5KnHP5OpFIUKhE
         Xjazll40BBeqSK9yQ8yytu/UlL0zbWXlMX5HyuPN2qJwvZ3pv5SkPaWMWEw3SHA8Wfra
         JMfdB94zC1qvLLXuD9JfWAAWoPcnQyWS5mxviw2IWBEMz1m088KSdnfC3+4iFAtPmUlq
         R0vF1KZmz+npp7HFBhOqZHnqg3BgCGbPlJXbR2pptjGq4hIzuwqkY+lYPFlMQduDrFhV
         3B6Q==
X-Gm-Message-State: AJcUukd18m7yOKeb3VOQT6Yura4mOiBhFDeg2XLa8fyKo2aKtjKovqon
        kb5LcirChQBhDg/zYUXOtUXHL29zq97NCA==
X-Google-Smtp-Source: ALg8bN5NtjBGQY/Af5MitsQfwaPXyGWw+TXoYAE1Fg4yKcLBUxsmJNR5fp4dTLI3jNqvIZAyW2sJ2g==
X-Received: by 2002:a63:2586:: with SMTP id l128mr8301096pgl.104.1546276820383;
        Mon, 31 Dec 2018 09:20:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i193sm76888608pgc.22.2018.12.31.09.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 09:20:19 -0800 (PST)
Subject: Re: [PATCH] block/swim3: Fix -EBUSY error when re-opening device
 after unmount
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <177ead1d637f617792aa5ca2ee294d61e3d0cea2.1546235049.git.fthain@telegraphics.com.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75422eb4-a0d7-c71d-643f-24496d86c74b@kernel.dk>
Date:   Mon, 31 Dec 2018 10:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <177ead1d637f617792aa5ca2ee294d61e3d0cea2.1546235049.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/18 10:44 PM, Finn Thain wrote:
> When the block device is opened with FMODE_EXCL, ref_count is set to -1.
> This value doesn't get reset when the device is closed which means the
> device cannot be opened again. Fix this by checking for refcount <= 0
> in the release method.

Applied, thanks.


-- 
Jens Axboe

