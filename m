Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E83C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FEB24625
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nS8GuzNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FEB24625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934632AbeGCTcu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:32:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37937 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934525AbeGCTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:32:48 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so2769678iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=v0gy9JkEbz5aa+9kjApdUAOTxh13BcKr22R0HR13L94=;
        b=nS8GuzNMW9tXjgkipEqj+4PgFewhVEQ+CTB4ZReuJ9/oXtmKJm8Rsa0gXCCqS5RVQd
         aFnBBLzIEepi6BEWHqZrIxshKmE1I3pS1SyLJBxg34ZX3oP8gQW0do7b+5zfqwqDd+jD
         9DWVn9jX6N1bpPKPgm7bpM+lUsVGO6FLN16RZ/xoTZVqUzee+Uh/fUoJGf5cZDxZBdxF
         iv8bSBGnazZnmCGycH2FYwKQeVl7eg1Wiy6SJWTQWzBoka1czE+wniaKn/ZNXOLh2sRY
         g6lU/EUjQZt8b58jRK/a/pzc3hNNp9KRzdKsAGn4tigxyDs3JqOf0BimK2riOyrOrASZ
         NYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v0gy9JkEbz5aa+9kjApdUAOTxh13BcKr22R0HR13L94=;
        b=NK6tTddG+qLv0uU/ixxaCYIeIjC1bAP+rtEekUbEi63mX2GlETIfKN8wM0sOerXUxn
         M49yaiOSSMZOITjxruOByRjvJN22fs5DUlJovs05sbD0cZBBUs70iGGGWLmfsh4u1j+W
         jySSSuxDcANaMsRRPNcg+RYfvbrQfyAiqIqTMLXaQJSzKu0czDKCTTSwgP50FAj8kPH6
         OqWkjBMBQpqPPM42X1g/WRBE7AQ8Y92jIZ2smV+JdOZPVLysxpDEwAnkaDuqdKJnFDbD
         9z43nuyCRICRpD0/yM/SVvGUJyUzleJPCNXIIbX3FOdrg5kAisESjuv8Lk7mSi9fyVKE
         K6WQ==
X-Gm-Message-State: APt69E04Hl2+dk/Rdfp3nCBRMuPY3XibPITELr90HNIfWGjbNJOrWIE4
        gm7LVFS//b8heLYHFQ7Dn4SjeA==
X-Google-Smtp-Source: AAOMgpcc+i8vkGpI9MOh11OWpxqE2MWdtHdRP3Vjs+aGMJPZa4b1r+BVts2UkDt8bheQSlzDHiFNiA==
X-Received: by 2002:a6b:c085:: with SMTP id q127-v6mr1914644iof.255.1530646367916;
        Tue, 03 Jul 2018 12:32:47 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p130-v6sm849114itc.38.2018.07.03.12.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 12:32:46 -0700 (PDT)
Subject: Re: [PATCH 05/14] swap,blkcg: issue swap io with the appropriate
 context
To:     Randy Dunlap <rdunlap@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-6-josef@toxicpanda.com>
 <da01afa9-ee89-3c54-9e41-b10875ff0787@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e871d2ac-1c63-071a-a61d-df22b94fe89c@kernel.dk>
Date:   Tue, 3 Jul 2018 13:32:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <da01afa9-ee89-3c54-9e41-b10875ff0787@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/18 1:27 PM, Randy Dunlap wrote:
> On 07/03/2018 08:14 AM, Josef Bacik wrote:
>> From: Tejun Heo <tj@kernel.org>
>>
>> For backcharging we need to know who the page belongs to when swapping
>> it out.  We don't worry about things that do ->rw_page (zram etc) at the
>> moment, we're only worried about pages that actually go to a block
>> device.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> cked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Checked-by:  ?  :)
> copy-pasto

I fixed that one up.

-- 
Jens Axboe

