Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649694-1519124018-2-11799370641597441893
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
    t=1519124017; b=pWHyubA9u8/MM3CvondfdlvEo7ANeaCWlfM8xPZg1f6ZhoF
    MGIgsMlJbrNtu6UGNZGP96JKQmelFs50tnLR0kIJ8VteXAJWyAh/zarp4Sga9by6
    Jn9CShclRTMjPEB/briPKa/Iejdz5jNFU1UrI7HEmB6VVnMCXHNevfkUY66gAGGk
    GWmSNJ5rIbly4m9/zrZEwFI27UWtSwfYOco11CAPZgKwAJM9dt10Bku3LCKkM1yM
    UpWTTW/6Y1IFNTW7UCrnZEpIfQRuB9deRwy0xeFlAgaTY0779IUuKJC4bQiD96u+
    Y6YUmwUAaEab24gLFma66PTcVOGD7Ah7oofND4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519124017; bh=0oPw7LtQERREdsuYWPH+fY4xSuMerl65ebVLrb
    9iExQ=; b=l26AhdhtWA1/gJ52GhZIRp3OqSpnk4eT+I/+/9Gv3fehQvHsyK97Ue
    3qS3LnCjtPM8iP1JX5BVeUojHEEzfwEyJ9q71diIZR13Dg6YwEMkIRN5v+U7RkVT
    VzBxojTHqYdIBsJ0uvUMAL2x+4kZUWXAWNEREXtMUNgXb0eNvMSvK3BNgbWIdImD
    fZc/I35lmjtbjrwvNqjjTOFepTT+QI3fF/Aaugy7p5mWctaSddgx0UVBxLh/Pt/u
    rUUtqdho96tl3rhT4aMR8gDax8hYQ9ZLEcWCGAilH+lhU5Aq4rUZvlewgFsCZVoo
    jjC2pncoy+Ahg7wLH8em7M33r5AYV/eg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YpnKATsH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F+gN1G1b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YpnKATsH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F+gN1G1b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeBTKxf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:53:35 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44532 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeBTKxe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:53:34 -0500
X-Google-Smtp-Source: AH8x226KieWqe8TrgOp7k8EweylUIoUecHcdZhL1DcjK4Cz/+Kxi9qutkbU1CJMEGwRFyRUHQvM1SCKgTSbPChw6MIw=
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-9-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be> <1519119624-1268-9-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:53:32 +0100
X-Google-Sender-Auth: odXfEiv_bfHQkr8Sa5l0fa6_QfQ
Message-ID: <CAMuHMdUymMioYc=ifKMZEZ8tU+D=JXH7b+LsLR4d_EDhbEPkcA@mail.gmail.com>
Subject: Re: [PATCH 8/9] serial: sirf: Fix out-of-bounds access through DT alias
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
> The sirf_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: 66c7ab1120585d18 ("serial: sirf: Fix out-of-bounds access through DT alias")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: a6ffe8966acbb66b ("serial: sirf: use dynamic method allocate
uart structure")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
