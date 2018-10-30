Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9742EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF7F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HeZb6vAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF7F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeJ3W2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:28:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeJ3W2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:28:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so12642924wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yeEXKRot/kddQBDynD+lXJi2xfZpd+B24QtApxsaUm8=;
        b=HeZb6vAgX+TUA8svrJGhtaR6O7rOZPQOIPOMoo29Y2E9BLtRkn2I0olFV9N372SAr9
         zBaENpl1kfuQ+8GlQn1fjpnNsfrxOkrD8sBbJtV1Mh5lfBUVK3qfbFxOatWlrA5fd/NL
         GY1yy7dUzQ0DFwwvkc09pQPUiNNxTj4MVlxg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yeEXKRot/kddQBDynD+lXJi2xfZpd+B24QtApxsaUm8=;
        b=P1RA8ftnZS8/Wpwx3XoZxFlTkLUc/PlCG7N4g8AkXmOqonEoYYdHCPzyj7OZ+AoQdp
         XsWfC2jhQ04xlS6hG29fc5y6YYI62IjLRaifpsGqKheBWvrOJo/etefTtoJY8kSnthCH
         vPgHYjjpUL91Tfza0za5tfRMq8210hF9DSwtMURv+sJHwcQuz2IJe2NR/yXfHPa/GK9u
         rUNbTB2MS3HNw+VGKKkoqVBgndxh17LQ7QQ0uI6O3k41XuHZBT3KmA5KxO0pD9IjvNW0
         0O4tDlmGWSqH5TNT5eNl6zAkfbMnW6DClVKb39eLX0s8IMQa0yWZ3uT2MGTtc8r9L5hx
         VaiA==
X-Gm-Message-State: AGRZ1gI3WohbJxpvqS2JGj3NNFlVrGehM6qwf5n+1rmsRU706jMSYbrR
        6mVSORJzJ7SAPzFaNtLlX2mOtw==
X-Google-Smtp-Source: AJdET5cV2C62C4iNNjK1gQ+/xlRRPV0hChwMVbELHP1em7gNZdOpP94P7yxh7jSUOY030+O5yGQRJQ==
X-Received: by 2002:a5d:5146:: with SMTP id u6-v6mr1912509wrt.299.1540906523126;
        Tue, 30 Oct 2018 06:35:23 -0700 (PDT)
Received: from [192.168.0.40] (12.152.88.92.rev.sfr.net. [92.88.152.12])
        by smtp.googlemail.com with ESMTPSA id q190-v6sm25843404wmg.40.2018.10.30.06.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 06:35:22 -0700 (PDT)
Subject: Re: [PATCH 1/4] base/drivers/arch_topology: Remove useless check
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <CAOh2x==y+7jEdC-3xpvhr6j+RTtXRwTnBFC2uRVUmuktbCvsKw@mail.gmail.com>
 <d689e382-e4f2-0b03-03a5-2ff4a6bb88bb@linaro.org>
 <20181030083308.5znognajpwjvdxfv@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <318665ae-0852-1350-b43f-bbf929b1cb4f@linaro.org>
Date:   Tue, 30 Oct 2018 14:35:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030083308.5znognajpwjvdxfv@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 09:33, Viresh Kumar wrote:
> On 30-10-18, 08:55, Daniel Lezcano wrote:
>> The workqueue is called from init_cpu_capacity_callback(). This one is
>> called in the notifier callback. IOW the notification callback
>> unregisters itself. But if it is not registered, it won't unregister,
>> hence it won't call the workqueue and init_cpu_capacity_notifier() is
>> not called.
> 
> Sorry, couldn't understand most of your reply :)

Logical, I didn't understand your initial comment :)

> Though let me try to explain the problem I was trying to show you..
> 
> cpufreq-notifier-callback
>         -> init_cpu_capacity_callback()
>                 -> free raw capacity
>                 -> queue_work() to unregister the notifier
>                 -> return
> 
>         ->init_cpu_capacity_callback() called again before work was processed.
>                 -> If we don't check raw_capacity, we may end up using
>                 NULL pointer, as the notifier isn't unregistered yet.

Oh, nice catch.

I'm wondering if having a statically per_cpu variable, even if it is not
free at the end, isn't worth regarding the twisted code we end up with
an allocation.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

