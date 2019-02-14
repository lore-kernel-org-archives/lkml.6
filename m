Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5405C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9720D222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpCDQLV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393560AbfBNO0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:26:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33931 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbfBNO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:26:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id w4so7049499qtc.1;
        Thu, 14 Feb 2019 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dT2lzlpua4hQYDJckwyrzS3wsiX4wbYJMpJBqfzJGEw=;
        b=bpCDQLV9MJfDZ3gNFVv6ioYDALhw2pkHOAQRP5rCe5KpuNqkg+tjAFZDLqkjJKp5xb
         LCMO6BLH+c1YgntzArHIJx2iPtUkrgOgO/cenXV3JGDiCoJbU+4slh4Xwt4sajWz0M6m
         lElQFyoEzvQPXOO1dEQI8N+Q+aMKHAM+7LyxTrl1BQvpKSgT3Z0ovcrWLp9vmCCEnlFs
         IRYKSByaSgTE3Pr3JNUsR/TcBwkqFzr2psz0co9V4HM/mMLL0+cvmiKb+O3Gh/kDQpe5
         HR6hMksIPECkHaqMrHxY5ODXTys2OV98cb5u2VFg41cy23+QmeVpsB6hF+um17TI0zuc
         V4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dT2lzlpua4hQYDJckwyrzS3wsiX4wbYJMpJBqfzJGEw=;
        b=EFbWzBlqLDSEFUoHtVMr2tKdDm1auN1vkBVvkZ3aGGKhQa97AE4hdf8BIkHga/D1ew
         m9CxPKvtYjQCToLezeGTEyxLClfipRXxjfM7KcNJFT+MHBlIe2+uWxGEAzuwM4lYEjFE
         U1srb+KauBJ2bHQ0YovTbGASoawC7ESfKKZprjhrWu2NxJFA3uSV7x157+zSd1BYE/Eh
         ZI3D/4qK0TGBB2gRytJ7eopawNtCXTsi+JHFIKoWN1Bf7DF6CgGIE0qspCcDwqe1VzQ+
         WXx6nz7BdDeZosCF9TtNvY0QdcQ7wZO/q5MxjQ2pQRWTln1uJ658aagPLtNhAbo6AnmV
         YkfA==
X-Gm-Message-State: AHQUAubSeLIrR4RyMbCoWCTrPauA/pvy2HWiapOI5nBdNDJD6dXLpmq0
        ny5l3W/c0xhobq0wHnQNLv6+IUJVv0cWjqcE+4E=
X-Google-Smtp-Source: AHgI3IbvJQrM6ed9xgZ1eoiqchz0XZr50eiGUBuALDc4qu4d8Hxyc8qxv6di4+RAPJe0OfGMFnbPOCOMTZ9G+h1Ubww=
X-Received: by 2002:a0c:9346:: with SMTP id e6mr3103554qve.98.1550154389046;
 Thu, 14 Feb 2019 06:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20190214013042.254790-1-mka@chromium.org> <20190214013042.254790-2-mka@chromium.org>
In-Reply-To: <20190214013042.254790-2-mka@chromium.org>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 14 Feb 2019 23:25:52 +0900
Message-ID: <CAGTfZH3E+RetMzKxzZNEgYw6=kocdfgRcKSbmP5GfZ4k1j0Cuw@mail.gmail.com>
Subject: Re: [PATCH 1/4] PM / devfreq: Track overall load monitor state
 instead of 'stop_polling'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

2019=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:16, M=
atthias Kaehlcke <mka@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The field ->stop_polling indicates whether load monitoring should be/is
> stopped, it is set in devfreq_monitor_suspend(). Change the variable to
> hold the general state of load monitoring (stopped, running, suspended).
> Besides improving readability of conditions involving the field and this
> prepares the terrain for moving some duplicated code from the governors
> into the devfreq core.
>
> Hold the devfreq lock in devfreq_monitor_start/stop() to ensure proper
> synchronization.

IMHO, I'm not sure that there are any benefits changing
from 'stop_polling' to 'monitor_state'. I have no objections
if Myungjoo confirms it.

And I agree to move the initialization of work under if statement
according to the value of polling_ms variable in devfreq_monitor_start().

>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 34 +++++++++++++++++++++++++---------
>  include/linux/devfreq.h   |  4 ++--
>  2 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b7..1d3a43f8b3a10 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -29,6 +29,10 @@
>  #include <linux/of.h>
>  #include "governor.h"
>
> +#define DEVFREQ_MONITOR_STOPPED                0
> +#define DEVFREQ_MONITOR_RUNNING                1
> +#define DEVFREQ_MONITOR_SUSPENDED      2
> +
>  static struct class *devfreq_class;
>
>  /*
> @@ -407,10 +411,17 @@ static void devfreq_monitor(struct work_struct *wor=
k)
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> -       INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> -       if (devfreq->profile->polling_ms)
> +       mutex_lock(&devfreq->lock);
> +
> +       if (devfreq->profile->polling_ms) {
> +               INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>                 queue_delayed_work(devfreq_wq, &devfreq->work,
>                         msecs_to_jiffies(devfreq->profile->polling_ms));
> +
> +               devfreq->monitor_state =3D DEVFREQ_MONITOR_RUNNING;
> +       }
> +
> +       mutex_unlock(&devfreq->lock);
>  }
>  EXPORT_SYMBOL(devfreq_monitor_start);
>
> @@ -425,6 +436,10 @@ EXPORT_SYMBOL(devfreq_monitor_start);
>  void devfreq_monitor_stop(struct devfreq *devfreq)
>  {
>         cancel_delayed_work_sync(&devfreq->work);
> +
> +       mutex_lock(&devfreq->lock);
> +       devfreq->monitor_state =3D DEVFREQ_MONITOR_STOPPED;
> +       mutex_unlock(&devfreq->lock);
>  }
>  EXPORT_SYMBOL(devfreq_monitor_stop);
>
> @@ -443,13 +458,13 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
>  void devfreq_monitor_suspend(struct devfreq *devfreq)
>  {
>         mutex_lock(&devfreq->lock);
> -       if (devfreq->stop_polling) {
> +       if (devfreq->monitor_state !=3D DEVFREQ_MONITOR_RUNNING) {
>                 mutex_unlock(&devfreq->lock);
>                 return;
>         }
>
>         devfreq_update_status(devfreq, devfreq->previous_freq);
> -       devfreq->stop_polling =3D true;
> +       devfreq->monitor_state =3D DEVFREQ_MONITOR_SUSPENDED;
>         mutex_unlock(&devfreq->lock);
>         cancel_delayed_work_sync(&devfreq->work);
>  }
> @@ -468,7 +483,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>         unsigned long freq;
>
>         mutex_lock(&devfreq->lock);
> -       if (!devfreq->stop_polling)
> +       if (devfreq->monitor_state =3D=3D DEVFREQ_MONITOR_STOPPED)
>                 goto out;
>
>         if (!delayed_work_pending(&devfreq->work) &&
> @@ -477,7 +492,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>                         msecs_to_jiffies(devfreq->profile->polling_ms));
>
>         devfreq->last_stat_updated =3D jiffies;
> -       devfreq->stop_polling =3D false;
> +       devfreq->monitor_state =3D DEVFREQ_MONITOR_RUNNING;
>
>         if (devfreq->profile->get_cur_freq &&
>                 !devfreq->profile->get_cur_freq(devfreq->dev.parent, &fre=
q))
> @@ -504,13 +519,14 @@ void devfreq_interval_update(struct devfreq *devfre=
q, unsigned int *delay)
>         mutex_lock(&devfreq->lock);
>         devfreq->profile->polling_ms =3D new_delay;
>
> -       if (devfreq->stop_polling)
> +       if (devfreq->monitor_state =3D=3D DEVFREQ_MONITOR_SUSPENDED)
>                 goto out;
>
>         /* if new delay is zero, stop polling */
>         if (!new_delay) {
>                 mutex_unlock(&devfreq->lock);
>                 cancel_delayed_work_sync(&devfreq->work);
> +               devfreq->monitor_state =3D=3D DEVFREQ_MONITOR_STOPPED;
>                 return;
>         }
>
> @@ -526,7 +542,7 @@ void devfreq_interval_update(struct devfreq *devfreq,=
 unsigned int *delay)
>                 mutex_unlock(&devfreq->lock);
>                 cancel_delayed_work_sync(&devfreq->work);
>                 mutex_lock(&devfreq->lock);
> -               if (!devfreq->stop_polling)
> +               if (devfreq->monitor_state !=3D DEVFREQ_MONITOR_SUSPENDED=
)
>                         queue_delayed_work(devfreq_wq, &devfreq->work,
>                               msecs_to_jiffies(devfreq->profile->polling_=
ms));
>         }
> @@ -1372,7 +1388,7 @@ static ssize_t trans_stat_show(struct device *dev,
>         int i, j;
>         unsigned int max_state =3D devfreq->profile->max_state;
>
> -       if (!devfreq->stop_polling &&
> +       if ((devfreq->monitor_state =3D=3D DEVFREQ_MONITOR_RUNNING) &&
>                         devfreq_update_status(devfreq, devfreq->previous_=
freq))
>                 return 0;
>         if (max_state =3D=3D 0)
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index fbffa74bfc1bb..0a618bbb8b294 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -130,7 +130,7 @@ struct devfreq_dev_profile {
>   * @max_freq:  Limit maximum frequency requested by user (0: none)
>   * @scaling_min_freq:  Limit minimum frequency requested by OPP interfac=
e
>   * @scaling_max_freq:  Limit maximum frequency requested by OPP interfac=
e
> - * @stop_polling:       devfreq polling status of a device.
> + * @monitor_state:     State of the load monitor.
>   * @suspend_freq:       frequency of a device set during suspend phase.
>   * @resume_freq:        frequency of a device set in resume phase.
>   * @suspend_count:      suspend requests counter for a device.
> @@ -168,7 +168,7 @@ struct devfreq {
>         unsigned long max_freq;
>         unsigned long scaling_min_freq;
>         unsigned long scaling_max_freq;
> -       bool stop_polling;
> +       int monitor_state;
>
>         unsigned long suspend_freq;
>         unsigned long resume_freq;
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


--=20
Best Regards,
Chanwoo Choi
