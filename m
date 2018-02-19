Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeBSNxc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:53:32 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:41408 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbeBSNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:53:31 -0500
X-Google-Smtp-Source: AH8x2256dSAHm3hN3n25gwLFjGyYM8yR06IDrazjNtCC+jp0wWFqsnxvTWBpBkD4vzyMGH1zR9vFHfa5uljU7Pqnngs=
MIME-Version: 1.0
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 15:53:30 +0200
Message-ID: <CAHp75Ved8FH+ZvzEbPjHj2uwTg4pXvky3fjxHFsk-352V17obg@mail.gmail.com>
Subject: Re: [PATCH 0/9] ASoC: Intel: sst: Fix Bay Trail suspend/resume issues
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Here is a series fixing suspend/resume errors (and broken audio after
> resume) on Bay Trail devices.
>
> Cherry Trail devices also do not like being suspend while audio is
> playing, but with different sypmtoms instead of SST_ERR_INVALID_STREAM_ID
> errors, if a stream was playing (being allocated is fine, playing is a
> problem) before suspend then after resume we get the following errors:
>
>   [ 2312.389974] intel_sst_acpi 808622A8:00: sst: Busy wait failed, cant send this msg
>   [ 2312.597976] intel_sst_acpi 808622A8:00: sst: Busy wait failed, cant send this msg
>   ...
>
> Until the stream is stopped and restarted after which things work fine
> again. I've tried enabling the quirk this commit adds for Cherry Trail
> devices too, but that does not help. If anyone has any clues about the CHT
> problem, please let me know.

Good fix!

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
