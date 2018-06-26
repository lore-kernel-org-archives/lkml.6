Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F263424D4E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kdp7CNy4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZGUuUzMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F263424D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeFZQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:55:02 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41997 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbeFZQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:55:01 -0400
Received: by mail-yw0-f196.google.com with SMTP id i143-v6so4857531ywc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2yF/chjSYg1rhHn0ubGQyEC0d68k6bewWdcfOTWkqXc=;
        b=kdp7CNy4zlwEE8sCAbmvHqTj3240XqQmiSKrY4MEqi75mn9ndWfPuJZjg3WrOkw3b7
         xjdSjDUmwlho1Kyk2H9WbG1uIGDHFWfAjaLQAIJhI8Q7gJq3k0xKszFwlpoa2SMNIFFS
         Sa0dT7fR5WnFItmlTjCZXSjIAmsT0m1j6Yk3F1QRkI6KOmsew0EhOkltHP1YUIsoJOa6
         KLFm0ZtMEjawjvQ+NqGK7PPRLKj4dEEbx0+U04jLxICaJdPNCCD0ZICX6oaBHFc489RK
         BaofeG78WTmXzk1Fe8fZGuIFj6MmM6Bi3Hpg1YnA4htB+m+Ch7GfAPD//Y5F/04h/15F
         PusQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2yF/chjSYg1rhHn0ubGQyEC0d68k6bewWdcfOTWkqXc=;
        b=ZGUuUzMYRSo+HkqQMSB+pIBZsu68D0h8HDE1s+4EYjxIxqe0d2VRkWIQpk3m/NYy+e
         mTuQh9fmzsv5nHhN0GQZSplxS1L0cxlLEoUwygyMs8ULT2DYpLLg3jsX9cabRWbQzlk8
         Lq6TRUc5ZNa7qOoW03BVNr/anFT+u6rg9Ewss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2yF/chjSYg1rhHn0ubGQyEC0d68k6bewWdcfOTWkqXc=;
        b=oPtZMirEPnQmO6h1js7rl+aXP2z9LroMDuoaS3UnIXNAy0XBDQkTNtOdiAd2GGoQK8
         6Vlth+6ZPWvXR3e68hbu8fKK2fS0perkOwnc8b/kv1pupi3XQCZihzcbiHcXctg+UCYF
         LPtsB5vqARubSX7zSICQm/LLUPImF821GR2BzH5+zmslAkRDgsWytkg0e37uT+utbQ/c
         MJi2NAefh0y3TzlZj3vzCrshWmrIvLIVVfX1M4bmJ2/O+sHgQVROb96FB3trlW9Ym/wW
         KADdschK1VjQmraUzuwkhclCu3A1PFVLO2RmWm7AqqeICK/sfFRDo7RztmunxFHop5ju
         sGEg==
X-Gm-Message-State: APt69E18GkeMNOAlZW5Xew8D6zQJ5O63YqO/kshvI88CtfOC33xlPh/1
        5rbqu4O7uauoGSL4BlV2XLU3XU/aQHfD1J6kVYaskQ==
X-Google-Smtp-Source: AAOMgpdhfNXoKi/BhMsya1IXzZclgXDMlnFrejr0ahgu7glZf3eONw4Al93rR8ZT8bV9xvsI/lMgRa9q5ASZfSAFD00=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr1113581ywf.129.1530032100265;
 Tue, 26 Jun 2018 09:55:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:54:59
 -0700 (PDT)
In-Reply-To: <a48538cf40c1645669326c92d9600fc98a13a260.camel@redhat.com>
References: <CAGXu5jL=aEXHKr5ouVdSKwG-y7xSQFLi=x1nwSjFspYiyKL1Pw@mail.gmail.com>
 <64bf81fa-0363-4b46-d8da-94285b592caa@redhat.com> <a48538cf40c1645669326c92d9600fc98a13a260.camel@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Jun 2018 09:54:59 -0700
X-Google-Sender-Auth: yu9TgeG0dRdU7UGku88TQHx-hf8
Message-ID: <CAGXu5jKHz=OaU1ejYEB=t-=Gs6gVoRywFbyQw8ThHk6WYG7Qxg@mail.gmail.com>
Subject: Re: [PATCH] add param that allows bootline control of hardened usercopy
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:48 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> Hi,
>
> On Mon, 25 Jun 2018 11:21:38 -0700 Kees Cook <keescook@chromium.org> wrote:
>> On Mon, Jun 25, 2018 at 8:08 AM, Chris von Recklinghausen
>> <crecklin@redhat.com> wrote:
>> > Enabling HARDENED_USER_COPY causes measurable regressions in the
>> > networking performances, up to 8% under UDP flood.
>>
>> Which function is "hot"? i.e. which copy*user() is taking up the time?
>> Do you have a workload that at can be used to reproduce the problem?
>
> I'm running an a small packet UDP flood using pktgen vs. an host b2b
> connected. On the receiver side the UDP packets are processed by a
> simple user space process that just read and drop them:
>
> https://github.com/netoptimizer/network-testing/blob/master/src/udp_sink.c
>
> Not very useful from a functional PoV, it helps mostly pin-pointing
> bottle-neck in the networking stack.

Cool; thanks for the pointer!

> When running a kernel with CONFIG_HARDENED_USERCOPY=y, I see a 5-8%
> regression in the receive tput, compared to the same kernel without
> such option.
>
> With CONFIG_HARDENED_USERCOPY=y, perf shows ~6% of CPU time spent
> cumulatively in __check_object_size (~4%) and __virt_addr_valid (~2%).

Are you able to see which network functions are making the
__check_object_size() calls?

-Kees

-- 
Kees Cook
Pixel Security
