Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC07C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A1120823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAUi4Nz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A1120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeJ3Qrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:47:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37213 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeJ3Qrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:47:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so10290986wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WmyCKMv07XMDvUOnOjyH62nnn/qafLYfJ5ZNEqaVqoQ=;
        b=iAUi4Nz9S3pjXM6yK8JWzgw5DiUzJ54geSSQZUAw8ms+j1XV5ACSAkPmF/FN9A9T6+
         oVax5OaUnMWKdKDScx+feR4hBlZZjBVhvjkMazfqNfQnxt+SWgYP898BKEbpDIBzL9UB
         +OGnD3CDpydmi16kH64GuEQGpWnEumAa6ednw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WmyCKMv07XMDvUOnOjyH62nnn/qafLYfJ5ZNEqaVqoQ=;
        b=irncm0kphe+7WmS7wamvAmuUmxalZCq3IIl0dReaV5Sno9rfTErCBj1yzegYLr5dX6
         2+vxDLgnqQZEQwCcWigMpPZjLw84Q/A74RKdh9VmgHklxxTky1vZAyD1sTJVOz/fOt32
         lR4ge4idux6WkzsS8h275PXU2I+JlF39URMKvBkTOvNRCNOyqp6FKkDOkeQjO1/OU5aD
         zp9Vqs318gxlniwwdw1HccvXYhX++VgIf7tktWGCCc137OWW1FZBPfdsjotLCxGS+uv5
         S84BmK75DO+Sdy3R6Ii4R6UlB/Q49DW+2qcyx83Iz2yteu88u5wHfYUA9Hxb/LjWnoec
         eJzg==
X-Gm-Message-State: AGRZ1gJr7ApvNFd/IVYT2ZvXYf20+Bo2euVYgR6wc/K5wVJt6MTfgpS6
        GULP6d3I+oZR30jYQj8kM+fTjw==
X-Google-Smtp-Source: AJdET5dpyGMFfRgwb49TDAGbnG1rc8izS6wDnhopduqbWaQtgIx2Q+0ktr8xOdtQTaTLALsfKCu1/g==
X-Received: by 2002:a1c:870c:: with SMTP id j12-v6mr838368wmd.40.1540886122410;
        Tue, 30 Oct 2018 00:55:22 -0700 (PDT)
Received: from [192.168.0.40] (137.55.88.92.rev.sfr.net. [92.88.55.137])
        by smtp.googlemail.com with ESMTPSA id b5-v6sm2511727wrf.15.2018.10.30.00.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 00:55:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] base/drivers/arch_topology: Remove useless check
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <CAOh2x==y+7jEdC-3xpvhr6j+RTtXRwTnBFC2uRVUmuktbCvsKw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d689e382-e4f2-0b03-03a5-2ff4a6bb88bb@linaro.org>
Date:   Tue, 30 Oct 2018 08:55:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOh2x==y+7jEdC-3xpvhr6j+RTtXRwTnBFC2uRVUmuktbCvsKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 06:50, Viresh Kumar wrote:
> On Mon, Oct 29, 2018 at 9:56 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
> Would have been better if I was cc'd on all the patches since I was
> looking at this
> stuff actively this week :)

ah, yes. Sorry for that.


>> The function 'register_cpufreq_notifier' registers the
>> init_cpu_capacity_notifier() only if raw_capacity is not NULL.
>>
>> Hence init_cpu_capacity_notifier() can not be called with raw_capacity
>> set to NULL, it is pointless to check it.
> 
> It isn't entirely pointless though.
> 
> It is possible for init_cpu_capacity_notifier() to get called after
> free_raw_capacity()
> is called from it as the notifier unregistration happens from a workqueue.

The workqueue is called from init_cpu_capacity_callback(). This one is
called in the notifier callback. IOW the notification callback
unregisters itself. But if it is not registered, it won't unregister,
hence it won't call the workqueue and init_cpu_capacity_notifier() is
not called.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

