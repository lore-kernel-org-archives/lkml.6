Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6D2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6rEUaNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD6D2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbeGLOug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:50:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35854 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732507AbeGLOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:50:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so19541261lji.3;
        Thu, 12 Jul 2018 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l5k5VJAxtdPYYDxhCwt0rT9X4t+zeOlolDIDHe/lqig=;
        b=J6rEUaNF7UoX7z0XU1PiH2tJiz44m4YzYeUuPfyogXSI2KGBBqZUD+pA5VvSVddt6c
         V7nHg/4CRLiFV4RvuWntEFRysEQaycbavEKrfE2RTBBjSyZWwEEUqMtIlIZssuOG0aZU
         xZeeVMduTkjjxAuWwUDzFYEkM2IXQKeGmKfdk1+yu3R6ciAjIPGGcodM1nTVMqP4ktcm
         4mZ3zsXiHYgnf3zPsMZfjAnxSm+xq+O9unPKVX9mht2u/Tnqmg13qTLv5aRNdIYPgid0
         N1ko0jmB7PCbdqgZRiUNrY1v470s4uzAVMDVo0AhDyh70QrO/WrNorpEzM2SRHoDvBLD
         eCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=l5k5VJAxtdPYYDxhCwt0rT9X4t+zeOlolDIDHe/lqig=;
        b=XwM9Xu/uIOUOusugHsEBKF5uLYETbViSu4o1lYr96Lors965aFWw7Wrci8ODJACNcZ
         Ww/CiErOfxwyts2dkbGBto1Est+4WCI4qxIBpGgmfICqcE4vH8GrEsfgqfLDR4zRnOxG
         clEkYzd3ks3P7Y9iFmaABtziiJnH59WhcqBLwgTfoHn3TQD+cNAlAVcmkPYcdqoQX4+e
         FnrvTvhPKY9qHyTXFW0pgL2GeJyVSR4RReGkJRSQ1Ei5oBpA78hcuHR7YgU8RXco6Qdb
         Ocsi31THJnVUpIHTHxXQws5ajIIBKswF8pqJdtVuGUk8Mhes80TsXQddUq0COESEghrp
         JF5A==
X-Gm-Message-State: AOUpUlEMcq8j9XskxJf+9P+wPBJ2QwXURVjqbzHeby4OimDTQZh98+6r
        DdJ7aAK+KhSLDZSByD3XKSdM0aRq4Q7/tEoAkeY=
X-Google-Smtp-Source: AAOMgpdcRo98xcYNNp94xr5t0wVyquTJf+yAUANKkHzP4SuKImwIu5mGh03r2wfsrFEKsKgop3ayIapaWPsHK5lbOmo=
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr789414ljc.71.1531406443901;
 Thu, 12 Jul 2018 07:40:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 07:40:42
 -0700 (PDT)
In-Reply-To: <20180712082956.GD8802@infradead.org>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-8-deepa.kernel@gmail.com> <20180712082956.GD8802@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 16:40:42 +0200
X-Google-Sender-Auth: fKtoiJasJ_hM-ktGKeRDpxKyN58
Message-ID: <CAK8P3a0CHHTg+ccQc1VViRW8pmd7Rx+BsnGX8FWDQd3CK1BY1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] timex: change syscalls to use struct __kernel_timex
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:29 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jul 06, 2018 at 10:42:47PM -0700, Deepa Dinamani wrote:
>
>> -#ifdef CONFIG_COMPAT
>> -
>>  COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
>>                      struct compat_timex __user *, utp)
>>  {
>> @@ -1187,10 +1183,6 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
>>       return err;
>>  }
>>
>> -#endif
>
> And this unconditionally defines clock_adjtime, but doesn't actually
> seem to add callers, which looks rather odd.  Same for other bits
> in the patch.

It really just moves compat_sys_clock_adjtime() into the same
#ifdef CONFIG_COMPAT_32BIT_TIME that hides the surrounding
functions.

Currently CONFIG_COMPAT_32BIT_TIME is used only as a subset
of CONFIG_COMPAT, and the plan was to have 32-bit architectures
enable it later so they could get access to all the functions
implementing 32-bit time with a patch similar to what I'm testing
with, see https://pastebin.com/F3QZdyin for the current draft that
I use for testing.

We already spent several review rounds coming just discussing the
naming of the macros etc before we decided on the
CONFIG_64BIT_TIME and CONFIG_COMPAT_32BIT_TIME
symbol, but if you have a better suggestion (as part of moving
away from the compat_ naming), we can change all that again.

      Arnd
