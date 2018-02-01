Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeBALtD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:49:03 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38650 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeBALtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:49:00 -0500
X-Google-Smtp-Source: AH8x224IilaeIweEqsEAs2Gcbn17UUCyp/Lvg0nXk81SFz9Cn1wusy4lVUvcuflV0ZU3S5mkoBvi97qYFR0nJrRKiEU=
MIME-Version: 1.0
In-Reply-To: <1517480783-5692-1-git-send-email-geert@linux-m68k.org>
References: <1517480783-5692-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Feb 2018 12:48:59 +0100
X-Google-Sender-Auth: 6Eu_h6Pj6cITBFYqK-NJ-_0O0hc
Message-ID: <CAK8P3a3QoF9Xv3sq-2D3YtZJSVZx0nCkzmfOX93zJfBviocA3A@mail.gmail.com>
Subject: Re: [PATCH] inet: Avoid unitialized variable warning in inet_unhash()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11Bn9nr029770

On Thu, Feb 1, 2018 at 11:26 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> With gcc-4.1.2:
>
>     net/ipv4/inet_hashtables.c: In function ‘inet_unhash’:
>     net/ipv4/inet_hashtables.c:628: warning: ‘ilb’ may be used uninitialized in this function
>
> While this is a false positive, it can easily be avoided by using the
> pointer itself as the canary variable.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks like a reasonable workaround if we care about it. gcc-4.3 and higher
don't seem to produce this warning, so I wouldn't normally care though.

Acked-by: Arnd Bergmann <arnd@arndb.de>
