Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B5820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oeLt3U2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfAOBMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:12:49 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38328 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfAOBMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:12:48 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so668290vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuqzscYgEsQBok9wmcfK6HOguS4Lb+mgL1IzpMHVqqY=;
        b=oeLt3U2vRPVFDmm/Gb87mcy5TDvsVx+iwdMZPimP5WX4VVpNOfYj7YP4FblO/+cav7
         uAie9eTerj3zqkCwaaCwY492vom/iTicdmDuQRh9RB842svvuucDPVorQ1yUjECsFVNU
         0NHKSi36ZKcrdFDM/BzJwBIsnd3Hk3/r2GOYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuqzscYgEsQBok9wmcfK6HOguS4Lb+mgL1IzpMHVqqY=;
        b=WK8rb4LB5utgjXd/yRoEf67lBa2X6tS0UtcBFONZ0oseS2IhwAzxWOfYY4kjCv0F19
         dOam1ovm7Ss5pf4LY0mbAgCuwyFhLjoO4Epx2HV8ApJ0XYm6QC37vqLzBGpvjO8oS/EM
         PmkdFrZ8V6Au9w5p4RKUKvoaEBkEFPeWV14w9a7/PAwfKl4JtawHpfES+xgKxaNYdCoF
         yydIS+Y/Yi57zTy8cnnCw9NhvzhqKggBBCOeRrVqEELborDx0lh311nxQI1ASaiHm5H8
         aewI3AsCksuj0j6Wdt5FyqA7JVanslIFbAK1MOOwGS7xCc7+zw9c+sBEc349gN3GJ8To
         pTlQ==
X-Gm-Message-State: AJcUukcDo1b1/P72sO9PI8FtS9+pTr7MeVhjoeIg9oUz6bwEyXQCqd+h
        VXhSBBPhgqw1+fbVckqv9Xhsibb9VLg=
X-Google-Smtp-Source: ALg8bN5vLNv71+yqMjEyNk+zdTdH2fHMf57OjYi7MdJN3lR0c6LPaLfrQXVnEki2lkizhJ+F4r+ifA==
X-Received: by 2002:a67:ff02:: with SMTP id v2mr571571vsp.176.1547514767010;
        Mon, 14 Jan 2019 17:12:47 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id l13sm74151343vka.16.2019.01.14.17.12.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:12:45 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 185so247298vkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:12:44 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr526423vkh.92.1547514764110;
 Mon, 14 Jan 2019 17:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-6-w@1wt.eu>
In-Reply-To: <20190112152844.26550-6-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:12:32 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL=gSQdv4B70QwQ9cvTM590ivNJWYpc9Dk025r9mzhzbA@mail.gmail.com>
Message-ID: <CAGXu5jL=gSQdv4B70QwQ9cvTM590ivNJWYpc9Dk025r9mzhzbA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ASoC: intel: skylake: change snprintf to scnprintf
 for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

This should get a Cc: stable, IMO.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>  sound/soc/intel/skylake/skl-debug.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
> index 5d7ac2ee7a3c..bb28db734fb7 100644
> --- a/sound/soc/intel/skylake/skl-debug.c
> +++ b/sound/soc/intel/skylake/skl-debug.c
> @@ -43,7 +43,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
>         ssize_t ret = 0;
>
>         for (i = 0; i < max_pin; i++)
> -               ret += snprintf(buf + size, MOD_BUF - size,
> +               ret += scnprintf(buf + size, MOD_BUF - size,
>                                 "%s %d\n\tModule %d\n\tInstance %d\n\t"
>                                 "In-used %s\n\tType %s\n"
>                                 "\tState %d\n\tIndex %d\n",
> @@ -59,7 +59,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
>  static ssize_t skl_print_fmt(struct skl_module_fmt *fmt, char *buf,
>                                         ssize_t size, bool direction)
>  {
> -       return snprintf(buf + size, MOD_BUF - size,
> +       return scnprintf(buf + size, MOD_BUF - size,
>                         "%s\n\tCh %d\n\tFreq %d\n\tBit depth %d\n\t"
>                         "Valid bit depth %d\n\tCh config %#x\n\tInterleaving %d\n\t"
>                         "Sample Type %d\n\tCh Map %#x\n",
> @@ -81,16 +81,16 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
>         if (!buf)
>                 return -ENOMEM;
>
> -       ret = snprintf(buf, MOD_BUF, "Module:\n\tUUID %pUL\n\tModule id %d\n"
> +       ret = scnprintf(buf, MOD_BUF, "Module:\n\tUUID %pUL\n\tModule id %d\n"
>                         "\tInstance id %d\n\tPvt_id %d\n", mconfig->guid,
>                         mconfig->id.module_id, mconfig->id.instance_id,
>                         mconfig->id.pvt_id);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "Resources:\n\tMCPS %#x\n\tIBS %#x\n\tOBS %#x\t\n",
>                         mconfig->mcps, mconfig->ibs, mconfig->obs);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "Module data:\n\tCore %d\n\tIn queue %d\n\t"
>                         "Out queue %d\n\tType %s\n",
>                         mconfig->core_id, mconfig->max_in_queue,
> @@ -100,38 +100,38 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
>         ret += skl_print_fmt(mconfig->in_fmt, buf, ret, true);
>         ret += skl_print_fmt(mconfig->out_fmt, buf, ret, false);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "Fixup:\n\tParams %#x\n\tConverter %#x\n",
>                         mconfig->params_fixup, mconfig->converter);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "Module Gateway:\n\tType %#x\n\tVbus %#x\n\tHW conn %#x\n\tSlot %#x\n",
>                         mconfig->dev_type, mconfig->vbus_id,
>                         mconfig->hw_conn_type, mconfig->time_slot);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "Pipeline:\n\tID %d\n\tPriority %d\n\tConn Type %d\n\t"
>                         "Pages %#x\n", mconfig->pipe->ppl_id,
>                         mconfig->pipe->pipe_priority, mconfig->pipe->conn_type,
>                         mconfig->pipe->memory_pages);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "\tParams:\n\t\tHost DMA %d\n\t\tLink DMA %d\n",
>                         mconfig->pipe->p_params->host_dma_id,
>                         mconfig->pipe->p_params->link_dma_id);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "\tPCM params:\n\t\tCh %d\n\t\tFreq %d\n\t\tFormat %d\n",
>                         mconfig->pipe->p_params->ch,
>                         mconfig->pipe->p_params->s_freq,
>                         mconfig->pipe->p_params->s_fmt);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "\tLink %#x\n\tStream %#x\n",
>                         mconfig->pipe->p_params->linktype,
>                         mconfig->pipe->p_params->stream);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "\tState %d\n\tPassthru %s\n",
>                         mconfig->pipe->state,
>                         mconfig->pipe->passthru ? "true" : "false");
> @@ -141,7 +141,7 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
>         ret += skl_print_pins(mconfig->m_out_pin, buf,
>                         mconfig->max_out_queue, ret, false);
>
> -       ret += snprintf(buf + ret, MOD_BUF - ret,
> +       ret += scnprintf(buf + ret, MOD_BUF - ret,
>                         "Other:\n\tDomain %d\n\tHomogeneous Input %s\n\t"
>                         "Homogeneous Output %s\n\tIn Queue Mask %d\n\t"
>                         "Out Queue Mask %d\n\tDMA ID %d\n\tMem Pages %d\n\t"
> @@ -199,7 +199,7 @@ static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
>                 __iowrite32_copy(d->fw_read_buff, fw_reg_addr, w0_stat_sz >> 2);
>
>         for (offset = 0; offset < FW_REG_SIZE; offset += 16) {
> -               ret += snprintf(tmp + ret, FW_REG_BUF - ret, "%#.4x: ", offset);
> +               ret += scnprintf(tmp + ret, FW_REG_BUF - ret, "%#.4x: ", offset);
>                 hex_dump_to_buffer(d->fw_read_buff + offset, 16, 16, 4,
>                                    tmp + ret, FW_REG_BUF - ret, 0);
>                 ret += strlen(tmp + ret);
> --
> 2.19.2
>


-- 
Kees Cook
