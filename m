Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE97420828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DlYC5H05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeLaGKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 01:10:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33749 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLaGKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 01:10:09 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so20821559ioi.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 22:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWXk32NGwEbWOnn28Kw933pTT+gOGAMs6PWbGYkREzY=;
        b=DlYC5H05NSMpUq0MJdGKzaQe6QDBGQ29lZOKnYOeC64f1CzkIRbN0RwDn731QNbrCE
         /p0qegD3efRRj+j0QZAHBb06OU3nAG8qLm1u2ASkvDZsFLQc0yfmclegRwdozqrb3tti
         bir2JSFAXg6DAtHVEP1ID0okr6o2BcznFDNAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWXk32NGwEbWOnn28Kw933pTT+gOGAMs6PWbGYkREzY=;
        b=I6MKu32zRLa9rNgcR2+hJY5L7KRWL3Z80sYDUPIYFROHXyh3PEinugqftyhBAEK2lx
         JS7W2wWDejq9cV0QdowUMwXbCVJSDxPe/NYAZt39xsjMVijCltQXS2FLrOdlkwIslMhQ
         MFIwZb0dASki0fnIZvQqvCCQEXobJ1Pf4HW43+0xSPiVtoPazbOx9gibaRpfS01Awk9J
         Aqibo+jVHQsflcSeASoloJ1Og3iiYDN0KKm+WKJnMT6mnpGLp/yScHbR/sPGLDKL5784
         3c5rP/Is3ZAjgKLtxaWj8LBrfxqvqIwSuiDltaQfYXsf0pp/Xlq+dDPyyhu92eu0rPQr
         VDaQ==
X-Gm-Message-State: AJcUukfflhVUpQC9t73PFstcoaqcbqSmNMfx4U8iaWxwcMQI/woDv8Nr
        ifz/Us8URgPlJ7IUx389i4MV6K5eJNhfmpRhOYLDsg==
X-Google-Smtp-Source: ALg8bN4JiqbVwLgMNOrozkh8IuYsHnM8t0zngXZaH4fKm1lndHUFBxk0AJHo30WsDfA/wLp6Okay9vjJk06z+ijMIFg=
X-Received: by 2002:a6b:d005:: with SMTP id x5mr5855601ioa.46.1546236608186;
 Sun, 30 Dec 2018 22:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20181226185623.9324-1-pakki001@umn.edu>
In-Reply-To: <20181226185623.9324-1-pakki001@umn.edu>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 31 Dec 2018 11:39:32 +0530
Message-ID: <CANjDDBgEFGe3DMUvP_K7zzuqA8i0RosLwX_iRHBMxAEBx3crXg@mail.gmail.com>
Subject: Re: [PATCH] infiniband: bnxt_re: qplib: Check the return value of send_message
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 12:26 AM Aditya Pakki <pakki001@umn.edu> wrote:
>
> In bnxt_qplib_map_tc2cos(), bnxt_qplib_rcfw_send_message() can return
> an error value. The fix returns the error from the latter function
> upstream.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index 5216b5f844cc..adb8eae5193c 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -778,9 +778,8 @@ int bnxt_qplib_map_tc2cos(struct bnxt_qplib_res *res, u16 *cids)
>         req.cos0 = cpu_to_le16(cids[0]);
>         req.cos1 = cpu_to_le16(cids[1]);
>
> -       bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp, NULL,
> -                                    0);
> -       return 0;
> +       return bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
> +                                               NULL, 0);
>  }
>
>  int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
> --
> 2.17.1
>

Acked-By: Devesh Sharma <devesh.sharma@broadcom.com>
