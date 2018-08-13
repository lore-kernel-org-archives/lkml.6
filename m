Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEE0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CE621763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9+OfEd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CE621763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeHMMM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:12:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45077 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeHMMM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:12:28 -0400
Received: by mail-io0-f193.google.com with SMTP id p6-v6so4942709iom.12;
        Mon, 13 Aug 2018 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IIR81WymSQhbQ9H5Y07qHf9l7A/JxPSD5fChXwbkhPg=;
        b=g9+OfEd0IyWnXV7MBYU5LhE1yhb28H6ZpPTRqdywTrQDZUrvpDik7V/BjS3Djmzk0r
         u0Ip6FSxcdKPFP6TRkqOTGCW1BlSWiqUQaguU1SIdVfFQR6M6Hu1JAC/vA8i0TjmlEi+
         al0FbXIEkOEnF5Rng2W0FFoHziQvSf2kQPipGYbBRRFTKrJuRofiaB8rApDsbO3XI8RT
         RBpa/PDd+lvhxBh5KKagqkMSFQ8r5zkGnvAd+kXUZyR9NTYOlsAwKVS1QQLwcfVlcJU3
         68QRGyEXNsW5qz69kARlwsss5aQw94H3oIR+mt7AZaDmA6lh2/epzA3p2HMaY/T626wQ
         pfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IIR81WymSQhbQ9H5Y07qHf9l7A/JxPSD5fChXwbkhPg=;
        b=pKReDUuQvZugu20myrlt2xXLZw1fTFsHikfk9hZSF4uuolfqviXVAqBORlCFfOJRAn
         feNTP+LcT8rooOXwlwPASdbUfQultRBmsB9LfKfdqq79GB1srNVgZ0z7Rj6LvYQo1KAk
         O02dmzb6pPWswM/knvdsKHDIUN0Mwg0IyRDGK4rayYwy4b3lnlQTteQAR/P6OvYfKsDQ
         ft/LYyMVCiX6V6Rjw/JIhB3o6FhWa1Qxup/o3Rsd0OyuaOjF6acUy3hmhbGn0HsQhtYK
         MErcHNu0xkdkLLOMdt3n22PVGmrLr+GhrAiq0Gj/109tICvh8uS5wDdyaHprAWvRbEyf
         Ctrw==
X-Gm-Message-State: AOUpUlEGhCbkkU9q5Wz1KB3IOogdBYIhIHhGBs/a7Y41ZoKlRM9xiBD9
        qn7gc+P+rZd1y+nFfH6KHj5eRQSF
X-Google-Smtp-Source: AA+uWPyIBp+5phoRMpDDNbBxtYpsBFIAPO/b8hGjNgSu4fYWykU+te5cpeb6pvSMl6RPGpoBImg3oQ==
X-Received: by 2002:a6b:cd08:: with SMTP id d8-v6mr14682450iog.194.1534152661680;
        Mon, 13 Aug 2018 02:31:01 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id k5-v6sm3529657ioc.68.2018.08.13.02.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 02:31:01 -0700 (PDT)
Subject: Re: [BUG] mm: truncate: a possible sleep-in-atomic-context bug in
 truncate_exceptional_pvec_entries()
To:     Jan Kara <jack@suse.cz>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        ak@linux.intel.com, mawilcox@microsoft.com,
        viro@zeniv.linux.org.uk, ross.zwisler@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <f863cf8d-615f-c622-812a-a6370efe757b@gmail.com>
 <20180813085635.GA8927@quack2.suse.cz>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <91c44d76-ff62-7cdc-3f78-e0c3acc58637@gmail.com>
Date:   Mon, 13 Aug 2018 17:30:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180813085635.GA8927@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/13 16:56, Jan Kara wrote:
> Hi,
>
> On Mon 13-08-18 11:10:23, Jia-Ju Bai wrote:
>> The kernel may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] schedule
>> fs/dax.c, 259: schedule in get_unlocked_mapping_entry
>> fs/dax.c, 450: get_unlocked_mapping_entry in __dax_invalidate_mapping_entry
>> fs/dax.c, 471: __dax_invalidate_mapping_entry in dax_delete_mapping_entry
>> mm/truncate.c, 97: dax_delete_mapping_entry in
>> truncate_exceptional_pvec_entries
>> mm/truncate.c, 82: spin_lock_irq in truncate_exceptional_pvec_entries
>>
>> I do not find a good way to fix, so I only report.
>> This is found by my static analysis tool (DSAC).
> Thanks for report but this is a false positive. Note that the lock is
> acquired only if we are not operating on DAX mapping but we can get to
> dax_delete_mapping_entry() only if we are operating on DAX mapping.

Thanks for your reply :)
My tool does not well check the path condition here...
Sorry for this false report.


Best wishes,
Jia-Ju Bai
