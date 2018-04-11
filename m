Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeDKUZL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 16:25:11 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41072 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757546AbeDKUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 16:25:05 -0400
X-Google-Smtp-Source: AIpwx49SWo/mnxBlx2p/byW2I1cTp9wSOjN+MO1/koIuckQKnp65I0BWaWOtC9X6069icmNPkvWop89Fzmv5/hKrR1M=
MIME-Version: 1.0
In-Reply-To: <87fu41ilor.fsf@xmission.com>
References: <20180411150829.3881900-1-arnd@arndb.de> <87fu41ilor.fsf@xmission.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Apr 2018 22:25:03 +0200
X-Google-Sender-Auth: TqcbS_oGCtvrf-TaWRaldNYQVX4
Message-ID: <CAK8P3a3em5b2Qp_y0uHz95=JbyB7dHuPnfRNWNZ79beV6hGMyQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: compat: allow including asm/compat.h for 32-bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 9:32 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> We have several files on sparc that include linux/compat.h and expect
>> asm/compat.h not to be included, otherwise we get a build failure.
>
> Should this say: "We have several files on sparc that include
> linux/compat.h and expect asm/compat.h not be included when
> !CONFIG_COMPAT." ?

Correct, I'll fix it up. I'll say '32-bit builds' instead, which is what
I'm interested in. On sparc64, CONFIG_COMPAT is enabled
unconditionally, so it's really the same thing.

> I don't have your tree and I see asm/compat.h included from
> linux/compat.h already so the description above seems wrong.

I removed the tree from linux-next before the merge window because
of this build regression, if you are interested in the other changes,
please see

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-next

      Arnd
