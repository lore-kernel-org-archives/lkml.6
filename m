Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7014FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6FD205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/RZpm3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6FD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeJaTi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:38:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34823 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeJaTiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:38:25 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so17575662itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Oc920HhcaFht1P1gx8e+YPniWWLvqaRc2V27SaYgIf8=;
        b=e/RZpm3Z9Tl/steJrWf3Hs/H1pphamuQcl1d5a7txM9w4jev/enBGEwAzERrEJbsBn
         REe7QmG4yfy9+9bb5y4sV2HhIpS8l1EFqeZSEU9Hq4RhEtJAYoTyfn9qOzCFpTSKyf/d
         /sPOiiBZreSH1UflA9u5ceESiQbQRCV4RLtCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Oc920HhcaFht1P1gx8e+YPniWWLvqaRc2V27SaYgIf8=;
        b=cU9VMM53260QcFlTSCFYtM04tpYG/+HnZduYNmdsjmCTSzFRoRTF5G/CHE97vowplv
         qooEHa6SMwM7lZJBvwfXxoc2m8r5KWk7ieBVUyjRZ66A3uC3R8nq5MZtbdx22G4X2oHk
         g8lMlwDhzumh/+v+ZTAKasff8tW7BMhHQuA8Vj7wGwLIgjag9ATEGc1PUgSalaB8AS0E
         oipNcVvU+I5mwUMwwabenI0HrYmGXsNRqPxBk7FNDIykYB5KbPGZKGJlWrGt63/Q4y/b
         SD1eD5MC1RrU9p7lv/gDwS1DSFgE4PZoGTh3FOp9RSlBu2TmO56xhJiQJX1DZfF0S4op
         Qr/w==
X-Gm-Message-State: AGRZ1gJewSyrISRjL/fdh7mnrUuQvzFG1S6fHlQG8l5B7M9Sb8F2zQx/
        JwKHRgSHU306tKwkOGj/uYaKDm6Epv+k6+fDSP4VMg==
X-Google-Smtp-Source: AJdET5cSA8tfbwc81LVYEJNEQ5IbJow9S0sWDOUQl//itTVqWrkIg8mZzg5ehvYMf94mQwLERQR20BOniLH/6HDN0ak=
X-Received: by 2002:a24:47c5:: with SMTP id t188-v6mr1577090itb.78.1540982450548;
 Wed, 31 Oct 2018 03:40:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 03:40:10 -0700 (PDT)
In-Reply-To: <20181031065903.6209-5-kai.heng.feng@canonical.com>
References: <20181031065903.6209-1-kai.heng.feng@canonical.com> <20181031065903.6209-5-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Oct 2018 11:40:10 +0100
Message-ID: <CAPDyKForivbBAOMBkdULorqP-Udsdyh8nJwiBHg8Ww1vVoZk3A@mail.gmail.com>
Subject: Re: [PATCH 4/4 v6] memstick: rtsx_usb_ms: Support runtime power management
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 October 2018 at 07:59, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> In order to let host's parent device, rtsx_usb, to use USB remote wake
> up signaling to do card detection, it needs to be suspended. Hence it's
> necessary to add runtime PM support for the memstick host.
>
> To keep memstick host stays suspended when it's not in use, convert the
> card detection function from kthread to delayed_work, which can be
> scheduled when the host is resumed and can be canceled when the host is
> suspended.
>
> Put the device to suspend when there's no card and the power mode is
> MEMSTICK_POWER_OFF.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/memstick/host/rtsx_usb_ms.c | 167 +++++++++++++++++-----------
>  1 file changed, 102 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index cd12f3d1c088..3800c24b084e 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -40,15 +40,14 @@ struct rtsx_usb_ms {
>
>         struct mutex            host_mutex;
>         struct work_struct      handle_req;
> -
> -       struct task_struct      *detect_ms;
> -       struct completion       detect_ms_exit;
> +       struct delayed_work     poll_card;
>
>         u8                      ssc_depth;
>         unsigned int            clock;
>         int                     power_mode;
>         unsigned char           ifmode;
>         bool                    eject;
> +       bool                    system_suspending;
>  };
>
>  static inline struct device *ms_dev(struct rtsx_usb_ms *host)
> @@ -545,7 +544,7 @@ static void rtsx_usb_ms_handle_req(struct work_struct *work)
>                                                 host->req->error);
>                         }
>                 } while (!rc);
> -               pm_runtime_put(ms_dev(host));
> +               pm_runtime_put_sync(ms_dev(host));
>         }
>
>  }
> @@ -585,14 +584,14 @@ static int rtsx_usb_ms_set_param(struct memstick_host *msh,
>                         break;
>
>                 if (value == MEMSTICK_POWER_ON) {
> -                       pm_runtime_get_sync(ms_dev(host));
> +                       pm_runtime_get_noresume(ms_dev(host));
>                         err = ms_power_on(host);
> +                       if (err)
> +                               pm_runtime_put_noidle(ms_dev(host));
>                 } else if (value == MEMSTICK_POWER_OFF) {
>                         err = ms_power_off(host);
> -                       if (host->msh->card)
> +                       if (!err)
>                                 pm_runtime_put_noidle(ms_dev(host));
> -                       else
> -                               pm_runtime_put(ms_dev(host));
>                 } else
>                         err = -EINVAL;
>                 if (!err)
> @@ -638,25 +637,44 @@ static int rtsx_usb_ms_set_param(struct memstick_host *msh,
>         }
>  out:
>         mutex_unlock(&ucr->dev_mutex);
> -       pm_runtime_put(ms_dev(host));
> +       pm_runtime_put_sync(ms_dev(host));
>
>         /* power-on delay */
> -       if (param == MEMSTICK_POWER && value == MEMSTICK_POWER_ON)
> +       if (param == MEMSTICK_POWER && value == MEMSTICK_POWER_ON) {
>                 usleep_range(10000, 12000);
>
> +               if (!host->eject)
> +                       schedule_delayed_work(&host->poll_card, 100);
> +       }
> +
>         dev_dbg(ms_dev(host), "%s: return = %d\n", __func__, err);
>         return err;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM

I think you should keep CONFIG_PM_SLEEP, else this triggers a warning
about unused functions, when CONFIG_PM is set but CONFIG_PM_SLEEP is
unset.

>  static int rtsx_usb_ms_suspend(struct device *dev)
>  {
>         struct rtsx_usb_ms *host = dev_get_drvdata(dev);
>         struct memstick_host *msh = host->msh;
>
> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
> +       /* Since we use rtsx_usb's resume callback to runtime resume its
> +        * children to implement remote wakeup signaling, this causes
> +        * rtsx_usb_ms' runtime resume callback runs after its suspend
> +        * callback:
> +        * rtsx_usb_ms_suspend()
> +        * rtsx_usb_resume()
> +        *   -> rtsx_usb_ms_runtime_resume()
> +        *     -> memstick_detect_change()
> +        *
> +        * rtsx_usb_suspend()
> +        *
> +        * To avoid this, skip runtime resume/suspend if system suspend is
> +        * underway.
> +        */
>
> +       host->system_suspending = true;
>         memstick_suspend_host(msh);
> +
>         return 0;
>  }
>
> @@ -665,58 +683,83 @@ static int rtsx_usb_ms_resume(struct device *dev)
>         struct rtsx_usb_ms *host = dev_get_drvdata(dev);
>         struct memstick_host *msh = host->msh;
>
> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
> -
>         memstick_resume_host(msh);
> +       host->system_suspending = false;
> +
>         return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>
> -/*
> - * Thread function of ms card slot detection. The thread starts right after
> - * successful host addition. It stops while the driver removal function sets
> - * host->eject true.
> - */
> -static int rtsx_usb_detect_ms_card(void *__host)

Because of the above comment, then add:
#ifdef CONFIG_PM

> +static int rtsx_usb_ms_runtime_suspend(struct device *dev)
> +{
> +       struct rtsx_usb_ms *host = dev_get_drvdata(dev);
> +
> +       if (host->system_suspending)
> +               return 0;
> +
> +       if (host->msh->card || host->power_mode != MEMSTICK_POWER_OFF)
> +               return -EAGAIN;
> +
> +       return 0;
> +}
> +
> +static int rtsx_usb_ms_runtime_resume(struct device *dev)
> +{
> +       struct rtsx_usb_ms *host = dev_get_drvdata(dev);
> +
> +
> +       if (host->system_suspending)
> +               return 0;
> +
> +       memstick_detect_change(host->msh);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops rtsx_usb_ms_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(rtsx_usb_ms_suspend, rtsx_usb_ms_resume)
> +       SET_RUNTIME_PM_OPS(rtsx_usb_ms_runtime_suspend, rtsx_usb_ms_runtime_resume, NULL)
> +};
> +
> +#endif /* CONFIG_PM */
> +
> +static void rtsx_usb_ms_poll_card(struct work_struct *work)
>  {
> -       struct rtsx_usb_ms *host = (struct rtsx_usb_ms *)__host;
> +       struct rtsx_usb_ms *host = container_of(work, struct rtsx_usb_ms,
> +                       poll_card.work);
>         struct rtsx_ucr *ucr = host->ucr;
> -       u8 val = 0;
>         int err;
> +       u8 val;
>
> -       for (;;) {
> -               pm_runtime_get_sync(ms_dev(host));
> -               mutex_lock(&ucr->dev_mutex);
> -
> -               /* Check pending MS card changes */
> -               err = rtsx_usb_read_register(ucr, CARD_INT_PEND, &val);
> -               if (err) {
> -                       mutex_unlock(&ucr->dev_mutex);
> -                       goto poll_again;
> -               }
> +       if (host->eject || host->power_mode != MEMSTICK_POWER_ON)
> +               return;
>
> -               /* Clear the pending */
> -               rtsx_usb_write_register(ucr, CARD_INT_PEND,
> -                               XD_INT | MS_INT | SD_INT,
> -                               XD_INT | MS_INT | SD_INT);
> +       pm_runtime_get_sync(ms_dev(host));
> +       mutex_lock(&ucr->dev_mutex);
>
> +       /* Check pending MS card changes */
> +       err = rtsx_usb_read_register(ucr, CARD_INT_PEND, &val);
> +       if (err) {
>                 mutex_unlock(&ucr->dev_mutex);
> +               goto poll_again;
> +       }
>
> -               if (val & MS_INT) {
> -                       dev_dbg(ms_dev(host), "MS slot change detected\n");
> -                       memstick_detect_change(host->msh);
> -               }
> +       /* Clear the pending */
> +       rtsx_usb_write_register(ucr, CARD_INT_PEND,
> +                       XD_INT | MS_INT | SD_INT,
> +                       XD_INT | MS_INT | SD_INT);
>
> -poll_again:
> -               pm_runtime_put(ms_dev(host));
> -               if (host->eject)
> -                       break;
> +       mutex_unlock(&ucr->dev_mutex);
>
> -               schedule_timeout_idle(HZ);
> +       if (val & MS_INT) {
> +               dev_dbg(ms_dev(host), "MS slot change detected\n");
> +               memstick_detect_change(host->msh);
>         }
>
> -       complete(&host->detect_ms_exit);
> -       return 0;
> +poll_again:
> +       pm_runtime_put_sync(ms_dev(host));
> +
> +       if (!host->eject && host->power_mode == MEMSTICK_POWER_ON)
> +               schedule_delayed_work(&host->poll_card, 100);
>  }
>
>  static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
> @@ -747,39 +790,35 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
>         mutex_init(&host->host_mutex);
>         INIT_WORK(&host->handle_req, rtsx_usb_ms_handle_req);
>
> -       init_completion(&host->detect_ms_exit);
> -       host->detect_ms = kthread_create(rtsx_usb_detect_ms_card, host,
> -                       "rtsx_usb_ms_%d", pdev->id);
> -       if (IS_ERR(host->detect_ms)) {
> -               dev_dbg(&(pdev->dev),
> -                               "Unable to create polling thread.\n");
> -               err = PTR_ERR(host->detect_ms);
> -               goto err_out;
> -       }
> +       INIT_DELAYED_WORK(&host->poll_card, rtsx_usb_ms_poll_card);
>
>         msh->request = rtsx_usb_ms_request;
>         msh->set_param = rtsx_usb_ms_set_param;
>         msh->caps = MEMSTICK_CAP_PAR4;
>
> -       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_active(ms_dev(host));
> +       pm_runtime_enable(ms_dev(host));
> +
> +       pm_runtime_get_sync(ms_dev(host));

I would rather re-place/re-order this with:

pm_runtime_get_noresume()
pm_runtime_set_active()
pm_runtime_enable()


>         err = memstick_add_host(msh);
>         if (err)
>                 goto err_out;
>
> -       wake_up_process(host->detect_ms);
> +       pm_runtime_put(ms_dev(host));
> +
>         return 0;
>  err_out:
>         memstick_free_host(msh);

Looks like you need a pm_runtime_disable(); here as well. However,
that seems like an existing bug, perhaps it deserves it own change.

> +       pm_runtime_put_noidle(ms_dev(host));
>         return err;
>  }
>

[...]

Kind regards
Uffe
