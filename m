Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE74CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E83321780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeyDi0IM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E83321780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbeKOUE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:04:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40334 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbeKOUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:04:56 -0500
Received: by mail-io1-f66.google.com with SMTP id r7-v6so13879102iog.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKu+ZpTgdrMph3MTU+jlN22vZuqb5xRwQWAGLjD0msE=;
        b=LeyDi0IMg3ku3AAiptguG2b6UJbNeOmNu+IrRt1MBQ3QLb4PPDL9h/lRNhSu7ddeba
         1LlyMQVNJkW59KTRG9Q/rQ1VJR1AcIeFVIuF6WEEP9Y2ZNnzUtcMSfFZYCzkcZha9DFH
         hTIPsH0Z17VqzCpchticBaSU1yOtkjNvDUhXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKu+ZpTgdrMph3MTU+jlN22vZuqb5xRwQWAGLjD0msE=;
        b=WcJoC0DqlNmkrPGpT/gvrhCWwq6Kl1qp9Cfl0zb/0NyAcXwNBRWjkMmig12YTzefMQ
         h8eRBboIoy7zPNpBIkH3MTeuNjGoqvq3iy3c4wEBe1fnwI0lmo3wennTLfctgwjO1oOo
         DF/vpFVpDbwtLQiGXM5tJXBncSPU6US1suCgH7kq0bXYw2+CPz4RWop7YVPrfFT7YSnv
         njwnz6ZKtY5nD6P4WW79GUkFoU7WhoMH7B3MjLKHqaoHwQ5eCzMLiReIbZVUW0x/uMxO
         1KnHqc3vruLZ0agkb8+o9HzHgsZOxc3vughVP76aqsLLEtX372xCOCQHV5+06CpFLT/2
         Nwrw==
X-Gm-Message-State: AA+aEWYeuecoF0nZGvz0EiJPDBMywm+Jl9XOZ34rzoPkxFi/zB5u45wX
        YSFHNO7cDGQNLzylQdu+gjw9QfLMNStwz4kKWvUU8A==
X-Google-Smtp-Source: AFSGD/V39DmWYfS5WDypLkd1SeWrHWfWxgAxjv19BqjJEtM3OALWpvMw0tLZc7r/rwjBz/I5W3ZNa7ATk/xUGd5B/i8=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr4296509ioc.119.1542275867960;
 Thu, 15 Nov 2018 01:57:47 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org> <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
In-Reply-To: <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 15 Nov 2018 15:27:36 +0530
Message-ID: <CALxhOng8jc3WCmw-i5LeghjE5EKuJaXVZGHLN98+552qqgUy=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
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

On Wed, 14 Nov 2018 at 05:23, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Firoz,
>
> On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> [...]
> > Firoz Khan (3):
> >   xtensa: add __NR_syscalls along with __NR_syscall_count
> >   xtensa: add system call table generation support
> >   xtensa: generate uapi header and syscall table header files
>
> What's your plan for submission of this series? Are you going to
> submit it with other similar series in a common tree, or shall I take
> it into the xtensa tree?

I prefer the second  option.

Thanks
Firoz

>
> --
> Thanks.
> -- Max
