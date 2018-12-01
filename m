Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38050C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D120867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeBBXUZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7D120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLBA2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:28:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37514 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeLBA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:28:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so3722527pge.4;
        Sat, 01 Dec 2018 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8H4/l64B6yHC0qT8Zyx/zZ6ebwiWoIwxZUOpgj1sIbs=;
        b=JeBBXUZw9fHclGpFB63VFyEWl88VfsPYdd/Xt9lVu6kJWl1XO/D5hGbzqiS68p/rqo
         iwoHEqPNBxUEQXXdgq35nxtRRyPoai/KRImW9x+mCzxnNyBe8qQZrlWYcUnh3eGgAniU
         TqOYjEQLlmsA/7bcEiV0lfbiZe9HuD1FVeZt12HdlW/+dKgKpIyPRmT4FCsidpV+tFF+
         itQDchh7T9eZ6XsabeA2H2HvZuA+/aRSWIDvARILXjmwkYQc4uhY4VY+Da+NSsQdHKZb
         JX+d8oWFMCO16JQt5EUz2D7E8+qxGDHRAkbMYheFgvZFIN2fBtONBP7dD2NdR3HYWhwR
         vUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8H4/l64B6yHC0qT8Zyx/zZ6ebwiWoIwxZUOpgj1sIbs=;
        b=Sv8qBtJJNxSrcvYqjXxvfz03QkNI1N/x8Vg8ymUhPxg6YXzf76IMKKQGaXfcGeRZkT
         jCsiPzdF63Q07fk1tzcnoc5UYf8KPQMmwZIGdwSXjtzAjH2xV8rhnUS9tz54KkdYYDmF
         /UkZUpcmXPw1ldFcmSWwzlpzqG4x2NbbKx4yzogxUteaQSc9I8lXgMJcbl8gCnxLHIkH
         z+mR+sEzJjUMcSnNkLM3hJ5XvQLAqMRbS2n+gzDpLdpLbeUBj9NjJhXjN0QruIyefze/
         ssmAQsBQJfVeXuLiJetQxqNXQypIAp6eI7r8JTt9+7ragsJszyjMWCfVzucfZNY30BP7
         2Vyw==
X-Gm-Message-State: AA+aEWbjF2M5wg/0Vt7oPK/dmqda0RH0j1InCri9D0ij4EUr3CW8hJCv
        gmYslrnGaWLL7jPtMhpeg6ap4gJDTpthED36Bx4=
X-Google-Smtp-Source: AFSGD/U874I7m90gN2X882UK14YQIeP4XE5SkLBJVbYE7C8TA4+dTq/thOx/RNjJqCD0oYkBpMFWIpwZex7JMyLcypk=
X-Received: by 2002:a62:43c1:: with SMTP id l62mr9484884pfi.22.1543670135518;
 Sat, 01 Dec 2018 05:15:35 -0800 (PST)
MIME-Version: 1.0
References: <5bf00de4.1c69fb81.7dd65.5785@mx.google.com>
In-Reply-To: <5bf00de4.1c69fb81.7dd65.5785@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Sat, 1 Dec 2018 18:45:23 +0530
Message-ID: <CAJr6mf2Kvj0FJb2zf9FZUNEkyQtYZVbFNBwG+dH_LyhSDU92wg@mail.gmail.com>
Subject: Re: [PATCH] scsi/dpt_i2o.c: Use dma_zalloc_coherent
To:     aacraid@microsemi.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 6:17 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  drivers/scsi/dpt_i2o.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> index 37de8fb..056383a 100644
> --- a/drivers/scsi/dpt_i2o.c
> +++ b/drivers/scsi/dpt_i2o.c
> @@ -1370,13 +1370,12 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
>                 schedule_timeout_uninterruptible(1);
>         } while (m == EMPTY_QUEUE);
>
> -       status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> +       status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
>         if(status == NULL) {
>                 adpt_send_nop(pHba, m);
>                 printk(KERN_ERR"IOP reset failed - no free memory.\n");
>                 return -ENOMEM;
>         }
> -       memset(status,0,4);
>
>         msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
>         msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
> @@ -2836,14 +2835,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
>
>         msg=(u32 __iomem *)(pHba->msg_addr_virt+m);
>
> -       status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> +       status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
>         if (!status) {
>                 adpt_send_nop(pHba, m);
>                 printk(KERN_WARNING"%s: IOP reset failed - no free memory.\n",
>                         pHba->name);
>                 return -ENOMEM;
>         }
> -       memset(status, 0, 4);
>
>         writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
>         writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
> @@ -2890,14 +2888,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
>                         pHba->reply_pool, pHba->reply_pool_pa);
>         }
>
> -       pHba->reply_pool = dma_alloc_coherent(&pHba->pDev->dev,
> +       pHba->reply_pool = dma_zalloc_coherent(&pHba->pDev->dev,
>                                 pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4,
>                                 &pHba->reply_pool_pa, GFP_KERNEL);
>         if (!pHba->reply_pool) {
>                 printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
>                 return -ENOMEM;
>         }
> -       memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
>
>         for(i = 0; i < pHba->reply_fifo_size; i++) {
>                 writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
> @@ -3126,13 +3123,12 @@ static int adpt_i2o_build_sys_table(void)
>         sys_tbl_len = sizeof(struct i2o_sys_tbl) +      // Header + IOPs
>                                 (hba_count) * sizeof(struct i2o_sys_tbl_entry);
>
> -       sys_tbl = dma_alloc_coherent(&pHba->pDev->dev,
> +       sys_tbl = dma_zalloc_coherent(&pHba->pDev->dev,
>                                 sys_tbl_len, &sys_tbl_pa, GFP_KERNEL);
>         if (!sys_tbl) {
>                 printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");
>                 return -ENOMEM;
>         }
> -       memset(sys_tbl, 0, sys_tbl_len);
>
>         sys_tbl->num_entries = hba_count;
>         sys_tbl->version = I2OVERSION;
> --
> 2.7.4
>
