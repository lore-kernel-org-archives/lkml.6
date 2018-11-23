Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA59C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E38F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="EebVeko2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E38F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503150AbeKWUsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:48:47 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43575 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393839AbeKWUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:48:47 -0500
Received: by mail-vk1-f195.google.com with SMTP id o130so2545288vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YUd68lT+Nbs1CuYWfgadotcTcrWCer+xWXfaNUArWhM=;
        b=EebVeko2mmI5SWtPIR/svf3tE1WPbBR+a6wqVVBgi2l2k4J6oIBkZnhiDXBs7L5ToE
         c9mz7ptIEZ+nF8T3Y0lVBLAMT1Sz41raMant5AZveh9rKMsd6W6aUmq2umPcoHLhswbk
         aV0LzE/8jM4p3hosvcL5qg10piQW5PT/KP2/0Fr/P3XaYgDQwqljvEgH+3WuYx/PCpGJ
         gb/Hy1sB3jyE3r+xcsJMihNxA4Kwmvu9Ea+aygpE1ydzqV6u311LLnWsgPJ5PnbFk0Xa
         EKHY1vSP59SOrHfBMsXaZoqlsgWFzA7ud92yzcisAxgHzc3pLOSSv/xumsk1+JBXulyZ
         GboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YUd68lT+Nbs1CuYWfgadotcTcrWCer+xWXfaNUArWhM=;
        b=gpmgX+O+BCY2kKsipSDz8IRBJRS6npjE6zWEznmJaJrEFrUB/aq7orJ0OpffRaP/hr
         lO0Pb45FI+06jRyVNcOAZXYk/5Su7u0xgfhnYea2Pdj8XjB9QRotReP0ePf3tJaubHBX
         W/raSe1w2IG9JgJVWdynk7AzxSqZHOZtvOe6eNG8xu9jflaStiPAvlR85XEnk1xm/HhC
         S27rwkVWLPb4sNrzEvVW6iWnK7qtRll35+SXa1mNYOOk32C4oU+cjAt8E2LnozbndT4E
         XLq6Vr8nr7tFsI4HK2INpdzp9+ViKw3HmIql2WfB89DBkEDdCX9MGgW2lleWd07d5pXu
         fRBQ==
X-Gm-Message-State: AA+aEWZ3TAyGOh/5HWeKLVIgGg6M31PrhalhvqEdalWmHqhKtVSdGCxv
        CUGy1Wg/ksHfFfPCAZRdTgLl5GfZYlaPVdppAjuk/majORw=
X-Google-Smtp-Source: AFSGD/X33K6U3n0oOIT1K2p9wXWxpWqmndNvaTQGhe3/o+R6jjwYuaaxCVxk6T0+TwtwwjkW1KT4pBkgtvv6ImnwLA8=
X-Received: by 2002:a1f:8b48:: with SMTP id n69mr5988322vkd.12.1542967509671;
 Fri, 23 Nov 2018 02:05:09 -0800 (PST)
MIME-Version: 1.0
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com> <1542894410-14047-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1542894410-14047-2-git-send-email-javier@cnexlabs.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 23 Nov 2018 11:04:58 +0100
Message-ID: <CANr-nt2XMzZnd309pY7QJxYXWMSuXXrcWMt8F=pa49BzARb5dg@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: avoid ref warning on cache creation
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great catch Javier! Nice refactoring work too.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
On Thu, Nov 22, 2018 at 2:47 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> The current kref implementation around pblk global caches triggers a
> false positive on refcount_inc_checked() (when called) as the kref is
> initialized to 0. Instead of usint kref_inc() on a 0 reference, which is
> in principle correct, use kref_init() to avoid the check. This is also
> more explicit about what actually happens on cache creation.
>
> In the process, do a small refactoring to use kref helpers.
>
> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-init.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 13822594647c..e225bd60cbb4 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -350,23 +350,19 @@ static int pblk_create_global_caches(void)
>
>  static int pblk_get_global_caches(void)
>  {
> -       int ret;
> +       int ret =3D 0;
>
>         mutex_lock(&pblk_caches.mutex);
>
> -       if (kref_read(&pblk_caches.kref) > 0) {
> -               kref_get(&pblk_caches.kref);
> -               mutex_unlock(&pblk_caches.mutex);
> -               return 0;
> -       }
> +       if (kref_get_unless_zero(&pblk_caches.kref))
> +               goto out;
>
>         ret =3D pblk_create_global_caches();
> -
>         if (!ret)
> -               kref_get(&pblk_caches.kref);
> +               kref_init(&pblk_caches.kref);
>
> +out:
>         mutex_unlock(&pblk_caches.mutex);
> -
>         return ret;
>  }
>
> --
> 2.7.4
>
