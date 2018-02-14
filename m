Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030900AbeBNOgf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:36:35 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35562 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030381AbeBNOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:36:34 -0500
X-Google-Smtp-Source: AH8x226N3pM34Is2jgjEho8qL2Z5YLmpvJkhXnzcg4dgIv1rH0ukuEMvavZ5biUarmyFpA0TTRdWY6dTaQE9Vh+yNgs=
MIME-Version: 1.0
In-Reply-To: <CAKb7Uvj3MKGzNNcrc=-JA5GN4jt9+TU7ZjWDZpccmYJLDo76WQ@mail.gmail.com>
References: <alpine.LRH.2.21.1802132200260.24929@math.ut.ee>
 <alpine.LRH.2.21.1802141628110.25362@math.ut.ee> <CAKb7Uvj3MKGzNNcrc=-JA5GN4jt9+TU7ZjWDZpccmYJLDo76WQ@mail.gmail.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Wed, 14 Feb 2018 09:36:33 -0500
X-Google-Sender-Auth: CqNV5PeEVOYpgz_OyQdAfv69aTU
Message-ID: <CAKb7UvhRt=25J5aOUZusdE51hh1JVc45aQ8OhCVeOJwzYvLOJw@mail.gmail.com>
Subject: Re: [Nouveau] 4.16-rc1: UBSAN warning in nouveau/nvkm/subdev/therm/base.c
 + oops in nvkm_therm_clkgate_fini
To: Meelis Roos <mroos@linux.ee>
Cc: nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 9:35 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> On Wed, Feb 14, 2018 at 9:29 AM, Meelis Roos <mroos@linux.ee> wrote:
>>> This is 4.16-rc1+todays git on a lowly P4 with NV5, worked fine in 4.15:
>>
>> NV5 in another PC (secondary card in x86-64) made the systrem crash on
>> boot, in nvkm_therm_clkgate_fini.
>
> Mind booting with nouveau.debug=trace? That should hopefully tell us
> more exactly which thing is dying. If you have a cross-compile/distcc
> setup handy, a bisect may be even more useful.

Erm, sorry, nevermind. You even said it -- nvkm_therm_clkgate_fini is
somehow mis-hooked up for NV5 now. A bisect result would still make
the culprit a lot more obvious.
