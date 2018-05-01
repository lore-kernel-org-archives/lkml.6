Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeEAWgC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:36:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43182 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeEAWf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:35:57 -0400
X-Google-Smtp-Source: AB8JxZpvMz90e8inBJ+/2oPNGCI4tlOUiBp1gDUH/jlcV7rTkVsjDNE/dci3pC4SLPEZK1LuXK650TIPSy8DFAbvjU4=
MIME-Version: 1.0
In-Reply-To: <20180501125518.GI20585@thunk.org>
References: <20180426235630.GG5965@thunk.org> <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org> <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box> <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box> <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com> <20180501125518.GI20585@thunk.org>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 1 May 2018 17:35:56 -0500
Message-ID: <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Justin Forbes <jmforbes@linuxtx.org>, Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 7:55 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, May 01, 2018 at 06:52:47AM -0500, Justin Forbes wrote:
>>
>> We have also had reports that Fedora users are seeing this on Google
>> Compute Engine.
>
> Can you reproduce this yourself?  If so, could you confirm that
> removing the dracut-fips package makes the problem go away for you?
>

I have not reproduced in GCE myself.  We did get some confirmation
that removing dracut-fips does make the problem less dire (but I
wouldn't call a 4 minute boot a win, but booting in 4 minutes is
better than not booting at all).  Specifically systemd calls libgcrypt
before it even opens the log with fips there, and this is before
virtio-rng modules could even load. Right now though, we are looking
at pretty much any possible options as the majority of people are
calling for me to backout the patches completely from rawhide.
