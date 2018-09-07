Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4321C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f93XVwxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4321C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeIGUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:40:26 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45952 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeIGUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:40:26 -0400
Received: by mail-yb1-f196.google.com with SMTP id h22-v6so5610884ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6DbOPasXmvvA9ax5nixZ9FIEYbBx/6YMibqhBygSp9Q=;
        b=f93XVwxYDC0VkAqFfh/qlXeZxa4M+lp9A4kDGMJ/gztNLn68wr3L8k4Q/NRPZzcQe+
         BJI9Ju2d0P4dktV+lMPqnQHvuc0umzIxTpASQri9WkBglL2mUjTnk0fdw41sifG7VGwE
         ft7y3MGqk4LzYJeNj21q2YwawP479wI2tKM7Fj1mMb+N9r+HX5zmi8MIZHiuzdexaShm
         gpNALyF8Xw3t5gLaP02YFS1OHaxCMGcvzuun49J1jonuHOk9tcRNjj9uHFKg2HkFvw8a
         xDVXmii86iSD2rqb8iNKt6JP10GxltGcnoQB1XPObryvDeX1YHv0U/oKXzTIez7NEaLM
         d2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6DbOPasXmvvA9ax5nixZ9FIEYbBx/6YMibqhBygSp9Q=;
        b=J7VqVNY1wd1fBw1aJbDT1oqqbTY01k6se+upR8SRk2ERDF2LFAv9Edsxlv8JUqYbCr
         cobgckBH02cxNAkZnumkQsIRo7ivCuqwl8vTSSr1Cnty7xQmK7/ArpYnpF70CeR0v5ep
         h112rbYW//Q1+rYFwZzbwkqGl6plL9ayZUMfnaXH0y8zWnw2DOtJAdl9O7QVhYu4Sk/v
         Jr6Bsl1yoT+KFhtFnECAairE6cWAHEjxVBlTkivDinAJBERsGBUtPDQ+zJ2R/iNf3X8K
         8+rDXmmNqsjCN993fi2j7zTmYYy/ffIcDLcuoh2Y+Sni5JCyYmMFCHT61SXVrZrRFro3
         npRg==
X-Gm-Message-State: APzg51AvIz1aoq+vbvqj/DCjuOHTNdtg1GxcP+axRfF6KzG3zk7bmJTo
        0dDj2RQ8+CN7/UCj1Z+xknP/JZC1CSTn/eCRnKUeWQ==
X-Google-Smtp-Source: ANB0VdbXFgRN9LiGFnvcfASoFe//CiTmNKSmA89kFRrSi9bkbBGQ+GjGXJ6GVz+d5NYZws9szyIuHa60FYfAd8+CK/s=
X-Received: by 2002:a25:5c87:: with SMTP id q129-v6mr4465999ybb.403.1536335932287;
 Fri, 07 Sep 2018 08:58:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 08:58:51 -0700 (PDT)
In-Reply-To: <CACT4Y+YszL5gXBqz041i1WZW4nifK3tQ35sAH6t0GuGxLp5-VQ@mail.gmail.com>
References: <000000000000edab9e0575497f40@google.com> <CACT4Y+YszL5gXBqz041i1WZW4nifK3tQ35sAH6t0GuGxLp5-VQ@mail.gmail.com>
From:   Kees Cook <keescook@google.com>
Date:   Fri, 7 Sep 2018 08:58:51 -0700
Message-ID: <CAGXu5jK=upmx7Fx+Y7vFJXz7aYvvd7WxXhOYk=746tpmafZDug@mail.gmail.com>
Subject: Re: BUG: bad usercopy in __check_object_size (2)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 8:19 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Sep 7, 2018 at 5:17 PM, syzbot
> <syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
>> git tree:       bpf
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1618ac21400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=62e9b447c16085cf
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a3c9d2673837ccc0f22b
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com
>
> +Kees, looks like false positive?

Basically, yes. CONFIG_HARDENED_USERCOPY_PAGESPAN=y should not be used
-- it's for tracking down these cases (not really for general-purpose
"debugging"), but no one is currently working on solving them.

-Kees

-- 
Kees Cook
Pixel Security
