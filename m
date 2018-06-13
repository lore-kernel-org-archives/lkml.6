Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3265EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87C0208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laMpX7qO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87C0208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935101AbeFMRA5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:00:57 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37643 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934747AbeFMRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:00:56 -0400
Received: by mail-ua0-f195.google.com with SMTP id i3-v6so2198381uad.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oN8x4t5AlnqwLPH5J4s8CXuwHw6OREHTuwpz/aBY1W8=;
        b=laMpX7qOJPpyrf1j7YmRJ+GCOnoFe9uUX9ploWzflJnCArzOqrPg2xSNRvr0Y6hWzE
         BMqHfQAQKyGkkyHPq/gbxnTEUJWhmzehhI797B+Jg8MzTbyaCJ5sYJBKfj4N7QroeGe0
         EbPhPlFbG6cDMfPukLGwyt7+KxVN4XbiF2QT5zN73TAnRTiKks/mqT+X4WwvrtSPMgnM
         MYBjufOSeuOtbjEXpyIQXiQEkY9A7Hau8EUxsi6j2Vt/8/yz/4dup9fepLxfZjVVPHwh
         B4RYGOIwImEF2rb01RfAa3EhJelL0QbbQW5910+8gQnmuJcd1nsk7bWnHUgLE5vAd4vB
         +M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oN8x4t5AlnqwLPH5J4s8CXuwHw6OREHTuwpz/aBY1W8=;
        b=sK9bilP2XZfPMJAzvXTwC9jgNt+DcygcUKyWMBq8jtuyvry+jUofsSLdiwmYhACYh4
         ekefrFT7yU5srlUxj2Yeh4KV/D59tXShMUtgAQafqjlyYrDWgCaqusohBy9gFy1Wh+P3
         RIIo1Ios60mrpRJNX5z8JpqszGkL2gPX3aJqKr6rQ6X3ZQRpmOcCu6dQS+2pnkINNO4h
         xB+9otVUsZLl5y3Ko+X633EXD2YzOM3iueydqEJnp3PnTcXrNwmPX+StGrlwQul2Fr1C
         431PTP/ZWFZe625orfn3/YcSPxhb4Dc+Tb9QmQb+dN876rI4c5IAgz4b/uxOxf5Ox/dF
         pVgQ==
X-Gm-Message-State: APt69E3IOCJ58cb8fEYYsE2/Dxc05MXWK6ry9mlgLX3s6dx2NLLRZaWv
        lL39TAvkY1h5s87gnIDm8TK8q0bja18dYjRmrTyz61lA
X-Google-Smtp-Source: ADUXVKJfm6MpB0z+uM4ayhlegESS6/2/e0TIG7Q/LgemIZDWY1ZULfhE1j5576YZuyopZ1b/gNskWndYPQzbYO+urWI=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr4054418uad.49.1528909255607;
 Wed, 13 Jun 2018 10:00:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 10:00:55
 -0700 (PDT)
In-Reply-To: <20180613165501.30669-1-vasilyev@ispras.ru>
References: <20180612130640.6lcnn4cj7cval7aw@mwanda> <20180613165501.30669-1-vasilyev@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 20:00:55 +0300
Message-ID: <CAHp75VetOuS+H4GU9UW-Ekczs22-Ju++jXWdvkMJGktbumDzwQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rts5208: add check on NULL before dereference
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 7:55 PM, Anton Vasilyev <vasilyev@ispras.ru> wrote:
> If rtsx_probe() fails to allocate dev->chip, then NULL pointer
> dereference occurs at release_everything()->rtsx_release_resources().
>
> Found by Linux Driver Verification project (linuxtesting.org).
>

You forgot to adjust subject and commit message to the new reality
which is brought by this change.

> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v2: Add error handling into rtsx_probe based on Dan Carpenter's comment.
> I do not have corresponding hardware, so patch was tested by compilation only.
>
> I faced with inaccuracy at rtsx_remove() and original rtsx_probe():
> there is quiesce_and_remove_host() call with scsi_remove_host() inside,
> whereas release_everything() calls scsi_host_put() after this
> scsi_remove_host() call. This is strange for me.
>
> Also I do not know is it require to check result value of
> rtsx_init_chip() call on rtsx_probe().
> ---
>  drivers/staging/rts5208/rtsx.c | 38 +++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 70e0b8623110..69e6abe14abf 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -857,7 +857,7 @@ static int rtsx_probe(struct pci_dev *pci,
>         dev->chip = kzalloc(sizeof(*dev->chip), GFP_KERNEL);
>         if (!dev->chip) {
>                 err = -ENOMEM;
> -               goto errout;
> +               goto chip_alloc_fail;
>         }
>
>         spin_lock_init(&dev->reg_lock);
> @@ -879,7 +879,7 @@ static int rtsx_probe(struct pci_dev *pci,
>         if (!dev->remap_addr) {
>                 dev_err(&pci->dev, "ioremap error\n");
>                 err = -ENXIO;
> -               goto errout;
> +               goto ioremap_fail;
>         }
>
>         /*
> @@ -894,7 +894,7 @@ static int rtsx_probe(struct pci_dev *pci,
>         if (!dev->rtsx_resv_buf) {
>                 dev_err(&pci->dev, "alloc dma buffer fail\n");
>                 err = -ENXIO;
> -               goto errout;
> +               goto dma_alloc_fail;
>         }
>         dev->chip->host_cmds_ptr = dev->rtsx_resv_buf;
>         dev->chip->host_cmds_addr = dev->rtsx_resv_buf_addr;
> @@ -915,7 +915,7 @@ static int rtsx_probe(struct pci_dev *pci,
>
>         if (rtsx_acquire_irq(dev) < 0) {
>                 err = -EBUSY;
> -               goto errout;
> +               goto irq_acquire_fail;
>         }
>
>         pci_set_master(pci);
> @@ -935,14 +935,14 @@ static int rtsx_probe(struct pci_dev *pci,
>         if (IS_ERR(th)) {
>                 dev_err(&pci->dev, "Unable to start control thread\n");
>                 err = PTR_ERR(th);
> -               goto errout;
> +               goto control_thread_fail;
>         }
>         dev->ctl_thread = th;
>
>         err = scsi_add_host(host, &pci->dev);
>         if (err) {
>                 dev_err(&pci->dev, "Unable to add the scsi host\n");
> -               goto errout;
> +               goto scsi_add_host_fail;
>         }
>
>         /* Start up the thread for delayed SCSI-device scanning */
> @@ -950,18 +950,16 @@ static int rtsx_probe(struct pci_dev *pci,
>         if (IS_ERR(th)) {
>                 dev_err(&pci->dev, "Unable to start the device-scanning thread\n");
>                 complete(&dev->scanning_done);
> -               quiesce_and_remove_host(dev);
>                 err = PTR_ERR(th);
> -               goto errout;
> +               goto scan_thread_fail;
>         }
>
>         /* Start up the thread for polling thread */
>         th = kthread_run(rtsx_polling_thread, dev, "rtsx-polling");
>         if (IS_ERR(th)) {
>                 dev_err(&pci->dev, "Unable to start the device-polling thread\n");
> -               quiesce_and_remove_host(dev);
>                 err = PTR_ERR(th);
> -               goto errout;
> +               goto scan_thread_fail;
>         }
>         dev->polling_thread = th;
>
> @@ -970,9 +968,25 @@ static int rtsx_probe(struct pci_dev *pci,
>         return 0;
>
>         /* We come here if there are any problems */
> -errout:
> +scan_thread_fail:
> +       quiesce_and_remove_host(dev);
> +scsi_add_host_fail:
> +       complete(&dev->cmnd_ready);
> +       wait_for_completion(&dev->control_exit);
> +control_thread_fail:
> +       free_irq(dev->irq, (void *)dev);
> +       rtsx_release_chip(dev->chip);
> +irq_acquire_fail:
> +       dev->chip->host_cmds_ptr = NULL;
> +       dev->chip->host_sg_tbl_ptr = NULL;
> +       if (dev->chip->msi_en)
> +               pci_disable_msi(dev->pci);
> +dma_alloc_fail:
> +       iounmap(dev->remap_addr);
> +ioremap_fail:
> +       kfree(dev->chip);
> +chip_alloc_fail:
>         dev_err(&pci->dev, "%s failed\n", __func__);
> -       release_everything(dev);
>
>         return err;
>  }
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
