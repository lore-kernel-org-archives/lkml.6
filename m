Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135DEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDF620869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbtCH6Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDF620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbeKFD41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:56:27 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44881 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbeKFD41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:56:27 -0500
Received: by mail-yb1-f194.google.com with SMTP id p144-v6so4212660yba.11;
        Mon, 05 Nov 2018 10:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rw7yZs/KZ/2L+MwKTyvYUljc1s+TO7g8Kd7LxC69Y8s=;
        b=SbtCH6Z9yRPE4TQJ22VsEMhGVhEjdS0ew6byvQoQgBEAm1+Q0MA6VyET8YNUglSoxU
         xugYFFJqQXmkAoknHo2Pk80Iqb9cpfa8v7rg3y5O7BGjDownj0UgV3ch1wRjoACBM4Wk
         8e1dFohSwJByb7uHaApAayfOAZKi39O5XPXtFFYcIO13xQlIrEx1ic9AUTCwGPxPxxqc
         AKtsQQ4+WAyxCSrpBGxI/1gjgHXN1W8rZ+ZVZdz1B4zRJ6OhAM80cayK9qnj69g1sAmc
         Zbs2MJpYd7i+Zu0ANEm0hsEgVGm0WSnim/bCPLmm5kqQCQ9GCMKjGFtZeZPtdYP7V4AP
         LuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rw7yZs/KZ/2L+MwKTyvYUljc1s+TO7g8Kd7LxC69Y8s=;
        b=VilMEkEp7PlvlvPGjBA/sSjXYCKkMKMA5r4aFzBDoKJZsNydIJM+F1F0pfe8qRYvRO
         sEUz99ipcpfq9rQiCX2Yz0RFxIGC0O5cDn2eHUm3b838F7xqqiWRQHs1MXqmvOMbchQP
         Y3ejUjRj92TTr1i7yFwnpiITUgJAHtFQRhFwyXECk036RxyqkpdvPoOnIZoXOcgTmmkL
         ZCBRVMxkQ0hPjnPFguHjnbNpX77rZcg53mOgFWceQvPCEO0Iv00H1kiux12krCADlJCa
         GzqNbK6DJ54raMaQVihCMFZD2UD2pDH71qm61IicGlxqy4u9TSpfUkrypPgnF5dU/78u
         Ckhw==
X-Gm-Message-State: AGRZ1gKTUCKpr1alEcbAW51KEd5yfMuOqFyzgo8S+d1FWEvtTh5ZEG0Y
        W9BZub20DwPS2muAiwMhzQ5ISF1p9lnvgk0HbGU=
X-Google-Smtp-Source: AJdET5dZ8yN7ZHl+TeMFjFhS/ArWgaoueo6P8S+7YEcOzmWv9WxYxoo7KBhXxSaZ+7D03gjPE5w7jR7BqmH7EKbL+k8=
X-Received: by 2002:a25:b002:: with SMTP id q2-v6mr2373648ybf.397.1541442929228;
 Mon, 05 Nov 2018 10:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20181105182146.233025-1-salyzyn@android.com> <20181105182146.233025-2-salyzyn@android.com>
In-Reply-To: <20181105182146.233025-2-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 5 Nov 2018 20:35:17 +0200
Message-ID: <CAOQ4uxi_hY4UnGJhr83gfsrKEkK6pgi1OHv8L7p8GvRvR4tF6A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] overlayfs: check CAP_DAC_READ_SEARCH before
 issuing exportfs_decode_fh
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 8:22 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Assumption never checked, should fail if the mounter creds are not
> sufficient.
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
>
> v5:
> - dependency of "overlayfs: override_creds=off option bypass creator_cred"
>
> v6:
> - rebase

1. rebase onto which branch? doesn't look like the right one
2. pls keep patch revision outside of commit message
    you can put it after --- line
3. revisions are usually ordered latest on the top

> ---
>  fs/overlayfs/namei.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index efd372312ef1..aa012b6bd46e 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -163,6 +163,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
>         if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
>                 return NULL;
>
> +       if (!capable(CAP_DAC_READ_SEARCH)) {
> +               origin = ERR_PTR(-EPERM);
> +               goto out;

I have a deja vu
there is no out label in this function in upstream kernel
you must post patches that are applies and tested on upstream kernel

Thanks,
Amir.

> +       }
> +
>         bytes = (fh->len - offsetof(struct ovl_fh, fid));
>         real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
>                                   bytes >> 2, (int)fh->type,
> --
> 2.19.1.930.g4563a0d9d0-goog
>
