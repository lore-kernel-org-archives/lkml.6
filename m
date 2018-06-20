Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4A120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fY6iK2ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4A120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeFTDiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:38:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36121 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbeFTDiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:38:13 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so3567164itj.1;
        Tue, 19 Jun 2018 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YjztxKYod3jBGTRxo1te4jqDib2Ua/EZN5M+U4/2X4=;
        b=fY6iK2EDm3uxs630evI97IyuPRArYZwDEBNduXuu9RhXlwqBo1cyJkaLqUElx9fHLR
         sZ6xeFo8nRIRqNIogeB1Z3uHwCU0GeGNR0M1/uYWpjNwH7/XrDyQJGX+EzPJH8oDgvee
         voBYwWsUBAmYd5+cpTFzFZ6W20rnXbAJMVHr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YjztxKYod3jBGTRxo1te4jqDib2Ua/EZN5M+U4/2X4=;
        b=EzGgrcyueaw8FE4UmNcirssnGDsc8AAXDyfDCy6O7TEN5uIu0yukDrJUipP57QSGws
         E3gJ4g0RTjLEIdTy/XxU3BnRRbrm0KzHVH1jTM4kZkQ1poU6PGwbsXYOWA/KZu1Uoo/w
         pUeLzJIEH1n6ZwvF2tZ5CJg9mM8v+3KzrdPdkA/uHpCPdKUhvnhufCOY01Q3zt/a0wJM
         x7NknAD6VaGTAxzaYWXikcWq17+wEZmCjwHzjyoyGHviWDaUCeDwq/TYuncvhLGV+aP8
         ELXeJFljDTkeQj19c1qrJWFujE+0r+xldMOt8j8GccaeYyRvhlO314MrtYRAEIP8th4C
         ZJMg==
X-Gm-Message-State: APt69E0nkKvVGGmZHAJXET+o3sQP4Hw86gq/MFUpIqzM1MiqU4AILmGY
        LPWofsAywmfHwXuywtKPo+6URlGeUzneVk7D6qc=
X-Google-Smtp-Source: ADUXVKK4PP1DfO3i4tPQq188jLvzIh1ZbPVP/ngIBWQWbapPXkZQbtDjqhZQy/s3UPwMVBR7/sIhJkNudrDqOHFzJMs=
X-Received: by 2002:a02:666a:: with SMTP id l42-v6mr16259059jaf.70.1529465893008;
 Tue, 19 Jun 2018 20:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop> <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz> <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180620025050.GE650@jagdpanzerIV>
In-Reply-To: <20180620025050.GE650@jagdpanzerIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 12:38:01 +0900
Message-ID: <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
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

On Wed, Jun 20, 2018 at 11:50 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> It's not UART on its own that immediately calls into printk(), that would
> be trivial to fix, it's all those subsystems that serial console driver
> can call into.

We already have the whole PRINTK_SAFE_CONTEXT_MASK model that only
adds it to a secondary buffer if you get recursion.  Why isn't that
triggering? That's the whole point of it.

I absolutely do *not*  want to see any crazy changes to tty drivers.  No no no.

                   Linus
