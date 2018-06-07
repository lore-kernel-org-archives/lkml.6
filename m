Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CVChDbxhGVvjTQAAmS7hNA
	; Thu, 07 Jun 2018 16:47:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 198DE6089E; Thu,  7 Jun 2018 16:47:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMhlszr2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89EB7601B4;
	Thu,  7 Jun 2018 16:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89EB7601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeFGQrw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:47:52 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34498 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932647AbeFGQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:47:46 -0400
Received: by mail-ua0-f194.google.com with SMTP id 74-v6so6975239uav.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CBljQIfjBDSLVYosz1ncdDxJ0n7KLw23n6ER51QagWQ=;
        b=VMhlszr2mVF+JkVJR6W6aiQRSWURoEOCjBWcygx06DXl5c12qG+XF9J6bfEjI2W+4J
         1E2bFKSIe683D/nXdoEOIs9qMus0ThJ6swOTw663/Q1pgoOD9sCGj+hnjLbIWf5O0v+H
         NYxzo8qzw24MxRk1388FUm++YdubleN7unhrv/3n6yPU8iEXQ8qcHr0rZ/Ir4Y1qiLs8
         2yiXguzC4tBcZlEC2Mx7vLdUG1Drm0bCogEDhAlMn4wTd0JtQKVwUxo/B9YwQA6qyq1b
         Nb5PWfL7RA6tif4CXywm4cFRWRXYCyG2gJ/mB3UOLL9Xu/jvlEbzjqHqn6HpKiJa5bQU
         iRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CBljQIfjBDSLVYosz1ncdDxJ0n7KLw23n6ER51QagWQ=;
        b=ex9YqUBOvyKkzTceiC7cRbx5CzhSLF5DAYF2jh9xvxJlVjINNvdnpK0fiRv4UfAu4s
         4VXQL/XK4Wlts0MOUfDXEWORr8/JpLNXCkqVChT3PM96O/UHzRBpOP8a8H2cnTvZ8u9o
         cX8pObOEbkAwJ0avmqybxjdZWhqNFnrHf/vfLlmzxo0oZPz3Ar4BMPb03XkSfxMJSpWf
         fwiHorUSl8DsRLbb8PmpWCPu1P9MDZAQYQ1EypbOnjUrNMbwM4Hhqya90XHhnxJM9zQJ
         2pchPfQMFeFavA6RdhG23p0gCug4OEquJtxBLBx93Kj8eo9EnBEEORGD0VNmC+KfpeNB
         /UEA==
X-Gm-Message-State: APt69E3Tie8Iul9v2oxpqcryU2l/XF1FYSPr48Rb5ZpzDe/N5zPgEzMv
        6GO/BVv7YizcUP0d2sQ3EqEZWT5+Jods996VVLbB2w==
X-Google-Smtp-Source: ADUXVKK4r/4y10kOU65ZWG5bYxp+qlj/0eVhzFad5mp/XIdD7suaXTv/lvXYx7rVkwPMjJh+guVzTQVZclSZ/5X9EsU=
X-Received: by 2002:ab0:1251:: with SMTP id s17-v6mr1636177uac.37.1528390064650;
 Thu, 07 Jun 2018 09:47:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:80d4:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 09:47:24 -0700 (PDT)
In-Reply-To: <CAOGSYL0ga-H=0a5EEDmOWSZjnmG1Qc=9AxAbM_-ifHDj_FbREg@mail.gmail.com>
References: <20180602023215.176521-1-ravisadineni@chromium.org>
 <CAJZ5v0gWeq034sObmHsbJoiBri4a=Av8xroeuW+eqyv_W=cHjQ@mail.gmail.com> <CAOGSYL0ga-H=0a5EEDmOWSZjnmG1Qc=9AxAbM_-ifHDj_FbREg@mail.gmail.com>
From: Ravi Chandra Sadineni <ravisadineni@google.com>
Date: Thu, 7 Jun 2018 09:47:24 -0700
Message-ID: <CAOGSYL3ZHZ2Desafp5bmyEnfUW6xdu3CAhKu2=P7X_omb8Cavw@mail.gmail.com>
Subject: Re: [PATCH] power: Print wakeup_count instead of event_count in the
 sysfs attribute.
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, chenhong3@huawei.com,
        Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor@google.com>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafeal,

Soft ping. Is this patch good to be merged ?

Thanks,
Ravi


On Sun, Jun 3, 2018 at 10:14 AM, Ravi Chandra Sadineni
<ravisadineni@google.com> wrote:
> Hi Rafael,
>
> On Sun, Jun 3, 2018 at 1:05 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Sat, Jun 2, 2018 at 4:32 AM, Ravi Chandra Sadineni
>> <ravisadineni@chromium.org> wrote:
>>> Currently we show event_count instead of wakeup_count as part of per
>>> device wakeup_count sysfs attribute. Change it to wakeup_count to make
>>> it more meaningful.
>>
>> More information, please.
>>
>> In particular, why it is more meaningful.
> Wakeup_count increments only when events_check_enabled is set. This
> bool is set whenever we write current wakeup count to
> /sys/power/wakeup_count from the user land. Also events_check_enabled
> is cleared on every resume. My understanding is that, userland is
> expected to write to this just before suspend. This way
> pm_wakeup_event() when called from irqs will increment the
> wakeup_count only if we are in system wide suspend resume cycle and
> should give a fair approximation of how many times a device might have
> caused a wake from S3/S0iX.  event_count on the other hand will
> increment every time pm_wakeup_event() is called irrespective of
> whether we are in a suspend/resume cycle.  For example when I try
> doing something like this (https://lkml.org/lkml/2018/6/1/890), we see
> the wakeup_count sysfs attribute for the particular device
> incrementing every time there is a irq. If it is important to expose
> event_count via sysfs attribute, should we create another attribute ?
> Also we do expose each of these counters via
> debugfs(/sys/kernel/debug/wake_sources).
>
> Please correct me if I am wrong or missing something. Also if there is
> a better way to do this, please let me know.
>>
>> Thanks,
>> Rafael
