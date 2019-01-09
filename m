Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD253C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4DC20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwBtRJzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfAIDBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:01:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43620 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIDBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:01:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so6840724qtj.10;
        Tue, 08 Jan 2019 19:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqGhvalgUkJRqBGfha3b2X+nh2sDVtv9VqDdO6uweFA=;
        b=WwBtRJzC/qm/d+swZ4f82ncqZfFKjqqjrCeZGdumyLK8C9Y2RlBE+RMRE6DgOT6znb
         jqVo8Qq6oWqImyUFKU3naNqHjy3QrV/LZjuEF8qziQDgRG1nmdXpmXBG8a5uMNbglxCQ
         QdxDBTLbkaVMi8gwdym4NzNkITOEsRBboatwYmkiYb0YHeFwOBNnH1sEaiuzmgzWyXBE
         p+gV7+/twEv61BiFsYcvz5pSdB4OiXF5awm1jOrGdWANram+fKxfCSa8Y0fiATMYeup0
         NwBF7An4adbJX8Dt7EqBos1ogBsGFS2expxTP6z/G6rWdT7elqIm6ckjnYDmQ0d1Hk0n
         ZX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqGhvalgUkJRqBGfha3b2X+nh2sDVtv9VqDdO6uweFA=;
        b=RRD++kDRvDlpDIM/kLtTkFRp1kZXWfmLBUcYLYOLDQVBwna8fS40gqVO9HlA6CfEq9
         a/ntZEoz3xpmiR/mRF56AXLZN78UKztBWifhWD4VHzRNEZzeffwxPX4/YdXwyA+kU+2S
         0jSz5mKlsNWGJDP0yBJ/B/S9oWs0QdSbURJ2H4NsNXxKsT6v4nfBKad7FUgzKVHr6i+j
         WGe0OjRs4nD3BNkmKGsQxw5dH03rNNoNX6FR6JhPqMy4sIzd5MF9CvIvPhZRwU7SYbnE
         BCGOnGZ5n1GEb1Ge/goHkmnCqcygjhDn2k/ZH27vGm6cuQvcHBC4/3VixrK3C4tZ1sq0
         0Oiw==
X-Gm-Message-State: AJcUukegEWzD13/MZldjiY+sOnsPZO3vLlij7A15SpIuYEdjxZGpHDCD
        XZOypR4W21RTC+9fKgAZSL/X0lox++Gl93uo49BNdju+
X-Google-Smtp-Source: ALg8bN7zE20m57DcK8yfPCgDbI3v88OxGsKtquduRzKOrrn/NLySkBnqyi+0fN8SSWiFHcLiwNwTypd7MXay7fEmdoI=
X-Received: by 2002:ac8:1:: with SMTP id a1mr4003634qtg.366.1547002896329;
 Tue, 08 Jan 2019 19:01:36 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
 <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
In-Reply-To: <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 8 Jan 2019 21:01:25 -0600
Message-ID: <CALaQ_hpEZcHHjicnO3Vc8iFJyQQ1rS4GHk5Xd4n1wbt4897KMw@mail.gmail.com>
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I finally got one... but there was only 1 journal log entry. The
previous time there were like maybe 10 (also very little), but the 2
times before that had enough for me to have to page through the log.

I actually messed up on a variable in my script so missed the actual
time, but the trace still encompassed entries around the log entry
time when I copied it manually.
I fixed the script, tested it and have it running again for the next time.

GZip compressed the 1GB trace down to 43MB, but PLZip got it down to
19.5MB: https://1drv.ms/f/s!AkkOvekTOCrYn0kEFtJzreV7gCTD
All 3 files are from the same trace, but wanted to give you options in
case you didn't have plzip.
The journal entry (time): [501180.585516] computername kernel:
xhci_hcd 0000:00:14.0: ERROR unknown event type 37

On Wed, Jan 2, 2019 at 5:32 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> The event type 37 is a host controller event, most likely a event ring full error.
>
> So there are probably so many events that we fill the event ring before we can handle them.
>
> Could you take traces of this?
> Note that the trace file will be huge.
>
> mount -t debugfs none /sys/kernel/debug
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
>
> copy the traces somewhere safe once the error is triggered:
> cp /sys/kernel/debug/tracing/trace  /<somewhere>
>
> -Mathias
