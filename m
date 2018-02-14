Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967466AbeBNLaV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:30:21 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43355 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967342AbeBNLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:30:20 -0500
X-Google-Smtp-Source: AH8x2252s2MvPCEkEFeGV9x7W9hax6QASpcBc+RVhQi3w4O4MJiBPQtnFAbyOJ7OueLC/vthA+zuIFi3kW1GCGJHWzg=
MIME-Version: 1.0
In-Reply-To: <24ddea73-5c84-e098-caae-8a4c14834cbd@metux.net>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net> <20180213222751.p3fyg7whg6jqlzz5@gordon>
 <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net> <20180214045442.jyv6zpbwz5glzi4z@gordon>
 <9c097fd9-3035-d5be-a829-fc18e7734f18@metux.net> <20180214102410.dxgbayb4i76h5exo@gordon>
 <24ddea73-5c84-e098-caae-8a4c14834cbd@metux.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 14 Feb 2018 12:30:18 +0100
Message-ID: <CAFLxGvzxLP_UTQbwEY99bQfyftWzZHwaOP+WrzJ8099EKtbVLg@mail.gmail.com>
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Enrico Weigelt <lkml@metux.net>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:27 PM, Enrico Weigelt <lkml@metux.net> wrote:
> On 14.02.2018 11:24, Aleksa Sarai wrote:
>
>> What distribution are you using and which release?
>
>
> On a self-compiled system.
>
> Forgot to enable namespaces in the kernel. Now it seems to work
> as root, but not as an unprivileged user:
>
>
> daemon@alphabox:~ unshare -r -U
> unshare: can't open '/proc/self/setgroups': Permission denied
> daemon@alphabox:~ unshare -f -r -U
> unshare: can't open '/proc/self/setgroups': Permission denied
>

Please read http://man7.org/linux/man-pages/man7/user_namespaces.7.html
setgroups is a corner case and needs special care.

-- 
Thanks,
//richard
