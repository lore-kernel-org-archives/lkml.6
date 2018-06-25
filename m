Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC498C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5280D25519
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ue4QzpDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280D25519
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeFYHRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:17:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39712 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeFYHRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:17:44 -0400
Received: by mail-lf0-f67.google.com with SMTP id t2-v6so13573348lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EpWL8iUVCezpHaWboyC2BprR9cD5RAh1IEj4w/mNkK4=;
        b=Ue4QzpDWetTVWgGlsH/VNpYOzHNcMNhUOmW9P+g8XvGTpz9SQpFuJJr21TNkvgfU6d
         32GP81YzEgWohGRtYwvkIOYV18UGM3pOKwF1d0qeZWzB5O5CBQKuOyHs0fYG9xIDD0W5
         qMNUg1069NtbUWINsayxD9+EWmWrJ9kw02ncc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EpWL8iUVCezpHaWboyC2BprR9cD5RAh1IEj4w/mNkK4=;
        b=nNKDX7j6S/wNt0VsoAbyjCsSY7GfU3h/QX57bkCSVF235ml3IJvYqOMuvofUwdecps
         OyCpDPLIfCbmDteN79EtTSJBihAzy82LZzuH/Ctdm2W2h9igld2GSb1BdkA0hhXc7soC
         /D+BHsAmYgjjN1igRC0+1bBzVgfVl/+xbk/9KSJAxKBHmKzzqQ6KwuDP8fhfGNrmGMA8
         XGg6fW4JqkMBcDwwhKZ1zChlN6h9n+eIRNXiZZORirFhtxbZFWwo85X42cIsnOeMI8lB
         REXAkNqL2BWpWWA1MiPB5lbnSLw0n9u/E8/ggrLZiS22RseWtqepQdafMz/Q4VkHBwCW
         U2IQ==
X-Gm-Message-State: APt69E2yzTc4pg4LrCUN3KW2g3VcBMVxIkr+yPiyGx9mbTR2avfK9S7p
        QR43a/qUaro+DYhOs48EAez96YYABku8nddBJ8Qasg==
X-Google-Smtp-Source: ADUXVKI9DygxEQTnVTUUtdIr9rOc48CxEeaZxPpc8rGnplyJ4TEsPu0YtC+b4ZHgXZd1cZsxqSI3vnBDAurq1HKvIqY=
X-Received: by 2002:a19:51db:: with SMTP id g88-v6mr5399159lfl.78.1529911063291;
 Mon, 25 Jun 2018 00:17:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 00:17:42
 -0700 (PDT)
In-Reply-To: <20180625065557.GA5140@kroah.com>
References: <20180624142740.481662434@linuxfoundation.org> <CA+G9fYsxWVXZH=VB9tCvBcJ_K4pOPs51J1XnnCjF8vcBVMadDg@mail.gmail.com>
 <20180625065557.GA5140@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Jun 2018 12:47:42 +0530
Message-ID: <CA+G9fYvsGCogLWYooQ9qjUYuu5XO=pwD_q3vqD-ys41wwPk90w@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/70] 4.17.3-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Kselftest test case mov_ss_trap_64 is causing kernel panic on
>> qemu-system-x86_64 and PASS on real x86_64 hardware.
>>
>> [RUN] MOV SS; CSx14 INT3
>> [  762.263790] PANIC: double fault, error_code: 0x0
>> [  762.265169] CPU: 2 PID: 3380 Comm: mov_ss_trap_64 Not tainted 4.17.3-rc1 #1
>> [  762.267588] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.10.2-1 04/01/2014
>> [  762.273190] RIP: 0010:error_entry+0x12/0x100
>>
>> Test code snippet,
>> main() {
>> <>
>>     printf("[RUN]\tMOV SS; CS CS INT3\n");
>>     asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss));
>> <>
>> }
>>
>> Reported upstream,
>> https://lkml.org/lkml/2018/6/25/19
>
> Nit, there is a better way to refer to lkml emails, see the bottom of
> this page as lots of time lkml.org does not work for people:
>         https://www.kernel.org/lore.html

Sorry about that.

>
> This looks like a quemu bug, not a kernel issue, so did you tell the
> qemu developers about this?

Thanks for confirming this is not a kernel bug.
I will report this bug to qemu developer mailing list.

>
> In looking at the full headers:
>         https://lore.kernel.org/lkml/CA+G9fYu0E0fM+WaFim1WKup5BZvjtGZ_4ii5FhTUjNZEqaAuwA@mail.gmail.com/
> it doesn't look like you did :(
>
> thanks,
>
> greg k-h
