Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D93C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D2520855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQbWyOlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfBHPTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:19:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38463 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:19:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so3058471ede.5;
        Fri, 08 Feb 2019 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BvVSppcWn4VKsXIVbbXUK9OzQFNQquhADDfzAtIHSjQ=;
        b=qQbWyOlW4jZhTSepxY6IuZc9GizIYO0YmQSzY5+z3ft0wFNY9G6+H0CYMBaoursQq2
         E2Z5K+wfPrkdxvZUgRjIRSXyVF0Mxm9pg+5ybj+YNvYXAy7jNUDAZZ8P/rZWV5hAU68U
         vg3fmyutYTD78lGwtOq+J5EVQMP87EvmcZdgaZiQWhZN+nzGt9CYHuo3lGQ4QNqF8+WW
         C9+sdT1WkyUd/1c7agT0Mw0JPHYi/ftkHfsjcd8ycyayxlJ8ndt3ngdUwfOB9DejFYob
         zKT0ajmPD1yk0cOEdIDLTq/o+m7qVCuEUPbet54aWkuBf+Mn53K+RdEw9lDJ8V+6lpti
         Tv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BvVSppcWn4VKsXIVbbXUK9OzQFNQquhADDfzAtIHSjQ=;
        b=X0/cHpa4xXls2tsWJmfC+PZPsxoeQnGkk5qN40K5bHPxyONyi8oidZPa/1wZ3d16yk
         3gdYtQKwlOgrHlAJ/5nhVyiF5+kx0xwiFeYNpEbKhhOlBKyvbCA18KdB2YrUBpU8lIti
         fRfhzaTzpXofWzpe+WjYdEW2RQMs7BW4eW83orrmBFIdD0oIaSeZ4PRiwMfbETwz8Yyk
         yJE7PTW2hV+zv+IJO3jeC44X/KhCGFOCh8thbKTG3a1utGPdJM2USpoW/hWC/BFzchIS
         pQghq1XxiDu5fe6sMf1dkUDED/vri7EuhL3fcATbv3HjHoj2NDOPNF2apgiSOsYLPm+k
         QRFQ==
X-Gm-Message-State: AHQUAuZYC4YOtUTVLG2rhEZ63o5HM/AHLjBsO9d8tGiVoTs3gHx8MM2d
        sFoRr9PdWY8UsYTpnFYmTgM=
X-Google-Smtp-Source: AHgI3IYFaDDqMZAOazuJyTTXQfm3Y6F9RIFCwFsXW2qY0NZHjA6nnQYDdploNVfWk5NPLMQNP4PAyA==
X-Received: by 2002:aa7:c0c8:: with SMTP id j8mr10087558edp.94.1549639138655;
        Fri, 08 Feb 2019 07:18:58 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z60sm674220ede.82.2019.02.08.07.18.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:18:57 -0800 (PST)
Subject: Re: [PATCH 16/32] x86/vdso: Generate vdso{,32}-timens.lds
To:     Thomas Gleixner <tglx@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-17-dima@arista.com>
 <a2bbe610-7553-0ba6-b58b-1013e034b8f6@rasmusvillemoes.dk>
 <alpine.DEB.2.21.1902081051410.1645@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <3f0ac089-387e-ab58-59e9-5f8cafa1573d@gmail.com>
Date:   Fri, 8 Feb 2019 15:18:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902081051410.1645@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 9:57 AM, Thomas Gleixner wrote:
> On Thu, 7 Feb 2019, Rasmus Villemoes wrote:
> 
> Cc: + Vincenzo, Will
> 
>> On 06/02/2019 01.10, Dmitry Safonov wrote:
>>> As it has been discussed on timens RFC, adding a new conditional branch
>>> `if (inside_time_ns)` on VDSO for all processes is undesirable.
>>> It will add a penalty for everybody as branch predictor may mispredict
>>> the jump. Also there are instruction cache lines wasted on cmp/jmp.
>>>
>>> Those effects of introducing time namespace are very much unwanted
>>> having in mind how much work have been spent on micro-optimisation
>>> vdso code.
>>>
>>> Addressing those problems, there are two versions of VDSO's .so:
>>> for host tasks (without any penalty) and for processes inside of time
>>> namespace with clk_to_ns() that subtracts offsets from host's time.
>>>
>>> Unfortunately, to allow changing VDSO VMA on a running process,
>>> the entry points to VDSO should have the same offsets (addresses).
>>> That's needed as i.e. application that calls setns() may have already
>>> resolved VDSO symbols in GOT/PLT.
>>
>> These (14-19, if I'm reading them right) seems to add quite a lot of
>> complexity and fragility to the build, and other architectures would
>> probably have to add something similar to their vdso builds.
> 
> Yes and we really want to avoid that. The VDSO implementations are
> pointlessly different accross the architectures and there is effort on the
> way to consolidate them:
> 
>   https://lkml.kernel.org/r/20190115135539.24762-1-vincenzo.frascino@arm.com
> 
> I talked to Vincenzo earlier this week and he's working on a new version of
> that. The timens stuff wants to go on top of the consolidation otherwise we
> end up with another set of pointlessly different and differently broken
> VDSO variants.

That looks awesome!
I've missed the tread about it, will catch the details.

Thanks much,
          Dmitry
