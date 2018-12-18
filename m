Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F234C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287592133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPRpcIaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeLRFGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:06:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40902 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeLRFGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:06:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so7227094pgp.7;
        Mon, 17 Dec 2018 21:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pktrFD8srfTcPs5y3ak7/CEWAGgVk+nF3nTuxokaMBY=;
        b=MPRpcIaLhy5l6ykb4PvTOVDVanPWdRFekcg2M31aamGxvWVhUr6MYsTmzOHeg+b3Hg
         J8GLxElJNmpAqpqtm5xyz04bzUgAJ1zsgCO/pBiOP657+5YTQ/i7DFKXFdV5ZLrSDYJH
         eqlw/g0fjerWgGmEDg5+L1mpRq2mMa+w6PALvSXzMm/yuRm4CqMowqzmr5SaNZRYmKJn
         2D9L1bsO1JPHVSKYMqOA7QpU0Bp/9oT92xBtDSMU2uZa+v7r9FsNvUC/ufXBppt06vLQ
         nM4K7rj+KOjyF07PP6psIRL4BO972fNd6OUPZQvetDcnAQLC4o7dFM4bLqZ+MFvY+Emw
         t9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pktrFD8srfTcPs5y3ak7/CEWAGgVk+nF3nTuxokaMBY=;
        b=Zovuqf49oH8rgz1L0SFSBL+K7DPBN1xh6qu3XIJxp34+0ybgTxxktBYCD0EwbFGvnR
         phL9UXTsL138tglh7UyM+OnJx5VlqFohZ9e0ke15/16zPAb2VDx3L07h2XTV/1MOvfpl
         YXIU/96C6qfvnvQdtN7LB6HhLI7PxBwkS0mCyIRtAL6/SsqHagnPtpVsR4piajW7PjAL
         17Civ/hW2/bDgK8TfcKkywBotV2mScHLZaM+xPriIQT0DpNpAJXSNa2hUPeMjY4qhCQy
         LUvVgMZwU4c7peICwHdTfX0VWIaaJ/kg7mbkBuApumM0sbTUuOSWWENj3ADJxh+bk2o+
         QFkw==
X-Gm-Message-State: AA+aEWZTdcs11oAd6QWAwPPA9raWnKAGFNvAc3SvvhopQn42vNkE8ZyL
        Xlhlg4BjWYeJvj/45vv39hcat9bgIKVBB+oEI3eEhg==
X-Google-Smtp-Source: AFSGD/UDioK76hHXlhq1evtTC2G97mWI0YpOanK8EQbhr3ZskYGWuftDe9y6MZHzalxuwoAWPfBboEHzs5QPTZ1pfJE=
X-Received: by 2002:a63:a112:: with SMTP id b18mr14622934pgf.440.1545109560630;
 Mon, 17 Dec 2018 21:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20181216231704.16761-1-longli@linuxonhyperv.com>
In-Reply-To: <20181216231704.16761-1-longli@linuxonhyperv.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 17 Dec 2018 23:05:48 -0600
Message-ID: <CAH2r5muQnmCG2qJBfoDSm59x0hfJo4MtCxqOkCLWh46iYdFNNg@mail.gmail.com>
Subject: Re: [PATCH] CIFS: use the correct length when pinning memory for
 direct I/O for write
To:     Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Sun, Dec 16, 2018 at 5:18 PM Long Li <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> The current code attempts to pin memory using the largest possible wsize
> based on the currect SMB credits. This doesn't cause kernel oops but this is
> not optimal as we may pin more pages then actually needed.
>
> Fix this by only pinning what are needed for doing this write I/O.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/cifs/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 3467351..c23bf9d 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2617,11 +2617,13 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
>                 if (rc)
>                         break;
>
> +               cur_len = min_t(const size_t, len, wsize);
> +
>                 if (ctx->direct_io) {
>                         ssize_t result;
>
>                         result = iov_iter_get_pages_alloc(
> -                               from, &pagevec, wsize, &start);
> +                               from, &pagevec, cur_len, &start);
>                         if (result < 0) {
>                                 cifs_dbg(VFS,
>                                         "direct_writev couldn't get user pages "
> --
> 2.7.4
>


-- 
Thanks,

Steve
