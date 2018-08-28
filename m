Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DEEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0172F2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAhwPWoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0172F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeH1VZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:25:36 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41903 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1VZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:25:36 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so895262ywg.8;
        Tue, 28 Aug 2018 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbMdiRPKcp0rF63yXFtLNTFPritkic5ohSFwzfS2+Ns=;
        b=ZAhwPWoDyjSRk9tSpwjeY6D9E8frfpU5hApihi3JjYbNZmsdKNY440qjalcjyRGM7a
         IMyFpDcKUGisuISZSBcZayUQxukF97fGR9J3rhLjenNeWB6vOZDa/0M6/3cJmUM+ILI9
         4F4qxnsLrAtR2qzUyJlbLuNUnDIcOl2IoiROOCILUUWzf2cFElJsI3aiUobD6PQjrjxs
         4viHVNt/ZslU8ncBZSYJ2J/A839r2nf6LVwVvvkqzEXu2h66BUyEIe3GKHERPLhxGKrr
         Nb9cs0DqIFSUH2C4P2KU5dem38DB8G8FQJlLVdg/qWYeuFXrR+knn9UnQjS+x5gZ+SJA
         LM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbMdiRPKcp0rF63yXFtLNTFPritkic5ohSFwzfS2+Ns=;
        b=AdTt/VLycbC7663Mam3vBm5/u/YbXT1DNUKUwwN2J8wHmjUbYWC4wOcnHhjl5yJn/u
         f0gFw/9O2pbVnY9CbqoFph8Pv5o6At4BC9gPUU9J3mUfVL05ku/SL1PuzW7CIGd5A3rO
         2xyHJLnuBSxHcPPvCz5rQ67dPfjNvw1a2G/BvzrRt9aS9Zes4kztLgOfDiYp1Ac+Jkgt
         YlgCWZr8W2Z+P33DHhGU0l30OKOOmt+DiwLczdVrvsLAvGH4IDS6VQgmsUd8dFpe0Hyv
         3ByI8vEqZGEbbwGP4x7nJm9i/SxYF+WBfJBR6HDLzPQLaYleiBrzs5tXVXOCdUliEK4g
         WZpA==
X-Gm-Message-State: APzg51BrqOzGReept5ZlGYEzQ0demMZOQA8b+NuwndDQXk2N2ht6IgKI
        DR8u0UgwgksFdtH1y05EFPPwzvefacs9q6icO1P0eYjN
X-Google-Smtp-Source: ANB0VdbiWO50dNOCujzz4O93H8dx+BQn4vqrRcgP/DwxDcSNL0jKJkVM39Ubpz8uzY9dS4p0Tj/KXf0PGSQR3nxGzqw=
X-Received: by 2002:a81:2856:: with SMTP id o83-v6mr1370214ywo.211.1535477573693;
 Tue, 28 Aug 2018 10:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180828165259.211474-1-salyzyn@android.com>
In-Reply-To: <20180828165259.211474-1-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Aug 2018 20:34:40 +0300
Message-ID: <CAOQ4uxgwKe7_QC7Rg=BTQ_WvnAm+-kSh0LXWGVOoHHAqJt3aXA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] overlayfs: check CAP_DAC_READ_SEARCH before
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
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 7:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
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
>
> v5:
> - dependency of "overlayfs: override_creds=off option bypass creator_cred"
> ---
>  fs/overlayfs/namei.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index c993dd8db739..84982b6525fb 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -193,6 +193,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
>         if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
>                 return NULL;
>
> +       if (!capable(CAP_DAC_READ_SEARCH)) {
> +               origin = ERR_PTR(-EPERM);
> +               goto out;

Which branch is this works based on?
I don't see any out label in current code.

> +       }
> +
>         bytes = (fh->len - offsetof(struct ovl_fh, fid));
>         real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
>                                   bytes >> 2, (int)fh->type,
> --

Please add same test in ovl_can_decode_fh().

Problem: none of the ovl_export_operations functions override creds.
I guess things are working now because nfsd is privileged enough.
IOW, the capability check you added doesn't check mounter creds
when coming from nfs export ops - I guess that is not what you want
although you probably don'r enable nfs export.

Thanks,
Amir.
