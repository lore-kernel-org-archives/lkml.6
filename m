Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE074C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="DAzmUc/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfAPSkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:40:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43670 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbfAPSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:40:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3461691pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIyuPks/WGV+kSOuibV1hRX/RG5e3NayXJi0jgd0Yd0=;
        b=DAzmUc/P9EAoHGBxRnG5TXJHlvMmXETUQpNdPquBETb3eLOPxpHWXN+V1AOCOP7Iyi
         vPWwGrLZ0rvV0Ep2YY5cnQNCLI3LdhpNJZZct27W4SKsd9ca36tW3FcgDBO35E9TGAdW
         DdldUI9Y6LQEYiGS2KIhz5ZC94+bZwejl0PPwpuDNcAG0Y102uAxY7TlTImEIjdsXtds
         z08a6+P1friOWLEohNDd7bzq88/Bmh1jVna4QbDBG0LeAa1a0YqQXadoAxFsr03nC2Iv
         i6E+R51sI0WzvlVud0XtvoJJpeDw+3Mj6HpM5IPgY1xjNYK3AQ3q3KL2VoEgKq8vdRCg
         Mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIyuPks/WGV+kSOuibV1hRX/RG5e3NayXJi0jgd0Yd0=;
        b=l2Ggtc97kdR3JD8GC27HW0JDhRIwgQvo1bjxn6Xhrrv/pCm1oEHwFarLbeWqB1YJun
         wigRu+YqIZWfw0ypVFzlKuJgcKjbY86N0KT7S1WwbFERXUmW/c+sHG0VGzyN6nHdYJGq
         mB5NImGm083CxVdqlRLxf7hJvuGtrhxMplXRuJzSMvXUppXmB7XNtCJR5uMX8Bnioi9O
         UsibeaMr0OZ8gEn1TuIPiaL6kkXX2579IXTftNaa66OH6v2LJEZ1ODBoFvzy3i93TZe3
         qpNsFxKKORYvFqrxfJi98cae0gljD5Uj/6HCojswVQs1AMsTwlI6V4qVAMCOxsAHeLuT
         21uw==
X-Gm-Message-State: AJcUukfqYxpszQ42FUA+sWw4w8xvsK9LI7hA2b11yseQ9kCIgihKjNDA
        +0VWSwWp8hVgAHZE8keXqgN28w==
X-Google-Smtp-Source: ALg8bN74aKWrlZ5d/KXkSzovgSdXj0Djizb1oF+8It99db1RNfrGA760zzg/AjeK4yQn/2QeG+B/1Q==
X-Received: by 2002:a65:610d:: with SMTP id z13mr10317160pgu.427.1547664010914;
        Wed, 16 Jan 2019 10:40:10 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c69:9cc7:f9cf:ff1b])
        by smtp.gmail.com with ESMTPSA id v13sm8601079pff.20.2019.01.16.10.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 10:40:10 -0800 (PST)
Date:   Wed, 16 Jan 2019 11:40:03 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     samir@embedur.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.co,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uart: Fix crash in uart_write and uart_put_char
Message-ID: <20190116184003.GF1642@cisco>
References: <1547663287-4890-1-git-send-email-samir@embedur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547663287-4890-1-git-send-email-samir@embedur.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:28:07AM -0800, samir@embedur.com wrote:
> From: Samir Virmani <samir@embedur.com>
> 
> We were experiencing a crash similar to the one reported as part of
> commit:a5ba1d95e46e ("uart: fix race between uart_put_char() and
> uart_shutdown()") in our testbed as well. We continue to observe the same
> crash after integrating the commit a5ba1d95e46e ("uart: fix race between
> uart_put_char() and uart_shutdown()")
> 
> On reviewing the change, the port lock should be taken prior to checking for
> if (!circ->buf) in fn. __uart_put_char and other fns. that update the buffer
> uart_state->xmit.
> 
> Traceback:
> 
> [11/27/2018 06:24:32.4870] Unable to handle kernel NULL pointer dereference
>                            at virtual address 0000003b
> 
> [11/27/2018 06:24:32.4950] PC is at memcpy+0x48/0x180
> [11/27/2018 06:24:32.4950] LR is at uart_write+0x74/0x120
> [11/27/2018 06:24:32.4950] pc : [<ffffffc0002e6808>]
>                            lr : [<ffffffc0003747cc>] pstate: 000001c5
> [11/27/2018 06:24:32.4950] sp : ffffffc076433d30
> [11/27/2018 06:24:32.4950] x29: ffffffc076433d30 x28: 0000000000000140
> [11/27/2018 06:24:32.4950] x27: ffffffc0009b9d5e x26: ffffffc07ce36580
> [11/27/2018 06:24:32.4950] x25: 0000000000000000 x24: 0000000000000140
> [11/27/2018 06:24:32.4950] x23: ffffffc000891200 x22: ffffffc01fc34000
> [11/27/2018 06:24:32.4950] x21: 0000000000000fff x20: 0000000000000076
> [11/27/2018 06:24:32.4950] x19: 0000000000000076 x18: 0000000000000000
> [11/27/2018 06:24:32.4950] x17: 000000000047cf08 x16: ffffffc000099e68
> [11/27/2018 06:24:32.4950] x15: 0000000000000018 x14: 776d726966205948
> [11/27/2018 06:24:32.4950] x13: 50203a6c6974755f x12: 74647075205d3333
> [11/27/2018 06:24:32.4950] x11: 3a35323a36203831 x10: 30322f37322f3131
> [11/27/2018 06:24:32.4950] x9 : 5b205d303638342e x8 : 746164206f742070
> [11/27/2018 06:24:32.4950] x7 : 7520736920657261 x6 : 000000000000003b
> [11/27/2018 06:24:32.4950] x5 : 000000000000817a x4 : 0000000000000008
> [11/27/2018 06:24:32.4950] x3 : 2f37322f31312a5b x2 : 000000000000006e
> [11/27/2018 06:24:32.4950] x1 : ffffffc0009b9cf0 x0 : 000000000000003b
> 
> [11/27/2018 06:24:32.4950] CPU2: stopping
> [11/27/2018 06:24:32.4950] CPU: 2 PID: 0 Comm: swapper/2 Tainted: P      D    O    4.1.51 #3
> [11/27/2018 06:24:32.4950] Hardware name: Broadcom-v8A (DT)
> [11/27/2018 06:24:32.4950] Call trace:
> [11/27/2018 06:24:32.4950] [<ffffffc0000883b8>] dump_backtrace+0x0/0x150
> [11/27/2018 06:24:32.4950] [<ffffffc00008851c>] show_stack+0x14/0x20
> [11/27/2018 06:24:32.4950] [<ffffffc0005ee810>] dump_stack+0x90/0xb0
> [11/27/2018 06:24:32.4950] [<ffffffc00008e844>] handle_IPI+0x18c/0x1a0
> [11/27/2018 06:24:32.4950] [<ffffffc000080c68>] gic_handle_irq+0x88/0x90
> 
> Fixes: a5ba1d95e46e ("uart: fix race between uart_put_char() and
>                       uart_shutdown()")
> Signed-off-by: Samir Virmani <samir@embedur.com>
> Cc: Tycho Andersen <tycho@tycho.ws>

Acked-by: Tycho Andersen <tycho@tycho.ws>

Thanks,

Tycho
