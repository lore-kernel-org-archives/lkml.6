Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7792082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7792082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeLERvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:51:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46014 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLERvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:51:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so19405045ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibqsYSKAoSqnlOjk4KKyyzbiSkCmLucodSv4g6hHtWo=;
        b=F6G7PCAwdPRGAg83mSyNFp9A6Fu3E2oUyQoveFS8CJWw7dfOxAWEUf+yJGqfEgwlOH
         AB4D6hhldF/xmOVjE9S/47uSZv6G449XR6P973uG7cDqb45i9ZnZ+lEPJBULh84QJV6j
         zbbI5jfdXvPHy2woToZBHMv31L5ShFu3NXngrl2f30ETFBlnVqqVBjaz+sot4V+7J8W8
         QiOQfNudmGwvT7Udv4cdtWZ9RkZPvCdgobpxQtJ/QXUCp+6BoDfu4Hy2B+DcqhZGy3Qg
         cbB3Gb8s2xVQqbNcMaIYgTXpNDxXvNk/fPBI25Dj7eezZpiviQUtKbN+C/8/4GnUgjPT
         TA1A==
X-Gm-Message-State: AA+aEWZEgJEygNVynP9n0fMwTTglVUwiWLYiD9vg7eyac7eZf3I7oglC
        RvoSzw0YJPSvazqJKaQEAEdaO2qEOEc=
X-Google-Smtp-Source: AFSGD/Vwur3thmo+cgw+0HJDXzQ43UgvWE098CpKAcdV1HPOYX2S29A5+GEkjRhid2F7kpMNo6OqNA==
X-Received: by 2002:a9d:1f3:: with SMTP id e106mr4200762ote.369.1544032274514;
        Wed, 05 Dec 2018 09:51:14 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id t12sm11622357otk.61.2018.12.05.09.51.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:51:14 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id v23so19419667otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:51:13 -0800 (PST)
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr16231441oth.338.1544032273394;
 Wed, 05 Dec 2018 09:51:13 -0800 (PST)
MIME-Version: 1.0
References: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com> <1543922408-22950-2-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1543922408-22950-2-git-send-email-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 5 Dec 2018 11:51:02 -0600
X-Gmail-Original-Message-ID: <CADRPPNR43D4jhcdMigUz3-CrNp4VEhUJmsZXofha2kY+gkLsoQ@mail.gmail.com>
Message-ID: <CADRPPNR43D4jhcdMigUz3-CrNp4VEhUJmsZXofha2kY+gkLsoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
To:     ioana.ciornei@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>, youri.querry_1@nxp.com,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:21 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> The dpio_by_cpu array should not contain a reference to a freed dpaa2_io
> object. This patch adds the necessary cleanup in dpaa2_io_down.

Applied.  Thanks.

>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
>   - none
>
>  drivers/soc/fsl/dpio/dpio-service.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 9b17f72..21c3e32 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -160,6 +160,11 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
>   */
>  void dpaa2_io_down(struct dpaa2_io *d)
>  {
> +       spin_lock(&dpio_list_lock);
> +       dpio_by_cpu[d->dpio_desc.cpu] = NULL;
> +       list_del(&d->node);
> +       spin_unlock(&dpio_list_lock);
> +
>         kfree(d);
>  }
>
> --
> 1.9.1
>
