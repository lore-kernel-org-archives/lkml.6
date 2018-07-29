Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77384C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EAB20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpvocCtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EAB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeG3AH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 20:07:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36243 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeG3AHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 20:07:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id n21-v6so17975585oig.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGXjudSXbMqpGtwtp4Fl8ptFkSd3qc43by/CY/mgIYE=;
        b=hpvocCtp+ncC2e+Tx5WfpGrnJvM5VdDDGXYI8LGgIYt5VpN75Kum4XuiH0mDOUk74c
         WA3dW0MumTIos3HSvtVfalNJjAx2PUnFSEk5DUPp7zlq+AtgR7bvAc09neKUbFBa11IL
         lUt1jbsczr3bg0Jk8VItyzNj8f0uRBy5kdZYzNRxSzHuc1FaJ36WejkNmJMQIsitXilt
         d+iDdMxnbAcv7SQpR90DRzs5FC4a8aernepy3OGpGxqadUqGBfubpFtOlnZOUEoab2XI
         bgr5MukFqKhcZrtEPGiNMUDH55UZWJOAdSMzwcoiALQ8Nl0STGNOu3fQcDbv+qeD4Ub9
         p4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGXjudSXbMqpGtwtp4Fl8ptFkSd3qc43by/CY/mgIYE=;
        b=ju7Xxc71nEUaLw0CmLwt+twkv6nAFFExgqIm+pxWkPmxfQi/ZiY4DXVBTUwgi4xRJq
         gaIYXZDpPKnLCx3OUnCgk0/YD2mhbCqEKoZebgXC6rWl+129jWWb7qo4wcuApkz5mtcE
         apWAWojjt9YvB/va59NL33nhlwpps/YLTQ3jThd5FEDN+FGMMLldbCgmSo3wrEEzYr5+
         0B4AN5RNHuS9nyjtjVMAeS2h/Q832Mq5bPFPGUEIYeHSblT8y9iUtFiD0QFxlOyeAIxw
         ofqvKKtxmSLk0FSAmUOEcxqgXqyJuqAxwLFfX2Y02pbi59vu7WhQ1YZEEKFsukKTko6F
         o85A==
X-Gm-Message-State: AOUpUlGP5pINJ8defTPaSAHrhz1ENg8VYAyGo6SG5l1oQU+FG2PpGsUd
        XU1kLuxW96V2mnrAwZaMDApuLJP7EDAp1s2Wus0mYw==
X-Google-Smtp-Source: AAOMgpeJbGMvWCGjUQjUQWd5REW+3+cd3xyIe0CmnMkaSj13hLKik5veVt4PPcVlhZQ1pNuayprHWIxSEO0cQsrZJO4=
X-Received: by 2002:aca:cd84:: with SMTP id d126-v6mr16712571oig.325.1532903718924;
 Sun, 29 Jul 2018 15:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180729144358.3442-1-tsotsos@gmail.com> <233f0f7b1165f6427fa86f026c4e7dcb5cafe35f.camel@perches.com>
In-Reply-To: <233f0f7b1165f6427fa86f026c4e7dcb5cafe35f.camel@perches.com>
From:   Georgios Tsotsos <tsotsos@gmail.com>
Date:   Mon, 30 Jul 2018 01:35:07 +0300
Message-ID: <CADERADNz1_ep8pC0fuHXHKzn7Ap6MCpgeR33q95jAUKcNB72UA@mail.gmail.com>
Subject: Re: [PATCH] Staging: octeon: Fixing coding style for minor notices.
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Smith <catalinnow@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, i found a few case on this module i will try to fix them
and send a new patch series.
On Sun, 29 Jul 2018 at 20:33, Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2018-07-29 at 17:43 +0300, Georgios Tsotsos wrote:
> > Fixing coding style for a few lines that were reported to check from
> > checkpatch.pl in minor cases for alignment and ending with parenthesis.
> >
> > Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> > ---
> >  drivers/staging/octeon/ethernet.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> > index 9b15c9ed844b..1e258deecacc 100644
> > --- a/drivers/staging/octeon/ethernet.c
> > +++ b/drivers/staging/octeon/ethernet.c
> > @@ -141,8 +141,8 @@ static void cvm_oct_periodic_worker(struct work_struct *work)
> >       if (priv->poll)
> >               priv->poll(cvm_oct_device[priv->port]);
> >
> > -     cvm_oct_device[priv->port]->netdev_ops->ndo_get_stats(
> > -                                             cvm_oct_device[priv->port]);
> > +     cvm_oct_device[priv->port]->netdev_ops
> > +                             ->ndo_get_stats(cvm_oct_device[priv->port]);
> >
> >       if (!atomic_read(&cvm_oct_poll_queue_stopping))
> >               schedule_delayed_work(&priv->port_periodic_work, HZ);
>
> Probably more sensible to use a temporary.  Something like:
> ---
>  drivers/staging/octeon/ethernet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index 9b15c9ed844b..2febf1229587 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -137,12 +137,12 @@ static void cvm_oct_periodic_worker(struct work_struct *work)
>         struct octeon_ethernet *priv = container_of(work,
>                                                     struct octeon_ethernet,
>                                                     port_periodic_work.work);
> +       struct net_device *ndev = cvm_oct_device[priv->port];
>
>         if (priv->poll)
> -               priv->poll(cvm_oct_device[priv->port]);
> +               priv->poll(ndev);
>
> -       cvm_oct_device[priv->port]->netdev_ops->ndo_get_stats(
> -                                               cvm_oct_device[priv->port]);
> +       ndev->netdev_ops->ndo_get_stats(ndev);
>
>         if (!atomic_read(&cvm_oct_poll_queue_stopping))
>                 schedule_delayed_work(&priv->port_periodic_work, HZ);
>
>


-- 
Best regards!
Georgios Tsotsos
Greece-Evia-Chalkida
tsotsos@linux.com
skype: tsotsos
------------------------------------
Georgios Tsotsos
*Greece - Evia - Chalkida*
tsotsos[at]linux.com
skype: tsotsos
