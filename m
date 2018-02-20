Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649694-1519123927-2-7095477927210363414
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
    t=1519123927; b=j/jsL7YuvfNYz1EO7JtnRQIQxpAhNHP5penaJ24E34Y+rJE
    N8fXV/v3PPM2FKZ/EV+1RNrwnI0xyS+u0mk9hntb7qSbiJjG8D2D1cBdUg2q9vrX
    q9L1uR9wmiKPD4gx3yEqyyY4n7GyCgcvzggg/3hBA1QDVpMRqTk9sXPD7WklDGgn
    5u5I6xI8K21ijIBU38Gftdp5C9F4quGXnr3mJ2xIKyJ81N+XMZ5YE4qqggJ7KXFc
    SdJdhQH73+NDsz7kPvq0uHBwgUmB/LB5MOhtcQgaAwfoa+M9Gg4HWn665RCIxZAz
    QsnF7QbZCKMkEpRROgpgkflBEMQQVPrGL1+J66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519123927; bh=GDUtMNmf3X3aJFd4wPE8EBlg7hJarjfesi2SHa
    ewzno=; b=lmZHnc+2ajW3ABiw+643T7uA9ruUukmJmqOOA9I0qrUEKu7HqWIEm0
    yNxP3HZiPueJfQA4Rr3BvK4AW9sZ9+8y4xmvljM9ttCWg1pXyP3SFk72sXW1yf3N
    F+k4H94MkW8c+poD8bKmsrZcHY6ZYEvqSVmTkTpWsRCCMiQ5pIxk8lSu0vdurvh1
    kBIE8/Gv3Ah3/Uy415MIFkVXbHqXRJY6gqelUbreWkVfXyuVmWvfPBaxMatRHiCX
    0XgNCYXdWWhsZYR/2zhkBICt0PI8D5otp6bn8976MzXKXTya0Cpeq1BdiMupI86V
    UFJ+XjLgWbpQO2e1xzZ4mGtd/9L36LbA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D1qtQpNt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WwZfuowI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D1qtQpNt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WwZfuowI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBTKvw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:51:52 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33170 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeBTKvu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:51:50 -0500
X-Google-Smtp-Source: AH8x226RFw/wLvrqgiocUJLcZZFuyx3A6VYS6xgb216HZWTxDiyjVnc7f0zOfc7R8hgfkCpawuTheun/zvPgwFpoAM0=
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-5-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be> <1519119624-1268-5-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:51:49 +0100
X-Google-Sender-Auth: 7D-C44TZR4ocRNL7jFtFu14MSzo
Message-ID: <CAMuHMdW8LHTd4q9q_pL97W1vtM68x+Fep8QjCx_O2sNre1CNng@mail.gmail.com>
Subject: Re: [PATCH 4/9] serial: mxs-auart: Fix out-of-bounds access through
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
> The auart_port[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: cabf23e7aa00b145 ("serial: mxs-auart: Fix out-of-bounds access through DT alias")

Fixes: 1ea6607d4cdc9179 ("serial: mxs-auart: Allow device tree probing")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
