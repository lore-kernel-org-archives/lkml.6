Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A928C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A727720894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNtvc9aA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A727720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbeHBDHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:07:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43080 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeHBDHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:07:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17-v6so269314pgv.10;
        Wed, 01 Aug 2018 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w8zUIR4fv9Mkuv+Lfm1QBDwQldHi5GacH3sH913Q3TU=;
        b=PNtvc9aA/GDNG08D7vrJB8r4aeLzVea66zDPDct+IKe/2vk/NtNzoJk4lieMFn0+mM
         9kKaAUuEhy2i8Zk0pEyRzHOX7yQf5tFt6B6GoUYbSAyO13y1DPz6s6DIMJOpkqlrZK7G
         TJOqTt4lV7KjgQdcohz0aU2a9FsOLIh7CaoSa7IhWJFO+ApnrVUBm8G49ZMD6bd3pp+E
         hD6ipfKHNORVwcouBqoSThPz/Wbtl/yqRbuL2trOE/NNuI9kY36b+JLmYztRs2kjBNXy
         1LgsGsU6zjY0lfmJcMbXOIRlIMoUjW9nriwY5WH4A4904VVcZ217hHhtatxOKslAqwr1
         FsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8zUIR4fv9Mkuv+Lfm1QBDwQldHi5GacH3sH913Q3TU=;
        b=WHw9b4eQvCZv8d4A0EV44uBvAYn360jzJhN9xpAqlUpoqg4EgHEpoG5laXs/5Fn2/2
         vUT3hJyPyocDdDhEPmSsLgGgZ8zO3a+BHKRR3t/G1G5OA6wBklBdcS8f/Nw8hSDFILyh
         ZuJEMSQxHhfNMqHC8ZHI7RsUk51pdipoW+sNXneCTbQaGtCHsqxhWtAaqVo2uPJKyvvK
         MQUP5xjm01azMvV4OlcNUIdjY8GW6ljtM0kCBCH5XhGgUDHeZV+KkIE+X68s+cJjaftk
         UrgMhXq8F0glxDsqvh9nvdYmlqg53tiLT2RXPW5EtuolBnvcVqAt1oguxSuBOg2gT7rB
         hvUQ==
X-Gm-Message-State: AOUpUlEZIm32Mc4Z1N0ALhh2WLkWIY+Nm4OK+mHFV4Y1t6VAqUH/qM0F
        10zvdXvtTiQotaSFxYwudfuOkHSH
X-Google-Smtp-Source: AAOMgpcHQo959vDcOVgAuTQa/4M3uYqz2By346SWdAKh223DxXJAaoDtRfwAmUGBF0ulViPNpuGBeQ==
X-Received: by 2002:a63:ab4c:: with SMTP id k12-v6mr629565pgp.386.1533172743012;
        Wed, 01 Aug 2018 18:19:03 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 14-v6sm460952pft.93.2018.08.01.18.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 18:19:02 -0700 (PDT)
Subject: Re: linux-next: Tree for Aug 1
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
 <1533164454.3158.3.camel@HansenPartnership.com>
 <20180802100505.56e663cb@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <83936bed-e783-191f-c308-8f8470a0dbf3@roeck-us.net>
Date:   Wed, 1 Aug 2018 18:19:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802100505.56e663cb@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 05:05 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 01 Aug 2018 16:00:54 -0700 James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>>
>> So what seems to be happening to cause this is that there's a patch
>> somewhere between the merge base of my scsi-next series and the next
>> tree and the patch just before scsi-next was actually merged that
>> actually causes a boot failure with blk-mq enabled.  Could you try to
>> find this patch?  I think the way to do it is to try to bisect this
>> range of linux-next using the command line
>>
>> scsi_mod.use_blk_mq=1
>>
>> Which forces block mq to be the default and seeing where the first boot
>> failure is (you don't need my scsi-next tree merged to do this because
>> all the offending patch does is flip the default state of the above
>> flag).
> 
> So this means using v4.8-rc1 as the first good commit and 453f1d821165
> ("Merge remote-tracking branch 'cgroup/for-next'") as the first bad
> (assuming that this latter fails to boot with "scsi_mod.use_blk_mq=1").
> 

Puzzled. Same results. 453f1d821165 works with both scsi_mod.use_blk_mq=0
and scsi_mod.use_blk_mq=1. next-20180801 works with scsi_mod.use_blk_mq=0
and fails with scsi_mod.use_blk_mq=1. Bisect still points to the same commit
(which just changes the default) as culprit. I know that doesn't make sense.
I'll need to think about it.

Guenter
