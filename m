Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649693-1519123953-2-2249722383511118998
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
    t=1519123953; b=srIklPvwTe0imxbaHkY9YD8IY0FAqqcsqz5B6E7iu7Vi25+
    EMIPdMaI/qlLjMM8hO+wlJZ5yGXXiLIeFqmr5Sd17T+yRDwJItcfUd9WoW1PTkyx
    YbbNIFPtn0Kj+/bBqNq/TtyboeXiYAdtiiOKTwysx/UL62Icnmqhd6woPYU1H5HK
    bkILW8tKWCJ7oNv83Oo76kunbwdLGpVKDhFF7Z35tdSXC9goeb3J/O+LZno9KbLw
    a/NxXqqz/Zr4tZq6UYhYGKjllrlvrdk2duAi51odySqxzEk+xh805XttW8UURthh
    +pshuX4LeNPv8dktmKvbPhEXjaKI2CifRghA0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519123953; bh=NVViSKNanfIxUJ9eCCEwi64FLiMHCz53hkWcD6
    Jbk8g=; b=XY64FNxraTGNhAGwdVG34ddhQ1lQx6QUzVhdrGZlm8jq4YByJR6DG/
    zhyud3FfCgi8v++V4R4o6qXueECz2ymnmP8wU0ibb6RvdO+qjUFfcXu9JriBCzZZ
    MB20pt5Ul0nhIVSOOmERGbyM26OtKmBHpYwiYEx20QeWXRKDqxmywPF5ReaHv3DH
    hAss/ufq7k+fNg/mPKcL9fYYgb/f65pfuOs/2Z6Bm8Znm07iffsyyg2GqAkcfMBp
    TJ7H2wbHAB5RYf5cIK4U6tJ2s38AG4aD/Y6piXBs5FSzlLR1X02hQK3qA6qFM41h
    EMCVzPrH6V6jk2yLXgYKcC03cWqli9eA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VyzxTxFM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IOf8EYTx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VyzxTxFM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IOf8EYTx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeBTKwR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:52:17 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42995 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeBTKwQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:52:16 -0500
X-Google-Smtp-Source: AH8x227rhFft0X9Mg7aidogAzk5bkv9A527g/XUdO45lui4PZVelLCTQNNoPTM947mr/1HD5TK0ogsSmFnqwucVNMAU=
MIME-Version: 1.0
In-Reply-To: <1519119624-1268-6-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be> <1519119624-1268-6-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:52:14 +0100
X-Google-Sender-Auth: O6NT_-IKfChp068sqCdKys6lY1Q
Message-ID: <CAMuHMdX-9+7WRDP848Y6xwqF-iNGm6A32gKgTPFdsLY=5K2q9A@mail.gmail.com>
Subject: Re: [PATCH 5/9] serial: pxa: Fix out-of-bounds access through DT alias
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
> The serial_pxa_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: c8dcdc77298dde67 ("serial: pxa: Fix out-of-bounds access through DT alias")

Fixes: 699c20f3e6310aa2 ("serial: pxa: add OF support")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
