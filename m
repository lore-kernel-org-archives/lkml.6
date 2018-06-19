Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D0C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D24C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoK2AQ60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D24C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030462AbeFSUcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:32:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43815 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967224AbeFSUcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:32:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id y89-v6so1021193qtd.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ht4eZixTn5+tjkWxF8iFQ8lGmj1j45/TFrf+OTnnwc8=;
        b=qoK2AQ60MnL2GIrwTkJlLB3YM+fekvB5lF7sgq8IuBREZKQ7smbi/mLBqEqUAZkwOd
         Kdly7O01QuIagZwQDhBzCo3sxLm7uZszsJ8kLfUkBoaXjcGyPGi0foZAhlr/r5qlb6VA
         MVSW67I/Iy2Tsi2FjH0t80YNUlv6l2sKqiRsYBjKJlogBIgG1rkCyHBaSRLuq9oqwy4O
         198uwZWosRyLCT+zQsT5ggmP/Oc5yfhT+OFN5AizUNedS0XFtGYxylduecH54JHR/cxS
         oqI6KqvHNdTuLQqTRPllXdiMk9bOCxBD8bJPBGn0B6a03zGF+m4t7XN9QhuZrHssa3Fr
         zByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ht4eZixTn5+tjkWxF8iFQ8lGmj1j45/TFrf+OTnnwc8=;
        b=C/E11KLsbvISOEagl7O2QR1HecFXHb9GjTI1sXspHiGAdzalPh4umg08Aew6Skg1k2
         Z1w9P5WreVT48KASADrTJCJpVuA5B3wVeACPMeJntpuoJha2ZVjUJgnMEoo2l6HWpYD/
         o9B2JJx27bhnCI+pqNOdGIf6srsJ+Ha2LDYr2o/NY8aNGyeJz07uxtgNkJ3k4vW0+vqX
         i1qHk9pzob0JkyVhUSpBJEGT29h8QJ8frR4wQyqj8Acqv9Z7hLhQE6eqzJ198Mp90MhQ
         VVOCjSv58aA3L8RzFn8qKL0ukb1urDldzt8tHDnayeCg9ttHPlk/X6wxbWn27NgiIqZL
         vDSQ==
X-Gm-Message-State: APt69E0OLkzsDK5iC3VK4z57lvPGTDgqq3JPFHBxAVwAcBvYptw2Wx8z
        0QevqhQf1g82SUghYehq2j0exuhkl/eobEd6yrM=
X-Google-Smtp-Source: ADUXVKKFJJwJgzhmtdDbuPDvDElSlwjfwRYLudn2ZqU83r66s4k6a3hag4S4D1msY4T2i+R389PqswrIHLUdwXCBAU0=
X-Received: by 2002:a0c:b3d5:: with SMTP id b21-v6mr15787037qvf.80.1529440351106;
 Tue, 19 Jun 2018 13:32:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3f3d:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:32:30
 -0700 (PDT)
In-Reply-To: <4C5FD65B.8080800@gmail.com>
References: <i3n3dh$t48$1@dough.gmane.org> <20100809063742.GA1632@arch.tripp.de>
 <20100809083053.GB2169@osiris.boeblingen.de.ibm.com> <20100809083451.GC2169@osiris.boeblingen.de.ibm.com>
 <4C5FC49B.9040208@kernel.org> <4C5FCC14.6030901@gmail.com>
 <20100809094630.GA1603@arch.tripp.de> <4C5FCF0C.2000100@gmail.com>
 <4C5FD1D1.9060302@gmail.com> <20100809101406.GA1633@arch.tripp.de> <4C5FD65B.8080800@gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 20 Jun 2018 06:32:30 +1000
Message-ID: <CAPM=9tw4qhaW0N4WQywfg9D7eb672FGrd4gfReDZhadSNRZYjQ@mail.gmail.com>
Subject: Re: [PATCH] drm: fix fallouts from slow-work -> wq conversion
To:     Tejun Heo <htejun@gmail.com>
Cc:     Markus Trippelsdorf <markus@trippelsdorf.de>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>, walt <w41ter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 August 2010 at 20:20, Tejun Heo <htejun@gmail.com> wrote:
> >From 9a919c46dfa48a9c1f465174609b90253eb8ffc1 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 9 Aug 2010 12:01:27 +0200
>
> Commit 991ea75c (drm: use workqueue instead of slow-work), which made
> drm to use wq instead of slow-work, didn't account for the return
> value difference between delayed_slow_work_enqueue() and
> queue_delayed_work().  The former returns 0 on success and -errno on
> failures while the latter never fails and only uses the return value
> to indicate whether the work was already pending or not.
>
> This misconversion triggered spurious error messages.  Remove the now
> unnecessary return value check and error message.
>
> Markus: caught another incorrect conversion in drm_kms_helper_poll_enable()

Acked-by: David Airlie <airlied@linux.ie>

For queuing via your tree.

Thanks,
Dave.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Markus Trippelsdorf <markus@trippelsdorf.de>
> Tested-by: Markus Trippelsdorf <markus@trippelsdorf.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> ---
> Oops, you're right.  So, this should do it.
>
> Thank you.
>
>  drivers/gpu/drm/drm_crtc_helper.c |   16 ++++------------
>  1 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index 4598130..b9e4dbf 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -839,7 +839,6 @@ static void output_poll_execute(struct work_struct *work)
>         struct drm_connector *connector;
>         enum drm_connector_status old_status, status;
>         bool repoll = false, changed = false;
> -       int ret;
>
>         mutex_lock(&dev->mode_config.mutex);
>         list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> @@ -874,11 +873,8 @@ static void output_poll_execute(struct work_struct *work)
>                         dev->mode_config.funcs->output_poll_changed(dev);
>         }
>
> -       if (repoll) {
> -               ret = queue_delayed_work(system_nrt_wq, delayed_work, DRM_OUTPUT_POLL_PERIOD);
> -               if (ret)
> -                       DRM_ERROR("delayed enqueue failed %d\n", ret);
> -       }
> +       if (repoll)
> +               queue_delayed_work(system_nrt_wq, delayed_work, DRM_OUTPUT_POLL_PERIOD);
>  }
>
>  void drm_kms_helper_poll_disable(struct drm_device *dev)
> @@ -893,18 +889,14 @@ void drm_kms_helper_poll_enable(struct drm_device *dev)
>  {
>         bool poll = false;
>         struct drm_connector *connector;
> -       int ret;
>
>         list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
>                 if (connector->polled)
>                         poll = true;
>         }
>
> -       if (poll) {
> -               ret = queue_delayed_work(system_nrt_wq, &dev->mode_config.output_poll_work, DRM_OUTPUT_POLL_PERIOD);
> -               if (ret)
> -                       DRM_ERROR("delayed enqueue failed %d\n", ret);
> -       }
> +       if (poll)
> +               queue_delayed_work(system_nrt_wq, &dev->mode_config.output_poll_work, DRM_OUTPUT_POLL_PERIOD);
>  }
>  EXPORT_SYMBOL(drm_kms_helper_poll_enable);
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
