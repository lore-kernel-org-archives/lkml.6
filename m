Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A3CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37B920657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vOyqO3Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37B920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeKBIGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:06:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35399 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeKBIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:06:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so67812pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PUTUmuA4BAAHF0QIxrg9myki0Ae0g45BmwJh4otzHA0=;
        b=vOyqO3FbBRXH/w9LKQMSyqE59hQ+kwOTdVejlhHC3JVw6Ikc+p9Uez/rh1kapEQl0+
         lS9+xUwMH0e9M6E2NxqV1ClqWrO5Fw0HMmisSPTToRPtaDq7KocG34FM1Gz+/2zndW9T
         28niaNnRPfVZJn/6z8MC/hmZkwzPv9rB/FRDYOn0oShEwssM7pG9UcYZJ5CRx3y2RRkw
         wCSaIwA7h4qc4l8a+XoRmffbn9cynfOOQX4HrPW/JMVrIJjqVLqIHViEu8vijJNJM9Ph
         4xXYMV4+cPg78Pv0hX2VOoK1iPo41qiZl8SlHXIcO2kuuZXsnyEaDdI8UOSqNFVluHjf
         r9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PUTUmuA4BAAHF0QIxrg9myki0Ae0g45BmwJh4otzHA0=;
        b=GFXV1QX2jfbpJtyYzcdZWGxQzRBH2NULrUjbdtnQRLfIPRTS1hNcksLDDT3o3+SOBA
         JYOKLH2rQq1gjXjcc6uQyuKlGxP7u0BHQUpHlPfZUl1TQsY9IyJMzxjsm9/pRTipicM9
         k5mxZTtMK3v9t2T8pF2YBofxSS/ceaDEt8YCqllqhvFZhCwRsNgO4pVXGWANWGfpMi9T
         riemXcRkGGVKQ61d6BPoBV0VyqH3jMhXLBbQqR+9ahM7DQfeG4oeiKdBZmZJcrVvkwFE
         PUMaWjVCjEpTjvimK0/FiyC+cvIKyqzFl2VKVY8kovB0jiZhQ+WW0AkwUq51bxB5FSv1
         EB6A==
X-Gm-Message-State: AGRZ1gLO4nAgSZ8Njtrd9YCf/Cu0odxJg1Phd7/KdbKV5Rz2Gr6XLzAQ
        VUIEqtLK1vbbfEUFnNJ5tQCispDprro=
X-Google-Smtp-Source: AJdET5evOU3AJfZHaU0fCaBcnVw7Jkz2gk2pskHlnfFn3FlLuhQpUyvVVT4Zh6hrfNVmxJYi27aYUA==
X-Received: by 2002:a62:b09:: with SMTP id t9-v6mr9592159pfi.36.1541113305949;
        Thu, 01 Nov 2018 16:01:45 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v20-v6sm52479689pfj.107.2018.11.01.16.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 16:01:44 -0700 (PDT)
Subject: Re: [PATCH] blkcg: revert blkcg cleanups series
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181101212410.47569-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd8428ce-21d0-c817-3187-fb9a43feb389@kernel.dk>
Date:   Thu, 1 Nov 2018 17:01:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101212410.47569-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 3:24 PM, Dennis Zhou wrote:
> This reverts a series committed earlier due to null pointer exception
> bug report in [1]. It seems there are edge case interactions that I did
> not consider and will need some time to understand what causes the
> adverse interactions.
> 
> The original series can be found in [2] with a follow up series in [3].
> 
> [1] https://www.spinics.net/lists/cgroups/msg20719.html
> [2] https://lore.kernel.org/lkml/20180911184137.35897-1-dennisszhou@gmail.com/
> [3] https://lore.kernel.org/lkml/20181020185612.51587-1-dennis@kernel.org/
> 
> This reverts the following commits:
> d459d853c2ed, b2c3fa546705, 101246ec02b5, b3b9f24f5fcc, e2b0989954ae,
> f0fcb3ec89f3, c839e7a03f92, bdc2491708c4, 74b7c02a9bc1, 5bf9a1f3b4ef,
> a7b39b4e961c, 07b05bcc3213, 49f4c2dc2b50, 27e6fa996c53

Thanks Dennis, I think this is the best way forward. Then you can
work on getting the stacked setups working correctly for 4.21.

-- 
Jens Axboe

