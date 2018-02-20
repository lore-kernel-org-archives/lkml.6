Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649694-1519123992-2-767123958560187708
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
    t=1519123991; b=ARoUQbX9/w1vhz/GURKjtHg9KUBo/SI9Re28wbLnL0m7mBx
    NPKhu7G4yeXWF6l0dMdnSqMUBQqkBGyzZDYKSyUtJuRfiUB4+cJhE9O68qavmcs0
    SRLkMKuzjEf7WywkIH4zgBO+ZUjDbB99QFlBFPEw5oiaqQdjn2FJGDh3XOzf1Wyf
    8oXUZahtz8ArTy0ViMgZ7r6kmR4WY9hJ7xpWq3izom0UpfnheXBsmWY1WPAgSOw1
    jG8B3mehkXntLwnaYKnjebmEDvdQAZ/0yxVO+eVhR/zrPZIhdlbu9NaejiITO3xV
    jZSp3k7gkYPywb2kJME25fmaJnwU92GNK7MdN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519123991; bh=kL+WmWLtcdLHheMmFNNTMCvsje2fLV71wWa9uO
    K6F5c=; b=EoBFbOptHpWluZ4brnN7kU3IiFTyjfHpwQsH4nobwJeKAPv0W90YkD
    qcZtAQ4Xvt6CcaGqkSunrQkkssHpe3tIGi2H8DrNyOzFxS52lbCC7uBEb5F1bFpB
    rtd3JgEtoNsK17BpquwatG5dCC/Ck52U2YQt35OlOl7jwmAxA2uq2yM9NYE8daMB
    bJleOcsiwav57pZVpNWLr7RBO7HbwLLQ9xpScrjGctLVKVIRGOJ/wGJxze/2reh8
    +sXRU0axWUWEQ3sjrkF9KZH2igRKqkZp4hKViprFNdlmpq7Ei0/katNxMMEPuUn5
    pB/8VfWGLD2AWs2eDogb0/Y+oXqpqaLQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F5OtZ/RL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GtVjaYN/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F5OtZ/RL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GtVjaYN/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeBTKxI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:53:08 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38219 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeBTKxG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:53:06 -0500
X-Google-Smtp-Source: AH8x226E0vWspbV6E36wWDkFknK745sfNqupnZF7SHOrZfgzT7XQf+aT+H5GEhLHC9NNYDokJorO+emNTiS2dR9gReQ=
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-8-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be> <1519119624-1268-8-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:53:05 +0100
X-Google-Sender-Auth: hxp9mGt_vzmqjQAfw_MzJt3_6R4
Message-ID: <CAMuHMdVqoBC0oD+JXWJU_p5KJy7adZj681rwxYFYj_L5kwD=ew@mail.gmail.com>
Subject: Re: [PATCH 7/9] serial: sh-sci: Fix out-of-bounds access through DT alias
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
> The sci_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Note that the array size is defined by a Kconfig symbol
> (CONFIG_SERIAL_SH_SCI_NR_UARTS), so this can even be triggered using a
> legitimate DTB.
>
> Fixes: f650cdf1c115498e ("serial: sh-sci: Fix out-of-bounds access through DT alias")

Fixes: 97ed9790c514066b ("serial: sh-sci: Remove unused platform data
capabilities field")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
