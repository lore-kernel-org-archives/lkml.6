Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA52C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD392075D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKsEihHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbfBMNtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:49:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38826 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfBMNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:49:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id p15so1344090qkl.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZzUxIwwVmyGRTq67o/RmvEGq558xPaPNzxNRIq1QbU=;
        b=sKsEihHBuVPCradf+BqHQ5EgQt1TWsSdA2OJMuA2r/FuJDQh/DAlD5hmq9oOfVhf2/
         YsOKbcCfMgHfs0w5XS6AxFaIF64yhTe6KOYyqhiHhCCXCoQtqZqDKkoCiurNthEeohUO
         At13S8c6qfyiNmLoDe14cC0K1JoRWaacp16VTm0ZdiuTBymZxp/sDQoZXHwXlHzGIudB
         lQroSDyVuPUu6qps2PcgDshiJcK4P7UxV1p2cEtvWkYSo2FZt27yIsWhmyiEFyYWUA19
         8GCmDMT4LtDNsGm2MH9Z4eV0UhittrufxEvAURQrT9uromMuCWnpphVdW1qMOde0GXXU
         orJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZzUxIwwVmyGRTq67o/RmvEGq558xPaPNzxNRIq1QbU=;
        b=e0wqKDnMG/11uHtyDDgxbWxqQIgnJyxKp7UlITeAbH2RadOcLteRIxMUkyFRwPEp8e
         6I+h8R/UquW3TwrNyq357OAXVQfLYbFkrT1qoArgNyKZoML7qetA19CDkPaH24yJ6le8
         dXz62q6IGXbGhkibdwdUuCCmZ45V13bVw89SfJTpTxy3H3HBLFypF+dFHy8vjeQZpY6j
         sJ0/2h/v3venxfOCweL2l/zY0HeoOFeaWAIbk+EP/cAFeg/rh6W6YBaIZJAj8T9FxvlK
         97caS98G/1bAs6KzXQ19XdO3gNr/rrYV2rOj/YJ5AgQVYkDMLXRyaSiL5MvMV9t5XDfo
         4fCg==
X-Gm-Message-State: AHQUAuacs5d2WbyKJo5w04YJBUon8dCAjJB5HXajq+dAsTViLwHq01tv
        sLHbP6aAwACdCpWJBrCMsysB9k5wUsrGT389OlZC6na4kPs=
X-Google-Smtp-Source: AHgI3IaewYNZGvpOaF/1momf68+OU43kPGD0BFwZ/O9+W2O8K5wwigG1fyzEv2ZWSeKxeQpPTTu5m522t7Wno7hPQzM=
X-Received: by 2002:ae9:ed12:: with SMTP id c18mr442986qkg.39.1550065790242;
 Wed, 13 Feb 2019 05:49:50 -0800 (PST)
MIME-Version: 1.0
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home> <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213131912.4w3fonbgwjathpyp@pathway.suse.cz>
In-Reply-To: <20190213131912.4w3fonbgwjathpyp@pathway.suse.cz>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 21:49:30 +0800
Message-ID: <CAH2Cfb-5-ZxQPBTx_Gxt9kK3DqwTOS1Z6RVJ-ewMSB2-U0eTRg@mail.gmail.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:19 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2019-02-13 14:19:01, xiang xiao wrote:
> > On Wed, Feb 13, 2019 at 3:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 13 Feb 2019 02:11:05 +0800
> > > Xiang Xiao <xiaoxiang781216@gmail.com> wrote:
> > >
> > > > Because log may already add the timestamp sometime
> > >
> > > Can you be a bit more detailed on this. When and where does this
> > > happen?
> >
> > Here is my case:
> > 1.A small MCU(Cortex M4) in SoC run RTOS
> > 2.RTOS append timestamp to log for the accurate timing
> > 3.RTOS send log to Linux kernel when buffer exceed the threshold
>
> What do you exactly mean by the threshold, please?

The current algorithm is:
1.the free space is less than 25% or
2.the idle time is large than 100ms

> Does it mean
> that you use the kernel buffer when there are too many messages
> and they do not fit into the MCU local buffer?

The buffering just happen in MCU side, kernel don't do any buffering
except waiting for '\n' before printk.

>
> How exactly the kernel gets the messages, please?
> Via a kernel driver or from userspace (via /dev/kmsg)?
>

It's a kernel rpmsg driver:
https://github.com/thesofproject/linux/pull/177/commits/a0b7009fede5552dc98733f2996a8140bff62455

>
> > 4.Kernel call printk to dump the received buffer
> > So I want that printk skip the timestamp here.
>
> If the messages are printed by a kernel driver then
> a better solution would be to create a printk() API
> where you could pass the time stamp as a parameter.

Yes, this is a better approach and could fix all issues you list below.

>
> The aim is to store the precise time stamp in ts_nsec, struct
> printk_log. Then it will get handled correctly by any
> output, e.g. consoles, syslog, /dev/kmsg.
>
>
> There are several problems with your approach:
>
> 1. The time stamp is still duplicated in the output via /dev/kmsg,
>    see msg_print_ext_header(). We could not change this
>    because the time stamp is part of the format.
>    Any change could break userspace (systemd).
>
>
> 2. The time stamp stays part of the message:
>
>      + It might have different format than the normal
>        time stamp. Therefore it might be hard to filter
>
>      + dmesg might be unable to parse it and show in
>        the other formats.
>
>      + Kernel-5.1 will allow to print information
>        about the caller. It is supposed to be between
>        the time stamp and the message text, see
>        http://lkml.kernel.org/r/93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp
>
>
> Best Regards,
> Petr
