Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C06DC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE6A20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oaMBpIOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE6A20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJZW6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:58:38 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34163 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:58:38 -0400
Received: by mail-it1-f194.google.com with SMTP id e81-v6so4709647itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j1TvbJnptUDqMo9gDt7Ey7HHVnSuK3Q1eC9ovbm5gGI=;
        b=oaMBpIOmd6AdwBbp+I+iYZalscMdD3YugqGwPoErtTAZq0H9c9sk7jnkcgdVS4vFBN
         JZGA2X1bpQ3omFYnMIquTz2XMGtdURiF6TNFls47AWcM9myKT8ULHBuIPM+V7fV1D+mx
         UU4Jwzjzd0v1MVAwVb018AbFoyp/M2w09fZJWXz3haz0A0LW9xZCGWN9zjuDU60Ejqlj
         c2Gx2WC0KCLq9rzDo6w8dKneqIQ119eDeiiVN/3tZJDM6LiixSKulKS9vXkrtbOA/Jou
         vIO+b0LnBX0PKzoY8vQ/Rz7KxjVfCyFbIK0m2CD6oFr9gHYmj4o2BncEVb4BUwkjVxi9
         kdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1TvbJnptUDqMo9gDt7Ey7HHVnSuK3Q1eC9ovbm5gGI=;
        b=aemHJWl7OWEJ/FWad6x9Z1TBz6vFADSNt81gkvz5/9vWawdpvTdGvseyCCDkMaUz2+
         zCpQMCK7FAZUZZx/gErb4UwtDpSnS9TBUYY3h3CiX640m30iysD056mbMeejB6JsKen7
         EQATVbG9le5QMge2aC68zAJiOLxLbe+NtUOyqgGyeSjWJO8ORvV5Cqx+twGok4XD2i82
         cdIdxEiEZNuQW5PJH/Yyb79yazmpKegzSNV52ndxCHdWcaWWuxFkKzSjYCqM1UJ9Xu5D
         2Xy7ZEl/w4dAMcy3YBxUArAgaDEuz9VUpXTSSxEYw72Q5Y73hESBIbrYM/MQA8RbjPS5
         PcQg==
X-Gm-Message-State: AGRZ1gKepxJCXY6yQkShg/PScW2sJG1syxW/2mgRbd3/zIO+NPphCiVH
        GZ/x6BlnuByxjqvGiiNlp9A/Jw==
X-Google-Smtp-Source: AJdET5crIPuvfzizga3m5teH0s0mpG03CL+GzE3bXeQmCzpMmb4+Yw6aXrv1sPuIXRi/bGXpWL75Aw==
X-Received: by 2002:a24:3383:: with SMTP id k125-v6mr4018192itk.14.1540563682440;
        Fri, 26 Oct 2018 07:21:22 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s15-v6sm1776393ioe.70.2018.10.26.07.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:21:21 -0700 (PDT)
Subject: Re: [PATCH v3] libata: Apply NOLPM quirk for SAMSUNG
 MZ7TD256HAFV-000L9
To:     Diego Viola <diego.viola@gmail.com>, hdegoede@redhat.com
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20181026134516.1234-1-diego.viola@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d9dd60b-7bfe-bc1c-b971-0935a84dcf45@kernel.dk>
Date:   Fri, 26 Oct 2018 08:21:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026134516.1234-1-diego.viola@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 7:45 AM, Diego Viola wrote:
> med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> 
> Switching the LPM to max_performance fixes this issue.

Applied, thanks.

-- 
Jens Axboe

