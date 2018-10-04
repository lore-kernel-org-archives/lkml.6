Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D0AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0766E2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD+7Ms7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0766E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDKGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:06:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44382 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeJDKGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:06:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so2446825pgu.11;
        Wed, 03 Oct 2018 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ot+SY8vO4yMITcD1BSzHRJIs5K5VhRWdb/JZjmg3njo=;
        b=pD+7Ms7dBzM8aX01qbzg4xjSB8GrwdSv/FFxgjfQJ2rEPPVPpx76wu8J7BmaD8GK9d
         Hic66c+dut2MQzcoKRAitmrLjlrNogdpcu7cci09s6/WzUGGxckwjZCl49q2D/Sp3lDL
         oXZaXbpuFuD3Ok5UtEFe5h9/pzdYevwOp3npVRPPkIOh7oYE0sFk+BtqxO/SKETgQBn+
         a8C2e+ZtHfcnbQp+x0BIn3ziDULexxRBHU8d+ysRMx1WPAJk62AHX+CtYUO21rKca3k0
         5Uo//HRZjnxmgw71YYsyQTWYBTSQyQX6kZBsiTBQBqCLKANUKklDn21mEPklQphuQBi4
         D2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ot+SY8vO4yMITcD1BSzHRJIs5K5VhRWdb/JZjmg3njo=;
        b=TEqTt+5T/bgWXY/sfme5a1YK1FWrUSH47SjGjT4ToD/hbCJWZo9cTLzeep/+xQ+Ai+
         DuWlUz4Q/LcXC7SgnWBjc+AgFVFQ+lCqgWi4rrOaU39RDf36diCRxlVzR//e9TBwccbs
         pkemIGL5cMRUQm3L5LKLB6CSnDnx4+8mZeHhgnHbxAdBbp9Ei85E2BJZXJQIA/WCkAER
         94TzuL+1B5vVNaMKbwtxK1pu09DAIsQjm8wwtjYqcF6NT3HEHH7ysE3SvoAhx/b1wBSl
         pJuRqcFcRbwMr0cMS6hU3sQsg+Nih8MDAoCkQATVqGCFJz2k35M7VWrm+wKOutsCnCU5
         xLPQ==
X-Gm-Message-State: ABuFfogn2ANdrjzhOYgC37vDmOQgGDDirjT6RlTS50UqyQZj66gUPE5a
        9Lo5n+xgVPii41qnCHXin5xUVqJW
X-Google-Smtp-Source: ACcGV6230pwzQHEf5w35wxaryu0UGUTpu/qAXLExV+hEONvjaol/qCsLv318uK3DxzvXFGf2EJ0RUg==
X-Received: by 2002:a63:e00d:: with SMTP id e13-v6mr3852051pgh.114.1538622897081;
        Wed, 03 Oct 2018 20:14:57 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.3? ([2402:f000:1:1501:200:5efe:a66f:4703])
        by smtp.gmail.com with ESMTPSA id z63-v6sm6005978pfz.31.2018.10.03.20.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 20:14:56 -0700 (PDT)
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180913033432.16336-1-baijiaju1990@gmail.com>
 <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm>
 <4c0096c6-3745-963c-5086-5f579792599b@gmail.com>
 <nycvar.YFH.7.76.1809292118240.15880@cbobk.fhfr.pm>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <6bea4185-3325-b04d-56ed-2fdf4c74d8ae@gmail.com>
Date:   Thu, 4 Oct 2018 11:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1809292118240.15880@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/30 3:20, Jiri Kosina wrote:
> On Sat, 29 Sep 2018, Jia-Ju Bai wrote:
>
>>>> picolcd_send_and_wait (acquire a spinlock)
>>>>     hid_hw_request
>>>>       __hid_request
>>>>         hid_alloc_report_buf(GFP_KERNEL)
>>>>
>>>> picolcd_reset (acquire a spinlock)
>>>>     hid_hw_request
>>>>       __hid_request
>>>>         hid_alloc_report_buf(GFP_KERNEL)
>>>>
>>>> lg4ff_play (acquire a spinlock)
>>>>     hid_hw_request
>>>>       __hid_request
>>>>         hid_alloc_report_buf(GFP_KERNEL)
>>>>
>>>> lg4ff_set_autocenter_ffex (acquire a spinlock)
>>>>     hid_hw_request
>>>>       __hid_request
>>>>         hid_alloc_report_buf(GFP_KERNEL)
>>> Hm, so it's always drivers calling out into core in atomic context. So
>>> either we take this, and put our bets on being able to allocate the buffer
>>> without sleeping,
>> In my opinion, I prefer this way.
> Why? Forcing all the report buffer to be limited to be non-sleeping
> allocations just because of two drivers, looks like an overkill, and
> actually calls for more issues (as GFP_ATOMIC is of course in principle
> less likely to succeed).
>

Okay, I thought that using GFP_ATOMIC is the simplest way to fix these bugs.
But I check the Linux kernel code again, and find that hid_hw_request() 
are called at many places.
So changing this function may affect many drivers.
I agree to only change the two drivers, and explicitly anotate 
__hid_request() with might_sleep().


Best wishes,
Jia-Ju Bai
