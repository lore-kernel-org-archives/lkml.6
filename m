Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbeDRDfW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 23:35:22 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:43876 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeDRDfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 23:35:21 -0400
X-Google-Smtp-Source: AIpwx4/WNCkr50u5pybFpkWDqGKOOF653oMYax6/1C4pire9LB0YOV3juH5sE8oHpWPKPn+8ZNvOHz9FMxotzDibjCw=
MIME-Version: 1.0
In-Reply-To: <CABxcv=n6HFXB+sAW_8qwMJWwWXDgspFgNs9Kk37hMO53EimWCg@mail.gmail.com>
References: <20180417171204.259146-1-dianders@chromium.org>
 <20180417172229.GK8973@sirena.org.uk> <CABxcv=n6HFXB+sAW_8qwMJWwWXDgspFgNs9Kk37hMO53EimWCg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Apr 2018 20:35:18 -0700
X-Google-Sender-Auth: 7w1N88Iv0vibg-wwPbsYddONGb0
Message-ID: <CAD=FV=WOZn2vqeZp=EbWjR80Q=6HbdRZbqXr-jK6rBn_dpsyqw@mail.gmail.com>
Subject: Re: [PATCH] regulator: Fix return type of of_map_mode()
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Mark Brown <broonie@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, swboyd@chromium.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 17, 2018 at 10:48 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>>> Let's fix the return type of all of the current of_map_mode()
>>> functions.  While we're at it, we'll remove one pointless "inline".
>>
>> Ah, I see...  the thing here is that the mode is always an unsigned int
>> since it's a bitmask - this goes out beying the use in of_map_mode() and
>> into all the other APIs.  We only actually use 4 bits currently so I
>> think there's no problem switching to int but it seems we should
>> probably do that consistently throughout the API so that things don't
>> get missed later on.
>
> Maybe another option could be to add a REGULATOR_MODE_INVALID with
> value 0x0, and fix the drivers that are returning -EINVAL to return
> that instead?
>
> In of_get_regulation_constraints() we could check for that and
> propagate -EINVAL.

I like this idea.  Posted at
<https://patchwork.kernel.org/patch/10347345/>.  Note that there's no
actual error to propagate since of_get_regulation_constraints() just
prints the error and continues on its merry way.

-Doug
