Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649694-1519123967-2-15953980438861634999
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
    t=1519123967; b=Y+2lhujVQRg33LIiHaj3cLpMogN1PadBYoHJEMTtcnhGrm1
    qRMynNe/D9DpDvE9M89fawMwJtlBIu2CEqZBC516+uZr9WuUWVIYOkuXxIbPyzOc
    LcodRhSF/iWlbqEpQcDn1msiA7PsGi7cCVYJWhBdHR3HU3c561KriCKoVwsJHku6
    /xh3jXFdeW8U1Ms4tVGwrud2jgk9boOl8b20PJFUoGCszZu+9tPvK0J7/gEo+2x8
    cCXzyXwTuZf7BkOgdl700/M2q8R8c6f3NiJx0J6DSecioK6hWrzVeR0u7MiSTlDN
    plGoK+j8K/j/XL2HE5TrWFmkhPpQdhe8pTw0D6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519123967; bh=Xj4zQtkGG5XnrtUBgI36rSkSLRE2CVFM02yYmv
    FY/FQ=; b=vg1+/K+D0F6DWA/wBoRZ85Z6fVTQo9O2asTLE7Kqo3zOzbsjTwTqdZ
    vfqhJ6m6CWq7eHkXejMcKswtXfeJ2Gb8jvgW79reD3sEh70OpUOHwRURG3wodi5d
    KnbHBE2b1yqpyQsPMZ54yfFtThqdQPHwUaB9TCGtRnLzMNe3iLDP1PRJBzbz1pHL
    INOX276lNh1fnjDLBkv31eiGGTpGx51m62mUbpTge61F/ZsaxTYtAbI0nKkEIOtC
    OxoS4xbtBnAcp3oyZxDjlZezKxgp1w9F0gA4dOMLalqixPBUhbH+VlS/gJ4xNdvY
    6K4MzSadyytqFIDDYXUa8+BoEPB0cmYw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HTzy33mj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jxLqqWak;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HTzy33mj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jxLqqWak;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBTKwq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:52:46 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35368 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeBTKwp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:52:45 -0500
X-Google-Smtp-Source: AH8x226QghhxAAoKSqQDk3TNhmACkcEi9KZXxpXiy3C+lBwMzlDMbW5We0zu19naZNpwEcnvouefvtRwt/CGEtjhSCU=
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-7-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be> <1519119624-1268-7-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:52:43 +0100
X-Google-Sender-Auth: 3IqkSuFC1T8X9i6BEHgxmmLBtN0
Message-ID: <CAMuHMdUPb8cubv5v7OD4qHokwk1tPScNkju0Tizwm2sOFpcF3Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] serial: samsung: Fix out-of-bounds access through DT alias
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
> The s3c24xx_serial_ports[] array is indexed using a value derived from
> the "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Note that the array size is defined by a Kconfig symbol
> (CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using a
> legitimate DTB.
>
> Fixes: 3ac337e76a1c637b ("serial: samsung: Fix out-of-bounds access through DT alias")

Fixes: 13a9f6c64fdc55eb ("serial: samsung: Consider DT alias when probing po
rts")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
