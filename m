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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68655C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAF222D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MflhVWtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407193AbfBNOSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:18:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38820 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBNOSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:18:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so6978834qtb.5;
        Thu, 14 Feb 2019 06:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dhHkBvsFwhoBk7HhJn3rcdLGAqE4zJS29PVZ64IlvLA=;
        b=MflhVWtb8wMqFt8aA1rTZsc33wrzTSCe7EsQ7mvyMvHsGcsMTeE5pvvXDC0X4+JnV2
         jV35Al3tlVED6bDA/I+vzsvBRQnqQofsRCYp+I2ei6Lug5o+Q4Ur9M20Tcluao5eBmlJ
         Sq4qNZcyd8gbLLkuUyFgkaH3F8/11cFrxl1mpb7cYrt87Czzc1wIiU35vTXUN5SCfEXU
         mC8RW/oqQ6+q8ZvwxyZniWePXYRTu97dknLOSzthVm5CvCwPTYkGdZr6OY4t0REJnYUv
         tYKRG9JkVazijVLQdHj+uCt7VKHIHgXv7FfbJRnDIdX7L5Aab4SjIs8yXwdl7UASFJFH
         WBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dhHkBvsFwhoBk7HhJn3rcdLGAqE4zJS29PVZ64IlvLA=;
        b=Pt21ySOHw7zQhhc0HlMT3AGwLlwxAOwYRJBXwAW0k7sxGHmZEEy5A86P/6mdoECn+i
         c+YHcejLDMOgcR63uaaiuu0iMKwP5IERNyV5wNNdWiTNTkvSTCnZhSWMeYqagiS5jOXc
         N7zSA+X/R+aU+Rxn6XUzTqelrwcIAh2sYjV4bYKYB3B7gibf26jzn8AWXoVFVFA0pAGz
         WaGhdoo0ZjtZOyQPHTk8mP1JNHkj1YNDz2wsbByy6k/gZZPRermdFLFg7eqTVQZgkJMl
         uxPfP+FgpGacId1xAnC0SNXAN2AqTqFu0FX8q22hh+85xEw6HDgL03exyUAq3XiqeSJH
         LjJQ==
X-Gm-Message-State: AHQUAuZWjtGpEvVsTPce6ndY3+Tjdmbv8pZUguukEv7+/S19RmkcCkW6
        k2OGRspDgvSlKJnYqdSYElJUs3T0Tij6WOJzqeRb9L2bprE=
X-Google-Smtp-Source: AHgI3IaSZ8B9oPHoyxblOhKtMd+6twpd6eF6Jm6qiH2HuC18lLEDBvY3O5qqS6jpRlBZlnUmga7YLKPefYfUCpzNZ4o=
X-Received: by 2002:a0c:8816:: with SMTP id 22mr3109268qvl.247.1550153892059;
 Thu, 14 Feb 2019 06:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20190214013042.254790-1-mka@chromium.org> <20190214013042.254790-5-mka@chromium.org>
In-Reply-To: <20190214013042.254790-5-mka@chromium.org>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 14 Feb 2019 23:17:36 +0900
Message-ID: <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
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

As I commented on the first patch, it is not possible to call some codes
according to the intention of each governor between 'devfreq_moniotr_*()'
and some codes which are executed before or after 'devfreq_moniotr_*()'

For example, if some governor requires the following sequence,
after this patch, it is not possible.

case DEVFREQ_GOV_xxx:
        /* execute some code before devfreq_monitor_xxx() */
        devfreq_monitor_xxx()
        /* execute some code after devfreq_monitor_xxx() */

2019=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:16, M=
atthias Kaehlcke <mka@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> devfreq expects governors to call devfreq_monitor_start/stop()
> in response to DEVFREQ_GOV_START/STOP events. Since the devfreq
> core itself generates these events and invokes the governor's event
> handler the start/stop of the load monitor can be done in the common
> code.
>
> Call devfreq_monitor_start/stop() when the governor reports a
> successful handling of DEVFREQ_GOV_START/STOP and remove these
> calls from the simpleondemand and tegra governors. Make
> devfreq_monitor_start/stop() static since these functions are now
> only used by the devfreq core. For better integration with the
> callers the functions must now be called with devfreq->lock held.
>
> Also stop manipulating the monitor workqueue directly, use
> devfreq_monitor_start/stop() instead.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c                 | 45 +++++++++++------------
>  drivers/devfreq/governor.h                |  2 -
>  drivers/devfreq/governor_simpleondemand.c |  8 ----
>  drivers/devfreq/tegra-devfreq.c           |  2 -
>  4 files changed, 22 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index eb86461648d74..ac553c00f6790 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -404,14 +404,14 @@ static void devfreq_monitor(struct work_struct *wor=
k)
>   * devfreq_monitor_start() - Start load monitoring of devfreq instance
>   * @devfreq:   the devfreq instance.
>   *
> - * Helper function for starting devfreq device load monitoing. By
> - * default delayed work based monitoring is supported. Function
> - * to be called from governor in response to DEVFREQ_GOV_START
> - * event when device is added to devfreq framework.
> + * Helper function for starting devfreq device load monitoring. By
> + * default delayed work based monitoring is supported. Must be called
> + * with devfreq->lock held.
>   */
> -void devfreq_monitor_start(struct devfreq *devfreq)
> +static void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> -       mutex_lock(&devfreq->lock);
> +       WARN(!mutex_is_locked(&devfreq->lock),
> +            "devfreq->lock must be held by the caller.\n");
>
>         if (devfreq->profile->polling_ms) {
>                 INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> @@ -420,28 +420,28 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>
>                 devfreq->monitor_state =3D DEVFREQ_MONITOR_RUNNING;
>         }
> -
> -       mutex_unlock(&devfreq->lock);
>  }
> -EXPORT_SYMBOL(devfreq_monitor_start);
>
>  /**
>   * devfreq_monitor_stop() - Stop load monitoring of a devfreq instance
>   * @devfreq:   the devfreq instance.
>   *
> - * Helper function to stop devfreq device load monitoing. Function
> - * to be called from governor in response to DEVFREQ_GOV_STOP
> - * event when device is removed from devfreq framework.
> + * Helper function to stop devfreq device load monitoring. Must be
> + * called with devfreq->lock held.
>   */
> -void devfreq_monitor_stop(struct devfreq *devfreq)
> +static void devfreq_monitor_stop(struct devfreq *devfreq)
>  {
> +       /* mutex must be held for symmetry with _start() */
> +       WARN(!mutex_is_locked(&devfreq->lock),
> +            "devfreq->lock must be held by the caller.\n");
> +
> +       mutex_unlock(&devfreq->lock);
>         cancel_delayed_work_sync(&devfreq->work);
>
>         mutex_lock(&devfreq->lock);
>         devfreq->monitor_state =3D DEVFREQ_MONITOR_STOPPED;
>         mutex_unlock(&devfreq->lock);
>  }
> -EXPORT_SYMBOL(devfreq_monitor_stop);
>
>  /**
>   * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq inst=
ance
> @@ -518,27 +518,22 @@ void devfreq_interval_update(struct devfreq *devfre=
q, unsigned int *delay)
>
>         /* if new delay is zero, stop polling */
>         if (!new_delay) {
> +               devfreq_monitor_stop(devfreq);
>                 mutex_unlock(&devfreq->lock);
> -               cancel_delayed_work_sync(&devfreq->work);
> -               devfreq->monitor_state =3D=3D DEVFREQ_MONITOR_STOPPED;
>                 return;
>         }
>
>         /* if current delay is zero, start polling with new delay */
>         if (!cur_delay) {
> -               queue_delayed_work(devfreq_wq, &devfreq->work,
> -                       msecs_to_jiffies(devfreq->profile->polling_ms));
> +               devfreq_monitor_start(devfreq);
>                 goto out;
>         }
>
>         /* if current delay is greater than new delay, restart polling */
>         if (cur_delay > new_delay) {
> -               mutex_unlock(&devfreq->lock);
> -               cancel_delayed_work_sync(&devfreq->work);
> -               mutex_lock(&devfreq->lock);
> +               devfreq_monitor_stop(devfreq);
>                 if (devfreq->monitor_state !=3D DEVFREQ_MONITOR_SUSPENDED=
)
> -                       queue_delayed_work(devfreq_wq, &devfreq->work,
> -                             msecs_to_jiffies(devfreq->profile->polling_=
ms));
> +                       devfreq_monitor_start(devfreq);
>         }
>  out:
>         mutex_unlock(&devfreq->lock);
> @@ -601,6 +596,8 @@ static int devfreq_governor_start(struct devfreq *dev=
freq)
>                 return err;
>         }
>
> +       devfreq_monitor_start(devfreq);
> +
>         return 0;
>  }
>
> @@ -624,6 +621,8 @@ static int devfreq_governor_stop(struct devfreq *devf=
req)
>                 return err;
>         }
>
> +       devfreq_monitor_stop(devfreq);
> +
>         return 0;
>  }
>
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index d136792c0cc91..47efe747b6f79 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -57,8 +57,6 @@ struct devfreq_governor {
>                                 unsigned int event, void *data);
>  };
>
> -extern void devfreq_monitor_start(struct devfreq *devfreq);
> -extern void devfreq_monitor_stop(struct devfreq *devfreq);
>  extern void devfreq_interval_update(struct devfreq *devfreq,
>                                         unsigned int *delay);
>
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/=
governor_simpleondemand.c
> index 52eb0c734b312..e0f0944a9c7aa 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -91,14 +91,6 @@ static int devfreq_simple_ondemand_handler(struct devf=
req *devfreq,
>                                 unsigned int event, void *data)
>  {
>         switch (event) {
> -       case DEVFREQ_GOV_START:
> -               devfreq_monitor_start(devfreq);
> -               break;
> -
> -       case DEVFREQ_GOV_STOP:
> -               devfreq_monitor_stop(devfreq);
> -               break;
> -
>         case DEVFREQ_GOV_INTERVAL:
>                 devfreq_interval_update(devfreq, (unsigned int *)data);
>                 break;
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devf=
req.c
> index 79efa1e51bd06..515fb852dbad6 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -580,13 +580,11 @@ static int tegra_governor_event_handler(struct devf=
req *devfreq,
>
>         switch (event) {
>         case DEVFREQ_GOV_START:
> -               devfreq_monitor_start(devfreq);
>                 tegra_actmon_enable_interrupts(tegra);
>                 break;
>
>         case DEVFREQ_GOV_STOP:
>                 tegra_actmon_disable_interrupts(tegra);
> -               devfreq_monitor_stop(devfreq);
>                 break;
>
>         case DEVFREQ_GOV_SUSPEND:
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


--=20
Best Regards,
Chanwoo Choi
