Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932794AbeDXCpJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:45:09 -0400
Received: from genki.is ([159.203.135.224]:33092 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932721AbeDXCpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:45:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 genki.is CC46F40040
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@gmail.com>
From: Genki Sky <sky@genki.is>
In-Reply-To: <2580c734d38041e984215ccc522a4f2d@genki.is>
Cc: linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
 <2580c734d38041e984215ccc522a4f2d@genki.is>
Message-ID: <cef78d739d29410cb73072e9792598a7@genki.is>
User-Agent: alot
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
Date: Mon, 23 Apr 2018 22:45:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3O2jBoZ027244

Quoting Genki Sky (2018/04/23 20:40:36 -0400)
> I came across this thread for same reason as [0]: Daemons getting
> killed by systemd on resume (after >WatchdogSec seconds of
> suspending). I'm using master branch of systemd and the kernel. As
> mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
> not include suspend time.
>
> Correct me if I'm mistaken, but I don't see the ambiguity of whether
> this patch series breaks systemd. If it's implemented correctly, you'd
> hope it *would* break it!

This sounded a little weak on re-reading, sorry. So, I just confirmed
that after booting a "git revert -m 1 680014d6d1da", the issue no
longer appears. (I.e., a suspend for >WatchDog sec doesn't result in
any daemon getting killed).

Let me know if I can help in any way.
