Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968014AbeEYTWZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:22:25 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39190 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967811AbeEYTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:22:23 -0400
X-Google-Smtp-Source: ADUXVKInWIgiQRHELu68Ef4w5dyq5YPLhILPN8G9FqWVWdf8XKFXMqCk79/TjKfE+3tvnOmCmcv9rQ==
MIME-Version: 1.0
References: <20180521223503.152131-1-evgreen@chromium.org> <CAPDyKFq3+rfSgUMv1R3AEEw-v7e-J2wvbye8ztXsoaJSwxDLbQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq3+rfSgUMv1R3AEEw-v7e-J2wvbye8ztXsoaJSwxDLbQ@mail.gmail.com>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 25 May 2018 12:21:44 -0700
X-Gmail-Original-Message-ID: <CAE=gft52Yvtqy_i4eXoQs6XV=mrzahoSPxRO=3jiLNKL=pNP1A@mail.gmail.com>
Message-ID: <CAE=gft52Yvtqy_i4eXoQs6XV=mrzahoSPxRO=3jiLNKL=pNP1A@mail.gmail.com>
Subject: Re: [PATCH] mmc: Allow non-sleeping GPIO cd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 5:08 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> First, I thought I preferred this option, as it becomes clear of what
> goes on. However I then realize, that it may not be worth it, because
> in the end I guess the caller (sdhci), will not be able to deal with
> error codes. For example, what would it do if it receives  a -ENOTSUPP
> from mmc_gpio_get_cd_nosleep()?


Uffe,
Yeah, that would end up looking more like my original RFC patch, where we
just kind of assume the card is there (and therefore ignore the quirk) if
we're not in a preemptible state. Sounds like I should make another spin
this way, at least for consideration.

Andy,
Thanks for the review. I will incorporate your feedback into the next spin.
-Evan
