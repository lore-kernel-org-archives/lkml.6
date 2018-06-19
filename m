Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592DDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18FF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blofghbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18FF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966768AbeFSRNF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:13:05 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37152 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:13:03 -0400
Received: by mail-ua0-f195.google.com with SMTP id l14-v6so298057uao.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9OlL7JKXRSUcC2lFlmHbe582krE2dkF6hNzttiyipyA=;
        b=blofghbJqf9dBPlVmFLliLnFQh+Hblwaz86NPqNObUOXT9ODgsdvmB5w66NmfIN/KW
         lI+aaGZBdNOy8IdJUoj1f1PA3JlrnXYSXIc0TVopXCNZz++fhFoguS617YWT/Ef1s7IP
         25HRMGhWpKqgnLhdFdCF8Hw8LpqG2FJQQcgvtk4D6W6ncTYjbPq/Bc7qaSTkd3Ig67La
         VkWT2US7d49xWiBgPEQ8assftukOHxsxVnllzWjIlAzYLNu415trJ79vONBsaXKPnenp
         Ikr1uqt+yWocHYz1EJQjXly2eFPSOOIPgtGUYpejYtWqMuRQ3KxSIVxRyYnbX6wMJQx9
         KcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9OlL7JKXRSUcC2lFlmHbe582krE2dkF6hNzttiyipyA=;
        b=h8022akBqxfIVCf0EdzDwIGas4RWbxt4SxnvNdt2f6IxHTk5wnOUNyRh6ojgLhoBdA
         pr9jQVEWSbl3Ykjk1st5UafORBGaltk6KSncoDbbjRM9qLi1UwDcAWw+YmG1FMtoXeU6
         CpnR7Yd6DboLkYyp2T17xYm09lh501oJom50SatQotJi4jVG0eMpmStVAMeDTV4hq1YF
         WU8BfI9RT28rxnAmz9RNS9w891ga9IL/N/Y1kSUklCgKf+d5TtEGaMcLg69l+hBA/+Im
         KVo07cOAziScEw2nuXcMc6MvovHmhtz9mbgMarLvDCvIwcEBlseinfL4OM4H9NVSu0jL
         hfow==
X-Gm-Message-State: APt69E3DVVr3ELeBal5oj18ZJjflBaPe6PA/GoxRTaOx/lzPo3POXf/k
        vMWevzyIT5mIHa6c6DgSbaV6V6B+bRq7Dbxllhhg4w==
X-Google-Smtp-Source: ADUXVKKc7NN0yi2i92qQ+exIeWQYIFh6XZkm7WsfeKLzmQslG4jjk/H3hEarb52ruz23wig+dKkTYRYvtigfpjBCQwQ=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr10966199uai.47.1529428382961;
 Tue, 19 Jun 2018 10:13:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 10:13:02
 -0700 (PDT)
In-Reply-To: <20180619152524.6080-1-vasilyev@ispras.ru>
References: <20180619074248.ssu5kza6wdwhzdqi@mwanda> <20180619152524.6080-1-vasilyev@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 20:13:02 +0300
Message-ID: <CAHp75VfktnjL+G0vjHNHr=8mbDXu+4BDogsnxrp_2Bo4em=r2Q@mail.gmail.com>
Subject: Re: [PATCH v4] staging: rts5208: add error handling into rtsx_probe
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, Jun 19, 2018 at 6:25 PM, Anton Vasilyev <vasilyev@ispras.ru> wrote:
> If rtsx_probe() fails to allocate dev->chip, then release_everything()
> will crash on uninitialized dev->cmnd_ready complete

Period is missed at the end.

>
> Patch adds error handling into rtsx_probe.

an error

>
> Found by Linux Driver Verification project (linuxtesting.org).
>

Reviewed-by: Andy Shevchenko <andy.shevhchenko@gmail.com>

Couple of comments below though.

> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v4: rename labels baced on Dan Carpenter's recommendation
> v3: fix subject and commit message
> v2: Add error handling into rtsx_probe based on Dan Carpenter's comment.
> I do not have corresponding hardware, so patch was tested by compilation only.
>
> I faced with inaccuracy at rtsx_remove() and original rtsx_probe():
> there is quiesce_and_remove_host() call with scsi_remove_host() inside,
> whereas release_everything() calls scsi_host_put() after this
> scsi_remove_host() call. This is strange for me.
> Also I do not know is it require to check result value of
> rtsx_init_chip() call on rtsx_probe().
> ---
>  drivers/staging/rts5208/rtsx.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 70e0b8623110..233026ee5dd4 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -879,7 +879,7 @@ static int rtsx_probe(struct pci_dev *pci,
>         if (!dev->remap_addr) {
>                 dev_err(&pci->dev, "ioremap error\n");
>                 err = -ENXIO;
> -               goto errout;
> +               goto err_chip_free;
>         }
>
>         /*
> @@ -894,7 +894,7 @@ static int rtsx_probe(struct pci_dev *pci,
>         if (!dev->rtsx_resv_buf) {
>                 dev_err(&pci->dev, "alloc dma buffer fail\n");
>                 err = -ENXIO;
> -               goto errout;
> +               goto err_addr_unmap;
>         }
>         dev->chip->host_cmds_ptr = dev->rtsx_resv_buf;
>         dev->chip->host_cmds_addr = dev->rtsx_resv_buf_addr;
> @@ -915,7 +915,7 @@ static int rtsx_probe(struct pci_dev *pci,
>
>         if (rtsx_acquire_irq(dev) < 0) {
>                 err = -EBUSY;
> -               goto errout;
> +               goto err_disable_msi;
>         }
>
>         pci_set_master(pci);
> @@ -935,14 +935,14 @@ static int rtsx_probe(struct pci_dev *pci,
>         if (IS_ERR(th)) {
>                 dev_err(&pci->dev, "Unable to start control thread\n");
>                 err = PTR_ERR(th);
> -               goto errout;
> +               goto err_rtsx_release;
>         }
>         dev->ctl_thread = th;
>
>         err = scsi_add_host(host, &pci->dev);
>         if (err) {
>                 dev_err(&pci->dev, "Unable to add the scsi host\n");
> -               goto errout;
> +               goto err_complete_control_thread;
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
> +               goto err_stop_host;
>         }
>
>         /* Start up the thread for polling thread */
>         th = kthread_run(rtsx_polling_thread, dev, "rtsx-polling");
>         if (IS_ERR(th)) {
>                 dev_err(&pci->dev, "Unable to start the device-polling thread\n");
> -               quiesce_and_remove_host(dev);
>                 err = PTR_ERR(th);
> -               goto errout;
> +               goto err_stop_host;
>         }
>         dev->polling_thread = th;
>
> @@ -970,9 +968,25 @@ static int rtsx_probe(struct pci_dev *pci,
>         return 0;
>
>         /* We come here if there are any problems */
> +err_stop_host:
> +       quiesce_and_remove_host(dev);
> +err_complete_control_thread:
> +       complete(&dev->cmnd_ready);
> +       wait_for_completion(&dev->control_exit);
> +err_rtsx_release:
> +       free_irq(dev->irq, (void *)dev);
> +       rtsx_release_chip(dev->chip);
> +err_disable_msi:

> +       dev->chip->host_cmds_ptr = NULL;
> +       dev->chip->host_sg_tbl_ptr = NULL;

This seems superfluous, you are freeing entire struct few calls after.

> +       if (dev->chip->msi_en)
> +               pci_disable_msi(dev->pci);

This might be material for another improvement, PCI core tracks
MSI/MSI-X enable state.
So, the conditional with the local variable looks superfluous as well
(in some, rare, cases we indeed need something like this to basically
distinguish MSI from MSI-X, though I don't think it's a case here)

> +err_addr_unmap:
> +       iounmap(dev->remap_addr);
> +err_chip_free:
> +       kfree(dev->chip);
>  errout:
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
