Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3530641-1519151892-2-3090742351399586265
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519151892; b=qpbh4wlfJHtkBX5d+gUr7ovmNZ80mcSDWdh8TeNYXuVE9pS
    pa189NkF1ddpAwVOcoT73C78newEaNqKOXbKuMMjj0DfpnntP+2g/m8Z/oWdne5u
    jYZ86nTaXk6gbOdjBabyn14IO1lO87Al6ZfzXBmfezxaLZODNFXdljIBqKBWHR/c
    4eA9Pwch7KSnpx6d18sLpQaEBh8Y8hQfFEUcTBbrfwbG0+5dFEcuPYTrGsknecdX
    6bbVJNVE2+/PV5Yl5pRHbnky5aa71VJJn7j4w61dvCQHxmVPnLR3E+dXSd60I31O
    b14oj9PztcQzg5a5O2wcvOouSU4szJTY/Tec+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519151892; bh=lIbgEOgXNiQDzt0yQkvu8grqITByZtxIO2Ceel
    Ap830=; b=JyelW0dLs+MivvnXG11LynriZS8P+BUZHYt9IGYceJZu+Eohf18f7e
    QIAx1VCHqSI4bfpwQJiJpcjpkwOfT2+xJQ+C3I+upExfgaaz9Avsde+Mvv1dylxZ
    Mnplj3hBHGB6pS+a5jvdo4QDo/6gwt3cmLnU3rbclx/aLC7odTDnABLyIpQ1doK/
    RjZ43oRnJbHgnbZ/+NIoBTKAElFlhAdym4Yr+r/3SMiC68UMOofwYbS74HaVAs2k
    Ggkb8MTaynbeogJtQ7fsg2BiEECvWE+OVVTugQmS/zhCcoYpBoVUYHzI841yHnAL
    nEtaMxwXA9JdamoYpF6qDrOv/KgATk7w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ioqvh9LJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H1GAHRgN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ioqvh9LJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H1GAHRgN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeBTSiJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 13:38:09 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41195 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBTSiI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 13:38:08 -0500
X-Google-Smtp-Source: AH8x22544cpPG+Kb97qVmOKueFWvGXM6P23pLOJknjPIKBaMyjFZWy0EHjW3eYy7gHK5UR0yRy5O73atQEYrZ4eK5lI=
MIME-Version: 1.0
In-Reply-To: <20180220181751.20826-1-krzk@kernel.org>
References: <20180220181751.20826-1-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 19:38:07 +0100
X-Google-Sender-Auth: 0-azr2yXDjigAVDZgYiM-2OYlKg
Message-ID: <CAMuHMdUg-Fj5J7peAWUBc-5qnDc5RSzOg1TxURdEW4g9NrsYsQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: Validate alias coming from DT
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 7:17 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Driver uses alias from Device Tree as an index of pin controller data
> array.  In case of a wrong DTB or an out-of-tree DTB, the alias could be
> outside of this data array leading to out-of-bounds access.
>
> Depending on binary and memory layout, this could be handled properly
> (showing error like "samsung-pinctrl 3860000.pinctrl: driver data not
> available") or could lead to exceptions.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 30574f0db1b1 ("pinctrl: add samsung pinctrl and gpiolib driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
