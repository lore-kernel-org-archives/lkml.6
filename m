Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A027222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN6piFtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbfBMHOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:14:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43537 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfBMHOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:14:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so1441804qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZw8NWCkrIdQULVXmOWdgHLRCXLYmoCG/Pslju8tszA=;
        b=eN6piFtw2Q6HnufPjY72J8LCMiPfheSOO0vX1QyrHrebasssXsq+WRAElarFnJVkZb
         xNSt4BQvJMbsLx5fw076i7NhEStvT/9S0s5c3AQ814E0Yg4ckq51ppvr7duVEUGvoVJs
         /xQd3v+tQEHhZSFdEsjcA3XdlYcEbQr2adTJOZEQrrnozJAX+h6UCvo3mlOXukISP8tF
         VifwUqbC1muhDAy80KWU6yQwoDq3HPM9dcakDdSjBxazcqpekslEO3EwCEH0KegraMIk
         bVSnmSj/SbMMOa8R3oQ1aiQH01Qjo+w6g7FbZgFRdiLoZUJnhoWQH1whu2MyIqeA22t+
         wl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZw8NWCkrIdQULVXmOWdgHLRCXLYmoCG/Pslju8tszA=;
        b=Dwf8329Q6Vi3+FHPV5nPRvzDnbiTAexmrkEbwQXFhl2HOO5CNgMWHL4PGpmbs4snCd
         +bJb9qUnn7NkI6dnmSUAEhSve6w+EDJLgHxaQs0jzyZv1yfti39weZyLIhLcFvCk5UkK
         eQBi6l2hKeTl5v63e7FPKbW770Tuo0DVqvj8dFh+JFkBPPNEFyClYPjUwVraMBdToTot
         Cxngvz583m4e5xZGlYiQtXLd/u5DYMDbQrnBQjrcRumwpgP9wG8cEBF3mHlwEWcyEQuo
         FwBhjj6gSdEUSJ1pslZsrGUOg5aGo31t4i7tzs3tOtZcoyUoC+WjpogKeZAjFueC8u9h
         hxqg==
X-Gm-Message-State: AHQUAuaO7IE12qO/QgDFtPHIop4VBmhIRvaiXhF0MuIGC9C4nYhqSfzn
        3seqOAu92ZYSi2TjZaWNj9yIFgStY7vF2vJULWQ=
X-Google-Smtp-Source: AHgI3IaDpZS4pK8fpahEeY+9OaxChZxh38YNCp6r/0B0Xmup3F7Ghe4IdDFQ87XkDs42cljaGPSkRfgn9cNT+bwuEQE=
X-Received: by 2002:ac8:23aa:: with SMTP id q39mr5780306qtq.82.1550042084559;
 Tue, 12 Feb 2019 23:14:44 -0800 (PST)
MIME-Version: 1.0
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home> <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213062912.GA23233@jagdpanzerIV> <20190213063815.GA32272@jagdpanzerIV>
In-Reply-To: <20190213063815.GA32272@jagdpanzerIV>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 15:14:25 +0800
Message-ID: <CAH2Cfb8ENK6f1BKvD4oqGhRjQU6cU5ii_OREcPtjwZqP=1qAeQ@mail.gmail.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

But how can I precisely control timestamp on/off per message through sysfs node?

On Wed, Feb 13, 2019 at 2:38 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (02/13/19 15:29), Sergey Senozhatsky wrote:
> >
> > cat /sys/module/printk/parameters/time ?
>  ^^^^^
> cat / echo
>
> Works both ways.
>
>         -ss
