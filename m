Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeDXDDs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:03:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43916 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932759AbeDXDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:03:46 -0400
X-Google-Smtp-Source: AIpwx48KkDhFk5P8kS7Q4MtjJCJcpMr/3F0t0IeqM+Gr6/5VX7R8AQbSPyR0MkBmMgUoYXGTk1LIaJXhAbDw7uKsbFk=
MIME-Version: 1.0
In-Reply-To: <cef78d739d29410cb73072e9792598a7@genki.is>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
 <2580c734d38041e984215ccc522a4f2d@genki.is> <cef78d739d29410cb73072e9792598a7@genki.is>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 23 Apr 2018 20:03:44 -0700
Message-ID: <CALAqxLWmcmiOgbH1Ri+Ki-OGFvgzRzRDzX3FZdUhcqu1OoCWiA@mail.gmail.com>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
To: Genki Sky <sky@genki.is>
Cc: David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 7:45 PM, Genki Sky <sky@genki.is> wrote:
> Quoting Genki Sky (2018/04/23 20:40:36 -0400)
>> I came across this thread for same reason as [0]: Daemons getting
>> killed by systemd on resume (after >WatchdogSec seconds of
>> suspending). I'm using master branch of systemd and the kernel. As
>> mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
>> not include suspend time.
>>
>> Correct me if I'm mistaken, but I don't see the ambiguity of whether
>> this patch series breaks systemd. If it's implemented correctly, you'd
>> hope it *would* break it!
>
> This sounded a little weak on re-reading, sorry. So, I just confirmed
> that after booting a "git revert -m 1 680014d6d1da", the issue no
> longer appears. (I.e., a suspend for >WatchDog sec doesn't result in
> any daemon getting killed).
>
> Let me know if I can help in any way.

Yea, this is the sort of thing I was worried about.

Thomas: I think reverting this change is needed.

thanks
-john
