Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeBSNvH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:51:07 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:39390 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbeBSNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:51:06 -0500
X-Google-Smtp-Source: AH8x227CgHmbq9lNbmfiDGxsQQEiWA9+PzXM4HsFLFb0tiY7UTq3xTvB+kzedd19R+aog4Yt8g4q+iiT9IaaUw1QOlU=
MIME-Version: 1.0
In-Reply-To: <20180218220146.22485-7-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com> <20180218220146.22485-7-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 15:51:05 +0200
Message-ID: <CAHp75VfjpRngR9_vE2SrHA_NRZdsap-2bEdRD6OEK63CTPBw2g@mail.gmail.com>
Subject: Re: [PATCH 6/9] ASoC: Intel: sst: Free streams on suspend, re-alloc
 on resume
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The Bay Trail SST-DSP firmware version looses track of all streams over a
> suspend/resume, failing any attempts to resume and/or free streams, with
> a SST_ERR_INVALID_STREAM_ID error.
>
> This commit adds support for free-ing the streams on suspend and
> re-allocating them on resume, fixing suspend/resume issues on devices
> using this firmware version.
>
> This new behavior gets triggered by a new flag in sst_platform_info which
> only gets set on Bay Trail platforms.
>
> This has been tested on the following devices:
> -Asus T100TA,    Bay Trail    + ALC5642 codec
> -Ployer MOMO7W,  Bay Trail CR + ALC5652 codec


>  /* Cherryview (Cherrytrail and Braswell) uses same mrfld dpcm fw as Baytrail,
> - * so pdata is same as Baytrail.
> + * so pdata is same as Baytrail, minus the streams_lost_on_suspend quirk.
>   */

A nit, perhaps to fix multi line comment style as well?


-- 
With Best Regards,
Andy Shevchenko
