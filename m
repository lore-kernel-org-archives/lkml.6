Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8B6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10EE214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYCereFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10EE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeLFI3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:29:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42881 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:29:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so10309756pga.9;
        Thu, 06 Dec 2018 00:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/Ar76V5U0eoQHEha4TAqTfqZW7EvmtK6ivHZJBG9/8=;
        b=LYCereFXM0+qp/g4KRHsWnV3ECC+9vLIdjBJjdD74qJR0ihF/6x+1XldRJtxrhQIMd
         u7ckYUzYqc6yX8nicxrlPPyMXVT05wLXncpiQqzyItKmwMZGRrVkANC/av4gGWlxP/vc
         LRCwDkWF9peBt8c2jbkp6YVcBAPkTnLMIzHPjUfna9XQOIyBst7u/UUjgLKUu3QBi/Og
         9QfGTlXyTFe+dKGMyXgeOPZbw76S3PSDxU+zRHz9qgNpiXOuU1HE9aiaebPn8V248ay1
         a6+zrZoZiI/2f6+VtAsK2CSJxOAFB8qdsGe/0Ow8T0GIvAcZfoDn3SQINMGc6RGXbqod
         sm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/Ar76V5U0eoQHEha4TAqTfqZW7EvmtK6ivHZJBG9/8=;
        b=OxCCyhAgtdvqw3f8rIDK4Kb37dR9f0ncB4aXEXN1Pv3AO082L5dzPQVCdxMEErHre1
         BB37HaHggF9CG3H0kY+a2DzPV+YStXuX1gyKJsCBJT+CwIkzD7hiC+E7TR1S2E4WKwUA
         7aA4xKtfi8xje9rA2o1V/nWKRH+W7nEAbRlwEA4Ho60OTNw01AopQwDwS6h2DCR2bt/D
         NTElr1jcCHqD7pGjYIAvLUL06um2IWBicXEd3h9FDI2EGdv/dML5RBGMs0XeCIgM3VoS
         +Ca76dZCKnI4cDOrDlVsm5dumiXLoqDD4Y2ERqkQQjZjBI1wonbbrIwhBepqvRp4tJme
         hJSg==
X-Gm-Message-State: AA+aEWbqnJup9iL+Eer+JkkRUEYnuGRxF23+rdIpDo9vTW/OfKnaFvTG
        isJZte/ZUP9Tg4zSn6ffgEQ+rWiJZP/42QCs5VF9Mw==
X-Google-Smtp-Source: AFSGD/UsqoV0dI04Ew3lydPHCAHYOocMn9yeUbYOBpfE58rp/AxjVEA5vLWSxTmZSh15uCAEWkQ37KrNxbhjx54ER0A=
X-Received: by 2002:a63:61c8:: with SMTP id v191mr23568082pgb.242.1544084952852;
 Thu, 06 Dec 2018 00:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20181206045106.10307-1-longli@linuxonhyperv.com>
In-Reply-To: <20181206045106.10307-1-longli@linuxonhyperv.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 6 Dec 2018 02:29:01 -0600
Message-ID: <CAH2r5mvvJ1-vP4o-hBUD04ySD+OvzGr12YcvyFBA9VWOs8gSGQ@mail.gmail.com>
Subject: Re: [PATCH] CIFS: Avoid returning EBUSY to upper layer VFS
To:     Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tentatively pushed to cifs-2.6.git for-next
On Wed, Dec 5, 2018 at 10:52 PM Long Li <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> EBUSY is not handled by VFS, and will be passed to user-mode. This is not
> correct as we need to wait for more credits.
>
> This patch also fixes a bug where rsize or wsize is used uninitialized when
> the call to server->ops->wait_mtu_credits() fails.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/file.c | 31 ++++++-------------------------
>  1 file changed, 6 insertions(+), 25 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 74c33d5..c9bc56b 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2541,14 +2541,13 @@ static int
>  cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
>         struct cifs_aio_ctx *ctx)
>  {
> -       int wait_retry = 0;
>         unsigned int wsize, credits;
>         int rc;
>         struct TCP_Server_Info *server =
>                 tlink_tcon(wdata->cfile->tlink)->ses->server;
>
>         /*
> -        * Try to resend this wdata, waiting for credits up to 3 seconds.
> +        * Wait for credits to resend this wdata.
>          * Note: we are attempting to resend the whole wdata not in segments
>          */
>         do {
> @@ -2556,19 +2555,13 @@ cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
>                         server, wdata->bytes, &wsize, &credits);
>
>                 if (rc)
> -                       break;
> +                       goto out;
>
>                 if (wsize < wdata->bytes) {
>                         add_credits_and_wake_if(server, credits, 0);
>                         msleep(1000);
> -                       wait_retry++;
>                 }
> -       } while (wsize < wdata->bytes && wait_retry < 3);
> -
> -       if (wsize < wdata->bytes) {
> -               rc = -EBUSY;
> -               goto out;
> -       }
> +       } while (wsize < wdata->bytes);
>
>         rc = -EAGAIN;
>         while (rc == -EAGAIN) {
> @@ -3234,14 +3227,13 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
>                         struct list_head *rdata_list,
>                         struct cifs_aio_ctx *ctx)
>  {
> -       int wait_retry = 0;
>         unsigned int rsize, credits;
>         int rc;
>         struct TCP_Server_Info *server =
>                 tlink_tcon(rdata->cfile->tlink)->ses->server;
>
>         /*
> -        * Try to resend this rdata, waiting for credits up to 3 seconds.
> +        * Wait for credits to resend this rdata.
>          * Note: we are attempting to resend the whole rdata not in segments
>          */
>         do {
> @@ -3249,24 +3241,13 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
>                                                 &rsize, &credits);
>
>                 if (rc)
> -                       break;
> +                       goto out;
>
>                 if (rsize < rdata->bytes) {
>                         add_credits_and_wake_if(server, credits, 0);
>                         msleep(1000);
> -                       wait_retry++;
>                 }
> -       } while (rsize < rdata->bytes && wait_retry < 3);
> -
> -       /*
> -        * If we can't find enough credits to send this rdata
> -        * release the rdata and return failure, this will pass
> -        * whatever I/O amount we have finished to VFS.
> -        */
> -       if (rsize < rdata->bytes) {
> -               rc = -EBUSY;
> -               goto out;
> -       }
> +       } while (rsize < rdata->bytes);
>
>         rc = -EAGAIN;
>         while (rc == -EAGAIN) {
> --
> 2.7.4
>


-- 
Thanks,

Steve
