Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010DAC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA31F2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mmv15kBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA31F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeJVRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:34:42 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:43893 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeJVRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:34:41 -0400
Received: by mail-qt1-f181.google.com with SMTP id q41-v6so45382861qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J8hKjGL9XnVpHdgJh2lZBsuf0iZHIAAdkctiupTtcM0=;
        b=Mmv15kBqJB6K0IKzn027xvDs1elCxbhM9rfAP/qprdpykjT4p4K5gAMhXE4k7o3APc
         CvYkR20u5NtBbUoQQDofZD2j4ry4+FNGH3dDELtz516BsHuUWxy/rj/z4diJUpAqon2F
         gE9u9Y5JtKD5H8+FXXzij1XfyJPc2yUxzFRl8vltpEV5wA74psvsBMw5EKUWX2AudtVh
         a8KJVDYTvfmyvGZvK5Qw+aMvSDSsGxmrHUY00xn6FB1eAxh3kMryylGaSJSuO1c8PBkj
         hQzxS8eh5TfV6iB6/httUIvatQxvTgRO5SHjza8rm7apqimzjPV8/zpyEVPkdVRu6yHv
         5ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8hKjGL9XnVpHdgJh2lZBsuf0iZHIAAdkctiupTtcM0=;
        b=VVk/p8w3TB8PqVMbZoWgW27tMEUjSewVFgiaGh/ZzBsRX9ExrWm435E6x4urXcC8YA
         jUO/XpyWqjsdwlxwdeoGsv37+AlkPakTyIBRfnhtVuyL4wX1rSBroh155GAqjjUONqgD
         r35FQSjvApjQ/9nbsTzrzzIbklBUBma8E8rVcSr7SLTZZ8Pz9bI2c63VaGlFZVx/qn+V
         Vm9u1c3iPd4aKDJ3MyJ43/HzkDKbkUHiWHz+0vkgywAD3WCpmC8JNpr2204+vVWvIDw3
         jQAM1DVwT7U9AO+fMCXZAVXhboxJwRNMoywhSUlEreHOkDbloH9Zs6iil1c4beL0FXKV
         F+Kw==
X-Gm-Message-State: ABuFfohNpC4Z4f1psfVJuYID4LABGyjMrKWg6zZTaRr6yjQvCbRbKChd
        aOLjAXYe5wRy/XBwNXUHTcWdrqZ0r40=
X-Google-Smtp-Source: ACcGV61KLkquq85jOjkDmxDvoaJZXvYExXYiS/6o941J/lHVE+dByIixyKDsN6nnKz4uEy0KkAHEDg==
X-Received: by 2002:a0c:b5ed:: with SMTP id o45-v6mr28996215qvf.12.1540199820348;
        Mon, 22 Oct 2018 02:17:00 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-59-201.mycingular.net. [166.172.59.201])
        by smtp.gmail.com with ESMTPSA id 5-v6sm5327437qtz.8.2018.10.22.02.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 02:16:59 -0700 (PDT)
Subject: Re: [PATCH] skd: fix unchecked return values
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181019184417.GA21154@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf4ab819-0116-e0cc-5186-441415609483@kernel.dk>
Date:   Mon, 22 Oct 2018 03:16:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019184417.GA21154@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/18 12:44 PM, Gustavo A. R. Silva wrote:
> Check return values of dma_set_mask_and_coherent().
> 
> Otherwise, if dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> fails, the following piece of code will be executed even when the call
> to dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)); returns 0:
> 
> dev_err(&pdev->dev, "DMA mask error %d\n", rc);
> goto err_out_regions;

Applied, thanks.

-- 
Jens Axboe

