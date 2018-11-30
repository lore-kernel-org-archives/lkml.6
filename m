Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D860C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12CB20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZ3ISqG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12CB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeK3QNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:13:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35484 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeK3QNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 11:13:18 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so3552162ioc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 21:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY5ldt/nvbSFXjThNmQjCgsUcV0slJ0eCOAORjgvOko=;
        b=VZ3ISqG7vJiHteR3Wc9v9zOLEZdAQyQstRiI782J1G5n1ySMxWCSYKka3klsSovgZG
         366zRvN/ZHhlb9zmcu6yYzzunhA+UVExfUuwzH4kU4uiekLb7khZdOu/7gbOy+Lgl6Xu
         NJr7gk5SCjikRFCsd430lskS/ZSnrr2IBySMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY5ldt/nvbSFXjThNmQjCgsUcV0slJ0eCOAORjgvOko=;
        b=n5rm7N6tLHkqmatQz0hz38dCi9LV5JfhZDbcuD+FAAkRJZ5mxgtZjk69wi2Qj3TqRg
         H6zR8f2W0HDqlYb6QjDC10mffVqKaZK+A6RV04ViF4Mga+EBqctfpuCaSHfW43t+jcoQ
         hq0UmbKHuy3gT8yFIvjSBK7hsmatCrAg4aHhnkPi1HMIvdttHfaN60OhBcp/6YB//p+s
         XfwKbQ6lzmDr43P+Ryq2Aqhcp4MhN0XFhfS00OKVARH7SPXrK/37e4rVbLmomBI01V7w
         vGr8p5o79VuoJOXuEl387g3dY71KorpevFr9cEWJrNmIQXVKL/MkU5znofSDnCshFGOv
         /9UQ==
X-Gm-Message-State: AA+aEWYOfyoNeQJHj61gnvdEvkdSEuMY+3aZYE3l1/GGaffYVbBUg2Ki
        x91TzzQ3T84ex9NCVOi6uqdeKfrQP/9PECuZvdk4rw==
X-Google-Smtp-Source: AFSGD/VHy2GoglJpf5KuZifXucd+0itkqTW5MYI4S1kTr8TRo8fZu9CyYUvzL/AT/AQzuL9fEx7BQB9MwypD8kU4EF8=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr3440101ioc.119.1543554314477;
 Thu, 29 Nov 2018 21:05:14 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <1543481016-18500-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1KcUQEbavu1eZaoKXTmbdbxiKgVqt6XF-PeeSSbpVEVg@mail.gmail.com>
In-Reply-To: <CAK8P3a1KcUQEbavu1eZaoKXTmbdbxiKgVqt6XF-PeeSSbpVEVg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 30 Nov 2018 10:35:02 +0530
Message-ID: <CALxhOnivqOdpZ8WRK3Lx9ScApa34MS6riTwFz15aS7GTGf6QQA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mips: add system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your email.

On Thu, 29 Nov 2018 at 19:46, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The system call tables are in different format in all
> > architecture and it will be difficult to manually add,
> > modify or delete the syscall table entries in the res-
> > pective files. To make it easy by keeping a script and
> > which will generate the uapi header and syscall table
> > file. This change will also help to unify the implemen-
> > tation across all architectures.
> >
> > The system call table generation script is added in
> > kernel/syscalls directory which contain the scripts to
> > generate both uapi header file and system call table
> > files. The syscall.tbl will be input for the scripts.
> >
> > syscall.tbl contains the list of available system calls
> > along with system call number and corresponding entry
> > point. Add a new system call in this architecture will
> > be possible by adding new entry in the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >         - Compat entry name, if required.
> >
> > syscallhdr.sh and syscalltbl.sh will generate uapi
> > header unistd_64/n32/o32.h and syscall_table_32_o32/-
> > 64_64/64-n32/64-o32.h files respectively. Both .sh files
> > will parse the content syscall.tbl to generate the header
> > and table files. unistd_64/n32/o32.h will be included by
> > uapi/asm/unistd.h and syscall_table_32_o32/64_64/64-n32-
> > /64-o32.h is included by kernel/syscall_table32_o32/64-
> > _64/64-n32/64-o32.S - the real system call table.
> >
> > ARM, s390 and x86 architecuture does have similar support.
> > I leverage their implementation to come up with a generic
> > solution.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Ah, I see you added the syscallnr.sh script from ARM.  I guess
> that is one way to handle it, and the implementation seems
> fine. It would be good to mention it in the changelog text above
> though.

I came across the file name - syscallnr.sh  in ARM long back and I
used it here.

Everyone - Arnd pointed out __NR_syscalls assignment issue in my
v2 patches. For that, I came across those macros to be part of the
generated file. So I created another script - syscallnr.sh just write
__NR_N32/N64/O32_Linux, __NR_N32/N64/O32_Linux_syscalls
to the generated file. I had 1:1 chat with Paul also and he share few
concerns to convert above macros to be variable.

The advantage of adding another script is the other two scripts -
syscallhdr.sh and syscalltbl.sh are identical across all other 10
architecture. If we are trying to come up with a common script,
hopefully the effort will be minimal.

Yes, I can update the change log.

Paul, Could you help me to review this patch series and perform
the boot test on actual platform.

FYI, I could send v4 (clean one) next week mid as I'm on a vacation
couple of days.

Thanks
Firoz





>
>       Arnd
