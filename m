Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FDC5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B537B208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9kobUNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B537B208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757340AbeFSUjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:39:49 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42628 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757248AbeFSUjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:39:43 -0400
Received: by mail-ua0-f195.google.com with SMTP id x18-v6so697548uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g65TXA7TDQXfLYuhYem8AHQr198ELtqoOZnVu8iH0KY=;
        b=n9kobUNv1VKHPnCPde77DwElNurDeBYmWCrKHHne84ABNou5hFUT1fB+Q3yJNjvf+w
         X1I6tYHAtmyuy23h2AAK+/eDv2QIaIslbn+ddR6Lcq4+8jBpInt43wz3b+6xz0gp7dhh
         S7w+QZ7i8c0v/Dsw12ZyerGdiv4IkPXluQj9o4RrpCFxTtY6MyzgSh1v6/Kw6tHw+5fr
         531d3E1YOtYn5CmsG7MlanTdEHHyFh0HEVKP3zz+HkECHQ1a9qoWEbo2TcVFD/s1sAfh
         qhNCyiLx+GVo1km1wwOhwWsBaB1hVwIA8cSoCKrGGdILTCBpljq8xGVXYusjnKGjM6I+
         fDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g65TXA7TDQXfLYuhYem8AHQr198ELtqoOZnVu8iH0KY=;
        b=EhzrEh3XqQsnG108ceYh7GetUiyhgAKQX+QiL40b3qPxqN8z0pAwlAz/sIf6Igfx/i
         eSgBjPgCIw8sI/ESIaV+vJ1VXlrOv6d25GjVoTN4S2tFcZw7IeiEp7cmyXOUNdpQFt3V
         j+xmTwhbZFFW+Z5mkI+k7VY4p3MQgyHqQAeHQihjcs15N+dM/OH+75ScEvfJc2DeALIL
         COo+bURnL01lVZZrlNxgKFjAYmakukwM6jFtwLT+EImljjR1Ccqk7OCQiRW1iG5YUe9M
         iNVNdsNGC9A3gTh3EBmLtwCn78F8HV7ee8ntLdIlve1L2uVSMhB9vvrkOJ+YHpQ7OyxH
         9/iw==
X-Gm-Message-State: APt69E1Xz85h9Am7P2EYeGh/Ni6hbdvYf/GuzBYR1eIH9Uycx9m+gYjH
        RcXDEXgikg1/qKTmJS9xSEqByBZ6WurEkRb/dC4=
X-Google-Smtp-Source: ADUXVKKuoSIRTEVyWObU7eWwl9jPHMWI+xsGCMzpj9svu89qY+ItorGt0hNuoQIMbWj5u84ptboxa+UYhaRmvBOnHl4=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr11569284uae.12.1529440783259;
 Tue, 19 Jun 2018 13:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:39:42
 -0700 (PDT)
In-Reply-To: <CAGM2reZR9iwUoBynrBRbjJAZ1D5WqAKdSzc=xQPWstXs1nN-nw@mail.gmail.com>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-4-pasha.tatashin@oracle.com> <CAHp75VdRxpSYJE17bjGvRAjCq5vjf23L=HT5oA6OhPSCzJJ0FA@mail.gmail.com>
 <CAHp75VdLoSDYvX6ZiRKJq0RRtz4nbkNwsjSFxbOsNeJofoUJVw@mail.gmail.com> <CAGM2reZR9iwUoBynrBRbjJAZ1D5WqAKdSzc=xQPWstXs1nN-nw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 23:39:42 +0300
Message-ID: <CAHp75VeJWuPyEZkzgbxZZriCaDkX9+ViHJ-X1NO0tofdDOMZLA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] x86/time: read_boot_clock64() implementation
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, prarit@redhat.com,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:23 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:

>> > > +               *ts = (struct timespec64){0, 0};
>>
>> I dunno if additional variable would be better for readability, like
>>
>> struct timespec64 null_ts = {0,0};
>
> I don't mind adding ts_null, but I think, as-is ok here,

Actually I meant presicely null_ts, and the reason why is that alias
is much easy to parse to get the idea, than to read entire "struct bla
bla bla".

But again, this is my personal point of view.

>
>> ...
>> *ts = null_ts;
>>
>> > > +       else
>> > > +               *ts = ns_to_timespec64(ns_now - ns_boot);
>>
>> But I'm fine as long as Thomas is okay with this code.

> Thank you for the review!

You're welcome!

-- 
With Best Regards,
Andy Shevchenko
