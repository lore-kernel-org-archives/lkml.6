Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9AEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACF9208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CV0q0c+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACF9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbeHAQ70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:59:26 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35041 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbeHAQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:59:26 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so16376457iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HQMZMofm3hqnJL4ZEZex/S4NjfN6A8POx42vmJuZXt8=;
        b=CV0q0c+HdAssgboqB1Dz/kbOUAQjbmH+k7WDKtPCdj8+2lSY0sgAHdCOc9iNbQbDi8
         HE000v0A6sY3OAF1cWySOwBSaTZ9784Xwa/oPVQsVgHOXABeWk1jsAEHGSUMpoBeL4+o
         HkwMYdzH4XJvEpIcckoS3sewuHQJERJfxd8fq0Ni7hV/GAmh+mHiY/+IAnhCT+q808eS
         lTUwqmRxXhAY6hGdW6lYhE0MJSQevDFoTbn/vJVNajzCI3pZV+PqsIVzTqDVihva4tMG
         fF6poYVEI3LKw/RG5Q//v6823w/MVzBXTMXh74iX5QjOrP5KAJVNjdD4P0KcVXoBvXbR
         cnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HQMZMofm3hqnJL4ZEZex/S4NjfN6A8POx42vmJuZXt8=;
        b=NzptEUXH7FTKZDw2PJNZ9tx7JlG9SSn+UJ0EIN3WcuBHS8iEWy9w8PVZ1Q1Ow24RL3
         EDBTNY8r449CYi6uaQemhtlI+BS5pv0Q4nA4waEC4PGjVwwG9L2z5F+/TwuRZe+2+fGE
         GZYYCwmWSHtX/183lw0F2E3R8MTdgbcVazcvoCUMAVjeVhBbZBZmIakc/1SeBU09AGhB
         CCpErbsrluQrtR8Co5gNsZaHXF986PjUzBXW6kP4tWxNHfLht1secKT6+tULS70wZxhM
         7Se4uRsS/J1fPplS5ocefx+svoZ3Qa2fm/E4NT4jDpvvN9EeElsBLukf3McKhe3sz4Vb
         Vqlg==
X-Gm-Message-State: AOUpUlF0ZwfXAAeCXg3PHE8rQ9OhlJYbJKDiHinx3bMd8WdgKP2drSTm
        V3B24umTZV2/CX/ivrkjgEHBRwz/RoQ=
X-Google-Smtp-Source: AAOMgpfAS541Q3aSx6fJukj9TQ2m9MKQ4f1Q97CqOjs4YqYet8Pm1EU9p3HwON6vJ1uXK3XFMMap1Q==
X-Received: by 2002:a6b:a28b:: with SMTP id l133-v6mr3935800ioe.23.1533136395832;
        Wed, 01 Aug 2018 08:13:15 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id p70-v6sm3268315itb.3.2018.08.01.08.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:13:14 -0700 (PDT)
Subject: Re: [PATCH] block/bsg-lib: use PTR_ERR_OR_ZERO to simplify the flow
 path
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf7c3f7d-f47d-d077-4c84-ecb4083fe6cf@kernel.dk>
Date:   Wed, 1 Aug 2018 09:13:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/18 10:13 AM, zhong jiang wrote:
> Simplify the code by using the PTR_ERR_OR_ZERO, instead of the
> open code. It is better.

Applied, thanks.

-- 
Jens Axboe

