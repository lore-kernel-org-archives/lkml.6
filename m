Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F97BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D763F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MscIAcNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D763F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeI2DAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:00:46 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51303 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeI2DAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:00:45 -0400
Received: by mail-wm1-f45.google.com with SMTP id y25-v6so3406975wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YUd/Tzcz6xeSMrE2mzymdgZesnLIDZ1c+ORuzac3xyg=;
        b=MscIAcNWmo6GN4auIhdyELv6Mw0k5mWJcVbN4CVTyJoVF144796nW0hUJkbbFY7ZMc
         /lnnPbYJYcS+vqEn06Jl3bv793rkJNGrQ8Kw3RmjFtkCCE9g/XPamKu8TIzcRPU8oAgO
         TEj6ws/Xewh5Qv3Fm3QBREKySoKFa+VaGGVM39h4WraPqh5hcR3qWuv/dT4cox7ltmZ2
         2PmxqxbqmqS6lIa5W7/yVHb65iNyPSAsbXSF3E+IX2TC2gv+UvdCtcERBmCs753ul1vt
         BE5z4ZBlppOA2oXApByfLbfav0rc0aoH2UKRLIRCecVqA0pZ/o226EpIOUv6yIZR8SCX
         oU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUd/Tzcz6xeSMrE2mzymdgZesnLIDZ1c+ORuzac3xyg=;
        b=pdCrBpTPdn9UL5qmu+2v7JI0pBxWLH1Ch8zICYKUXIJuaNjDpKlT1Jn8YVq3OMTQH/
         J3zjDIyBy5XKeFj8WOB/u1Yur/YAYvXTc1mkXf3BiQlUKOMgXoQKampqUr4neKO+0Zi4
         +SXsmvdqq8wZOiMhmH1mZdAhgqNphwNMmwniu05HOfvd+oEYFP96/DuzMFhkOQarwsnn
         FrMNx45DVNFLVdtRSWZnzGdinHVLU+OC3BOcYrUGYLh5EAelb2KlRRcW7MgJuRze2NGj
         0xzMB1E8h/o5BQWtsJ2WbkOYumVJwmhu1M2ql3kwaXlBVmP6aOZ3kmmgf9OnBXTxdY4M
         L3kg==
X-Gm-Message-State: ABuFfojJOkzjPTLsslzGrVTgX9Nrt8OKn+zOW8vT/YONlU7lGYCxy8N7
        DHVJz5W7zeHDkhAfhZRRQ2xk3AVlgDg=
X-Google-Smtp-Source: ACcGV602jRLxi+ZMrNZ48hilNR5YyC0PPCGMGdkKcFygfC0etRRG2AwqjqIq4J1ey6W+FLSr0PtBlA==
X-Received: by 2002:a1c:280a:: with SMTP id o10-v6mr3011259wmo.33.1538166919097;
        Fri, 28 Sep 2018 13:35:19 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc0:ba00:446a:b1f:7ba8:3398? (p200300EA8BC0BA00446A0B1F7BA83398.dip0.t-ipconnect.de. [2003:ea:8bc0:ba00:446a:b1f:7ba8:3398])
        by smtp.googlemail.com with ESMTPSA id z12-v6sm2447069wmf.23.2018.09.28.13.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:35:18 -0700 (PDT)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <5fe79368-2afb-8f94-094c-9604b61a3c6f@gmail.com>
Date:   Fri, 28 Sep 2018 22:35:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928131855.GB8795@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.2018 15:18, Frederic Weisbecker wrote:
> On Thu, Sep 27, 2018 at 06:05:46PM +0200, Thomas Gleixner wrote:
>> On Tue, 28 Aug 2018, Frederic Weisbecker wrote:
>>> On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
>>>> I tested it and Frederic is right, it doesn't help. Can it be somehow related to
>>>> the cpu being brought down during suspend? Because I get the warning only during
>>>> suspend when the cpu is inactive already (but still online).
>>>
>>> It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.
>>>
>>> Does this script eventually trigger it after some time?
>>
>> Any update to this?
> 
> Heiner? Can you please test the script I sent to you?
> 
> Thanks.
> 
Sorry, this wasn't on my radar any longer. Next week I'm on
travel, I can do it the week after.

Heiner
