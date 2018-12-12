Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD340C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933D42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933D42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeLLGq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:46:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLGq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:46:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so7856397pgp.13;
        Tue, 11 Dec 2018 22:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TD/VgaPEPIcpXAlHjKXyndOsvZUOxXJvfEiXyKWTLsM=;
        b=IotraGm+3yk2bctTepagvmXK4MXiduE1sW2LfQZJt3GCT3hmpOnCAkK+x4zPVoFTgQ
         IJlUFyBWvAcFcdXmyrndwpwvqMDvmtVH71zaraQpHY7wPXY6QbU3UY+HLvYVWg6q4aXC
         W08Or6qFbRCJoCEt7KkNZ2DDsN2WW1r864sYhrFdsDPeun0iqGUEXyW5jwudszO/C9HY
         pLcqdVrz1Ru4Xvc1D7t7noNjnwkCX+UIAZl5QQnZvFJcco/9xChwkFOBzPIePhrW+zX6
         3Gu2N/0TCyzM787aiPOzron0+qh8DP0oh28Iy0YVH1jHg4Th8/Kmd8T3BJYbwkFY+Yod
         087g==
X-Gm-Message-State: AA+aEWYOhRWooEjP4BRIIKXHR/7PbkEKJZKUPoM6YsdP8xvwPQxxl6V4
        7PSNVcgpvwzVoMvcLRt27zlCo6fY
X-Google-Smtp-Source: AFSGD/W7UUiLa984qDVSTw8/pwXp0YTgpvVw92XC37bL8gEUfD5Nn74mJfV40mXVWEmefyc1iUfNgQ==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr16868564pgf.402.1544597215486;
        Tue, 11 Dec 2018 22:46:55 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id m85sm25167375pfj.171.2018.12.11.22.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 22:46:54 -0800 (PST)
Subject: Re: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
To:     Ashish Mhetre <amhetre@nvidia.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, axboe@kernel.dk, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-crypto@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com, mmaddireddy@nvidia.com
Cc:     linux-tegra@vger.kernel.org, Snikam@nvidia.com
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <39a4f02c-d054-2651-2381-a8d86cdf3c13@grimberg.me>
Date:   Tue, 11 Dec 2018 22:46:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   struct nvme_sgl_desc {
>   	__le64	addr;
> -	__le32	length;
> +	__le64	length;
>   	__u8	rsvd[3];
>   	__u8	type;
>   };

in what world changing a wire protocol for this make sense?

please get rid of this hunk, NVMe will never cross the 32 bit sg element 
size.
