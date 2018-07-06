Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E131DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E20822AAB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYWFwjvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E20822AAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933763AbeGFQtM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:49:12 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39043 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeGFQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:49:11 -0400
Received: by mail-vk0-f65.google.com with SMTP id e139-v6so5703002vkf.6;
        Fri, 06 Jul 2018 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uoq+9eaRh31rsmOWQakLZnRhbNgrp+HyXztSn+oSv6k=;
        b=gYWFwjvbX6CctjgeLemurze2n0lurcDgcU3g1DRXojDQROfmepQT5Aq4GGrMcuMTDq
         OrJ7+ayVU1xdY2yAA3k/SiWSQAym68tYIgBm/aUuVhim0nzsUyE0y7OAPjspcqMQ6bnZ
         ZU+ohZCAbHiWn0TB+B+QoV2/2Xg0YLVZcWY3N3SXXqn3U5lKWFDRJNIUoVjTfV04rn1b
         7OMVOkArkpxuR4z97151LjD+x7okeT7JKGs9DAH0dGmNYP82LomEXbilmtuuNDsvh3Jp
         0wvXMlcd9zHbbN9LAYvGQM0x4vGMPgRFY2czPZpyNQn1fbbZAuJCAbk6egyvNUi5UXyY
         UOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uoq+9eaRh31rsmOWQakLZnRhbNgrp+HyXztSn+oSv6k=;
        b=gve+R04MJmvrIIp6dh8r4dc1tOTKTNNNIy2tLzsBQ2zgb+bL4wSReq4e96+nqdXprf
         Tl/jajRH9obZY9jnlNWffa7MrMzNsoCp7/qHvTK3CjSZVo3zAsvVOeyBdCE9/uHlWwUD
         OI93hyrWZ/uriE7ypYW4G6qS48Bqd/yYmgyZ4nYMIZtVafJ8W8mdp2GuIjNkcbA5QJf9
         E+pTN/YxUlaB5b8Oh0z4GneTBQ4wTt9fup8EpQkhwSr0BaFIl/1hPg1HKseeAA9v0YeN
         8hU7e1oP6EBWsOCyxlJPECpbYaYUZqt4qsQWn6dh0QhixoKUIJlWYVvvJ4pdo2kIagTq
         LMxg==
X-Gm-Message-State: APt69E324+YvyIp+lBenwtYgOAnPFv4GlIc+tlooOMnWLhvCTA/wgzra
        xBTlQJoUoDdEnZgwGKYMRjyNk6kaXmZgzVmDs1MfAA==
X-Google-Smtp-Source: AAOMgpcdYAYlQg1m568Jd3n7hYtqPeIqy2GfxoiXMCJWLqxnN2AqdhogFzFxCaTdt1jMf0DRUW1lk6W6w7ufaTAfGoo=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr6173846vkf.26.1530895750526;
 Fri, 06 Jul 2018 09:49:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 09:49:09 -0700 (PDT)
In-Reply-To: <20180706162457.20489-1-tycho@tycho.ws>
References: <20180706143919.GA2344@kroah.com> <20180706162457.20489-1-tycho@tycho.ws>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 Jul 2018 19:49:09 +0300
Message-ID: <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and uart_shutdown()
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:

> Looking in uart_port_startup(), it seems that circ->buf (state->xmit.buf)
> protected by the "per-port mutex", which based on uart_port_check() is
> state->port.mutex. Indeed, the lock acquired in uart_put_char() is
> uport->lock, i.e. not the same lock.
>
> Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> last chunk of that function may release state->xmit.buf before its assigned
> to null, and cause the race above.
>
> To fix it, let's lock uport->lock when allocating/deallocating
> state->xmit.buf in addition to the per-port mutex.

Thanks for fixing this!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Some nitpicks though.

> +       unsigned long page, flags = 0;

I would rather put on separate lines and btw assignment is not needed.
It all goes through macros.

> -       if (!state->xmit.buf) {
> -               /* This is protected by the per port mutex */
> -               page = get_zeroed_page(GFP_KERNEL);
> -               if (!page)
> -                       return -ENOMEM;
> +       page = get_zeroed_page(GFP_KERNEL);
> +       if (!page)
> +               return -ENOMEM;
> +       if (!state->xmit.buf) {
>                 state->xmit.buf = (unsigned char *) page;
>                 uart_circ_clear(&state->xmit);
> +       } else {
> +               free_page(page);
>         }

I see original code, but since you are adding else, does it make sense
to switch to positive condition?

> +       unsigned long flags = 0;

Ditto about assignment.

-- 
With Best Regards,
Andy Shevchenko
