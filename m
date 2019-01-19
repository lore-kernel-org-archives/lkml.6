Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ADC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FC02084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY/vpDZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfASM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:27:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39778 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfASM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:27:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so18236031qtj.6;
        Sat, 19 Jan 2019 04:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mxLZ2ljrOOiZoM6/944zh2i8w3FeYz9CqhIKDHNZPK8=;
        b=FY/vpDZPe3uZMbzL71zfoZcUgfRhujARaiuFQc2jZsKm6QeXRcxCOQS9rKw4jbpLn6
         dej7d3cN4k5rH8cua2NTIJ+YXICENqtiaJ03Ow8n68AMNRQhfuxV0KPdWoF1KvsNMke5
         ycHygVD7rSKBjoFUq5ghM2wvnPwXA4quQ7WcWUdC6F90KBEamRFDE+U5JFGKrf4mBBrU
         ItwzgEpAvUNGCRZMUkB//ROsKsm12Y6g3Q0fP5OO5mmUxZfoKqfGsxzttMj8LuSXb3Av
         UGU6kiXDsiiMnePueQrnTfVYIWDbPr5ij7xNBgW8aNJpam39l0PAo1D5/i0Fzsd7fpXl
         5F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mxLZ2ljrOOiZoM6/944zh2i8w3FeYz9CqhIKDHNZPK8=;
        b=PKQ+HY7175BqU7dOjdXIzJe6zsEWhSd4UkszKk0txf326SKPLZ3KvIpMphwVS4sEGP
         bRcO6858yj4JphVizgIKuht0XC3FQrdOPCHNHsgb8aUuOjjf6C3+ztrXmHlOr9sTUCFj
         M1BbOpo35C+XR2lvkU7URWcCSAsRN4V0AwnrhwK5DWL//hyqNQ9Kaf2GInEP5VdpJhPj
         KllK5ET3P1fkiau0hsY4y/t3VfIeM/4X0aO5ho++GtkIvUqYphBJr7+fdbwIYEXFiwfi
         waMezqQgQ+/43S8N50UwVU9eEGfh+WLI5LaXvBm42D5EOGSSo/DR57tmvDc/6hl6n1rM
         LSIw==
X-Gm-Message-State: AJcUukcQ8kj2sljx/MITIBC2fxKAZPHzX2bv2dmW2e0A/vf7tM6qJSMH
        0/eTkEJEzZK4uHNKUVeyVt3Odi33MUG7kMgMcn8=
X-Google-Smtp-Source: ALg8bN4vE0Ze4u/rlWwdy0HvTE2ri6UKGOXdiuQwTM9emujhOMMIbRb4+f3xCxOSEBJQ2mwWMd1LvwcYLfGA5T1YCRU=
X-Received: by 2002:aed:2803:: with SMTP id r3mr19431555qtd.316.1547900864208;
 Sat, 19 Jan 2019 04:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20190119050256.22520-1-tiny.windzz@gmail.com>
In-Reply-To: <20190119050256.22520-1-tiny.windzz@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 19 Jan 2019 21:27:08 +0900
Message-ID: <CAGTfZH33xt9xtNF=uvFMLQ9U68UuePQ_zVwtm7juhHK=pxh_jA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: fix mem leak and missing check of return
 value in devfreq_add_device()
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

2019=EB=85=84 1=EC=9B=94 19=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 2:03, Y=
angtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 'devfreq' is malloced in devfreq_add_device() and should be freed in
> the error handling cases, otherwise it will cause memory leak.
>
> devm_kzalloc() could fail, so insert a check of its return value. And
> if it fails, returns -ENOMEM.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..fe6c157cb7e0 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>                 mutex_unlock(&devfreq->lock);
>                 err =3D set_freq_table(devfreq);
>                 if (err < 0)
> -                       goto err_out;
> +                       goto err_dev;
>                 mutex_lock(&devfreq->lock);
>         }
>
> @@ -683,16 +683,27 @@ struct devfreq *devfreq_add_device(struct device *d=
ev,
>                 goto err_out;
>         }
>
> -       devfreq->trans_table =3D
> -               devm_kzalloc(&devfreq->dev,
> -                            array3_size(sizeof(unsigned int),
> -                                        devfreq->profile->max_state,
> -                                        devfreq->profile->max_state),
> -                            GFP_KERNEL);
> +       devfreq->trans_table =3D devm_kzalloc(&devfreq->dev,
> +                                           array3_size(sizeof(unsigned i=
nt),
> +                                           devfreq->profile->max_state,
> +                                           devfreq->profile->max_state),
> +                                           GFP_KERNEL);

The above 10 ten lines are not related to the memory leak for this
patch. If you want to fix the indentation, you have to make it
separately.

> +       if (!devfreq->trans_table) {
> +               mutex_unlock(&devfreq->lock);
> +               err =3D -ENOMEM;
> +               goto err_devfreq;
> +       }
> +
>         devfreq->time_in_state =3D devm_kcalloc(&devfreq->dev,
> -                                               devfreq->profile->max_sta=
te,
> -                                               sizeof(unsigned long),
> -                                               GFP_KERNEL);
> +                                             devfreq->profile->max_state=
,
> +                                             sizeof(unsigned long),
> +                                             GFP_KERNEL);

ditto. The above 6 ten lines are not related to the memory leak for
this patch. If you want to fix the indentation, you have to make it
separately.

> +       if (!devfreq->time_in_state) {
> +               mutex_unlock(&devfreq->lock);
> +               err =3D -ENOMEM;
> +               goto err_devfreq;
> +       }
> +
>         devfreq->last_stat_updated =3D jiffies;
>
>         srcu_init_notifier_head(&devfreq->transition_notifier_list);
> @@ -726,7 +737,7 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>
>  err_init:
>         mutex_unlock(&devfreq_list_lock);
> -
> +err_devfreq:
>         devfreq_remove_device(devfreq);
>         devfreq =3D NULL;
>  err_dev:

Also, you better to add following codes to free the memory of
'devfreq->trans_table' and 'devfreq->time_in_state' because this patch
handles the memory leak of 'trans_table' and 'time_in_state'
variables.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..945f5f1 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -593,6 +593,9 @@ static void devfreq_dev_release(struct device *dev)
                devfreq->profile->exit(devfreq->dev.parent);

        mutex_destroy(&devfreq->lock);
+       kfree(devfreq->trans_table);
+       kfree(devfreq->time_in_state);
        kfree(devfreq);
 }

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
