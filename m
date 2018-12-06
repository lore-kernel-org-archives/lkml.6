Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC66BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A179920661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="iwN8Lm/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A179920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLFQYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:24:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36680 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:24:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so1271237edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TvzzSnEtxTz0N6W2I45ZFgRuzIMKqGGWKQ8IDFuvJk4=;
        b=iwN8Lm/grLxeF4hBWuiXrxRUHTsoizvlUBmu5btveHxETYtu+HbbWFB7NpAgpG4dYC
         V2bx4bWg1gKqo14ETuqCwpJWy0USwHznIYjxnP3vIX4GbaF4+gT5SDIelbitpzZZGDl3
         hJUF/6JZexWXatOW6eeLP/Ntidf0SiXA2zuzpeHl1613h1BPZPn+0u85SyyykwfLwJsG
         lita/GkcjSFkAC3QN7Zegf1kRB1CLc3ThVTOBNyeWLKT/kH6/Gyv11eAqzdjD9fsQcbz
         LiZJzlh1OoPQE87jOvs7njzkHl75Vs+yTpoe9jrlp8LARI8tFBzi9SVbk+84RN7pVVyL
         uOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvzzSnEtxTz0N6W2I45ZFgRuzIMKqGGWKQ8IDFuvJk4=;
        b=FIwb7BPRvC+VLax4GnwtcMzeCKx87C+k+/Qt3DfGzcMtRFgAo/KudD8nUZq4FJtzu+
         OrIUWeiAj2ttxAAy2DM6WRO0xVzqXI8hFBV2sBEJiLtuqdnnAOrqActPYL2zuuS4z3Rb
         BCIO8CQtutw61nBz7lswRfVb7QhidqCH7nibLeosbn/gZL5dxqmQv7AmTY/JAqBKtl6A
         Th/C0DoUGL6vxCNRtlmUCl2byiWi4YCtXj1HT59CTjAxtR3XlqT4LeviAk54hjs0Bo9/
         4U3uhAuLWBpSZcskYJuWjkaojb76s0BACntFXjgabT/VcSEHcoH033edfK3Ybo61fgAn
         fD8g==
X-Gm-Message-State: AA+aEWajnyv7CbCjGkaDEAIfx0z4uZneJIv+AbDxeRMtV5Pi+Kem8otV
        spp0HogL+x/+Ia0n4zhE/WjogQ==
X-Google-Smtp-Source: AFSGD/U65PnoB7oVaTou8rZB0wZ8jltsCQcFGvpTyh5YYaHPjcPbOPAzQS0kEqc1IDZZP/pYcF3XFQ==
X-Received: by 2002:a50:a9e5:: with SMTP id n92mr24841275edc.63.1544113463086;
        Thu, 06 Dec 2018 08:24:23 -0800 (PST)
Received: from [192.168.192.38] ([80.111.179.123])
        by smtp.gmail.com with ESMTPSA id w10sm281145eda.77.2018.12.06.08.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:24:22 -0800 (PST)
Subject: Re: [PATCH 2/2] staging: greybus: Added space between string
 concatenated
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sicilia Cristian <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
 <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
 <20181205210034.GA24054@peano>
 <e7902148-4f80-2d9c-7f51-d6bd21bf9eff@nexus-software.ie>
 <20181206150516.GA1774@kroah.com>
 <131a4c41-2c5f-a660-5190-52ce5d59e532@nexus-software.ie>
 <20181206162340.GA12032@kroah.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <6c01fbe2-3263-c923-f246-2feaad7f20f3@nexus-software.ie>
Date:   Thu, 6 Dec 2018 16:24:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181206162340.GA12032@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 16:23, Greg Kroah-Hartman wrote:
> On Thu, Dec 06, 2018 at 04:14:53PM +0000, Bryan O'Donoghue wrote:
>> On 06/12/2018 15:05, Greg Kroah-Hartman wrote:
>>> On Thu, Dec 06, 2018 at 09:43:46AM +0000, Bryan O'Donoghue wrote:
>>>> On 05/12/2018 21:00, Sicilia Cristian wrote:
>>>>> It doesn't change the result string
>>>>
>>>> So why do it then ?
>>>
>>> Because it is easier to read this way and odds are checkpatch is
>>> happier.
>>
>> Fine.
>>
>> Sicilia could you please amend your commit.
>>
>> 'This patch fixes the checkpatch error "CHECK: Concatenated strings should
>> use spaces between elements"'
>>
>> and then feel free to add my
>>
>> Acked-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> 
> It's already in my tree, no need to ammend it, sorry :)
> 
> greg k-h
> 

thanks greg !
