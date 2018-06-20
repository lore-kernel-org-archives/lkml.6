Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CBC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F53205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WsNKLR8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F53205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeFTCCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:02:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43575 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTCCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:02:01 -0400
Received: by mail-io0-f195.google.com with SMTP id t6-v6so2034322iob.10;
        Tue, 19 Jun 2018 19:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUuWX4Cv/N/G0IlDB22wAs/eO61RaRo2Hh0SiVvV/Lk=;
        b=WsNKLR8WLJtsv/Zau3ADa9TMWxTYuDc+Q5A1Fgz9RlvS8mYt3bLYCGDEIUpgO39dwZ
         qC5I3C9EuhqdNlqBJj49QSfWr4wVvo4uQX/ZM3gFXNXAg8/HmEXx4WuVS/Mg6btgmraO
         Qa5G9jqOu3I51CieQPcEtGlMCdaXUO+J8dlJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUuWX4Cv/N/G0IlDB22wAs/eO61RaRo2Hh0SiVvV/Lk=;
        b=W4fuV+ki2PBbjftu3evFXHOAvgTDN5lakCZWdAk6FEv/TWp+XTij8tnsFfOcnJdZxb
         cuCgZyUiCFqM7LlZYT0b29u6HiIrKAxQYdzdkHKDnZ50IhE/7nCzjM16/ZKGEV6tSYQL
         CGmvnN2fyPZTbsKgyqwQhdoiPpZKXZ8jje1WGr0h5pDeok3FCkXJ0EbQZEDvUReg+82I
         zcMp0Of562VS5SstwwqdF5qGXvAnSs/z4oAZKFIbaLhDV3UKAGLtTsYM7Gbm/wyeVwbr
         pdKkktnzd5iEO6h0/pXWG+ZeVFZ6ab44ICw5L3TtEnhi49e62BEpf2TXfkyGgqjS/Vey
         zK4g==
X-Gm-Message-State: APt69E3eyy83HMNSQ4RgLyQLowwwmpwyg57CiCaAgJb2E+SdVryZCoUp
        aBwDWkNcFIoD4B+6A+TDs4c4pQjmZsxXaV28yw8=
X-Google-Smtp-Source: ADUXVKLVUeeiuea1cVLk2EhZm7WYp7iEieT1uVVeG98QkbOGGuVBEs7pORs/ERvXbyU44ikuehAkTlUliSciSTPMjCc=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr16465892iov.203.1529460120427;
 Tue, 19 Jun 2018 19:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop> <20180619005308.GA405@jagdpanzerIV> <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
In-Reply-To: <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 11:01:49 +0900
Message-ID: <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:30 PM Petr Mladek <pmladek@suse.com> wrote:
>
> To make it clear. This patch set adds yet another spin_lock API.
> It behaves exactly as spin_lock_irqsafe()/spin_unlock_irqrestore()
> but in addition it sets printk_context.
>
> This patchset forces safe context around TTY and UART locks.
> In fact, the deferred context would be enough to prevent
> all the mentioned deadlocks.

Please stop this garbage.

The rule is simple: DO NOT DO THAT THEN.

Don't make recursive locks. Don't make random complexity.  Just stop
doing the thing that hurts.

There is no valid reason why an UART driver should do a printk() of
any sort inside the critical region where the console is locked.

Just remove those printk's, don't add new crazy locking.

If you had a spinlock that deadlocked because it was inside an already
spinlocked region, you'd say "that's buggy".

This is the exact same issue. We don't work around buggy garbage. We
fix the bug - by removing the problematic printk.

           Linus
