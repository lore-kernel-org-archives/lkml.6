Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BAEC468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1D2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLFw6k0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC1D2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbeGLPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:03:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46226 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbeGLPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:03:19 -0400
Received: by mail-lf0-f68.google.com with SMTP id l16-v6so24490214lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LtMXOsEKRmo9Xs1o6pS7MykKjB6sXzjGV7cjCMO8fUM=;
        b=pLFw6k0KgTb5+cSsY+TFfbarGSjZmNVC1KM9XVbm2TrEE5oWeV/Y/MPDPfRHaQ4DQP
         LqAASKqaU094bu7Hj2j/ZC3opFaLSd55T9VtRdoAjNnhzDxp0wEY0wThridvOvWftitq
         RxV5C6BdKDV3pnxn39SS2lP39YkpQDXjzsdWYkmBlxyKu0QpM1hMUXvXbl9w9GLiOvMF
         2UtKdb9dl48ozwaykQgEXlMyt7NPHzQd8svaweJIcr6mB5yyuxFDSdOmUTrMSlgJqKMa
         fIHMVVl+mvmt1S7JluoLHIq67YCddMQG9ZFLYgPK8eYxlgsCVbRYi6wRMgW66ZAHx4ha
         1hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LtMXOsEKRmo9Xs1o6pS7MykKjB6sXzjGV7cjCMO8fUM=;
        b=hIyj5D3vH6Jt6T5Hs8wOykwSyF7m8grsxSgRLL42DWgkN/0Rh+PZo06xwE/IzJ+8Nq
         gEQy/OZk6zkupbv9c5XmPGJo9aQNbrop1Y/RkFERBKa/H9EGd81QYNVNBtybIu+H9PZi
         hsBVTlReWOsVDkxJSvborSpI5Tb5WFN8Uucw+2ZbsuBXKOizvwpkS4D+08nq7PS6Jxku
         h6drPSuCRwi+SLAgPLiYoY7m9ZdlaoneW24Q/i+Avw72TH3ObIaFISlXAJLJBHXVsUph
         lLi49YPTiT3zvPezhXIfB68HXsLdurtRRB7a0YtS+L3fs7R+UPnMS0M4YnG9CMUxIu4f
         19rw==
X-Gm-Message-State: AOUpUlGlDEHxPsVjOHsIXRAme6BIGtocOkeGY76FxbuQWvc9wKJe+sk3
        PqDWMWm02hIBweT6fOlzDx7mcL+XVAzwkrZj8hw=
X-Google-Smtp-Source: AAOMgpdUndlgFe0adDQ0v446vQpZsS03GYrvNxsdOV6J4B8xaN+HBKy/TE4QHFpUa2u6p8FhTN9znAFQFyLYfk0tFWk=
X-Received: by 2002:a19:7b08:: with SMTP id w8-v6mr2116559lfc.22.1531407204113;
 Thu, 12 Jul 2018 07:53:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 07:53:23
 -0700 (PDT)
In-Reply-To: <20180712082609.GB8802@infradead.org>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-6-deepa.kernel@gmail.com> <20180712082609.GB8802@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 16:53:23 +0200
X-Google-Sender-Auth: ZjS_JP_ATnZ01T9h9c6B8fUOzsw
Message-ID: <CAK8P3a02MJt7xDR3-u4r7GGaUc-ndnkq8Hb_ZC7YB6mkNqmeLw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] time: Add struct __kernel_timex
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:26 AM, Christoph Hellwig <hch@infradead.org> wrote:

>> +#ifndef CONFIG_64BIT_TIME
>> +#define __kernel_timex timex
>> +#endif
>
> using #defines for structs has all kinds of ill effects.  Why can't
> we aways use __kernel_timex for the in-kernel usage?

It's the same thing that Deepa did in the already merged
series for the timespec interfaces, this is done in order to
stage the conversion of 50 system calls and 20 architectures
without having to do everything at once.

The system call entry points are changed to take a __kernel_timespec
or __kernel_timex argument as the first step, and the conditional
macro override makes that a NOP. At the same time, the existing
compat entry points are modified so they have the exact same
behavior but use the compat_timespec, compat_timex etc
argument types (which we can rename, too, as discussed).

When a 32-bit architecture gets converted, it sets
CONFIG_64BIT_TIME, which flips the normal syscall entry to
use 64-bit time_t, and enables the compat syscalls to be built.
The same arch specific patch must then change the syscall
table to redirect the old syscall numbers to the compat handlers
(which implement the 32-bit time_t arguments), and add new
numbers pointing to the default handlers that now take the
64-bit time_t, see https://pastebin.com/F3QZdyin

This was all explained in a lot of detail when the first set
of patches got merged for the clock_ syscalls, but I suppose
it can all be explained again.

>> +#ifndef __kernel_timex
>> +struct __kernel_timex {
>> +     unsigned int modes;     /* mode selector */
>> +     int :32;            /* pad */
>
> Why do we need padding for a purely in-kernel structure?
>
> Also the anonymous member syntax is rather odd and I don't remeber
> us using it anywhere else.  Why here?

This is in the uapi header, and the structure just matches the
existing timex definition, which has the same oddity.

     Arnd
