Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8325C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804B720877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakoman-com.20150623.gappssmtp.com header.i=@sakoman-com.20150623.gappssmtp.com header.b="djwQ/NrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804B720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakoman.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeJDX2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:28:48 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45144 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeJDX2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:28:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id g201so5735198vsd.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZEMuIbw/YmQqFwvz7bn2OTBd8jtFcXctfPp2y2a5Tg=;
        b=djwQ/NrPy311XOmQe7oXAET4J54SUONQwsGQq/H0Gq9t12uGPsbXmzSdPfCGzG79Vq
         7bnWByMFmdemwg/XgYXIUO1XoXr0OKkbxLTfI5Da1c2QLXdtaC0gaAGJBgSxkZAKqTCZ
         5NjFFB+gwOCYUsCf6qy9te0+r8/3njE1eqTAP0ByILfqSr+0Tn5gHRPSkEbybSeqVv6e
         Zrm3KCnd8vd6vF2PNmEzE9zjr2dEvjJPluApEdZigLD9BNsCpQd1tZoTyQj22gsi3Mzy
         QJvlJAYiyo+3ZSmFhw4Dp2bGcpY2KiAjPO2fTesUx/r/oN+Pu3S0fF9P16PpHvS2t4gD
         IKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZEMuIbw/YmQqFwvz7bn2OTBd8jtFcXctfPp2y2a5Tg=;
        b=qjlLFIIY/joWcUgXxWmVj5nUYd4oeAsGwFLNW0CndpBmKI8EXb7BW7crsvatUjtu3K
         xInZXG5o6wrGXW+t1RP9iC4XM+igEjdWhZgIElrCWRtY7X6IVUl0rUIdYTmBOs/NyRL2
         xRne5rzdm/2Fqa6PTfm5dGy7XB7RCgKQLmoZEgZHBhgYHg/QSbHMuS5Wa2eigAbz4wsf
         v1tY4WhA6Ly9TNfMQtHVuZfLxqsgWYT3z1dnuivnvfxIUtm8POUGKkCWJQJM8H+HAiig
         blqs52qr5MaBZGEMEYm6lh2whyC5whCx9pqrVxO72uD6/BSX5HBTOCSdNVGtqJQ8L1aW
         73rQ==
X-Gm-Message-State: ABuFfoj9hJxLSVfYYQ4YRbBaytvtPgnx7TFBxwhWEW+FcjHNhxjmZUZY
        e6Bf2ti7HiePS/veQXxnNoXQRwmPNFBTuY/lCcvfzw==
X-Google-Smtp-Source: ACcGV60gw0u42+7i/Jp3zRsi+lBSc5sWOt94bjLBwTyvjzPBxXLPbbCA1F4JWO5M62zhmyvHmtYRo2pkH/f5aTF7dB8=
X-Received: by 2002:a67:83d5:: with SMTP id f204-v6mr2775121vsd.6.1538670884444;
 Thu, 04 Oct 2018 09:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181004151501.280d8282@canb.auug.org.au>
In-Reply-To: <20181004151501.280d8282@canb.auug.org.au>
From:   Steve Sakoman <steve@sakoman.com>
Date:   Thu, 4 Oct 2018 06:34:31 -1000
Message-ID: <CAOSpxdYzm6fTd88gP_OdrTuqbf-kJr3t+3ObPU9vMCHqYJSgHg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
To:     sfr@canb.auug.org.au
Cc:     Greg Kroah-Hartman <greg@kroah.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        Eric C Gallimore <egallimore@ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting indeed. Who would have thought someone would be using the
"unused" padding variable!

How would folks prefer we fix this, in the referenced patch or by
eliminating the use of "unused" in samsung.c?

Steve
On Wed, Oct 3, 2018 at 7:19 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the tty tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_rx_enable':
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:138:2: note: in expansion of macro 'rx_enabled'
>   rx_enabled(port) = 1;
>   ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_rx_disable':
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:153:2: note: in expansion of macro 'rx_enabled'
>   rx_enabled(port) = 0;
>   ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_stop_tx':
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:165:7: note: in expansion of macro 'tx_enabled'
>   if (!tx_enabled(port))
>        ^~~~~~~~~~
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:185:2: note: in expansion of macro 'tx_enabled'
>   tx_enabled(port) = 0;
>   ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_start_tx':
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:343:7: note: in expansion of macro 'tx_enabled'
>   if (!tx_enabled(port)) {
>        ^~~~~~~~~~
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:347:3: note: in expansion of macro 'tx_enabled'
>    tx_enabled(port) = 1;
>    ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_stop_rx':
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:392:6: note: in expansion of macro 'rx_enabled'
>   if (rx_enabled(port)) {
>       ^~~~~~~~~~
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:399:3: note: in expansion of macro 'rx_enabled'
>    rx_enabled(port) = 0;
>    ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_rx_drain_fifo':
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:621:8: note: in expansion of macro 'rx_enabled'
>     if (rx_enabled(port)) {
>         ^~~~~~~~~~
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:623:6: note: in expansion of macro 'rx_enabled'
>       rx_enabled(port) = 0;
>       ^~~~~~~~~~
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:631:6: note: in expansion of macro 'rx_enabled'
>       rx_enabled(port) = 1;
>       ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_shutdown':
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:981:3: note: in expansion of macro 'tx_enabled'
>    tx_enabled(port) = 0;
>    ^~~~~~~~~~
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:990:3: note: in expansion of macro 'rx_enabled'
>    rx_enabled(port) = 0;
>    ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_startup':
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:1015:2: note: in expansion of macro 'rx_enabled'
>   rx_enabled(port) = 1;
>   ^~~~~~~~~~
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:1029:2: note: in expansion of macro 'tx_enabled'
>   tx_enabled(port) = 1;
>   ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c64xx_serial_startup':
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:1080:2: note: in expansion of macro 'rx_enabled'
>   rx_enabled(port) = 1;
>   ^~~~~~~~~~
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:1082:2: note: in expansion of macro 'tx_enabled'
>   tx_enabled(port) = 0;
>   ^~~~~~~~~~
> drivers/tty/serial/samsung.c: In function 's3c24xx_serial_resume_noirq':
> drivers/tty/serial/samsung.c:86:41: error: subscripted value is neither array nor pointer nor vector
>  #define tx_enabled(port) ((port)->unused[0])
>                                          ^
> drivers/tty/serial/samsung.c:1966:8: note: in expansion of macro 'tx_enabled'
>     if (tx_enabled(port))
>         ^~~~~~~~~~
> drivers/tty/serial/samsung.c:87:41: error: subscripted value is neither array nor pointer nor vector
>  #define rx_enabled(port) ((port)->unused[1])
>                                          ^
> drivers/tty/serial/samsung.c:1968:8: note: in expansion of macro 'rx_enabled'
>     if (rx_enabled(port))
>         ^~~~~~~~~~
>
> Caused by commit
>
>   c550f01c810f ("serial:serial_core: Allow use of CTS for PPS line discipline")
>
> Looks like a suprise from some "interesting" previous development.
>
> I have used the tty tree from next-20181003 for today.
> --
> Cheers,
> Stephen Rothwell
