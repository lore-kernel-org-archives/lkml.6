Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB2FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5517F2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/0egDdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5517F2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeKBUD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:03:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37987 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:03:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id q186-v6so1367159ljb.5;
        Fri, 02 Nov 2018 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0LKP1ViBIUDzybZ6UHMgA77PrdumiAw69YBzmrhxfA=;
        b=C/0egDdgbZqtk4LAfDgucriN/4mV03+1a4LHuwy9vywDlUic0qjCBjU6v3WGC2bv5M
         VpdwkPPM6eyUGcvlM5aWC/LRDnTn0MBFkpqQLlTQOotJB0Fy7zGQk0f+u3xnrKi01ryt
         38DGZEEzTOduSDMq7bNahO022ypz3I2d+Ww4YCp2FdGRUQQrXCccLoGypIHZy7qvjjfn
         ftpAtXjbItSNvOeseJwZoQ6pS1MsT1FCoVu5Yv1zMn8iQzul769AkfqGiz00P4+voIen
         M0EQ3Zu1EpAtYGak8uibwe4Ny0INWsY5C5jYkh8KTzmHIgCnOfk48PhmrcF5FRMVM1YE
         bYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0LKP1ViBIUDzybZ6UHMgA77PrdumiAw69YBzmrhxfA=;
        b=MQgVlCKDkBlc6zg7WwT/BC6+kK0LfcALWCj5kgLqZJrmYWZPWu036nIT9Mj9OrmBV8
         yw9rjw+ZlVr0CZrjDu+eLqw4awLNuFIPnACfBuJtZ+nNWtyPYr/tuHRuHSUHZIzOn7eo
         pz3GvoR2OA/tifHi84VrauAKuMoE/3IjjUk/damWpmrKNw3F+aG/0QmNnB/DmtHhf5Pe
         5QNdzwjpT+779nJkHS/puCPRxHyvqHyYIu5BUOhUkX7cp6gmwcPQ9vnMHa1eDHnvjAxU
         vi6NOBWp3m1MXBgF5kxMXW1tHy5sN5hfH1y58n5k7/q6qhGrvkovwJtgHZyerNAm6cDb
         9A9Q==
X-Gm-Message-State: AGRZ1gIfAzoEZrzD01/4OtSTde+AmCkZLIzQ+v1m7SuVcW+3PSdyWMbl
        tvJZLfJIo57ZVkE6GfYt472wZLrZf8jq8ib+HPI=
X-Google-Smtp-Source: AJdET5fb0KCjT0Va1vp1KB0+UQRADtdHgUT6R0un5RbFVB4VoRblJAzDZfMJuTS9J8NvmQe+6ZeITnYYHIImx58H0KI=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr7254742ljd.94.1541156229590;
 Fri, 02 Nov 2018 03:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-3-miguel.ojeda.sandonis@gmail.com> <CAGXu5j+3pR2mfcdbURv7MrPxUVjmjQEDRHH8BLpTNGiasJs1pg@mail.gmail.com>
 <20181023053542.lsklua2p3lnbkqir@mwanda> <CANiq72nrd70qTxEAfxxuNHNoi19MBo=yrJnm9_EnfrpEMQHXCg@mail.gmail.com>
In-Reply-To: <CANiq72nrd70qTxEAfxxuNHNoi19MBo=yrJnm9_EnfrpEMQHXCg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Nov 2018 11:56:58 +0100
Message-ID: <CANiq72k3rniqgoEqLwZxpTO0N9-BqkZKRJr_M-T7-y6khR03ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] Compiler Attributes: auxdisplay: panel: use __fallthrough
To:     Dan <dan.carpenter@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:49 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Thanks for checking! Let's wait then a few months and see if we can
> get cppcheck/Eclipse to support it.

In the meantime, saved here too:

  https://github.com/ojeda/linux/tree/compiler-attributes-fallthrough

rebased on top of e468f5c06b5e ("Merge tag
'compiler-attributes-for-linus-4.20-rc1' of
https://github.com/ojeda/linux").

Cheers,
Miguel
