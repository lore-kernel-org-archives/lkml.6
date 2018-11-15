Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B3BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ED222419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBkAJeoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ED222419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbeKOUMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:12:45 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38344 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbeKOUMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:12:44 -0500
Received: by mail-it1-f196.google.com with SMTP id k141-v6so28423899itk.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1O5QeBXNTKJsnfH4yuc6B/0oPJM0+rcTyrA4hnHLMJ4=;
        b=HBkAJeoJwfE9BzYgivF5GViHshYLx8/aeNv/x0tqg2G4mWGYAY3j52wj9ZvWOZchan
         QkBegBhLRbPlNaDuxRR/UXURr7KlaGE094UmZqO+5som4DauFq2flFkjBR6gRiVw4NFi
         3w/jerH/ejrXBoHivlhwtHSMOcMlsB7bs5v1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1O5QeBXNTKJsnfH4yuc6B/0oPJM0+rcTyrA4hnHLMJ4=;
        b=hq2yP7Wv5YNDfqO2FqZe++HOmYtLIx2fxXFwnOczw5rbbFObmU1nvQwISdcNdWJJtn
         NpbmJfJnrO4MraolT0EICYIObqBbQbqN0eYYStnrYAMEJnkgyNrWhBhP4qHVts0in9XB
         Ky0WPHMeCNQCb5a8H2w0aHhwbDgH0ncksnkHx51xvMWYs5fIaTHsqkcxQuFr71B8WZsa
         HiDdXHK39HGxaf2vHXthR1Tj7fMmVjr9qMopzclrtdSYT8Fpil+RRuUkmhTbNOYiLPcR
         J4YFugw0xi7mJwqoH9NyG9j+IzuYAyeFpolO1AQd8Dz4VKmzXOY9Xn7nXAPeJOg9kSkE
         BjEQ==
X-Gm-Message-State: AA+aEWbcypx2oXFmU15k3P0vEAun/7khr2nuwvrxrwUXcq1ywgiWjRzE
        7KDgy5oQXr658MTQs9fFI7B7htJ2/4OonFKAuM7SKFIzlaw=
X-Google-Smtp-Source: AJdET5cNa/Aq1YxMyJ5M33yYS4goSKM4J7vMzlAQ7ga3g7BVokFgY4SVtnVSz/sHwDqz7GvKEy5CwhBdAjMa2VBDNf0=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr4929034itf.166.1542276334446;
 Thu, 15 Nov 2018 02:05:34 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <1542104370-22831-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
In-Reply-To: <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 15 Nov 2018 15:35:23 +0530
Message-ID: <CALxhOnhBN3ibNku5z4ZwnRjnWEtSrsbyVQUDzJkT6U65Ek0H+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Wed, 14 Nov 2018 at 05:19, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Firoz,
>
> I have one more question:
>
> On Tue, Nov 13, 2018 at 2:20 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with __NR_syscall_count asm/unistd.h. The macro __NR_sys-
> > calls also added for making the name convention same across
> > all architecture. While __NR_syscalls isn't strictly part
> > of the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
>
> Looking at the include/uapi/asm-generic/unistd.h I see that
> __NR_syscalls is not guarded by the #ifdef __KERNEL__,
> why should it be guarded for xtensa?

__NR_syscalls for kernel. So this macro is present in asm/unistd.h
rather than uapi/asm/unistd.h. As I mentioned in the patch, it would
be better to keep in uapi/asm/unistd.h to count the number of syscalls.
But this will create some side effect. So I was guarded with __KERNEL__.
In order to come up with common implementation, I kept this for all
architecture.

>
> If we remove __NR_syscall_count from the uapi header I'd
> suggest dropping it completely and switching its two current
> users to __NR_syscalls.

I'm not removing the __NR_syscall_count macro; just place it
in asm/unistd.h file for the above reason.

FYI, I made sure that the kernel will build with my patch. I would
appreciate if you can perform the boot test on the actual platform.

Thanks
Firoz
>
> --
> Thanks.
> -- Max
