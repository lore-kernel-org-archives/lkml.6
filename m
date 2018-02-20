Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649694-1519123830-2-12442196768017527535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519123830; b=HD3LmJghKFKQGESGhUPDOPrHNlGqRHWdRg7faiFy0UUHl3n
    IJ3B+TlaMEmQLqFZtheyeTJCvwzS/3/zTAnkJ50rI+3Vv1kknUK3DMTI0dnhewtX
    8gENnX2iiurTEmgIfY9Pn8/dsLvumVDMnRbHWAWbUIN5OsnblDgJk52LJPyDURa/
    Jbgag09FIo+EtQfr1WiRGeyaYsAqxrz4qwVwyyozGCnG17xWIY8LnJC0LVmTCki8
    XLLyC2xzPu6ExBnitJrY5l9PRgQqsEcrwU2uT45r+Z/Jav19ORTTFCWHPuWVN0jx
    LXpvxUh+CcmO9KkwQZie8bKbYzFT+twLigy4MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519123830; bh=JJPyP/XlUL/yf7ZZQF2tfyI5kdI+5tNKTe9BBf
    uMfjo=; b=F/UwHPLLJ0MS3pQKEfduYzhxCuJvzhQuft9BxF5Az4VA0qiWKqejy9
    d5ICcaBJHBfcePLtrE6WtjUf88ys4A3zKHGp87arOlR/K9TJT/7YNNHNaklz4RM/
    xZ06StHBbGklXtG9LaoFrXwS0oBt7q6aDEJFcjebK88p/mzAKWM5oCI5cOrZPVli
    bv0uiTpTAbiH0EOC2DTwC8lO8vaRw67+2qbhtQsc2l4u7vz868RKRuq/Pz+j9aVo
    PPV69RoWfc60ilb8CaHFmuPJqamDMyz7K5MA4JkyXfA6GGevfRU2V1o80FXqtXR0
    YgVQCj5gfiKGjunILGQ0R4YrwVpEOsEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RNCjzYsE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KjOccMO7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RNCjzYsE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KjOccMO7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBTKuQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:50:16 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42357 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBTKuO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:50:14 -0500
X-Google-Smtp-Source: AH8x226e8xod+n6bGtwZ7h0QoparQN/cTqxdnao77Gtu3yQRvX4eu3w2euO/rEbTnu7kwlBSDwtQgYATWhxZ4qoxUAo=
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-2-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be> <1519119624-1268-2-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:50:13 +0100
X-Google-Sender-Auth: l9g2qwW_ZwsrKpCgfLbKuno9ExE
Message-ID: <CAMuHMdVVzK9Fisi6yjXq8ScM1QzBgm5aaV4QgU8Q=3b+_78Anw@mail.gmail.com>
Subject: Re: [PATCH 1/9] serial: arc_uart: Fix out-of-bounds access through DT alias
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <baohua@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The arc_uart_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Note that the array size is defined by a Kconfig symbol
> (CONFIG_SERIAL_ARC_NR_PORTS), so this can even be triggered using a
> legitimate DTB.
>
> Fixes: 10640deb04b7949a ("serial: arc_uart: Fix out-of-bounds access through DT alias")

Fixes: ea28fd56fcde69af ("serial/arc-uart: switch to devicetree based probing")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
