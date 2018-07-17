Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8D3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bl312LO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8D3205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeGQWvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:51:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42878 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGQWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:51:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so1052015plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D/YGTuN6Klw2q4jYEyvzusVSx0bxBDD0pMg2sv98vYQ=;
        b=Bl312LO6YcCHMiq7AcDLxgvNO1zQNdBNJantnTz6ON1DqvBGqOmYC/V2uYd794Xwlo
         IHc/L2Gi3Tp1wHWRUb0ckjVDLjaev76lkv33CpmyKJTl3Oixta3xDUZ9HHKg9EnhxWR5
         UmWxjW1QoQBg+kdB9NBFGcpSsmi7AvPyHqx14DcdOQHA5KJ8l6POZqVnJHR5sLrqQHfU
         cdQMFXybboUq84IIgWNAq2hDqVmJRzcne5h0G0Q1sCwyuxle4vcLSaaB9esRGltwaUlM
         VwYGHy6JaB7GEQxHlPKNPaGjFXHVsvQtLrfyDR4pORAp2f68sAwuCUPJAsmwn/amkjuL
         92pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D/YGTuN6Klw2q4jYEyvzusVSx0bxBDD0pMg2sv98vYQ=;
        b=Mp8PkkX5uzV1XNBzueu6UTkmj+xC2D4F3aAlzH67/+7x4YS4ssmehjia0YkJ+V30VL
         PCO3/oBdGd7yuG1dhFMqVIIvlgijTZ5tnDaKF7eKwfaFtEqr/J89Br9QVVrguQtdcN+G
         mlSQRgIT8QIYboY5Ol6E/3B0SRtS7uTdsMejB4+ivhoH9HOvHJAH6uX8HIfb6VdyVCV7
         m9NMex/HGMUgtPuPA/bRllF8Ak50f+9RUjn6/t1bMrwwQuh6pO1f821QZpuFcLiBQ5jO
         NhE5jxtgGshTNEiYk2NfMgSaMSpMwi9iVy9RBauLWam2phc0CCES7NmqLjpUcCFqvsd6
         eyww==
X-Gm-Message-State: AOUpUlFUgnPC5+RNGf8Ze6BbVp0+qDNuDNh6ew7EHq9OqhEIJ+yWJFQe
        fHi3r7IwREzbtRIJCbzAUJSCMg==
X-Google-Smtp-Source: AAOMgpdAMelQb/0t1Omb5R+yDd8DkooXfrKShcvdDXO/vsmAY9QXLPQcYP+1dO0KoucBxqnCW7/xMw==
X-Received: by 2002:a17:902:a981:: with SMTP id bh1-v6mr3307617plb.2.1531865822944;
        Tue, 17 Jul 2018 15:17:02 -0700 (PDT)
Received: from [192.168.1.56] (206-212-239-179.static.onlinenw.com. [206.212.239.179])
        by smtp.gmail.com with ESMTPSA id 1-v6sm3280632pfm.145.2018.07.17.15.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 15:17:01 -0700 (PDT)
Subject: Re: [PATCH] pktcdvd:checkpatch:Remove assignment if condition
From:   Jens Axboe <axboe@kernel.dk>
To:     RAGHU Halharvi <raghuhack78@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20180717170212.17197-1-raghuhack78@gmail.com>
 <96cc7712-bbc3-25fa-06ce-876bd8068f61@kernel.dk>
Message-ID: <6c46fb77-93d4-a24a-a99e-07242a597b67@kernel.dk>
Date:   Tue, 17 Jul 2018 16:17:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <96cc7712-bbc3-25fa-06ce-876bd8068f61@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/18 4:14 PM, Jens Axboe wrote:
> On 7/17/18 11:02 AM, RAGHU Halharvi wrote:
>> * Remove checkpatch errors caused due to assignment operation in if
>> condition
> 
> Applied all three patches, thanks.

I take that back, only patch #1 actually applies. Please resend the
other two in a series, which apply to my for-4.19/block branch.

-- 
Jens Axboe

