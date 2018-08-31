Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CB8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DAB20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOtdXgUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DAB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHaFlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:41:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41035 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaFlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:41:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so4646248plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f2GNbtlFcY1TIVzxiubqydAQ0jpxS/w1bwW/ErrCSqE=;
        b=jOtdXgUNTnL44Hd/GjjOezTI9HTdTUOvfQSnJ+cSxCf2rFiTJCMTd+26kowPq+9i9h
         YsxCc+0Ybd0rQj+X6K1eNs3R4Wf5cXlgLPrYvi3AwCh+wQhZqYZMTxKuLuGTuZoCabCl
         Jj4+lH5PK92vPlN5hT9RLCjjvOhfAEASZwErBBsz79CPX1jCs9E54RF1NLkKCPh7Zjhg
         79un43mm/DCo6dOk693dzHSbM6nKtdYg4mPjI8JJo5BvYiu7Cjw0xZ6ThvR1bohBv6h+
         v9f829OeRyePjKZIGPUuyjKJ3aZAQB2R8Y9IAES7DSCgHynbSzu51TVuaNMa23pDjpL4
         pYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f2GNbtlFcY1TIVzxiubqydAQ0jpxS/w1bwW/ErrCSqE=;
        b=XSf2CixFW4fA7KQi1T1G4srWyCKHRkvm7i7McJQjTMUCIolwaqY3iSZ/f69xHxbfoZ
         5wGuWCP+Uktb48dJINJnrswrXNCcRgX/7sMUhd1w/r+jDzi6++1WH7XJztJBefPl6JYD
         QoV7JNfvKVCZwsa3vOIpCCd375o6qloVQwWYvgScHJD8QOngMdWG2BswcZfElMW02LvO
         R2jUwIusObUgfeQK7PKUgheIbjhimZp48UO97O+RTZqWpzkcEaKaHgR7s38LMQqbrvvy
         d3HmheXKaxYv15BgT/p01nr+nwpRzBtI8PJ/o3qEsjPw8iGPqzVSSy6EDFgRajifB9du
         eHUw==
X-Gm-Message-State: APzg51Ax4xqlIOxINumNS2DqcdWjeOcK5zwKfLq7FqwItRFvciR4frFa
        uTQjG2Tceqg0haQfobzqeErlyw==
X-Google-Smtp-Source: ANB0Vdb0AwXXCgMKwWfA20UuzpSsHFA3VVWztUeUMbqFyopbHAfzu62awpBKDeF332T0v3jHpr7qFw==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr12968669pls.204.1535679379941;
        Thu, 30 Aug 2018 18:36:19 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id 5-v6sm11763860pgc.86.2018.08.30.18.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:36:19 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: check for kref overflow
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20180830230946.228701-1-drosen@google.com>
 <20180831004144.GC20664@kroah.com>
From:   Daniel Rosenberg <drosen@google.com>
Message-ID: <589c036d-450a-3f3b-8f5a-4148713d4bfb@google.com>
Date:   Thu, 30 Aug 2018 18:36:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180831004144.GC20664@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 05:41 PM, Greg Kroah-Hartman wrote:
> On Thu, Aug 30, 2018 at 04:09:46PM -0700, Daniel Rosenberg wrote:
>> This patch is against 4.9. It does not apply to master due to a large
>> rework of ion in 4.12 which removed the affected functions altogther.
>> 4c23cbff073f3b9b ("staging: android: ion: Remove import interface")
>>
>> Userspace can cause the kref to handles to increment
>> arbitrarily high. Ensure it does not overflow.
>>
>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> I signed off on this?  Where?  When?  Are you sure?
>
> greg k-h
The sign off was on the 4.4.y version that I cherry-picked this from. 
There was a trivial conflict moving it to 4.9, but it did not modify any 
changed lines, so I hadn't thought that was worth noting on the patch. I 
apologise if leaving the signed-off-by was incorrect here.

-Daniel
