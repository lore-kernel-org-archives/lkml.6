Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B98C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0312133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaWYxaC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeLRFIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:08:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46229 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeLRFIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:08:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so7225902ply.13;
        Mon, 17 Dec 2018 21:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcR12R1Hu+Opr82T5BSp3OH/2Y3+fWS6ZvGG0SZcBXQ=;
        b=VaWYxaC5CVglOmGsaBSlpdXYJ2H1wdO9t/iIESZ7Jhyuv6/cbntKpRnRqjrhhKV5qi
         /JhtXXj8tthtySpqzYQJIPxbcE42WYZYhL/UmFTKYEehPWFN5LPqQrveyWE4+TWpe5mW
         HGaREhkA5yCT8tUqH1YjJesAOzEUB2O35rRrB4ASCLGT01Gc/eTqekZWkDQU3h5XedS8
         sn9MEXpEdun37GHMn5anT1DbBQetBNZCAbbp88Vr5wPlnUt4kvJ1CmIdjUrX1ZURRZ+P
         ACJXGNnq62u6a/Zm7PKBufQccdcBKI517sWmw3YzbSEbG4dJ/ZYN8zttveXpchWvPU2T
         LSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcR12R1Hu+Opr82T5BSp3OH/2Y3+fWS6ZvGG0SZcBXQ=;
        b=gE6ENTXERSnQ9r0Smj9jb97W83vnzODOhwuu520PfXv6B3icLnNkOWM8IJ9kmEQ3/c
         XGjD0jaoDhs3BZQPYhWU1mQv3SqYIdlS1ExFCa3ewZ9TJCAKqB7Sg6aC8sOfET8/6Csp
         dRn8+iYYC47+Pf3FXzD6AuxFz1Rnf0WHcPaFdn/5qLRWZMDsd6sc86n3o9ZELHbtfwU5
         0Sypln3dqELp4ERxCqZhEfEwIOoEChMsvLWSkTUkFr8amJ1dspQkpQNQI5eQ2L7dwaXk
         giynNRhhul7vwsIfqTJwZiF9NDS5OmhD3nrUgdseHkcUXxVloi2RptPzap2JoZLdkmdU
         KSBA==
X-Gm-Message-State: AA+aEWbDlSpnsxD+opeow/fCmtYdPIUqEE1kuVaaXP+HMl5z2lf0/NMF
        NFXtDmNJhrkpQXkB6P597zseNOVtmvfMEdAH4mE=
X-Google-Smtp-Source: AFSGD/UuU58nv0EwVeWXQNAzaGjwXGG3pY6qgX52aViwn9ggGmtsphK2djeYLD4fajgfkMEgNXROBGcIrZJ5f4ZVRQY=
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr15480557pld.18.1545109679568;
 Mon, 17 Dec 2018 21:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20181216224107.16164-1-longli@linuxonhyperv.com>
In-Reply-To: <20181216224107.16164-1-longli@linuxonhyperv.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 17 Dec 2018 23:07:47 -0600
Message-ID: <CAH2r5muQVqOy1c0Mk0BBHBND_7oqqhyXUwGVp1M0ek7+onLAJw@mail.gmail.com>
Subject: Re: [PATCH] CIFS: return correct errors when pinning memory failed
 for direct I/O
To:     Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Stable <stable@vger.kernel.org>, jencce.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Sun, Dec 16, 2018 at 4:44 PM Long Li <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> When pinning memory failed, we should return the correct error code and
> rewind the SMB credits.
>
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  fs/cifs/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index c9bc56b..3467351 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2630,6 +2630,9 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
>                                         result, from->type,
>                                         from->iov_offset, from->count);
>                                 dump_stack();
> +
> +                               rc = result;
> +                               add_credits_and_wake_if(server, credits, 0);
>                                 break;
>                         }
>                         cur_len = (size_t)result;
> @@ -3313,13 +3316,16 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
>                                         cur_len, &start);
>                         if (result < 0) {
>                                 cifs_dbg(VFS,
> -                                       "couldn't get user pages (cur_len=%zd)"
> +                                       "couldn't get user pages (rc=%zd)"
>                                         " iter type %d"
>                                         " iov_offset %zd count %zd\n",
>                                         result, direct_iov.type,
>                                         direct_iov.iov_offset,
>                                         direct_iov.count);
>                                 dump_stack();
> +
> +                               rc = result;
> +                               add_credits_and_wake_if(server, credits, 0);
>                                 break;
>                         }
>                         cur_len = (size_t)result;
> --
> 2.7.4
>


-- 
Thanks,

Steve
