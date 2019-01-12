Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B31214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJgMTxdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfALS2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:28:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34784 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfALS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:28:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id q8so8443780qke.1;
        Sat, 12 Jan 2019 10:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p29PLyr0BPhZLh5vERSIH6e/m0+cY7CVM5A2hjYAp+c=;
        b=aJgMTxdYxu8EapLVjUu0B/rxrL01uSkqoHjkaCdAV4L2f2XtKwHnNhnhEIuM4ITHnB
         ATYer4kTbREIA05CqwIoAACeUR37LR9d+tIEgPLoA+oeP8bAFR+dOxCPqnTdyb58t7gz
         68GmP5i/5VhJ9x+1f06x/BbtGFRPiMiWSr1PNET6HBLnB4BQPNjTY9/hiLguSXRoNK0a
         Ba2DqceksTdHvgZlIaWXWvOnbqMqHgJxjxa+U7ctQzeD6pLEDmRnFRi5rtUq1OzwfMLc
         KQzh4snBN5JEyJdMfJGWvOeIdrDirqY2nZqxzhSD89bHp6Q9XZNsh6m0+UdQIbKCZOMN
         HFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p29PLyr0BPhZLh5vERSIH6e/m0+cY7CVM5A2hjYAp+c=;
        b=jvkw2oklehfe/3iKQyHlsXHBzycALO0pAC7zZzLD7Mg/+aJKj6OtTQ4teXVvwbL9vy
         6sHWhvv4Vd+SG466OOgHjWkPHjN+PvTJIxa7kO0/z7l+CMEeogYGbEipRedt96e9km/i
         mg3H+Yux7TBBVo4z6kB+wAJ8XHW4pjZZP4g5qu4iqDdZyaGno39K36lzvdVaNTwIFwH1
         RE+cSZpVdnVirYsCjBA85Ag7w3FdjArNcg75JvYo/l4tMrzhgiP0cLvO+exeWw1kM3eF
         xwq0yUzpZRUWmh99x8xWKOwD0pH30yVBjOhU0At2JGAersvVAJdVrK/RhXkGF3WEU6Qw
         xnvQ==
X-Gm-Message-State: AJcUukcwgbR/Z8SU6RNdlszsgjFcwGvz5cE1CSu2r2nYjh8JZTZVNORG
        5bnfO4npIaKzC0CpaXrDzu0s8FTc1nohTKCp9jk=
X-Google-Smtp-Source: ALg8bN5fvpyi1zaeuPecdG5sw7ZPDA7h959CrVe0DdSxdl4DW5UsIlm2aOwMn9W4S4RAIWNGUx6O3lAEjBP9KGKe4Xk=
X-Received: by 2002:a37:9442:: with SMTP id w63mr16717959qkd.109.1547317732561;
 Sat, 12 Jan 2019 10:28:52 -0800 (PST)
MIME-Version: 1.0
References: <1547031403-34535-1-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1547031403-34535-1-git-send-email-loic.pallardy@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Sun, 13 Jan 2019 02:28:41 +0800
Message-ID: <CAH2Cfb_4qFAEjiANLpRmQL5o9-JCPHCBULLz5-r=zbK9EwiT_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] remoteproc: fix recovery procedure
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org,
        s-anna@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,
The change just hide the problem, I think. The big issue is:
1.virtio devices aren't destroyed by rpproc_stop
2.and then rpmsg child devices aren't destroyed too
Then, when the remote start and create rpmsg channel again, the
duplicated channel will appear in kernel.
To fix this problem, we need go through rpproc_shutdown/rproc_boot to
destroy all devices(virtio and rpmsg) and create them again.

Thanks
Xiang

On Wed, Jan 9, 2019 at 6:56 PM Loic Pallardy <loic.pallardy@st.com> wrote:
>
> Commit 7e83cab824a87e83cab824a8 ("remoteproc: Modify recovery path
> to use rproc_{start,stop}()") replaces rproc_{shutdown,boot}() with
> rproc_{stop,start}(), which skips destroy the virtio device at stop
> but re-initializes it again at start.
>
> Issue is that struct virtio_dev is not correctly reinitialized like done
> at initial allocation thanks to kzalloc() and kobject is considered as
> already initialized by kernel. That is due to the fact struct virtio_dev
> is allocated and released at vdev resource handling level managed and
> virtio device is registered and unregistered at rproc subdevices level.
>
> This patch initializes struct virtio_dev to 0 before using it and
> registering it.
>
> Fixes: 7e83cab824a8 ("remoteproc: Modify recovery path to use rproc_{start,stop}()")
>
> Reported-by: Xiang Xiao <xiaoxiang781216@gmail.com>
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 183fc42a510a..88eade99395c 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -332,6 +332,8 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>         struct virtio_device *vdev = &rvdev->vdev;
>         int ret;
>
> +       /* Reset vdev struct as you don't know how it has been previously used */
> +       memset(vdev, 0, sizeof(struct virtio_device));
>         vdev->id.device = id,
>         vdev->config = &rproc_virtio_config_ops,
>         vdev->dev.parent = dev;
> --
> 2.7.4
>
