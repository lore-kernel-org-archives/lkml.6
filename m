Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8962C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D91C206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFKFXm9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D91C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeI2P2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:28:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44362 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeI2P2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:28:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so6090133pgu.11;
        Sat, 29 Sep 2018 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3xj7uk7bYWSxDBCior/qmqdza4Mc1TrEa5Mr5CgV9DQ=;
        b=RFKFXm9VI1+hS4OjJKwPOasFkb55OpXif7lvqk5VUVnnX5iYiU4OVcuOd3zKLKgz3x
         DTYG87++1TYgebsyJ0vI1npNI2ydf3yOYixBgtJcB85qlg1fA7c2pGcPfZd6Z/rCGuYg
         9bm8+gTZNzlA404vxAiBPCSDhZ/Ie55GmAPT24jvXacBLKDC88p8GXFZpxpibYzpgcBD
         fWPZ2UNfMreYYuehLQHNqWFR794FypzLFGy/JGM39JIIThI8TjxgFv7I66L44N46cv35
         PFNMIZ6rF57w1QeKvMP4jRMmsp0W4IkDxG1agPApt+5pEftWBe539tHBBR+A3M/HeC7c
         beZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3xj7uk7bYWSxDBCior/qmqdza4Mc1TrEa5Mr5CgV9DQ=;
        b=BAq0HcBWTmw1e19foHqhu36Ux6ICNmsBFoR9uWhP/uYlkwBJZnmS1jCZgQpWqq9a0K
         yuJx/OAgk+xtH2i4YAIKV0UsX500RPoqGn6odV7s7FrOOm0kKNPFbB36gSt1NvLtwzzR
         K2VZkt14eUa7naH5lL83TGB1T5Xv0vDYtmjW6YtNdnozvOpNNlwIQCRKlcax9OYFybUD
         Cq7Z6842xXKTQzxUmcZOIR1S5SKN7D8CuvBKFzjpWh1a1ShTpGbUmPm9lc/RqSyS5Yug
         q4iKhgotd+mJZBm98H6d9VdIpIA8kUyz+pwKmCULPGnCVqS8skdn5P+JFrL2dpO5PItb
         HS+g==
X-Gm-Message-State: ABuFfojcuK/n6R7HXDktao7ktIQfSPFJE9fFjQzzxS/ZH+fdn096+gjH
        nJxNIgyewJZSMm0jrxy/GwF3MXya
X-Google-Smtp-Source: ACcGV60xEv/0cVNHBajUBQdA46Bp/dMXvSi6vF5z/OIMfmWA1cW0uRPvCh6fhZL4l05+XIhLKeE6qw==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr2055399pgv.233.1538211656613;
        Sat, 29 Sep 2018 02:00:56 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.37? ([2402:f000:1:1501:200:5efe:a66f:4725])
        by smtp.gmail.com with ESMTPSA id n13-v6sm9017545pgr.73.2018.09.29.02.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 02:00:55 -0700 (PDT)
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180913033432.16336-1-baijiaju1990@gmail.com>
 <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <4c0096c6-3745-963c-5086-5f579792599b@gmail.com>
Date:   Sat, 29 Sep 2018 17:00:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/24 17:26, Jiri Kosina wrote:
> On Thu, 13 Sep 2018, Jia-Ju Bai wrote:
>
>> hid_alloc_report_buf() has to be called with GFP_ATOMIC in
>> __hid_request(), because there are the following callchains
>> leading to __hid_request() being an atomic context:
>>
>> picolcd_send_and_wait (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
>>
>> picolcd_reset (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
>>
>> lg4ff_play (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
>>
>> lg4ff_set_autocenter_ffex (acquire a spinlock)
>>    hid_hw_request
>>      __hid_request
>>        hid_alloc_report_buf(GFP_KERNEL)
> Hm, so it's always drivers calling out into core in atomic context. So
> either we take this, and put our bets on being able to allocate the buffer
> without sleeping,

In my opinion, I prefer this way.


Best wishes,
Jia-Ju Bai

> or actually fix the few drivers (it's just lg4ff and
> picolcd at the end of the day) not to do that, and explicitly anotate
> __hid_request() with might_sleep().
>
> Hmm?
>
> Thanks,
>

