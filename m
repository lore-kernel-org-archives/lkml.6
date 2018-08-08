Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB65C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904E62175F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Aw2SSwnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904E62175F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeHHSZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:25:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42951 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:25:16 -0400
Received: by mail-io0-f195.google.com with SMTP id n18-v6so2220839ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L8DKoROSsOiUyNybow3fCKDivmCX773+Mpkg7vVOPms=;
        b=Aw2SSwnvvhUTBLSGOfmpfYV3LEWTRy6CdkgiiUv4bZIPh+R+kcQP3W2aOmbPxp+5z5
         1fwZr9YJ48NPXCBtSRSx0j0bhvIfhK4U66UJHfkURQ3M5gl3ZNQAWIpw4QHvsv7R0Nry
         G2fy07ew4Nr+5W8nlCipj+/CaacH9Emu+jVfAhFpQtr+G+SpOc01UtxoUEtHw+WtUNDD
         59SfrhGk9orFtECpCM3KYsvX8YeMYfzXQhDlWDo+naCifrrH4sjdu6UPkBK1rIqdI+E1
         6NCx4Bsk213OZiBjOqC4iK5+5yRrFHidjF4Qe8b97R0CdBfu7AzIB/jvvzzYfFR4KHZG
         joYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L8DKoROSsOiUyNybow3fCKDivmCX773+Mpkg7vVOPms=;
        b=LA42JlUKYJlg2pk1RnlDKjM0IGqnaPp7eBCMmu11tZOo/rR0QzCa+ByB8qpV2hF3/y
         TErn5W1M3YLSLdXmqju14HUiVfrp7+odL3Azx80SDDRG4tIbYOqiZtZSjnLxqwecU7sc
         NvkncGt9o+d5jmR2xj3H515wKHZfJ3xqjHr0qnZw3R2yKtbb8I4AgdatYC4CbnL7Q51N
         2KthhEFY7e82ldkHOqbAYa6CC4yBo3qELyobxhCR5YoFeD9L7ArpyvgRL6UH2vDnp1P2
         ZGG19n/4i8tLxInfJ1nqsq0V5Olx19JPKxVeqUoN7vHB9oTH8NazESCfNG2UBeEKyxDO
         gOAA==
X-Gm-Message-State: AOUpUlHnnOlVcodIhohilQWdSCkNJEw5x5vVsxZXjiZBf5kQCwfCBgAj
        TX5Oowzxw7ohSkfb7XVy3EZt1tSMnwM=
X-Google-Smtp-Source: AA+uWPw+a72zFl9Ccz8KkDqgq4p2XVrp5cTJXaeUXQ3C0qyLrb7iTkqE5BEzNQMZS8VlLVt2CvXlXw==
X-Received: by 2002:a6b:b546:: with SMTP id e67-v6mr2878729iof.179.1533744295941;
        Wed, 08 Aug 2018 09:04:55 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 82-v6sm2791977itm.2.2018.08.08.09.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 09:04:54 -0700 (PDT)
Subject: Re: [PATCH] drivers/block/drbd: remove the null check for
 kmem_cache_destroy
To:     zhong jiang <zhongjiang@huawei.com>, lars.ellenberg@linbit.com
Cc:     linux-kernel@vger.kernel.org
References: <1533741767-13055-1-git-send-email-zhongjiang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0122f2b-9ac7-947d-6cc6-bb1b8c3ba152@kernel.dk>
Date:   Wed, 8 Aug 2018 10:04:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533741767-13055-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/18 9:22 AM, zhong jiang wrote:
> kmem_cache_destroy has taken null pointer into account. So it is
> safe to drop the null check before calling the function.

Applied, thanks.

-- 
Jens Axboe

