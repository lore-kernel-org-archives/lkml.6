Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR1qTB1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F1F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440100AbeKXBWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:22:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38506 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388198AbeKXBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:22:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so10733665plb.5;
        Fri, 23 Nov 2018 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Aj68xe/v5FknL39hGY54BgIh+8HGfbrwuVhVkEqjDo=;
        b=gR1qTB1jtD9HBcdHor/xSB6mHdxi6f4ucL3W1Sf/QQ0ADeo+Zmtr2T5qJoXoov2guv
         WlYZ42RcCRMAlbHzUhRNjN9mWziWPVYOH/QJ6oLWdK+3i0bBU6AbvBZVIrpRACgLeCC7
         T1WlXOkWxkBmre31lxNOKdMrH+A4zIElFlyUU0CW4zVKOHADbRi2t5zf6kRnuQtkPjEM
         ZFv9m4zEY74q2IMVn1AdyrLnUKw4WVbbX4k+giNf4aha88HoVZZaqQQ1lXEoHUKufyoz
         5qiLj8F6UlAHjMSYOzXae7nIKx1in83k9RCTljKAd8ZmgNo1GeOSfyRDMBcMBfn15A2I
         A+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Aj68xe/v5FknL39hGY54BgIh+8HGfbrwuVhVkEqjDo=;
        b=meqlSQv4DJf/EMrcKJpVRsbdOcLMjPL0Q1piD7/y5qkXQ32dRcfqijyVu8TRY+hoS8
         7IudCr5w2hSxatUUU1vqJI24Ri2wQqmqFdhkvMcU17cNKazSHBUh228KwYaLfSMJaQbe
         ULpGW8YzGVfliYYQ9dbkmA/iCTYGgL6N4A/MvsURkYxKCsC8As2SiH1eQVadIh2n13HU
         qrtqm0kPC8Qm1zmUN92Wtx0DJNWLmfR0LDqPFoQ1PVlMf8FzneXYG7j2LdmWEHptVPIo
         0J8+ILjEHm8hYkVvl58BCm4ujAxm8INr6ulcCWBfU3S5BzT6ZmNkwyViW6pdzFG0onnc
         I9fw==
X-Gm-Message-State: AA+aEWaUkqBSkbjVse384t1KYfOVGonJsc4gUNNv7RjYBrgN872VdhVm
        ioZFy4AStfF10lIyahE+al8p6yFVA1qzuurLklQ=
X-Google-Smtp-Source: AFSGD/XhzPXxmm7CZ+xFRIukyMRxnApW5l2sisguxuiFO0NNfjF6RDEbwK3STMoTIy151ePm05qvQ3Yto5+FNEkal7Q=
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr16300320plb.335.1542983870343;
 Fri, 23 Nov 2018 06:37:50 -0800 (PST)
MIME-Version: 1.0
References: <5beda000.1c69fb81.e6599.d3d8@mx.google.com>
In-Reply-To: <5beda000.1c69fb81.e6599.d3d8@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Fri, 23 Nov 2018 20:07:38 +0530
Message-ID: <CAJr6mf0rawk6rDRB7NzsTUXyqvt0U5J4SUnVYck2_-jh6D6MoQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/scsi/snic/snic_trc.c: Use vzalloc
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:04 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced vmalloc + memset with vzalloc
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  drivers/scsi/snic/snic_trc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
> index fc60c93..458eaba 100644
> --- a/drivers/scsi/snic/snic_trc.c
> +++ b/drivers/scsi/snic/snic_trc.c
> @@ -126,7 +126,7 @@ snic_trc_init(void)
>         int tbuf_sz = 0, ret;
>
>         tbuf_sz = (snic_trace_max_pages * PAGE_SIZE);
> -       tbuf = vmalloc(tbuf_sz);
> +       tbuf = vzalloc(tbuf_sz);
>         if (!tbuf) {
>                 SNIC_ERR("Failed to Allocate Trace Buffer Size. %d\n", tbuf_sz);
>                 SNIC_ERR("Trace Facility not enabled.\n");
> @@ -135,7 +135,6 @@ snic_trc_init(void)
>                 return ret;
>         }
>
> -       memset(tbuf, 0, tbuf_sz);
>         trc->buf = (struct snic_trc_data *) tbuf;
>         spin_lock_init(&trc->lock);
>
> --
> 2.7.4
>
