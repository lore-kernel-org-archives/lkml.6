Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E31C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298492080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s29CI/X5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404599AbfBNONe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:13:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33336 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387611AbfBNONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:13:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so7005567qtz.0;
        Thu, 14 Feb 2019 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=82Eoim/sp9OokMECnUSQZdyG6roLp6zl++a2hyeJwBE=;
        b=s29CI/X5ewXuhUGSnqf6rC+Hyi0hNSSCM5zbCAGe1CLPhhaZCppjl+k13Kvd0cQBGv
         1H9AAj16cy62cWYXAPciSlcoI+ToMePg7KVNrC7mKbAU88BTfiHWGCxztQERlE0uYmiD
         RoVEoxbVSAbPDecK4vlrQjToUZNluMGDJRvD6Yj8RlzdGHvVEHWnN0V5OI8eyPnRyibr
         vUwdpNJ0l+O2NLnN2qLebwKEQtSOUFUH8oRZ2kAslcDqzvOGkKAAD+dA7+Hqrgb2/quH
         tGhDdHHqNWIuwFfN5URgPAAmVi1f1gz8P76XMlww6rNbkYvX8apgD0FqWAsywC6HtOT2
         YLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=82Eoim/sp9OokMECnUSQZdyG6roLp6zl++a2hyeJwBE=;
        b=lkId2vt5TBCKncMbvLu+bPPNYoG4o0Lx+3+UlU+XeANoJBocJo4ac6bWhi9kehjQzk
         /qQSh6NL37+vk0LU3ptdhxqzWAS7IXR4OUofiXIzVenjLUmetGyMkmMIzxKPv0hh2v4e
         eLf5LS/QYkViU7e46alrVsDu3z+TaVLwqXqVWVofJ1Ht7mC/32AMuUaUULaCQK74qDbW
         HvvmypaP852GsQYEvbnTO0BOakXA6RmlesnD2UTmyP+EJBTtHaAij8htPVEiFSc83qi7
         gWUPQMkcrPbEErWc9Vy0IPO+EHxdrMMXT5HM6q9zokNZK17aFU+TH3mm7ZFuuT8ymWSt
         cXRQ==
X-Gm-Message-State: AHQUAuZBaFe3dbOqrUGdvFVWizMD4Sz1xVTocw/P0d1AShLNv3xq6n41
        WVBTke2tDAo2hMcOj/8KoKdnRvL8ubudsdofZOk=
X-Google-Smtp-Source: AHgI3IbHI4GnsD3Amq1+KtkqMRUXZ65vZ0YUCSu8JiRoyoBz0dJYnszqarfuxkSSjoGh9wHt85UC8tK9YEK68AdJ2H8=
X-Received: by 2002:a0c:d237:: with SMTP id m52mr3032532qvh.219.1550153611840;
 Thu, 14 Feb 2019 06:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20190214013042.254790-1-mka@chromium.org> <20190214013042.254790-4-mka@chromium.org>
In-Reply-To: <20190214013042.254790-4-mka@chromium.org>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 14 Feb 2019 23:12:55 +0900
Message-ID: <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
Subject: Re: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
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

Looks good to me for making the function to remove the duplicate code.
But,  When I just tested the kernel build, following warnings occur
about devfreq_governor_stop().

In file included from ./include/linux/devfreq.h:16:0,
                 from drivers/devfreq/devfreq.c:23:
drivers/devfreq/devfreq.c: In function =E2=80=98devfreq_governor_stop=E2=80=
=99:
drivers/devfreq/devfreq.c:619:17: warning: format =E2=80=98%s=E2=80=99 expe=
cts
argument of type =E2=80=98char *=E2=80=99, but argument 4 has type =E2=80=
=98int=E2=80=99 [-Wformat=3D]
   dev_warn(dev, "%s: Governor %s not stopped: %d\n",
                 ^
./include/linux/device.h:1380:22: note: in definition of macro =E2=80=98dev=
_fmt=E2=80=99
 #define dev_fmt(fmt) fmt
                      ^
drivers/devfreq/devfreq.c:619:3: note: in expansion of macro =E2=80=98dev_w=
arn=E2=80=99
   dev_warn(dev, "%s: Governor %s not stopped: %d\n",
   ^
drivers/devfreq/devfreq.c:619:17: warning: format =E2=80=98%d=E2=80=99 expe=
cts a
matching =E2=80=98int=E2=80=99 argument [-Wformat=3D]
   dev_warn(dev, "%s: Governor %s not stopped: %d\n",
                 ^
./include/linux/device.h:1380:22: note: in definition of macro =E2=80=98dev=
_fmt=E2=80=99
 #define dev_fmt(fmt) fmt
                      ^
drivers/devfreq/devfreq.c:619:3: note: in expansion of macro =E2=80=98dev_w=
arn=E2=80=99
   dev_warn(dev, "%s: Governor %s not stopped: %d\n",

2019=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:16, M=
atthias Kaehlcke <mka@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The following pattern is repeated multiple times:
>
> - call governor event handler with DEVFREQ_GOV_START/STOP
> - check return value
> - in case of error log a message
>
> Add devfreq_governor_start/stop() helper functions with this code
> and call them instead.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 96 +++++++++++++++++++++++----------------
>  1 file changed, 58 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7fab6c4cf719b..eb86461648d74 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -580,6 +580,53 @@ static int devfreq_notifier_call(struct notifier_blo=
ck *nb, unsigned long type,
>         return ret;
>  }
>
> +/**
> + * devfreq_governor_start() - Start the devfreq governor of the device.
> + * @devfreq:   the devfreq instance
> + */
> +static int devfreq_governor_start(struct devfreq *devfreq)
> +{
> +       struct device *dev =3D devfreq->dev.parent;
> +       int err;
> +
> +       if (WARN(mutex_is_locked(&devfreq->lock),
> +                "mutex must *not* be held by the caller\n"))
> +               return -EINVAL;
> +
> +       err =3D devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STA=
RT,
> +                                              NULL);
> +       if (err) {
> +               dev_err(dev, "Governor %s not started: %d\n",
> +                       devfreq->governor->name, err);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * devfreq_governor_stop() - Stop the devfreq governor of the device.
> + * @devfreq:   the devfreq instance
> + */
> +static int devfreq_governor_stop(struct devfreq *devfreq)
> +{
> +       struct device *dev =3D devfreq->dev.parent;
> +       int err;
> +
> +       if (WARN(mutex_is_locked(&devfreq->lock),
> +                "mutex must *not* be held by the caller\n"))
> +               return -EINVAL;
> +
> +       err =3D devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STO=
P, NULL);
> +       if (err) {
> +               dev_warn(dev, "%s: Governor %s not stopped: %d\n",
> +                        devfreq->governor->name, err);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the dev=
ice.
>   * @dev:       the devfreq device
> @@ -720,13 +767,9 @@ struct devfreq *devfreq_add_device(struct device *de=
v,
>         }
>
>         devfreq->governor =3D governor;
> -       err =3D devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STA=
RT,
> -                                               NULL);
> -       if (err) {
> -               dev_err(dev, "%s: Unable to start governor for the device=
\n",
> -                       __func__);
> +       err =3D devfreq_governor_start(devfreq);
> +       if (err)
>                 goto err_init;
> -       }
>
>         list_add(&devfreq->node, &devfreq_list);
>
> @@ -1029,24 +1072,13 @@ int devfreq_add_governor(struct devfreq_governor =
*governor)
>                                 dev_warn(dev,
>                                          "%s: Governor %s already present=
\n",
>                                          __func__, devfreq->governor->nam=
e);
> -                               ret =3D devfreq->governor->event_handler(=
devfreq,
> -                                                       DEVFREQ_GOV_STOP,=
 NULL);
> -                               if (ret) {
> -                                       dev_warn(dev,
> -                                                "%s: Governor %s stop =
=3D %d\n",
> -                                                __func__,
> -                                                devfreq->governor->name,=
 ret);
> -                               }
> +                               ret =3D devfreq_governor_stop(devfreq);
> +
>                                 /* Fall through */
>                         }
> +
>                         devfreq->governor =3D governor;
> -                       ret =3D devfreq->governor->event_handler(devfreq,
> -                                               DEVFREQ_GOV_START, NULL);
> -                       if (ret) {
> -                               dev_warn(dev, "%s: Governor %s start=3D%d=
\n",
> -                                        __func__, devfreq->governor->nam=
e,
> -                                        ret);
> -                       }
> +                       devfreq_governor_start(devfreq);
>                 }
>         }
>
> @@ -1081,7 +1113,6 @@ int devfreq_remove_governor(struct devfreq_governor=
 *governor)
>                 goto err_out;
>         }
>         list_for_each_entry(devfreq, &devfreq_list, node) {
> -               int ret;
>                 struct device *dev =3D devfreq->dev.parent;
>
>                 if (!strncmp(devfreq->governor_name, governor->name,
> @@ -1093,13 +1124,8 @@ int devfreq_remove_governor(struct devfreq_governo=
r *governor)
>                                 continue;
>                                 /* Fall through */
>                         }
> -                       ret =3D devfreq->governor->event_handler(devfreq,
> -                                               DEVFREQ_GOV_STOP, NULL);
> -                       if (ret) {
> -                               dev_warn(dev, "%s: Governor %s stop=3D%d\=
n",
> -                                        __func__, devfreq->governor->nam=
e,
> -                                        ret);
> -                       }
> +
> +                       devfreq_governor_stop(devfreq);
>                         devfreq->governor =3D NULL;
>                 }
>         }
> @@ -1149,19 +1175,13 @@ static ssize_t governor_store(struct device *dev,=
 struct device_attribute *attr,
>         }
>
>         if (df->governor) {
> -               ret =3D df->governor->event_handler(df, DEVFREQ_GOV_STOP,=
 NULL);
> -               if (ret) {
> -                       dev_warn(dev, "%s: Governor %s not stopped(%d)\n"=
,
> -                                __func__, df->governor->name, ret);
> +               ret =3D devfreq_governor_stop(df);
> +               if (ret)
>                         goto out;
> -               }
>         }
>         df->governor =3D governor;
>         strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
> -       ret =3D df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> -       if (ret)
> -               dev_warn(dev, "%s: Governor %s not started(%d)\n",
> -                        __func__, df->governor->name, ret);
> +       ret =3D devfreq_governor_start(df);
>  out:
>         mutex_unlock(&devfreq_list_lock);
>
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


--=20
Best Regards,
Chanwoo Choi
