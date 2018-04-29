Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeD2Wny (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 18:43:54 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54609 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbeD2Wnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 18:43:50 -0400
X-Google-Smtp-Source: AB8JxZpaypgZR/PBo/Kvrus1MXu2+nuVc/oAqbuy5vOpKGCNtTiVq/UOXKrrLhpZVT1b7b0Ng5HyZUcpzVRuE54eFlI=
MIME-Version: 1.0
In-Reply-To: <20180429222625.35tedjzkizchudcm@sultan-box>
References: <20180426192524.GD5965@thunk.org> <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org> <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org> <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box> <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box> <20180429220519.GQ5965@thunk.org>
 <20180429222625.35tedjzkizchudcm@sultan-box>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 30 Apr 2018 00:43:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
Message-ID: <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -       if ((fast_pool->count < 64) &&
> -           !time_after(now, fast_pool->last + HZ))
> -               return;
> -

I suspect you still want the rate-limiting in place. But if you _do_
want to cheat like this, you could instead just modify the condition
to only relax the rate limiting when !crng_init().
