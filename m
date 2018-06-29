Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF8C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1F215FB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asDyhqn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF1F215FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755118AbeF2Awa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:52:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37489 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753663AbeF2Aw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:52:28 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so596718itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIyVs41jfppXAoRVFzsOGK/t/A013DuefWd4HcLkE9M=;
        b=asDyhqn49ZiXUiHLAlix0RaNiylVlsYyN9oBzvjOGS01QO0ct7XVuYgg6r4dzrBVi0
         GZr+qnKRm9Nmjmexf8eWw9DEzZJkpleHHtTIii9mr5G9NoQNKHth4T/+cb++vhL6nWAM
         cAT0wJI/smnVkJkSg30Berk3h+Jd4p6tVe9B9jvjz4bDJfPJF3iNF3Yifm0wQKf6s50j
         6KBNN9dpcbQCB6ZAh7aUvTP0xgSDTKo+a8kqLULkbsqLMiADZS2+tC1/Y3vfE58z68GY
         QN/DLTZLqzSeqWn7Zd91FsX/s3LqizkiHHJfPh+wzxinoMIw/loXNkIF5lteBLnpVylc
         5x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIyVs41jfppXAoRVFzsOGK/t/A013DuefWd4HcLkE9M=;
        b=FExddZTU4z0La0i5D531dz6xIdI4Mx9JtsnBpEekUFPY2agoIAslxWDo18HqI5n16T
         fMOO5krdy4cb2g+aptCV4K+Cuurr0+4UclxrXmzAXheJI/jNBk6sR24tDCcsoF8v5sCJ
         3cud/vd3LcUZulu/rT3lEtBBQGmI3mnevyNfpKIMrK2yyM2l4bNgmkAbSoXuTN6tx3Tz
         UVCVZvsI8afI1ST8YtcVQ/hTTpsjJr7X2AlYlCHH9TxrMM8oWo+iW69ECkZ32QaNV7Yv
         bp7q2SDRlz0Bww69HNsdhA9bauSpseIl/tw8j3LS65A7QfZa0PScgiW5DsiVMnebgxT3
         cjfA==
X-Gm-Message-State: APt69E2xxHIIz+V1CgAx1UM241DuGLCh8twq/d0pet7qa9T+MVlRy5ma
        iwag4PrcpBDFpsk3hEnorFi9ZBve
X-Google-Smtp-Source: AAOMgpe4JS3jQmnyXS7keue54zGaK9WCyQsbNExK/e6C+HhHE7bBMbGlw3LRVGcPhn2jHbd2Ea5Xqg==
X-Received: by 2002:a02:5f92:: with SMTP id x18-v6mr10262822jad.22.1530233548062;
        Thu, 28 Jun 2018 17:52:28 -0700 (PDT)
Received: from [192.168.1.196] (c-69-180-151-171.hsd1.mn.comcast.net. [69.180.151.171])
        by smtp.gmail.com with ESMTPSA id a77-v6sm98299itd.4.2018.06.28.17.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 17:52:26 -0700 (PDT)
Subject: Re: Memory zeroed when made available to user process
To:     Richard Weinberger <richard@sigma-star.at>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <71d13d76-4591-9206-ebbb-5e9599f10c7c@gmail.com>
 <CAFLxGvyJsjWum34Q67UP+EGkg9+W0nPsMpu8mS9PaH8wL3Rd9g@mail.gmail.com>
 <20180627131248.GA3032@dhcp22.suse.cz> <2634793.Cb5OrAPIO5@blindfold>
From:   Jefferson Carpenter <jeffersoncarpenter2@gmail.com>
Message-ID: <c1cda925-72bd-5937-a73d-617fd6f50c8e@gmail.com>
Date:   Fri, 29 Jun 2018 00:52:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2634793.Cb5OrAPIO5@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2018 1:18 PM, Richard Weinberger wrote:
> Am Mittwoch, 27. Juni 2018, 15:12:48 CEST schrieb Michal Hocko:
>> On Wed 27-06-18 13:29:05, Richard Weinberger wrote:
>>> On Wed, Jun 27, 2018 at 11:34 AM, Jefferson Carpenter
>>> <jeffersoncarpenter2@gmail.com> wrote:
>>>> Is there a way for a user process to mark memory as 'sensitive' or
>>>> 'non-sensitive' when it is allocated?  That could allow it not to have to be
>>>> zeroed before being allocated to another process.
>>>
>>> Isn't this what we have Meltdown and Spectre for? ;-)
>>>
>>> No, memory from the kernel is always zeroed.
>>> libc offers malloc() and calloc() for this purpose.

Interesting.  Let's say

Process 1:
free(use_memory(malloc(1024)));

Then Process 2:
malloc(1024);

The physical RAM used to service Process 2's malloc call has to be 
zeroed to prevent it from leaking data from Process 1.  However, if 
Process 1 could mark that memory as non-sensitive, then it would not 
have to be zeroed, saving the time it takes to do that.  However, this 
would require at least a bit per memory page, so maybe it's not worth it.

>>
>> Well, except for the weird MAP_UNINITIALIZED. Anyway agreed that this is
>> a bad idea and the flag should have never been merged. I've just
>> mentioned it for completness.
> 
> Oh, I forgot about the crazy nommu world. :-)
> 
> Thanks,
> //richard
> 
