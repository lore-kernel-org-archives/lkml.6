Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C82E21900
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UVRP61D2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBGIbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:31:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35436 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfBGIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:31:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id j13-v6so2252860ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 00:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F3OVCgS04O83R2oLJJQ2Nrws8Y1HvwAba42PL2PXJOo=;
        b=UVRP61D2Gkwq+NJPLZ38VxRUqsXvwp5kTWdVouWzK8tmmr3Zocbljkt8L6sYpwPr5L
         HfIo6YINtKnG2ZHaKKY61QaRNgp1hzgYRdJ29nfQVg4aaRsjXkfiC0jr2wP+D7xgrOy/
         X/klLsib3gocCvobSOb7BxVReEpSdwz2OCv9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F3OVCgS04O83R2oLJJQ2Nrws8Y1HvwAba42PL2PXJOo=;
        b=fvVti+UNwqWvW6tFWHjPW0xUOh47wtuqJJiardXvgJayZ9j7Uy7BXJAk2PPGX/xqR1
         gVKF6dEyMwQpdUBDwt35hoSiYqrC2HnpBwyByAw0PpyZ7Jv6GF6UZSF3rv6H20AQw7au
         2UHLOjzZqRJhZShY9vWMN/VyflBicle7Aa8Zdh2sOwCC6ZX1a0IDaBXzIprYTdsjhNt/
         TIyFc7WQUEeXCozg+K2ppm/o6RxWXpyU0oOyLpcJBe/XQ1CjqMkIl2P9bRw7v+h1ar9Z
         4q54R6GzFWL24GStv2evrJ12xohxq5hsS9XMY4HYGGA4724qFOpejacgkP7KZW/Ap8SH
         7d3g==
X-Gm-Message-State: AHQUAuaKaVzaeDT+o8bTieFrug4v1cWN2yW59+KNowi6hXjndyjR1EvP
        0K6UzVVCoIpSxcdbbYeveS9sNw==
X-Google-Smtp-Source: AHgI3Ibk3QtRuVL/qXVFet0q5Yhr9tYsZaKTkFDT6MtQmlvXQmBh6T3d5rT94kVAD/eEXGzBL9XLZw==
X-Received: by 2002:a2e:9f0b:: with SMTP id u11-v6mr8403932ljk.99.1549528272892;
        Thu, 07 Feb 2019 00:31:12 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m21sm4764473lfl.97.2019.02.07.00.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 00:31:12 -0800 (PST)
Subject: Re: [PATCH 16/32] x86/vdso: Generate vdso{,32}-timens.lds
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Adrian Reber <adrian@lisas.de>, Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-17-dima@arista.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a2bbe610-7553-0ba6-b58b-1013e034b8f6@rasmusvillemoes.dk>
Date:   Thu, 7 Feb 2019 09:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206001107.16488-17-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2019 01.10, Dmitry Safonov wrote:
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> It will add a penalty for everybody as branch predictor may mispredict
> the jump. Also there are instruction cache lines wasted on cmp/jmp.
> 
> Those effects of introducing time namespace are very much unwanted
> having in mind how much work have been spent on micro-optimisation
> vdso code.
> 
> Addressing those problems, there are two versions of VDSO's .so:
> for host tasks (without any penalty) and for processes inside of time
> namespace with clk_to_ns() that subtracts offsets from host's time.
> 
> Unfortunately, to allow changing VDSO VMA on a running process,
> the entry points to VDSO should have the same offsets (addresses).
> That's needed as i.e. application that calls setns() may have already
> resolved VDSO symbols in GOT/PLT.

These (14-19, if I'm reading them right) seems to add quite a lot of
complexity and fragility to the build, and other architectures would
probably have to add something similar to their vdso builds.

I'm wondering why not make the rule be that a timens takes effect on
next execve?

Rasmus

