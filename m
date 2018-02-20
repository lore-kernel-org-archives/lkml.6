Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649693-1519123879-2-16253405637761870037
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
    t=1519123879; b=SgKAVCEPYw/T3UsLDMi9eGitdpknX7OS+2FMzN1rY5fDC07
    AeZIBDOEAMTiIAMLNBm2uNtvyiEzHwj6XMJHA+35FThWaKgZu00BjE3TavRQoh2b
    2xhxr5EruWrx1NFfqBUHyNhg0BfcRyi0EU9DKn2Hnl5Y2MhVqqg0NKRyWwn0r27L
    5ybpaVgXd4mABkZ7IeE+3DHf6lCr0WCnB25miRJAWQqlEEYW0dH7bOlrTAoIdXM8
    whKddm0ZVj2xPuMj84RUZiw7leOnQoI8AWxbiDhixWzgye3DrkobLn5DDtud/vE7
    NoH19IrXX7L5oQ4o4rRWtDnci4Zr7vAy8uDYd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519123879; bh=jduOt1fwHYipQX/HZ+fmTFxniDCien0KW7ujvl
    I45J0=; b=JijsuzW7HwR41I0ISk9+S+QiZ4V8oloYKtK7uEMGeGmIY/JVtprhTI
    U6gbxBVtUTNier1Mxuy0ArSrnUP4mWrEX8gZf42AXJI2MrvJS17w6qz4YkKZoncl
    3R0gDY3eWL7MU0OLdi4rFZ44rSQ4JlLUEbmQfSqzg/RteEc8BdwrdbqoUqLnHvJj
    a28NCv/DydcZApfnPScOUNiaqBzmO7LhmUVlw2G5wkf0Jf5c5yBPueXv5zXCohTg
    p1olJ3SiZEFuVBC2MUyGb6pE4hiHnI11bW64xByRIvquS24eO8G0OvPsqfKRuSF+
    eB4cMjaeJTwWPk/RLbz7ZZbnDnI28W+Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tss+16Bv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QLyZ0Dzi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tss+16Bv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QLyZ0Dzi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBTKvQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:51:16 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47040 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeBTKvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:51:15 -0500
X-Google-Smtp-Source: AH8x225pjrO9fla/L3VouC+i0EjCEfsoKSkDQXAKcfBj4VOMp/Jn4yOLsoCNYICDgLsQrDDeosKIiAkybefY13cO0vI=
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-3-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be> <1519119624-1268-3-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:51:13 +0100
X-Google-Sender-Auth: XZQRRkld1hCVNt0V0jMW-ysSM7s
Message-ID: <CAMuHMdXrFQbopFKipo0yGejyayHXWXy_t50ZDJMbn6dj04LtOw@mail.gmail.com>
Subject: Re: [PATCH 2/9] serial: fsl_lpuart: Fix out-of-bounds access through
 DT alias
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
> The lpuart_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: 970416c691dc68b5 ("serial: fsl_lpuart: Fix out-of-bounds access through DT alias")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: c9e2e946fb0ba5d2 ("tty: serial: add Freescale lpuart driver support")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
